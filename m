Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9786E2B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDNUgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:36:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF47290
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:36:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id jg21so48273622ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681504564; x=1684096564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8CJir3j3h3iz3lOaao3uM4b4n2bBipQycmBP4wvaNk=;
        b=kGWjr0/CHo8BFqm+05eB3GLYkTLecAOjzwYHXFb9ROxyHjoM+n5DU7jEpWNDb/rp5g
         OkzEMwjv62wpX9GyJ+CyGr3dNhc8rjLUK1fw99wYj8ouDnzFWk5p2S3r3c7PtA1ozWB6
         OzSZZ8Q8grvNoS9oNtFzjksLWBdMyWdDihVMPJLGL47lCgV08ry9nMdZD6/31cseIVOt
         tna0SqWUlB1PL5hFyqx00lOSil0+Y9dA1UG/w29Ig9xR2tFOazqoG9dqroRmKaz8qty0
         nbtlE/YMMGufW2Bc4d/n4B99YVV/zhl8WPwoRUcBDL3IX7CegYW1TjEEdke3Pgofnx4O
         fWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681504564; x=1684096564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8CJir3j3h3iz3lOaao3uM4b4n2bBipQycmBP4wvaNk=;
        b=ca6JElwjNZ1uzQwfpoQswLKgck7Ttd5I/17pNOkaw/HJaQV5lPJQLydD20jhcLGurP
         Zt8Hjd4DjgPFPsE5dMPuqY/xAfVzdaf7F5ZdnZ9d2CaEBdPx9qeEy/3X1pm9uOEeOGJI
         Hh7GIt8a7BfHE9Lc6j4awOT780EAi1NNx2q31rrKe4+rwVGt/iwjBpz3DdurR68TKYaO
         tik6o/FuEmhOZSCuX7MSrEmbmDfJiGFLzT8ERDBW6jnLwGlUS78/aFWoQ6SD91vZKJtj
         o24CYh8dfHlR0V/52XcOthUae9kxpyAP2NrgoEAhw3jAA3SvgcNuRz9/lP3ly7VQBFG4
         c5Qw==
X-Gm-Message-State: AAQBX9f+RYya30dVfFALonflJwxzgtX1rhWKYvKHzJaroz3C+LlxBvLS
        XpRItlzOHXny6J3oPv4KBAUBYg==
X-Google-Smtp-Source: AKy350bNnkeouvV6lS7CSRyzxJBpdhSqncKW6XFCRpOwKjqeVcRUhCjyEbvbpaYbs+WoPeAlLZtROQ==
X-Received: by 2002:a17:906:2f91:b0:94a:87d6:d39e with SMTP id w17-20020a1709062f9100b0094a87d6d39emr277861eji.58.1681504564643;
        Fri, 14 Apr 2023 13:36:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id g25-20020a17090613d900b0094edfbd475csm1398229ejc.127.2023.04.14.13.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 13:36:04 -0700 (PDT)
Message-ID: <686577b9-7ddf-c05d-19d4-926a8b0a963a@linaro.org>
Date:   Fri, 14 Apr 2023 22:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add KUNBUS GmbH
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Stefano Bossi <stefano.bossi@gmail.com>
References: <20230414045747.5499-1-bruno.thomsen@gmail.com>
 <45602a7e-9385-296b-d704-64cdf727f5db@linaro.org>
 <CAH+2xPBe8Ef2YedghsxBwxUEiS_M-eVxyC4oScs2HeTM=4M_yg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAH+2xPBe8Ef2YedghsxBwxUEiS_M-eVxyC4oScs2HeTM=4M_yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 22:24, Bruno Thomsen wrote:
> Den fre. 14. apr. 2023 kl. 09.58 skrev Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>:
>>
>> On 14/04/2023 06:57, Bruno Thomsen wrote:
>>> KUNBUS GmbH created the modular DIN-rail mounted open source hardware
>>> platform called Revolution Pi for automation and IIoT projects.
>>> https://www.kunbus.com/
>>>
>>> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
>>> Reviewed-by: Stefano Bossi <stefano.bossi@gmail.com>
>>
>> I do not see it being used in current next. We do not document all
>> possible companies in the world. We document prefixes used in bindings.
> 
> I am going to use it in the board compatibility string for the Revolution Pi
> DIN module device tree(s). So I send it separately to avoid spamming the
> mailing list on every iteration of the board DT. But I can resend it when there
> is a board patch that uses it.

The best is to send it with the first patchset which introduces it.

Best regards,
Krzysztof

