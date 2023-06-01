Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E271F275
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjFAS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFASz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:55:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8993137;
        Thu,  1 Jun 2023 11:55:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so1767951a12.1;
        Thu, 01 Jun 2023 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685645755; x=1688237755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3lDxoepCotRm5g8FmHuYHCp7Kw5DHj9NlnnBObc7C0=;
        b=LspfDwwu0agFSlesNyPc16GF73NRIzLGQX0dggyRENMz5sxChLm+2fO9GJdhtloMu2
         uzCqa511Tn9y8kg4OVqMFBaYucEaSUhGsGiOF8r7Qke5fN56Ci3JGb7AaSM8cYn9X2Y2
         2u2f3g7voyelZ07YV8cLRcFui+u9NRL9Ussoa9OG7WSMsFKGCqyQ3quGp9UpcEd2yDn1
         9UgQ5j8PxLqmzsfpzaMuvGY+T1pIWF9wdYhVpIPxmmjYBpAM9LfB8KdioJS+ATSSOU80
         PmcOHOeVHSYb8Dl4VdkSU3ir+p3jJAz6vrJGBQJZu6FOWBoPK0spka7zBwj2kT9eq195
         wtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685645755; x=1688237755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3lDxoepCotRm5g8FmHuYHCp7Kw5DHj9NlnnBObc7C0=;
        b=hYm272baur9NULWH+TZuhqR4qYVXfImTzwLshJ2Pwze8GE/Bei6Ildi97pqEvqXzTj
         OJcIFSV+HT4ccxEuFr2uOZ7WOGmGUJI8V4w6sFAyyM/SjU6YZypStWkccbI5WlZSXjFu
         Yr4ZMYEL4hJ66ksBAdtGv+j5j/9LOzEpXg1kJl1mq6ocd/OIb4vQ4vOR1R/FPYnWVsOR
         l1SlfASJxWT1459RbRhZ2HoGfhPKCxa7/+3QfdMoLlKg2zbF0oZLjrqDj6ljkNHoZGjb
         hAyyuMem8vvVwS9FxYKsMqVj34e46ogXpUZejQUYB3vzpopY3XlqL7ANGB2cVjNVkaEv
         LmiA==
X-Gm-Message-State: AC+VfDxodby5Hbl9c7mhhedeFZaqNk+ll5pNzWTfPMDM8sEyZGLWLc4n
        mIHV1/zBxMzSbGrwrqPe6ShQzLcRnBuS3A==
X-Google-Smtp-Source: ACHHUZ5v17sxhOVW4SbCe8kdp+/1vwAyqZlUA/agwNrEA3Z8CZkWH1W1KIEfT1VywtH+5JP5hGZFjQ==
X-Received: by 2002:aa7:d403:0:b0:50b:c397:bbac with SMTP id z3-20020aa7d403000000b0050bc397bbacmr573668edq.29.1685645755137;
        Thu, 01 Jun 2023 11:55:55 -0700 (PDT)
Received: from [192.168.3.32] (dh207-98-93.xnet.hr. [88.207.98.93])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b005149c3fa632sm5876632edv.13.2023.06.01.11.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 11:55:54 -0700 (PDT)
Message-ID: <d64b9718-0c85-6e5d-7c5b-6ea617e36a32@gmail.com>
Date:   Thu, 1 Jun 2023 20:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 04/13] dt-bindings: clock: qcom: gcc-ipq5018: remove q6
 clocks macros
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-5-quic_mmanikan@quicinc.com>
 <514a9e26-aeb9-ce05-1055-337646098ec1@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <514a9e26-aeb9-ce05-1055-337646098ec1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 05. 2023. 13:01, Krzysztof Kozlowski wrote:

> On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
>> Since Q6 firmware takes care of bring up clocks in multipd
>> model, remove bring up clock macros.
>>
>> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
>> ---
>>   include/dt-bindings/clock/qcom,gcc-ipq5018.h | 21 --------------------
>>   1 file changed, 21 deletions(-)
>>
> I am fine with this if it still compiles... I have doubts about it,
> unless of some depedencies (you mentioned three !)... but then it gets
> complicated.
>
> Keep patches doing same logical change in same patchset. This dependency
> dance in recent submissions is making things tricky and prolonging your
> upstreaming process significantly.

Considering that the basic IPQ5018 patchset that this series depends on
has not yet been merged, why not just drop these there instead?

Regards,
Robert

>
> Best regards,
> Krzysztof
>
>
>
