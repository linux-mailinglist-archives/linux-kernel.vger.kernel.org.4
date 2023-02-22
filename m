Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98A69F6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjBVOqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjBVOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:45:57 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDD23B64C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:45:28 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m7so10245823lfj.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82MAuCNhG06xMeVQkBmgdPiKLkfVFlIu9OWII8VtcQA=;
        b=jbz30JcKqnUko6NCOvVUzpfPgOlNcTNiBXom2bSbhca8hPWlzTMqkY904C5HWQAr8M
         0JocMOzsOUXiVouYD6KGTRaWAW8XEWiNpxFRimk5Ox07Qsnub9Qj4Dj1nTNSu4OM7sgw
         pDZ5UkFTjYe3Hqsxp0UcoOVb0DOvLuhc+dK0vig+k/v9frs8o2q57M2RbP3CCf4mVjae
         NnjOnsDTqXltTvWNbk1BEyKig3SB/gePUTVYz9r4iOgIZgtiSjmQXGLC1rDEPdbZ/7tp
         lmD3qqQTikKpP68zOQkoFA67MtIlwu69KpmlzBiqJ7LctprtIGR0KVJoNGOr9ji4XZtu
         c+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82MAuCNhG06xMeVQkBmgdPiKLkfVFlIu9OWII8VtcQA=;
        b=gunavViJNd4dspmVDGQ8FCAsbTIWJaXamC9x0qA7bf0Xd20nPNkffcmllSzE55luFM
         Rt8zu7khc1f50p/3/JnRNeRSncSFk6lMhRmjXRmgdSIs6GZ5qPaoF51Wz0xna3scbEFZ
         ZufDdXsdxFszOR0lTI8K2hIAL9BsE2vVlcctdrvoLBmdKoDi4P6l78KSlJ+S2hV23PgO
         tImZpQkXWqs5gB4/r/Pt8+MCy39ZUwrC/PHbNDOvB/ql6jf6jkuZL2OoMe4l6YJLGSbV
         ll91JDu4JcrUkfg0lJdbSqqpDnpiN8wPRvzyUrSBs08xaIrQpYYqadSrKpwlBhUiyvRn
         fQ+A==
X-Gm-Message-State: AO0yUKUsYfz6dnFclRCxcX8mHoUwxb1w5wjyTPzhRtslLkvH2J3rHXLU
        4b63HykK1SDQxGrMpBL1vlQInA==
X-Google-Smtp-Source: AK7set9ZQwKHM5C/UkmDcsKwJ3injIEsUGeSMXhs/dQJ3ThR3rnbgEMHbFOu0LRO77vL7KiuJDldSw==
X-Received: by 2002:a05:6512:38d1:b0:4dd:9f4d:7459 with SMTP id p17-20020a05651238d100b004dd9f4d7459mr488939lft.67.1677077123238;
        Wed, 22 Feb 2023 06:45:23 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id f25-20020ac25339000000b004d865c781eesm978866lfh.24.2023.02.22.06.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:45:22 -0800 (PST)
Message-ID: <65533400-5baa-1577-f2af-c9fca9e888e4@linaro.org>
Date:   Wed, 22 Feb 2023 15:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] soundwire: qcom: define hardcoded version magic
 numbers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 15:44, Krzysztof Kozlowski wrote:
> Use a define instead of hard-coded register values for Soundwire
> hardware version number, because it is a bit easier to read and allows
> to drop explaining comment.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index ba502129150d..79bebcecde6d 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -28,6 +28,9 @@
>  #define SWRM_LINK_MANAGER_EE					0x018
>  #define SWRM_EE_CPU						1
>  #define SWRM_FRM_GEN_ENABLED					BIT(0)
> +#define SWRM_VERSION_1_3_0					0x01030000
> +#define SWRM_VERSION_1_5_1					0x01050001
> +#define SWRM_VERSION_1_7_0					0x01070000
>  #define SWRM_COMP_HW_VERSION					0x00
>  #define SWRM_COMP_CFG_ADDR					0x04
>  #define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
> @@ -351,8 +354,7 @@ static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *swrm, u8 cmd_data,
>  	/* Its assumed that write is okay as we do not get any status back */
>  	swrm->reg_write(swrm, SWRM_CMD_FIFO_WR_CMD, val);
>  
> -	/* version 1.3 or less */
> -	if (swrm->version <= 0x01030000)
> +	if (swrm->version <= SWRM_VERSION_1_3_0)
>  		usleep_range(150, 155);
>  
>  	if (cmd_id == SWR_BROADCAST_CMD_ID) {
> @@ -695,7 +697,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	u32p_replace_bits(&val, SWRM_DEF_CMD_NO_PINGS, SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK);
>  	ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>  
> -	if (ctrl->version >= 0x01070000) {
> +	if (ctrl->version >= SWRM_VERSION_1_7_0) {
>  		ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>  		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>  				SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
> @@ -704,8 +706,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	}
>  
>  	/* Configure number of retries of a read/write cmd */
> -	if (ctrl->version >= 0x01050001) {
> -		/* Only for versions >= 1.5.1 */
> +	if (ctrl->version >= SWRM_VERSION_1_5_1) {
>  		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
>  				SWRM_RD_WR_CMD_RETRIES |
>  				SWRM_CONTINUE_EXEC_ON_CMD_IGNORE);
> @@ -1239,7 +1240,7 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>  	ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>  					bp_mode, nports);
>  	if (ret) {
> -		if (ctrl->version <= 0x01030000)
> +		if (ctrl->version <= SWRM_VERSION_1_3_0)
>  			memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>  		else
>  			return ret;
> @@ -1442,7 +1443,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  
>  	/* Clk stop is not supported on WSA Soundwire masters */
> -	if (ctrl->version <= 0x01030000) {
> +	if (ctrl->version <= SWRM_VERSION_1_3_0) {
>  		ctrl->clock_stop_not_supported = true;
>  	} else {
>  		ctrl->reg_read(ctrl, SWRM_COMP_MASTER_ID, &val);
> @@ -1527,7 +1528,7 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
>  	} else {
>  		reset_control_reset(ctrl->audio_cgcr);
>  
> -		if (ctrl->version >= 0x01070000) {
> +		if (ctrl->version >= SWRM_VERSION_1_7_0) {
>  			ctrl->reg_write(ctrl, SWRM_LINK_MANAGER_EE, SWRM_EE_CPU);
>  			ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL,
>  					SWRM_MCP_BUS_CLK_START << SWRM_EE_CPU);
