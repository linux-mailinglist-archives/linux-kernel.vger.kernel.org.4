Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A062B856
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiKPK3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKPK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:29:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B194D2FC19;
        Wed, 16 Nov 2022 02:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3A361BFB;
        Wed, 16 Nov 2022 10:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ED3C433D7;
        Wed, 16 Nov 2022 10:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668594348;
        bh=sRkzPw2tQ0bFhCiQdFtyKxy2q3DB99dBo/dIdUpImyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzNgl2XvWlYUH5ldwswLfJHn7kdmaLJCLdIXDegIkkwwceUN708LMCKN+/sYttXkc
         C/M1lX1BjFe9eVAAA5IuN6inrCIbgKD7gk8h/lwNN7T1EgnHeBzdms8QAcmv3X+WYp
         ekzCoLQjczHOCjul90Prl5XyFbUd7noCsdofXLYLtLO39QLFt2c2Va8oMR/S9VA4Z3
         IvyUsAXmrCbFAtSmTeOOFNjc4f1PGjU2ARq27BfUSsWHcNxOmrnos+TFjKXkgbBTSL
         O4OVGk9W+QZnOqG1i9/3GC60waj3Ba5onlXql3gauih1jVXzd61PpAlDdekcdWSh5P
         4Nd/AhgqiSpzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovFba-0001Ie-NS; Wed, 16 Nov 2022 11:25:18 +0100
Date:   Wed, 16 Nov 2022 11:25:18 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v8 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <Y3S6joPSdF37r4li@hovoldconsulting.com>
References: <20221116075207.32363-1-quic_ppareek@quicinc.com>
 <20221116075207.32363-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116075207.32363-3-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:22:07PM +0530, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
> been created for PMIC, so that it can be used for future SA8540P based
> boards.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Brian Masney <bmasney@redhat.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Tested-by: Eric Chanudet <echanude@redhat.com>
> Reviewed-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/pm8450a.dtsi     |  77 ++++++++
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 221 ++++++++++++++++++++++
>  3 files changed, 299 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8450a.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> 
> +&apps_rsc {
> +	regulators-0 {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";

> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;

The indentation here is off, but I noticed that you've probably just
copied that from the existing devicetree sources. I just sent a couple
of patches to clean that up:

	https://lore.kernel.org/lkml/20221116102054.4673-1-johan+linaro@kernel.org/

You can drop the first newline and indent the continuation line properly
using tabs (and spaces).

> +			regulator-allow-set-load;
> +		};

> +		vreg_l17c: ldo17 {
> +			regulator-name = "vreg_l17c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allowed-modes =
> +			    <RPMH_REGULATOR_MODE_LPM
> +			     RPMH_REGULATOR_MODE_HPM>;

Here too.

> +			regulator-allow-set-load;
> +		};
> +	};

Johan
