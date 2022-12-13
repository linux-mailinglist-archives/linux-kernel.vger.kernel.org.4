Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369C064B7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiLMOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiLMOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:50:11 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF9110B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:50:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q6so5252221lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mB0KyvqD0ZqBlFhaR84Srpxb4q3+wwTogg2S2DXkML4=;
        b=dl6LT2ovp/B3Y8Aog5ybn1DkZ642QYFV8JNKX1yB40+DiHoijbyZlUIHK0L+iiGECp
         oLVuAIg1kjBIOeAJJlIlAMb5szh4oey9yAGsHu7yhT33z/mzLNfWvcDHH34j4zhlJ3i5
         D7dBBiM+najrsgIoQNE0ytCF4qSbsHPCMKGVzzcysociARtsY9ubAvbCOGFjd4xbEfhx
         v/cDVJdUJ6jFlGqWTpvPhPbsbCDHkZznO6CytKKZ47lqgFa51DbckYI7ZZNS2Rl5KvFA
         UgXUKedi4I2MLVkNwDz6uoWcW1WHDmYNt6sYgQNoQlxncSz4C4V4pRF7oow+U//Z0O5Q
         VduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mB0KyvqD0ZqBlFhaR84Srpxb4q3+wwTogg2S2DXkML4=;
        b=OdBZkLyEpAniATq4KVph3W7tv6nwT2cYz+kA2ALryfRCrvqhTLyKcMYfR8GSDvxmUn
         14ZeKslHfcVNDpIRKwBLv2H81HZigZQ9mrMJLeHV8Y4uTfbsgznbYa8g0cPth4U5NYub
         8I8bxBGnp2A6EiVJ873jy+hrftIl3ySbbWaHgc7Zcvqp70rKcej87wm8sI13445lM7oG
         st1Zv48oBiDFCOR3Ia8JM/xorXqA9x8sdfXdjhq5ra6ONZl5z3DezYccic24vQ8nFB27
         C7yZ5Swrgt1VtcgoagMULOCUHWL11IOLuga37SeB1KH0g3tfaUwyT2J0N/Dipe5g7ulq
         RCOg==
X-Gm-Message-State: ANoB5pn2UQjbbT9092L0SwKnCc0RNa1VEF47qJoOrSldWZbr6PqVJTkA
        vylCChb3coXejgsinYkGVfdygw==
X-Google-Smtp-Source: AA0mqf4KuAGFhbPb0Ty13iG9BNOSTdRpE4YMXaM6bojLbmytGkhMxOskRTyEq2EfStBLNwzjOiqO3A==
X-Received: by 2002:ac2:430c:0:b0:4a4:68b9:6085 with SMTP id l12-20020ac2430c000000b004a468b96085mr4816436lfh.16.1670943009070;
        Tue, 13 Dec 2022 06:50:09 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c2-20020ac25f62000000b004b7033da2d7sm42359lfc.128.2022.12.13.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:50:08 -0800 (PST)
Message-ID: <371d9af8-5af4-e421-2382-8fc29b35eec6@linaro.org>
Date:   Tue, 13 Dec 2022 15:50:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 01/17] dt-bindings: clock: Fix node descriptions in
 uniphier-clock example
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-2-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-2-hayashi.kunihiko@socionext.com>
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
> clock nodes to the generic names in the example.
> 
> And drop redundant examples and a parent node of the clock as it is not
> directly necessary.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

