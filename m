Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573916E0C40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjDMLOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDMLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:14:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC25BB1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:14:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id gw13so8239841wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681384476; x=1683976476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYFOuqjrRkiTqE85pHBJSzLoXaxjeLMqi19QXOUSwdw=;
        b=MJYazG3MWhBKdjCIEdwTGQIzO6R0FZi6WrHC80hSJzFz5pqTd36vWo1DtGgDjk5nrE
         PhpC7pur2CvmuvH/GUk9OgF1Pe5XtujjXhZKF0fiE5Gm0miNQT60nZI169m8H/ZqiL03
         13o80JeaHg58ALqc4BiL0ZRTd1JsAo/tsKVd7oqL/+hU85YnoXNhj1J0Nsyt8jTritLi
         oETw1t7SBxC7ade05TSsqvKrexYhSKnUaOxUnhIo9+E9UuinJeasNzgMRETl8vXdh4M7
         /767ZMSiCbbGejhG5FFaGHxpjo7WNkAT5WT560gIHNEpXU0oZWILru4JQn1WvD0BN0Ss
         6EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681384476; x=1683976476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYFOuqjrRkiTqE85pHBJSzLoXaxjeLMqi19QXOUSwdw=;
        b=lhbo/5XDUd0Hl16dI5n/1ZHjHCuaRXwbIU/NaRfCoHO69UeDcx1d5zy5iLznMVu0Nv
         pfUxCpOTsJMUBQDvtFWh6kqENsiukgCU4xpitpdFgfU7pVobcSCj/B9v0sz4GggGhkwp
         FfsqSn032WZvYWDJ9cjOxvisMn3pp1Wyk8NSLU+8VnL2rlMVvmqIYOuT30L01NfO9pdu
         rMkURDi6OcdhnoAVCAKuvQFbkeRZXGLTJj1FcLwqDfcUU0xUri21W06apDiKrfZ3fG4i
         Y4Vm3W9qjwnpPddLANsl3CUsYb6CZRLG6lb6mGwdnsM8VyT0aYJTQkh8TRKVGlJnmPqO
         nUwQ==
X-Gm-Message-State: AAQBX9f6BH994XpXW9/9aeZnijUbNQTJeoHlaRfnnSYziaAXhVztPWIP
        LlciaoOwzlqe/bAhN1lY5aIqiw==
X-Google-Smtp-Source: AKy350b2znCGr+siH4jPQbi0en+qZPDa0GzWx6fKz1SpR9vsEZKXoYvPG88NZP2AQI8DPrJ32rKuhw==
X-Received: by 2002:a05:600c:ac9:b0:3ee:7f0b:388f with SMTP id c9-20020a05600c0ac900b003ee7f0b388fmr1170036wmr.40.1681384476037;
        Thu, 13 Apr 2023 04:14:36 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id iw11-20020a05600c54cb00b003f0a96b21d3sm1152026wmb.7.2023.04.13.04.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:14:35 -0700 (PDT)
Message-ID: <ff9f6042-6e67-b96b-3a8c-4d4e129883ea@linaro.org>
Date:   Thu, 13 Apr 2023 12:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/7] soundwire: qcom: prepare for handling different
 register layouts
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
 <20230403132503.62090-6-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230403132503.62090-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2023 14:25, Krzysztof Kozlowski wrote:
> Currently the driver supports Qualcomm Soundwire controller versions
> from v1.3 till v1.7 which mostly have same register layout.  With
> coming Qualcomm Soundwire v2.0, several registers were moved and
> changed, thus a different register layout will have to be supported.
> 
> Prepare for this by:
> 1. Renaming few register defines to indicate v1.3 (earliest supported)
>     version,
> 2. Add a simple table for mapping register to its offset,
> 3. Change the code to use the mapping table.
> 
> Since only few registers differ, this solution seems easier then
> switching to regmap fields.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Reviewed-by: Srinivas Kandagagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagagatla <srinivas.kandagatla@linaro.org>

tested on RB5 and SM8450 HDK.

