Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D982F6F70DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEDRaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:30:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D74ED7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:30:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f14468ef54so934589e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683221417; x=1685813417;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USgyYClOAh8hG0SxXXCYpGkelSi9AZ1K2lmrTQ+brls=;
        b=CIAIVw9KsGwAnLtm7y1fdStcCxRZj5+30HgtUTyRkivn/xZGI/8SUcFG/WTUBdfwNX
         +qgYiXhGyeoVbTUm9Tr4vnIenPQz6RPiMVX4IZoBws/e92GZAGbXrKhrJOkB9YbQ2bsv
         Eh4MGR1m7IEmT+uWYOL5NTOZywKS+xe5y36xx8npnVREHcx3sNhWT/0i8I4s3iAur48b
         ryT+W4eL51pOAjo3Zd8OQ+HodIGDU5FEZDkzR9awYmYv0u0GQeHGGQMDfT2/l+Z+i0KC
         Nz0WymJdNH1oPGzaX7b0mjq4ZVeqlcRulxkjywNmDTvmc5o3UCuaed6KdPjbOZt2onxk
         GjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221417; x=1685813417;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USgyYClOAh8hG0SxXXCYpGkelSi9AZ1K2lmrTQ+brls=;
        b=XUeahpIi11UZdZjnFQX4nPJLS1KewSsmz1pNWKbPP3QOq+oMcwF6rDmU7efy7vc567
         9Ug8PvOsDNQ6ebRKViFykI7ZyuXJ9Fe9mSyEDvuJ+WlsGEAVr7q5YW+Jr9SlRVE4eI0q
         wzgQ+i533TnuOGwpkx5jz9nKaX4GuUF5Fcokhu5MrCWQT+XW95Ix6ggqaj+MqEnd239x
         hjDDXIgrWcLFk+097j5/76LCnTAyykTQkaYJD/heuzJroa0RDEMuSIIitACk4ojmEkPb
         PfTUNzf+BxdWBIP7MYh31egsOYYa2+fE1Orusdhj2gNrFOu73MhbZ0cgJ6dVDdZD6aPi
         DyNg==
X-Gm-Message-State: AC+VfDymmP1aDyjs2m+sL/wSmaAF01kRrkK1OSJ1iXlUfwl7rfupzBVS
        cngldcqopYLv+KX7LwZeOv94XA==
X-Google-Smtp-Source: ACHHUZ6BDKSG/UfzEsZOwOXle9LxvxwrYDGdcfaJFM6ZuV3WqBDURrT/+UajKqa7HMn+ORI7m2/l/w==
X-Received: by 2002:a19:ac08:0:b0:4f1:450b:a13 with SMTP id g8-20020a19ac08000000b004f1450b0a13mr623007lfc.2.1683221417603;
        Thu, 04 May 2023 10:30:17 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b004edce1d338csm6577223lfg.89.2023.05.04.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:30:17 -0700 (PDT)
Message-ID: <68ee1330-3319-d39e-8628-8ebc1b856a21@linaro.org>
Date:   Thu, 4 May 2023 19:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/4] venus: update calculation for dpb buffers
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <1683196599-3730-3-git-send-email-quic_dikshita@quicinc.com>
 <a37ff9da-d8d8-0af0-6d08-3d8858fe49f9@linaro.org>
In-Reply-To: <a37ff9da-d8d8-0af0-6d08-3d8858fe49f9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 19:29, Konrad Dybcio wrote:
> 
> 
> On 4.05.2023 12:36, Dikshita Agarwal wrote:
>> Use dpb color format, width and height of output port
>> for calculating buffer size of dpb buffers.
>>
>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> ---
> Looks sane but I'm not exactly an expert on this
> 
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>  drivers/media/platform/qcom/venus/helpers.c          | 4 ++++
>>  drivers/media/platform/qcom/venus/hfi_plat_bufs.h    | 3 +++
>>  drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 8 +++++++-
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>> index 5946def..4ad6232 100644
>> --- a/drivers/media/platform/qcom/venus/helpers.c
>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>> @@ -641,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
>>  	if (is_dec) {
>>  		params.width = inst->width;
>>  		params.height = inst->height;
>> +		params.out_width = inst->out_width;
>> +		params.out_height = inst->out_height;
>>  		params.codec = inst->fmt_out->pixfmt;
>>  		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
>>  		params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
>>  		params.dec.buffer_size_limit = 0;
>>  		params.dec.is_secondary_output =
>>  			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
>> +		if (params.dec.is_secondary_output)
>> +			params.hfi_dpb_color_fmt = inst->dpb_fmt;
>>  		params.dec.is_interlaced =
>>  			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
>>  	} else {
>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>> index 52a51a3..25e6074 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>> @@ -12,8 +12,11 @@
>>  struct hfi_plat_buffers_params {
>>  	u32 width;
>>  	u32 height;
>> +	u32 out_width;
>> +	u32 out_height;
>>  	u32 codec;
>>  	u32 hfi_color_fmt;
>> +	u32 hfi_dpb_color_fmt;
>>  	enum hfi_version version;
>>  	u32 num_vpp_pipes;
>>  	union {
>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>> index ea25c45..3855b04 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>> @@ -1185,6 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>>  	enum hfi_version version = params->version;
>>  	u32 codec = params->codec;
>>  	u32 width = params->width, height = params->height, out_min_count;
>> +	u32 out_width = params->out_width, out_height = params->out_height;
>>  	struct dec_bufsize_ops *dec_ops;
>>  	bool is_secondary_output = params->dec.is_secondary_output;
>>  	bool is_interlaced = params->dec.is_interlaced;
>> @@ -1235,7 +1236,12 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>>  		bufreq->count_min = out_min_count;
>>  		bufreq->size =
>>  			venus_helper_get_framesz_raw(params->hfi_color_fmt,
>> -						     width, height);
>> +						     out_width, out_height);
>> +		if (buftype == HFI_BUFFER_OUTPUT &&
>> +		    params->dec.is_secondary_output)
I suppose this line could be unbroken

Konrad
>> +			bufreq->size =
>> +				venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
>> +							     out_width, out_height);
>>  	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
>>  		bufreq->size = dec_ops->scratch(width, height, is_interlaced);
>>  	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
