Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAF6D6B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjDDSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjDDSHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:07:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5059E1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:07:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s20so14497966ljp.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680631637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKGYy/lnfy+kLVObhWRLvXvnRmxbL6o7FAqb6+OXgrQ=;
        b=DbMjP6MwypN0+AIvI231crk6wvxsuu1WgEHE8k11XZwNJ4wrzM22ZnANpFzc2fIHna
         xoU+P8AQqFjdSEJUcHCaDAwXjAOKFNZjTTr4RRqxfmX5chfPkxBWkOwkg4rkGJ4qBUZP
         8YmaIFmy5Z1qX7WKMVTNSZ5J0z8bhI8Z4hWuQykH40P1zjalVw093YXWCaQpvO8Yox1+
         /lJH++B4xthR9N3fAGfyZX397SX4/YQYq/+lYqQaw9yMZRb2KOQ06KXQQTv9jOJgkgM7
         AUKntf986yXaatoMev2hFimEW1tDanBSrkmwyxDe26kjfZh2vMqA37SXRqRtlKA7Q49+
         G28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680631637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKGYy/lnfy+kLVObhWRLvXvnRmxbL6o7FAqb6+OXgrQ=;
        b=WPse7emhDod+to7sbOehLv93uq8yiPeTe3UtlBrl1uAD5FdSvkt9gdenXuMLB+wlby
         prnLLcwvZvzs1PmvZPuMyMAbesogXjb3Hy1xClyZkdFZPuUudKCLyPl+jMWfY/6ckefq
         opqmULAQ+mpjGh7rozNq7pMNnYd3z9kMFgl6AhWv6ew/MlHWRuSMW+Dq7inncHEtjdfP
         R9okF2R33DgvPFJYXbvl8FLr3sjilwgBxkftknEkEqUsMnU9n65Dpdu9IyJkprJeQkHY
         QPqdujkqVBAasBJgi9Uwp8Psp/iv3FA2TvuqbSYTOI+Sq+VSqhh0RLO1vlnMJBFl2ipJ
         GT3A==
X-Gm-Message-State: AAQBX9f36OSDY6WO/BfpshcQWeeH2wu62wxBCNdaZYdQYiGATQ2DTF4Z
        fpApzo1V0ZfJnMzPPIHoyv4UhA==
X-Google-Smtp-Source: AKy350bTRPJNdhoD8Ppp5HPZcfIS1qN1iMMfdXM1O3Ez1bpFq/GD7QD6JQ8TrFGnaqFjGD4viKhZcg==
X-Received: by 2002:a2e:9002:0:b0:29e:6d48:d8d5 with SMTP id h2-20020a2e9002000000b0029e6d48d8d5mr1151815ljg.29.1680631637323;
        Tue, 04 Apr 2023 11:07:17 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id o7-20020a2e90c7000000b002958c4e96fasm2470187ljg.3.2023.04.04.11.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:07:16 -0700 (PDT)
Message-ID: <0bd29b3e-a6c9-ff22-cfb3-1860f56b4ee5@linaro.org>
Date:   Tue, 4 Apr 2023 20:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/7] soundwire: qcom: use consistently 'ctrl' as state
 variable name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230403132503.62090-1-krzysztof.kozlowski@linaro.org>
 <20230403132503.62090-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230403132503.62090-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.04.2023 15:25, Krzysztof Kozlowski wrote:
