Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C90666300
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjAKSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjAKSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:47:17 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4395F15FD8;
        Wed, 11 Jan 2023 10:47:16 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so9298555otk.8;
        Wed, 11 Jan 2023 10:47:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JzVVh+fKujPsI6nJzYq3FThr+ETXFDdV8+q+BDcVj0Q=;
        b=mQMNZoxJkrTf2YMvP0hCIsoWtjO/xvvygq+XksAngWt8NBkPcqCEe52AQvJa0myMlc
         x1lyhYnvDD4oBoJazl0j6QuCSrmTgpkDSWUbbj9cUjNRdFMIXvApy3D8YKXosoWS7TMm
         l4FHIjtzPf5u2sOFNvfDk1Fuiy9kTofg+TgEdqqp9mhyJYDZL5bSBLsQ27cfCOCVZkIK
         ENUXtP0kvcQWO4m9mvg2k/wjBGmlEFKNk0V7dZtk0QMCdxlbuWuojfGJBOQL5VCBl7ZC
         2NJuwGxOIVBuhIyEDOv9ISiD4dFbvz7MZGkm6jLlTQffHOljigSjZWqNEj5JU/ds6/5p
         SU8Q==
X-Gm-Message-State: AFqh2kqe9Mj4Cc0HzvcH9tsDgLDp1E9nZl3HKaOwjOAwW/1lGHmHIvih
        1ehtuWtGDseQIh23p2T0jA==
X-Google-Smtp-Source: AMrXdXsAVnC+efVv0faJRtQubP8A/BpMNUC9mne6ZPgsGEyKFYjoVA0F4H3g3dMiCIi1qyCEz7zukw==
X-Received: by 2002:a9d:4547:0:b0:673:3fac:b328 with SMTP id p7-20020a9d4547000000b006733facb328mr34495980oti.10.1673462835429;
        Wed, 11 Jan 2023 10:47:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a9d6446000000b0066ec67bbc7asm7841142otl.7.2023.01.11.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 10:47:14 -0800 (PST)
Received: (nullmailer pid 1107807 invoked by uid 1000);
        Wed, 11 Jan 2023 18:47:13 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     a.zummo@towertech.it, krzysztof.kozlowski+dt@linaro.org,
        riku.voipio@iki.fi, robh+dt@kernel.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        lee@kernel.org, linux-leds@vger.kernel.org,
        upstream@lists.phytec.de
In-Reply-To: <20230111163404.3526248-1-w.egorov@phytec.de>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
Message-Id: <167346265519.1103752.16521267476598663004.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Convert PCA9532 to dtschema
Date:   Wed, 11 Jan 2023 12:47:13 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 17:34:03 +0100, Wadim Egorov wrote:
> Convert the PCA9532 LED dimmer to dtschema.
> While at it, also update and the the example to match
> recommended node names and the link to the product datasheet.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2:
>   - Rename yaml file to match compatibles, nxp,pca953x.yaml
>   - Remove Jacek Anaszewski from maintainers list
>   - Remove color labels in example
>   - Restore labels/default-states from original example
>   - Drop reg description
>   - Add unevaluatedProperties to patternProperties scope
>   - Update description of type property & set default to 0
>   - Fix indentation in example
> ---
>  .../devicetree/bindings/leds/leds-pca9532.txt | 49 -----------
>  .../devicetree/bindings/leds/nxp,pca953x.yaml | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-pca9532.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/nxp,pca953x.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230111163404.3526248-1-w.egorov@phytec.de


leddimmer@62: 'led1', 'led2', 'led3', 'led4' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rk3288-phycore-rdk.dtb

leds@62: 'led1', 'led2', 'led3' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb

pca9530@61: 'tft-panel@0' does not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-pdu001.dtb

pca9532@60: '#gpio-cells', 'gpio-controller' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/lpc3250-ea3250.dtb

pca9532@60: 'psc0', 'psc1', 'pwm0', 'pwm1', 'run.green@1', 'run.red@0', 's1.green@5', 's1.yellow@4', 's2.green@3', 's2.red@2' do not match any of the regexes: '^led-[0-9a-z]+$', 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-pdu001.dtb

