Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F485FD93A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJMMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJMMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:32:56 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287BA11B2E5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:32:54 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c23so855364qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9/tYfzo17fxLFOcvb7w4ZSv+9JYtZRmBZDcx1r51RQ=;
        b=T8PR2tbP2asBfPQ/sPK7BXRCjTnXv7MbrGu6XACJj7n5bOLtJO1scp5X5Pg95HDtSU
         LX88dulxsHzuUS4qhA7+Rk92DSgMWUUTpWwkyW9z65GjqHJYQRvieFZtzR+alSdsB/ME
         1Lu6Bd9vx5A/i258W++UPk1L14KM6AMWkbV0cOl5PCb8hpJRJ0sd2DNs5nPjgWlujXrE
         8PisCB6Ot2YFWI5w1XCs5tKHe4cbyNvZSSnDjFnRxJiFH1iYcJjtUvtRiP4mEBl3R/vB
         L7PvSM3x7yzClY80o9bvSqf/tOpc4kz2QTJCvL0DZFoDQbzKQ2nDKRUyti8Z6XVeKrXZ
         7+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9/tYfzo17fxLFOcvb7w4ZSv+9JYtZRmBZDcx1r51RQ=;
        b=htMffBTjLtYKjdzIhVtTJ2dlFlISd+hp+oqMWFEuqtRIPfsc8CYHH6QG8HudCLLr5H
         S9n/03xWpPNnoHPLTE9QoWWwMUnlu32PKI3gNyHrHyYKoKeUu8an4xHIcRXGFWIbcoiZ
         9Xk3APWddcrgWhExgjuAnB7I04yJGiCNFfuuosohNLMk8GuZD8gHaW3cuLN9e0yUK7+Z
         4Vw8j9mmtZDRaJLnxZTjvGAmvsBJJIbU61X77+Wfrbunw93CK4BEB9u0B34UrzXMSOpZ
         5SBB7m+/Z1bmyDx0edUNYK9tAjma+5XyUJ8GwatYsKmUZeRbw0vzOcJYqRo63btfEk6J
         /HVA==
X-Gm-Message-State: ACrzQf3duOQmfRlvkg1Znkm9EhPF+E6aHQiEcf1bzx2f4rcOkTS6cDLt
        9TpxQLoAunhK7AW1IjzpShnkCg==
X-Google-Smtp-Source: AMsMyM6odUD07MJbJEAOtrPomHyrhKE2DOIYANh7IOcMSsMD88ZCbgJDBPZ1duhCai51wYvDAvDioA==
X-Received: by 2002:a05:622a:546:b0:393:7334:65de with SMTP id m6-20020a05622a054600b00393733465demr27887490qtx.504.1665664373240;
        Thu, 13 Oct 2022 05:32:53 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cbc6e1478csm17498265qkh.57.2022.10.13.05.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:32:52 -0700 (PDT)
Message-ID: <8d27a5f6-461a-5b28-1560-07bb4ddcaa8a@linaro.org>
Date:   Thu, 13 Oct 2022 08:32:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 6/6] arm64: defconfig: Add tps65219 as modules
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        jerome Neanne <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com
Cc:     afd@ti.com, narmstrong@baylibre.com, msp@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-7-jneanne@baylibre.com>
 <72b9809e-d6d7-862a-26b8-221d14ea4322@linaro.org>
 <60507e87-cf92-13d9-29d0-83f18a648f4b@baylibre.com>
 <fc1e5799-20ea-de37-6693-e2ea0fb87f13@linaro.org>
 <7hzge1hqof.fsf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7hzge1hqof.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 13:56, Kevin Hilman wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 12/10/2022 04:39, jerome Neanne wrote:
>>>> You explained what you did, which is easily visible. You did not explain
>>>> why you are doing it.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>> Thanks for pointing me to the detailed guidelines
>>> I'm new to upstream and not well aware of all good practices.
>>>
>>> Would below commit message be more suitable:
>>>
>>> Add support for the TPS65219 PMIC by enabling MFD, regulator and 
>>> power-button drivers.  All drivers enabled as modules.
>>
>> This still says only what you did. I still does not explain why.
> 
> Jerome, maybe adding a bit of preamble like:
> 
> "Development boards from TI include the TPS65219 PMIC.  Add support..."

I would propose: "Development boards from TI with xxx SoC include the
..." because the point is that you use this defconfig for boards for
given SoC (supported by upstream).

Other way would be "Foo-bar development board includes the TP..."

> 
> Krzysztof, I'm the first to argue for descriptive/verbose changelogs,
> but IMO, this is getting a little bit nit-picky.
> 
> The series adds a new driver, DTS and defconfig patches to enable
> support the new driver.  The "why" for changes to defconfig changes like
> this are kind of implied/obvious, and there is lots of precedent for
> changelogs of defconfig changes for simple drivers to simply say "enable
> X and Y".

While I understand the entire patchset, the defconfig goes via separate
tree/branch and must stand on its own. Later (one month, one year, one
decade) someone will look at history and wonder why the heck we enabled
TPS65219.

> 
> If my above suggesion is not enough, please make a suggestion for what
> you think would qualify as an appropritate changelong that answers "why"
> for a simple driver change.

It is enough :)

Best regards,
Krzysztof

