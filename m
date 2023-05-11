Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1819F6FF724
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjEKQ01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbjEKQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:26:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8746E89
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:26:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f450815d02so17265975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1683822382; x=1686414382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF5be2sbBRpbJkglPQmtYdfxdzXzFcyuT/Uqn8tbJs0=;
        b=3AcKBS2AKkP+hgitbm+wq3uVskTmKG/0vaBTKI0L6vILE+f5VBLOBe0TL8plhGdu7B
         eZGrsawTX63q6E5lGFY78BmIvUlegj5yP/PWEUT8Ay6yKjoe/vZKeSCHIpKpFgsV+pyQ
         nIg+08ZJpvfMALLQIqtfPBcMWEsZ3fqeEVRgGQmG/FrneojZRUMDFQYQR2/5rfUwcdae
         8KDKsoutI4e5thG//4KPHXocQfP8dyqweODPb88V5Ef8WtZcBQvMmThuwHxyfT7bIyQo
         E4eYfi+ze6IkGD9wXXXMIgPiMdAOnyVEKTQ8F2feJD4ZT7CHLVCiGCH8nYozpX9vjQNq
         uHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822382; x=1686414382;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF5be2sbBRpbJkglPQmtYdfxdzXzFcyuT/Uqn8tbJs0=;
        b=Dg+Q799/yNXqKjMLxFDWHR66YNZA+l/G/ogV87fNEZfdrFXYH7Xz2KDMXdwI5DGeVV
         TEJGgSfW8B0DsedGlHNy6swLv6y6jRIo7IuqBmFrM2KlS7X6rXJBXHLcD8IIaL2FLlGS
         6l/84DOJXnE1apM5av35QC2ithe2JT26ODAGNz6nZ8ZIoXQTI9N94AtXqChWqqraD4c5
         37v+1lQLn78DkBT6m6ujWaPMmp4kL0Ea3s9uqWOXmF8T5awjvWaEROn510IfQGDKKBRZ
         XK3Ywp5C2DWzIO2guw0jhkEGo7Z9dWlfr02QaFr02G8rbFpGWEgu3ytlVrDrdzQ/JGHX
         2jeg==
X-Gm-Message-State: AC+VfDzVCSHazGyxH1kcB64Hq69vIo0w12LWwhb5jk3rQakS2PU8DEKP
        ltUFvWea70bM3qzxHJtq5g6JWA==
X-Google-Smtp-Source: ACHHUZ71SlSxsCaeilcIYcDc28kvbiCwHxN4BH39zGfpp8GeZyI0S1Zx9G4r3sqDUBDRnZoDtZ+WOw==
X-Received: by 2002:a05:600c:243:b0:3f4:2b72:eaa9 with SMTP id 3-20020a05600c024300b003f42b72eaa9mr7321645wmj.8.1683822382087;
        Thu, 11 May 2023 09:26:22 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f26-20020a7bcd1a000000b003f423f5b659sm13528211wmj.10.2023.05.11.09.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 09:26:21 -0700 (PDT)
Message-ID: <40d8c92e-458e-ace9-2fab-6fc3da580221@nexus-software.ie>
Date:   Thu, 11 May 2023 17:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: defconfig: enable TYPEC_QCOM_PMIC
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230511135503.198538-1-krzysztof.kozlowski@linaro.org>
 <016ab311-cc66-b1c7-4099-f63e8f3644b8@linaro.org>
 <ca7a8499-0ac9-43d3-45ab-c974b1a2a564@linaro.org>
 <CAA8EJpptzh1w5-WgybEOOa59PTgo5z7CEr5vstWwhH7naBttjw@mail.gmail.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <CAA8EJpptzh1w5-WgybEOOa59PTgo5z7CEr5vstWwhH7naBttjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 15:52, Dmitry Baryshkov wrote:
> On Thu, 11 May 2023 at 17:36, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/05/2023 16:14, Neil Armstrong wrote:
>>> On 11/05/2023 15:55, Krzysztof Kozlowski wrote:
>>>> Enable CONFIG_TYPEC_QCOM_PMIC necessary for full USB Type-C support on
>>>> Qualcomm QRD8550 and MT8550 boards.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    arch/arm64/configs/defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index a24609e14d50..8b6407d2059d 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -991,6 +991,7 @@ CONFIG_TYPEC_TCPCI=m
>>>>    CONFIG_TYPEC_FUSB302=m
>>>>    CONFIG_TYPEC_TPS6598X=m
>>>>    CONFIG_TYPEC_HD3SS3220=m
>>>> +CONFIG_TYPEC_QCOM_PMIC=m
>>>>    CONFIG_TYPEC_UCSI=m
>>>>    CONFIG_UCSI_CCG=m
>>>>    CONFIG_TYPEC_MUX_GPIO_SBU=m
>>>
>>> This driver isn't used on SM8550, only CONFIG_TYPEC_UCSI is needed.
>>
>> Indeed, apparently I messed something with config while looking for
>> other options. Patch can be skipped, the driver has no users in upstream
>> (and bindings are still missing :( ).
> 
> ... And it will be hopefully removed by landing Bryan's patches.
> 

I actually reuse this CONFIG option so I can stack this commit last in 
the series - it will just switch on the new driver instead.

---
bod
