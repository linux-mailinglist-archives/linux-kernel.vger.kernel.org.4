Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE26D6CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDDTFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjDDTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:05:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15954C28
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:05:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k37so43686313lfv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680635104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5dgMuodeZyHzVT6FAH17HFaS4nHaYRdl9cH8QECjHA=;
        b=PNK48df4b81vGypDdYK41csF7ttvhDtcCM36t2Rf9srpmo6sWIaTkikR70C+xjmQwY
         HDdkLrvZoMeUdOfWQx+Kki6hp4deeHR+RAcu+jD3t7PESXxSJHtHsp88mPpvu5VLJUt7
         bGVODPHVLvxQYnzwJCVNBtqGywiLz0O/TyTMMK96AO5FiSvDWOr0ySpXFlma52Szu6+z
         C0tWn2pnb7WKrgE2PJFTfxalZFWbnr7wN0xYeVcyeWulOakmFDI0m+8o+Ffl5W4oiCxt
         pTmo68/Kb9tMkL1hVes1MgcRjxFmECX+wkAvLLAK91ji9LyWQwc8LFjSh1VcgoOf1ghq
         py1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680635104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5dgMuodeZyHzVT6FAH17HFaS4nHaYRdl9cH8QECjHA=;
        b=DBwlYknRS+1SSPRGefL3xchzE2oSDWeyCY/Xob3Bgsp1/OkI8G1lOI4b4MriPv7314
         IEaWCpEDQ+RjXRI5y4SJ3CvkxODIPSuHkebSmzDKHlixjcGoa907HI5CMn5NbsYTrteQ
         AHdbxgE3cVcVW4PjtDjuw0xr4NWjnzTc7juSa/U1fs2vcM7NI3PyDj7tZ4O3uzKYK6xq
         4mP7bvbE/+WYRSr+sUMuFpg8tD4FVuEXlQN9SMZRRpWjiAI5j9mFjMK1pZeeDuUqRzJp
         CxERE9IyWfbH2IIyNZ2Zq8W/g2xSsno+OJ9aQT1lsZY62z7ntNOoLUP+hTX4Z1LIEgON
         QT2Q==
X-Gm-Message-State: AAQBX9fQc886UgQmz662uYCGt9EN1k6E7QrmugZZELAEzvQU8yA5M3Dy
        N7HGHXOY9p1pJ2nPotAyqCL+IA==
X-Google-Smtp-Source: AKy350ZJm7DCWcawFstZhDR/T62LoyF1dMnhZc8JIB9o1LYekSdv0olD4QHgqYZPKKmJfDgn2RcvxA==
X-Received: by 2002:ac2:561b:0:b0:4eb:2a26:babf with SMTP id v27-20020ac2561b000000b004eb2a26babfmr89283lfd.0.1680635104208;
        Tue, 04 Apr 2023 12:05:04 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25610000000b004caf992bba9sm2467420lfd.268.2023.04.04.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 12:05:03 -0700 (PDT)
Message-ID: <2c3a823c-4620-1557-39ff-1db169aeb7aa@linaro.org>
Date:   Tue, 4 Apr 2023 21:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] venus: enable sufficient sequence change support for
 vp9
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1680589032-26046-1-git-send-email-quic_dikshita@quicinc.com>
 <1680589032-26046-3-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1680589032-26046-3-git-send-email-quic_dikshita@quicinc.com>
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
> VP9 supports resolution change at interframe.
> Currenlty, if sequence change is detected at interframe and
> resources are sufficient, sequence change event is not raised
> by firmware to driver until the next keyframe.
> This change add the HFI to notify the sequence change in this
> case to driver.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c   | 1 +
>  drivers/media/platform/qcom/venus/hfi_helper.h | 2 ++
>  drivers/media/platform/qcom/venus/vdec.c       | 8 ++++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 930b743..e2539b5 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -521,6 +521,7 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
>  		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*en);
>  		break;
>  	}
> +	case HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT:
>  	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER: {
>  		struct hfi_enable *in = pdata;
>  		struct hfi_enable *en = prop_data;
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index d2d6719..20516b4 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -469,6 +469,8 @@
>  #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
>  #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
>  #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
> +								0x0100300b
Also, nit: this one has a leading zero, whereas other properties don't

Konrad
>  
>  /*
>   * HFI_PROPERTY_CONFIG_VDEC_COMMON_START
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 4ceaba3..f0394b9 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -671,6 +671,14 @@ static int vdec_set_properties(struct venus_inst *inst)
>  			return ret;
>  	}
>  
> +	/* Enabling sufficient sequence change support for VP9 */
> +	if (is_fw_rev_or_newer(inst->core, 5, 4, 51)) {
> +		ptype = HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT;
> +		ret = hfi_session_set_property(inst, ptype, &en);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>  	conceal = ctr->conceal_color & 0xffff;
>  	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
