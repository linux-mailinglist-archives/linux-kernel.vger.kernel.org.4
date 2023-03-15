Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD916BB549
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjCONzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjCONzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:55:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706D60D7B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:55:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so75809505edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678888530;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FL2PPYlA0uRNBqiWUXPuYQTCMqk2pdi/oLiMTHLvsic=;
        b=AFOfedjgXSfHm0FNU0hZ/CmUqoER/e89nK2ng2txWLf8ICWj/nGtq3b/d4mfuSpGrW
         O1HFmqgN3bjP55Fw9LczQKBO9y8ysPn/4E8XIHPMmsTLH1Qj5KfsMERSzXpwkAdcfU0+
         5U9ovU2dPH8JnPl0IcdTabZ9/22tWBkASeY1GS1lkgwoKk2gacKxD7jUcduxW7/cpSJj
         Qe3KUT1L/bLAGL+r9ZXuv4kMKRLdDGBmsOjCuHO702yfNuh926onLw1V2+7WWmOAJknY
         JNoZnJBvuEF4gn4pVRVZnFzYrnj6wEgUb4LD91L/gVfUfTMdgGI7ojADK+oQMceGPboA
         +7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888530;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL2PPYlA0uRNBqiWUXPuYQTCMqk2pdi/oLiMTHLvsic=;
        b=3VgtCAv2bvodxAwkY1NIzFU4/w6FEqNRpoFNl7X+jReTt8n29B4ZeQYALl54LnzIC6
         4X+RuyqY8wOj4VJQb56mH3L0cH8B+TDczMHaXY+Bcq9iIBkWQN5EpIP8bwWqd/1A1DCj
         B+xAQM+ojgpviwZpldTKHJNC+loLUbzTwJQ7jCLWwyZkMw/igNoqUmZmwvaC0EPOjxJ8
         lXh6Lr0+EV7yJL4HPtQSMT0x/Wgg/hqO/zEHBvvioKqpUUW3aPfhgWmX3Wq+SgOM89Qz
         SbEuO0UD/LpulQwjuDdqxhAselEvxLyeWt0dnzC9L8wefP3fRiy5pJSTmwgfLk4LAtBK
         J2Bw==
X-Gm-Message-State: AO0yUKUp/jNywtXCGSwRfhkjInG/2L0HT7OZHRmlFWGpwpkZvZ2dOsFN
        QuOTvlHMjYixE40h2mHEax5MrA==
X-Google-Smtp-Source: AK7set9f42lDPAauaA03LEFsdxyf5keK13/YIZ6Me3D3oy6UAB45VczN3jJ7dfbB7drXgjK46lX3aQ==
X-Received: by 2002:a17:906:3986:b0:91f:32f9:82f0 with SMTP id h6-20020a170906398600b0091f32f982f0mr6253293eje.29.1678888530287;
        Wed, 15 Mar 2023 06:55:30 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ot10-20020a170906ccca00b008e51a1fd7bfsm2580448ejb.172.2023.03.15.06.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 06:55:29 -0700 (PDT)
Message-ID: <7de97b6f-1318-5c40-2e42-3cc4774c9905@linaro.org>
Date:   Wed, 15 Mar 2023 13:55:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] soundwire: qcom: define hardcoded version magic
 numbers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2023 14:44, Krzysztof Kozlowski wrote:
> Use a define instead of hard-coded register values for Soundwire
> hardware version number, because it is a bit easier to read and allows
> to drop explaining comment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks Krzysztof,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini

>   drivers/soundwire/qcom.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index ba502129150d..79bebcecde6d 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -28,6 +28,9 @@
>   #define SWRM_LINK_MANAGER_EE					0x018
>   #define SWRM_EE_CPU						1
>   #define SWRM_FRM_GEN_ENABLED					BIT(0)
> +#define SWRM_VERSION_1_3_0					0x01030000
> +#define SWRM_VERSION_1_5_1					0x01050001
> +#define SWRM_VERSION_1_7_0					0x01070000
>   #define SWRM_COMP_HW_VERSION					0x00
>   #define SWRM_COMP_CFG_ADDR					0x04
>   #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
> @@ -351,8 +354,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>   	/* Its assumed that write is okay as we do not get any status back */
>   	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
>   
> -	/* version 1.3 or less */
> -	if (swrm->version <= 0x01030000)
> +	if (swrm->version <= SWRM_VERSION_1_3_0)
>   		usleep_range(150, 155);
>   
>   	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> @@ -695,7 +697,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>   	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>   	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>   
> -	if (ctrl->version >= 0x01070000) {
> +	if (ctrl->version >= SWRM_VERSION_1_7_0) {
>   		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>   		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>   				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
> @@ -704,8 +706,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>   	}
>   
>   	/* Configure number of retries of a read/write cmd */
> -	if (ctrl->version >= 0x01050001) {
> -		/* Only for versions >= 1.5.1 */
> +	if (ctrl->version >= SWRM_VERSION_1_5_1) {
>   		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
>   				SWRM_RD_WR_CMD_RETRIES |
>   				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
> @@ -1239,7 +1240,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>   	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>   					bp_mode, nports);
>   	if (ret) {
> -		if (ctrl->version <= 0x01030000)
> +		if (ctrl->version <= SWRM_VERSION_1_3_0)
>   			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>   		else
>   			return ret;
> @@ -1442,7 +1443,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	pm_runtime_enable(dev);
>   
>   	/* Clk stop is not supported on WSA Soundwire masters */
> -	if (ctrl->version <= 0x01030000) {
> +	if (ctrl->version <= SWRM_VERSION_1_3_0) {
>   		ctrl->clock_stop_not_supported = true;
>   	} else {
>   		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
> @@ -1527,7 +1528,7 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>   	} else {
>   		reset_control_reset(ctrl->audio_cgcr);
>   
> -		if (ctrl->version >= 0x01070000) {
> +		if (ctrl->version >= SWRM_VERSION_1_7_0) {
>   			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>   			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>   					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
