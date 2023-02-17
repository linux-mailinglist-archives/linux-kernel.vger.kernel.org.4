Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721169AFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBQPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjBQPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:47:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49EECC17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:47:52 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cn2so5872688edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ydvsRPVG061WS4UTZVStbsfcU/oL9Zx0nIHQuE4tyA=;
        b=xHv1htd37Mqx8hvLnrTvHhIKTpFqgdOz/1uJyvsbCg+1IPuW59e2MfJdhcJtQ3aWyV
         xUB/T+IXHjLDCvXwC9m29LDgZ+A61/SeNTAAUrd6IJpaDhZJxoEe5LF44aoAoG0mrzUu
         0lOJcKpvLEP5h4rgVdXnUYvWRSgvSOu+eCQTNX3hkJ54KJL6CBHqpmqkLP5mr5eh1brS
         ++TVu9WgIto2kqXvqrncZ44tK7YBoLdTHeaTJ09BtZ2wu03bTVchrrGc3ZuVFHbD6vn2
         ESq5gYkZ6eNaSTUmCDMI6zhEA2eovgrlV9Q83ml6nk9QzoAJwaS7RdSM9QG25SKYHLfv
         1+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ydvsRPVG061WS4UTZVStbsfcU/oL9Zx0nIHQuE4tyA=;
        b=odW3Gtzj4PY31s4HkoRPQQE5+cqqMWmZF0qNRsd0OzNiGQJkC1ZXSqoB0B340fNuoU
         vOIsjRLyfEk9KLnSBwpXb4Q1EBEUJhiVB85o/lwpvqVTtk5QQTMmR3l+y1p7S3fQ07Pq
         608vJ10X1eDqjZaFS/7z1ilT0P94yXBh6HLK+JuuK0KijkpXkr13Mmi6Mn7f9OM21xPx
         MwkiEJrT3ClIUfzEDVoANpWhEYvvafHLal7OktxR8Il3pMs5M/aTkzVw2kaAbUPd+XzI
         anIO6eZfqDDUdor/fV1k4wO/OQ+o7pQlrSyoguKlAMtXzjpTOE/vcZVjktcRrZUaerdl
         1QwA==
X-Gm-Message-State: AO0yUKV/upqVSwWfh8/HaWlAKzd4fh/80JNYt65hp93uXA0vPE1dqqTL
        S+7sML1sRFPzn/D1oXZZMQk9fw5PqLDIib2P
X-Google-Smtp-Source: AK7set92ggsq7QntNOjYeDE1GS2W9aHhklXHaJSFIAczwRnKnbIvvSu4L4kHtCgfE55Dgzu7wN1V/Q==
X-Received: by 2002:a17:906:9f25:b0:8b1:2eef:154c with SMTP id fy37-20020a1709069f2500b008b12eef154cmr5350244ejc.0.1676648871136;
        Fri, 17 Feb 2023 07:47:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ui41-20020a170907c92900b008af3930c394sm2282740ejc.60.2023.02.17.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 07:47:50 -0800 (PST)
Message-ID: <dcba75b5-7b62-35aa-6836-5d5edd785002@linaro.org>
Date:   Fri, 17 Feb 2023 16:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com> <Y6JB37Pd5TZoGMy4@spud>
 <7a7bccb1-4d47-3d32-36e6-4aab7b5b8dad@starfivetech.com>
 <Y6tSWB2+98a8k9Qw@spud>
 <5cf0fe71-fd17-fb28-c01e-28356081ba76@starfivetech.com>
 <Y+5z8skN2DuvxDEL@spud>
 <68e61f28-daec-ce72-726a-1fffe8e94829@starfivetech.com>
 <Y+8x/KSujhgNLAd6@wendy>
 <d3b06d0b-ff17-ebab-bae5-e1ec836fe667@starfivetech.com>
 <Y++B43uCnPQlRYFi@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y++B43uCnPQlRYFi@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 14:32, Conor Dooley wrote:
>>>> Yes, it is.
>>>
>>> Which would then make GMAC1 RGMII RX optional, rather than required?
>>
>> If thinking in this way, I must say yes, it is optional. But actually
>> GMAC1 RGMII RX feeds gmac1_rx by default. 
>> For a mux, it usually works if you populate only one input to it.
>> Does it mean all the other inputs are optional? And how can we define
>> which input is required?
> 
> I'm not sure, that is a question for Krzysztof and/or Rob.

That's a long thread, please summarize what you ask. Otherwise I have no
clue what is the question.

Does the mux works correctly if clock input is not connected? I mean,
are you now talking about real hardware or some simplification from SW
point of view?

Best regards,
Krzysztof

