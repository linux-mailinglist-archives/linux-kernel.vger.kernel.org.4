Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8F36B09CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCHNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCHNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:49:04 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25A7EA31;
        Wed,  8 Mar 2023 05:48:59 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e13so15401324wro.10;
        Wed, 08 Mar 2023 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678283338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tco07tSmEQBiv71NXDzVf5aD4DjBEdds3t5x2RXjRVw=;
        b=DlvVULZUotz3deOjlXFKnSNlgdpST98uhJdHZ4e1NXMBbrrYUb2k8Dct5mbtiAcB3c
         48FtqBgntAVXTBP7MOEHhk6XmX4vBJrQ4EM5HDtmFFEoZLJWu/nij0cmec+t2P24C20E
         aYfDxqzNoZ8RAp4nr9Km9xo01iFVcYZ/XgD7STYZjOMZFdVJEH3qj0Zyncwl3enOt9Ey
         9ZMzOXmQz5iIj4YNmV1PvhJxtk03O89K2eQPSDCwlSsr1swh09q9v++wrQXeut/LURkn
         ZcNl7e7o/f3dJM0FPa1dWaXWA76B0MCZ7zrOfKPKF0oXFmvjQ3txwsxaUHlolDCVnTyf
         IFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678283338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tco07tSmEQBiv71NXDzVf5aD4DjBEdds3t5x2RXjRVw=;
        b=X8ri75Lg3zg5efTaJ/i6CJVE6BxqPR4f2vtC5KWuL5K+/666DryGTjfoyLnNpwzII9
         Dj8W4RO5yiT17LnrPwvAshDCtLVmZOFAFEGyqjpzFwpKs4rUlDluge1N93l+Ybr512D1
         tSb1AcacsuAU8oFup7R6PXBMB/wI8RLAPnpNwP0eZmXZFF6CeOlMP6hvSU9OKimx74ER
         pWkjseKJUCV1ktLhKNFZJ3KGCeAPk4c1HxL6fcDG/uJdmGRYQUefAgZD0RdlGsYcmtGj
         7ox1jJoFy0qifBlWi/SSA+SYJ2dUqetQzCx/zQsaKR5W8vZ6/o5SfaMsu6QBhm+RyUPg
         sPCA==
X-Gm-Message-State: AO0yUKUP7QZgOBZYRKtcM1IxY8qFiLTLXRAZTqWugdOsJIJgL5LpBHE1
        9rNeYDR7Xn3L2eRfYp+v2QxGclnNsY+5EA==
X-Google-Smtp-Source: AK7set+VxlNFqlHpPXLEDvE8dh540twa/JaSY1eUa88H3atwrzzplcAsjKwRn/MlGcuB7PdRi6/KJw==
X-Received: by 2002:adf:f6c8:0:b0:2c5:4ffb:b5d4 with SMTP id y8-20020adff6c8000000b002c54ffbb5d4mr12353195wrp.19.1678283338052;
        Wed, 08 Mar 2023 05:48:58 -0800 (PST)
Received: from [10.28.0.5] ([194.126.177.75])
        by smtp.gmail.com with ESMTPSA id e18-20020adffc52000000b002ca864b807csm15271790wrs.0.2023.03.08.05.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:48:57 -0800 (PST)
Message-ID: <81468734-d25e-ddda-7bd1-1498ca6fa6ae@gmail.com>
Date:   Wed, 8 Mar 2023 14:48:56 +0100
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
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <615d907e-fd7c-f235-405b-d112f1373280@linaro.org>
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

On 3/8/23 13:53, Srinivas Kandagatla wrote:
> 
> 
> On 07/03/2023 15:23, Dmitry Baryshkov wrote:
>>
>>> Make qcom_scm_call, qcom_scm_call_atomic and associated types accessible
>>> to other modules.
>>
>> Generally all the qcom_scm calls are a part of qcom_scm.c. I think it is better to make qseecom_scm_call a part qcom_scm.c (as we were previously doing) rather than exporting the core function.
>>
> 
> Other big issue I see in exporting qcom_scm_call() is that there is danger of misuse of this api as this could lead to a path where new apis and its payloads can come directly from userspace via a rogue/hacking modules. This will bypass scm layer completely within kernel.

I'm not sure I follow your argument here. If you have the possibility to
load your own kernel modules, can you not always bypass the kernel and
just directly invoke the respective SCM calls manually? So this is
superficial security at best.

I guess keeping it in qcom_scm could make it easier to spot new
in-kernel users of that function and with that better prevent potential
misuse in the kernel itself. But then again I'd hope that our review
system is good enough to catch such issues regardless and thoroughly
question calls to that function (especially ones involving user-space
APIs).

Regards,
Max

> 
> --srini
> 
>> If you wish to limit the kernel bloat, you can split the qcom_scm into per-driver backend and add Kconfig symbols to limit the impact. However I think that these functions are pretty small to justify the effort.
>>
> 
> 
>>>
>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
