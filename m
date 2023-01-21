Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE992676933
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjAUUYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:24:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3A233E4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:24:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n7so7592808wrx.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZnR1B/AyPGervYqcEeJnFg27T+IclC2LptczP06yoo=;
        b=DHuwbtveKrMItUiMUIDKfgeKqMHy6Uyu0qJs5OfBFNWc+Fcbd70Pm4MeBS6DiFsyig
         MXKKjosQ+AzIbYHTnNtnq9DSv/PrUkhj3aEWQP618ZzTy+jq9g6+wAiO5jwcTgdBqKmx
         PLBTRjcQHtvYXZ9mPoZWlpOQjbV+Fh72nFuTPx0KtYItspAyRfndFPSeGeTJFg0gx2Vm
         C1jmD7u/bkBEICULSFn2QbDavl5iOMekAqa/pIxUDNefMSF0QPy33Ws4z8ErCA3/fQfz
         ATPTF50eFDMmzVg04Pax7lRCuyvpEXIxkBcUKmLFEAGMkAz6chG1DLYOqcZtJsc8Xh1K
         RKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZnR1B/AyPGervYqcEeJnFg27T+IclC2LptczP06yoo=;
        b=MW8QqLqe9iDD/SOyDTOF5Nps2usDKBzUwM60ouACojEJ2/We7AzYwzLRCH/GT0/PtE
         Xrvxu4sXWJbb/PeNShKRt/yoU6ae9+VFCg89XxpUdtftCFUO/uoYiqw8JmhyFcnNP/jw
         Bt+PORqe0kzqU4iVpS26C4pM1h/nBtzmv6czOZ4a1tRDhLLl7iX487TT/7iXXp1mXnlV
         a6HRxY5bE1h8+8+pobE7sEkDe11RDdzgsXgC6ysKiY5I0o7biDbhLzhfqiIz/+JUOV8l
         odx+sXD7UbVkCCrxBfZuV79nZ+/eeQbR5ZonqYRDaZVsE8Q7GXr/3JDd8YA/KzF0ag+y
         6IDg==
X-Gm-Message-State: AFqh2koJSA/XLRRD0kLYo0BctVC0Ph1Bc2LCQCW9o9wAgEAjW4aMz3Mn
        f84sQKyFlDQMo5HWB69PTwghyQ==
X-Google-Smtp-Source: AMrXdXveEvSU7bnrx9Tk15ZMWoYARs+fMfa5qksVjn+oX/GXg18n57L0QbHDCIrDWHpoqURgmtuZeQ==
X-Received: by 2002:adf:f705:0:b0:2bd:d34e:534c with SMTP id r5-20020adff705000000b002bdd34e534cmr15230975wrp.36.1674332667394;
        Sat, 21 Jan 2023 12:24:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d6d0b000000b002bdda9856b5sm5680432wrq.50.2023.01.21.12.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 12:24:26 -0800 (PST)
Message-ID: <a21fd9b8-bb40-0ed1-72cc-849a096dfe7b@linaro.org>
Date:   Sat, 21 Jan 2023 21:24:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: document SPI dev
 compatibles
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
 <20230120075618.153664-2-krzysztof.kozlowski@linaro.org>
 <Y8quqsiRmMbPyyar@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y8quqsiRmMbPyyar@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 16:09, Mark Brown wrote:
> On Fri, Jan 20, 2023 at 08:56:18AM +0100, Krzysztof Kozlowski wrote:
>> Document existing SPI dev compatibles.
> 
> I'm missing patch 1/2 here - what's the story with dependencies?

Sorry for that, I should Cc everyone. First patch [1] is just vendor
prefix, which should rather go via Rob's DT tree to avoid any conflicts.
There is no dependency, so if Rob is fine with this, please take the
patch here.

[1]
https://lore.kernel.org/all/20230120075618.153664-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

