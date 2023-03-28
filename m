Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3046CC05F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjC1NOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjC1NN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC00AF27;
        Tue, 28 Mar 2023 06:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE336177E;
        Tue, 28 Mar 2023 13:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71742C433D2;
        Tue, 28 Mar 2023 13:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680009219;
        bh=xDV/rnXaG4zPjSk/m3uIXh8upXUA/UdagRMunPLZZX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uffR3YwJXzhxQ4+vkLQxrDU4I52FhGeDv29OrJuOBjMGdss6voJqf0/NmarBEu9Ti
         dzA4h1f7lELyA+HG/jYjO459UhplolVjRfoNtPBkhGvPgNEKKALS02SxDu+9WwdvsM
         MZvHe169bzcXUsVi0MHcbSJk0gADO37Dx52AvzJE+/ji/NuYJemsgMszbYcc6IEMtB
         eTsbaKF8oCxs4t2tq27IZTsR/kRbZOnKatOBAkQCM43JOasPhj7w1J+zpsVbA7azav
         dUMDAfnUKzd0d/S0IC384fiiLsqQ2hyOLgg/EO4NK+aYPI08yiJq+l3SfgK+L3En4k
         0ZA7vFNQiFsxQ==
Date:   Tue, 28 Mar 2023 18:43:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: Introduce the SC8180x platform
Message-ID: <ZCLn/m8GKVo7p/Ga@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-11-vkoul@kernel.org>
 <bfc64e55-3c06-e36b-70cc-33a0303681be@linaro.org>
 <ZCEr5WnbvA2jkHLn@matsya>
 <5ad54197-3638-fc75-02ee-5c285fe4dabb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad54197-3638-fc75-02ee-5c285fe4dabb@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-03-23, 10:49, Konrad Dybcio wrote:
> On 27.03.2023 07:38, Vinod Koul wrote:
> > On 25-03-23, 13:34, Konrad Dybcio wrote:

> >>> +	cpus {
> >>> +		#address-cells = <2>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		CPU0: cpu@0 {
> >>> +			device_type = "cpu";
> >>> +			compatible = "qcom,kryo485";
> >>> +			reg = <0x0 0x0>;
> >> Please add clocks = <&cpufreq_hw n>;
> >>  
> >>> +			enable-method = "psci";
> >>> +			capacity-dmips-mhz = <602>;
> >>> +			next-level-cache = <&L2_0>;
> >>> +			qcom,freq-domain = <&cpufreq_hw 0>;
> > 
> > You mean this or something else?
> Check
> 
> https://lore.kernel.org/lkml/20221102065448.GA10650@thinkpad/T/

Good point, thanks

> >>> +		compatible = "qcom,sc8180x-camnoc-virt";
> >>> +		#interconnect-cells = <2>;
> >>> +		qcom,bcm-voters = <&apps_bcm_voter>;
> >>> +	};
> >>> +
> >>> +	mc_virt: interconnect-mc-virt {
> >> Please be consistent with your naming.
> > 
> > Are you referring to adding -0 for this?
> I'm not sure which is preferred (-n vs -name), there's a mixed bag
> upstream.. Krzysztof?

Either ways this should be consistent, so camnoc_virt:
interconnect-camnoc_virt makes sense rather than arbitrary -0

> >>> +		compatible = "qcom,sc8180x-mc-virt";
> >>> +		#interconnect-cells = <2>;
> >>> +		qcom,bcm-voters = <&apps_bcm_voter>;
> >>> +	};
> >>> +
> >>> +	qup_virt: interconnect-qup-virt {
> >>> +		compatible = "qcom,sc8180x-qup-virt";
> >>> +		#interconnect-cells = <2>;
> >>> +		qcom,bcm-voters = <&apps_bcm_voter>;
> >>> +	};
> >>> +
> >> [...]
> >>
> >>> +	reserved-memory {
> >>> +		#address-cells = <2>;
> >>> +		#size-cells = <2>;
> >>> +		ranges;
> >>> +
> >>> +		hyp_mem: hyp-region@85700000 {
> >> the -region seems a bit unnecessary in all of these nodes
> > 
> > This is reserved for hyp, I think we should add it here so that we dont
> > touch this piece..?
> I meant the '-region' bit in the node names
> 
> (label: name@unit-address)

ack, thanks for clearing my misunderstanding

-- 
~Vinod
