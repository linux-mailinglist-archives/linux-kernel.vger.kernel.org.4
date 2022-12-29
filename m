Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0A9658ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiL2QM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiL2QMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:12:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A605FF0;
        Thu, 29 Dec 2022 08:12:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AABA6183D;
        Thu, 29 Dec 2022 16:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE60C433F0;
        Thu, 29 Dec 2022 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672330372;
        bh=1FBrD6XHPFiM6g/S/VhHmBUtyYNpfvk6206YTBkt7w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q131yO/zv6p1g6U2mU9idvwcbdySugYey845zHfH6jwVsd8IPXO4vQrzm1K4h1EJj
         rlxP9tKe3/ejHQrxsqhv/GhtgiWSoP6MmWnW8Ow4v1HCm6AgLah9zTpQit0UjO0bJU
         ceSwQQWClkT/eb3jq2Jwk5YiQ9GCA18sObq5WU/tmSmVGBMWtnQdRjM63frJ8lguv/
         O7ufGJLxx0ZfeILrkidSLMOhjPZ7/kHL5woC59gBHlNwSIcqDjIWKp075EMWs4Mbjk
         TYTB71xXqacRWGGoOIg08f9nc0ckd9FV+mlnXXt+ngaQxL/V9DBV6slbNDYcrHAokm
         WqURj/aty78kg==
Date:   Thu, 29 Dec 2022 10:12:49 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] arm64: dts: qcom: sm8450: add spmi node
Message-ID: <20221229161249.34jgdev2446rdxkf@builder.lan>
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
 <7b32e414-96a9-7265-efee-f872badb32b2@linaro.org>
 <71d7a162-569d-1443-9e53-3ba374d06ccd@linaro.org>
 <ee24809b-cf9b-c555-9c30-956949be25a4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee24809b-cf9b-c555-9c30-956949be25a4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:57:58AM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2022 11:45, Konrad Dybcio wrote:
> > 
> > 
> > On 29.12.2022 11:42, Krzysztof Kozlowski wrote:
> >> On 29/12/2022 11:32, Konrad Dybcio wrote:
> >>> From: Vinod Koul <vkoul@kernel.org>
> >>>
> >>> Add the spmi bus as found in the SM8450 SoC
> >>>
> >>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> >>> [Konrad: 0x0 -> 0, move #cells down, make reg-names a vertical list]
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>> v1 -> v2:
> >>> No changes
> >>>
> >>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>> index 570475040d95..b9b59c5223eb 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> >>> @@ -2715,6 +2715,28 @@ aoss_qmp: power-controller@c300000 {
> >>>  			#clock-cells = <0>;
> >>>  		};
> >>>  
> >>> +		spmi_bus: spmi@c42d000 {
> >>
> >> Hmm looks different than reg.
> >>
> >>> +			compatible = "qcom,spmi-pmic-arb";
> >>> +			reg = <0 0x0c400000 0 0x00003000>,
> >>> +			      <0 0x0c500000 0 0x00400000>,
> >>> +			      <0 0x0c440000 0 0x00080000>,
> >>> +			      <0 0x0c4c0000 0 0x00010000>,
> >>> +			      <0 0x0c42d000 0 0x00010000>;
> >> x
> > Hm, my guess would be that Vinod chose to put the "cnfg" reg
> > instead of "core" in the unit address, as 8450 has 2 SPMI bus
> > hosts and they both share the core reg, so it would have been
> > impossible to have two spmi@core nodes..
> 
> Eh? SM8450 has 2 SPMI hosts both using 0x0c400000? How does that work?
> Usually address can be mapped only once.
> 

The SPMI controller does something like multi-master. The driver expects
the same region to be mapped multiple times and qcom,channel is used to
select which one each instance should operate on.

Regards,
Bjorn

> Where is the second SPMI? I cannot find it in linux-next.
> 
> 
> Best regards,
> Krzysztof
> 
