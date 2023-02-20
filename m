Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73669CB27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjBTMkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjBTMj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:39:59 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24FDDBC5;
        Mon, 20 Feb 2023 04:39:53 -0800 (PST)
Received: from [10.0.0.182] (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 138721600E5;
        Mon, 20 Feb 2023 13:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1676895941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4264FLxyABbFkLYLtX4Tn1z8cOx769b0SJ6QlJBzWI=;
        b=v3HuHaoMIdRLKX+fDb8Mi0Z2WQDy4lpt+UgClwwYWReKremy6ifZAFeQ+sFigLLVCt1SCo
        VWGkwKqJqA2Lwkq5Lmx9oX2pz5Uk9WsyqFeZfHwZ7XBU7ZhHACnCbHxgvNceDQlDQCJw1W
        211hefUDRBa2eXcBOBJj6pe1YPDibA4=
Message-ID: <6db2461e-249e-c181-4e14-48b792207a18@ixit.cz>
Date:   Mon, 20 Feb 2023 13:25:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] ARM: dts: qcom-apq8064: Fix opp table child name
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230220120831.1591820-1-konrad.dybcio@linaro.org>
Content-Language: en-US
From:   David Heidelberg <david@ixit.cz>
In-Reply-To: <20230220120831.1591820-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!

Reviewed-by: David Heidelberg <david@ixit.cz>

On 20/02/2023 13:08, Konrad Dybcio wrote:
> The opp-320000000 name is rather misleading with the opp-hz value
> of 450 MHz. Fix it!
>
> Fixes: 8db0b6c7b636 ("ARM: dts: qcom: apq8064: Convert adreno from legacy gpu-pwrlevels to opp-v2")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 92aa2b081901..3aeac0cabb28 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -1260,7 +1260,7 @@ &gfx3d1 30
>   			gpu_opp_table: opp-table {
>   				compatible = "operating-points-v2";
>   
> -				opp-320000000 {
> +				opp-450000000 {
>   					opp-hz = /bits/ 64 <450000000>;
>   				};
>   

-- 
David Heidelberg
Consultant Software Engineer

