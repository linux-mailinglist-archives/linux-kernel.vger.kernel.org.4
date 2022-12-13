Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957B964B7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiLMOxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbiLMOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:53:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A011C12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:53:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y25so5270286lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZNYw0cYbv8pEkdRU/rmPHESxuk7T+6SVi5xDvP+lXg=;
        b=LkNxPVXA5NjXY+RrcA2AvC/pJlxkhLpHnMLqaNm3GnoTz+q7MUVL9oxGVKjOD+AsWb
         HEYmM234BHnq0CU6JDD47H//9PMu5ddp3BPvFCiCLxFyh/D7zohiuG2cus8ZpTYMPNyz
         KTwBALPrQGVr90wcCZFjsHkRxtwGOg9K2mryQ0xdesmOlY7VB7gd692s6C5U/HYJ/jQp
         ircxeB94mOGLsnEU2evwBqpzi0FE01vLDtxvnHULDAQ4qHOKPQhmiTNCc/oObokutEsq
         DNqztCv9cLP4AKGEuxQO/mPEFXoj3IfT9J/oOIIo88FY+LY1aSbp11kRl2z/8JuPlOD7
         H5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZNYw0cYbv8pEkdRU/rmPHESxuk7T+6SVi5xDvP+lXg=;
        b=MKtdZ63SYX4yP1oV5Z0803c/hTIT8Hh3Yqv++9O5gj9QOG8uburgJEqMpCGzVaBV2N
         lNE77ltR/aJfxNcRUy+3/vfZsotTh1lX84J2hYspypulZLKlakAGvZeazIfQ1MkDuqU9
         ekWioVRcq/tzlFunel+Znuc7BKBActSzXERdDDeCwz+q7QRlZfgFMNKTI50JJSCQGLVy
         u3S51HH5B3xtUDZg+Pe7bCeYkp8YodY0Eif3T2usKzXPhkg6xdMJisQkMylP6XOcYOF6
         zLFmNS8Pvszg/Ee6qcGUp4XN/Pd3jTSJafLzWsDCMrE6jQjJeRQiXVrbQGy1ngFJ3YWO
         ZS4A==
X-Gm-Message-State: ANoB5pmURFVda97LzcaZS8Rooikwy+IeSnBRfYXJxF4DF2xSqOt/Sr9K
        2fg9KiZf47sTritQ+jb8zbcH8g==
X-Google-Smtp-Source: AA0mqf7YZIMIYnF/AmUtETOj9iiwd9xDCo5UgQllt34v31+ROEtCiOLrSziUzTKt/t324aCAka0ZXA==
X-Received: by 2002:ac2:57c2:0:b0:4b6:7212:3bfb with SMTP id k2-20020ac257c2000000b004b672123bfbmr3787642lfo.0.1670943194112;
        Tue, 13 Dec 2022 06:53:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u17-20020ac24c31000000b00497a32e2576sm398112lfq.32.2022.12.13.06.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:53:13 -0800 (PST)
Message-ID: <7585e021-a100-0216-c071-551db79c0436@linaro.org>
Date:   Tue, 13 Dec 2022 15:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 05/17] dt-bindings: watchdog: Fix node descriptions in
 uniphier-wdt example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-6-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-6-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Drop a parent node of the watchdog as it is not directly necessary.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/watchdog/socionext,uniphier-wdt.yaml      | 10 ++--------


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

