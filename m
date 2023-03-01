Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28F6A7686
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCAV74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCAV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:59:54 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD134332
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:59:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n2so19557612lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677707990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xveem0XZU8zbcJMVqhduNToGKrA015CFGtNmws1lpSg=;
        b=sscPBx8VipUxfpdU3daFHeHI7ppgtWgE718q0dAf3+T8455XnGIqaoR/wFlEv9cR0C
         5sMdrmFUEymTYJ+cF6x/yEEK73Pi3RewsC5JoQ+G+lybzcOu5rMeBjtLi7GL3JDyYiBT
         FO4HCZVRdY5FHqgpL1m13/OJlu89Yajy1/gfFW5ls0XHRa+xBT8D3ssGo17QjiR1cwKX
         MPIr6iRHByLSFsWGKLCvL/sBxh5vyacM3TfTW+PzksPzaWHT+aUNbGOOazDgFwiVOa3I
         jEv3h0sOAHvcz1yydc/RzeqzysbIGj3R1q5NNlzeFuvqu+AeEjxx9Del2GhO158e3Nce
         LEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xveem0XZU8zbcJMVqhduNToGKrA015CFGtNmws1lpSg=;
        b=Qi2cZeBKF5gVNinu/nu62Wej0JrqPF7kydOmhwwPvR9jdZ6Ta+C73wBNVPIU5By6YT
         hB5Rv8JT0V/bJekFy9/GMSdQqZcQe14Ad+P2rQVMJitAkgTy3pvYq3uxeqFKqYz44aS+
         SUm6Y72YH4TI2lXCtlT+mG5VMITxcvV1NbKuWJXp2iPi7kxkTBmStVYdoclAvvu0OuPG
         ZKT/v4UMmshTU/TzlqbnlkkjAp2v0Ak1HcPq4gPyAFOaWz1R0ZXujlk/KGMNLFLPwsmn
         brvAcu0abGe3eJUf1fNBKtz1JlAH/XskpWLuByE/fxEIsWulKp48w1UPJnFE4gq/fotz
         ELmg==
X-Gm-Message-State: AO0yUKXH6j+uh+1B+kxCsqg1jVNvqwgH0L2VnK0ajhjB3Zp0iXrmambK
        WYdOZcCGWlZpU66AXPUtTuyFQQjWm33L0pkv
X-Google-Smtp-Source: AK7set96xRRKf752/tKy8I/rX0/WG5Sw7M+TQ1tFyCV8QBvHb5x9PE/VW9BfVHW1H4UrciJp5dsr4A==
X-Received: by 2002:ac2:491a:0:b0:4db:2977:508f with SMTP id n26-20020ac2491a000000b004db2977508fmr1811434lfi.68.1677707990543;
        Wed, 01 Mar 2023 13:59:50 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x21-20020ac24895000000b004b57162edfasm1865911lfc.117.2023.03.01.13.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:59:49 -0800 (PST)
Message-ID: <43604015-3c48-e190-d5c0-32204d6201ff@linaro.org>
Date:   Wed, 1 Mar 2023 22:59:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: Delete wormdingler-rev0
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301185007.1101006-1-dianders@chromium.org>
 <20230301104859.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230301104859.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.03.2023 19:50, Douglas Anderson wrote:
> The earliest wormdingler I could find in my pile of hardware is
> -rev1. I believe that -rev0 boards were just distributed as a pile of
> components with no case. At this point I can't imagine anyone needing
> to make wormdingler-rev0 work, so let's delete support for it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Looks like sc7180-trogdor-wormdingler-rev0.dtsi can go as well!

Konrad
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  2 --
>  .../sc7180-trogdor-wormdingler-rev0-boe.dts   | 22 -------------------
>  .../sc7180-trogdor-wormdingler-rev0-inx.dts   | 22 -------------------
>  3 files changed, 46 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 31aa54f0428c..a51060378ddc 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -118,8 +118,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> deleted file mode 100644
> index d6ed7d0afe4a..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Wormdingler board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - *
> - * SKU: 0x10 => 16
> - *  - bits 7..4: Panel ID: 0x1 (BOE)
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor-wormdingler-rev0.dtsi"
> -
> -/ {
> -	model = "Google Wormdingler rev0 BOE panel board";
> -	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";
> -};
> -
> -&panel {
> -	compatible = "boe,tv110c9m-ll3";
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
> deleted file mode 100644
> index c03525ea64ca..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Wormdingler board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - *
> - * SKU: 0x0 => 0
> - *  - bits 7..4: Panel ID: 0x0 (INX)
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor-wormdingler-rev0.dtsi"
> -
> -/ {
> -	model = "Google Wormdingler rev0 INX panel board";
> -	compatible = "google,wormdingler-rev0-sku0", "qcom,sc7180";
> -};
> -
> -&panel {
> -	compatible = "innolux,hj110iz-01a";
> -};
