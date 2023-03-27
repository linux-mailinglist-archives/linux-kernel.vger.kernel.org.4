Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4529B6CA1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC0Kxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjC0Kxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:53:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850110C9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:53:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c29so10832090lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679914409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WnzOjHdVfvoCMG3pjVqA605yGhXEuWWs9v71lH5Wbo=;
        b=Xm77A2gZGJkkJRtH7/hFJbceaoRhHoVaOSxcCKITYDDDP4yT2vupGTRCWt74OJ+uen
         KpfmZs5f/A++PJKPsZoJ6OjGV1chdMTpQIT9W34thZ+h4J+1HBG5uQf/ULfnLqhSEhAR
         0z2ytp0tax/KYyx3JEkAfBBO2lIHsftrPRqBA0YLEYkSMMT15/0t3CAd6SrcqN+1g47q
         jtkLfIFkq1wFK11UujS6j+bkWaqUZk227f5/1D2vBf3KRUDoEd5LbNqToHxKTLKtfdwf
         J+kVvbDFHlA86Mza2ojvGiC3UT4ARSxK1gD8jkyOI8I6qp3idVgIagCeWYrDvpCAtJqL
         J5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679914409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3WnzOjHdVfvoCMG3pjVqA605yGhXEuWWs9v71lH5Wbo=;
        b=NzPugeRJYwSEEFZ44Z5xbW+t2TUcutUBq6D1BXhws/T9Z5POP4hvRR66f9eP+bmXeM
         lr5PpKGqgaaWu0BzkIeMqIqBe/yPnaOp8hRevHPVpxriYeI3oRTHMqO5iFTyi0I7RFWb
         fprZYBipwbN9nSN0EbKfn7tUB2UZb7coOHJfnE7BlxIepbrrkdnYwqZJbBAJ7VKjMGcB
         PCZKhmRAPNE7n4WaCRpaNdkWjzckE/VM+jHicOdoJP2aBnekKUodoNKpxsXHs9S2W+Pz
         ik+Ku6wLjeInKv5Qo1488cJRqvPhnUieC8FdYJZhjPrE5YSAO3kGVKAaLYMFRZn36mAC
         orEg==
X-Gm-Message-State: AAQBX9ert7PbpPAYrYSBTrTbmMiiRErmsb2TLFYffYoeOUb4i8Zz/zGc
        kB9BgvtM6QI0CKxZjsN3IeKRuQ==
X-Google-Smtp-Source: AKy350aYInrCK0ZXczOvivBLQCQFlcg1lhhCSj4cNtly1U8Jiy5o34ej8P5uE+5wVjEIyQgO5SUasw==
X-Received: by 2002:ac2:5541:0:b0:4e0:2455:3ade with SMTP id l1-20020ac25541000000b004e024553ademr2952253lfk.60.1679914409515;
        Mon, 27 Mar 2023 03:53:29 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y28-20020ac2447c000000b004eafa141a12sm2075784lfl.9.2023.03.27.03.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:53:29 -0700 (PDT)
Message-ID: <d8ff650c-fd6a-bec4-354b-eb7b27b6394e@linaro.org>
Date:   Mon, 27 Mar 2023 12:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] remoteproc: qcom: pas: add SDM845 SLPI resource
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230325132117.19733-1-me@dylanvanassche.be>
 <20230325132117.19733-3-me@dylanvanassche.be>
 <a27e7e67-a3e8-01ec-1f0d-717d705af117@linaro.org>
 <91875b7f6f77d6bc846e2da6d009b44c89cbafab.camel@dylanvanassche.be>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <91875b7f6f77d6bc846e2da6d009b44c89cbafab.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 11:34, Dylan Van Assche wrote:
> Hi Konrad,
> 
> On Mon, 2023-03-27 at 10:44 +0200, Konrad Dybcio wrote:
>>
>>
>> On 25.03.2023 14:21, Dylan Van Assche wrote:
>>> Add SLPI resources for the SDM845 Qualcomm SoC to the Qualcomm
>>> remoteproc q6v5_pas driver to define the default firmware name
>>> and GLink edge name.
>>>
>>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>>> ---
>>>  drivers/remoteproc/qcom_q6v5_pas.c | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c
>>> b/drivers/remoteproc/qcom_q6v5_pas.c
>>> index c99a20542685..d82b6f4bced4 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>>> @@ -1028,6 +1028,22 @@ static const struct adsp_data
>>> slpi_resource_init = {
>>>                 .ssctl_id = 0x16,
>>>  };
>>>  
>>> +static const struct adsp_data sdm845_slpi_resource = {
>>> +               .crash_reason_smem = 424,
>>> +               .firmware_name = "slpi.mdt",
>>> +               .pas_id = 12,
>>> +               .auto_boot = true,
>>> +               .proxy_pd_names = (char*[]){
>>> +                       "lcx",
>>> +                       "lmx",
>>> +                       NULL
>>> +               },
>>> +               .load_state = "slpi",
>>> +               .ssr_name = "dsps",
>>> +               .sysmon_name = "slpi",
>>> +               .ssctl_id = 0x16,
>> Isn't this identical to sm8150_slpi_resource?
>>
>> Konrad
> 
> Yes it is. I added a new entry because for SM8150, SM8250, and SM8350
> they are duplicated as well. The SDM845's struct is indentical to
> SM8150/SM8250/SM8350's structs.
Well, you just found a quick improvement to make then! :D

Konrad
> 
> Kind regards,
> Dylan Van Assche
> 
>>> +};
>>> +
>>>  static const struct adsp_data sm8150_slpi_resource = {
>>>                 .crash_reason_smem = 424,
>>>                 .firmware_name = "slpi.mdt",
>>> @@ -1201,6 +1217,7 @@ static const struct of_device_id
>>> adsp_of_match[] = {
>>>         { .compatible = "qcom,sdm660-adsp-pas", .data =
>>> &adsp_resource_init},
>>>         { .compatible = "qcom,sdm845-adsp-pas", .data =
>>> &sdm845_adsp_resource_init},
>>>         { .compatible = "qcom,sdm845-cdsp-pas", .data =
>>> &sdm845_cdsp_resource_init},
>>> +       { .compatible = "qcom,sdm845-slpi-pas", .data =
>>> &sdm845_slpi_resource},
>>>         { .compatible = "qcom,sdx55-mpss-pas", .data =
>>> &sdx55_mpss_resource},
>>>         { .compatible = "qcom,sm6115-adsp-pas", .data =
>>> &adsp_resource_init},
>>>         { .compatible = "qcom,sm6115-cdsp-pas", .data =
>>> &cdsp_resource_init},
> 
