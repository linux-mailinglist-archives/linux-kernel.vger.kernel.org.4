Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B96EB973
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 15:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjDVNuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDVNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 09:50:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869AA1BEB;
        Sat, 22 Apr 2023 06:50:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 4fb4d7f45d1cf-506bfe81303so4536514a12.1;
        Sat, 22 Apr 2023 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682171404; x=1684763404;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WFcPcfg308BxIs2D12U44N+18aoFFJxwabh2xPhsPSk=;
        b=ZRWs3JpD4Cp5/pHGbDd0vrTAVGX7MoGwPJIJGgfDW35EVVzY7pVHO1cr+CMew4W30p
         LssfreTk3/208zOZke8KMcbc5fRWXdHA1gLcffdeonmQ1cUm09zZdb7Qax14xXqktigh
         QxVFZlPxVn+VDM9CKTWGq2LYuxR3RzYjFrprgWqmNAwY/xi4H8xNsc+kt0VKUI+/YJis
         qEI1pzNybL5k5euRWSNV8a+Zk0eVTMAXFwkhC0Ved4lMSY7As7fGXewYKgf18p+dGQsc
         OWQWry1WTSwtalqKuUvjPaulrvkzhckKJWomjmsPu5aIEGm3MfwYgVjIgZ9AR3G3sIm1
         gFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682171404; x=1684763404;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFcPcfg308BxIs2D12U44N+18aoFFJxwabh2xPhsPSk=;
        b=YHtdifYPr278Wus8Jc+cYsuOrZjDGWe//gWavURvo2GnS9R1L/aRvE2JUcqZ6wkKOA
         y0ZOCA1VCyZtXOtrgLstzJ15jABFFTg64pLhV0iBhZUuyhhO1gFxQDWf9Sqa9jUEG6qS
         /wp6Fb9pizTEKTxL0OafhG1UGpoZx+lWHDtnouP5tTWfTaxf9mBZKaQCrddgj98Klf3t
         XPJ2acbJpkuOZC/Whavn9eYNfA9JLEyoDWO/8tm1ztg/U8mSI5b8kEGABCjCBscVFSEV
         TTL1tkbvZt3WrZ8AGcG0/CPsJPA9wUtPPy4STpUnJIcaGI7vWYZRukwUmgFms7nnmFDP
         BI7A==
X-Gm-Message-State: AAQBX9dXR9NKae4d9v4NVWtsAEXk99ZivEGy5yoJOGvcFv77i/9/Qnnd
        /y6MFtbnC4GofUpaPSVF/3k=
X-Google-Smtp-Source: AKy350agXYSrpjkbP6WbEUuG++nS8/psneQ03hXKL+jNOlMEImcYh4gHMeo5CK525yNYdOAzt8ZgwA==
X-Received: by 2002:aa7:da41:0:b0:506:8660:77a3 with SMTP id w1-20020aa7da41000000b00506866077a3mr8228114eds.37.1682171403662;
        Sat, 22 Apr 2023 06:50:03 -0700 (PDT)
Received: from [192.168.50.244] (83.11.224.11.ipv4.supernova.orange.pl. [83.11.224.11])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7d802000000b004ad601533a3sm2846990edq.55.2023.04.22.06.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Apr 2023 06:50:03 -0700 (PDT)
Message-ID: <5818b5be-f9cc-8009-e2a4-1049d84a944d@gmail.com>
Date:   Sat, 22 Apr 2023 15:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH v2 12/12] ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0
 boards
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
 <20230416133422.1949-13-aweber.kernel@gmail.com>
 <9aba4c1d-93f3-7613-6fb5-0591a281ec0a@linaro.org>
Content-Language: en-US
In-Reply-To: <9aba4c1d-93f3-7613-6fb5-0591a281ec0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thank you for the review.

On 16/04/2023 20:26, Krzysztof Kozlowski wrote:
> On 16/04/2023 15:34, Artur Weber wrote:
> [...]
>> +
>> +		backlight: backlight@2c {
>> +			compatible = "ti,lp8556";
> 
> You need to convert bindings to DT schema first. I don't accept any new
> usages of TXT bindings anymore, sorry.
> 

I'll be taking a look at the conversion (will likely submit it as a
separate patchset, since I've been looking into some minor driver-side
changes there as well...), although I have one question - who should I
list as the bindings maintainer ("maintainers" field in YAML format)? Is
this someone specific for that subsystem, or the author of the driver,
or someone else? (It's worth noting that there isn't a maintainer listed
for the lp855x driver in the MAINTAINERS file.)
Documentation/devicetree/bindings/writing-schema.rst doesn't really
mention anything about this.

>> +&bus_acp {
> 
> Order label/phandle overrides by name, so acp before dmc.
> 

Out of curiosity - should I order the children of the / node or the
pinctrl nodes by name as well?

Best regards
Artur Weber

