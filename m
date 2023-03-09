Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BB6B2175
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCIKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCIKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:31:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DC66287A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 02:31:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x3so4958305edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 02:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678357909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7CF8z9jOtSHETZ35/S5CyQ9qW+jDKWLcnRE2tTycAxk=;
        b=lz2qXv02Qi0cPLKJ8qrTLl4kUwKDbhY5yYCkCKeO+SS273hkfqFOlMrGvpxRj8f1Bx
         BiI6EVRN9nGDJTdNGPXh1msUnHkck/zaquorFZGQpIUCDDN3W/uqpBDSOR29It0BoNsG
         cZLZ8fZYx/LdZcNQ+Pi1qhuSLRynQpoCYntoSrxF7KP2wGdzoWSJizeDiGBgMSE1PISH
         aw6LYPGBlqG6Q2CSfwyq4LgIl/lfCASstHMuiYOdLDFjI16fVozkvDijYIMMF8wAXZQd
         dtxLnPXKfcW1OsJk6VY4iXoV2m5MvlSvkEDJWWeJtMdJPy9AfhHBsQ/A+xrkLkXOOwn0
         lMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CF8z9jOtSHETZ35/S5CyQ9qW+jDKWLcnRE2tTycAxk=;
        b=cR+NySt8e7Tk1VVEkrf5zCI1wSed8fDRCVVwlznR45MAbPb83bKZU48DML3EHWoZd7
         gDs2H3Muiidr8MpOfccQmXIlyjRXHWeJPn0+JnqHTaMhzrQUJRCoiTTBGeYdPWkayf8p
         iPsJrIf8Sb+X0ZhoO0KBRC1camNc/tTBqnyniyke1Z5avhrpssffj/X5oSlDUjxLDvAV
         nYPshiQ5PhF9uR8La380phPKRKkiKWxOSFKPdh6KCdkx9SZlsM0rZSuhi8zm/8K7TbfA
         Tv52/Mg6cORvpEKcl6m7REjrTEve/l1nYaySNVbtNZzSwODwgUaaR6FpYCboW+ucOEOX
         V4Yw==
X-Gm-Message-State: AO0yUKWGM6eeenlZnMYFGNmMGb5h/46jpcyA8BBokAxtboLgEUBGUjYp
        qlcjSp5XjkzuF1E0zOpjQMD8ow==
X-Google-Smtp-Source: AK7set9Dg6O4cO0YA5JkJqzyy2QEjbu78MIGWlRIZmzieAqsZkY6bSqEUGwojwHo/WXVK7gGEqKJlw==
X-Received: by 2002:a17:907:7e82:b0:8f4:6efd:833f with SMTP id qb2-20020a1709077e8200b008f46efd833fmr26844959ejc.3.1678357908781;
        Thu, 09 Mar 2023 02:31:48 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id mb3-20020a170906eb0300b008e772c97db6sm8603741ejb.128.2023.03.09.02.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:31:48 -0800 (PST)
Message-ID: <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
Date:   Thu, 9 Mar 2023 11:31:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto Engine
 nodes
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308155838.1094920-8-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 16:58, Abel Vesa wrote:
> Drop all properties related to ICE from every UFS and SDCC node,
> for all platforms, and add dedicated ICE nodes for each platform.
> On most platforms, there is only one ICE instance, used by either
> UFS or SDCC, but there are some platforms that have two separate
> instances and, therefore, two separate nodes are added.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * Made changes for all platforms that use ICE, as a single patch since
>    most changes look really similar.
> 
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 18 +++++++++-----
>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 15 +++++++----
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++-------
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 +++++++++++++++++-----------
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++---------
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 +++++++++-------
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++-------
>  7 files changed, 102 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 5827cda270a0..2aed49104d9d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1330,9 +1330,8 @@ opp-200000000 {
>  		sdhc_1: mmc@c0c4000 {
>  			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
>  			reg = <0x0c0c4000 0x1000>,
> -			      <0x0c0c5000 0x1000>,
> -			      <0x0c0c8000 0x8000>;
> -			reg-names = "hc", "cqhci", "ice";
> +			      <0x0c0c5000 0x1000>;
> +			reg-names = "hc", "cqhci";

I believe this will break the ICE on these platforms without valid
reason. The commit msg does not explain why you do it or why this is
necessary.

We already we received comment that we keep breaking Qualcomm platforms
all the time and need to keep them in some shape.

Also, patchset is non-applicable in current set (breaks users) and
neither commit nor cover letter mentions it.

Best regards,
Krzysztof

