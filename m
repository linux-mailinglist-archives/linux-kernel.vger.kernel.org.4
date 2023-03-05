Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7E6AAEE7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 10:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCEJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 04:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCEJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 04:55:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624CDBE3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 01:55:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a25so27225743edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 01:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678010100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3Mz8nGSypISQ5Iob2JuXsUI2Y6N6SPOQnq6dbwkLTE=;
        b=eG9Xw9uQnFHiva9f5dum6CQkumtzYV9plb92VS1a8qYzFomDfrCfC35VI6YfXQ5fhC
         NfiYiqT8sfGCd/5BMfXIFyq5k/owyRT8POPqryozvMyrb/n0hHTm3HqtkxDa/WBieq1d
         fPgDS9Ygl2nXX/8CUr1V9+xZUklEwQVqputF0Cx3dz9SPot8/njTXJoToWkSH6RFwAQm
         KnSpkKcFjLMOZ9l3e+dWEE5LdGdwWBYV8E5KHHmnwBqza+C+cj7m25K53BirlDds69K9
         vB2u9ZdRXgx0TX0TgxQtMC6exTgXKlRGqZ4TcNCKqH3zpg3R5jJywj9c7ux5vuTaJ8vy
         B5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678010100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3Mz8nGSypISQ5Iob2JuXsUI2Y6N6SPOQnq6dbwkLTE=;
        b=KbQynfVFKqwKbPpi2cJkuStBTFKg8OOqdbzp/CPgA7bBEE/H/2elci+HTziJwJLU6m
         cFq0kzrlDMRQdY3TxQ+r/gofWtTPJUcAk6yDdHlDFk800KN8pXIkdp+S5tMZCpFHlEl4
         7jj1JMFrVpspI6Und59WVdPmXanTcGsG7FdG47Y+qPxHo0Wm2aR9VoWTuqqIPAL44IoZ
         QjgyBA7AW50e2DEVW0UKb0T2anIYXwWWpCsaM05+36N+xZqg5ZxwMIi7zh64Ozy9zp17
         UTDcfZHGbmK2dqBi2wZZKGEplrcQQuSk2JBT2asvqocQeYpMAanJeaObsmOSwYQX99hj
         eNtw==
X-Gm-Message-State: AO0yUKUk+A+cPYJGuMzojMLXxrX6EzoGuFXYj75wg49wSayOcpjZQATW
        9QYadWBL0NmaCPSvVTStXtrniA==
X-Google-Smtp-Source: AK7set80nCfgRmhYAiNs8HixNvxmB6fcSKTKascs+iD8glJ7/xFifsreyHUtbTMrnEsxOVn3YawkHw==
X-Received: by 2002:aa7:c0cd:0:b0:4af:59fa:2a20 with SMTP id j13-20020aa7c0cd000000b004af59fa2a20mr7653723edp.15.1678010100459;
        Sun, 05 Mar 2023 01:55:00 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:71e7:13d:1c29:505f? ([2a02:810d:15c0:828:71e7:13d:1c29:505f])
        by smtp.gmail.com with ESMTPSA id d9-20020a17090648c900b008b17b0f5d07sm3017195ejt.217.2023.03.05.01.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 01:55:00 -0800 (PST)
Message-ID: <c7f26dcc-ac39-ae5f-8642-34814a22b9fe@linaro.org>
Date:   Sun, 5 Mar 2023 10:54:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/6] dt-bindings: clk: Add Hi3798MV100 CRG driver
 binding
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230304063333.162309-1-mmyangfl@gmail.com>
 <20230304063333.162309-4-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304063333.162309-4-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 07:33, David Yang wrote:
> Add CRG driver for Hi3798MV100 SoC. CRG (Clock and Reset Generator) module
> generates clock and reset signals used by other module blocks on SoC.

Subject: drop second/last, redundant "binding". The "dt-bindings" prefix
is already stating that these are bindings.

Drop also "driver". Bindings are for hardware, not driver.

> 

With both above:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

