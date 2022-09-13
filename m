Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27B5B7CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIMViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMViU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:38:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488E61B10;
        Tue, 13 Sep 2022 14:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3B4615BF;
        Tue, 13 Sep 2022 21:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D5C433D6;
        Tue, 13 Sep 2022 21:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663105098;
        bh=ySzPYixkG3ZBWTadxbOwMb02JswJwS60s+/FJORSLeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAUsbfW4VrqJc9Bkj903IaJBYN1LcigoJDj3f7V0ZVv6aFOIbqJr9X9IbdWDrhbC/
         NJugMROJ5O4cS6ZMaYaO23/e+PcLZ8jAvL/WuD7F9IoWGMdzYuFYh885S8VTdd+7fG
         FwB17x1qIwl1/jmz36XeU1M1yHHWSiofkRsiHFprL7XPBP6KOAq2kWgIdzl2mnXIkj
         JOsY5FnT6psL/3gKFa96sDyaE0DJUF9nWMbbRwc8ikN5+6p/BYjNSI9/lnusWi4FZr
         J+wPzBDAulVZoay06XMRwpVXf/Bz9RLmTb8OSPVnjD5jce7CbYXY1FhFkgpp1N81xo
         yOwoKWv1Zg1aw==
Date:   Tue, 13 Sep 2022 16:38:15 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] arm64: dts: qcom: sm6115: Add basic soc dtsi
Message-ID: <20220913213815.bvw2pro6f3mj3q6z@builder.lan>
References: <20220910143213.477261-1-iskren.chernev@gmail.com>
 <20220910143213.477261-8-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910143213.477261-8-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 05:32:11PM +0300, Iskren Chernev wrote:
[..]
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
[..]
> +
> +	smem {
> +		compatible = "qcom,smem";

Please move the compatible, qcom,rpm-msg-ram and hwlocks into the
&smem_mem node.

> +		memory-region = <&smem_mem>;
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	soc: soc {

I expect that you should be told that you're missing a @0 on your soc.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		tlmm: pinctrl@500000 {

Please sort your nodes based on address, followed by node name
alphabetically, followed by label.

> +			compatible = "qcom,sm6115-tlmm";
> +			reg = <0x500000 0x400000>, <0x900000 0x400000>, <0xd00000 0x400000>;

Please pad your address to 8 digits, to make it faster to see if the
sort order makes sense.

> +			reg-names = "west", "south", "east";
> +			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			gpio-ranges = <&tlmm 0 0 121>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
[..]
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 1 0xf08>,
> +			     <GIC_PPI 2 0xf08>,
> +			     <GIC_PPI 3 0xf08>,
> +			     <GIC_PPI 0 0xf08>;

Please use (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW) for your flags.

Regards,
Bjorn
