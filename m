Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28770DC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjEWMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjEWMZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08809E79;
        Tue, 23 May 2023 05:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D3B1624E0;
        Tue, 23 May 2023 12:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF27FC433D2;
        Tue, 23 May 2023 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684844689;
        bh=gj5qIIuM/4Kg3jC5/WRQLFgOl7Twqxvxi08WIIuci8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgWNdxltwGQqe77/yXQP1OUs5hUYMlAa7cWzRlcniVlKNMKSR2Fu4pf9sJ1z5+O9J
         JemQW2C7EWNrKRljOPe/LVd7yWtEzsnv1g+mPi2m3oM4LOfartq8L3cHNSGbMQTv5i
         YNoHXYpTrSPo9wOlwmkoaxfEkrBR8vjJ1SD2/BfjvaB2QixOWH3m0YNWVDmtzN+gl2
         3y4GmJe0BBepLjBPw92WBqLDkfYLBz4locVt+GEP0QZXrtVhDR6U/Vg/l3dWTkehDw
         TtQlgcR+5lBvSHHq6APpu5allzmRN7iRgDWFtSoSQIqgXu7oPGv8Fi5Zwoy8NQKsXg
         kWIjjqfBrLKLA==
Date:   Tue, 23 May 2023 05:28:42 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Enable GPU related
 nodes
Message-ID: <20230523122842.cueyeovuzpx63def@ripper>
References: <20230523011522.65351-1-quic_bjorande@quicinc.com>
 <20230523011522.65351-4-quic_bjorande@quicinc.com>
 <1669ecc5-1845-e671-83f4-19ee14d37ce5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669ecc5-1845-e671-83f4-19ee14d37ce5@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:04:40AM +0200, Konrad Dybcio wrote:
> 
> 
> On 23.05.2023 03:15, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Add memory reservation for the zap-shader and enable the Adreno SMMU,
> > GPU clock controller, GMU and the GPU nodes for the SC8280XP CRD and the
> > Lenovo ThinkPad X13s.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> > 
> > Changes since v1:
> > - None
> > 
> >  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 26 +++++++++++++++++++
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 26 +++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > index 5b25d54b9591..547277924ea3 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> > @@ -210,6 +210,11 @@ vreg_wwan: regulator-wwan {
> >  	};
> >  
> >  	reserved-memory {
> > +		gpu_mem: gpu-mem@8bf00000 {
> The ZAP region is very seldom moved around, and I wouldn't expect it
> to be uncommon among the very usecase-specific 8280 machines.
> 
> > +			reg = <0 0x8bf00000 0 0x2000>;
> > +			no-map;
> > +		};
> > +
> >  		linux,cma {
> >  			compatible = "shared-dma-pool";
> >  			size = <0x0 0x8000000>;
> > @@ -259,6 +264,10 @@ usb1_sbu_mux: endpoint {
> >  	};
> >  };
> >  
> > +&adreno_smmu {
> > +	status = "okay";
> > +};
> Ugh. Should definitely be enabled by default.
> 
> > +
> >  &apps_rsc {
> >  	regulators-0 {
> >  		compatible = "qcom,pm8350-rpmh-regulators";
> > @@ -376,6 +385,23 @@ &dispcc0 {
> >  	status = "okay";
> >  };
> >  
> > +&gmu {
> > +	status = "okay";
> > +};
> You can keep the GMU enabled by default as well, it won't "probe" on
> its own (the GPU's hw_init calls its registration)
> 
> > +
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sc8280xp/qcdxkmsuc8280.mbn";
> > +	};
> > +};
> > +
> > +&gpucc {
> > +	status = "okay";
> > +};
> Clock controllers have no reason to be off by default.
> 

On sa8295p/sa8540p the GPU is powered differently, so if I leave it
enabled by default I need to disable it (or configure it) for those, or
they won't boot.

Regards,
Bjorn

> Konrad
> > +
> >  &mdss0 {
> >  	status = "okay";
> >  };
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index bdcba719fc38..5ef3f4c07d75 100644
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
> > @@ -359,6 +364,10 @@ usb1_sbu_mux: endpoint {
> >  	};
> >  };
> >  
> > +&adreno_smmu {
> > +	status = "okay";
> > +};
> > +
> >  &apps_rsc {
> >  	regulators-0 {
> >  		compatible = "qcom,pm8350-rpmh-regulators";
> > @@ -518,6 +527,23 @@ &dispcc0 {
> >  	status = "okay";
> >  };
> >  
> > +&gmu {
> > +	status = "okay";
> > +};
> > +
> > +&gpu {
> > +	status = "okay";
> > +
> > +	zap-shader {
> > +		memory-region = <&gpu_mem>;
> > +		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
> > +	};
> > +};
> > +
> > +&gpucc {
> > +	status = "okay";
> > +};
> > +
> >  &mdss0 {
> >  	status = "okay";
> >  };
