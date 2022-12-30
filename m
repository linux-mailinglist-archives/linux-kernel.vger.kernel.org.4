Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893206594D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiL3FSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiL3FS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:18:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B2640D;
        Thu, 29 Dec 2022 21:18:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0536361A22;
        Fri, 30 Dec 2022 05:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8821EC433D2;
        Fri, 30 Dec 2022 05:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672377504;
        bh=2qylLi2kCTdKliwyFYLHMEdujewzC6sE3S4J7gHkrZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6UhDdsirwtb50xtkgIr5O7T3gydw4+sSocahqHU/N7KOU2dsh9YWFXqWUJ5Kqn6g
         jhFpFctZ2xqX7TcIUyMBOkF5zeISVeDWuBLhcWt7UZzRXjkwfLJx5h/GQadUtjlV+u
         0wTp4mw5aWwAbiZIYeiHQfBKJyKPBL0DtrQ/y5d6dSmSvRQD77E94wBV03cXdIabgv
         HwKt5kvW1LqsHIXDqiz3gRGQx9VowXocpn0mqwtosAdrD4CHEfXy+2ffmIm4/W3mbc
         LAbBeqK7ui7EyaO8urQ1CCi8fYMLDqvn9iinZF/h2QZrAPrGKU7aQc2IOdICfkx23N
         vZjDor6OIr0KQ==
Date:   Fri, 30 Dec 2022 10:48:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] arm64: dts: qcom: sm8450-nagara: Include PMIC
 DTSIs
Message-ID: <Y650nIthLg1/IDeT@matsya>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
 <20221229103212.984324-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229103212.984324-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-12-22, 11:32, Konrad Dybcio wrote:
> Now that SPMI is finally in place, include the DTSIs of PMICs present
> on Nagara.

I never got to send mine, so thanks for sending

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> No changes
> 
>  arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> index 45ee922de4e8..e29fb7adc780 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
> @@ -5,6 +5,12 @@
>  
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sm8450.dtsi"
> +#include "pm8350.dtsi"
> +#include "pm8350b.dtsi"
> +#include "pm8350c.dtsi"
> +#include "pm8450.dtsi"
> +#include "pmk8350.dtsi"
> +#include "pmr735a.dtsi"
>  
>  /delete-node/ &adsp_mem;
>  /delete-node/ &rmtfs_mem;
> -- 
> 2.39.0

-- 
~Vinod
