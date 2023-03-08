Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467226B0775
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCHMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCHMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:53:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138CB8609
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:53:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a25so65523375edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66PBEHLuoBHi5dP79a5TGRn1C5ICF0qRu69ManVqQR0=;
        b=K1HkAKtDVpeQ4XArvfQu0D+mZCmjmHYnXtRR/EdZtvb2noWLzodKeDhezQHx+K5gcK
         3jSaa2wQy2yWpGZgCrusY2K//W0qBy085ndtPdCcfsT06/f+BdX03OepLmgvzC4nZJtX
         LU8cbfKOy/IM0LKmrFqe4GO7JQbtQNNYJCNGdfUHM8rX+8UOvMDBAJ72QTo0R00ae40M
         ATgEXTlf7yIe6EyrIELaZ82xXqprCsatJV/FhMTTYiinbsFkTp+eGrFPUG4NLfVXNg85
         Ays+BVBKm/RpPbEO3ZArk0C3p/MoFJH8Vjp6dElbv9n/TK18HwFs1ZUwO+bbswzlur5B
         O0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66PBEHLuoBHi5dP79a5TGRn1C5ICF0qRu69ManVqQR0=;
        b=XBnygrnGqhuBKnh1UqaNAs4QFTE1+rd2skiogC/uFeuye0YeCoZ+bK7FuoPljX04RL
         n5s4Uqpw18EoyvnFN3PyxsmRi356foaGyAW99rVh8QdZYm8E/PsVpz2qH7vdJs2j+gRn
         N/cfdKesyPME1WGSY/CP/TpF01J9uPrxNhrFhKBa/znDP5oYcERCDa8idj199VeP1ybt
         fFspHG7hvQgx8y1huQq+OoTo1BOEIp6X9jMBpu2oDytRfJhv+gqZNt5bo5CLPugUD383
         DiYgWTPLFvyIBja6jjrRwq6e2lELZE3XiwlVbC1b4+9XjV7ei0hPb4LVS4q5Ne6VeUH3
         qBNQ==
X-Gm-Message-State: AO0yUKU67LflAOEDdMASHt1toTsJgTpB3nmOcwF+8SERwRq4A7VW5L6A
        m2MiuwqKpB+MOI4wOu/dbnLhKw==
X-Google-Smtp-Source: AK7set+E35x60NTcteiH0pNOUZAw9vG7PdnXC0LoxRe3x7P7UWNCvpb2BGmoA3MNv+KLUHytkEGxww==
X-Received: by 2002:a17:907:72c9:b0:889:b38b:4bb2 with SMTP id du9-20020a17090772c900b00889b38b4bb2mr21140310ejc.49.1678280024347;
        Wed, 08 Mar 2023 04:53:44 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id uk19-20020a170907ca1300b008cecb8f374asm7427112ejc.0.2023.03.08.04.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:53:43 -0800 (PST)
Message-ID: <615d907e-fd7c-f235-405b-d112f1373280@linaro.org>
Date:   Wed, 8 Mar 2023 12:53:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/4] firmware: qcom_scm: Export SCM call functions
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <a2c97f09-3360-b2b1-184a-8e3b869a70ef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 15:23, Dmitry Baryshkov wrote:
> 
>> Make qcom_scm_call, qcom_scm_call_atomic and associated types accessible
>> to other modules.
> 
> Generally all the qcom_scm calls are a part of qcom_scm.c. I think it is 
> better to make qseecom_scm_call a part qcom_scm.c (as we were previously 
> doing) rather than exporting the core function.
>

Other big issue I see in exporting qcom_scm_call() is that there is 
danger of misuse of this api as this could lead to a path where new apis 
and its payloads can come directly from userspace via a rogue/hacking 
modules. This will bypass scm layer completely within kernel.

--srini

> If you wish to limit the kernel bloat, you can split the qcom_scm into 
> per-driver backend and add Kconfig symbols to limit the impact. However 
> I think that these functions are pretty small to justify the effort.
> 


>>
>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
