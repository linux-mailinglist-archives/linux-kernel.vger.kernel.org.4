Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5781613F95
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJaVMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJaVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:12:12 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCE91402D;
        Mon, 31 Oct 2022 14:12:11 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.156.neoplus.adsl.tpnet.pl [95.49.29.156])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DA59E3EBDD;
        Mon, 31 Oct 2022 22:12:08 +0100 (CET)
Message-ID: <e26c93ed-ae42-c508-d1c8-a2e40416b296@somainline.org>
Date:   Mon, 31 Oct 2022 22:12:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 01/10] arm64: dts: qcom: sm6350: Add resets for SDHCI 1/2
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221030073232.22726-1-marijn.suijten@somainline.org>
 <20221030073232.22726-2-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221030073232.22726-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.10.2022 08:32, Marijn Suijten wrote:
> Make sure the SDHCI hardware is properly reset before interacting with
> it, to protect against any possibly indeterminate state left by the
> bootloader.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index c39de7d3ace0..a3ae765d9781 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -490,6 +490,7 @@ sdhc_1: mmc@7c4000 {
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC1_BCR>;
>  			qcom,dll-config = <0x000f642c>;
>  			qcom,ddr-config = <0x80040868>;
>  			power-domains = <&rpmhpd SM6350_CX>;
> @@ -1068,6 +1069,7 @@ sdhc_2: mmc@8804000 {
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "iface", "core", "xo";
> +			resets = <&gcc GCC_SDCC2_BCR>;
>  			interconnects = <&aggre2_noc MASTER_SDCC_2 0 &clk_virt SLAVE_EBI_CH0 0>,
>  					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_SDCC_2 0>;
>  			interconnect-names = "sdhc-ddr", "cpu-sdhc";
