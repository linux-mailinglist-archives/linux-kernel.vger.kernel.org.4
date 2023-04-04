Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE66D6B63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbjDDSSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjDDSSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:18:30 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364544BB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:18:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g17so43486399lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680632306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mwj94M7IXiRkpXzS0kpJXSI6UJpeRp+IXnxxWI2fhS0=;
        b=ndd2JaCzNh/i8RPI/N0M4bQjsPmKPtle9ldN+YMoQ0+NYMNwX0XxpkWkPSu7N4ub9N
         cx9wzG73k7bJC9GPDtb/P/TC9WT1uMs4ngdCV7wVlgvi9c4XR8t1KazlsibBVnvYD/sv
         XCIt8xngG+YTTKbeuD/VpID2dNvwzCIOH8J1jmF1AfgnEDvKBBCqVtaigxduSCExjnrz
         bQCfIZ1qQh8uh3HfZmf0N/lrElDV2jv0E4ld7SpQsL1ianRj73n0ZqKwDm7Wl/B5bOPG
         MAa4MECyqe78hsg3VC/05TVv9zV9nEjVLHntUFo+Usd9xCe9Ue5UaaVkyacNaNq8sAxu
         onJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mwj94M7IXiRkpXzS0kpJXSI6UJpeRp+IXnxxWI2fhS0=;
        b=f+rJWqujU+YdO58R+lNW20LR1Op/o3YzoXJEL4KQhypEKAGA58CMExYaZNtTfH2CgY
         yvmhQFvrsF0GhspRF92X/JMy6IUVsNgvo3sHw6WcqwielSCT8VOjZgDzwg9Qz0eaGR7u
         NerB4JGGGce/gwps3mFMStI6itNyu7QqWCP3zaCs/tvD2juqSXpiBzUeeE8X25rcjPrZ
         E7JofsxnSpK5MrCno+Y0JOxi761pkbTe7hYn4r1sJC+6XNAtAdqGE/wApmYqhFj/qKcm
         OZ271KA09IdhMT5pnhBVRMFnlVYcCS4bt1f5j/LW54OIwitiLOADUPWO2GTohnD2cGCI
         D/Ow==
X-Gm-Message-State: AAQBX9dkEt8ABfDXtHFTmVHga1IIl4w3o5ZSl6d0lSNA618yfomkVRh5
        NTp1fn//lG1+ULs+qZKJiEIj7Q==
X-Google-Smtp-Source: AKy350Z6I0H5kzeFMVDCpRA4on3SoYOdt2agRTNTZBqaG9b4x3mC+71DDkuUpUMIEoFQ/XF92mdg9A==
X-Received: by 2002:ac2:43d1:0:b0:4dc:65c0:c74e with SMTP id u17-20020ac243d1000000b004dc65c0c74emr34507lfl.29.1680632306644;
        Tue, 04 Apr 2023 11:18:26 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id x4-20020a19f604000000b004eaf8613bc3sm2440370lfe.284.2023.04.04.11.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:18:26 -0700 (PDT)
Message-ID: <7511d03b-5b88-d1c2-d756-4781b12d5296@linaro.org>
Date:   Tue, 4 Apr 2023 20:18:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] venus: add firmware version based check
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-2-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1680589032-26046-2-git-send-email-quic_dikshita@quicinc.com>
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



On 4.04.2023 08:17, Dikshita Agarwal wrote:
> Add firmware version based checks to enable/disable
> features for different SOCs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.h     | 18 ++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_msgs.c | 11 +++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2..ee8b70a 100644
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
> @@ -500,4 +505,17 @@ venus_caps_by_codec(struct venus_core *core, u32 codec, u32 domain)
>  	return NULL;
>  }
>  
> +static inline int
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
So this is trying to find the revision of a MAJ.MIN firmware release..

Is the MAJ.MIN part supposed to stay constant for a specific version of
a Venus block (say idk, IRIS2) and only the VREV part is supposed to
be updated with both feature and security developments?

> +{
> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +			vminor && (core)->venus_ver.rev >= vrev);
return ((core)->venus_ver.major == vmajor &&
	(core)->venus_ver.minor == vminor &&
	(core)->venus_ver.rev >= vrev);

for readability

Konrad
> +}
> +
> +static inline int
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor && (core)->venus_ver.minor ==
> +			vminor && (core)->venus_ver.rev <= vrev);
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
