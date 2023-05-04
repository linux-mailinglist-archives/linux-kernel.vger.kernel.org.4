Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD786F6883
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEDJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjEDJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:43:00 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D29649C6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:42:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4efd6e26585so297608e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683193376; x=1685785376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wz8u/j3YhzQeA5NKiJONlU41B8oa1KpDldXNgze6k3I=;
        b=cLN/DBCz+Oa4n4KyPUcLekbExQO6re2Ba78o1GnOX4hXU0pH6+rYpVNR0E6AHf1yCq
         kbheHc1CKPzTxdoGJIaWENoNFHhh5D24KoPkC4BPjjfcHv2gfwMa12ni8dc8KAO4Xfjm
         NmB+GHwERBax5RDnN3zmPWquEaB6V/PhcTfMYwJREND0xOfMyNKnmPcIl1eNEtJndBg4
         SXsNSxhU/icYlHMBkFM0Q6YCQV0jJ5u40zqSdl0Nyta/79NcAkMNlkkuIj1t1Dh7vc70
         zGDLXwybzUmppK8hMkhIZ8rSu9J4VXqw0TBxCCBPAxe4+udKBp4Yx/ay39Gx9gzJUAJ8
         LyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193376; x=1685785376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz8u/j3YhzQeA5NKiJONlU41B8oa1KpDldXNgze6k3I=;
        b=T63Kwm5NowH3JOEr7HWE/Q2BpyTe8MuKDhaAqRyhlGmxGgtMI1EMYTkiPqPwfYDv3d
         4dl3+RAhyHEdMcGFpHxgmRi5m+M1YMXVUpjYqZAMQiI/SUw9YaPIUNffTq3d1kaqMFXZ
         J2ye7IcvxHQsWsJBEPMnP+Le+I5MpIM3JSuPGIbouNGga8rqPxxQCKfp01A5rIWUkZRy
         D8BwTl+7Zh5MOW8qwGG07rQY1uYnDRjKtFqeCJGkIRqCzME2GVdmYxRaDR9x00eWJQRy
         CGyVSXjKZw3NRUTXVjNg9rTTl8XS+zNaIJlGaMGeGqdmg+ADt+7q9ud5kCvmyyTYcHUP
         9OXw==
X-Gm-Message-State: AC+VfDxI4ny+SIZXvQyAz+Y604iXBLb6NSxKrI4SSCeFNPI8EraCGhSp
        09lf9gueTmwtqR1GoKMPv/2tF8vPwQZa58dG+QA=
X-Google-Smtp-Source: ACHHUZ4IxTWpVWf0zwLSLWRS9LQYzbh8zmn8oJsLbm8qRNTSzuhYvR76gABP+Zhw/wituNHLTOFW4Q==
X-Received: by 2002:a05:6512:517:b0:4f1:3c41:9819 with SMTP id o23-20020a056512051700b004f13c419819mr1158894lfb.29.1683193375845;
        Thu, 04 May 2023 02:42:55 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id s4-20020ac25fa4000000b004ef92c6e645sm6086581lfe.263.2023.05.04.02.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:42:55 -0700 (PDT)
Message-ID: <966416d1-3ddd-26ba-63ec-2323062dfda5@linaro.org>
Date:   Thu, 4 May 2023 11:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] venus: add firmware version based check
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
 <1683193152-5808-2-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1683193152-5808-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 11:39, Dikshita Agarwal wrote:
> Add firmware version based checks to enable/disable
> features for different SOCs.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/core.h     | 20 ++++++++++++++++++++
>  drivers/media/platform/qcom/venus/hfi_msgs.c | 27 +++++++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 32551c2..2f2176f 100644
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
> +static inline bool
> +is_fw_rev_or_newer(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev >= vrev);
> +}
> +
> +static inline bool
> +is_fw_rev_or_older(struct venus_core *core, u32 vmajor, u32 vminor, u32 vrev)
> +{
> +	return ((core)->venus_ver.major == vmajor &&
> +		(core)->venus_ver.minor == vminor &&
> +		(core)->venus_ver.rev <= vrev);
> +}
>  #endif
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index df96db3..4854863 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -248,13 +248,16 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
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
>  	size_t smem_blk_sz;
> +	int ret;
> +	u8 *ver_str;
>  
>  	req_bytes = pkt->hdr.size - sizeof(*pkt);
>  
> @@ -263,6 +266,26 @@ sys_get_prop_image_version(struct device *dev,
>  		return;
>  
>  	img_ver = pkt->data;
> +	if (IS_V6(core) && core->res->num_vpp_pipes == 1) {
> +		ret = sscanf(img_ver, "14:video-firmware.%u.%u-%u",
> +			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
This is still not perfect, 8350 has 4 vpp pipes and its firmware is
also denominated with "video-firmware".. perhaps we can just try
each variant until we reach ret == 3?

> +		if (ret != 2) {
3?

Konrad
> +			dev_dbg(dev, VDBGL "error reading F/W version\n");
> +			return;
> +		}
> +	} else {
> +		if (IS_V6(core))
> +			ver_str = "14:VIDEO.VPU.%u.%u-%u";
> +		else
> +			ver_str = "14:VIDEO.VE.%u.%u-%u";
> +
> +		ret = sscanf(img_ver, "14:VIDEO.VE.%u.%u-%u",
> +			     &core->venus_ver.major, &core->venus_ver.minor, &core->venus_ver.rev);
> +		if (ret != 3) {
> +			dev_dbg(dev, VDBGL "error reading F/W version\n");
> +			return;
> +		}
> +	}
>  
>  	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
>  
> @@ -286,7 +309,7 @@ static void hfi_sys_property_info(struct venus_core *core,
>  
>  	switch (pkt->property) {
>  	case HFI_PROPERTY_SYS_IMAGE_VERSION:
> -		sys_get_prop_image_version(dev, pkt);
> +		sys_get_prop_image_version(core, pkt);
>  		break;
>  	default:
>  		dev_dbg(dev, VDBGL "unknown property data\n");