> The pointer to 'struct qcom_swrm_ctrl' was called sometimes 'swrm' and
> sometimes 'ctrl' variable.  Choose one - 'ctrl' - so the code will be
> consistent and easier to read.
> 
> No functional change.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 168 +++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index faa091e7472a..00522de47b6f 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -279,14 +279,14 @@ static u32 swrm_get_packed_reg_val(u8 *cmd_id, u8 cmd_data,
>  	return val;
>  }
>  
> -static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *ctrl)
>  {
>  	u32 fifo_outstanding_data, value;
>  	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
>  
>  	do {
>  		/* Check for fifo underflow during read */
> -		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>  		fifo_outstanding_data = FIELD_GET(SWRM_RD_CMD_FIFO_CNT_MASK, value);
>  
>  		/* Check if read data is available in read fifo */
> @@ -297,39 +297,39 @@ static int swrm_wait_for_rd_fifo_avail(struct qcom_swrm_ctrl *swrm)
>  	} while (fifo_retry_count--);
>  
>  	if (fifo_outstanding_data == 0) {
> -		dev_err_ratelimited(swrm->dev, "%s err read underflow\n", __func__);
> +		dev_err_ratelimited(ctrl->dev, "%s err read underflow\n", __func__);
>  		return -EIO;
>  	}
>  
>  	return 0;
>  }
>  
> -static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *swrm)
> +static int swrm_wait_for_wr_fifo_avail(struct qcom_swrm_ctrl *ctrl)
>  {
>  	u32 fifo_outstanding_cmds, value;
>  	int fifo_retry_count = SWR_OVERFLOW_RETRY_COUNT;
>  
>  	do {
>  		/* Check for fifo overflow during write */
> -		swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>  		fifo_outstanding_cmds = FIELD_GET(SWRM_WR_CMD_FIFO_CNT_MASK, value);
>  
>  		/* Check for space in write fifo before writing */
> -		if (fifo_outstanding_cmds < swrm->wr_fifo_depth)
> +		if (fifo_outstanding_cmds < ctrl->wr_fifo_depth)
>  			return 0;
>  
>  		usleep_range(500, 510);
>  	} while (fifo_retry_count--);
>  
> -	if (fifo_outstanding_cmds == swrm->wr_fifo_depth) {
> -		dev_err_ratelimited(swrm->dev, "%s err write overflow\n", __func__);
> +	if (fifo_outstanding_cmds == ctrl->wr_fifo_depth) {
> +		dev_err_ratelimited(ctrl->dev, "%s err write overflow\n", __func__);
>  		return -EIO;
>  	}
>  
>  	return 0;
>  }
>  
> -static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
>  				     u8 dev_addr, u16 reg_addr)
>  {
>  
> @@ -342,20 +342,20 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  		val = swrm_get_packed_reg_val(&cmd_id, cmd_data,
>  					      dev_addr, reg_addr);
>  	} else {
> -		val = swrm_get_packed_reg_val(&swrm->wcmd_id, cmd_data,
> +		val = swrm_get_packed_reg_val(&ctrl->wcmd_id, cmd_data,
>  					      dev_addr, reg_addr);
>  	}
>  
> -	if (swrm_wait_for_wr_fifo_avail(swrm))
> +	if (swrm_wait_for_wr_fifo_avail(ctrl))
>  		return SDW_CMD_FAIL_OTHER;
>  
>  	if (cmd_id == SWR_BROADCAST_CMD_ID)
> -		reinit_completion(&swrm->broadcast);
> +		reinit_completion(&ctrl->broadcast);
>  
>  	/* Its assumed that write is okay as we do not get any status back */
> -	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
> +	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>  
> -	if (swrm->version <= SWRM_VERSION_1_3_0)
> +	if (ctrl->version <= SWRM_VERSION_1_3_0)
>  		usleep_range(150, 155);
>  
>  	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> @@ -363,7 +363,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  		 * sleep for 10ms for MSM soundwire variant to allow broadcast
>  		 * command to complete.
>  		 */
> -		ret = wait_for_completion_timeout(&swrm->broadcast,
> +		ret = wait_for_completion_timeout(&ctrl->broadcast,
>  						  msecs_to_jiffies(TIMEOUT_MS));
>  		if (!ret)
>  			ret = SDW_CMD_IGNORED;
> @@ -376,41 +376,41 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  	return ret;
>  }
>  
> -static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>  				     u8 dev_addr, u16 reg_addr,
>  				     u32 len, u8 *rval)
>  {
>  	u32 cmd_data, cmd_id, val, retry_attempt = 0;
>  
> -	val = swrm_get_packed_reg_val(&swrm->rcmd_id, len, dev_addr, reg_addr);
> +	val = swrm_get_packed_reg_val(&ctrl->rcmd_id, len, dev_addr, reg_addr);
>  
>  	/*
>  	 * Check for outstanding cmd wrt. write fifo depth to avoid
>  	 * overflow as read will also increase write fifo cnt.
>  	 */
> -	swrm_wait_for_wr_fifo_avail(swrm);
> +	swrm_wait_for_wr_fifo_avail(ctrl);
>  
>  	/* wait for FIFO RD to complete to avoid overflow */
>  	usleep_range(100, 105);
> -	swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
> +	ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
>  	/* wait for FIFO RD CMD complete to avoid overflow */
>  	usleep_range(250, 255);
>  
> -	if (swrm_wait_for_rd_fifo_avail(swrm))
> +	if (swrm_wait_for_rd_fifo_avail(ctrl))
>  		return SDW_CMD_FAIL_OTHER;
>  
>  	do {
> -		swrm->reg_read(swrm, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &cmd_data);
>  		rval[0] = cmd_data & 0xFF;
>  		cmd_id = FIELD_GET(SWRM_RD_FIFO_CMD_ID_MASK, cmd_data);
>  
> -		if (cmd_id != swrm->rcmd_id) {
> +		if (cmd_id != ctrl->rcmd_id) {
>  			if (retry_attempt < (MAX_FIFO_RD_RETRY - 1)) {
>  				/* wait 500 us before retry on fifo read failure */
>  				usleep_range(500, 505);
> -				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD,
> +				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD,
>  						SWRM_CMD_FIFO_FLUSH);
> -				swrm->reg_write(swrm, SWRM_CMD_FIFO_RD_CMD, val);
> +				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
>  			}
>  			retry_attempt++;
>  		} else {
> @@ -419,9 +419,9 @@ static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *swrm,
>  
>  	} while (retry_attempt < MAX_FIFO_RD_RETRY);
>  
> -	dev_err(swrm->dev, "failed to read fifo: reg: 0x%x, rcmd_id: 0x%x,\
> +	dev_err(ctrl->dev, "failed to read fifo: reg: 0x%x, rcmd_id: 0x%x,\
>  		dev_num: 0x%x, cmd_data: 0x%x\n",
> -		reg_addr, swrm->rcmd_id, dev_addr, cmd_data);
> +		reg_addr, ctrl->rcmd_id, dev_addr, cmd_data);
>  
>  	return SDW_CMD_IGNORED;
>  }
> @@ -533,39 +533,39 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>  
>  static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>  {
> -	struct qcom_swrm_ctrl *swrm = dev_id;
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(swrm->dev);
> +	ret = pm_runtime_resume_and_get(ctrl->dev);
>  	if (ret < 0 && ret != -EACCES) {
> -		dev_err_ratelimited(swrm->dev,
> +		dev_err_ratelimited(ctrl->dev,
>  				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>  				    __func__, ret);
>  		return ret;
>  	}
>  
> -	if (swrm->wake_irq > 0) {
> -		if (!irqd_irq_disabled(irq_get_irq_data(swrm->wake_irq)))
> -			disable_irq_nosync(swrm->wake_irq);
> +	if (ctrl->wake_irq > 0) {
> +		if (!irqd_irq_disabled(irq_get_irq_data(ctrl->wake_irq)))
> +			disable_irq_nosync(ctrl->wake_irq);
>  	}
>  
> -	pm_runtime_mark_last_busy(swrm->dev);
> -	pm_runtime_put_autosuspend(swrm->dev);
> +	pm_runtime_mark_last_busy(ctrl->dev);
> +	pm_runtime_put_autosuspend(ctrl->dev);
>  
>  	return IRQ_HANDLED;
>  }
>  
>  static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  {
> -	struct qcom_swrm_ctrl *swrm = dev_id;
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
>  	u32 value, intr_sts, intr_sts_masked, slave_status;
>  	u32 i;
>  	int devnum;
>  	int ret = IRQ_HANDLED;
> -	clk_prepare_enable(swrm->hclk);
> +	clk_prepare_enable(ctrl->hclk);
>  
> -	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> -	intr_sts_masked = intr_sts & swrm->intr_mask;
> +	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &intr_sts);
> +	intr_sts_masked = intr_sts & ctrl->intr_mask;
>  
>  	do {
>  		for (i = 0; i < SWRM_INTERRUPT_MAX; i++) {
> @@ -575,80 +575,80 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  
>  			switch (value) {
>  			case SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ:
> -				devnum = qcom_swrm_get_alert_slave_dev_num(swrm);
> +				devnum = qcom_swrm_get_alert_slave_dev_num(ctrl);
>  				if (devnum < 0) {
> -					dev_err_ratelimited(swrm->dev,
> +					dev_err_ratelimited(ctrl->dev,
>  					    "no slave alert found.spurious interrupt\n");
>  				} else {
> -					sdw_handle_slave_status(&swrm->bus, swrm->status);
> +					sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>  				}
>  
>  				break;
>  			case SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED:
>  			case SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS:
> -				dev_dbg_ratelimited(swrm->dev, "SWR new slave attached\n");
> -				swrm->reg_read(swrm, SWRM_MCP_SLV_STATUS, &slave_status);
> -				if (swrm->slave_status == slave_status) {
> -					dev_dbg(swrm->dev, "Slave status not changed %x\n",
> +				dev_dbg_ratelimited(ctrl->dev, "SWR new slave attached\n");
> +				ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &slave_status);
> +				if (ctrl->slave_status == slave_status) {
> +					dev_dbg(ctrl->dev, "Slave status not changed %x\n",
>  						slave_status);
>  				} else {
> -					qcom_swrm_get_device_status(swrm);
> -					qcom_swrm_enumerate(&swrm->bus);
> -					sdw_handle_slave_status(&swrm->bus, swrm->status);
> +					qcom_swrm_get_device_status(ctrl);
> +					qcom_swrm_enumerate(&ctrl->bus);
> +					sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>  				}
>  				break;
>  			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
> -				dev_err_ratelimited(swrm->dev,
> +				dev_err_ratelimited(ctrl->dev,
>  						"%s: SWR bus clsh detected\n",
>  						__func__);
> -				swrm->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> -				swrm->reg_write(swrm, SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
> +				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
> +				ctrl->reg_write(ctrl, SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW:
> -				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> -				dev_err_ratelimited(swrm->dev,
> +				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				dev_err_ratelimited(ctrl->dev,
>  					"%s: SWR read FIFO overflow fifo status 0x%x\n",
>  					__func__, value);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW:
> -				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> -				dev_err_ratelimited(swrm->dev,
> +				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				dev_err_ratelimited(ctrl->dev,
>  					"%s: SWR read FIFO underflow fifo status 0x%x\n",
>  					__func__, value);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW:
> -				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> -				dev_err(swrm->dev,
> +				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				dev_err(ctrl->dev,
>  					"%s: SWR write FIFO overflow fifo status %x\n",
>  					__func__, value);
> -				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
> +				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_CMD_ERROR:
> -				swrm->reg_read(swrm, SWRM_CMD_FIFO_STATUS, &value);
> -				dev_err_ratelimited(swrm->dev,
> +				ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +				dev_err_ratelimited(ctrl->dev,
>  					"%s: SWR CMD error, fifo status 0x%x, flushing fifo\n",
>  					__func__, value);
> -				swrm->reg_write(swrm, SWRM_CMD_FIFO_CMD, 0x1);
> +				ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION:
> -				dev_err_ratelimited(swrm->dev,
> +				dev_err_ratelimited(ctrl->dev,
>  						"%s: SWR Port collision detected\n",
>  						__func__);
> -				swrm->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
> -				swrm->reg_write(swrm,
> -					SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
> +				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
> +				ctrl->reg_write(ctrl,
> +					SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH:
> -				dev_err_ratelimited(swrm->dev,
> +				dev_err_ratelimited(ctrl->dev,
>  					"%s: SWR read enable valid mismatch\n",
>  					__func__);
> -				swrm->intr_mask &=
> +				ctrl->intr_mask &=
>  					~SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH;
> -				swrm->reg_write(swrm,
> -					SWRM_INTERRUPT_CPU_EN, swrm->intr_mask);
> +				ctrl->reg_write(ctrl,
> +					SWRM_INTERRUPT_CPU_EN, ctrl->intr_mask);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
> -				complete(&swrm->broadcast);
> +				complete(&ctrl->broadcast);
>  				break;
>  			case SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED_V2:
>  				break;
> @@ -657,19 +657,19 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  			case SWRM_INTERRUPT_STATUS_EXT_CLK_STOP_WAKEUP:
>  				break;
>  			default:
> -				dev_err_ratelimited(swrm->dev,
> +				dev_err_ratelimited(ctrl->dev,
>  						"%s: SWR unknown interrupt value: %d\n",
>  						__func__, value);
>  				ret = IRQ_NONE;
>  				break;
>  			}
>  		}
> -		swrm->reg_write(swrm, SWRM_INTERRUPT_CLEAR, intr_sts);
> -		swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> -		intr_sts_masked = intr_sts & swrm->intr_mask;
> +		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, intr_sts);
> +		ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &intr_sts);
> +		intr_sts_masked = intr_sts & ctrl->intr_mask;
>  	} while (intr_sts_masked);
>  
> -	clk_disable_unprepare(swrm->hclk);
> +	clk_disable_unprepare(ctrl->hclk);
>  	return ret;
>  }
>  
> @@ -1301,23 +1301,23 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  #ifdef CONFIG_DEBUG_FS
>  static int swrm_reg_show(struct seq_file *s_file, void *data)
>  {
> -	struct qcom_swrm_ctrl *swrm = s_file->private;
> +	struct qcom_swrm_ctrl *ctrl = s_file->private;
>  	int reg, reg_val, ret;
>  
> -	ret = pm_runtime_resume_and_get(swrm->dev);
> +	ret = pm_runtime_resume_and_get(ctrl->dev);
>  	if (ret < 0 && ret != -EACCES) {
> -		dev_err_ratelimited(swrm->dev,
> +		dev_err_ratelimited(ctrl->dev,
>  				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
>  				    __func__, ret);
>  		return ret;
>  	}
>  
>  	for (reg = 0; reg <= SWR_MSTR_MAX_REG_ADDR; reg += 4) {
> -		swrm->reg_read(swrm, reg, &reg_val);
> +		ctrl->reg_read(ctrl, reg, &reg_val);
>  		seq_printf(s_file, "0x%.3x: 0x%.2x\n", reg, reg_val);
>  	}
> -	pm_runtime_mark_last_busy(swrm->dev);
> -	pm_runtime_put_autosuspend(swrm->dev);
> +	pm_runtime_mark_last_busy(ctrl->dev);
> +	pm_runtime_put_autosuspend(ctrl->dev);
>  
>  
>  	return 0;
> @@ -1498,13 +1498,13 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
> +static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *ctrl)
>  {
>  	int retry = SWRM_LINK_STATUS_RETRY_CNT;
>  	int comp_sts;
>  
>  	do {
> -		swrm->reg_read(swrm, SWRM_COMP_STATUS, &comp_sts);
> +		ctrl->reg_read(ctrl, SWRM_COMP_STATUS, &comp_sts);
>  
>  		if (comp_sts & SWRM_FRM_GEN_ENABLED)
>  			return true;
> @@ -1512,7 +1512,7 @@ static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
>  		usleep_range(500, 510);
>  	} while (retry--);
>  
> -	dev_err(swrm->dev, "%s: link status not %s\n", __func__,
> +	dev_err(ctrl->dev, "%s: link status not %s\n", __func__,
>  		comp_sts & SWRM_FRM_GEN_ENABLED ? "connected" : "disconnected");
>  
>  	return false;
