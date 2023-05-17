Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87F705F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjEQFro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQFrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2835A5;
        Tue, 16 May 2023 22:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4791D63187;
        Wed, 17 May 2023 05:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7E9C433D2;
        Wed, 17 May 2023 05:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684302460;
        bh=xR894eWuJz83yxJe9tbqmIXVG1V/4uvTog4qdhGWcaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrhhT3AnRbI0I07t98bjVU82LZ2EvHZa+PKkwawUCODVBN6QhkOhCNINquKKvzp7q
         +8FVczXtKd5z3N+THXAaGaYHjBvTdhTxl9fKR99jGnclI30jGco7ldU0sWAwx9QNeo
         D1igt8vNV+KVX1QM5V7HwZpKkqkQbou9R99OE2K5QNjiZN5Yj7cik54EIHXZCKAFmb
         LgKrDnAtpWwtfNBkYGJIylvycaX8dE3ImhyZHQgPdYaEBZ3Y0Jr4JQTn6PEfGtiwl4
         y9TpPXC2xcvAAA+pVU2r/fBMTRv/kMqORIA5liwfABVmx5CoMq+vq9JFP9JtHRMR1R
         97s1RSJticdrQ==
Date:   Wed, 17 May 2023 11:17:31 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: Use the correct LLCC
 register scheme
Message-ID: <20230517054731.GI4868@thinkpad>
References: <20230517-topic-kailua-llcc-v1-0-d57bd860c43e@linaro.org>
 <20230517-topic-kailua-llcc-v1-2-d57bd860c43e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517-topic-kailua-llcc-v1-2-d57bd860c43e@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 04:18:50AM +0200, Konrad Dybcio wrote:
> During the ABI-breaking (for good reasons) conversion of the LLCC
> register description, SM8550 was not taken into account, resulting
> in LLCC being broken on any kernel containing the patch referenced
> in the fixes tag.
> 
> Fix it by describing the regions properly.
> 
> Fixes: ee13b5008707 ("qcom: llcc/edac: Fix the base address used for accessing LLCC banks")

Same comment about the Fixes tag.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I do not have access to the SM8550 documentation to confirm the base address but
I hope that it has been taken care of.

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6e9bad8f6f33..70ae7e2e900a 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -3762,9 +3762,16 @@ gem_noc: interconnect@24100000 {
>  
>  		system-cache-controller@25000000 {
>  			compatible = "qcom,sm8550-llcc";
> -			reg = <0 0x25000000 0 0x800000>,
> +			reg = <0 0x25000000 0 0x200000>,
> +			      <0 0x25200000 0 0x200000>,
> +			      <0 0x25400000 0 0x200000>,
> +			      <0 0x25600000 0 0x200000>,
>  			      <0 0x25800000 0 0x200000>;
> -			reg-names = "llcc_base", "llcc_broadcast_base";
> +			reg-names = "llcc0_base",
> +				    "llcc1_base",
> +				    "llcc2_base",
> +				    "llcc3_base",
> +				    "llcc_broadcast_base";
>  			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> 
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்
