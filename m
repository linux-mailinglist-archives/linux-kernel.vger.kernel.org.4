Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED46B2CED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCISbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCISbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B7F693F;
        Thu,  9 Mar 2023 10:31:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBCA61CBB;
        Thu,  9 Mar 2023 18:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10531C433EF;
        Thu,  9 Mar 2023 18:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678386664;
        bh=OxAVh16i6IS88ISIABoRkC+frhPtYq64zT19SQCyKuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/CTkObKg7x/D/u0C5N5X1Oe97RxLUH9xaQb+tvbS0VyIbeXR3gZfQgQJoq2Y+eU6
         ApNVEfFzmVjpK122Zj0KuSSGs3ZWk8ult+K7iQtgck7Q6XiZ1UiDGKYuldXFyw7ec9
         0wskKSCc7dXvIAfKo3uXFG6i1uWX5W2t9bf7DDi6ez4IVixa8IRd6EhST86ZvFfwUE
         4jmRAsUFcgDB2OZGUAcCcH0YZb+IDOxPvphulo5tOTsJzIqpzqMmgLgm9Pyd7uQyz8
         wMIKFTyeHowrCRL8A1MyTBRwk8Y0EC7JDQn3qBSbuYctpA9Co1DzkcmKhajDFNTW7j
         C3J/3pCbY7AOA==
Date:   Thu, 9 Mar 2023 10:31:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto
 Engine nodes
Message-ID: <ZAol5o5a6HZYgRaG@sol.localdomain>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:31:46AM +0100, Krzysztof Kozlowski wrote:
> On 08/03/2023 16:58, Abel Vesa wrote:
> > Drop all properties related to ICE from every UFS and SDCC node,
> > for all platforms, and add dedicated ICE nodes for each platform.
> > On most platforms, there is only one ICE instance, used by either
> > UFS or SDCC, but there are some platforms that have two separate
> > instances and, therefore, two separate nodes are added.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > 
> > Changes since v1:
> >  * Made changes for all platforms that use ICE, as a single patch since
> >    most changes look really similar.
> > 
> >  arch/arm64/boot/dts/qcom/sdm630.dtsi | 18 +++++++++-----
> >  arch/arm64/boot/dts/qcom/sdm670.dtsi | 15 +++++++----
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++-------
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 +++++++++++++++++-----------
> >  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++---------
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 +++++++++-------
> >  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++-------
> >  7 files changed, 102 insertions(+), 63 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > index 5827cda270a0..2aed49104d9d 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> > @@ -1330,9 +1330,8 @@ opp-200000000 {
> >  		sdhc_1: mmc@c0c4000 {
> >  			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
> >  			reg = <0x0c0c4000 0x1000>,
> > -			      <0x0c0c5000 0x1000>,
> > -			      <0x0c0c8000 0x8000>;
> > -			reg-names = "hc", "cqhci", "ice";
> > +			      <0x0c0c5000 0x1000>;
> > +			reg-names = "hc", "cqhci";
> 
> I believe this will break the ICE on these platforms without valid
> reason. The commit msg does not explain why you do it or why this is
> necessary.
> 
> We already we received comment that we keep breaking Qualcomm platforms
> all the time and need to keep them in some shape.
> 
> Also, patchset is non-applicable in current set (breaks users) and
> neither commit nor cover letter mentions it.
> 

FWIW, I tested this patchset on SDA845, and ICE continues to work fine.

(Though if I understand the patchset correctly, the ICE clock is no longer
turned off when the UFS host controller is suspended.  That isn't ideal as it
wastes power.  I would like that to be fixed.)

Anyway, when you say "break the ICE", do you really mean "make an incompatible
change to the device-tree bindings"?

I'd think there would be no problem with that as long as everything is updated
at once, which this patchset does.

I've heard before that some people consider the device-tree bindings to be a
stable UAPI.  That doesn't make sense to me.  Actually, my original ICE patches
ran into this issue too, and the resolution was simply that the Qualcomm
platforms maintainer (Bjorn) decided to take the patches anyway.  I never heard
any complaints afterwards.  Maybe the same is fine here too?

- Eric
