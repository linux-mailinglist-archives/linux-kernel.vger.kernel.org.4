Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1543B608075
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJUVAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiJUVAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:00:31 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3214FD04;
        Fri, 21 Oct 2022 14:00:27 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13aeccf12fbso5043835fac.11;
        Fri, 21 Oct 2022 14:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SWP5v8HRUCk7/hb7vmyzXf8BLZ4FLSUpZrXYdCAKxQ=;
        b=YaWGAk6840rn9XIwfKIShS7voLLbYld1awIv++Ygm6guo7YSW6Xv9V1zfEZi+pLxmO
         +2PA8+yqQfgKslonTl1A01Ka4oNNXXTfkfiFUIUpUJNzXyNhSbOI+TyBp8bTOBtK61fy
         iRT8quk6GBJyqw1B2r4Y7LXWGn2SUkIFuyn6OtWt3lcwx0qyPSLudQWk8cFUrlJOV+Gf
         NL3bmco7CzP5PLdV9LNlSZDZKqvlyPGnJFT7P4UczeNQnNDLvRQe7iJBMLi2rc8H/e2n
         eomxSdp/A9ClKoOCNXb11OiE92U0Ln1wTGI9QOC2Xqt9G8IyfNDASstfJqEVMXet3mLh
         vcJQ==
X-Gm-Message-State: ACrzQf2Zy5LET94USAsVNeo/1bDIilMk7g41pii/uas3JcWvfXMU+E+a
        TmDRvwkGDR+bIHN++y+xbc/ZMgSVRQ==
X-Google-Smtp-Source: AMsMyM4zfmA64szobAsLRy52z4gDmDBq3BWObAglOPZ8qfI8if3qSwJ9rZhxc4xXc1u5oHIeTjJfgA==
X-Received: by 2002:a05:6870:961d:b0:137:1434:2fd3 with SMTP id d29-20020a056870961d00b0013714342fd3mr13413073oaq.148.1666386026765;
        Fri, 21 Oct 2022 14:00:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870960800b00127fbb7afffsm10316682oaq.5.2022.10.21.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:00:26 -0700 (PDT)
Received: (nullmailer pid 314791 invoked by uid 1000);
        Fri, 21 Oct 2022 21:00:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20221021170605.85163-1-sebastian.reichel@collabora.com>
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
Message-Id: <166638585542.310921.10672175342433537422.robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to json-schema
Date:   Fri, 21 Oct 2022 16:00:25 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 19:06:05 +0200, Sebastian Reichel wrote:
> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> Schema format.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
>  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++++
>  2 files changed, 55 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


hym8563@51: $nodename:0: 'hym8563@51' does not match '^rtc(@.*|-[0-9a-f])*$'
	arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dtb
	arch/arm64/boot/dts/rockchip/rk3368-r88.dtb
	arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb
	arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb
	arch/arm/boot/dts/rk3036-evb.dtb
	arch/arm/boot/dts/rk3288-evb-act8846.dtb
	arch/arm/boot/dts/rk3288-firefly-beta.dtb
	arch/arm/boot/dts/rk3288-firefly.dtb
	arch/arm/boot/dts/rk3288-firefly-reload.dtb
	arch/arm/boot/dts/rk3288-miqi.dtb
	arch/arm/boot/dts/rk3288-rock2-square.dtb

hym8563@51: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
	arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dtb
	arch/arm64/boot/dts/rockchip/rk3368-r88.dtb
	arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dtb
	arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dtb
	arch/arm/boot/dts/rk3036-evb.dtb
	arch/arm/boot/dts/rk3288-firefly-beta.dtb
	arch/arm/boot/dts/rk3288-firefly.dtb
	arch/arm/boot/dts/rk3288-firefly-reload.dtb
	arch/arm/boot/dts/rk3288-miqi.dtb
	arch/arm/boot/dts/rk3288-rock2-square.dtb

rtc@51: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dtb
	arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dtb
	arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dtb
	arch/arm/boot/dts/rk3288-rock-pi-n8.dtb

