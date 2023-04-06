Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94E6DA363
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbjDFUgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbjDFUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:36:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FAD51A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:33:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d7so7325979lfj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680813212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dONEmhUJMhKYFyZCBXcrCjLm9T5FLjoW/K6qSBrVWs8=;
        b=iXhYZHOsYYYByLIA54EIRN5iC1g9jRD/H4vcAjIRVUNPxfUo6SjOyNgbGDjm5sAiue
         jubnPKPMjjmxtQDKeS6mmlRhRjIeQSZDA4Rnevei6eELX0UwkBaUiDD2557RfOvIOigA
         JdOK7tx8C8ejzaAS2c7nWwtYXa5VL0eD9o9LU8aiMDgKiXYeIIzK3EuDFoVOF8EFvdiB
         gKuF94X6obIasywVx+EVNlehhtOsuqTLkcYMDSE1HXVQBw5WLu7kPOVGuSvG1FrMifII
         CQPNSnE7Q8gFxF0RqHkN36Ts//vYU5rzFrqjMvRP9VOYZVsjOBO/y/YB32JSEtvlQbnv
         9gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813212;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dONEmhUJMhKYFyZCBXcrCjLm9T5FLjoW/K6qSBrVWs8=;
        b=nq+tMLqnBtJ+bn7xhUqpk+tuUVGXS94wHV1569YElImiFDasIh0kmjgZWjyYjm8/I2
         86QLMR2aVdh9xKwbG+Lbw0pb8oLtf6B4gRptXCzLpEjFCRq4/puGzbZYVOPeEdNbEn8R
         UCQrd+sHogu7Md16z1dttjmBf3QCUwv5HRGPDA3OSuvQuw6vVQcU9gfjGMC5wJ7Ycb2O
         G2zwQY8vGYjmTExrwmhNoRFZR0I/GwaMZzmg4a+zaJ/HOPNLdmSSGVUYKM4puDzolhZk
         0CiPJ4hp09Zm38HG+rvwPvyEp3Tl8lZ2uhvUkFuXJKASmhzb+std8koM1wBfWOrk8WvI
         CRQQ==
X-Gm-Message-State: AAQBX9fIrsBILqsA/w6wJkMYbs2rtI0np4mr3/p/udC1VWjPsCEW/Tv3
        4bX4MfjU+yw4eOMBIa7y144nrg==
X-Google-Smtp-Source: AKy350aK+D04bDPlVQe02bcm3DZA2ygZJUKZhuGRc1v3vQWp0mlWlfT3uHMd/Rqq0oinC0UjePn6Ew==
X-Received: by 2002:a05:6512:3ca6:b0:4dc:8049:6f36 with SMTP id h38-20020a0565123ca600b004dc80496f36mr1912599lfv.1.1680813212065;
        Thu, 06 Apr 2023 13:33:32 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id d13-20020ac24c8d000000b004db3d57c3a8sm405663lfl.96.2023.04.06.13.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 13:33:31 -0700 (PDT)
Message-ID: <9f4cb333-bea0-0849-e8a6-dd96cb09bdbd@linaro.org>
Date:   Thu, 6 Apr 2023 22:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sa8775p: add UFS nodes
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230406194703.495836-1-brgl@bgdev.pl>
 <20230406194703.495836-5-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406194703.495836-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 21:47, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add nodes for the UFS and its PHY on sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 58 +++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 2343df7e0ea4..5de0fbbe9752 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -585,6 +585,64 @@ &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
>  			};
>  		};
>  
> +		ufs_mem_hc: ufs@1d84000 {
> +			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
> +			reg = <0x0 0x01d84000 0x0 0x3000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +			phys = <&ufs_mem_phy>;
> +			phy-names = "ufsphy";
> +			lanes-per-direction = <2>;
> +			#reset-cells = <1>;
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +			iommus = <&apps_smmu 0x100 0x0>;
> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
> +			clock-names = "core_clk",
> +				      "bus_aggr_clk",
> +				      "iface_clk",
> +				      "core_clk_unipro",
> +				      "ref_clk",
> +				      "tx_lane0_sync_clk",
> +				      "rx_lane0_sync_clk",
> +				      "rx_lane1_sync_clk";
> +			freq-table-hz = <75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<75000000 300000000>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>,
> +					<0 0>;
> +			status = "disabled";
> +		};
> +
> +		ufs_mem_phy: phy@1d87000 {
> +			compatible = "qcom,sa8775p-qmp-ufs-phy";
> +			reg = <0x0 0x01d87000 0x0 0xe10>;
> +			/*
> +			 * Yes, GCC_EDP_REF_CLKREF_EN is correct in qref. It
> +			 * enables the CXO clock to eDP *and* UFS PHY.
> +			 */
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&gcc GCC_EDP_REF_CLKREF_EN>;
> +			clock-names = "ref", "ref_aux", "qref";
> +			power-domains = <&gcc UFS_PHY_GDSC>;
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
