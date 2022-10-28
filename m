Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C267611CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJ1Vp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJ1Vph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:45:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C13CBFF;
        Fri, 28 Oct 2022 14:44:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4294862A9A;
        Fri, 28 Oct 2022 21:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8841C433C1;
        Fri, 28 Oct 2022 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666993486;
        bh=hEPWWlelcGH3NQVG+eZz1c2zEG8h8Bc4DpOykI4c9Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lCifIkfabc3Jhkz4fjaWCTgPqUFY6iypjHmafhtPZwpsAaSeav5hoQsjrowongJD/
         E4hvNN1opq6PBc4kN7fHcndS9JUOMMBGHKXUURcE9UjjCylPtb34ePtBWcD3/5b0g3
         XVV74JyQ+4QbEhXMqotyyegecdwxoRPZt0+tVx1N5/+lyu34mtpfp0+S0RAH+K26SA
         z2aKMVv+7fHOVnIa+Ln6nWjzYW5RvVIQ25V0mwkZlBssJayoBi8zmAPxtdennkyIs0
         SfmsMf2EOmfLRwv62heLRDN0GgpFulhGzy8CpH/6kAsf1RcPrWVwAImDt7liDWmA4h
         hIF7ZaPyGt8nA==
Date:   Fri, 28 Oct 2022 16:44:43 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Job Noorman <job@noorman.info>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: sdm632: fairphone-fp3: add
 touchscreen
Message-ID: <20221028214443.oeg5u4n4bjdyeuks@builder.lan>
References: <20221024140001.139111-1-job@noorman.info>
 <20221024140001.139111-4-job@noorman.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024140001.139111-4-job@noorman.info>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 03:59:59PM +0200, Job Noorman wrote:
> Add Himax hx83112b touchscreen to the FP3 DT.
> 
> Signed-off-by: Job Noorman <job@noorman.info>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Please include at least all the mailing lists as Cc on all your patches
in the series - I'm not subscribed to linux-input, so I don't have patch
1 or patch 2 in my inbox.

Thanks,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> index 891e314bc782..2920504461d3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> @@ -49,6 +49,20 @@ &hsusb_phy {
>  	vdda-phy-dpdm-supply = <&pm8953_l13>;
>  };
>  
> +&i2c_3 {
> +	status = "okay";
> +
> +	touchscreen@48 {
> +		compatible = "himax,hx83112b";
> +		reg = <0x48>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <65 IRQ_TYPE_LEVEL_LOW>;
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2160>;
> +		reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
>  &pm8953_resin {
>  	status = "okay";
>  	linux,code = <KEY_VOLUMEDOWN>;
> -- 
> 2.38.1
> 
