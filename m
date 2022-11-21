Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB68A6321F5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKUM3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiKUM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:28:40 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132C9B7017
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:27:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id r8so3719539ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqDoQW+ExRlQ4XcuipMt388Vx0gMl1yxHscCBvvs+7o=;
        b=pr05XG2eWSBxVvSLCqaaVVwSgfwOaVveoWIpfJzVw19EWKfDOybsheosmVGpOb3WOU
         L0ADbk2CeR3dGIO/FmPBHNNNiy5mHmyGW0qeGmeRB8OlCkWVrwOCMvbvX0A4tNv8LtAd
         +CBiRXgL5wEhw3/w3D00vL8JVBiv1nEVN3UYPw2bx5nQQhDN4eGSvkt+81MtZzMWfMGe
         avuHKo98CVhE0FPDPb1lrgw4Q1oHaPdghSfGia/d83luI/NxdGBaGOPRHtgwXEmCTwxC
         YAG3ou9WIlHXDeedTnlXAUq9Hg1YjXh8yntmTlxvAbeb5YXTAqS8m7BIiOcGqcKVHnwP
         staw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqDoQW+ExRlQ4XcuipMt388Vx0gMl1yxHscCBvvs+7o=;
        b=p4vo6XckmmDyGqDF0E5Wa7PVct+8ccCIulktPDwyZB5PGkS7nKS6m7rkUbLb9I5xlQ
         Oo0IbAwg0AcMPBF+CwIaJ+qPHyB/FqfmEMwfeLtw0WuOHaey/FbP/1f9TBLDxrnjJd+E
         7K9JHqiQ8O5pnoklsfRq6KfL03P5xGzxYpcmS9niEEJko2PMUEAzo9tr1NZMben8dSm9
         Mokx3lbCiT7Tn0Tcefo1rgwaj2WhMmBawWgf83Ih6xVQAUevRIlZmZMBXvhiUqHcvMHq
         9AJRolewM/JIkuPk93RerMoLluoAa5MW0U3wbBTc60DENedeTqHvEDB6M4FZC94riMoF
         Qf+A==
X-Gm-Message-State: ANoB5pmZvjoIp2LiqREQC/jCVZq/kB3QXOBuX6rdlX2GpJU172hcApf8
        fWa2gYGJkLbC04QCcaQ6dE+URA==
X-Google-Smtp-Source: AA0mqf42gSqmzNNg4zoEvk7V5m7MWD4mxlEGtv42sHmh2Lq/P18eCvmKmMD3G2Ote6b1rjdD0sojzA==
X-Received: by 2002:a2e:b538:0:b0:26d:cfc6:d6f7 with SMTP id z24-20020a2eb538000000b0026dcfc6d6f7mr5883956ljm.34.1669033676306;
        Mon, 21 Nov 2022 04:27:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w2-20020a19c502000000b004a05767bc07sm2001896lfe.28.2022.11.21.04.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:27:55 -0800 (PST)
Message-ID: <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
Date:   Mon, 21 Nov 2022 13:27:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
 <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
 <20221121091118.48628-3-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121091118.48628-3-sriranjani.p@samsung.com>
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

On 21/11/2022 10:11, Sriranjani P wrote:
> Add SYSREG controller device node, which is available in PERIC, FSYS0 and
> FSYS1 block of FSD SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> index f35bc5a288c2..db78816ba0bf 100644
> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -518,6 +518,21 @@
>  				"dout_cmu_fsys1_shared0div4";
>  		};
>  
> +		sysreg_peric: syscon@14030000 {

Node name system-controller
and either put it next to existing one or next to functional block
(peric clocks?) ordered by unit address.

> +			compatible = "tesla,fsd-sysreg", "syscon";
> +			reg = <0x0 0x14030000 0x0 0x1000>;
> +		};

Best regards,
Krzysztof

