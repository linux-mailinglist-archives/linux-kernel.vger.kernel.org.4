Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C368658BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiL2KhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiL2KhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:37:03 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B01006D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:37:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z26so26985161lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7SwWwnfZr+uBEvsIuFz/yYh7XO2beOzaYWIBtOLhwsc=;
        b=wklaEMwa/1iRPi/ZBWVSzDnc15wt+GyNfabUflkM9an6lp25NFZDFPjOih/22pIwKT
         RTZFeyJ4tCIkbJdC7deYC4l1OpDZZtai1Yl/bEibpO6fCQmS67IddAdOl/0ho+cefTBJ
         gbW5Iao4tt0SWG5o+wcYSfbVsLFDtzlHNUda0OCQYvtG8P08ekaSpnJ39en6gZFxH1Dr
         qB6QfqXyIH0Ryhp97Qw0juNvpHGG3ia4AuHoVSLnAUiTNFrlL6aFjOExzh2SFDCypqZX
         ld/Vzr7fvZTNei4uOUru3K7AzXXXXsOrzkNMWOlG55QQKRV3PmTNUf+iSt8XOH/3fb12
         MQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7SwWwnfZr+uBEvsIuFz/yYh7XO2beOzaYWIBtOLhwsc=;
        b=tTabdlkBRSfLT6jNyMK42xHehvJMzQjqh9hl7xZigJoJwL3BI+TQccn30kutZ0wDzL
         RzsUp2/bK5iwM+GG+A4L6L0jpshCLJxaFRUjfcF1EWR281Xklgd6lHDGJvTWBMohdzvz
         ioSmxSGQgki60y+z3IPaZ8GxrH4GQG4nwjPuyLP+EMwRbwjrLAae16ASrkzZO2kxi6rM
         pNg19ohjI6psOGQ6ZbF/lMrladvvr5iSkvM8mzAEtFcy8g5amnNAWWlGCuwTN8ZNyKBY
         +WthnmzSEIcYMyQYjC83yzf5fQx1BIrG2dEIbR/IeMs/lmED6A2XKHaMWOFLWvPkiTxY
         dHXA==
X-Gm-Message-State: AFqh2kpyoGrAskFRGVqzXOFpuX7/DwUFW95e6SY4vI05OenQQDIZs9GC
        HKcQ6CaOXK/UnVtxp58u1rsj0w==
X-Google-Smtp-Source: AMrXdXslPob+FNgzHy2CAfC4/AAEPuPKx+TO27hrbUTcw0/b/25IJF1RaU4L2XRUOCJayuxD5zThNw==
X-Received: by 2002:a05:6512:141:b0:4ca:f887:fe99 with SMTP id m1-20020a056512014100b004caf887fe99mr5516459lfo.25.1672310220931;
        Thu, 29 Dec 2022 02:37:00 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b004b57a253deasm3014886lfr.162.2022.12.29.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 02:37:00 -0800 (PST)
Message-ID: <f0bfcbe0-5053-49b9-5598-7d23dcc4cbb3@linaro.org>
Date:   Thu, 29 Dec 2022 11:36:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] ARM: dts: qcom: pm8226: add PON device node along
 with resin sub-node
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221228230421.56250-1-rayyan@ansari.sh>
 <20221228230421.56250-3-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221228230421.56250-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.12.2022 00:04, Rayyan Ansari wrote:
> The PON (Power On) device in PM8226 supports both the power key and
> resin (reset input).
> The reset input is usually connected to a physical volume up/down button.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom-pm8226.dtsi | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
> index a2092569970a..6af259218f63 100644
> --- a/arch/arm/boot/dts/qcom-pm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  #include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> @@ -10,12 +11,25 @@ pm8226_0: pm8226@0 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		pwrkey@800 {
> -			compatible = "qcom,pm8941-pwrkey";
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
>  			reg = <0x800>;
> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> -			debounce = <15625>;
> -			bias-pull-up;
> +
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
That's redundant, the driver sets this by default if linux,code is
not found.

Konrad
> +			};
> +
> +			pm8226_resin: resin {
> +				compatible = "qcom,pm8941-resin";
> +				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				status = "disabled";
> +			};
>  		};
>  
>  		smbb: charger@1000 {
