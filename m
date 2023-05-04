Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09F56F6D53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjEDNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjEDNvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:51:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357477A99
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:51:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f19323259dso5421895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683208277; x=1685800277;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia+gttW4I6LvUBG5SY7+uvZOarzTht1TFNe05mMpTpk=;
        b=pB+A7cw/XPrev2umTc3YsHilspF6/U/QiIgfXIniedgiA08ah46Deykj946XMt0u2y
         Mw+tBWUfmBc4iaXx5HNGNp944Puirx1W0gsAjLeqU8v0GTl4+2WSMWcMYBJyPfmagPtc
         JjQXWu5XVJ7Qg1Sr52c08EgHuYMgbB+9RMEzHg8qsv/MweVK0BVQnEffpSXVijyW0UI0
         oAZ+N6Fd8fGQuSatWZHCrO8qVLlpYBerll24uNGCmp223+7HStfZWX0nXRcoYyasosjh
         iqnlSL4E/SRzrxmm5EGEvjLpIn2oyKifdqbIMpoFt6APqYxykGIDAF53fPdzzD2Mwvbg
         c0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683208277; x=1685800277;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia+gttW4I6LvUBG5SY7+uvZOarzTht1TFNe05mMpTpk=;
        b=d44+1UsvKkMcoXuzb/EdoT6RoBwnzFjHfnq3cjmdl8AoSgjDoc9v4C+fWVc1ZWjmil
         hYzBimUhU/20rvAXgVd5iPKeffQiDgGgyH+nRX3tSF0IY2BsnyK/fMMKdeslDHPjmJnh
         4N8iW+5P28JKRa7UexKV4L+dpFSlVJlIvYXRci/d+0SedG80o7W6gRY0kDOvSCCtl00y
         9/NiRN4XSLT/2QsLkrKhbyqw+2J0+TuGyG2oftJDpWIBezTb4eIMxenUuK5+ZPGZ+Lpc
         nsA5CcJUZtZ4OS7rL7WbBb8z7ULpapKMzUpGXFjnC8WavlK+fjcqhOCy8s3b62KorN6T
         ubuA==
X-Gm-Message-State: AC+VfDwQyVHyVQOkDYxDUQdDhvSGbDhxBNZBGGL8irQ060vcmNtOnGYk
        +EbAdB+MLzfGL+ALe5XpA+QvfA==
X-Google-Smtp-Source: ACHHUZ6ZwWaOz2K2WY4hZIZsmmaqvKeH1ItRgvGs0B/4byIMgWQUU4hx3hiPHFqMPR4D2l2Nrt2SUg==
X-Received: by 2002:a7b:c4d9:0:b0:3ee:96f0:ea31 with SMTP id g25-20020a7bc4d9000000b003ee96f0ea31mr16924743wmk.18.1683208277602;
        Thu, 04 May 2023 06:51:17 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c214f00b003f18141a016sm5010961wml.18.2023.05.04.06.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:51:17 -0700 (PDT)
Message-ID: <66b8e665-1038-127a-1f4f-20d8fe7bcd8e@linaro.org>
Date:   Thu, 4 May 2023 14:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/4] venus: add support for 10 bit decoding
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
 <8df7f24b-9dbe-4491-bcb1-f53021bb482f@linaro.org>
In-Reply-To: <8df7f24b-9dbe-4491-bcb1-f53021bb482f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 14:49, Bryan O'Donoghue wrote:
> On 04/05/2023 11:36, Dikshita Agarwal wrote:
>> This series includes the changes to
>>    - add V4L2_PIX_FMT_P010 as supported decoder format.
>>    - consider dpb color format while calculating buffer
>>      size for dpb buffers.
>>    - update dpb and opb color format when bit depth
>>      changes is detected, also update preferred color
>>      format to P010 in this case.
>>
>> With this series, divided the previous version [1] into
>> multiple patches as suggested in review comments.
>>
>> [1] https://patchwork.linuxtv.org/project/linux-media/list/?series=10376
>>
>> Dikshita Agarwal (4):
>>    venus: add support for V4L2_PIX_FMT_P010 color format
>>    venus: update calculation for dpb buffers
>>    venus: add handling of bit depth change from firmwar
>>    venus: return P010 as preferred format for 10 bit decode
>>
>>   drivers/media/platform/qcom/venus/helpers.c        | 24 
>> ++++++++++++++++++++++
>>   drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
>>   .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  8 +++++++-
>>   drivers/media/platform/qcom/venus/vdec.c           | 16 +++++++++++++--
>>   4 files changed, 48 insertions(+), 3 deletions(-)
>>
> 
> For future reference a series like this should:
> 
> 1. Include a log of what changed between the last series and this
> 2. Describe which comments you addressed
>     I generally try to say
>     "Added newline to dts - Konrad"
>     "Sent the series as a -v3 - Bryan"
>     etc
> 3. Ideally provide a link to the previous series in
> 
> https://lore.kernel.org/linux-arm-msm/1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com/
> 4. Use versioning
>     This set should be prefixed with "v2-0000-cover-letter" 
> "v2-0001-add-support" etc
> 
> "git format-patch mybase..targettip --cover-letter -v2"
> 
> ---
> bod

Doh I see you did most of that - just missed the V2.

Please remember to version your subsequent series. "git format-patch -v2"

---
bod
