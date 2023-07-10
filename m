Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAC74CECE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjGJHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGJHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:45:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12A187
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:45:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99357737980so550115066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688975103; x=1691567103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MNKvxKhU5E3UfL1yykCL9W6AhB6g7MU09MxNEWDvB0=;
        b=Z5O9WCbpFEAEEX7ipSOm5t/0clVvwUC6C1Pysrl5LNHPr8d252uBkYx24L5kenOgj8
         d/okzdRXK45OgldGAb7iP3KIB5LrGWiH3ZJu1XvRmV5e2Xo9KlYE8p4XWrXCHxjrF5fT
         GvKf+Rgg8OcFAHQhzgaOon1JhYhau5BlztjxTFtvCamoM99I3NcuaEsEq/9jumfgNOZn
         mtoc0YtVNohyOtGhvPKiV7KOxij2wK0BzVl8S2godl+Ue8YEXSDZucUZb4gD2F4ckP8w
         ftVPVFqnOxKCzyVLnwM/3U07Awi2UKBgTBHzKX/64qn/o3ZFbWDz7yREO3xoGU9PhHmi
         fsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688975103; x=1691567103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MNKvxKhU5E3UfL1yykCL9W6AhB6g7MU09MxNEWDvB0=;
        b=kW5uREQt+nRuCKGI2vopbsbNQvmnxS2jtXcpcQUiGsJ5YlY0C1vkQ7OK2auVDguu3L
         ga+hTKwWVCAi6n+ypIiIjLx1z45sgF21FJDzG2cYif3HS5vivoI1KSdhqEC5TH5yFWOk
         3LBW8KyXztZYcbuw2T9aRjrNAG9sZJ2k/QiO7BhmKDtXvRNu6i9mNwxQbb61CxaeQX/5
         ajPLLYL9XscNfxIFOU45nowEgmp5llesE+iKlCLvAUWg+H2dkAKq8mQxVDqfijN8hQRV
         W4mU0ZWcxHQzMdA0qVW7KBhQ3RlDr4ZY5nCpP8o6uGpnO56CcTkpa2mEE9oS9l44EOZ7
         V7hQ==
X-Gm-Message-State: ABy/qLYcgKzKEIwjRZ0yMW4n2psry+4CMtPt0ZcFN8tpS5AaqVOiFYqA
        R0x18x4pKzOvO242hsRCmmcKjg==
X-Google-Smtp-Source: APBJJlHEWjZH7QcFgJVsbgRVy1gCD4+9E6PvXub3qGjdk22ca0yCMxJ77I0SGdcFF0cZjF/dDmDUQQ==
X-Received: by 2002:a17:906:20dd:b0:993:ec0b:1a27 with SMTP id c29-20020a17090620dd00b00993ec0b1a27mr7106837ejc.24.1688975103071;
        Mon, 10 Jul 2023 00:45:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ay26-20020a170906d29a00b009887f4e0291sm5717231ejb.27.2023.07.10.00.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:45:02 -0700 (PDT)
Message-ID: <48d345c2-c5fe-08e9-b8c2-8d83f826e45a@linaro.org>
Date:   Mon, 10 Jul 2023 09:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] ARM: dts: exynos/i9100: Fix LCD screen's physical
 size
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20230708084027.18352-1-paul@crapouillou.net>
 <20230708084027.18352-4-paul@crapouillou.net>
 <98b39071-cbfa-bc58-032e-56f6e9dd5c2a@linaro.org>
 <7672f0b65cf7d2a1bb81019417aa3fa98fbac5e3.camel@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7672f0b65cf7d2a1bb81019417aa3fa98fbac5e3.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 09:35, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le lundi 10 juillet 2023 à 08:59 +0200, Krzysztof Kozlowski a écrit :
>> On 08/07/2023 10:40, Paul Cercueil wrote:
>>> The previous values were completely bogus, and resulted in the
>>> computed
>>> DPI ratio being much lower than reality, causing applications and
>>> UIs to
>>> misbehave.
>>>
>>> The new values were measured by myself with a ruler.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the
>>> Galaxy S2")
>>> Cc: <stable@vger.kernel.org> # v5.8+
>>> ---
>>
>> This does not apply. You rebased your work on some older
>> version/tree,
>> without new layout. Please work on linux-next.
> 
> This patchset was based on drm-misc-next, because that's where I was
> planning to apply it; and it was extremely unlikely (but not
> impossible, apparently) that the i9100.dts would be modified in the
> meantime.
> 
> I can rebase on linux-next, the problem then is that I then don't know
> how/where to apply the patchset.

DTS cannot go via drm-misc-next, so if that's your intention please
always split the patchset into separate ones. *Always*.

Best regards,
Krzysztof

