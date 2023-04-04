Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933C36D6BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjDDSZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbjDDSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:24:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07024C2E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:22:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a11so34858742lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680632561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gCsbCvTCgaRyB9wS8Q3xuu2Nx7yr20kYCx9UApEX9HE=;
        b=pQcruk62SM9JprxSleDZCweUkHcc4/pN6Kips+B4RetrsoJ93Zl/p7/I+7ioy39a12
         MyyB70JpxZAVqwfnWDBHmRCvPBHsJoav64L4iXUAxbJd1tgsoNLKgymK1qwFbkRyGYmW
         QHUm3wl3IrJnzAgetDDf5GmFfSRz14i4ag1z6/wH8F0g6POEHgmh9auN+RwtxJWPTxem
         kIPKuiUnumQwR/O2GGdImFAf+o68qzeNMUSAtIIL+m2gnfWiWH+1uxP+0ijmdjRCqiHh
         45KC4gvcUShNhJzGIe8fZhptv58ayfS1GevgkcXmPale8V4hkxYvyDq+DFxMzbvOy3ql
         ZR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCsbCvTCgaRyB9wS8Q3xuu2Nx7yr20kYCx9UApEX9HE=;
        b=qg/zC/8fZBpphkxAuWYKrExqthr44ie+JmrLXpUjCYL8ETgkjxOAwncW5KRhhXmLQX
         LcO+le7ieq7rAoi5VeJtlPp+D2xzsSZ9NNMRQyU2949n/nsQE/C43s5ZZKJDd7zyHAXz
         cN7NpDMxu4CJ2H0ErfAphTF4HI/dSHaFww5Ymc563ZVT9MJaGF3BzT0PcmDjq5KuRS93
         mPIMjxnfA+gPg6fqa37UyBzrn1Gknq++0WZVc1hJCk+HpZg/r7CLxN3DCAKS5r0tLkLA
         73aQSND5n1SJ3uSy83SZxCFVA0qzkovBsLNle4fAVn7oP/UfqULk90az0bILeXuJy41+
         b74w==
X-Gm-Message-State: AAQBX9fHnzsnDRXvuiP6JHx0FXk+LdTIEhVhhwltZN9dELFG34Lq3luS
        uoRNuFaQHzsdsDYU6/L1WIjzUg==
X-Google-Smtp-Source: AKy350amooGyjgE60rmOZStLcfFrZJssPaQsBXH+2h13GWe5K3DiXU/Zh3sujpFhXylGHNj2nd9Iow==
X-Received: by 2002:a2e:99d4:0:b0:299:5d3a:4f29 with SMTP id l20-20020a2e99d4000000b002995d3a4f29mr1184378ljj.31.1680632560746;
        Tue, 04 Apr 2023 11:22:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id m14-20020a19520e000000b004cb1de3f487sm2428259lfb.104.2023.04.04.11.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:22:40 -0700 (PDT)
Message-ID: <8f0404d0-659d-0855-15dd-8a45f6fd1871@linaro.org>
Date:   Tue, 4 Apr 2023 20:22:38 +0200
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
Does it never have to be turned off? Or does it happen automatically
at session closure?

Konrad
> +
>  	ptype = HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR;
>  	conceal = ctr->conceal_color & 0xffff;
>  	conceal |= ((ctr->conceal_color >> 16) & 0xffff) << 10;
