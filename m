Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233FA74A0DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjGFPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjGFPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:23:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1593F1BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:23:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69ed7d050so12711211fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688656986; x=1691248986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdvJkszoG2WTtY67CN8XCdp6tfD5oO0tTKafld7lvz0=;
        b=ywM1c4n1OkVzUIqNTxjUt1vlyKoY2LC3Qedpos1g++zkqm/JCVVC1WiUXn94sEq1Ms
         5/GYiZPbSe9dJqJ/WY0zkiW670vqLdCATtRGcpg0d9rjAdqZOg3ezVR0KBx4PN8L/g2F
         x1z9OUgzWpFVyIGW6ePGAckvStupfqImL0ZLTU5sg77HUX9+D1oNC7m4+8TZLeCWqYmf
         xYL9uaVYFRwRQcOira1I0ctbSCk8ft7zy0+LuaKRNkgVWFvipT2ac5ks+isPg0zTr2Nq
         yeWiRtjcAyT/gxbw7/qBeu7IZOEhiUuadoVuooM5jWCAKEi6mCWsgpdO0IJNnEcGNZhk
         xWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656986; x=1691248986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdvJkszoG2WTtY67CN8XCdp6tfD5oO0tTKafld7lvz0=;
        b=ADG61X7OkrupVdAjMdpE2BnAjbFRy21R3fAgdnIX6S+k93PeCFKYbE0RVUngKcJH83
         +2swE5uN0FeF+OK3Q93Uf5vkyJ1DJUjno9j7i772HJVVVAEAEcheHhb3oXofL42FZH4z
         sB7EvWulOhKGzZ71zwGVK9M+3SDXgG4eCPor/aYnevY1/uZ6aSYvHZl7lb3lQWkLT4Ee
         qoFyxmi/67voyrDD5VkFK/Y6vnxn6k2TBHCoc4ZUwak32lqwyR8LXyWQg3bmb86GOYCq
         oxAxJAxwimnwwwdUgBmgMQFX6n8q741/ScSsGtl85u2nN2k4T8CFik2NxKS9QwuS0784
         Y0Mg==
X-Gm-Message-State: ABy/qLaHZbgXH/mR7Tki2pnjKxv6Gx05MpiUipXeOqBL/ZooiA9A3PFj
        xCTKLeiHyKmClwvcaht+7AfJRw==
X-Google-Smtp-Source: APBJJlELlfY0wD9lt1xSwuQ5SH6WJu54uwvb1v1yMI8PPgqzmXg0veE0Pz1A3cEnIcvXbJX4onJSSg==
X-Received: by 2002:a2e:9b15:0:b0:2b6:d8cf:2f44 with SMTP id u21-20020a2e9b15000000b002b6d8cf2f44mr1635708lji.13.1688656986366;
        Thu, 06 Jul 2023 08:23:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id r15-20020a2e94cf000000b002b6efce3f54sm354289ljh.123.2023.07.06.08.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:23:06 -0700 (PDT)
Message-ID: <f8152ec7-e38f-d215-3e1f-3165912b4031@linaro.org>
Date:   Thu, 6 Jul 2023 17:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba
 support
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688650209-25119-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688650209-25119-2-git-send-email-quic_rohiagar@quicinc.com>
 <4042fa22-8948-49c9-6e5c-dc8926ed5f99@linaro.org>
 <6d067262-d8af-f6f3-4ef7-870eafa15f46@quicinc.com>
 <8b04d830-4710-7f26-09e8-326b69d72396@linaro.org>
 <a50921ca-c858-dacc-6849-4898fdf7683c@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a50921ca-c858-dacc-6849-4898fdf7683c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 17:11, Rohit Agarwal wrote:
> 
> On 7/6/2023 8:34 PM, Konrad Dybcio wrote:
>> On 6.07.2023 16:45, Rohit Agarwal wrote:
>>> On 7/6/2023 8:05 PM, Krzysztof Kozlowski wrote:
>>>> On 06/07/2023 15:30, Rohit Agarwal wrote:
>>>>> Add support for the pm7550ba GPIO support to the Qualcomm PMIC GPIO
>>>>> binding.
>>>>>
>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>>>> I doubt that all your patches here and other patchsets are v1. Otherwise
>>>> how did you get my Acks and Rbs? Please use proper versioning and
>>>> provide changelog.
>>>>
>>>> What changed here?
>>> Actually this is part of the original bigger series [1] that as per Bjorn's suggestion need to be broken
>>> down according to the subsystem/maintainer.
>>> Since it got broken down into multiple smaller series, I didnt include the versioning.
>> All of that information should be included in the cover letter, to
>> limit confusion both for maintainers and patch workflow tools.
>>
>> Since these patches all come from a separate series, it would be
>> good for you to version this one as v(BIG_SERIES_REVISION)+1 because
>> they've already been on LKML at least once. That would especially hold
>> true if this revision included any changes.
> Understood. Will send all the smaller series again with v2 as version with changelog.
v3, this was essentially a v2.

Konrad
> 
> Thanks,
> Rohit.
>> Konrad
>>> [1] https://lore.kernel.org/all/9de424ca-271a-8ed2-5550-658a828c4ea5@quicinc.com/
>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
