Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D76944AC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMLim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBMLii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:38:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207B26593
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lu11so31114664ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8vF+glCGL/TIHZAeFd6umlQYUbpkh549EdL910Nq6g=;
        b=pbzrgTDa/e/4xlg4PGDTCGTOAIrar5NNyj1XRDqVj2OW2kFztgpd8dfuWPW2mMUB5/
         Kam3Hmw6s1u9RG7HZC8au2k//hLg4JZ+MdamafPtasioKUV8usFJ+bR+VDvQZSuTDc8c
         DTQCRhiuXbjC6otr2LbJS9OWT5S7jNCs+X2eCIzRzyhdOnPm5rzYZBroC5YSQGpCQzMR
         KQYXwL0XuYBbZiHOnjZkRocRjs5WQnddxMVHQaJtbPZUzz2lnE000ZBWOg04wz6tXkAb
         rTgkgL0CfKG2SfKyeioa/MzemDIdfpFlwBjHMCs5qdhfbukBEnQD8tHbuD8DkDTKEUgi
         YIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8vF+glCGL/TIHZAeFd6umlQYUbpkh549EdL910Nq6g=;
        b=xCb+mgfGOLX/V/gmlHgUsKPlIG0zEPothqAkCftaXC93aIoouPvUGBO0i0lGg43tyV
         zsyuMSLxNAAkjf6gQgK5GSj7UUizMNrflFB2ntazltGHulmoUeL04ZJd6SHE3JIbWvYA
         1RHJ8k0+hBy1HvteYEMQ9Vc0gp1m6ZthHCxXF1E9MyzgCriUhcDTG36t/LNKZlmXEVcU
         F+RLm9D2OFSAaYIa63xyAGll8lP/FjdVwyaEAArTAh0TpCe0oHinpBgOPCRpMIYPHJRD
         TzPnn71QjwTBYjcUN1421kKwYLl96Y8KdtBvM7wvVrI+SAORDx9vFNIJwH/6f/pfgjy+
         BB6A==
X-Gm-Message-State: AO0yUKXHfNnBK2b760nsRmQyI+VsuqoNbhTIA3fHRa6G+BTN3d3VCchN
        LYlwLuy0a90SXqUT0HCJcKHKQ39igaPmmYbZ
X-Google-Smtp-Source: AK7set8vw+ntyrLewHqJOjyeT2fk0N1lSDwSYCQMzlHCi7qiYZ98Cc2LOazfM4b9+yhsYZF/cbKmtA==
X-Received: by 2002:a17:906:9b96:b0:8af:370a:c1f8 with SMTP id dd22-20020a1709069b9600b008af370ac1f8mr20437423ejc.23.1676288315728;
        Mon, 13 Feb 2023 03:38:35 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n8-20020a1709065e0800b0087fa83790d8sm6755316eju.13.2023.02.13.03.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:38:35 -0800 (PST)
Message-ID: <e6653ceb-bce1-9552-019d-278f455ba8a5@linaro.org>
Date:   Mon, 13 Feb 2023 13:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/10] drm/msm/dpu: Allow variable SSPP/INTF_BLK size
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-6-konrad.dybcio@linaro.org>
 <20230213111220.ietr4aro6xu4emtu@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213111220.ietr4aro6xu4emtu@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 13:12, Marijn Suijten wrote:
> On 2023-02-11 13:26:51, Konrad Dybcio wrote:
>> These blocks are of variable length on different SoCs. Set the
>> correct values where I was able to retrieve it from downstream
>> DTs and leave the old defaults (0x1c8 for sspp and 0x280 for
>> intf) otherwise.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 242 +++++++++---------
>>   1 file changed, 121 insertions(+), 121 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 802050118345..d9ef1e133c1e 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> [..]
>> @@ -1848,10 +1848,10 @@ static struct dpu_dsc_cfg sm8150_dsc[] = {
>>   /*************************************************************
>>    * INTF sub blocks config
>>    *************************************************************/
>> -#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
>> +#define INTF_BLK(_name, _id, _base, _len, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
> 
> Dmitry and I discussed in #freedreno to instead add the INTF_BLK_DSI_TE
> macro that accounts for the INTF TE registers using this higher register
> area, as well as an extended signature to configure extra interrupts.

Yes, that's still the plan. It's slightly painful that we are touching 
this are simultaneously.

> 
> (Besides, I think the len is currently only used for snapshot dumping
> and no validation for out-of-blk reads/writes)

Yes. Because in most of the cases non-existing registers seem to be RAZ/WI.

> 
>>   	{\
>>   	.name = _name, .id = _id, \
>> -	.base = _base, .len = 0x280, \
>> +	.base = _base, .len = _len, \
>>   	.features = _features, \
>>   	.type = _type, \
>>   	.controller_id = _ctrl_id, \
> [..]
> 
> - Marijn

-- 
With best wishes
Dmitry

