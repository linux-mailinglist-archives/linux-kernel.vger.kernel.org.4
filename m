Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EA64BD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiLMTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbiLMTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:49:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF341A07D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:49:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id v11so4459814ljk.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VB334Z5ylGFHFbDqZH/w67NqwCvKwIWzx6/5zIn1zg=;
        b=xWHLQgnQ5QyduBhTr0fPPDJE9kbNggvfgqxrOFX8eBeyTafL8hG+GNfv5g9Z5BB/m/
         gzyZzL70TSZ6bAe90RrBODWKg0Vj5dJhtBXE4G3x/7I5QvBlJBS48yvomo5oz+kJyzSj
         R5OEuq7HQFi6pYTFlPhvbUvvaCTdpF8tgX5nqvIouaShqS/zC4DwIC27AcrrG0nZx7XN
         CBXs/9XZQdnVyFcPjJpH91C4nSKgZBGjMKqpDl9nA36oNh2s1G83/SAjG9h9ih1N6RHX
         Uv43ReWCaQFfXS6wBe1/1jbxqtBSlLQvFZuH2K2XkcOwiZ5QZif+k9iWtwuz8tNc/5KV
         rNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VB334Z5ylGFHFbDqZH/w67NqwCvKwIWzx6/5zIn1zg=;
        b=D4VsxRoQ33mt1z9uYT9orVlu7Nrnb5qd4TxauCahpHDvP7O63x9FM3W7oxTkkVw5+R
         U40ZEgt2/KqPQavZW4ScCblr5g7af/SBDMqKCRJ6W+0v6GPTdwyvx4Qf+eowQd2t6/bV
         1EAfTN4S8QHe5k4CyyY4EUIV9zSBWV5DwIhC3jixCqYsflATLmHmOCu6H819vVE4aF7U
         MGQoxpwSEPqf59nds3DMiFhNXaHoJZfqKPnxUJByTHYpF4ZM+li7EV9A3zG+e4wEvUyM
         SkpYI48kTWWO+DUz9QpOHi8ZX7TRJRptTgc5O8f5oKaiUxxQIWgNezl1Dggoua7Fvi+w
         5nJQ==
X-Gm-Message-State: ANoB5pmSs3NSEFVX83UNzPg9+KQsTXVJTatl5WmVFIfLJlxIFXGWRSyI
        o8JamtkN1yUEeIPLtzaJyZU5oA==
X-Google-Smtp-Source: AA0mqf40atQtjOzvx8pqPudCBx580m5yGd+KEZWkxc8Bvz3e+6GUxtm3Be/2ORduxhVplxgyDF+zvQ==
X-Received: by 2002:a05:651c:1592:b0:26f:db35:d203 with SMTP id h18-20020a05651c159200b0026fdb35d203mr5159745ljq.15.1670960940642;
        Tue, 13 Dec 2022 11:49:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z20-20020a2eb534000000b0027b50ed9df2sm383263ljm.17.2022.12.13.11.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 11:49:00 -0800 (PST)
Message-ID: <e8c5821c-2da5-d1ee-0d74-84e76af76696@linaro.org>
Date:   Tue, 13 Dec 2022 20:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 1/1] dt-bindings: mfd: x-powers,axp152: Document the
 AXP1530 variant
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Jan Trmal <jtrmal@gmail.com>, Tom <takuya@takuya.tech>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221213182743.3087889-1-martin.botka@somainline.org>
 <20221213182743.3087889-2-martin.botka@somainline.org>
 <1e0d86ee-a832-642d-c835-df1f6505940e@linaro.org>
 <C2E9D93B-96DF-49BB-B75F-27D621BF2501@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <C2E9D93B-96DF-49BB-B75F-27D621BF2501@somainline.org>
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

On 13/12/2022 20:43, Martin Botka wrote:
> That is very much my bad.
> 
> I understand the purpose of them :)
> 
> I just straight up forgot to add them.

Sure, happens, no worries.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

