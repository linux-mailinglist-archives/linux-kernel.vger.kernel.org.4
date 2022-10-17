Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE16016C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJQS6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJQS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:58:20 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F332753BC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:58:18 -0700 (PDT)
Received: from cp.tophost.it (vm1054.cs12.seeweb.it [217.64.195.253])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 9D05E1F999;
        Mon, 17 Oct 2022 20:58:16 +0200 (CEST)
MIME-Version: 1.0
Date:   Mon, 17 Oct 2022 20:43:44 +0200
From:   konrad.dybcio@somainline.org
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: pmi8998: add rradc node
In-Reply-To: <20221017185609.2280067-1-caleb.connolly@linaro.org>
References: <20221017185609.2280067-1-caleb.connolly@linaro.org>
User-Agent: Roundcube Webmail/1.4.6
Message-ID: <bcfd8f7e86c74c369e40a091b11cc7d1@somainline.org>
X-Sender: konrad.dybcio@somainline.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-17 20:56, Caleb Connolly wrote:
> Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.
> 
> The RRADC reports PMIC die and skin temperatures, as well as
> battery/charger thermals. It also reports USB and DC charger voltage 
> and
> current measurements.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch introduces a new dtbs_check warning which will be fixed by
> https://lore.kernel.org/linux-arm-msm/20221017185105.2279129-1-caleb.connolly@linaro.org/
> 
> V1:
> https://lore.kernel.org/linux-arm-msm/20221016180330.1912214-1-caleb.connolly@linaro.org/
> Changes since v1:
>  * Change node name from adc@ to rradc@, see linked patch
>  * Enable the RRADC by default, rather than per-device
> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index 6d3d212560c1..95c74d88eb93 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
>  		};
> +
> +		pmi8998_rradc: rradc@4500 {
> +			compatible = "qcom,pmi8998-rradc";
> +			reg = <0x4500>;
> +			#io-channel-cells = <1>;
> +
> +			status = "okay";
No need to, it's enabled by default when you define it.

Konrad
> +		};
>  	};
> 
>  	pmi8998_lsid1: pmic@3 {
