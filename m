Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A46691E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBJL3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjBJL3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:29:18 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC78EA5E8;
        Fri, 10 Feb 2023 03:29:17 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-15ff0a1f735so6271685fac.5;
        Fri, 10 Feb 2023 03:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E+QIm42lfZhlZbeaG7qYCyJVOqb0QqRX1daidzMMWs8=;
        b=l9/ICLTEy4X12DfoeGDbgC8YgpojuUn46XLjYS+ctKYDCI30TANzPS96QlUluuH0d0
         7Ek73lD0s+nidRDLR0Bg9dCfMRlNFDa9LyMg62Zzqi1BvkcXtVMZyiPrhim2yUBDhyYC
         hSgFzP7s6BLqDA1PgFfxuim4hmUqRxfQTds6rKvPDhY8Us+ULviSejLuXuqg1V8gPk97
         YTv6a7baJ/FJGff7KoLmMT2XD5XzlZoZem8Yx/VFscgj4DEH3kDPYxicvHc/uVfoG7Mo
         4uTJd7hUTxSHRVdSno+xMgthIWZQBxhRvOiI76X4Cf8vAhkf7IosQQ63LKk61d8qM3Q8
         zThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+QIm42lfZhlZbeaG7qYCyJVOqb0QqRX1daidzMMWs8=;
        b=tcSzkrEE0/Vd70JTdYeJy6d7YNowl7sJS+lgvIaRy3hYkSuXB+flJ5zgL5VNhINOIQ
         YhJsuWfeT3O72VX+XKHVgbqL98puOoV9pFqw/R9wiITdGkTtqKyXoAp8Mh1LorPuue+K
         0qH/EV6+UC7Ui/u8EE/qAtN9ZPphyk7zTHzGtEb9Nm/mVrRH5xXWV2rjtx93yejtiYqy
         O9XntBU+zVfSsR74X2NQ+OnjaBwJhZ62eC7tIwx2sH87gojEzl/nW+oS1pQJQw5AVrwc
         aRf6v12Hf+R4atrAG8t1r5Wufo3PbfI663a4lOXJ7vga3tZsCDG8O2AVJ0UijTsYeT9C
         NQTA==
X-Gm-Message-State: AO0yUKXUcJbMXZDudcmRQa8YaCvgHnFFnmxBurIe+3C+88Pe8BVX4I2O
        UwI4BvXjlmKnr0a8grk6EMjHT4GdhUBvap9koMEPuxsdIfs=
X-Google-Smtp-Source: AK7set/XpDpmJWqdAHMMbWA/nscupKegd3+t6d644Gwv9L/2xhqXlWN/c1w70icJQNFd+a70SoxpS0mMlTW+of/HtPY=
X-Received: by 2002:a05:6870:63a2:b0:16a:a8b5:16fe with SMTP id
 t34-20020a05687063a200b0016aa8b516femr1398407oap.144.1676028557088; Fri, 10
 Feb 2023 03:29:17 -0800 (PST)
MIME-Version: 1.0
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
 <20230210065621.598120-3-sergio.paracuellos@gmail.com> <23d2f23f-b063-c417-e85d-40f09b509d04@linaro.org>
In-Reply-To: <23d2f23f-b063-c417-e85d-40f09b509d04@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 10 Feb 2023 12:29:05 +0100
Message-ID: <CAMhs-H-rozEWNvRV0_CA1UeAZ9YJtg8PsHWjRnwBZp8ojqOcjQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Feb 10, 2023 at 12:00 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 07:56, Sergio Paracuellos wrote:
> > To allow to access system controller registers from watchdog driver code
> > add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
>
> ??? This does not make sense.

What do you mean? The commit message itself? I need the phandle to
'sysc' system controller node for accessing reset status registers
inside the watchdog driver code.

>
> > operations in driver code.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  arch/mips/boot/dts/ralink/mt7621.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > index 5ca40fd21..ebee23a2b 100644
> > --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> > +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> > @@ -71,8 +71,9 @@ sysc: syscon@0 {
> >               };
> >
> >               wdt: wdt@100 {
> > -                     compatible = "mediatek,mt7621-wdt";
> > +                     compatible = "mediatek,mt7621-wdt", "syscon";
>
> Why do you need syscon?

True, will drop, thanks!

>
> Best regards,
> Krzysztof
>

Best regards,
    Sergio Paracuellos
