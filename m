Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FF6DE1F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDKRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDKRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:11:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A37469F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:11:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-504a131087aso1766249a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681233079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWF1p5GA25OvC5IkhaNGaOg//cQPDFhqXYPwtZg5x8g=;
        b=dFhJFjoAyK5R5qUYgh0yy2kGnzMaXC2N0bUaD6ds2jGWr+eg21x5h5Y59+bii68GE/
         O9OXZ1lQnbZX0L9zcVcK68nwXmOBGw7buRRy33ISHJLAuEGTS2nLR1zMzuwp3zmkdtdy
         YyvHndm7VOLKCNjvlHGUXML5nG5b5Mhp0zotXMfgsTU/+go3Stzmayvk1FaopSuByQqL
         587TWv3Z5f0LAHsG1rjGcMkqZzYE7zwR2Powj9lwx/wzmD6d7HivHFZ0RvAxu9usT4Ke
         LUUgzQ3wRAFcgom89mshhLwvHZlZ2KVcium/5sR8t6G9+gXC5f7YtmhjL4kmEjYfkwqm
         /aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWF1p5GA25OvC5IkhaNGaOg//cQPDFhqXYPwtZg5x8g=;
        b=EngIQCCBDr9xMNN0avYXe6nbKv6vmHWgV9gnLGF0/wCqNNcpPb/zmqyWJ9YSgA5Tjt
         9D6E8AT6n+hhjaJ3yItx0k5EGkXP+Vnx4+tUTCuo6xi6hfLqsxCTiHn9rGqWTCNW1yrs
         6ynJSYL/CEjHbu190NpNAsuddWmsnLp9+Uv4gyvFV9mvepNEEJj4YtKZR52iT77Ix7fD
         AwuQGsYSNcYowPadG/s8oIRcjQ48b6itOSXWNvS6lJfvmUi7pYrmjrwc1hf/zGNLxb9K
         OoMTUULxxAQl7mYnIFdYGG5m44cdcRJJOmHXC3OmHljP3woYHjMw+kFNeDFItnJH1kjT
         0vhA==
X-Gm-Message-State: AAQBX9fw84QPuh+VYoJUjzKieoeNuRv2jyZ7HcHyvRKuPl2CjqdvMTsS
        CJQeAcsQYkYl0QjzJTeHB1rfAA==
X-Google-Smtp-Source: AKy350a8G75tLqrttqnXqD68zKhR4Bwu9CYLqf4N5npE1a25zQI5U9DFgT07MGKm1HXMLPmOpUvkXg==
X-Received: by 2002:aa7:c59a:0:b0:504:bba1:de8b with SMTP id g26-20020aa7c59a000000b00504bba1de8bmr3464462edq.19.1681233079521;
        Tue, 11 Apr 2023 10:11:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id k6-20020a50cb86000000b00501d73cfc86sm5820199edi.9.2023.04.11.10.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:11:18 -0700 (PDT)
Message-ID: <9a7b8fda-9a6a-59e3-3173-1d173b34825a@linaro.org>
Date:   Tue, 11 Apr 2023 19:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: sound: ep93xx: Add I2S description
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
References: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411165951.2335899-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 18:59, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S
> controller.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> Changelog:
> v3:
> - rebased onto
>  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> v2:
>  - Incorporated most of the suggestions from Krzysztof Kozlowski [1]
>  - Dropped AC97 (deleted from the tree)
> 

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

