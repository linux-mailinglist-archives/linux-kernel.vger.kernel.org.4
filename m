Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D049689C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjBCOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBCOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:51:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2319F9D5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:51:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so4862602wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofXAoU+hsGWOCNrrPepY1L9E1N+1o8r5iAwRdUiVGTM=;
        b=kaIVAubJnuVnjEZEfIfXoLm0zhFw3H7kWzldwb1nwpPceJSikzXZr+rkkQ1u8btllv
         19xoL0j17mGFkHBRb/ETa4UfuANvGhIV4aHwQmS29CPsLvbQRBbAyGlsRCtI1R84w+Uu
         ZKzPo8q7qlwIKv7XkTjtCUKIdvoCHcY6Tg4FIS+fTAfygstI3PNYY2Nwt0qVSxzwx6X6
         vdnf80IDTPXliYz5HQwdVccbFGt7l/m6TIccV2lpVL52v73pI3yAPhzBV32qiNrZ51jC
         kH1wpPdXxjqoQgHB+v7//ampqjvE6hoVOiKVbBar4woNduhmNFKkgCS4kQrbW4thSCPI
         zaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofXAoU+hsGWOCNrrPepY1L9E1N+1o8r5iAwRdUiVGTM=;
        b=UUZwOztPxbhEHFJPwZWH4Hm/PCNoYNmItsvwydRLgq5eciq6BWJyL//I48aDtxPePL
         08mFIMPvrdfNNxz8SRjFrI2Ku5l6+tkkCuDaoZJED8RpqbZcJ/jidT/AIlqRjCoLsPFC
         3yO5erSit9+zsqkpeTg8+woJWKd7V5gsAJaUCR+TrI02U/6lnkJUr7roboZuk64FvUa9
         Zcq/X8pRpC7b3o7kvjnzRJ38WCuGQyaweEAnA/mDBpWAqk/6909BdiQLjr7BEgI5Yuvg
         ux9oxQv+IRX9aIEcnWuTQPXrgDV7LUOPMjKqTMW9VJ286p48W577HWgxWaGldeuxGtSt
         4AXg==
X-Gm-Message-State: AO0yUKW7icHFSdugt+49Z9viIsgxA5uc9U0qgmFsZ72My9bzvrkZR8uG
        HlRF3RfwAs4rnttAwGuW+sdTpQ==
X-Google-Smtp-Source: AK7set8Q9SRj1NWFGgYcDTjDSO3e2yC2jTUX/a0ccHkC2zMn7TCVBBUgB/Ez+7jRBFeN7HLYFo+cgQ==
X-Received: by 2002:a5d:5c08:0:b0:2bf:c968:d181 with SMTP id cc8-20020a5d5c08000000b002bfc968d181mr11213697wrb.27.1675435868808;
        Fri, 03 Feb 2023 06:51:08 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id s8-20020a5d5108000000b0024cb961b6aesm2063305wrt.104.2023.02.03.06.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:51:07 -0800 (PST)
Message-ID: <1bca9111-1ad4-ad1d-b30a-9d2fbddf9e3a@linaro.org>
Date:   Fri, 3 Feb 2023 14:51:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] firmware: qcom_scm: modify
 qcom_scm_set_download_mode()
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/02/2023 10:17, Mukesh Ojha wrote:
> Modify qcom_scm_set_download_mode() such that it can support
> multiple modes. There is no functional change with this change.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>    - Stop changing legacy scm id for dload mode.
> 
>   drivers/firmware/qcom_scm.c | 15 +++++++--------
>   include/linux/qcom_scm.h    |  5 +++++
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54..6245b97 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> +static int __qcom_scm_set_dload_mode(struct device *dev, enum qcom_download_mode mode)
>   {
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_BOOT,
> @@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   
> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> +	desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;

I think this line should be:

	desc.args[1] = mode;


--srini

>   
>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>   }
>   
> -static void qcom_scm_set_download_mode(bool enable)
> +static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
>   {
>   	bool avail;
>   	int ret = 0;
> @@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
>   					     QCOM_SCM_SVC_BOOT,
>   					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
>   	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
>   	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
> @@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   	 * disabled below by a clean shutdown/reboot.
>   	 */
>   	if (download_mode)
> -		qcom_scm_set_download_mode(true);
> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
>   
>   	return 0;
>   }
> @@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct platform_device *pdev)
>   {
>   	/* Clean shutdown, disable download mode to allow normal restart */
>   	if (download_mode)
> -		qcom_scm_set_download_mode(false);
> +		qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>   }
>   
>   static const struct of_device_id qcom_scm_dt_match[] = {
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index f833564..f9bc84e 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -14,6 +14,11 @@
>   #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
>   #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
>   
> +enum qcom_download_mode {
> +	QCOM_DOWNLOAD_NODUMP    = 0x00,
> +	QCOM_DOWNLOAD_FULLDUMP  = 0x10,
> +};
> +
>   struct qcom_scm_hdcp_req {
>   	u32 addr;
>   	u32 val;
