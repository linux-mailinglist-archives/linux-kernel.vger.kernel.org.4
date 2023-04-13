Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3769C6E0C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDML1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDML1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:27:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1DC93EF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:27:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso12888236wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681385229; x=1683977229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJW5NHo/QPcykd5BCK4vJpi8upKIoUXMAlL+loG6WsQ=;
        b=busheVbmsbOciPMNFFMpxrEYjG0sp/27ZyUrsq74AC+/grTwEeD9Xu/KyLIMDyWWO2
         GJ83ZmRCE40yP4WoxyKuKWeuuj7DwnjQKMtSeCd0HYKiVEdPB72/i7yDHfW9ZIy1itLJ
         ps5pCXZhpEKpjqX3rjd8A7ajkfbRTYeYxPSTfwBJtRKWJZcW97xBznhPQqhnqv0JJOav
         qezIuYFm0n2UsYsSwW+akoxwDH0F3RNzjOyk06psI62dovXcqQaOsAzaAWKCZ62FMxdk
         jiM5i32rPPxFXUuoUtlBkL2hMjHrKKMWfKDuDgHqnPF+QLppzjQPYkYuxPNqhajQZxrZ
         CL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681385229; x=1683977229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJW5NHo/QPcykd5BCK4vJpi8upKIoUXMAlL+loG6WsQ=;
        b=IUcjk1DjvWmnB0jW2Vg1PjFN2xCEXALnskJzruoW9Z7XXmwG9b08BiJ1uaGWNDWZAv
         iqvzc/7flcJ33zJNVgcI7M4v71vcVhXBDCOTQzr21aO015K4A1PJwyogMTlCu20vZAwr
         oXywZr36TOQ2twYjOtpyFbu3sy99gnMquifjWN5LeBwZLnCY+fjiuQoT2l5GbE7PZ5YD
         pLbCorPJiV5GBt5Gh4X9+xp7GcaxOtaUWQXe6X29IZTAIaHiyANSBoHWBxIWfdFNdMoO
         0Y+GSUZUVcUo2ENJYrPtwQtOpk8EQbQY55iXraIfLjg16lByeZStsePxhq2FX4nigqcg
         IIYg==
X-Gm-Message-State: AAQBX9d6AA3nmgU5E6zRz8PMt/VYSVzrTjF/+BmTTnPwBwBbVDUg26Wt
        yRjh7G81u0y8cmcNIp/jihlGeQ==
X-Google-Smtp-Source: AKy350bngAl5vHFm2q4k0NEFhDNFXI+yvhiG0R07+MaG2x5e5803II3b38fmMpprZrK4KAxF7mje0Q==
X-Received: by 2002:a7b:cbcc:0:b0:3ed:eab9:976a with SMTP id n12-20020a7bcbcc000000b003edeab9976amr1175763wmi.5.1681385229537;
        Thu, 13 Apr 2023 04:27:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c350f00b003ee9f396dcesm5293612wmq.30.2023.04.13.04.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:27:08 -0700 (PDT)
