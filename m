Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8388760E012
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiJZLzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiJZLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0DAA3EB;
        Wed, 26 Oct 2022 04:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAFCC61E5A;
        Wed, 26 Oct 2022 11:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0715FC433C1;
        Wed, 26 Oct 2022 11:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666785345;
        bh=Pxq8mKgAK7SZAZtzyx61wd600ewnbz1pLQkko6CDjTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6/QtF3fFCUuWmwUKxrYcRcA6N0lYc5vViotYovq85s6jDR1tNz4nDlr7ZC9MVDLW
         IPyVR+vO4jvjoKcA7M0i3ATj/8WXUxMvDOTeybKTYbBSrBA3j0IZDZ1cjD6l6wGana
         5vY54Bs9jtIx+WSJStpXQJCICctEerYmTOK3AlFDYumfMDA9K0OB8uRA5w06h9/GEp
         C9x4yNNApzvieaUg+hoXyvWDbgP3jXK5cZfRbrr8QbdpBanYbZcivXKvQGIQdTo+kD
         ukbX3F1tkPUEfAHnrU/3obYq+hATgSg1/RNoVPs9B5UuyXh9M2TowYim0F/hh94iUn
         XGQb4YXtM5xaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1onf0J-0007FN-VE; Wed, 26 Oct 2022 13:55:28 +0200
Date:   Wed, 26 Oct 2022 13:55:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] arm64: dts: qcom: sc8280xp: Define some of the
 display blocks
Message-ID: <Y1kgL9YuIXoViSFD@hovoldconsulting.com>
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-11-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026032624.30871-11-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 08:26:22PM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Define the display clock controllers, the MDSS instances, the DP phys
> and connect these together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - New patch on list
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 838 +++++++++++++++++++++++++
>  1 file changed, 838 insertions(+)

> +				mdss0_mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-200000000 {
> +						opp-hz = /bits/ 64 <200000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-300000000 {
> +						opp-hz = /bits/ 64 <300000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-500000000 {
> +						opp-hz = /bits/ 64 <500000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +					opp-600000000 {

Super nit: missing newline between entries (I only noticed when rebasing
the external DP support on top).

> +						opp-hz = /bits/ 64 <600000000>;
> +						required-opps = <&rpmhpd_opp_turbo_l1>;
> +					};
> +				};
> +			};

> +				mdss1_mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-200000000 {
> +						opp-hz = /bits/ 64 <200000000>;
> +						required-opps = <&rpmhpd_opp_low_svs>;
> +					};
> +
> +					opp-300000000 {
> +						opp-hz = /bits/ 64 <300000000>;
> +						required-opps = <&rpmhpd_opp_svs>;
> +					};
> +
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-500000000 {
> +						opp-hz = /bits/ 64 <500000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +					opp-600000000 {
> +						opp-hz = /bits/ 64 <600000000>;
> +						required-opps = <&rpmhpd_opp_turbo_l1>;
> +					};

Ditto.

> +				};
> +			};

Johan
