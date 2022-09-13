Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E35B75DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiIMP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiIMP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:56:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9090C58;
        Tue, 13 Sep 2022 07:56:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d12so12075048plr.6;
        Tue, 13 Sep 2022 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BigZgzDalXUaUQ1hOGkvbyJvBJcRFxv/fgnReKtRTcE=;
        b=WFpSktm2Mw82yuwQ7/wyCjSuG6TNNYEa5KCF6cBQdRZGJHQ9unp/s9SSPsHoSy4auE
         opY2wZimheSkddlWEzgfaoo9l2oAlb/dP0NLy1091Z4rbn0R2Dl2rwa63TdLmEu7+PXm
         DebvbCRBNXJqpJoXYG2AcIMQarpGfUewuYztSeu0KRlnJFteqDZTfzNAiVWJ+SM8UKPZ
         UczbmrMKn1tM3Vpy0ikq5Fs7ezqANjPwoO5dDW+qsUfplPLIkwHkWE78Oxa2CI8GqGVq
         akpFAJvnzpIOdEq/BocwoMXN3XpApEC4W3U3PBpFrngeI+6IAriPpKUBw8X8e9KTSKgo
         1daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BigZgzDalXUaUQ1hOGkvbyJvBJcRFxv/fgnReKtRTcE=;
        b=KmW8aiAYQGPQTHzqF2eNChWcD6xb/g+O7VgNwjevX9XTKHCdD5KcU6t3xmzZuaHmHR
         9bYJFiXyWsvj365Bk4s1CnHX0S2Ssyt4RI8StZt2SWD9W+IOp/8eFIpjQUyXlqxgAEP9
         ecD++Xro9tlSqoeY3+6gToQWaijObammZyyepiGEXT+JJDHADVg3lRJeP9zA1o0/9uZC
         z9O1o5HZN/7lS61l1sqc/dMsz/K4WuTXORgWXzgcDjqbpbb3B7/tMjO/zUQeTkDC4Ma+
         XZnBOUwA5sQHLChqPDal6IQGX9wx2/TmiATdos0pxYoTHBe9m9GJ60wQJI41sAvJdjA2
         aUHQ==
X-Gm-Message-State: ACgBeo1DnmqFzpCewkhMDk+oOCgo4brqxqHJEXc3HqsrgQ/j25qom4Kk
        UZScvqk9oTX+/nAECm0rsyP8652Q8A46S1VDvEEGXJGxTFo=
X-Google-Smtp-Source: AA6agR7qMJQc4dCUaMDXsSVcOWzc8M1rs65BfNUznpDkE+XLgjqPyC+AronHj/TF2hyMk/7rv/F3M0KOhQogQlM7x9I=
X-Received: by 2002:a17:902:b085:b0:178:3af4:31b2 with SMTP id
 p5-20020a170902b08500b001783af431b2mr7826829plr.122.1663080306463; Tue, 13
 Sep 2022 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220911040628.13774-1-cnsztl@gmail.com> <7426763.EvYhyI6sBW@phil>
In-Reply-To: <7426763.EvYhyI6sBW@phil>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Tue, 13 Sep 2022 22:44:54 +0800
Message-ID: <CAOP2_TiBA0HZPO4tDviUuLMvw+oHe4BR3wiAMwdRodjfuEfVow@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, Sep 13, 2022 at 6:22 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Sonntag, 11. September 2022, 06:06:28 CEST schrieb Tianling Shen:
> > NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
> > stores the MAC address.
> >
> > FriendlyElec ship two versions of the R4S [1]: The standard as well
> > as the enterprise edition with only the enterprise edition including
> > the EEPROM chip that stores the unique MAC address.
>
> This needs to go differently.
>
> If the eeprom is only preset on the enterprise-version, you need
> a separate devicetree for it, that provides the eeprom node.
>
> Declaring the eeprom "in error" on a device that doesn't have it,
> isn't the way to go.
>
> Look for example at rockchip/rk3399-nanopi-m4b.dts for reference
> on how to do it - and also remember to add the new binding
> for that board. And can also again declare the correct mac-address
> cell.
>

Got it, thank you! I will do it these days.

Regards,
Tianling.

>
> Heiko
>
> >
> > 1. https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R4S#Differences_Between_R4S_Standard_Version_.26_R4S_Enterprise_Version
> >
> > Changes in v4:
> > - Removed `mac-address` cell as it breaks the standard edition
> >
> > Changes in v3:
> > - Added address-cells and size-cells
> >
> > Changes in v2:
> > - Added the size of EEPROM
> > - Added `mac-address` cell to pass the MAC address to kernel
> > - Removed `read-only` property in EEPROM node
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > index fe5b52610010..42c99573ab27 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > @@ -68,6 +68,17 @@ &emmc_phy {
> >       status = "disabled";
> >  };
> >
> > +&i2c2 {
> > +     eeprom@51 {
> > +             compatible = "microchip,24c02", "atmel,24c02";
> > +             reg = <0x51>;
> > +             pagesize = <16>;
> > +             size = <256>;
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +     };
> > +};
> > +
> >  &i2c4 {
> >       status = "disabled";
> >  };
> >
>
>
>
>
