Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18049605FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJTMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJTMEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:04:38 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF7BF52
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:04:28 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id A50E81F91E;
        Thu, 20 Oct 2022 14:04:24 +0200 (CEST)
MIME-Version: 1.0
Date:   Thu, 20 Oct 2022 13:49:23 +0200
From:   konrad.dybcio@somainline.org
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
In-Reply-To: <20221020073036.16656-3-quic_ppareek@quicinc.com>
References: <20221020073036.16656-1-quic_ppareek@quicinc.com>
 <20221020073036.16656-3-quic_ppareek@quicinc.com>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <7a62dd552c02e2b83fabaf9ff55a7c6c@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-20 09:30, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, 
> RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> ---

Hi!

[...[

> +		vreg_l3c: ldo3 {
> +			regulator-name = "vreg_l3c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
Not sure if setting load is desired after recent rpmh regulator changes.

[...]

> +
> +&spmi_bus {
> +	pm8450a: pmic@0 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
Please add a pm8450[aceg].dtsi instead, as other boards would probably 
like to
reuse this. Also, move the spmi.h inclusion there.

[...]

> +};
> +
> +/* PINCTRL */
Not sure if it's useful if there's nothing there for now.

Konrad
