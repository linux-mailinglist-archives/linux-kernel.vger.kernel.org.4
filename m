Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612AB64CB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238054AbiLNNfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLNNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:35:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5189FE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:35:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so19309548wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 05:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yO/it6DJXp58opzX/ToO7OVqJ9wX6hKFVXMEgWfEm9A=;
        b=TOB9+4TXJwox57SR5ai4OBl9YwUCb20Lc0xZmevqzptn6yBeJ5b5GsBsHcdZYDpl5C
         0kC2ZIP/E09MliK8iX8VeZJHjOfBMWfbdSMxYPXOcc439iesfxAvtSHAY0OYv1sJq3vl
         byrzWhbuStlrf8mMZWzT46PWZGFEEi/7kChYVfMUMksed8qTy4Btpf5eMbmx7d14SJjT
         jbeimh1T2+/uAT6et85Krc1ctpLFN2rvZ5qHdIt4qayhDOQ/wpoXe3UYbwwhrDaD72r+
         9TRW35Oww5E7E5oZhOknv/8Zq/EnyPNcZ6m8faVCxWlDQ/0GpwRVGdiu9EvtC11GeJA/
         iBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO/it6DJXp58opzX/ToO7OVqJ9wX6hKFVXMEgWfEm9A=;
        b=y9cuYH/096pd8WhMec4dhSD3rSYkuho0gnQwu2kl94OhCmJ66mftNwx1Hnrj9uYUv9
         8l1GbuCdGQFXZRtVCVRMsn7lYL8dfbE7ZpFRD+BZc1fEGqz8TTIa7xtfEb/JPdLwdiP+
         wvp3spaTpZpiu4nNUy8SB09pcjAAiLVeCuDPoeV0PY1C1NqZeaqNKR9gZNmB31cCgABH
         MX4QzDSHKcGRJ8aKbZr6URh2smfpbVe66gRD5lv6baZzB1/4Nc37NCMSZk/i20pQ2ANh
         gGDWWiqTyZfw+7CQyyKRJKTBpb4qfo9hKFiX6fhMg+2XxF5Mb/6yY4WzerVNQNvw9DHy
         wxFg==
X-Gm-Message-State: ANoB5pm0C37fd7p410Z5ijav3FglyyGtjFVj5ZeihY1j+vt4+CTsu2Ma
        N7v2n2WD84MOh2lq/KGXfH/k1+JoSW5q7jeZEYhZW1jCIUkPBkry
X-Google-Smtp-Source: AA0mqf79bjY9YiXeOf4EvoO88hS4D2+yUmG5vJpe/dJFyMZNIiX3tgDIgmMi5J9sK4jUQQTW92rWQteU/+QXFPmOvAc=
X-Received: by 2002:a5d:4c4e:0:b0:242:48ff:4004 with SMTP id
 n14-20020a5d4c4e000000b0024248ff4004mr16170546wrt.678.1671024939921; Wed, 14
 Dec 2022 05:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20221130140547.295859-1-mpfj@newflow.co.uk>
In-Reply-To: <20221130140547.295859-1-mpfj@newflow.co.uk>
From:   Mark Jackson <mpfj@newflow.co.uk>
Date:   Wed, 14 Dec 2022 13:35:28 +0000
Message-ID: <CAAbcLfgUmiM=6eTQRRdkgLSEQZEcZwnzq0=Ov58S_osru-_V2Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 0/5] ARM: dts: nanobone: Fix missing/incorrect features
To:     =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022 at 14:06, Mark Jackson <mpfj@newflow.co.uk> wrote:
>
> This patch series updates the NanoBone DTS file to address various missing or
> incorrect features.
>
> v1 -> v2:
>   - Move temperature sensor definition under I2C heirarchy
>
> Mark Jackson (5):
>   ARM: dts: am335x-nano: Fix GPIO settings for RTS/CTS pins on UART3 & 4
>   ARM: dts: am335x-nano: Enable RS485 mode for UART3 & 4
>   ARM: dts: am335x-nano: Enable I2C temperature sensor
>   ARM: dts: am335x-nano: Fix GPIO settings for MMC pins
>   ARM: dts: am335x-nano: Enable USB host
>
>  arch/arm/boot/dts/am335x-nano.dts | 32 +++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>

Any update on this patch ?
Did it ever get through ?
Do I need to re-submit for some reason ?

Regards
Mark J.
