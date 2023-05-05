Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB76F895F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjEETOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjEETOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:14:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECB922682
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:14:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso2496380e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683314045; x=1685906045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5H9rVQL/hXwX4C6YQKIXB1iFe6xi2aNzDtdSIAxJ2gM=;
        b=UmZCoToMmakn7dH/ICSWg39uBStU5GkZ2U/j94bYpEWR0wo0sJ/Tn7E2bX7lnvq/3F
         tnfNgUWgX6+jvput1Mktzhi5xsNvxh+8V8L1Nbn/zUOhIuO5wpmOFuxbnPD+yI8PUoRO
         QWb+pYDJGiNPMtNWhUg8cgDaYj3FC3qmqoyn3IXRAdpSsK3dasXxuo0Cnq7YxSBrnq6W
         9/nAVXOcK3MvC1GFw8SS+UEjFOslGOe74ztZYAqkv8zcrmX8opVwWOEFIOxk8XYN16CU
         YScXIK/KyX+lRcU0uBw/p4chjGUUoohm+x/NJHMa4zZ3cxBf1piIUROEiPgkVF4QJjsh
         iGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314045; x=1685906045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H9rVQL/hXwX4C6YQKIXB1iFe6xi2aNzDtdSIAxJ2gM=;
        b=CtTWJ7ywYq/bid5d/S3JXkTK5XDWQ/w7cH0qr/K8zpsIE8gp5OxB0Kz1q/m6j7UIZd
         FJPkq69uT4J4kaWiqLflDAirb7F6dREh2xuQPuo0goKGXeLYg6RGxjpxXaVGz/FTEIwC
         IGKVxqvtR4qZLJTylNsTwAXvdaKrq6O0C6fh9L8s7hu1A4QSFgQa9R80zdoPD8/0ue+l
         GvWtNil5htAPX66RTS1QRIgZ/HaZ86jTc326WAbSC69Q1Ci2sWvj3zHTq6R9CGIBkJT2
         ozBiy7gfbb7fotkLnz75nrwGBmzAPxffRkUEZiTW1en3GRdCu0jClcnyBfDR+LiET94O
         x0LQ==
X-Gm-Message-State: AC+VfDyNL1b6oxePVAH9RZHZdYxA9DpKyPtn0611gpP6vpTSbSY8ecUV
        WLAs+Mloz5VTAjM0oqUzwzuIHA==
X-Google-Smtp-Source: ACHHUZ7YW2zqy886AN83zUF7iGZVZPj2cQtQZFHOjTO95qsoc3txQ7z3DMc2p4uIV0/4y+Dl3W9TGA==
X-Received: by 2002:a05:6512:49b:b0:4dc:4b92:dbc4 with SMTP id v27-20020a056512049b00b004dc4b92dbc4mr783194lfq.14.1683314045218;
        Fri, 05 May 2023 12:14:05 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id q11-20020ac24a6b000000b004f1415aebc4sm384512lfp.255.2023.05.05.12.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:14:04 -0700 (PDT)
Message-ID: <538f4a97-c9f1-9e27-ef2c-0e2411d4d60d@linaro.org>
Date:   Fri, 5 May 2023 21:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 11/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_and_video_core_idle()
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
 <20230228-topic-venus-v2-11-d95d14949c79@linaro.org>
 <a4c104d4-39d1-4b33-28c9-80a383c61f8e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a4c104d4-39d1-4b33-28c9-80a383c61f8e@quicinc.com>
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



On 5.05.2023 15:36, Vikash Garodia wrote:
> 
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> IS_V6() should have instead checked for specific VPU versions. Fix it.
> 
> This is again not a fix. The patch just adds a video hardware AR50_LITE, which is
> 
> not supported on existing driver yet. With existing code, IS_V6 covers the video
> 
> hardwares which are enabled by the driver.
ack

Konrad
> 
> -Vikash
> 
>>
>> Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 6d5906fab800..82aa7deeafa1 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -1537,7 +1537,7 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
>>       void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>>       u32 ctrl_status, cpu_status;
>>   -    if (IS_V6(hdev->core))
>> +    if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>>           cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
>>       else
>>           cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
>>
