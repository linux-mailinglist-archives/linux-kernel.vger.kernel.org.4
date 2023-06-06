Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1699A72435A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbjFFM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbjFFM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:57:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632D170D;
        Tue,  6 Jun 2023 05:57:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256422ad25dso2678810a91.0;
        Tue, 06 Jun 2023 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686056234; x=1688648234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HcvXxC5LljciNKnH4gCYC904VosdsoyndxsGeWKp4Y4=;
        b=X44V629yNrLLSyOJWGic9coTHME+L/Jp0Zeb4rg243MnaeoIAyqLRIqjZNLyLdmHE8
         wlV9OgrnpTqC7nTwml+qrAy/kjwlEZrNkGc8dvWaTSeGzON5iRZadmZRGI3x6wh9AHeo
         EkHTau+6z+wpskWB+9B+KVvh3LvEJ3lvvLSXVhPhN9Yn6LaIvwe57fWChmcXkPDjqsax
         gV3Rpfe+ckIdBvJpvANPc4fPrHpkxa4gwpZM+0sbdOhNsYNy8xUev+vETymNO1hPfS6c
         UHtKamuaLFO7R/oNbY7f+u42ucgsODX0kAhweWM1XxJwlObd7gb5zZ6gpnmsQ4HSKLMY
         RfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056234; x=1688648234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcvXxC5LljciNKnH4gCYC904VosdsoyndxsGeWKp4Y4=;
        b=ldFFD1kfKQgftY/k6aunVhsGfov82SIHIkDoxUiJChxIV1d7HFyl2Hw4W2keRNBXRC
         XhbVgZM5DPuO+jh+KRRT9Si4+sEA12krEUXnKjPpyF/A7A/qPJtZ+7JMhazwAx2VhnD5
         LLnztKDqfKsGJEMGpy/iu1xdme8/W1R8I9Fb8vLtozl3SwjYaYitW3bsJr/QEkr/RaWf
         b8/AoZ7KMkbrmljxCRAkLv2AW4iyFr5Y+MuLSbSoBMYtN9dTmwwAyJDvfW5JxYBGWSDl
         gVhOwikJNy3NQsjPIAvfblyYmBEmhwlbPrV0cXcGXukVPsr+Cmt4DWQRiqiQHC2a+h3A
         uiIQ==
X-Gm-Message-State: AC+VfDxFs5MgF7Vy2rUYH/xl5KJRQSA4C05jx7mNvd7M72XoXveGm1gY
        TFqe8HE/FQFMi0wsh8MTD1qSNBKB5r1mSvKVe8g=
X-Google-Smtp-Source: ACHHUZ5RSqW3E8O0atNuttJgT+pe2cEkBbm+aGC+gFsG53Sm+xEZhZOZn/9dZqOzbkeg6Dvb3X9DHJiHhHiODT66ZqE=
X-Received: by 2002:a17:902:d4c7:b0:1ad:7bc5:b9ea with SMTP id
 o7-20020a170902d4c700b001ad7bc5b9eamr937083plg.60.1686056233838; Tue, 06 Jun
 2023 05:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230605223323.578198-1-aford173@gmail.com> <20230605223323.578198-2-aford173@gmail.com>
 <f821e008-c984-2f60-60c0-46220cada909@kontron.de>
