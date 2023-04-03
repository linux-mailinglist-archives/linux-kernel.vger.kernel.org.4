Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A296D4433
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjDCMQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjDCMQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC5113F2;
        Mon,  3 Apr 2023 05:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D890C61888;
        Mon,  3 Apr 2023 12:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B61C433EF;
        Mon,  3 Apr 2023 12:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680524165;
        bh=t8WBdW45+1Hqn/jcQvHAdYy51f3JmJMvVFmk48M7AiU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ivU9ezAkyEv2NnkR6ifcx9U961kKK2Qpk/PEiUrNlg5AWDDk7AzT3pIA88+jP5vAx
         wozi35njaonVEe+ZTVPEBIqGqS046LxdsPAUc1jP4wiS7a6t3lDzjwG2btjx2Syi+7
         +Ec5sBYZZ2DLlXUUKeU8Z04sL3FFCbXYK8M+5KtAT4Sj8REUcxY6o8vdJaCc4lVhcJ
         RN7yWhvbqezyDzivNJOwHfnKHfNlhHwvUPJfh9H+57FOA+gLj/NEB/jOAaPrp+jX+P
         cMmwsxbwCMYE6YULuOAKLekMvCap7SUsuiKw+id9m8hyeHdBNcVzMNWMJh5m+8BuEq
         A3qtr8eDVzpiw==
Message-ID: <9ecab48e-e828-0a03-2bc7-678e555bc80d@kernel.org>
Date:   Mon, 3 Apr 2023 15:15:59 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: sm8350: Add Crypto Engine
 support
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
 <20230402100509.1154220-11-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230402100509.1154220-11-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

On 2.04.23 13:05, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm8350.dtsi'.
> 
> Co-developed-by and Signed-off-by: Robert Foss <rfoss@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 7fbc288eca58..090ee07d1800 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1730,6 +1730,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
>   			};
>   		};
>   
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x24000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			iommus = <&apps_smmu 0x594 0x0011>,
> +				 <&apps_smmu 0x596 0x0011>;
> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,sm8350-qce", "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0 0x01dfa000 0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x594 0x0011>,
> +				 <&apps_smmu 0x596 0x0011>;
> +			interconnects = <&aggre2_noc MASTER_CRYPTO &mc_virt SLAVE_EBI1>;
> +			interconnect-names = "memory";

We switched to #interconnect-cells = <2> (since commit 4f287e31ff5f), so maybe #include
dt-bindings/interconnect/qcom,icc.h and add the tags.

BR,
Georgi

> +		};
> +
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sm8350-ipa";
>   

