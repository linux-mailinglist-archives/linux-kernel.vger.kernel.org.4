Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBC66F6887
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjEDJnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjEDJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:43:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0546B0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:43:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f13ef4ad91so286345e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683193414; x=1685785414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZgXOhUfnp5pJIsv21UC9FCZiuaRHfI+r6ej6LwX1czA=;
        b=x4mY+8MQ4cCMDgMWtjDPg1XoNMPfyfWnbJSFBHQQct9ML+Y6lmtuKv2846Ji5ouFPc
         c0mH8wwu6vmFRJXSGNEr735/lrU2kZKG+ymEcPeN2kyG1Z+liGB1pKnthPOxxffOcMzp
         fQlTyYGYWk3NuZKc1FmC+2g2e5MQwVA6BDaqMMTwL1C5NLiPbD2sntuf4By79PcBg7YS
         qVSd7Zn6SKsM4gfck2xE2qVKxgmvqkYmTOipajIGoJ/PbmsVMilFE+3VyuE9FOifI5oy
         2boyoqnZynoupHM3YiHhThJrIZ4qXR9ZrsPAPp4zaMJBXiLENNNOsLzlln6wE3lugFPH
         XctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193414; x=1685785414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgXOhUfnp5pJIsv21UC9FCZiuaRHfI+r6ej6LwX1czA=;
        b=GNvdN55TnE1iEMUw/4QvTddmpPtHC6lr9OR9brSAOz0+gKs45IsKeNyzN0bMx5UipD
         2PMjSSAkgdRX/DMGD4X5UkgHTyJAOtDYdtjSMhTo5MmoTJZZZnjTiLkYB50y1S78pmLJ
         NPSUUdc62WlsgvYEsanWr3J9cgGhybv77Agl48y1hSAp4YlY5lNxvqzYuqGnxTTxm6TD
         +xfZctTXleK6MHuYK6+AoB3U7BjdDbguiJM4vEAmFnvQIJD10zbnooxYJq8I1HSRtxbv
         nSatUmDD/PQqMbg7yh8nDNruoCdOFc4Ab4gZKbvYIuWXmgmJ+S1iDnoofpbhI6n01ppR
         bDVA==
X-Gm-Message-State: AC+VfDxsl42VTtv4k+7YaX5NCggLZgpWGZfhpuHdLV7MfDQjHRp77XMl
        uXn/jCXpJmFIwC1EOIikg/SOEQ==
X-Google-Smtp-Source: ACHHUZ4F6Ifn9xK8prHeWXgzeH8ijLXnXm406B+U0B6h42hqXIHYNu7HqD6BQHTdIkLVeduFOV9NLQ==
X-Received: by 2002:a19:c209:0:b0:4e0:a426:6ddc with SMTP id l9-20020a19c209000000b004e0a4266ddcmr1490243lfc.0.1683193413979;
        Thu, 04 May 2023 02:43:33 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25330000000b004f1411c0ac5sm307138lfh.79.2023.05.04.02.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:43:33 -0700 (PDT)
Message-ID: <b4abc8aa-bcd6-ae5c-1bab-5916f1e4a541@linaro.org>
Date:   Thu, 4 May 2023 11:43:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 2/3] venus: enable sufficient sequence change support
 for vp9
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Viswanath Boma <quic_vboma@quicinc.com>
References: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
 <1683193152-5808-3-git-send-email-quic_dikshita@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1683193152-5808-3-git-send-email-quic_dikshita@quicinc.com>
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
> VP9 supports resolution change at interframe.
> Currenlty, if sequence change is detected at interframe and
> resources are sufficient, sequence change event is not raised
> by firmware to driver until the next keyframe.
> This change add the HFI to notify the sequence change in this
> case to driver.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Tested-by: Nathan Hebert <nhebert@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
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
> index d2d6719..2e03b6e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -469,6 +469,8 @@
>  #define HFI_PROPERTY_PARAM_VDEC_PIXEL_BITDEPTH			0x1003007
>  #define HFI_PROPERTY_PARAM_VDEC_PIC_STRUCT			0x1003009
>  #define HFI_PROPERTY_PARAM_VDEC_COLOUR_SPACE			0x100300a
> +#define HFI_PROPERTY_PARAM_VDEC_ENABLE_SUFFICIENT_SEQCHANGE_EVENT \
> +								0x100300b
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
