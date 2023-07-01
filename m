Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26061744894
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGAK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGAK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:56:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D070E3C02
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:55:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso4674381e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688208957; x=1690800957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7+jU9LpPJg9EehaJpVm5VjMnguXv1PuXkPwCYOUgQk=;
        b=RMTftJM7u4c/lcq5Kiu4tD9+Gc5eKlF5ZVUEIxbkTRVUlBEGNjIC2YzrY63xeeG5ir
         c/4p1/+rCZwYTgVlHjp0gjLOGU02trzuPm9VtR3ATEDFotvwDNo5TuPllR870o55st/t
         X0K/f6785V14Ov949qwF3hsQM0vYQU6nU+EcP9N0+CiYebm4vN4SGkFgvoGp5p3OWBjF
         feC16pM3L6rzOMaX0+jegJ4ljEv4DTJzjQtNGJxoEHk3i0QWYtZOyFyb/XP1OAr/Leuj
         0up12xQ/G7GTGxyZ4lrWiD4W02khPCXHKTAqDQV9I3CfsfsR2puTLyCZU9kAps3OuCdV
         3YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688208957; x=1690800957;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7+jU9LpPJg9EehaJpVm5VjMnguXv1PuXkPwCYOUgQk=;
        b=Xxxf/TsRuDZJKKhH2sG20dyMDm/FJ+iQ/TtQknijbVIT5L4UCmDdE/bLrsmdQOSE+f
         4H7/KC+OIT4qRuuk6exlF0NjvfNZw9vOUDWlsk0mIIyb3xuwFhjj5Yr4WWyZMn2oYTGw
         fDxUsrj/FbVM13BsdPSlxunmn8BS8s/VyEW1hPLhq1kiRRYCdk/o3reVhbuUBS3/2S32
         KJH6YLPcxZBr9y8mxP6fhkOBEVIFrhipafkbmOVwGOtvN5rM2NLbwzMSJr9/xSLCeLPC
         P6Kr9LhhvxLktt1aeQZzaxwcDlDPSk/zfTRJrpCd3un3EScdk4JaG+kSOH0hFxg2YGfr
         ydPg==
X-Gm-Message-State: ABy/qLb21lvfY7IpNAQeBNqpAMLCMIjG4Mv2ig2xeOK4myQ7lfPg1dy/
        pPXvCPbstNrNg2158U2ykNhF4g==
X-Google-Smtp-Source: APBJJlGjWzze0Nw3aT298AyAOE/oLbH2N8dBcxHY1zC+9qyeCKLoYE8E6UHWwwJNQ4NwqUkLM8d6tw==
X-Received: by 2002:ac2:4bca:0:b0:4f9:ec5e:d624 with SMTP id o10-20020ac24bca000000b004f9ec5ed624mr3905398lfq.38.1688208956879;
        Sat, 01 Jul 2023 03:55:56 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7dd47000000b0051bf57aa0c6sm7800333edw.87.2023.07.01.03.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 03:55:56 -0700 (PDT)
Message-ID: <bc56e3be-7d0b-5420-978e-125d66ae8f72@linaro.org>
Date:   Sat, 1 Jul 2023 12:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 10/13] remoteproc: qcom: Add Hexagon based multipd
 rproc driver
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
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
 <20230521222852.5740-11-quic_mmanikan@quicinc.com>
 <2061a641-4b97-1aa6-27cd-99f01a785033@linaro.org>
 <54f06704-a849-7049-5956-31cb4765a1eb@quicinc.com>
 <8cf34ab3-fa8b-90f4-215e-bbfb0c41fade@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8cf34ab3-fa8b-90f4-215e-bbfb0c41fade@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 12:29, Manikanta Mylavarapu wrote:
> 
> 
> On 6/27/2023 6:09 PM, Manikanta Mylavarapu wrote:
>>
>>

Do you see the lines above? You quote my reply and claim it is you who
wrote it.

Please fix your mailer, it's making discussions unnecessary difficult.


>>>> +      Say y here to support the Qualcomm Secure Peripheral Image Loader
>>>> +      for the Hexagon based MultiPD model remote processors on e.g. 
>>>> IPQ5018.
>>>> +      This is trustZone wireless subsystem.
>>>> +
>>>
>>> ...
>>>
> 	I didn't understand. Can you please elaborate your comment?

https://en.wikipedia.org/wiki/Ellipsis

> 
>>>> +    int (*powerup_scm)(u32 peripheral);
>>>> +    int (*powerdown_scm)(u32 peripheral);
>>>> +};
>>>> +
>>>> +/**
>>>> + * qcom_get_pd_asid() - get the pd asid number from DT node
>>>
>>>  From node name? NAK. It does not work like that. Node names can change
>>> and you did not define this number as part of ABI.
>>>
>>> Probably you wanted unit address.
>>>
> 
> 	Yeah i got your point. Each of the WCSS PD's are internally
> 	represented in Q6 with their corresponding "spawn" bit numbers.
> 	I will use same and remove the "PD-" hardcodings.
> 
> 	Is this fine ?

I don't get what you are going to use, so post a patch. Talk is cheap.


Best regards,
Krzysztof

