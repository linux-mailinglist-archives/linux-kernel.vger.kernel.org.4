Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13226CCD18
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1WUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjC1WUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:20:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027423592
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:20:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y20so17760381lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680041986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEK2AHmPRbaja0kizq1EyPodYA6ZJcgPYzcG0gXYKYI=;
        b=q+YU76Gd6WGYFNVVLHZvAuwfYWumPa/BQQWslec5WU6lTTzbWw4GhIBAP5EY/dwv+B
         hURbVmN47F5F5HvNCqtEWOdAtx1k4rg1TcxgpYtQHo9eH1quQgtg1lZcO1xq2yTttk1O
         7MAJzp35j8z1EUnH8VEKF1A6Gcm+NLP67AyahZ87zn/ihoTNiZy+6399BozHf57gKAML
         ocezdBAJqak1jGjNSL92jqNkeImfhZ7uU7VU8tRHGPs8MeW8DpH19JYTKOk97XnprVKj
         8ngD2qnbc0QhtmAAnEPI6Vnu129S+H31GKAjXjvrIgZS0qVHRL3SIY/+4JYXBu1nRfHV
         Jueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEK2AHmPRbaja0kizq1EyPodYA6ZJcgPYzcG0gXYKYI=;
        b=VescpzM81hs1Sqooy7rOIxEJRbNzLPnY1AAxlGKzlrGp+wW+qX8ua77/4gDvKY3OQO
         A0N38VlbhQMuRvsFOXMIdTKThTwymHRtwc4EVhEr4N26W8T8POEL2H7DgY/zjF8GQAX9
         Uz/za8Zx3Cvc1TLk6bHBeiot8wBQNxmXxWMcLpjWF9fcBOvRl6ZA2/lj4XjedSEG8hVO
         VvOH9s7lUw6M9pMrh/3iOwhszcBNooGAHU6iKAwfB2FI5ICwKFVJCWmI0XTiKRjczGwN
         egSMUBY6u9TUAMLGbjHUozkobUzaHtlTBYnuCMcYTIVeyJrSz0lCvHJm4dceoPr/UzMp
         YPHA==
X-Gm-Message-State: AAQBX9cyRr6xigZsmZZjXlcLTaO0NReHf4L0MuXklUgiuIlV0NUP7yLS
        yQhsvQKfOrLGWUje2ePMxQoG/w==
X-Google-Smtp-Source: AKy350bheb2joASkyyWIlropafXmRcQapFB3f/1GsMtxBdIsgZ26u3T0Q8GTnz+rHTWe2SJIZoDMig==
X-Received: by 2002:ac2:5d66:0:b0:4d5:a689:7f9d with SMTP id h6-20020ac25d66000000b004d5a6897f9dmr4731051lft.57.1680041986405;
        Tue, 28 Mar 2023 15:19:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u1-20020ac248a1000000b004db51387ad6sm5236931lfg.129.2023.03.28.15.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 15:19:46 -0700 (PDT)
Message-ID: <c611c390-2cf3-2abe-82aa-67538b823d62@linaro.org>
Date:   Wed, 29 Mar 2023 01:19:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] venus: Enable sufficient sequence change support for
 sc7180 and fix for Decoder STOP command issue.
Content-Language: en-GB
To:     Viswanath Boma <quic_vboma@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com
Cc:     stanimir.k.varbanov@gmail.com,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
References: <20230323130153.8229-1-quic_vboma@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230323130153.8229-1-quic_vboma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 15:01, Viswanath Boma wrote:
> For VP9 bitstreams, there could be a change in resolution at interframe,
> for driver to get notified of such resolution change,
> enable the property in video firmware.
> Also, EOS handling is now made same in video firmware across all V6 SOCs,
> hence above a certain firmware version, the driver handling is
> made generic for all V6s

Having "Do abc. Also do defgh." is a clear sign that this patch should 
be split into two.

> 
> Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
> Since v3 : Addressed comments to rectify email address.
> 
>   drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
>   drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
>   drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
>   drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
>   drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
>   5 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2602a9..ee8b70a34656 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -202,6 +202,11 @@ struct venus_core {
>   	unsigned int core0_usage_count;
>   	unsigned int core1_usage_count;
>   	struct dentry *root;
> +	struct venus_img_version {
> +		u32 major;
> +		u32 minor;
> +		u32 rev;
> +	} venus_ver;
>   };
>   
>   struct vdec_controls {
> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>   	return NULL;
>   }
>   
> +static inline int
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +			vminor && (core)->venus_ver.rev >= vrev);
> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +			vminor && (core)->venus_ver.rev <= vrev);
> +}
>   #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index bc3f8ff05840..9efe04961890 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>   		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>   		break;
>   	}
> +	case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>   	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>   		struct hfi_enable *in = pdata;
>   		struct hfi_enable *en = prop_data;
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 105792a68060..c8aaf870829c 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -469,6 +469,8 @@
>   #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
>   #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
>   #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
> +								0x0100300b
>   
>   /*
>    * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3761a7..07ac0fcd2852 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -248,9 +248,10 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
>   }
>   
>   static void
> -sys_get_prop_image_version(struct device *dev,
> +sys_get_prop_image_version(struct venus_core *core,
>   			   struct hfi_msg_sys_property_info_pkt *pkt)
>   {
> +	struct device *dev = core->dev;
>   	u8 *smem_tbl_ptr;
>   	u8 *img_ver;
>   	int req_bytes;
> @@ -263,6 +264,12 @@ sys_get_prop_image_version(struct device *dev,
>   		return;
>   
>   	img_ver = pkt->data;
> +	if (IS_V4(core))
> +		sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +	else if (IS_V6(core))
> +		sscanf(img_ver, "14:VIDEO.VPU.%u.%u-%u-PROD",
> +		       &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
>   
>   	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>   
> @@ -286,7 +293,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>   
>   	switch (pkt->property) {
>   	case HFI_PROPERTY_SYS_IMAGE_VERSION:
> -		sys_get_prop_image_version(dev, pkt);
> +		sys_get_prop_image_version(core, pkt);
>   		break;
>   	default:
>   		dev_dbg(dev, VDBGL "unknown property data\n");
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ceaba37e2e5..36c88858ea9d 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>   
>   		fdata.buffer_type = HFI_BUFFER_INPUT;
>   		fdata.flags |= HFI_BUFFERFLAG_EOS;
> -		if (IS_V6(inst->core))
> +		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))

This should go into a separate patch.

>   			fdata.device_addr = 0;
>   		else
>   			fdata.device_addr = 0xdeadb000;
> @@ -671,6 +671,16 @@ static int vdec_set_properties(struct venus_inst *inst)
>   			return ret;
>   	}
>   
> +	/* Enabling sufficient sequence change support for VP9 */
> +	if (of_device_is_compatible(inst->core->dev->of_node, "qcom,sc7180-venus")) {

Let me repeat my question from v3:

Is it really specific just to sc7180 or will it be applicable to any
other platform using venus-5.4 firmware?

> +		if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
> +			ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
> +			ret = hfi_session_set_property(inst, ptype, &en);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>   	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>   	conceal = ctr->conceal_color & 0xffff;
>   	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;

-- 
With best wishes
Dmitry