In-Reply-To: <f821e008-c984-2f60-60c0-46220cada909@kontron.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 6 Jun 2023 07:57:02 -0500
Message-ID: <CAHCN7xLR7iGCmnSdJ-bw4sSA9SLc17tC67wfQmri3k22sQJq9g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mn-beacon: Add HDMI video with sound
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e3c00205fd758e09"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e3c00205fd758e09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 6, 2023 at 2:13=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Adam,
>
> On 06.06.23 00:33, Adam Ford wrote:
> > The Beacon Embedded imx8mn development kit has a DSI
> > to HDMI bridge chip.  The bridge supports stereo audio
> > and hot-plug detection.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch=
/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > index 1392ce02587b..2108ec8c019c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
>
> I have to minor comments below, otherwise this looks good to me.
>
> As I'm trying to come up with similar changes for our boards I also have
> some questions below. Maybe you could share your knowledge on these.
>
> Thanks!
> Frieder
>
> > @@ -16,4 +16,138 @@ / {
> >       chosen {
> >               stdout-path =3D &uart2;
> >       };
> > +
> > +     connector {
> > +             compatible =3D "hdmi-connector";
> > +             type =3D "a";
> > +
> > +             port {
> > +                     hdmi_connector_in: endpoint {
> > +                             remote-endpoint =3D <&adv7535_out>;
> > +                     };
> > +             };
> > +     };
> > +
> > +     reg_hdmi: regulator-hdmi-dvdd {
> > +             compatible =3D "regulator-fixed";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_reg_hdmi>;
> > +             regulator-name =3D "hdmi_pwr_en";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             gpio =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             startup-delay-us =3D <70000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     sound-hdmi {
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,name =3D "sound-hdmi";
> > +             simple-audio-card,format =3D "i2s";
> > +
> > +             simple-audio-card,cpu {
> > +                     sound-dai =3D <&sai5 0>;
> > +                     system-clock-direction-out;
> > +             };
> > +
> > +             simple-audio-card,codec {
> > +                     sound-dai =3D <&adv_bridge>;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c2 {
> > +     adv_bridge: hdmi@3d {
> > +             compatible =3D "adi,adv7535";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pinctrl_hdmi_bridge>;
> > +             reg =3D <0x3d>, <0x3b>;
> > +             reg-names =3D "main", "cec";
> > +             adi,dsi-lanes =3D <4>;
>
> On our boards we have this working with 4 lanes. But we also have some
> boards that only have 2 DSI lanes connected. We don't get any image in
> on the display in this case. Did you ever try 2 lanes or do you have an
> idea what could be wrong?

I didn't try 2-lane, but see below regarding clocks to see if any of
that makes any sense.

>
> > +             adi,fixed-lanes;
>
> I think this property comes from downstream and should be removed. I
> don't see it anywhere in the upstream driver or bindings.

You're right.  This came from some early debugging I was doing for a
patch I was going to propose when someone beat me to it.  I'll submit
a V3 with this removed.
>
> > +             dvdd-supply =3D <&reg_hdmi>;
> > +             v3p3-supply =3D <&reg_hdmi>;
> > +             v1p2-supply =3D <&reg_hdmi>;
> > +             a2vdd-supply =3D <&reg_hdmi>;
> > +             avdd-supply =3D <&reg_hdmi>;
> > +             pvdd-supply =3D <&reg_hdmi>;
>
> Please sort the reg properties above alphabetically.

OK.

>
> > +             interrupt-parent =3D <&gpio1>;
> > +             interrupts =3D <9 IRQ_TYPE_LEVEL_LOW>;
> > +             #sound-dai-cells =3D <0>;
> > +
> > +             ports {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     port@0 {
> > +                             reg =3D <0>;
> > +
> > +                             adv7535_in: endpoint {
> > +                                     remote-endpoint =3D <&dsi_out>;
> > +                             };
> > +                     };
> > +
> > +                     port@1 {
> > +                             reg =3D <1>;
> > +
> > +                             adv7535_out: endpoint {
> > +                                     remote-endpoint =3D <&hdmi_connec=
tor_in>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&lcdif {
> > +     assigned-clocks =3D <&clk IMX8MN_VIDEO_PLL1>;
> > +     assigned-clock-rates =3D <594000000>;
>
> Just out of interest: Why do you need to set the video PLL clock here
> and how did you determine the "correct" value? Why is this missing in
> the i.MX8MM dts?

I am glad you asked this question.  In an ideal world we would not
need to set this, because the display clock would propagate up to the
video_pll, but that's currently not happening yet, so one needs to
find a video-pll clock rate that nicely divides into the maximum
number of resoltions as possible.

When you run modetest on a display, you'll get a list of resolutions
with their refresh rate and horizontal and vertical timings as well as
the pixel clock.  The mxsfb needs its clock to match the pixel clock
in order for the displays to sync properly.  With 594000000 set for
the video-pll, the disp-clock divdes down to achieve what it can to
hit the required pixel clock.

Here is an example with some of the extra timing info removed.  The
final column is the 594MHz / pix-clk
name           refresh    pix clk       Divide by 594000000
1920x1080 60          148500        4000
1920x1080 59.94    148352         4003.990509
1920x1080 50         148500         4000
1920x1080 30          74250          8000
1920x1080 29.97     74176          8007.981018
1920x1080 24          74250          8000
1920x1080 23.98     74176          8007.981018
1600x900 60            108000        5500
1280x1024 60.02     108000        5500
1280x800 59.91       71000          8366.197183
1152x864 59.97       81579           7281.285625
1280x720 60            74250          8000
1280x720 59.94       74176          8007.981018
1024x768 60            65000          9138.461538
800x600 60.32         40000          14850
720x576 50              27000          22000
720x480 60              27027          21978.02198
720x480 59.94         27000          22000
640x480 60              25200          23571.42857
640x480 59.94         25175          23594.83615


As you can see, there are a number of resolutions which divide evenly,
but there are a bunch that do not.  If you wanted to achieve
resolutions that do not divide evenly by 594MHz, you'd need to change
the video-pll clock to something else in order for this clock to
evenly divide but then it would break other resolutions..  I have
tested this, and I can get some of these additional resolutions to
work with a different video-pll clock rate.  NXP's downstream kernel
masks this by blocking out clock rates that didn't divide evenly.

The Mini has a different clock parent-child relationship, and the
clock appears to default to 594MHz already, but the Nano has a default
of 650MHz which is why I had to add the clock there.  I didn't want to
put it into the imx8mn.dtsi file, because this may not be appropriate
for some people or people with a fixed display running at specific
resltion and/or pixel rate.

I proposed a solution which would fix both Mini and Nano by allowing
the requested display clock to propagate back up to the video-pll.

On the Mini and Nano, a patch I proposed can help achieve more accurate
lcdif clocks.   For example, when trying to get a pixel clock of 31.500MHz
on an imx8m Nano, the clocks divided the 594MHz down, but
left the parent rate untouched which caused a calculation error.

Before:
video_pll              594000000
  video_pll_bypass     594000000
    video_pll_out      594000000
      disp_pixel       31263158
        disp_pixel_clk 31263158

Variance =3D -236842 Hz

After this patch:
video_pll               31500000
  video_pll_bypass      31500000
    video_pll_out       31500000
      disp_pixel        31500000
        disp_pixel_clk  31500000

Variance =3D 0 Hz

If you want to check out the patch I proposed, look at [1].  I'd love
to get some tracking and/or feedback for this.  This would allow the
Mini and Nano to sync more resolutions and allow people to not have to
specify the video-pll rate.
imx8mp is little more complicated, because there are two different
pixel clocks generated from the same video-pll (the DSI and the
LDB/LVDS)

>
> > +     status =3D "okay";
> > +};
> > +
> > +&mipi_dsi {
> > +     samsung,esc-clock-frequency =3D <20000000>;
>
> Same here, I'm interested in how you determined the "correct" value for
> this property. Are there any rules to follow?

20MHz was the max clock rate supported by the DSI controller.  It also
appears to be the clock speed set in the NXP downstream kernel, so I
used it.  I wish I had a better explanation.

adam

[1] - https://lore.kernel.org/linux-arm-kernel/20230506195325.876871-1-afor=
d173@gmail.com/

>
> > +     status =3D "okay";
> > +
> > +     ports {
> > +             port@1 {
> > +                     reg =3D <1>;
> > +
> > +                     dsi_out: endpoint {
> > +                             remote-endpoint =3D <&adv7535_in>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&sai5 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_sai5>;
> > +     assigned-clocks =3D <&clk IMX8MN_CLK_SAI5>;
> > +     assigned-clock-parents =3D <&clk IMX8MN_AUDIO_PLL1_OUT>;
> > +     assigned-clock-rates =3D <24576000>;
> > +     #sound-dai-cells =3D <0>;
> > +     status =3D "okay";
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl_hdmi_bridge: hdmibridgegrp {
> > +             fsl,pins =3D <
> > +                     MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9               0=
x19
> > +             >;
> > +     };
> > +
> > +     pinctrl_reg_hdmi: reghdmigrp {
> > +             fsl,pins =3D <
> > +                     MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11              0=
x16
> > +             >;
> > +     };
> > +
> > +     pinctrl_sai5: sai5grp {
> > +             fsl,pins =3D <
> > +                     MX8MN_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0    0xd6
> > +                     MX8MN_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK     0xd6
> > +                     MX8MN_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC     0xd6
> > +             >;
> > +     };
> >  };

--000000000000e3c00205fd758e09
Content-Type: image/png; name="image.png"
Content-Disposition: attachment; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <f_lik9q4sq0>
X-Attachment-Id: f_lik9q4sq0

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
--000000000000e3c00205fd758e09--
