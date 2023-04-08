Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57916DB945
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 09:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDHHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDHHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 03:15:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53017C666
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:15:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e11so702448lfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680938154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUNMkqYPA7+zF4YxnREdArCgZKwdLy10k/38MRYMHX8=;
        b=rAd0fN1zSuD5cUKXGgg/AITm4qh0a1JH/cQeCa+k90d4LLcYxh9QEvLRSdRnG86leX
         9dbxElTwR7kzpvzwHVTI6J044N5J5XSJ/mWpg0qAzsefMOr3EQhg4XMawHTCc918M4HI
         RMN4ID4ztWQRP2Pgwo64FzCj7kSK3AERPd2OYHhlqfvX3VLf4qDqQQYUdqZTVpUDv/1n
         enjhCAew+Cx5lhIrLVG1fhh045XhIKGjdET6Znf2OBnzaf8IJoXX8NIpTtz87iCSuiyf
         tnCHzcna+WB7pXRhuI0q39JZxrFOcP90Hq2YHLLNCDm0CtvV992qCt+6GhZRoDJz9GpP
         o+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680938154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUNMkqYPA7+zF4YxnREdArCgZKwdLy10k/38MRYMHX8=;
        b=bMyFWhG+BLzPBRPIKyhGnIWhPcDSMGm4MOAyFoZZ3NfkbRBIIFbkk1SXZ8UQaJWYOX
         2iZC7+9gYUS/rh0Tc4GFEQujbjJZwF79uKf7NH33vYrULvS7nvOJUNuUMGGjhgcx41KM
         GLotFs0NVs/0I1zBcPsPJqGMnE8U4T1RWtsox0j3yDMj+d4MJBFf1aTlihKWRcstTLDd
         SUbGNBlUPi7kpZWCRX7vydqhYXSihTzEzyqvdwXl/8wFHPaGF3vJedY/ZFVwYcDKVdc+
         DdMlO8O6WZZUpz0GdSecXa9daI9GIeeVgubCuKcqVZNulLxgDu023wF308jPr9Z66BIo
         MAsw==
X-Gm-Message-State: AAQBX9d4x5UwzAx8uA0nK7CkV9Lavq6uI6xkYG5FwAY7ScTQFQ47gdzQ
        arMYrGQ+Dft59LHhr4IxyQFVWg==
X-Google-Smtp-Source: AKy350Z3JLwZSIqbFDcjhwWm3GDt0G6SowXpfJDa2y8R0DOZ/ZHY6IxekzFiQJjq2LlIKVwkfIzC+A==
X-Received: by 2002:ac2:4c39:0:b0:4eb:c85:bdc2 with SMTP id u25-20020ac24c39000000b004eb0c85bdc2mr1430582lfq.2.1680938154480;
        Sat, 08 Apr 2023 00:15:54 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512020e00b004cc8207741fsm1075807lfo.93.2023.04.08.00.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 00:15:53 -0700 (PDT)
Message-ID: <514c5c33-df0a-8b4b-a5a2-67abff538efa@linaro.org>
Date:   Sat, 8 Apr 2023 09:15:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] venus: add firmware version based check
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
 <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1680848758-3947-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 08:25, Dikshita Agarwal wrote:
> Add firmware version based checks to enable/disable
> features for different SOCs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

One extra question: some firmware builds have a TYPE-n suffix like
PROD-1 in:

14:VIDEO.VE.6.0-00042-PROD-1

Is the -1 a sign of an incremental build, or some "point release" of a
given fw revision? Does it matter as far as this checking function
goes?

Konrad
>  drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2..9d1e4b2 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -202,6 +202,11 @@ struct venus_core {
>  	unsigned int core0_usage_count;
>  	unsigned int core1_usage_count;
>  	struct dentry *root;
> +	struct venus_img_version {
> +		u32 major;
> +		u32 minor;
> +		u32 rev;
> +	} venus_ver;
>  };
>  
>  struct vdec_controls {
> @@ -500,4 +505,19 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>  	return NULL;
>  }
>  
> +static inline int
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev >= vrev);
> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev <= vrev);
> +}
>  #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3..07ac0fc 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>  }
>  
>  static void
> -sys_get_prop_image_version(struct device *dev,
> +sys_get_prop_image_version(struct venus_core *core,
>  			   struct hfi_msg_sys_property_info_pkt *pkt)
>  {
> +	struct device *dev = core->dev;
>  	u8 *smem_tbl_ptr;
>  	u8 *img_ver;
>  	int req_bytes;
> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>  		return;
>  
>  	img_ver = pkt->data;
> +	if (IS_V4(core))
> +		sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +	else if (IS_V6(core))
> +		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>  
>  	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>  
> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>  
>  	switch (pkt->property) {
>  	case HFI_PROPERTY_SYS_IMAGE_VERSION:
> -		sys_get_prop_image_version(dev, pkt);
> +		sys_get_prop_image_version(core, pkt);
>  		break;
>  	default:
>  		dev_dbg(dev, VDBGL "unknown property data\n");
