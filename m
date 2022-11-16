Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E8B62B4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKPIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbiKPIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:17:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F391082;
        Wed, 16 Nov 2022 00:17:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 815A1B81C11;
        Wed, 16 Nov 2022 08:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15712C433C1;
        Wed, 16 Nov 2022 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668586623;
        bh=Er2R0OHPCu/SqHwwGlC8AZqdFAugjR46KzS+F4no2fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxQaJ7phIKEIzxuweMu6HVT5HJv75OXYS9qyFvdKA11dLNya/mb911JqIOwgsfstp
         qUBQV2+dcZkmHukSuv8OliobCkZaVz8ixtpnOUvYiqj3Jeunkxgg2gKdYEE67U9+Tx
         v20ir3igWk21ZlWHUBq7+9ianukRkAW+QB73G3dvYygWegE9AHLpuFgQrZWT1EQCN8
         UZQoPQ0VX4ZT0IIKwGu1dZeHpfmZwdI1CpZ5zmZdcyH1qBv9j6cwoSzicN0AE/Y3HQ
         HxLEyzn6z2mu9m84rWLwCR7PGiSTRp3yZxna0HgaA2A1sCXe6McnjHPCVFZMTfejdF
         dkAysmw4FPTyA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovDay-0003vU-JY; Wed, 16 Nov 2022 09:16:32 +0100
Date:   Wed, 16 Nov 2022 09:16:32 +0100
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
Message-ID: <Y3ScYKVYIVyj/mG0@hovoldconsulting.com>
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

> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l17c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l6c>;
> +	vccq-max-microamp = <900000>;
> +
> +	status = "disabled";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +
> +	status = "disabled";
> +};

Why are these disabled? This should be mentioned somewhere (e.g. commit
message and/or comment) or you can drop the nodes until support is in
place.

Johan
