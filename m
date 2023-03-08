Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B854F6B03D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCHKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:18:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288FB1B2E3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:18:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a32so2070535ljq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678270681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krZQpr7uIm4vLx88h00ljILNedqe5S23Jc9CthZt6vU=;
        b=PEerjSzms92KVfFhY/EDDlsfRjdHx3uWqwcch/aK80fwALOeLAy74p2WPgAFoQNSSr
         sonOqt17DNZvs3NnL7QFpRcFnb/rklcHvxjsoXqPYtgwyQe8ahAiuPmtrYNDQLWG+XTb
         tbvH0r/yU5DXqsZxHw4ggMmgkQgS/DOmH2q3TLWciwkiXcnwB7pQFO8y78XRgdoK+v0H
         2FT7VtiOankxEG3I3fZUkq6pNqY5MQJtuGBlLYr88pEuOw2Q/ddpZz6JPf+1gtzX8KqH
         +WizrEyfHbtEKvSwd8SG6RyPFdt273usiyvAh84KpFdLTG2bDzvdZeoGpfg3xL3nqSsf
         NMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678270681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krZQpr7uIm4vLx88h00ljILNedqe5S23Jc9CthZt6vU=;
        b=FktW7KZ+0pU5zt99XmLwB5mgg6yVHV9Tccai+gPoSIrd1VkCIjtQyZ+N0UBF/0Etse
         zEKT2mh6WL4EE2rhT2toXqy/t9xMIMVlwCYmpIJWWY3kMRQGCms9CCxS3YKdRJfNO/y7
         /IxcCvakZ1PPoDyBNUApWeBp2q1K9zIQjRlTRAgsz9+EdSNNdClEllqAKUos/xn5+MJX
         VsCTLs/Rzn1Jg7Jf0SJeXNyhD/0eVzMDv1FyPgtDjg3p4IA+Ktylwrx8Q1jxFrOXbSdK
         ZaLvj9D9+Q91xkD1zVIUbAVk8Slnf8WlVh5ftWiYuNaneh6TLxdXYMf4zsbt8c4QXK4n
         VG5Q==
X-Gm-Message-State: AO0yUKVAkfHAd/A4arRtutRUP9uahzMthjemntZ3qUICP7E2FlOc8Oos
        XwQBYDsIHElcWGXqMQgVTuFojw==
X-Google-Smtp-Source: AK7set9n1U1YMBH0wlOoSKEkMVTtc4syUR8K40rQA+XD5LofbKGrhDBmIn2Es6laJf5Gpzy+YqdFcg==
X-Received: by 2002:a2e:3111:0:b0:290:6e3b:be34 with SMTP id x17-20020a2e3111000000b002906e3bbe34mr4957732ljx.42.1678270681440;
        Wed, 08 Mar 2023 02:18:01 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id c19-20020ac244b3000000b004cc9c2932a9sm2304433lfm.302.2023.03.08.02.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:18:01 -0800 (PST)
Message-ID: <b72d54ac-5152-bc6c-55a9-dd59d32614d6@linaro.org>
Date:   Wed, 8 Mar 2023 11:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 4/6] arm64: dts: qcom: sm6125: Add UFS nodes
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230306170817.3806-1-they@mint.lgbt>
 <20230306170817.3806-5-they@mint.lgbt>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230306170817.3806-5-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.03.2023 18:08, Lux Aliaga wrote:
> Adds a UFS host controller node and its corresponding PHY to
> the sm6125 platform.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
[...]

> +		ufs_mem_phy: phy@4807000 {
> +			compatible = "qcom,sm6125-qmp-ufs-phy";
> +			reg = <0x04807000 0xdb8>;
> +
> +			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> +			clock-names = "ref", "ref_aux";
Please wrap it into

clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
	 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
clock-names = "ref",
	      "ref_aux";


and resolve the binding/offset situation. Otherwise, LGTM!

Konrad
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		gpi_dma0: dma-controller@4a00000 {
>  			compatible = "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
>  			reg = <0x04a00000 0x60000>;
