<GameProjectFile>
  <PropertyGroup Type="Node" Name="HeroNode" ID="be82e29c-f8c9-475f-a7b7-fa6bedcf95dc" Version="2.2.5.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="75" Speed="1.0000">
        <Timeline ActionTag="-358938894" Property="FileData">
          <TextureFrame FrameIndex="0" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveDown1.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="5" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveDown2.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="10" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveDown3.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="15" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveDown4.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="20" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveLeft1.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="25" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveLeft2.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="30" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveLeft3.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="35" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveLeft4.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="40" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveRight1.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="45" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveRight2.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="50" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveRight3.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="55" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveRight4.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="60" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveUp1.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="65" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveUp2.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="70" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveUp3.png" Plist="" />
          </TextureFrame>
          <TextureFrame FrameIndex="75" Tween="False">
            <TextureFile Type="Normal" Path="Image/Charactor/moveUp4.png" Plist="" />
          </TextureFrame>
        </Timeline>
      </Animation>
      <AnimationList>
        <AnimationInfo Name="Down" StartIndex="0" EndIndex="15">
          <RenderColor A="255" R="153" G="50" B="204" />
        </AnimationInfo>
        <AnimationInfo Name="Left" StartIndex="20" EndIndex="35">
          <RenderColor A="255" R="244" G="164" B="96" />
        </AnimationInfo>
        <AnimationInfo Name="Right" StartIndex="40" EndIndex="55">
          <RenderColor A="255" R="153" G="50" B="204" />
        </AnimationInfo>
        <AnimationInfo Name="Up" StartIndex="60" EndIndex="75">
          <RenderColor A="255" R="128" G="0" B="128" />
        </AnimationInfo>
      </AnimationList>
      <ObjectData Name="Node" Tag="13" ctype="GameNodeObjectData">
        <Size />
        <Children>
          <AbstractNodeData Name="HeroSprite" ActionTag="-358938894" Tag="17" IconVisible="False" LeftMargin="-16.0000" RightMargin="-16.0000" TopMargin="-25.0000" BottomMargin="-25.0000" ctype="SpriteObjectData">
            <Size X="32.0000" Y="50.0000" />
            <AnchorPoint ScaleX="0.5000" />
            <Position Y="-25.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize />
            <FileData Type="Normal" Path="Image/Charactor/moveDown1.png" Plist="" />
            <BlendFunc Src="1" Dst="771" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>