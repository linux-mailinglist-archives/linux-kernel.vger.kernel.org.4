Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750D05BF6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIUGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiIUGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:51:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8542A417;
        Tue, 20 Sep 2022 23:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE4FB8236B;
        Wed, 21 Sep 2022 06:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45609C433C1;
        Wed, 21 Sep 2022 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663743094;
        bh=uylYBidHXUKvld2mr2PA6RP6gS5s9VAMXhoLewWP3kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgSx/xXd6i1h++aAxUgPHuMIzPZcmtyT4N7R5ep3aFsdYZ62kxKSboqwe6YAckgM8
         jplr33MT7pVin9s6JhVOJFc3E7HdDKl4cJCwnyRuljNqAtHkMcvfu9GsVpNPGlMVZ1
         EcFc4gczAIpR2H8NIfoXPbqflrDiylMkjQiI87FxVE5oL4wjfnwZoSVfnLbi/7AAcS
         lUf9q9L7YAtVSJy30HPNmvYcRtNLxfgyt219LNQPGVwAgO9VwESqxqnTdR8SHk3f43
         ws1UXTkj98YD9OeTgT3LlJCiSZZZIg0A2lzlNUjvL5xJek2RYAOwV7K1wEG2QLEQsH
         z4mzTM7kq7T+A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oata0-0003c5-8o; Wed, 21 Sep 2022 08:51:32 +0200
Date:   Wed, 21 Sep 2022 08:51:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: introduce sa8540p-ride dts
Message-ID: <Yyq0dFvCI54QMqAl@hovoldconsulting.com>
References: <20220920120802.14321-1-quic_ppareek@quicinc.com>
 <20220920120802.14321-4-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920120802.14321-4-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:38:02PM +0530, Parikshit Pareek wrote:
> Create new dts file specific for Qdrive board based on sa8540p chipset.
> Introduce common dtsi file sa8295p-adp.dtsi, to be included for adp and
> Qdrive board.
> 
> This is quite similar to sa8295 ADP development board. Main differences
> are related to connectors, and interface cards, like USB external ports,
> ethernet-switch, and PCIe switch etc.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Reported-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---

> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> new file mode 100644
> index 000000000000..bd79866b80e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8540p-adp.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8540 ADP";
> +	compatible = "qcom,sa8540p-adp-ride", "qcom,sa8540p";
> +};
> +
> +&ufs_card_hc {
> +	status = "disabled";
> +};

What about the UFS phy, etc?

This opt-out scheme seems quite fragile.

> +&usb_1 {
> +	status = "disabled";
> +};
> +
> +&usb_1_hsphy {
> +	status = "disabled";
> +};
> +
> +&usb_1_qmpphy {
> +	status = "disabled";
> +};

Johan
