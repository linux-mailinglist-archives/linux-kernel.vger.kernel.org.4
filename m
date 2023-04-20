Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386826E9690
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjDTODv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDTODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:03:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD336195
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:03:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r9so2882841ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681999414; x=1684591414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVkfX9ez3svxYnnM8rJPmrSpJjSKXj7Id4d2FlN3kdo=;
        b=KqeZisWyrlpuDhOBtUm7MpDZRVm7fv6Ei87iod2bozueBqbASVy7qkz9awjAAVSP5G
         YDnnpUgTd7mwlkUWt7aH1UYTPsy4Hk8bptdN7qqtXz6sN3sMqtqR15StRbdvsf3ixTaV
         UNqN/1J3WmYyn+lJaeiZ0nOOWHRh5RGrGYeWFVOfI1N3FdHEKDIw9aqK0IWbwlkKi6bp
         NMhO2QeiJZZhKRZ6AKbth5AIz/xO1JoKcWWV019YJcp2fd0K+lSkvREX95yT15aACGRu
         snhW/lsMW4uu65AaijRCk8SCWAtcefRydH8VPjx78sD9fwFVNGpfgaKmmFjlmpSmcSTI
         l+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999414; x=1684591414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVkfX9ez3svxYnnM8rJPmrSpJjSKXj7Id4d2FlN3kdo=;
        b=hSO9lUnxJOZeFE3Z+q2EAOhIdcKDTH4nco0Xh7nYpEkILtUMJJ5+ltrdbGOKD+pbkO
         94dvbDQ4J++9n4ILzNRhHY5VZAlwEMa/vv/zj5UjrGc9n5VC5V0lzHo2mvZSJ8MXNz1u
         piDV+8rnSkZa0mzU2Dca8OI3kEWF8OMLAe7INNO78RM13NeD+SYuIFUT0HvQ+TD3VExQ
         L6qQPseE+1kYp8YuthMzO5SjMN+jBaC2vuLJaMW67lSUBf4DUYOQp8vMc6mttDAAtO27
         jHbWIkxoBGr/Fr7akpR8FvR8F8H8+vylabapyikDXC+Sb4fqckXg/F1nG6BhwRDT1X5g
         /hGQ==
X-Gm-Message-State: AAQBX9cN9WkjFbBrHo6bGxTtNb+RXwPNBFnIdRVTHgRgd0j3NPSY6ZO9
        2wnGlluc1Yl1LaMCJXCHKLSaeQ==
X-Google-Smtp-Source: AKy350aSqD3HOes9oTjJ/n7YRoirlTchXOp15cOD09I43xK+WajJIRohATh87yc9DNwJ8QMiWGguPA==
X-Received: by 2002:a05:651c:1504:b0:2a8:bb0a:2214 with SMTP id e4-20020a05651c150400b002a8bb0a2214mr2441992ljf.12.1681999414124;
        Thu, 20 Apr 2023 07:03:34 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e86d5000000b002a77792f2c5sm244736ljj.62.2023.04.20.07.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 07:03:33 -0700 (PDT)
Message-ID: <c2c0567a-8205-510d-bc0d-35b28dd64f70@linaro.org>
Date:   Thu, 20 Apr 2023 17:03:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] drm/msm/dpu: always program DSC active bits
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1681490777-15351-1-git-send-email-quic_khsieh@quicinc.com>
 <zs762prrzv2geulwa7ztlolmxgldiyynk22m5ak4ejbyzbctrp@jprtanslko7c>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <zs762prrzv2geulwa7ztlolmxgldiyynk22m5ak4ejbyzbctrp@jprtanslko7c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2023 02:02, Marijn Suijten wrote:
> On 2023-04-14 09:46:17, Kuogee Hsieh wrote:
>> In current code, the dsc active bits are set only if the cfg->dsc is set.
> 
> This is the old sentence from v1 again, did you accidentally send the
> wrong patch as the improvements from v2 are missing?
> 
>> However, for displays which are hot-pluggable, there can be a use-case
>> of disconnecting a DSC supported sink and connecting a non-DSC sink.
>>
>> For those cases we need to clear DSC active bits during teardown.
> 
> At least teardown is one word again, v2 had "tear down" which is wrong.
> 
>> As discuss at [1], clear DSC active bit will handled at reset_intf_cfg()
> 
> discussed* as pointed out by Dmitry, and make it clear that this is
> about clearing CTL_DSC_ACTIVE (and CTL_DSC_FLUSH?) specifically.  Once
> that is moved to reset_intf_cfg(), this patch should be reverted as
> there is no need to write the registers once again when cfg->dsc equals
> 0.

Kuogee, can we please get a proper v4? With all the relevant changes 
from v2, with the changelog, etc.

Otherwise the present Reviewed-by tags are just incorrect.

> 
> - Marijn
> 
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> Fixes: 77f6da90487c ("drm/msm/disp/dpu1: Add DSC support in hw_ctl")
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>
>> [1] https://lore.kernel.org/linux-arm-msm/ec045d6b-4ffd-0f8c-4011-8db45edc6978@quicinc.com/
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> index bbdc95c..88e4efe 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
>> @@ -541,10 +541,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>>   	if (cfg->merge_3d)
>>   		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>>   			      BIT(cfg->merge_3d - MERGE_3D_0));
>> -	if (cfg->dsc) {
>> -		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>> -		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>> -	}
>> +
>> +	DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);
>> +	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
>>   }
>>   
>>   static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>

-- 
With best wishes
Dmitry

