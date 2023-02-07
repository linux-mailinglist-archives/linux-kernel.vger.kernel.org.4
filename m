Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B468E201
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjBGUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBGUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:39:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083063E0B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 12:39:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u10so8851408wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cewtMm2H6TvgRuKcxhj2ORsV/bxIWuRsAFNglsj+dsU=;
        b=EAshjM0gDnqv40CPbB1a6XFgQaMgrx+sTODrveXZ17EJ8BikHvNMn9yBxGA3W4RIgU
         u3wnpiYi7oF4VIzJ5ppJqFsj2pAlqEtXfIBF2deD0fSQvclUZnNuY4j+u1nScE/blCI+
         vQ+ST+e4xl8pueILUFSDwsxA61pYbjwmAB3oFwjpjRzf8FbCqswX+w7HyQq5xKjSX99k
         gPb6QzOo6Q9jADDhTMnVcJznOcLoMsF/BvK1qULar14fPCiqW7i7roPcBUf+UhcYQ9In
         v0IHnqVU1WsFVrKXd/FF2uI1ekebq2vJD0WKnrkKO9E4P5Z+qf29cbdg4iib8JfGAPHn
         WmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cewtMm2H6TvgRuKcxhj2ORsV/bxIWuRsAFNglsj+dsU=;
        b=B0ouPS3B2gcMRRLp0mGteyyL+DgPPk8OSMRottfjD8+B5j6v8C9DedDpHsYiZvIX2G
         5s2lhRMUo5fGbJS0aJNR+UhuIfYmGu0saXv4pET7KtJZx7/RHSiy74QtbejIVO5x4spX
         68ly8oDqAB5ELqGHcQpxMNPGjwxGZqvlXRLvzoG4To4xWSa6cIHwTIZ0rOoaye64PQVt
         JL/QaqVaC4ZLntv8H0kzK/9pqPnDyAq9rBLcgo+GevCsbYeqAn5Kdv+BeoCEXPy2XW7w
         ouXcT7MUXffZchAft/0xCRileYOtsE6QI8pHaICO7tyS5CgO9Xr9DOwNBAhcSL89FWPW
         SAbw==
X-Gm-Message-State: AO0yUKVBugAQY2in6zlfT0DrxTHWoq8vDDkfGapzZAMatGKiZWlPOKeo
        han/yIzJAZS1fEqLgkmgVRzZcg==
X-Google-Smtp-Source: AK7set/G49SerPJTf0JmGS3i+zryd5nRKrysWv+vlpKNy4dOTt8biA8SIm/oKxGV8uMBxTZxGcYTvw==
X-Received: by 2002:a05:600c:3423:b0:3e0:185:e916 with SMTP id y35-20020a05600c342300b003e00185e916mr4310668wmp.13.1675802357591;
        Tue, 07 Feb 2023 12:39:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s24-20020a05600c319800b003dfe5190376sm14075798wmp.35.2023.02.07.12.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:39:17 -0800 (PST)
Message-ID: <639db6ae-c7de-eec2-de4f-516aba471d47@linaro.org>
Date:   Tue, 7 Feb 2023 21:39:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] dt-bindings: leds: Document commonly used LED triggers
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        thunder.leizhen@huawei.com, festevam@gmail.com
References: <20221129174906.97749-1-manivannan.sadhasivam@linaro.org>
 <41ade5cb-98c1-e859-be4d-68eb05d0ea44@linaro.org>
 <Y+KcndmBBQw16hfM@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+KcndmBBQw16hfM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 19:46, Lee Jones wrote:
> On Tue, 07 Feb 2023, Krzysztof Kozlowski wrote:
> 
>> On 29/11/2022 18:49, Manivannan Sadhasivam wrote:
>>> Document the commonly used LED triggers by the SoCs. Not all triggers
>>> are documented as some of them are very application specific. Most of the
>>> triggers documented here are currently used in devicetrees of many SoCs.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>
>>> Changes in v4:
>>>
>>> * Removed the sorting of triggers
>>> * Removed the "items" as they were not needed
>>> * Reworded the description
>>> * Dropped Zhen Lei's tested-by tag as the patch has changed
>>> * Added kbd-capslock trigger
>>
>> Any plans for this patch?
> 
> Who are you asking?
> 
> This patch is not in my inbox.

Mani and Pavel. I Cc-ed you just for completeness.

I would expect Mani to rebase and resend it.

Best regards,
Krzysztof