Message-ID: <f2f1871c-38f1-52b0-d90d-d1f263048606@linaro.org>
Date:   Thu, 13 Apr 2023 12:27:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/7] soundwire: qcom: add support for v2.0.0 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-7-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230403132503.62090-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2023 14:25, Krzysztof Kozlowski wrote:
> Add support for Qualcomm Soundwire Controller with a bit different
> register layout.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/soundwire/qcom.c | 65 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 57 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b6666ffe37ae..f2e1135ef113 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -31,6 +31,7 @@
>   #define SWRM_VERSION_1_3_0					0x01030000
>   #define SWRM_VERSION_1_5_1					0x01050001
>   #define SWRM_VERSION_1_7_0					0x01070000
> +#define SWRM_VERSION_2_0_0					0x02000000
>   #define SWRM_COMP_HW_VERSION					0x00
>   #define SWRM_COMP_CFG_ADDR					0x04
>   #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
> @@ -42,6 +43,7 @@
>   #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>   #define SWRM_COMP_MASTER_ID					0x104
>   #define SWRM_V1_3_INTERRUPT_STATUS				0x200
> +#define SWRM_V2_0_INTERRUPT_STATUS				0x5000
>   #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
>   #define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
>   #define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
> @@ -54,24 +56,32 @@
>   #define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
>   #define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
>   #define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(11)
> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(12)
>   #define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2             BIT(13)
>   #define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
>   #define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
>   #define SWRM_INTERRUPT_MAX					17
>   #define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
>   #define SWRM_V1_3_INTERRUPT_CLEAR				0x208
> +#define SWRM_V2_0_INTERRUPT_CLEAR				0x5008
>   #define SWRM_V1_3_INTERRUPT_CPU_EN				0x210
> +#define SWRM_V2_0_INTERRUPT_CPU_EN				0x5004
>   #define SWRM_V1_3_CMD_FIFO_WR_CMD				0x300
> +#define SWRM_V2_0_CMD_FIFO_WR_CMD				0x5020
>   #define SWRM_V1_3_CMD_FIFO_RD_CMD				0x304
> +#define SWRM_V2_0_CMD_FIFO_RD_CMD				0x5024
>   #define SWRM_CMD_FIFO_CMD					0x308
>   #define SWRM_CMD_FIFO_FLUSH					0x1
>   #define SWRM_V1_3_CMD_FIFO_STATUS				0x30C
> +#define SWRM_V2_0_CMD_FIFO_STATUS				0x5050
>   #define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
>   #define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
>   #define SWRM_CMD_FIFO_CFG_ADDR					0x314
>   #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>   #define SWRM_RD_WR_CMD_RETRIES					0x7
>   #define SWRM_V1_3_CMD_FIFO_RD_FIFO_ADDR				0x318
> +#define SWRM_V2_0_CMD_FIFO_RD_FIFO_ADDR				0x5040
>   #define SWRM_RD_FIFO_CMD_ID_MASK				GENMASK(11, 8)
>   #define SWRM_ENUMERATOR_CFG_ADDR				0x500
>   #define SWRM_ENUMERATOR_SLAVE_DEV_ID_1(m)		(0x530 + 0x8 * (m))
> @@ -98,6 +108,11 @@
>   #define SWRM_DP_SAMPLECTRL2_BANK(n, m)	(0x113C + 0x100 * (n - 1) + 0x40 * m)
>   #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
>   #define SWR_V1_3_MSTR_MAX_REG_ADDR				0x1740
> +#define SWR_V2_0_MSTR_MAX_REG_ADDR				0x50ac
> +
> +#define SWRM_V2_0_CLK_CTRL					0x5060
> +#define SWRM_V2_0_CLK_CTRL_CLK_START				BIT(0)
> +#define SWRM_V2_0_LINK_STATUS					0x5064
>   
>   #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
>   #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
> @@ -243,6 +258,26 @@ static const struct qcom_swrm_data swrm_v1_6_data = {
>   	.reg_layout = swrm_v1_3_reg_layout,
>   };
>   
> +static const unsigned int swrm_v2_0_reg_layout[] = {
> +	[SWRM_REG_FRAME_GEN_ENABLED] = SWRM_V2_0_LINK_STATUS,
> +	[SWRM_REG_INTERRUPT_STATUS] = SWRM_V2_0_INTERRUPT_STATUS,
> +	[SWRM_REG_INTERRUPT_MASK_ADDR] = 0, /* Not present */
> +	[SWRM_REG_INTERRUPT_CLEAR] = SWRM_V2_0_INTERRUPT_CLEAR,
> +	[SWRM_REG_INTERRUPT_CPU_EN] = SWRM_V2_0_INTERRUPT_CPU_EN,
> +	[SWRM_REG_CMD_FIFO_WR_CMD] = SWRM_V2_0_CMD_FIFO_WR_CMD,
> +	[SWRM_REG_CMD_FIFO_RD_CMD] = SWRM_V2_0_CMD_FIFO_RD_CMD,
> +	[SWRM_REG_CMD_FIFO_STATUS] = SWRM_V2_0_CMD_FIFO_STATUS,
> +	[SWRM_REG_CMD_FIFO_RD_FIFO_ADDR] = SWRM_V2_0_CMD_FIFO_RD_FIFO_ADDR,
> +};
> +
> +static const struct qcom_swrm_data swrm_v2_0_data = {
> +	.default_rows = 50,
> +	.default_cols = 16,
> +	.sw_clk_gate_required = true,
> +	.max_reg = SWR_V2_0_MSTR_MAX_REG_ADDR,
> +	.reg_layout = swrm_v2_0_reg_layout,
> +};
> +
>   #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
>   
>   static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
> @@ -748,18 +783,23 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>   
>   	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
>   	/* Mask soundwire interrupts */
> -	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> -			SWRM_INTERRUPT_STATUS_RMSK);
> +	if (ctrl->version < SWRM_VERSION_2_0_0)
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +				SWRM_INTERRUPT_STATUS_RMSK);
>   
>   	/* Configure No pings */
>   	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
>   	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>   	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>   
> -	if (ctrl->version >= SWRM_VERSION_1_7_0) {
> +	if (ctrl->version == SWRM_VERSION_1_7_0) {
>   		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>   		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>   				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
> +	} else if (ctrl->version >= SWRM_VERSION_2_0_0) {

we can move this to a proper switch case rather than if else's

--srini

> +		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
> +		ctrl->reg_write(ctrl, SWRM_V2_0_CLK_CTRL,
> +				SWRM_V2_0_CLK_CTRL_CLK_START);
>   	} else {
>   		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>   	}
> @@ -1609,10 +1649,14 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>   	} else {
>   		reset_control_reset(ctrl->audio_cgcr);
>   
> -		if (ctrl->version >= SWRM_VERSION_1_7_0) {
> +		if (ctrl->version == SWRM_VERSION_1_7_0) {
>   			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>   			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>   					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
> +		} else if (ctrl->version >= SWRM_VERSION_2_0_0) {
> +			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
> +			ctrl->reg_write(ctrl, SWRM_V2_0_CLK_CTRL,
> +					SWRM_V2_0_CLK_CTRL_CLK_START);
>   		} else {
>   			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>   		}
> @@ -1620,8 +1664,10 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>   			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
>   
>   		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> -				ctrl->intr_mask);
> +		if (ctrl->version < SWRM_VERSION_2_0_0)
> +			ctrl->reg_write(ctrl,
> +					ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +					ctrl->intr_mask);
>   		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
>   				ctrl->intr_mask);
>   
> @@ -1645,8 +1691,10 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>   	if (!ctrl->clock_stop_not_supported) {
>   		/* Mask bus clash interrupt */
>   		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> -				ctrl->intr_mask);
> +		if (ctrl->version < SWRM_VERSION_2_0_0)
> +			ctrl->reg_write(ctrl,
> +					ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +					ctrl->intr_mask);
>   		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
>   				ctrl->intr_mask);
>   		/* Prepare slaves for clock stop */
> @@ -1684,6 +1732,7 @@ static const struct of_device_id qcom_swrm_of_match[] = {
>   	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>   	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
>   	{ .compatible = "qcom,soundwire-v1.7.0", .data = &swrm_v1_5_data },
> +	{ .compatible = "qcom,soundwire-v2.0.0", .data = &swrm_v2_0_data },
>   	{/* sentinel */},
>   };
>   
