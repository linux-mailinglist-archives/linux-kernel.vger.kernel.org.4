Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF39F64B7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiLMOy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiLMOyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:54:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25CDEE0E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:54:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so5332479lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVR1970k+osJav+KmX+NdOXUmXRch+KnBKh6B/puQ7g=;
        b=Vum6l67659PN77J8xJmKBxF+l69Gus+XL+TyOFYBlZjmKVG34H2q4Va77ZCXY3OltB
         wvTC2VWybymKlQwe6EbYL2eVawz4o5J75hbG/YVr0beeHi5kHtAGVFTshbFRxe53MEjf
         8bqFzCkdmwk2kEYueWpFgK2KTEP+/8JUvh8nSEchx+Q9cwLdHHI6RZbrjYPfQsXiScPs
         WstQcy8aBYAZaJcibAa/4xRLRMcf1LeSYnuFGMiNrAyJgN8tbK9NEa3PQsEdWejKTBhr
         EG+aao9QvTL/Us4AEJXwIIzNCgzNfB2VU+INMqznmnhWmqEoqUEscW9wyHWmnAQfsGTB
         x8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVR1970k+osJav+KmX+NdOXUmXRch+KnBKh6B/puQ7g=;
        b=Sq6E7UJvGhsslNzBmkBqPAVfxdrdXwD0wwbvKDHygbK3UdVoJlDv0L3r6DunJ2AuB2
         Gf4MoJjD0rw8lY9pN9jL2l9197l/Gc8ekuMjVQIn4MpWoJA9tYQnnRfFFIptojnIgNcK
         N9Xn7Y9+GPPuTcqCbcv+Ym8oO6znyElwHp1V45zljLqt3mlIV+BNJ5/RyI2NtHSUQHxw
         eLEueBBBw/fxiKglkjawKWfOJMvKMN7RBysXwkqIAHcVZlLjuBq5LHNhoLUa76Dg5Xgv
         BKOjpBZ55AN364OsUUudY22Mh3GcoOC4IQ2pCsU09YCnPpaudxriukJRyYhaIQAkWoto
         Insw==
X-Gm-Message-State: ANoB5pnyPtydtPHlsMKy5PSbRwQ1jmlEDOZNrGFRIp0MdXOvoI1YH+aA
        DsPcaK1w88QCCsiaxvGnTiPn+TiSWOQ1TqG7
X-Google-Smtp-Source: AA0mqf7i5N19z2EwwLP1FiBX7MBo+1NEYZeyq8YUr3q/+CBD0JvTKRQVA6yGfSUSZjnI1AW+s6W8jw==
X-Received: by 2002:a05:6512:401d:b0:4b6:edac:7168 with SMTP id br29-20020a056512401d00b004b6edac7168mr2541395lfb.39.1670943251058;
        Tue, 13 Dec 2022 06:54:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512348700b004a2511b8224sm399383lfr.103.2022.12.13.06.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:54:10 -0800 (PST)
Message-ID: <6a434a50-886d-cab1-2f65-7df3e7386472@linaro.org>
Date:   Tue, 13 Dec 2022 15:54:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 06/17] dt-bindings: thermal: Fix node descriptions in
 uniphier-thermal example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-7-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-7-hayashi.kunihiko@socionext.com>
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
> Prior to adding dt-bindings for SoC-dependent controllers, rename the
> thermal node and its parent node to the generic names in the example.
> 
> And drop a parent node of the thermal-sensor  as it is not directly

Drop double space in "thermal-sensor  as" above

With this:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

