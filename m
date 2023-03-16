Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E24C6BC9AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCPIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCPIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:46:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F7B5B65;
        Thu, 16 Mar 2023 01:46:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so4542509edd.5;
        Thu, 16 Mar 2023 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678956374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6P34+TGOqywF+lggu+lGsmpFltJF4GPVAdpCFRSroU=;
        b=PoY8ZKY5Ot9FwFQM0eQpIQoEo/+4/RAoN7eRKGnzYSLtbum4cpkSKwqWj2Jw1/NmGv
         +q3thyHAabSwfUEJKRaShlT6ZcySEMcH2HPpUdt9EsK2T+2WTdISwROG3iyzzQgb8cn/
         7zr4ZSIroP20IjlRLyHZC2SOe4/a4Qw85INvbCKYU1a2VHG2w8d+0J0nk8ianUzhYOo5
         61dOsQFKQwCVWB1rVbpJrMKWP/vGuiFmDUN0imPnxFFpnGlZW84OE6wZg1QQ5gw8MEMM
         qSr41lcQhqbgt4G/1agqp/8i4fOT73h1tH0rRjWpzaF1tM/5p3zWpcxLZitrfjacuFac
         Fagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6P34+TGOqywF+lggu+lGsmpFltJF4GPVAdpCFRSroU=;
        b=mwcVBNEXehCCgg3FNFY8n076sQxVENEXIHD+BEmQwl3bu2UVjfJh97N5KzBOUbusH0
         8SxM6ifsRTXg4nax5QcI6QWgu78xdit8thgITlz6+Bo1RpDH7lO7JLfbs/OQJMtiZ4BZ
         T7Lmgq3leYr5auVgmXpA1gyEQ6U8iwPOMt8t/2ROnC76dy0Ha+xzj9bgTxQUDX+p65Lc
         kkljJG/GGcMRnHBKGwHM0j/bszg/cbA5okhAtu9pLoHTq2LhwO2yk0x8OCkzQKN/BbIV
         eIXIOmFRTTB1RwTtlxdRInmD9KvB2trPROptsgQCHRhZ8+AjQOjoIVXVM8U+uYeehqHh
         0+xg==
X-Gm-Message-State: AO0yUKUBs5lveTMlTOBoCQeJgulcSC5T46DVTZVd8jB1lM8SNfAoA4u8
        vtr6BqcRC+LMjAmQwsvLyXSjoEAHXrtDmMlvlwQ=
X-Google-Smtp-Source: AK7set+twqeimaEY47S7j8LHdHqS8lxV0WNRWhT6uLCEjZeTtafnFxPK4wcwlhf/MxfD0gJGf9iU5bOpZjIrvdeVCx4=
X-Received: by 2002:a17:906:8455:b0:930:f984:c56f with SMTP id
 e21-20020a170906845500b00930f984c56fmr53532ejy.12.1678956373887; Thu, 16 Mar
 2023 01:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-5-cnsztl@gmail.com>
 <CA+E=qVei7T4T0FWhdUFnr5JbCWSgFbGLcmU2OHxx54yvnNR6mw@mail.gmail.com>
 <CAOP2_TiU815F528jVGvDbcg3kSG+ykepU-ZYz7VWMO84GgcwMg@mail.gmail.com> <71b16513-49b1-d9b3-b0b9-4c47e68563ba@kwiboo.se>
In-Reply-To: <71b16513-49b1-d9b3-b0b9-4c47e68563ba@kwiboo.se>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Thu, 16 Mar 2023 16:46:02 +0800
Message-ID: <CAOP2_TgieY2PNBJz9tE_+hxX14wBQ7RtFNfFhYd2_MCSnoZLxg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: fix gmac support for NanoPi R5S
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Thu, Mar 16, 2023 at 3:37=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Tianling,
> On 2023-03-16 06:34, Tianling Shen wrote:
> > Hi Vasily,
> >
> > On Thu, Mar 16, 2023 at 8:16=E2=80=AFAM Vasily Khoruzhick <anarsoul@gma=
il.com> wrote:
> >>
> >> On Wed, Mar 15, 2023 at 9:02=E2=80=AFAM Tianling Shen <cnsztl@gmail.co=
m> wrote:
> >>>
> >>> - Changed phy-mode to rgmii.
> >>>
> >>> - Fixed pull type in pinctrl for gmac0.
> >>>
> >>> - Removed duplicate properties in mdio node.
> >>>   These properties are defined in the gmac0 node already.
> >>>
> >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 7 ++-----
> >>>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arc=
h/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> >>> index e9adf5e66529..2a1118f15c29 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
> >>> @@ -57,7 +57,7 @@
> >>>         assigned-clock-rates =3D <0>, <125000000>;
> >>>         clock_in_out =3D "output";
> >>>         phy-handle =3D <&rgmii_phy0>;
> >>> -       phy-mode =3D "rgmii-id";
> >>> +       phy-mode =3D "rgmii";
> >>>         pinctrl-names =3D "default";
> >>>         pinctrl-0 =3D <&gmac0_miim
> >>>                      &gmac0_tx_bus2
> >>> @@ -79,9 +79,6 @@
> >>>                 reg =3D <1>;
> >>>                 pinctrl-0 =3D <&eth_phy0_reset_pin>;
> >>>                 pinctrl-names =3D "default";
> >>> -               reset-assert-us =3D <10000>;
> >>> -               reset-deassert-us =3D <50000>;
> >>> -               reset-gpios =3D <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
> >>
> >> Hmm, I don't see RK_PC4 being used anywhere else. gmac0 has RK_PC5 as
> >
> > Yes, it's a typo, it should be RK_RC5.
> >
> >> snsp,reset-gpio. So it essentially drops reset for the PHY. Is it
> >> expected?
> >
> > snsp,reset-gpio defined reset already, so we don't need to set it here =
again.
> >
> > ---
> >
> > snsp,reset-gpio is the legacy binding, but I still have no idea why
> > reset-gpios doesn't work,
> > the dwmac driver will fail to lookup phy:
> >
> > [   10.398514] rk_gmac-dwmac fe2a0000.ethernet eth0: no phy found
> > [   10.399061] rk_gmac-dwmac fe2a0000.ethernet eth0: __stmmac_open:
> > Cannot attach to PHY (error: -19)
> >
> > Any ideas would be appreciated.
>
> Generic ethernet phy driver is not resetting the phy in the same way
> that snsp,reset-gpio does, please see top two commits at [1].
>
> I have been meaning to send that out as an RFC but I got stuck in a
> u-boot rabbit hole, and I also do not know what the correct way to fix
> this would be, so I played with both device tree and code changes.
> Will prioritize this and send out a RFC later today.
>
> [1] https://github.com/Kwiboo/linux-rockchip/commits/rk3568-eth-phy-reset

Thanks for the hint! I will test your patches tonight.

Thanks,
Tianling.

>
> Regards,
> Jonas
>
> >
> > Thanks,
> > Tianling.
> >
> >>
> >>>         };
> >>>  };
> >>>
> >>> @@ -115,7 +112,7 @@
> >>>  &pinctrl {
> >>>         gmac0 {
> >>>                 eth_phy0_reset_pin: eth-phy0-reset-pin {
> >>> -                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcf=
g_pull_down>;
> >>> +                       rockchip,pins =3D <0 RK_PC4 RK_FUNC_GPIO &pcf=
g_pull_up>;
> >>>                 };
> >>>         };
> >>>
> >>> --
> >>> 2.17.1
> >>>
>