--srini
> 
> Changes since v1:
> 1. Fix lang typo in subject.
> ---
>   drivers/soundwire/qcom.c | 130 +++++++++++++++++++++++++++++----------
>   1 file changed, 97 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 00522de47b6f..b6666ffe37ae 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -41,7 +41,7 @@
>   #define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
>   #define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>   #define SWRM_COMP_MASTER_ID					0x104
> -#define SWRM_INTERRUPT_STATUS					0x200
> +#define SWRM_V1_3_INTERRUPT_STATUS				0x200
>   #define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
>   #define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
>   #define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
> @@ -58,20 +58,20 @@
>   #define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED_V2              BIT(14)
>   #define SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP               BIT(16)
>   #define SWRM_INTERRUPT_MAX					17
> -#define SWRM_INTERRUPT_MASK_ADDR				0x204
> -#define SWRM_INTERRUPT_CLEAR					0x208
> -#define SWRM_INTERRUPT_CPU_EN					0x210
> -#define SWRM_CMD_FIFO_WR_CMD					0x300
> -#define SWRM_CMD_FIFO_RD_CMD					0x304
> +#define SWRM_V1_3_INTERRUPT_MASK_ADDR				0x204
> +#define SWRM_V1_3_INTERRUPT_CLEAR				0x208
> +#define SWRM_V1_3_INTERRUPT_CPU_EN				0x210
> +#define SWRM_V1_3_CMD_FIFO_WR_CMD				0x300
> +#define SWRM_V1_3_CMD_FIFO_RD_CMD				0x304
>   #define SWRM_CMD_FIFO_CMD					0x308
>   #define SWRM_CMD_FIFO_FLUSH					0x1
> -#define SWRM_CMD_FIFO_STATUS					0x30C
> +#define SWRM_V1_3_CMD_FIFO_STATUS				0x30C
>   #define SWRM_RD_CMD_FIFO_CNT_MASK				GENMASK(20, 16)
>   #define SWRM_WR_CMD_FIFO_CNT_MASK				GENMASK(12, 8)
>   #define SWRM_CMD_FIFO_CFG_ADDR					0x314
>   #define SWRM_CONTINUE_EXEC_ON_CMD_IGNORE			BIT(31)
>   #define SWRM_RD_WR_CMD_RETRIES					0x7
> -#define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
> +#define SWRM_V1_3_CMD_FIFO_RD_FIFO_ADDR				0x318
>   #define SWRM_RD_FIFO_CMD_ID_MASK				GENMASK(11, 8)
>   #define SWRM_ENUMERATOR_CFG_ADDR				0x500
>   #define SWRM_ENUMERATOR_SLAVE_DEV_ID_1(m)		(0x530 + 0x8 * (m))
> @@ -97,7 +97,7 @@
>   #define SWRM_DP_BLOCK_CTRL3_BANK(n, m)	(0x1138 + 0x100 * (n - 1) + 0x40 * m)
>   #define SWRM_DP_SAMPLECTRL2_BANK(n, m)	(0x113C + 0x100 * (n - 1) + 0x40 * m)
>   #define SWRM_DIN_DPn_PCM_PORT_CTRL(n)	(0x1054 + 0x100 * (n - 1))
> -#define SWR_MSTR_MAX_REG_ADDR		(0x1740)
> +#define SWR_V1_3_MSTR_MAX_REG_ADDR				0x1740
>   
>   #define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
>   #define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
> @@ -143,10 +143,28 @@ struct qcom_swrm_port_config {
>   	u8 lane_control;
>   };
>   
> +/*
> + * Internal IDs for different register layouts.  Only few registers differ per
> + * each variant, so the list of IDs below does not include all of registers.
> + */
> +enum {
> +	SWRM_REG_FRAME_GEN_ENABLED,
> +	SWRM_REG_INTERRUPT_STATUS,
> +	SWRM_REG_INTERRUPT_MASK_ADDR,
> +	SWRM_REG_INTERRUPT_CLEAR,
> +	SWRM_REG_INTERRUPT_CPU_EN,
> +	SWRM_REG_CMD_FIFO_WR_CMD,
> +	SWRM_REG_CMD_FIFO_RD_CMD,
> +	SWRM_REG_CMD_FIFO_STATUS,
> +	SWRM_REG_CMD_FIFO_RD_FIFO_ADDR,
> +};
> +
>   struct qcom_swrm_ctrl {
>   	struct sdw_bus bus;
>   	struct device *dev;
>   	struct regmap *regmap;
> +	u32 max_reg;
> +	const unsigned int *reg_layout;
>   	void __iomem *mmio;
>   	struct reset_control *audio_cgcr;
>   #ifdef CONFIG_DEBUG_FS
> @@ -187,22 +205,42 @@ struct qcom_swrm_data {
>   	u32 default_cols;
>   	u32 default_rows;
>   	bool sw_clk_gate_required;
> +	u32 max_reg;
> +	const unsigned int *reg_layout;
> +};
> +
> +static const unsigned int swrm_v1_3_reg_layout[] = {
> +	[SWRM_REG_FRAME_GEN_ENABLED] = SWRM_COMP_STATUS,
> +	[SWRM_REG_INTERRUPT_STATUS] = SWRM_V1_3_INTERRUPT_STATUS,
> +	[SWRM_REG_INTERRUPT_MASK_ADDR] = SWRM_V1_3_INTERRUPT_MASK_ADDR,
> +	[SWRM_REG_INTERRUPT_CLEAR] = SWRM_V1_3_INTERRUPT_CLEAR,
> +	[SWRM_REG_INTERRUPT_CPU_EN] = SWRM_V1_3_INTERRUPT_CPU_EN,
> +	[SWRM_REG_CMD_FIFO_WR_CMD] = SWRM_V1_3_CMD_FIFO_WR_CMD,
> +	[SWRM_REG_CMD_FIFO_RD_CMD] = SWRM_V1_3_CMD_FIFO_RD_CMD,
> +	[SWRM_REG_CMD_FIFO_STATUS] = SWRM_V1_3_CMD_FIFO_STATUS,
> +	[SWRM_REG_CMD_FIFO_RD_FIFO_ADDR] = SWRM_V1_3_CMD_FIFO_RD_FIFO_ADDR,
>   };
>   
>   static const struct qcom_swrm_data swrm_v1_3_data = {
>   	.default_rows = 48,
>   	.default_cols = 16,
> +	.max_reg = SWR_V1_3_MSTR_MAX_REG_ADDR,
> +	.reg_layout = swrm_v1_3_reg_layout,
>   };
>   
>   static const struct qcom_swrm_data swrm_v1_5_data = {
>   	.default_rows = 50,
>   	.default_cols = 16,
> +	.max_reg = SWR_V1_3_MSTR_MAX_REG_ADDR,
> +	.reg_layout = swrm_v1_3_reg_layout,
>   };
>   
>   static const struct qcom_swrm_data swrm_v1_6_data = {
>   	.default_rows = 50,
>   	.default_cols = 16,
>   	.sw_clk_gate_required = true,
> +	.max_reg = SWR_V1_3_MSTR_MAX_REG_ADDR,
> +	.reg_layout = swrm_v1_3_reg_layout,
>   };
>   
>   #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
> @@ -286,7 +324,8 @@ static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *ctrl)
>   
>   	do {
>   		/* Check for fifo underflow during read */
> -		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +			       &value);
>   		fifo_outstanding_data = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
>   
>   		/* Check if read data is available in read fifo */
> @@ -311,7 +350,8 @@ static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *ctrl)
>   
>   	do {
>   		/* Check for fifo overflow during write */
> -		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +			       &value);
>   		fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
>   
>   		/* Check for space in write fifo before writing */
> @@ -353,7 +393,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
>   		reinit_completion(&ctrl->broadcast);
>   
>   	/* Its assumed that write is okay as we do not get any status back */
> -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
> +	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_WR_CMD], val);
>   
>   	if (ctrl->version <= SWRM_VERSION_1_3_0)
>   		usleep_range(150, 155);
> @@ -392,7 +432,7 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>   
>   	/* wait for FIFO RD to complete to avoid overflow */
>   	usleep_range(100, 105);
> -	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
> +	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_RD_CMD], val);
>   	/* wait for FIFO RD CMD complete to avoid overflow */
>   	usleep_range(250, 255);
>   
> @@ -400,7 +440,8 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>   		return SDW_CMD_FAIL_OTHER;
>   
>   	do {
> -		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
> +		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_CMD_FIFO_RD_FIFO_ADDR],
> +			       &cmd_data);
>   		rval[0] = cmd_data & 0xFF;
>   		cmd_id = FIELD_GET(SWRM_RD_FIFO_CMD_ID_MASK, cmd_data);
>   
> @@ -410,7 +451,9 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>   				usleep_range(500, 505);
>   				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD,
>   						SWRM_CMD_FIFO_FLUSH);
> -				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
> +				ctrl->reg_write(ctrl,
> +						ctrl->reg_layout[SWRM_REG_CMD_FIFO_RD_CMD],
> +						val);
>   			}
>   			retry_attempt++;
>   		} else {
> @@ -564,7 +607,8 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   	int ret = IRQ_HANDLED;
>   	clk_prepare_enable(ctrl->hclk);
>   
> -	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &intr_sts);
> +	ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
> +		       &intr_sts);
>   	intr_sts_masked = intr_sts & ctrl->intr_mask;
>   
>   	do {
> @@ -602,29 +646,39 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   						"%s: SWR bus clsh detected\n",
>   						__func__);
>   				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -				ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +				ctrl->reg_write(ctrl,
> +						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +						ctrl->intr_mask);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW:
> -				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				ctrl->reg_read(ctrl,
> +					       ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +					       &value);
>   				dev_err_ratelimited(ctrl->dev,
>   					"%s: SWR read FIFO overflow fifo status 0x%x\n",
>   					__func__, value);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW:
> -				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				ctrl->reg_read(ctrl,
> +					       ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +					       &value);
>   				dev_err_ratelimited(ctrl->dev,
>   					"%s: SWR read FIFO underflow fifo status 0x%x\n",
>   					__func__, value);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW:
> -				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				ctrl->reg_read(ctrl,
> +					       ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +					       &value);
>   				dev_err(ctrl->dev,
>   					"%s: SWR write FIFO overflow fifo status %x\n",
>   					__func__, value);
>   				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_CMD_ERROR:
> -				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				ctrl->reg_read(ctrl,
> +					       ctrl->reg_layout[SWRM_REG_CMD_FIFO_STATUS],
> +					       &value);
>   				dev_err_ratelimited(ctrl->dev,
>   					"%s: SWR CMD error, fifo status 0x%x, flushing fifo\n",
>   					__func__, value);
> @@ -636,7 +690,8 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   						__func__);
>   				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
>   				ctrl->reg_write(ctrl,
> -					SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +						ctrl->intr_mask);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH:
>   				dev_err_ratelimited(ctrl->dev,
> @@ -645,7 +700,8 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   				ctrl->intr_mask &=
>   					~SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH;
>   				ctrl->reg_write(ctrl,
> -					SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +						ctrl->intr_mask);
>   				break;
>   			case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
>   				complete(&ctrl->broadcast);
> @@ -664,8 +720,10 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>   				break;
>   			}
>   		}
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, intr_sts);
> -		ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &intr_sts);
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
> +				intr_sts);
> +		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
> +			       &intr_sts);
>   		intr_sts_masked = intr_sts & ctrl->intr_mask;
>   	} while (intr_sts_masked);
>   
> @@ -690,7 +748,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>   
>   	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
>   	/* Mask soundwire interrupts */
> -	ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
> +	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
>   			SWRM_INTERRUPT_STATUS_RMSK);
>   
>   	/* Configure No pings */
> @@ -723,7 +781,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>   
>   	/* enable CPU IRQs */
>   	if (ctrl->mmio) {
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN,
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
>   				SWRM_INTERRUPT_STATUS_RMSK);
>   	}
>   	ctrl->slave_status = 0;
> @@ -1312,7 +1370,7 @@ static int swrm_reg_show(struct seq_file *s_file, void *data)
>   		return ret;
>   	}
>   
> -	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
> +	for (reg = 0; reg <= ctrl->max_reg; reg += 4) {
>   		ctrl->reg_read(ctrl, reg, &reg_val);
>   		seq_printf(s_file, "0x%.3x: 0x%.2x\n", reg, reg_val);
>   	}
> @@ -1340,6 +1398,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	data = of_device_get_match_data(dev);
> +	ctrl->max_reg = data->max_reg;
> +	ctrl->reg_layout = data->reg_layout;
>   	ctrl->rows_index = sdw_find_row_index(data->default_rows);
>   	ctrl->cols_index = sdw_find_col_index(data->default_cols);
>   #if IS_REACHABLE(CONFIG_SLIMBUS)
> @@ -1556,12 +1616,14 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>   		} else {
>   			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
>   		}
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
>   			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
>   
>   		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +				ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +				ctrl->intr_mask);
>   
>   		usleep_range(100, 105);
>   		if (!swrm_wait_for_frame_gen_enabled(ctrl))
> @@ -1583,8 +1645,10 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
>   	if (!ctrl->clock_stop_not_supported) {
>   		/* Mask bus clash interrupt */
>   		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR, ctrl->intr_mask);
> -		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +				ctrl->intr_mask);
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +				ctrl->intr_mask);
>   		/* Prepare slaves for clock stop */
>   		ret = sdw_bus_prep_clk_stop(&ctrl->bus);
>   		if (ret < 0 && ret != -ENODATA) {
