Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4660ADD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbiJXOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiJXOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:35:08 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013B564C0;
        Mon, 24 Oct 2022 06:10:14 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13ae8117023so11732257fac.9;
        Mon, 24 Oct 2022 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dXA1ZaTzhF9A48V2DvR6P0p5UW5fQVlupW68wj5G1MI=;
        b=cmjA5XnbIZmjCLLpzw2uLxvN6yyWZdQ3gUF5+aEJ0HnEct0V0KrFIKJQbXLnUwhXXl
         75mGViDWJgiCOFS0BsjoEmGSjzYy9s3zGvkuW+m6WsbRRp+xMrDIPIL7neXDV8SAWchr
         Jm/pgZOhBrMNiIhS6FZMgkZJsN0YHeoI77Q9r4HOU9b7p+cXJwmVxpMf9X/KEqjOqQlN
         sFPMY1Ivo/4JCNY+yDoxneFiG1x0W3Dda3E7IAoT27d4kl+G7Qw1dL+cMqU8fE3RQUKs
         M6lIT8yyLjnP8Z7TynGSt7BNrxbb3Jk4nmEMJ85MsV9aMUxYZx0XBZowcCtEJzFoM3Id
         fwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXA1ZaTzhF9A48V2DvR6P0p5UW5fQVlupW68wj5G1MI=;
        b=RbJTpMWzSPwRCIJhzwy5b975foslN99Y+wiaB5vNPj0UHOxKN6ARHno6e8ChsKUppW
         vmi6ATgitQ+yQjbx5k4Xm6xqZl2bK6vbuOo67Mdw6KjhMDeDexUBcZvDteKLdGuSn9zB
         Rw7QDv0tzeWr59xBx1YE30rWva4WJpQ1GIoeTp5aXnkLFXaO7U8vdDhks6CJ8t0PCAm+
         DwPDIXHwbDnXa3tnX4iUL/b0Z0mjoRa03jeB8lnoVDBEZe3zfn4BuQUhzjQ0Tw7XyVc/
         VYKO0frogvzlBX92U38+QRICp2CvZHpnhz6bWZrx3vwgu41OX5nYhANfPAFjQ+BNWkk4
         jWYw==
X-Gm-Message-State: ACrzQf1ZL3l6Mhm7iM2DvVpPR4W8L+Trcn9YA1Q65Tb8ChcKfOroUus4
        tYU7svZmdeDTgK55ODfTaH3xmMrwdgKPZXdj+Zq6jO5oedo=
X-Google-Smtp-Source: AMsMyM7yyIWgHW6YqouKnOCQoG2M3VPIGNp4xQkEK4cKTeKr8AjH/0n4zv0ybPgxUFr35JkKl300YT893PORX+UssX0=
X-Received: by 2002:a17:90b:3ec1:b0:213:2f34:29ef with SMTP id
 rm1-20020a17090b3ec100b002132f3429efmr951603pjb.123.1666615978184; Mon, 24
 Oct 2022 05:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221024115429.1343257-1-heiko.thiery@gmail.com> <20221024122659.2krt2hh2sdvxuurn@pengutronix.de>
In-Reply-To: <20221024122659.2krt2hh2sdvxuurn@pengutronix.de>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Mon, 24 Oct 2022 14:52:46 +0200
Message-ID: <CAEyMn7Y9uxeFLM7-6jR=bonusdwjX=ukRotZm=7x_3QyxVW-DQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Am Mo., 24. Okt. 2022 um 14:34 Uhr schrieb Marco Felsch
<m.felsch@pengutronix.de>:
>
> Hi Heiko,
>
> On 22-10-24, Heiko Thiery wrote:
> > With that delay U-Boot is not able to store the environment variables in
> > the SD card. Since the delay is not required it can be remove.
>
> Now I'm curious, since this doesn't tell us the why, it just tell us
> about the end result. I'm asking because the NXP EVKs have an issue with
> the sd-card power line capacity and we need this delay to reach a level
> which is marked as low within the sd-spec.

I must admit that I do not know at all why this entry was made. I have
now looked at the dtbs of the imx8 EVKs and except for imx8dxl-evk.dts
I see no delay here.

-- 
Heiko

> Regards,
>   Marco
>
>
> > Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)
> >
> > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > ---
> > v3:
> >  - Improve commit message and explain why it is a fix (thanks to Fabio)
> >
> > v2:
> >  - add Fixes tag
> >
> >  arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > index a91c136797f6..21442e04a632 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
> > @@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
> >               regulator-min-microvolt = <3300000>;
> >               regulator-max-microvolt = <3300000>;
> >               gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > -             off-on-delay-us = <20000>;
> >               enable-active-high;
> >       };
> >  };
> > --
> > 2.30.2
> >
> >
