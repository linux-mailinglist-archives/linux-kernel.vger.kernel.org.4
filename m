Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F97476CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGDQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGDQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:33:24 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB26F2;
        Tue,  4 Jul 2023 09:33:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5576ad1b7e7so506548a12.1;
        Tue, 04 Jul 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488402; x=1691080402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQvB9pazQpz+2yHd1djg/ZPNR7htVfRGfkEykcgrM+o=;
        b=m5bCQ4yYE38W4kirdl6kjCOOk6SLdEjKK0boE6sZWiaXSOG1pWqXeNuExeh+qtpdcT
         6H/UlVHbGeNy3s4h5qaawbcAhgb8Q26QXFfLssk7GHwgmDFHWrSi+eNQee9S9zl8/SaE
         Zje9cr+Ey4fyyTZwDdVyRs+8F3ShYW/zOfD/0/+1P+jB7MRPMSqF4r5LhUe+v2W0Y1LQ
         xR9EcjURDlJ4AWkMaVM/+JkN8c30HQ2nnCr9ea4sE3Uc4r9q93Yur/cQO0EIlkD02z9n
         OCAuq8wZJvm/sskf6qunELA8KcIMSjd57eXxXsqTnxhUI+oZ2sX94QKT5x4Ko5u3h15r
         tSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488402; x=1691080402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQvB9pazQpz+2yHd1djg/ZPNR7htVfRGfkEykcgrM+o=;
        b=YrNU6b1r0bzeSsKwL7+3J/9J7lvSXrXasFHpISKsNpQBd0PHZozrP0raMZ2MX6F+D9
         dDfD3nsYooabQo1U/uICdPyhl8fwjhRgvGDQRsABvyaTvsDuR5bcVVwmd4SyrQ+BuguA
         k5MmIP5n+j4svUhj9dhvkB/KjvLkKjhO4qa6EUKnpjgXbrNVI0saFzol33xAgliQ3g6D
         xtYbtS9liIemOgymq6oAzH4oDev0Bbkz3zL5826JRp7/rwDWWLvozwa9wCIZqdC6AQ2P
         MzLvV6grBBrRpMPUg3XyYrxsdrwEZiIQqkHUPx0L9TESy+AtC+tZp+dlwaC4379DFSp/
         3q5g==
X-Gm-Message-State: AC+VfDxbKVQ8xGnroVZ9fQV9Sj0C9wAqCU2ROzlI/kxK7roUOcoNUfRc
        ZhZsxWuImcfuW7+8hVkGxys1zx6+30UFsMM2nyg=
X-Google-Smtp-Source: ACHHUZ56wqlzlBO53OuIFzdwzdzS2tSMbSG9qqqSnbk5ymiIHeod7V2AHmHwAOLFZ4mgluSW8PUxA4fKt7PYIhWniJw=
X-Received: by 2002:a05:6a20:3d1a:b0:100:b92b:e8be with SMTP id
 y26-20020a056a203d1a00b00100b92be8bemr20744718pzi.2.1688488402042; Tue, 04
 Jul 2023 09:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230704150240.2022020-1-hugo@hugovil.com> <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com> <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
In-Reply-To: <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Jul 2023 13:33:10 -0300
Message-ID: <CAOMZO5CX8WzaNeHmE8ohT2_6F-ehRRNWGnF7Dji=uLGphY4q2A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Nate Drude <nate.d@variscite.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some Variscite folks in case they can help to clarify.

On Tue, Jul 4, 2023 at 1:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/07/2023 17:31, Hugo Villeneuve wrote:
> > On Tue, 4 Jul 2023 17:08:12 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >
> >> On 04/07/2023 17:02, Hugo Villeneuve wrote:
> >>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>>
> >>> USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> >>> nano SOM.
> >>>
> >>> Import changes from linux-5.15 branch of  doen't giveto fix it.
> >>>
> >>> Link: https://github.com/varigit/linux-imx.git
> >>> Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Varisc=
ite Symphony board with VAR-SOM-MX8MN")
> >>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >>> ---
> >>>  .../dts/freescale/imx8mn-var-som-symphony.dts | 37 +++++++++++++++++=
+-
> >>>  1 file changed, 35 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dt=
s b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> >>> index 406a711486da..aef89198f24c 100644
> >>> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> >>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> >>> @@ -6,6 +6,7 @@
> >>>
> >>>  /dts-v1/;
> >>>
> >>> +#include <dt-bindings/usb/pd.h>
> >>>  #include "imx8mn-var-som.dtsi"
> >>>
> >>>  / {
> >>> @@ -104,10 +105,29 @@ extcon_usbotg1: typec@3d {
> >>>             compatible =3D "nxp,ptn5150";
> >>>             reg =3D <0x3d>;
> >>>             interrupt-parent =3D <&gpio1>;
> >>> -           interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
> >>> +           interrupts =3D <11 IRQ_TYPE_NONE>;
> >>
> >> That's surprising, why?
> >
> > Hi,
> > the varigit repos log or source code has no information about this
> > particular configuration.
> >
> > In the schematics, the interrupt output pin of the PTN5150 is connected
> > to two different resistors, one of these being connected to GPIO1 pin
> > 11. But these two resistors are not assembled on any versions of the
> > board, so the interrupt pin is currently not used.
>
> OK, so there is no interrupt, but not interrupt of type none. Just drop
> the property and make it optional in the bindings. The driver however
> requires the interrupt, so I wonder how the device is going to work
> without it?
>
> Are you sure that interrupt line is not shorted instead of missing resist=
or?
>
> Best regards,
> Krzysztof
>
