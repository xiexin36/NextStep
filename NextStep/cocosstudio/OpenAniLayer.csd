<GameProjectFile>
  <PropertyGroup Type="Layer" Name="OpenAniLayer" ID="a0726c2d-d724-4722-8a20-dc0363c97be3" Version="2.2.5.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="25" Speed="1.0000">
        <Timeline ActionTag="-1012112488" Property="ActionValue">
          <InnerActionFrame FrameIndex="0" Tween="False" InnerActionType="NoLoopAction" CurrentAniamtionName="-- ALL --" SingleFrameIndex="0" />
          <InnerActionFrame FrameIndex="25" Tween="False" InnerActionType="SingleFrame" CurrentAniamtionName="-- ALL --" SingleFrameIndex="20" />
        </Timeline>
      </Animation>
      <ObjectData Name="Layer" Tag="23" ctype="GameLayerObjectData">
        <Size X="960.0000" Y="640.0000" />
        <Children>
          <AbstractNodeData Name="ButtonContinue" ActionTag="2129736597" CallBackType="Touch" CallBackName="ContinueCallback" Tag="25" IconVisible="False" LeftMargin="287.0000" RightMargin="607.0000" TopMargin="472.0000" BottomMargin="132.0000" TouchEnable="True" FontSize="14" ButtonText="Continue" Scale9Enable="True" LeftEage="15" RightEage="15" TopEage="11" BottomEage="11" Scale9OriginX="15" Scale9OriginY="11" Scale9Width="16" Scale9Height="14" OutlineSize="1" ShadowOffsetX="2" ShadowOffsetY="-2" ctype="ButtonObjectData">
            <Size X="66.0000" Y="36.0000" />
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position X="320.0000" Y="150.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.3333" Y="0.2344" />
            <PreSize X="0.0688" Y="0.0562" />
            <TextColor A="255" R="65" G="65" B="70" />
            <DisabledFileData Type="Default" Path="Default/Button_Disable.png" Plist="" />
            <PressedFileData Type="Default" Path="Default/Button_Press.png" Plist="" />
            <NormalFileData Type="Default" Path="Default/Button_Normal.png" Plist="" />
            <OutlineColor A="255" R="255" G="0" B="0" />
            <ShadowColor A="255" R="255" G="127" B="80" />
          </AbstractNodeData>
          <AbstractNodeData Name="OpenAnimation" ActionTag="-1012112488" Tag="19" IconVisible="True" LeftMargin="320.0000" RightMargin="640.0000" TopMargin="320.0000" BottomMargin="320.0000" InnerActionSpeed="1.0000" ctype="ProjectNodeObjectData">
            <Size />
            <AnchorPoint />
            <Position X="320.0000" Y="320.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition X="0.3333" Y="0.5000" />
            <PreSize />
            <FileData Type="Normal" Path="OpenAni.csd" Plist="" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameProjectFile>