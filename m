Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4C72CC0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjFLRIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFLRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:08:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618F113;
        Mon, 12 Jun 2023 10:08:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25bbf87a2a4so1203923a91.3;
        Mon, 12 Jun 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686589686; x=1689181686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GcF4FVxMUj3uTqeynPgO9bv9/ZK50yjnWtFAyFt01Ew=;
        b=SfBujUSQHWQLwIOfC/M0Jcsc1+z8x/+iThJilZi1lWn0aB6okbYHg7UPO7ea37fR5l
         190SWxnYlBHxLJgSgKaE+zUoF4G10E6afviLpS678BwUO7O0DAZKlSFe7CWFDFkchdmL
         tJLssU/mCrtB9go3aQSkkSvJreXWzC1FmRYTleIKE/Y5FO0rbsj2qREfNmjUY9nwvAnb
         FD/BxxyXv2uKCl4qrrYGaL5lXnDDNB/RzNxcxw7HGucwPVVauJ+IHTvGWY+mpNElGOog
         tmAszEzFcD/yLbkgz5exYzi9Ic8xuPmZ/v8nWDOkmH/ULEO5KT6QBji1Ga5j1OJlb+t0
         wqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686589686; x=1689181686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GcF4FVxMUj3uTqeynPgO9bv9/ZK50yjnWtFAyFt01Ew=;
        b=D9q7IJ17h43SYKJqCKMq/oihR+8AC5HcqJ2uPMZFet3/wD8CEI7yxPetZdk3Tw7RR0
         CmkntcK3JVYgOZ73Erzp8qzkRqo3RDlHjlGv0NE/kOyt7CwSkXysFIFzTNX0vN5MCLKp
         hCbmgIaNVVvbzqRxNSmN/lLCB6zSAlzmPUPtWgGY0yaUhHqbNyz7CPiQ5BSFEGibwJ9W
         6zjmDt+WdlNtBrMy8e18vCm8gOuR1qkpat/ttVnHmlhYMql3hDqoO1WvSZpUUgMCIwOA
         su/jUQWfEgr4eA4UASJUOZQA1XJlcLTliJJGJtKzf6ds5of8kDzHELvaL9eUFzAzEuLf
         92Wg==
X-Gm-Message-State: AC+VfDz/pARSrUCyB6KIKQD5q72+Wl+UANkvhnB/D01NujieLjbmdGiT
        Dz0eHBwJeh/RByj+7SmOgJ+grUK546fuyvXpTQ8=
X-Google-Smtp-Source: ACHHUZ7cq9sdUSIwLAA0Oc2QqWJe0YhDBvPsBEHASu+gGBlWyEDCevw+8hPCIgkNFQ1F1modd5FmAecCixiae6UNzMo=
X-Received: by 2002:a17:90a:7345:b0:25b:8c02:13f4 with SMTP id
 j5-20020a17090a734500b0025b8c0213f4mr8617752pjs.38.1686589685770; Mon, 12 Jun
 2023 10:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230605223323.578198-1-aford173@gmail.com> <20230605223323.578198-2-aford173@gmail.com>
 <f821e008-c984-2f60-60c0-46220cada909@kontron.de> <CAHCN7xLR7iGCmnSdJ-bw4sSA9SLc17tC67wfQmri3k22sQJq9g@mail.gmail.com>
 <CAHCN7xKi7mfy+MFLu2GKbo4WYMAsgyZmmDr4GuDkYoZK-08nGQ@mail.gmail.com>
In-Reply-To: <CAHCN7xKi7mfy+MFLu2GKbo4WYMAsgyZmmDr4GuDkYoZK-08nGQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 12 Jun 2023 12:07:54 -0500
Message-ID: <CAHCN7xL4S3YqC=mT8vD1mn_xh0L_Jo8LHQ7e0qFggePYmrUomQ@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000001a4a5b05fdf1c3f9"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001a4a5b05fdf1c3f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 1:11=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Tue, Jun 6, 2023 at 7:57=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
> >
> > On Tue, Jun 6, 2023 at 2:13=E2=80=AFAM Frieder Schrempf
> > <frieder.schrempf@kontron.de> wrote:
> > >
> > > Hi Adam,
> > >
> > > On 06.06.23 00:33, Adam Ford wrote:
> > > > The Beacon Embedded imx8mn development kit has a DSI
> > > > to HDMI bridge chip.  The bridge supports stereo audio
> > > > and hot-plug detection.
> > > >
> > > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/=
arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > > > index 1392ce02587b..2108ec8c019c 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
> > >
> > > I have to minor comments below, otherwise this looks good to me.
> > >
> > > As I'm trying to come up with similar changes for our boards I also h=
ave
> > > some questions below. Maybe you could share your knowledge on these.
> > >
> > > Thanks!
> > > Frieder
> > >
> > > > @@ -16,4 +16,138 @@ / {
> > > >       chosen {
> > > >               stdout-path =3D &uart2;
> > > >       };
> > > > +
> > > > +     connector {
> > > > +             compatible =3D "hdmi-connector";
> > > > +             type =3D "a";
> > > > +
> > > > +             port {
> > > > +                     hdmi_connector_in: endpoint {
> > > > +                             remote-endpoint =3D <&adv7535_out>;
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +
> > > > +     reg_hdmi: regulator-hdmi-dvdd {
> > > > +             compatible =3D "regulator-fixed";
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_reg_hdmi>;
> > > > +             regulator-name =3D "hdmi_pwr_en";
> > > > +             regulator-min-microvolt =3D <3300000>;
> > > > +             regulator-max-microvolt =3D <3300000>;
> > > > +             gpio =3D <&gpio2 11 GPIO_ACTIVE_HIGH>;
> > > > +             enable-active-high;
> > > > +             startup-delay-us =3D <70000>;
> > > > +             regulator-always-on;
> > > > +     };
> > > > +
> > > > +     sound-hdmi {
> > > > +             compatible =3D "simple-audio-card";
> > > > +             simple-audio-card,name =3D "sound-hdmi";
> > > > +             simple-audio-card,format =3D "i2s";
> > > > +
> > > > +             simple-audio-card,cpu {
> > > > +                     sound-dai =3D <&sai5 0>;
> > > > +                     system-clock-direction-out;
> > > > +             };
> > > > +
> > > > +             simple-audio-card,codec {
> > > > +                     sound-dai =3D <&adv_bridge>;
> > > > +             };
> > > > +     };
> > > > +};
> > > > +
> > > > +&i2c2 {
> > > > +     adv_bridge: hdmi@3d {
> > > > +             compatible =3D "adi,adv7535";
> > > > +             pinctrl-names =3D "default";
> > > > +             pinctrl-0 =3D <&pinctrl_hdmi_bridge>;
> > > > +             reg =3D <0x3d>, <0x3b>;
> > > > +             reg-names =3D "main", "cec";
> > > > +             adi,dsi-lanes =3D <4>;
> > >
> > > On our boards we have this working with 4 lanes. But we also have som=
e
> > > boards that only have 2 DSI lanes connected. We don't get any image i=
n
> > > on the display in this case. Did you ever try 2 lanes or do you have =
an
> > > idea what could be wrong?
> >

+ Lucas,

> > I didn't try 2-lane, but see below regarding clocks to see if any of
> > that makes any sense.
>
Frieder,

> I tried configuring my hardware for 2-lane operation, and it appears
> to not function, but I haven't been able to determine why.  Have you
> made any progress on getting your 2-lane interface operational?

I looked at the NXP down-stream code to compare the HBP, HFP, and HSA
values [1] to what we're generating with this mainline code, but the
formula to achieve these values doesn't make sense to me.  The
equations for the 4-lane calculation were pretty straight-forward.

I tried to do a look-up table similar to the method that NXP did, but
it was rejected in favor of a formula to calculate values.  You  might
try to see if using hard-coded values for HFP, HBP and HSA work for
your display which would at least narrow down where the problem might
be.  NXP's downstream code also has a work-around for calculating the
PHY [2] which only appears to affect 720P@60 for some reason.

If someone has an idea of how to calculate the 2-lane timings for HFP,
HBP, and HSA, that would be useful.

720p@60
HFP     HBP     HSA
159      324       54 (calculated with current formula)
159      320       40 (downstream look-up table)

adam

[1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/br=
idge/sec-dsim.c#L369
[2] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/br=
idge/sec-dsim.c#L1018
>
> 2-lane clocks probably require a pixel clock 2x the speed of the
> 4-lane modes.  I'm really tight on time right now, but I can try to
> put some time in to investigating the 2-lane operation.
>
> adam
> >
> > >
> > > > +             adi,fixed-lanes;
> > >
> > > I think this property comes from downstream and should be removed. I
> > > don't see it anywhere in the upstream driver or bindings.
> >
> > You're right.  This came from some early debugging I was doing for a
> > patch I was going to propose when someone beat me to it.  I'll submit
> > a V3 with this removed.
> > >
> > > > +             dvdd-supply =3D <&reg_hdmi>;
> > > > +             v3p3-supply =3D <&reg_hdmi>;
> > > > +             v1p2-supply =3D <&reg_hdmi>;
> > > > +             a2vdd-supply =3D <&reg_hdmi>;
> > > > +             avdd-supply =3D <&reg_hdmi>;
> > > > +             pvdd-supply =3D <&reg_hdmi>;
> > >
> > > Please sort the reg properties above alphabetically.
> >
> > OK.
> >
> > >
> > > > +             interrupt-parent =3D <&gpio1>;
> > > > +             interrupts =3D <9 IRQ_TYPE_LEVEL_LOW>;
> > > > +             #sound-dai-cells =3D <0>;
> > > > +
> > > > +             ports {
> > > > +                     #address-cells =3D <1>;
> > > > +                     #size-cells =3D <0>;
> > > > +
> > > > +                     port@0 {
> > > > +                             reg =3D <0>;
> > > > +
> > > > +                             adv7535_in: endpoint {
> > > > +                                     remote-endpoint =3D <&dsi_out=
>;
> > > > +                             };
> > > > +                     };
> > > > +
> > > > +                     port@1 {
> > > > +                             reg =3D <1>;
> > > > +
> > > > +                             adv7535_out: endpoint {
> > > > +                                     remote-endpoint =3D <&hdmi_co=
nnector_in>;
> > > > +                             };
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +};
> > > > +
> > > > +&lcdif {
> > > > +     assigned-clocks =3D <&clk IMX8MN_VIDEO_PLL1>;
> > > > +     assigned-clock-rates =3D <594000000>;
> > >
> > > Just out of interest: Why do you need to set the video PLL clock here
> > > and how did you determine the "correct" value? Why is this missing in
> > > the i.MX8MM dts?
> >
> > I am glad you asked this question.  In an ideal world we would not
> > need to set this, because the display clock would propagate up to the
> > video_pll, but that's currently not happening yet, so one needs to
> > find a video-pll clock rate that nicely divides into the maximum
> > number of resoltions as possible.
> >
> > When you run modetest on a display, you'll get a list of resolutions
> > with their refresh rate and horizontal and vertical timings as well as
> > the pixel clock.  The mxsfb needs its clock to match the pixel clock
> > in order for the displays to sync properly.  With 594000000 set for
> > the video-pll, the disp-clock divdes down to achieve what it can to
> > hit the required pixel clock.
> >
> > Here is an example with some of the extra timing info removed.  The
> > final column is the 594MHz / pix-clk
> > name           refresh    pix clk       Divide by 594000000
> > 1920x1080 60          148500        4000
> > 1920x1080 59.94    148352         4003.990509
> > 1920x1080 50         148500         4000
> > 1920x1080 30          74250          8000
> > 1920x1080 29.97     74176          8007.981018
> > 1920x1080 24          74250          8000
> > 1920x1080 23.98     74176          8007.981018
> > 1600x900 60            108000        5500
> > 1280x1024 60.02     108000        5500
> > 1280x800 59.91       71000          8366.197183
> > 1152x864 59.97       81579           7281.285625
> > 1280x720 60            74250          8000
> > 1280x720 59.94       74176          8007.981018
> > 1024x768 60            65000          9138.461538
> > 800x600 60.32         40000          14850
> > 720x576 50              27000          22000
> > 720x480 60              27027          21978.02198
> > 720x480 59.94         27000          22000
> > 640x480 60              25200          23571.42857
> > 640x480 59.94         25175          23594.83615
> >
> >
> > As you can see, there are a number of resolutions which divide evenly,
> > but there are a bunch that do not.  If you wanted to achieve
> > resolutions that do not divide evenly by 594MHz, you'd need to change
> > the video-pll clock to something else in order for this clock to
> > evenly divide but then it would break other resolutions..  I have
> > tested this, and I can get some of these additional resolutions to
> > work with a different video-pll clock rate.  NXP's downstream kernel
> > masks this by blocking out clock rates that didn't divide evenly.
> >
> > The Mini has a different clock parent-child relationship, and the
> > clock appears to default to 594MHz already, but the Nano has a default
> > of 650MHz which is why I had to add the clock there.  I didn't want to
> > put it into the imx8mn.dtsi file, because this may not be appropriate
> > for some people or people with a fixed display running at specific
> > resltion and/or pixel rate.
> >
> > I proposed a solution which would fix both Mini and Nano by allowing
> > the requested display clock to propagate back up to the video-pll.
> >
> > On the Mini and Nano, a patch I proposed can help achieve more accurate
> > lcdif clocks.   For example, when trying to get a pixel clock of 31.500=
MHz
> > on an imx8m Nano, the clocks divided the 594MHz down, but
> > left the parent rate untouched which caused a calculation error.
> >
> > Before:
> > video_pll              594000000
> >   video_pll_bypass     594000000
> >     video_pll_out      594000000
> >       disp_pixel       31263158
> >         disp_pixel_clk 31263158
> >
> > Variance =3D -236842 Hz
> >
> > After this patch:
> > video_pll               31500000
> >   video_pll_bypass      31500000
> >     video_pll_out       31500000
> >       disp_pixel        31500000
> >         disp_pixel_clk  31500000
> >
> > Variance =3D 0 Hz
> >
> > If you want to check out the patch I proposed, look at [1].  I'd love
> > to get some tracking and/or feedback for this.  This would allow the
> > Mini and Nano to sync more resolutions and allow people to not have to
> > specify the video-pll rate.
> > imx8mp is little more complicated, because there are two different
> > pixel clocks generated from the same video-pll (the DSI and the
> > LDB/LVDS)
> >
> > >
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&mipi_dsi {
> > > > +     samsung,esc-clock-frequency =3D <20000000>;
> > >
> > > Same here, I'm interested in how you determined the "correct" value f=
or
> > > this property. Are there any rules to follow?
> >
> > 20MHz was the max clock rate supported by the DSI controller.  It also
> > appears to be the clock speed set in the NXP downstream kernel, so I
> > used it.  I wish I had a better explanation.
> >
> > adam
> >
> > [1] - https://lore.kernel.org/linux-arm-kernel/20230506195325.876871-1-=
aford173@gmail.com/
> >
> > >
> > > > +     status =3D "okay";
> > > > +
> > > > +     ports {
> > > > +             port@1 {
> > > > +                     reg =3D <1>;
> > > > +
> > > > +                     dsi_out: endpoint {
> > > > +                             remote-endpoint =3D <&adv7535_in>;
> > > > +                     };
> > > > +             };
> > > > +     };
> > > > +};
> > > > +
> > > > +&sai5 {
> > > > +     pinctrl-names =3D "default";
> > > > +     pinctrl-0 =3D <&pinctrl_sai5>;
> > > > +     assigned-clocks =3D <&clk IMX8MN_CLK_SAI5>;
> > > > +     assigned-clock-parents =3D <&clk IMX8MN_AUDIO_PLL1_OUT>;
> > > > +     assigned-clock-rates =3D <24576000>;
> > > > +     #sound-dai-cells =3D <0>;
> > > > +     status =3D "okay";
> > > > +};
> > > > +
> > > > +&iomuxc {
> > > > +     pinctrl_hdmi_bridge: hdmibridgegrp {
> > > > +             fsl,pins =3D <
> > > > +                     MX8MN_IOMUXC_GPIO1_IO09_GPIO1_IO9            =
   0x19
> > > > +             >;
> > > > +     };
> > > > +
> > > > +     pinctrl_reg_hdmi: reghdmigrp {
> > > > +             fsl,pins =3D <
> > > > +                     MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11           =
   0x16
> > > > +             >;
> > > > +     };
> > > > +
> > > > +     pinctrl_sai5: sai5grp {
> > > > +             fsl,pins =3D <
> > > > +                     MX8MN_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0    0xd6
> > > > +                     MX8MN_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK     0xd6
> > > > +                     MX8MN_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC     0xd6
> > > > +             >;
> > > > +     };
> > > >  };

--0000000000001a4a5b05fdf1c3f9
Content-Type: image/png; name="image.png"
Content-Disposition: attachment; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <f_lit3u7lb0>
X-Attachment-Id: f_lit3u7lb0

iVBORw0KGgoAAAANSUhEUgAAAgEAAAAVCAYAAADfPj3FAAADrUlEQVR4nO3dsXGjQBgF4MeNSwEH
titYKhBOFKkECKXEmcPLnEAosksdKTFUICrADgy97AULWHAgI/lGaNn3zShhhYcH4tcPi8ZWnucS
REREZJwbALi/v596Oybz/v7O/Mw/9WZMhvmZn/nNzv9r6o0gIiKiabAJICIiMhSbACIiIkOxCSAi
IjIUmwAiIiJDadUElJELy7JguRHKZmmKwLLU8uYVIG2Gg9ZYkPb+6et3LEdnzI3KzsolIrced/HP
sNa+Of4A5p2fTMH6d0b9KyO4R2vjXAzUuBH5NWkCVEBnkw2/xU8gpaxeWywAtQO8GCIsIGWBUACx
p+GXQBnB3S1VtiKEABB71YmeBrDqsSpjtnE6J8kLNpmAENNs/kX0Hf+aCflpxlj/zqp/ZQTX2SCr
9k3i99TGueircSPz69EElG94zQTCRH0Axq/2igzAw60NwMbjSgDI8Pqm2Vlgr7HfVl9r9i0eDscW
W8h6rMkI5J91xhSBF0OEz1hdaHOvi+n5SXusf2fVvzq/v1Tji6UPAIh3c+sC+mvc2Px6NAH2Gnu5
x9o5bbXio90527cPA+/USLpDDAD+sn21W6kzqxMfKKPfiOHj+dSdNxOm56cZYP37ckL96+aHc3dS
E6WLoRo3Nr8eTcAYsfc1L1Td73Du2lfF5Wc+2eb9VDMf6MUAfCTbnlMgDeDFAESIpwUApHjZZBDh
U+8JMys9x9+o/GQ21r+e+meCn9e4GTQBC2ybuTA1J4TYQ5AC9vpPM0dkWd/MqV05e72vMibwEcPr
PhxTzf8BPpL9GjaANPCqDtGeaKsvYfj4m5GfzMb6B6C3/pngf9S4GTQBh2zUd7xU92tjvZfNAzNF
qDrj+la5nhaopnba8/7OBhl8JM1DcSVU469OGMtyoGpAho2j4cNBoxwe/9TA/GQ21r/k4KHg+k5I
o/hABkDczWVq8HiN33Vv/g/k178JSIODnz2k2MUAILB67H7Q1W0TLW8VtTLWB77OmCKwVDeYtJ6K
bxeA5ioBAmGxx2wujgeP/8KM/GQ21r+B+gfYjyv1S4LqQbh0F6N/3+jqeI3fPo3Mn+e5vHpFKAUg
0X35STUsDpYLGRYD64lQFp0/rUV+OZyxvfxY1kKGorN/pD75jxk8/u13zTb/TzC/BvlZ/86vf4nf
Wl7tsoYu+cfpqXEj8lt5nkvT/5Ui8zO/qZif+Znf7Pz6TwcQERHRWdgEEBERGYpNABERkaGsPM/l
1BtBREREl/cXOQDModS0shIAAAAASUVORK5CYII=
--0000000000001a4a5b05fdf1c3f9--
