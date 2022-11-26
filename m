Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E359663986F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 23:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKZWZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 17:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKZWZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 17:25:37 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64281E0C5;
        Sat, 26 Nov 2022 14:25:36 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id f6so3442367ilu.13;
        Sat, 26 Nov 2022 14:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tc+sgoBt8SQSZNTnE/8ncNdspyRar+39pv2RWYZHvwY=;
        b=i9NeR+oKcaozjz5yQkk7zDPhhU86bNhr2FTT06CoBXwO7dCSlD3Nejvn9nyHoZM2VU
         gYhmYTsABor9NIKSbZGJTnatnDtKbjwWNLAeoVWp+Tx022JTVbSMtyeGIm1vTKDEW45B
         LACc6Cr3XA154Tf17vW6sgZJLWkIRhAVl92JALLObYPbPWlo7nbNC4+0JscKNwlSW8VZ
         sNv+oqFctFiM8JqCTVWMX2WwJjfH/yTjvgDCpxe5qHy98FHJRZ24SgbhJGXo1LRy7lmK
         oNvB2vJD55VnZDw4OmNSaH1ZSyHQZfsO/10K1mSSPrwDFagmOl+CyiUDqBgXE1PDwRmP
         SlQw==
X-Gm-Message-State: ANoB5plv/+VOyoK0aSvMw6BVVBNVU2XaeWEn76kp5rdgFgfS1Z6sa0xn
        WkmhwTp9LHr3jhNNit28JjBzZK/Ulg==
X-Google-Smtp-Source: AA0mqf7DRRzlqrejLrBAkATMaLVC4GqP1xlmozdaX0Z5OUpt6lA2YxQMGPblqe8qEEDrvoAw0AvO7A==
X-Received: by 2002:a92:1a49:0:b0:302:dcf1:59a with SMTP id z9-20020a921a49000000b00302dcf1059amr9322085ill.185.1669501535583;
        Sat, 26 Nov 2022 14:25:35 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f29-20020a02a11d000000b00372e2c4232asm2733142jag.121.2022.11.26.14.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 14:25:35 -0800 (PST)
Received: (nullmailer pid 35351 invoked by uid 1000);
        Sat, 26 Nov 2022 22:25:36 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     luka.perkov@sartura.hr, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        linux-watchdog@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20221125112904.48652-1-robert.marko@sartura.hr>
References: <20221125112904.48652-1-robert.marko@sartura.hr>
Message-Id: <166950120854.13025.2614107746698757914.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: watchdog: Convert GPIO binding to json-schema
Date:   Sat, 26 Nov 2022 16:25:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Nov 2022 12:29:04 +0100, Robert Marko wrote:
> Convert the DT binding for GPIO WDT to JSON schema.
> 
> Cc: luka.perkov@sartura.hr
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../devicetree/bindings/watchdog/gpio-wdt.txt | 28 ----------
>  .../bindings/watchdog/gpio-wdt.yaml           | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221125112904.48652-1-robert.marko@sartura.hr


watchdog-gpio: Unevaluated properties are not allowed ('always-enabled' was unexpected)
	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb

