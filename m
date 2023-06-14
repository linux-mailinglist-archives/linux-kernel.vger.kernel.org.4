Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED72B730451
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbjFNPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbjFNPzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F0B193;
        Wed, 14 Jun 2023 08:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EBD9615D1;
        Wed, 14 Jun 2023 15:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76027C433C0;
        Wed, 14 Jun 2023 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686758101;
        bh=iI6igqMT60w7P/l0QhFqDEyNg7+YVbD5N8OO3TanF+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e48oeFwLHdIUlSFKmZpuhvaZIc6XX120LrcMPSpyEqB7BWuDFDEx67h7VG5wuG+/V
         MZ55YvNovcv/mJkjYdv4qw/Fg9V8aUml9KglqAzDpQnFQJj6WBmgLjZINSWGrPOFKW
         A4UJyJrm6EZnGRqzlethKgCNm6OmbCct4vFCZC3ztZhnngSbp8pzXo4cyHdNGZkwXz
         gmGqY4U4493FBCFLe1W+p6/yZ9AorFfR4Az6A8Ax6LKC06sOmpk/gWKymf+QLeQbmI
         v+58d1tk96zhctkcv00QPrklqa/1YQT9XY3e8vW+P2TBoD2h3BSqXYCgybGS7H+ljv
         vnyDkW6WNMmCA==
Date:   Wed, 14 Jun 2023 08:58:23 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        johan@kernel.org, mani@kernel.org,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sc8280xp: Enable GPU related
 nodes
Message-ID: <20230614155823.g7xfgxff3eopukwh@ripper>
References: <20230614142204.2675653-1-quic_bjorande@quicinc.com>
 <20230614142204.2675653-3-quic_bjorande@quicinc.com>
 <8f8d5e09-50a6-a83f-d4bb-3d7bc8c07162@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8d5e09-50a6-a83f-d4bb-3d7bc8c07162@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:27:24PM +0200, Konrad Dybcio wrote:
> On 14.06.2023 16:22, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Add memory reservation for the zap-shader and enable the Adreno SMMU,
> > GPU clock controller, GMU and the GPU nodes for the SC8280XP CRD and the
> > Lenovo ThinkPad X13s.
> > 
> > Tested-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 

Thanks.

> one question below
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 14 ++++++++++++++
> >  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 14 ++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index cd7e0097d8bc..b566e403d1db 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -210,6 +210,11 @@ vreg_wwan: regulator-wwan {
> >  	};
> >  
> >  	reserved-memory {
> > +		gpu_mem: gpu-mem@8bf00000 {
> Is it ever going to differ on other platforms, including the automotive ones?
> 

The memory maps for the two live different lives.

Regards,
Bjorn

> Konrad
> > +			reg = <0 0x8bf00000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> >  		linux,cma {
> >  			compatible = "shared-dma-pool";
> >  			size = <0x0 0x8000000>;
> > @@ -390,6 +395,15 @@ &dispcc0 {
> >  	status = "okay";
> >  };
> >  
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sc8280xp/qcdxkmsuc8280.mbn";
> > +	};
> > +};
> > +
> >  &mdss0 {
> >  	status = "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index 5ae057ad6438..7cc3028440b6 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -264,6 +264,11 @@ vreg_wwan: regulator-wwan {
> >  	};
> >  
> >  	reserved-memory {
> > +		gpu_mem: gpu-mem@8bf00000 {
> > +			reg = <0 0x8bf00000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> >  		linux,cma {
> >  			compatible = "shared-dma-pool";
> >  			size = <0x0 0x8000000>;
> > @@ -518,6 +523,15 @@ &dispcc0 {
> >  	status = "okay";
> >  };
> >  
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
> > +	};
> > +};
> > +
> >  &mdss0 {
> >  	status = "okay";
> >  };
