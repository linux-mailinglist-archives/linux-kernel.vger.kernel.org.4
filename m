Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC66F8962
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjEETO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEETOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:14:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523282272D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:14:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so24341811fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683314053; x=1685906053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5xc7ui/gS3gulLT/1faky+1BssywybhSB3N5Tb5FKk=;
        b=CAdwWbMGthf1M7t1G2ZuyCrQT0W1MY0xMzdmhX5avDic6wMPUNAR6dsGlvSXJEJguk
         2vGBr7/Jg2GNLT/YsHCe3+K5sF9nke+AlwjHuDW3Sn2Qa36rkZL8sOimBfQ0jfUaCWrZ
         Ej/AgSdIuZM1eRRfWRdfv3mBHIDY0ggvJTez2tie/BQAUXcX+9bfiTZkRHLsT6xiMff2
         VARzb2WpibWSbz6rqJSUu5OK14ML8E+77g05QGkBdjerKCoV5XE+iOYO6GxercK5+56D
         mTnlTMavo4zDMyro5/IsX/4yGFKVGEDu4GwgjBQAqtLaO8q7DF3X7kIfZf9yDaBvjwqy
         87Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314053; x=1685906053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5xc7ui/gS3gulLT/1faky+1BssywybhSB3N5Tb5FKk=;
        b=H6TJibBjtrN6HGt29bc6KGAx8ucd52/iayQ/q6LLRELqS015o0ANyeKSNL+M8/Sd6l
         Xq0dW+uhrC/ginfLZA7ts0zens4fyz9yQ/xSIYoT1EnxkCJW/2GorMAwB40DYkoPSzuL
         /z8qebshBrp6BEDzr0LsStbokQVNKLNVBMaSgFaL+jj+/I2soKie/fAg4X+bmQslPk/f
         Lplf298/iySKoVeeOt77NXF9cNzt5dBNbACrQKlG30z+FRgwlH+ZHkPY1RMe1mE2WLYy
         io3mONQ1E2jJgjIA//Zas+Nkas5iIXObQsP06KXyHiXGYtao5e26Pur1yxem+WXoNqZl
         Zzag==
X-Gm-Message-State: AC+VfDx6g6q3078kpD4uSNY87YmGbZHnoKkvvAobLLRYNO0hkwAuJCd5
        NJJJUHipINlsF8RfMNmSbsK0Dw==
X-Google-Smtp-Source: ACHHUZ4Tuz2IZnNCmJZ3L9NX3hRWjZHlM1FnKK60v4rtrSqdyCSMMF/6SC1ASapkO/F8YgwQ9PspxA==
X-Received: by 2002:a2e:9818:0:b0:2a8:bdff:8556 with SMTP id a24-20020a2e9818000000b002a8bdff8556mr686171ljj.13.1683314053565;
        Fri, 05 May 2023 12:14:13 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id j28-20020ac2455c000000b004ec6252aa37sm386829lfm.116.2023.05.05.12.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:14:13 -0700 (PDT)
Message-ID: <70a6060b-2808-b68d-cb1f-4ad24e566de7@linaro.org>
Date:   Fri, 5 May 2023 21:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 12/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_idle_and_pc_ready()
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-12-d95d14949c79@linaro.org>
 <4c0fb166-4b58-56fb-d1e2-54bcddc3aab3@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4c0fb166-4b58-56fb-d1e2-54bcddc3aab3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 15:40, Vikash Garodia wrote:
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> IS_V6() should have instead checked for specific VPU versions. Fix it.
> This is again not a fix. The patch just adds a video hardware AR50_LITE, which is
> 
> not supported on existing driver yet. With existing code, IS_V6 covers the video
> 
> hardwares which are enabled by the driver.
> 
> -Vikash
Ack

Konrad
>>
>> Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 82aa7deeafa1..d6df99a921bb 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -1557,7 +1557,7 @@ static bool venus_cpu_idle_and_pc_ready(struct venus_hfi_device *hdev)
>>       void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>>       u32 ctrl_status, cpu_status;
>>   -    if (IS_V6(hdev->core))
>> +    if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>>           cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
>>       else
>>           cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
>>
