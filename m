Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A536D7B71
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbjDELfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjDELfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87230ED;
        Wed,  5 Apr 2023 04:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43D7F638A5;
        Wed,  5 Apr 2023 11:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B23C4339B;
        Wed,  5 Apr 2023 11:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680694549;
        bh=N42vKwPQpUIupvynklxUyAnnLu6zzFjrSXXRLaZg/fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx8dsTBHCpRbuAfcq1O0Y5Fpgr1DQDue3HT7scEALTFp7pUvSQmhFdsn/Hb5ilf1M
         PC48TiFwMIBKp+DwBwds8bikkKAPYZlOS5kOZ1OoaGEfDSHN/icpl97vXVRq0DYIQd
         XOLlWb9AB+0glIS914Tpbj6m/PLMzi97oCeQYFtZDkpSmbNW5aQvcE7p0Y5ij8ll5m
         s7TzdpzxQfG07R7EGnN1W5HUbCx3ylVe0Q7eh1QAP1eUyDyUw0MLNXrn8fI+mq3xVl
         MZABA9XHORt8OvCV/sXdrR9/v8PwdqFMt5ZRQ/BpypoOW75oFJ4BRLJyjYrOa/G5rF
         xedpWfoD61n2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pk1R5-00042y-1L; Wed, 05 Apr 2023 13:36:19 +0200
Date:   Wed, 5 Apr 2023 13:36:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Message-ID: <ZC1dM3CP5sAfga16@hovoldconsulting.com>
References: <cover.1680688209.git.quic_varada@quicinc.com>
 <a66878525affbc5db9fe1423018ba6250c03ae19.1680688209.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66878525affbc5db9fe1423018ba6250c03ae19.1680688209.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:24:04PM +0530, Varadarajan Narayanan wrote:
> Add USB phy and controller related nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v7:
> 	- Change com_aux -> cfg_ahb
>  Changes in v6:
> 	- Introduce fixed regulators for the phy
> 	- Resolved all 'make dtbs_check' messages

> +		usb_0_qmpphy: phy@7d000 {
> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
> +			reg = <0x0007d000 0xa00>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
> +				 <&xo_board_clk>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&gcc GCC_USB0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "cfg_ahb",

You still did not update the binding to match this clock. So this is
essentially the third time I'm pointing out the same issue. This is
simply not acceptable.

Just slow down, and don't rush out new revisions of series before
you've had time to review them yourself (and preferably internally at
qualcomm) to make sure that you have addressed all review comments you
have received.

Maintainer and reviewer time is scarce. Our development model really
does not scale unless people take more care.

Johan
