Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39CB631371
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKTKs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKTKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:48:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64E6AEF3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:48:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so14898333lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpHgffmtiiMC2IPVxm1Md1Xlp4INh6DTQCLUQWDSsp8=;
        b=wkRAvF3wvWBlBg1ImUf7ZQuVu0M9M6v3LQ0P+03MkSRnbrMRvkvqmDHsbKUvHTIuVP
         z4vMlxcR1C9eke2UIutQijHn63H6xvc6U7aPcckdnsd4mlOecGBhKJl++COGaO8LMiEs
         y4lO7BbkEO0dFuACEmwxpamMx4OqZZW+Ehs4KPw16i0MgFh0gR+JhG5YBwk1Dz8oOQtc
         Dy7YCAG9VHQrBjh9siB/gMMYwWLKN2Gb6LRYOHTWwypwmLZ7I0UFSgjGHWBtIp1kmlvb
         UrxD09ERcswUtDLhMInw88EFd8V2PWGMU/+Cg0y9ewPk6ZFx8a72PK3q3qsdqp+mYu0c
         vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpHgffmtiiMC2IPVxm1Md1Xlp4INh6DTQCLUQWDSsp8=;
        b=k8etyDpYVlgrVe5TUo3zqttL5g7RoaxWudk+DiPQoal0cscq5Vha3+qwQAkdgnE+b9
         ik/U6fwRQ8A6BArZlrXCdEkNwG5aFaXD3c0t+eYGxokAZXjMojg1HbDhp0S/2TZKTgtG
         VBUdWwlRVsb+pkUXdCda8+wIOx4qUPd7Upk6yx6uC4tudhnnE8JZhx/1B8+v0mvURb5E
         Peoh9NBMnz1YluOJVYqv2BfjXMSpwI51Kf3M4eK6Udys8pz0RmeYl+34dCZqS/MC8WuP
         ONTXrA/D8xlYeGRyS8QHFYg3U3tZkg/LDfdgOefR1bZPltYpDVLgBLiDNgcy/Zo1EKqa
         K7qQ==
X-Gm-Message-State: ANoB5plNZxwlqYjIildXsyutbpHq/8OIs2ImuDzXIM5i9TY3jr4sl0LC
        tdWWdItMTxoX8c7P0Q2bL/aj6w==
X-Google-Smtp-Source: AA0mqf6BjpdC7y0JZKaDfZRa+eU4/nR0bIzuXDspnNuluGukZIIJYh6eGAroVDsf7goRTNIE0UfupA==
X-Received: by 2002:a05:6512:3fa:b0:4a2:29d9:6587 with SMTP id n26-20020a05651203fa00b004a229d96587mr5397479lfq.477.1668941330676;
        Sun, 20 Nov 2022 02:48:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l13-20020ac2554d000000b004a26b9cea32sm1466833lfk.271.2022.11.20.02.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:48:50 -0800 (PST)
Message-ID: <90ca85c1-a5ed-3762-31dc-45f665e0762b@linaro.org>
Date:   Sun, 20 Nov 2022 11:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <Y2PP0cZaJ1vpv1Em@matsya> <f6842c89-fffc-e1b0-c68f-287111974378@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f6842c89-fffc-e1b0-c68f-287111974378@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 20:24, Melody Olvera wrote:
> 
> 
> On 11/3/2022 9:27 AM, Vinod Koul wrote:
>> On 14-09-22, 22:22, Vinod Koul wrote:
>>> Hello,
>>>
>>> The is version 5 of support for PMIC v7. I have added a new property
>>> qcom,bus-id for supporting v7 and then add driver changes for v7
>> Stephen,
>>
>> Can you pick this? It has been so long...
> 
> Hi Stephen,
> 
> Do you mind looking at this? I've got some patches that depend on functionality here...
> https://lore.kernel.org/all/20221118192241.29384-1-quic_molvera@quicinc.com/

This was merged.

Best regards,
Krzysztof

