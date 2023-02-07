Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D268DD59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjBGPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjBGPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:51:46 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C3170A;
        Tue,  7 Feb 2023 07:51:44 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-15fe106c7c7so19489890fac.8;
        Tue, 07 Feb 2023 07:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oFFVAGXmAn33jC18iARlTq1W8BZjLwMZcFPq63oKn2w=;
        b=N0M+DO+J5+8deeO0M0F0jkP8kFzkQUYSFG9m4l8/7ha6QaAjjunm75adpx+ffgejLn
         zT7B63dvvqOiPpxijDe19VG5AnZabeNFVByHzUAaH3soPlFhWvfEqx3yqq6OlWPdpLc9
         TRhVwi3uox8kjgd4WS6Pf8tWiXTBXLa7My7s/14hfldBrxkWrxEDyYj0Sh39RpV/Cf+U
         peBOKoRCIyvFXzHclmttBP8SEx33npRMewYNa3NDTZgOQOcoG9HxLTNuhLp+CtlKhy5n
         Wkoitlm0vcKs1AXWYYF7d61Bp0GI+XMizz7CpXPjX2r0D1NKp5qXTvmoG6cy1qsgW6Rx
         kxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFFVAGXmAn33jC18iARlTq1W8BZjLwMZcFPq63oKn2w=;
        b=GyFQT3MLGxNCnni1JsX1to/AsNt4Zkmqk/0XC6ebALx4c5SLBO1WCSOPLpWv2ZAEes
         pzS/cu94N6CgzRnkQcsqDGW5Pp+PTNZINVdylYOIldEyUolBgrmAJ52NR03/eprj5M+K
         oo6uJFMiDDWcZrpcf+F5Hg2pe5glW3Z8aJPJnzGWqx1CzIWC2Da/cPEKXOusDEa9481d
         zKblP6yqlrl+EVNbjK4kGcSHBMKxBwdiaUwOKXu2i9eIMTi0jTVr3tV6T4wVPigsE+Qp
         PvBrnjsCon/vsB75iDy/um1y4bUM1511YMp5aVSPyj3X9EBQGZTPfbtZdIvC0yDsIhFs
         NNvA==
X-Gm-Message-State: AO0yUKX4rIU3LFjkXPM9RyeF95Rt+9P/IGIqR9np4sGEkHJuumTec3vn
        3YCyquKoV7d0wXsR/j597Fk=
X-Google-Smtp-Source: AK7set8PNt0Bn7P7Em47vAQqHH8+QDOWgFLHEK1CoQh6BYQQUFWvd4MqvJ34uFVT/CoYEylUVKxGvw==
X-Received: by 2002:a05:6870:a7a4:b0:163:af13:c4e1 with SMTP id x36-20020a056870a7a400b00163af13c4e1mr1432071oao.46.1675785104217;
        Tue, 07 Feb 2023 07:51:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020a056870194100b0014ff15936casm1818137oak.40.2023.02.07.07.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 07:51:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ecd5ff48-78af-8cae-dd54-3bd3f0288434@roeck-us.net>
Date:   Tue, 7 Feb 2023 07:51:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/7] dt-bindings: watchdog: qcom-wdt: require fallback
 for IPQ4019
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-2-krzysztof.kozlowski@linaro.org>
 <20230113140230.GA1606649@roeck-us.net>
 <7e600ba9-a99e-5f07-334f-bb872f5ed7db@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <7e600ba9-a99e-5f07-334f-bb872f5ed7db@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 01:17, Krzysztof Kozlowski wrote:
> On 13/01/2023 15:02, Guenter Roeck wrote:
>> On Fri, Jan 13, 2023 at 11:33:40AM +0100, Krzysztof Kozlowski wrote:
>>> The device specific compatibles ("qcom,kpss-wdt-ipq4019") should be
>>> follwed by fallback "qcom,kpss-wdt", which is actually used by Linux
>>> driver for binding.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> The patchset was acked and reviewed, so are there any other comments?
> Guenter/Will - are you planning to pick it up?
> 

The series is in my watchdog-next branch. Wim usually picks patches
up from there.

Guenter

