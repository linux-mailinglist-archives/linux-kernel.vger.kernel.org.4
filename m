Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B1A6004A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJQBAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJQBAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:00:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB898FAF0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:00:17 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r19so6910966qtx.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqyNP0rk1a5dyKzMXLrktYgPBfFzcz/Grlk5GABzwuA=;
        b=FgZ7SzmXaofeCzubIB0q8LhO+QvOY2ZDnUr84pd3Sbi/CYgekID5pFTHfuxQLVZI8R
         kB4DNQOvnIyF+78IkyKhmIe8XAJOWrOk33SwiJMXUE8usYXMj++5ffXdaehwP8BgFHth
         tOWCgr1V3Y4ZOGYueFQDrVd4tKBZGfnqLb6sauN3VAkIhsERznmBkd0SPj8rtPaMP1yi
         0IRp6o8MdlsKD5/NGGdIDGJbNkCvwxMU8J6Fqrh7DtIlwbpkdsTyASZWvo8U6rHBTTvI
         9qwV4mPVmP51EgyibZBTOri0FzBUt/frREO29j+jSsHYQdt754UbzbkQw9s3GpBuABiF
         mbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqyNP0rk1a5dyKzMXLrktYgPBfFzcz/Grlk5GABzwuA=;
        b=fUbVF05bjND2rebudcVWXO954hfkMi5K8UtKKSbYT7u7WrfGD5CHo69dAqiNyXKw0h
         aTfzZxidO36ctS9c2EnB4/FGuvUvbIgAjJwwpBGjEVs6i3GT5CfaPpFvyjPsMYf1eMmB
         scfzhD5Ee+jHDQ1aCXintT8FDHyF9qYBFpj34rX3nd0bxX5FMRmMtF7yeIgKsQRwWMbL
         bf5FtQ0KAVD+QcjNKBqnGrzz5yhcmgsw6CMB6baJNJYiLPa/deancigkWPvgmFYydIj/
         +O1fmJKKJ2i6myYBx2AVQ2aHwJiTIow1IXE3jKLqnSdenLh2g1gstf7ZCLHRyqUe3ZQR
         xIyA==
X-Gm-Message-State: ACrzQf3BUhDMe6185WBLmQCxI1oJqGrd3NUu/GBpiKu7Ri+zWfZM6ZS/
        hTyZlmI1wB1OK0z9a6aFrt7sJg==
X-Google-Smtp-Source: AMsMyM7ScFx2l6l+XhU8l+SU8mYkGkxtKI0WUNcEwqTGC/mT54llVp2PDO9rYrVrIl0JdEA0HVAsNg==
X-Received: by 2002:ac8:5f08:0:b0:35c:cbe5:4b83 with SMTP id x8-20020ac85f08000000b0035ccbe54b83mr7114191qta.218.1665968416877;
        Sun, 16 Oct 2022 18:00:16 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:bb7d:1aa4:bef8:ec27? ([2601:42:0:3450:bb7d:1aa4:bef8:ec27])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006cfc01b4461sm8299700qkn.118.2022.10.16.18.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 18:00:15 -0700 (PDT)
Message-ID: <365c0b94-c619-3790-c23a-5582631dd208@linaro.org>
Date:   Sun, 16 Oct 2022 21:00:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add Ingenic JZ4755 CGU header
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221016150110.3020451-1-lis8215@gmail.com>
 <20221016150110.3020451-4-lis8215@gmail.com>
 <c2accc8b-f4eb-47ca-333f-eeb98da6a363@linaro.org>
 <CAKNVLfZ8qi4MS6ineF4M5xnSmHW+=P5mdgifmr74g4kOSK2wGA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKNVLfZ8qi4MS6ineF4M5xnSmHW+=P5mdgifmr74g4kOSK2wGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2022 14:21, Siarhei Volkau wrote:
> вс, 16 окт. 2022 г. в 18:32, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
> 
>> Why did you choose 2.0+?
> 
> It's the first time that I need to choose a license, so it's a bit
> confusing what
> side effects they have, especially in that particular case.
> 
> What do you recommend?

Choice was fine, just not common so I was just wondering. You can keep
it but usually we choose what the checkpatch is asking for - so GPL-2.0
(only )or BSD-2-clause.

Best regards,
Krzysztof

