Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC262D163
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 04:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiKQDCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 22:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiKQDCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 22:02:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768940933;
        Wed, 16 Nov 2022 19:01:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso685300wmp.5;
        Wed, 16 Nov 2022 19:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZNyOtjou7UGJa2BliLM3P7z/CgeMGDCK77AaNy+wyQ=;
        b=C2jhk9alJDbZ5zE2SEo1NUOVF583b2PxjyxmXI5EDaCEimWEeZn2/rHcTvHgV2DaGt
         WDY4CH0W4wb0jqG3tSeTV2vcZjeTa9t/iKjPs/MGiKk6C+ZYPelvaw1l5GJE16xIcmIz
         KCxTB43Hz/DU5YZXIkjtjitro4guGbjADT4YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZNyOtjou7UGJa2BliLM3P7z/CgeMGDCK77AaNy+wyQ=;
        b=hsBvyvxpJdmzBMnQNqosj+O+XAHJ0vxQxo+K0CGSeiiSnMqrAg0mMdLgShI8qgl/dL
         KTovj7KXWKukkATOKyUfZMas1qu+LBRehgmClo3n8KFqJSnUYy2uP3S0DU65txVCsGYu
         Aa/gOOrvRHS8dKcr/+/hEzwugefMEcILAU1/V6D2IiJ/IE/Nr3MteC8r/2Yn0CMfbKoS
         d+QwXJr/lUNJvgLsUKXbYuKqXAOYh1y8MotEtmtstmeILFAw7DStWSEHKvg7DMKiQCuV
         UqIODULaFyOr2I1dlX8lXomJLrE2EpbgnVakXrqiFOvlbbz7zAJWxoLXEeK9rDxv/BiI
         u/8g==
X-Gm-Message-State: ANoB5plKZIVV2kp17Q84yx96HkUF83Epr4AUq+U6OgbaYx3vyTsicLVa
        rTp6gDDfuBclhg+bK8VFueyMoY+CkOMqGJkZ7MY=
X-Google-Smtp-Source: AA0mqf5i0jUWFC4j+cDibzi3Vs644huDdFdGP0IPBdvtnKtWfTcCOdK582I2KflVIQxdgy1oF4QmbhOO9vJplBbSQxc=
X-Received: by 2002:a7b:cb83:0:b0:3cf:96da:3846 with SMTP id
 m3-20020a7bcb83000000b003cf96da3846mr3757718wmi.10.1668654117812; Wed, 16 Nov
 2022 19:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20221024081115.3320584-1-quan@os.amperecomputing.com> <781ea7c7-b33e-f054-71eb-d760f7a01301@os.amperecomputing.com>
In-Reply-To: <781ea7c7-b33e-f054-71eb-d760f7a01301@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Nov 2022 03:01:45 +0000
Message-ID: <CACPK8XcCKK_o0hBA82k0CEcpbHXbHcUii3bgoGvHaGvtw2Q_Ww@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: mtjade,mtmitchell: Add BMC SSIF nodes
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Open Source Submission <patches@amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 07:06, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
>
> Just a gentle ping about this patch.
>
> Thanks and best regards,
> - Quan
>
> On 24/10/2022 15:11, Quan Nguyen wrote:
> > Add BMC SSIF node to support IPMI in-band communication.
> >
> > Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Applied, thanks.


> > ---
> >   arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     | 4 ++++
> >   arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 4 ++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> > index d127cbcc7998..353359822d7b 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> > @@ -342,6 +342,10 @@ &mac1 {
> >
> >   &i2c0 {
> >       status = "okay";
> > +     ssif-bmc@10 {
> > +             compatible = "ssif-bmc";
> > +             reg = <0x10>;
> > +     };
> >   };
> >
> >   &i2c1 {
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> > index 606cd4be245a..4b91600eaf62 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> > @@ -445,6 +445,10 @@ &i2c9 {
> >
> >   &i2c11 {
> >       status = "okay";
> > +     ssif-bmc@10 {
> > +             compatible = "ssif-bmc";
> > +             reg = <0x10>;
> > +     };
> >   };
> >
> >   &i2c14 {
