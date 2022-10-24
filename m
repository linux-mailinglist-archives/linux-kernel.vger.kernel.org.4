Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F46F60BD17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiJXWHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJXWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:06:50 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B07C26129
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:20:24 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id y10so7212586wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiQT7+HgE+jR4dsGrwJz3G94YiAtTC/9uOWXE+hCFGA=;
        b=okuddTzYO1TEbcOoHs3cETupscqVLFavT+ZuM0xyJ0FmgPOtwXLLbSGbDEtSB/vSeU
         6y6hfL8paCriUw/eTP1AK+UrvF0MefnhJeNHDN8IkYKopUW2gsjlEpe7qO05CMornGP6
         A/LjFxv0v2fI2RMpWEOfzutp13JkWalxwEGnj9maqqg3y/MLJSMyQaqp2b6KJFxuQwg1
         W3FzYiqHS4aVRPDo8ntcp0sUQCB/qsIIngYm5Ni9YktjINff7ZOOT32zUlXMZYrRElNU
         RzQtAYEkTjbeMKw3jFxDHXe2VisvcW2U/Q5eiSZnpLMcRcWRukJPHIEgwepD4RgDtXJQ
         UnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiQT7+HgE+jR4dsGrwJz3G94YiAtTC/9uOWXE+hCFGA=;
        b=0SWq2/BtNtFV6saDPqeCLoPiGZpXiE3ncOhu2zWavsHbhuiiWJDPPpHZyKLC5Lclna
         FNV4feHUJBC/wlWRHbVjJn4lKXZOE5ZEEPsrFjF4Ycw+8dRmxsldlviwe8ZKW7PrKcdP
         uHEAv1odcXBQJoTLXwi65h5mLEFDBk5m7ZRqXQDte/s4vThonjYIpfPaD44VdRJBiQFx
         DrJLqo90BF3LvnEIvjEdCbY002nbztFjJmpaeB8aC7nHAJO1X7PWsasUuITmt7MUpQfp
         ipYsPQKx3ZDmZk/rRwWc6c8O6uRzC5g3HwICk2P9+11aqUg+9ccM4JhhT2pNXwX4Th+B
         crBw==
X-Gm-Message-State: ACrzQf35oEdqYSepHPWkVYNh3UKV4rYIES2YBOuUn2AQpbj3mhPhKcnN
        EBMScT4MH8KvHtp3uGMNX4F17WgoTj3PLg==
X-Google-Smtp-Source: AMsMyM5EgP3jrP0MHpcLueOSzk0P2MHNxZCsG/d9Mt4n7Q/UQlJfwgjk70koZ+VpXSeqg6kzdf/TMw==
X-Received: by 2002:a05:600c:42c6:b0:3c6:f27e:cac8 with SMTP id j6-20020a05600c42c600b003c6f27ecac8mr23194116wme.175.1666641891081;
        Mon, 24 Oct 2022 13:04:51 -0700 (PDT)
Received: from [192.168.0.11] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003c6f27d275dsm9654212wmq.33.2022.10.24.13.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:04:50 -0700 (PDT)
Message-ID: <e5ae9c89-7890-9bd7-3583-483667391203@linaro.org>
Date:   Mon, 24 Oct 2022 21:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] net: ipa: fix some resource limit max values
To:     Alex Elder <elder@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alex Elder <elder@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jami Kettunen <jami.kettunen@somainline.org>
References: <20221024165636.3979249-1-caleb.connolly@linaro.org>
 <bf67b30f-074b-22b5-8d23-b1531ad30d74@linaro.org>
Content-Language: en-US
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <bf67b30f-074b-22b5-8d23-b1531ad30d74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2022 20:15, Alex Elder wrote:
> On 10/24/22 11:56 AM, Caleb Connolly wrote:
>> Some resource limits on IPA v3.1 and v3.5.1 have their max values set to
>> 255, this causes a few splats in ipa_reg_encode and prevents it from booting.
>> The limits are all 6 bits wide so adjust the max values to 63.
> 
> Thank you for sending this Caleb.
> 
> On IPA v3.5.1 (SDM845) I confirm that these resource limit fields are
> 6 bits wide, while the values we assign are in some cases 255, which
> cannot be represented in 6 bits.  Your fix in this case is proper,
> changing the maximum limit from 255 to be 63.  (Just in case, I've
> sent a note to Qualcomm to ask them to confirm this, but I think this
> is fine.)

Great, thanks

> 
> I re-checked the definitions of the MIN_LIMIT and MAX_LIMIT fields
> for IPA v3.1, and it turns out in that case the *register field*
> definitions were wrong.  They should, in fact, be 8 bits wide rather
> than just 6.  So in that case, 255 would be a reasonable limit value.

Heh, well that's fun... Thanks for checking

