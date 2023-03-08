Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9A6B0C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjCHPKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjCHPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:09:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191676923E;
        Wed,  8 Mar 2023 07:09:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so1533429wmb.3;
        Wed, 08 Mar 2023 07:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678288191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YansXf0zLq5T5P19iJ7DLNxHDaMmpSGOLn6e9R569vU=;
        b=R/PnVQc7RbtXCtpiHwNNFYuv2ogwZ3Zd8AxDWv1cH8R7imqn53c//vb5ggnuQJzwXX
         r4u2VYpnx6bglLJ2VAx7vZzHQT3YGrrlwNyu+svzNK0QZIP7O8E/L6iBtNY6VG0XFdI4
         1BPBprIh2kHWX9jpKYvYCgcm3a/+mLvF1fgT7MW87ZukhQ4d7z1D9oh3TFDcATMGnauO
         gnEFBdZD23Ut+Jem7r3ZlZeY/wSXC1yqQrLCyTXWxbNMuiNSmcOyfI4IzgiuCNR2cOMU
         LRZhm5YUF5coOQ3otlxQtCPOKRp3Qc/nvS13CZ+Sd0kt8Wz9J+CbzVhM3ld9euMMiAHB
         134g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678288191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YansXf0zLq5T5P19iJ7DLNxHDaMmpSGOLn6e9R569vU=;
        b=JFgDMMREczYx51bccX4zhDWr4vlAKklS2zYdvVXjKWgLh8iDi7nYvM7IHdLxoBAxrX
         xufzvv0SOso+PDmUjtfQVR39Xg6m7reh2ePYqNT1XF+I5RNE8gadMvGAMRT3TbPOQPoh
         wdgjsQc9QASpVtVyyOWC2HWhtz7h9SPnWARWRrH3PW4A8DcJQsunIhb4KdXEzpk8xCLr
         pySH92V2yiVXTa3gu1+AQEMgIzUMTsf5U7EMRLpQ14+lQruvqHbvh/SqPHLw8tRg91Vq
         /dwGBlcwj366v49+cuFeIBo01DLk6agiUzxvPhV8tNaPbNtG2hKma7DHB8pz0yc6GjlP
         77kw==
X-Gm-Message-State: AO0yUKUD7BwUppEOQKvm9kKaFJSO2Xmk8zrZv9txm8R6I0bKCPTe9mDT
        OzHn31WKO/Tbw4fJLr2cZls=
X-Google-Smtp-Source: AK7set9NA759TkPEiy2zueCkzufiSYozuAdeanovTS3xJkyUpqquAcHFn8NI/2csXGnRA1KWIzyLRQ==
X-Received: by 2002:a05:600c:4687:b0:3e2:201a:5bcc with SMTP id p7-20020a05600c468700b003e2201a5bccmr16914704wmo.33.1678288191429;
        Wed, 08 Mar 2023 07:09:51 -0800 (PST)
Received: from [10.28.0.5] ([194.126.177.75])
        by smtp.gmail.com with ESMTPSA id hg13-20020a05600c538d00b003d9aa76dc6asm19805977wmb.0.2023.03.08.07.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:09:51 -0800 (PST)
Message-ID: <3144d7cd-0b17-6236-5575-cfbb1a71d1ab@gmail.com>
Date:   Wed, 8 Mar 2023 16:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm: Export SCM call functions
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-2-luzmaximilian@gmail.com>
 <a2c97f09-3360-b2b1-184a-8e3b869a70ef@linaro.org>
 <615d907e-fd7c-f235-405b-d112f1373280@linaro.org>
 <81468734-d25e-ddda-7bd1-1498ca6fa6ae@gmail.com>
 <afee5468-6c73-d088-e3ab-e9314492e49b@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <afee5468-6c73-d088-e3ab-e9314492e49b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 15:20, Srinivas Kandagatla wrote:
> 
> 
> On 08/03/2023 13:48, Maximilian Luz wrote:
>> On 3/8/23 13:53, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 07/03/2023 15:23, Dmitry Baryshkov wrote:
>>>>
>>>>> Make qcom_scm_call, qcom_scm_call_atomic and associated types accessible
>>>>> to other modules.
>>>>
>>>> Generally all the qcom_scm calls are a part of qcom_scm.c. I think it is better to make qseecom_scm_call a part qcom_scm.c (as we were previously doing) rather than exporting the core function.
>>>>
>>>
>>> Other big issue I see in exporting qcom_scm_call() is that there is danger of misuse of this api as this could lead to a path where new apis and its payloads can come directly from userspace via a rogue/hacking modules. This will bypass scm layer completely within kernel.
>>
>> I'm not sure I follow your argument here. If you have the possibility to
>> load your own kernel modules, can you not always bypass the kernel and
>> just directly invoke the respective SCM calls manually? So this is
>> superficial security at best.
> qcom_scm_call() will expose a much bigger window where the user can add new SCM APIs but with the current model of exporting symbols at SCM API level will narrow that down to that API.
> 
>>
>> I guess keeping it in qcom_scm could make it easier to spot new
>> in-kernel users of that function and with that better prevent potential
>> misuse in the kernel itself. But then again I'd hope that our review
>> system is good enough to catch such issues regardless and thoroughly
>> question calls to that function (especially ones involving user-space
>> APIs). 
> 
> One problem I can immediately see here is the facility that will be exploited and promote more development outside upstream.
> 
> ex: vendor modules with GKI compliance.

Fair point.

I still believe that squashing everything into a single driver is not
particularly great code/architecture style, but then again I'm not a fan of
vendors not integrating their stuff upstream either.

I guess we should be able to find something that has sufficiently low
complexity so that it can be implemented in qcom_scm while also preventing
external use like that.

Regards,
Max

> 
> --srini
>>
>> Regards,
>> Max
>>
>>>
>>> --srini
>>>
>>>> If you wish to limit the kernel bloat, you can split the qcom_scm into per-driver backend and add Kconfig symbols to limit the impact. However I think that these functions are pretty small to justify the effort.
>>>>
>>>
>>>
>>>>>
>>>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
