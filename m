Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2174D6D35BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDBGJ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 2 Apr 2023 02:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDBGJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:09:24 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0310B762;
        Sat,  1 Apr 2023 23:09:23 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id h8so105379110ede.8;
        Sat, 01 Apr 2023 23:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680415761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rTS/ruyRiwSLe4zYoc3zyVGgTu2JSYGkMmye5BXjHs=;
        b=1Bh8wEkgt3sYzSOM6kgMooEIzRr67A4ZPgyhAkf61rTWTDlITVSVk26g5SLLojh2XT
         FwZSr1r9pUUarjOIqQR7s2KvPcjHASgMPB4078jI/3jGEozcxNz2lfh3KDMxc28GBbqa
         WaklIJg718frf7CwKLOIyLWoAKpQ0H4ZkW/K9l6IG0FiIkgqHlyXAWywqSwDhs/65oyt
         IaWss7YIlwpyL/rowzFzSZ62vB12OFttF5gWmVGnIVKXRp8GMywJv3OG2ipBNlqstvDt
         YxtVJonCR6ZImkfi78mdAIj7pCNxMoPKZvKS58+OEFY2ImuU4ldJbYyTWG7vTKCPFGBP
         tR3A==
X-Gm-Message-State: AAQBX9coEs/y+ecFYGe/HN0Bsl7BJkHGWaZm6Gzh7Boo7nFpRdGEoQG4
        OxH0dY9/lNhh29ELApohSx0KKGv5QUgvIA==
X-Google-Smtp-Source: AKy350aUIsqQNq8Vogl7eQmHCwbAYMDF3GsYpLyFzTzRpoJ2emJVeVIOg+1OyouL2FQtmW/9COCdpg==
X-Received: by 2002:a17:907:8c83:b0:931:41af:8ecb with SMTP id td3-20020a1709078c8300b0093141af8ecbmr34040289ejc.49.1680415761386;
        Sat, 01 Apr 2023 23:09:21 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906394100b00933356c681esm2856336eje.150.2023.04.01.23.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 23:09:21 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id i9so26209433wrp.3;
        Sat, 01 Apr 2023 23:09:20 -0700 (PDT)
X-Received: by 2002:adf:efc8:0:b0:2e6:e4df:a7bd with SMTP id
 i8-20020adfefc8000000b002e6e4dfa7bdmr646032wrp.7.1680415760483; Sat, 01 Apr
 2023 23:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230401001850.4988-1-andre.przywara@arm.com> <20230401001850.4988-2-andre.przywara@arm.com>
In-Reply-To: <20230401001850.4988-2-andre.przywara@arm.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 2 Apr 2023 14:09:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v65t1bsfvg8WhfcuwsnAnbq4tXKz1YCKL719VHDd2D=8pg@mail.gmail.com>
Message-ID: <CAGb2v65t1bsfvg8WhfcuwsnAnbq4tXKz1YCKL719VHDd2D=8pg@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 8:19 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Martin Botka <martin.botka@somainline.org>
>
> The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
> H616 or H313 SoC.
> According to the datasheet, the DC/DC converter PWM frequency is fixed
> (to 3 MHz), so disallow the property that lets us set this frequency
> for the other PMICs.
>
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
