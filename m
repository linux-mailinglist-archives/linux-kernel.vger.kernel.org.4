Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291B6DB29B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjDGSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjDGSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:14:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F386A53;
        Fri,  7 Apr 2023 11:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6332860F87;
        Fri,  7 Apr 2023 18:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454ECC433EF;
        Fri,  7 Apr 2023 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680891238;
        bh=1RojAWCE830GdRwpiX0yQKERd7BzZhTLhzLyTIf7/Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJjWk131PcWTKGtHQQZK6HO2GfF1YInZNDlH/Y+ATqrcMghPbJJx1yYC9KoMT/YP1
         p0DsR3RfB7bJVgBoWAahft/wjY5aahUPRl2AhmQO4TSsaIuiD+iT+aaRlBzZVC31Gn
         +tmLP148gGtW73LMJ8yZhhCjpX2mTYG5tTe/SNH7oBZbISJYhsDuv0vClGeYSP6tfL
         eVLnh/yVsEEzu4aq77Y95AsbL4FCpI6kWo5zRK2Dq3KD4EeeXK8deeavkCHqmAzqeQ
         IH/ffgD1YEcBqyA2Wn8juylsc96R1mWB2KVK3D5Q3897wrC3j40ncwgGZPWC4PIgOA
         /V/AIcpN3DKMA==
Date:   Fri, 7 Apr 2023 11:16:47 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] arm64: dts: qcom: sm8550: Add the Inline Crypto
 Engine node
Message-ID: <20230407181647.5johwgldjuzk347c@ripper>
References: <20230407105029.2274111-1-abel.vesa@linaro.org>
 <20230407105029.2274111-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407105029.2274111-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 01:50:29PM +0300, Abel Vesa wrote:
> Add support for UFS ICE by adding the qcom,ice property and the
> ICE dedicated devicetree node. While at it, add the reg-name property
> to the UFS HC node to be in line with older platforms.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v5 is here:
> https://lore.kernel.org/all/20230403200530.2103099-7-abel.vesa@linaro.org/
> 
> Changes since v5:
>  * Dropped the reg-names property from UFS node as it was not needed and
>    makes the bindings check fail

You forgot to drop the related sentence from the commit message.

Regards,
Bjorn

> 
> Changes since v4:
>  * none
> 
> Changes since v3:
>  * none
> 
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index d252658c73dd..2b3a721292b6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1932,9 +1932,18 @@ ufs_mem_hc: ufs@1d84000 {
>  				<0 0>,
>  				<0 0>,
>  				<0 0>;
> +			qcom,ice = <&ice>;
> +
>  			status = "disabled";
>  		};
>  
> +		ice: crypto@1d88000 {
> +			compatible = "qcom,sm8550-inline-crypto-engine",
> +				     "qcom,inline-crypto-engine";
> +			reg = <0 0x01d88000 0 0x8000>;
> +			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0 0x01f40000 0 0x20000>;
> -- 
> 2.34.1
> 