> 
> Did you observe these splats when doing actual testing on an msm8998
> (which has IPA v3.1)?  Or did you just double-check the code?  I
> looked at the other currently-supported platforms and didn't see
> this sort of problem elsewhere (IPA v4.2, 4.5, 4.9, 4.11).

I found these just by 'grep'ing for "max = 255", none of the other versions had 
that and I didn't see anything obvious at a glance so I expect only these two 
platforms are affected. The same issue has been confirmed on MSM8998: 
https://gitlab.com/msm8998-mainline/linux/-/issues/39

Jami (CC'd) has offered to test the next revision of the fix there so we can be 
sure it works on v3.1 and v3.5.1.
> 
> 
> Could you please send a new version of your patch, which fixes the
> register definition in "ipa_reg-v3.1.c" instead?
> 
> It might be best to fix the two issues in separate patches, since
> they will parts pf the code with different development histories.

That makes sense, will do.
> 
> Thanks!
> 
>                      -Alex
> 
>> Fixes: 1c418c4a929c ("net: ipa: define resource group/type IPA register fields")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/net/ipa/data/ipa_data-v3.1.c   | 62 +++++++++++++-------------
>>   drivers/net/ipa/data/ipa_data-v3.5.1.c |  4 +-
>>   2 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/ipa/data/ipa_data-v3.1.c 
>> b/drivers/net/ipa/data/ipa_data-v3.1.c
>> index e0d71f609272..7ff093f982ad 100644
>> --- a/drivers/net/ipa/data/ipa_data-v3.1.c
>> +++ b/drivers/net/ipa/data/ipa_data-v3.1.c
>> @@ -187,53 +187,53 @@ static const struct ipa_gsi_endpoint_data 
>> ipa_gsi_endpoint_data[] = {
>>   static const struct ipa_resource ipa_resource_src[] = {
>>       [IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS] = {
>>           .limits[IPA_RSRC_GROUP_SRC_UL] = {
>> -            .min = 3,    .max = 255,
>> +            .min = 3,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DL] = {
>> -            .min = 3,    .max = 255,
>> +            .min = 3,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DIAG] = {
>> -            .min = 1,    .max = 255,
>> +            .min = 1,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DMA] = {
>> -            .min = 1,    .max = 255,
>> +            .min = 1,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>> -            .min = 2,    .max = 255,
>> +            .min = 2,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_HDR_SECTORS] = {
>>           .limits[IPA_RSRC_GROUP_SRC_UL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DIAG] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DMA] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_HDRI1_BUFFER] = {
>>           .limits[IPA_RSRC_GROUP_SRC_UL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DIAG] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DMA] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS] = {
>> @@ -272,36 +272,36 @@ static const struct ipa_resource ipa_resource_src[] = {
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_HDRI2_BUFFERS] = {
>>           .limits[IPA_RSRC_GROUP_SRC_UL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DIAG] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DMA] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_HPS_DMARS] = {
>>           .limits[IPA_RSRC_GROUP_SRC_UL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DIAG] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_DMA] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES] = {
>> @@ -345,22 +345,22 @@ static const struct ipa_resource ipa_resource_dst[] = {
>>       },
>>       [IPA_RESOURCE_TYPE_DST_DATA_SECTOR_LISTS] = {
>>           .limits[IPA_RSRC_GROUP_DST_UL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_DST_DL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_DST_DIAG_DPL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_DST_DMA] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_DST_Q6ZIP_GENERAL] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_DST_Q6ZIP_ENGINE] = {
>> -            .min = 0,    .max = 255,
>> +            .min = 0,    .max = 63,
>>           },
>>       },
>>       [IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
>> diff --git a/drivers/net/ipa/data/ipa_data-v3.5.1.c 
>> b/drivers/net/ipa/data/ipa_data-v3.5.1.c
>> index 383ef1890065..42f2c88a92d4 100644
>> --- a/drivers/net/ipa/data/ipa_data-v3.5.1.c
>> +++ b/drivers/net/ipa/data/ipa_data-v3.5.1.c
>> @@ -179,10 +179,10 @@ static const struct ipa_gsi_endpoint_data 
>> ipa_gsi_endpoint_data[] = {
>>   static const struct ipa_resource ipa_resource_src[] = {
>>       [IPA_RESOURCE_TYPE_SRC_PKT_CONTEXTS] = {
>>           .limits[IPA_RSRC_GROUP_SRC_LWA_DL] = {
>> -            .min = 1,    .max = 255,
>> +            .min = 1,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UL_DL] = {
>> -            .min = 1,    .max = 255,
>> +            .min = 1,    .max = 63,
>>           },
>>           .limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
>>               .min = 1,    .max = 63,
> 

-- 
Kind Regards,
Caleb (they/them)
