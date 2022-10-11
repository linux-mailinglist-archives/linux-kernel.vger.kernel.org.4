Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E195FB25E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJKMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJKMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:23:37 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88638FD48
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:23:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id o67so8361976qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDcL9+bBzbkp+KJx7T0xtbSPbbNIbsOAPMQB2E5GrtY=;
        b=N+NatMm2WFYZ9mlYoAn0l9SfSVSiVLQceQHaHCdUaWDDV5dzyZGrZFCohOqc6+l/Wy
         UL/lnRKlEhyWOhIYKablbsfREcV+noOV6VdWjGj0fpWW8ko2oTT6CVh/OcJrNZF8dEhB
         UFJomVk8jdBWafzbWL9DJobEwBdpEyNvPvikaiFZtuQW5eBVRj6QBOIlXxCoCcZbp4CK
         pP4scW0ATERDCFzEQok7RfNm0PdmdcKnmg5Sdy4N6mov7vn1IvqShkpDfTkpTtvDepB3
         e9gvkJvdPWsKYlnFac7mznRbl0yATAzgZFQ8jbaH5XxoDOMHjiC5xkcSEj7oRJCIrd1q
         qjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDcL9+bBzbkp+KJx7T0xtbSPbbNIbsOAPMQB2E5GrtY=;
        b=1m2MqMJHW5R3hkb7Ktz6AbaUbaK96FcexI+KU//hJxpahsmqA2CEwDjkt9kqDRlQaP
         UF7uf4668zAQJPbevVZ2MWjnmjJiVgfONY7pVMPt8IJ5z/sqb+wWqJCKQ2ou5dFU72js
         scLLK10ntYKfTA+1Fuo/qRhbFKg9biZY53DzVkqBIdQOkMU1E6w+v4fe0slPPYH7pg9N
         UOhFRexRG44dd0cYMfh2671Td3bLT75FCl7Ug2ol9E3Ruymab/kUmYq3d5Xy7XJfCC73
         Fo6cC51qJ8Oh3LFp5abh4Wx1fqFBMqA8ZEqb/4O7+afSUBVwX0hiBHFHyV/6lFco3+UL
         g5lA==
X-Gm-Message-State: ACrzQf1h4cPr+XOA9skgCVDC/Cr7liQ5KIKntuLE4/+Gr9syhJ5cVwGn
        LJN7dV4ybSnUe1ZQ2SyTZXoeVA==
X-Google-Smtp-Source: AMsMyM5WBAgPEtbDPqvpOtzVhrgo36KGJWwWy4bAnO2SXyUL6V2OnRATsznb7iVc9nuz8KjnaB3sCg==
X-Received: by 2002:a05:6214:2464:b0:4b3:6cce:9860 with SMTP id im4-20020a056214246400b004b36cce9860mr16026754qvb.120.1665491014660;
        Tue, 11 Oct 2022 05:23:34 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id bp36-20020a05620a45a400b006ce7bb8518bsm4348208qkb.5.2022.10.11.05.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:23:34 -0700 (PDT)
Message-ID: <1d2613aa-3225-a2b6-521a-b2df70a30ed5@linaro.org>
Date:   Tue, 11 Oct 2022 08:23:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 3/7] dts: arm64: mt8195: add MMSYS and MUTEX
 configuration for VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221011070356.682-1-moudy.ho@mediatek.com>
 <20221011070356.682-4-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011070356.682-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 03:03, Moudy Ho wrote:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Compatible names, node names, and GCE client registers for
> VPPSYS0 and VPPSYS1 should be renamed or added to match
> the binding file requirements.
> Also, add two nodes for MT8195 VPPSYS MUTEX.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 30 ++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..3e73bd58e54d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1476,12 +1476,23 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		vppsys0: clock-controller@14000000 {
> -			compatible = "mediatek,mt8195-vppsys0";
> +		vppsys0: syscon@14000000 {
> +			compatible = "mediatek,mt8195-vppsys0",
> +				     "mediatek,mt8195-mmsys", "syscon";

No. You change multiple pieces in one patch, some of them have much
bigger impact, like adding compatibles.

Split and describe *why* you are changing it.

>  			reg = <0 0x14000000 0 0x1000>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0 0x1000>;
>  			#clock-cells = <1>;
>  		};
>  
> +		mutex@1400f000 {
> +			compatible = "mediatek,mt8195-vpp-mutex";

And you add some new nodes in a cleanup patch...

Best regards,
Krzysztof

