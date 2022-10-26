Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F27B60E61F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 19:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbiJZRED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiJZRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 13:03:57 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589BDC0697
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:03:56 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g16so10399265qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ROnzP60siuGiHzqktFDOH9iIayLn915GOnQp0HlYMk=;
        b=WQN/OgLrj+21hWgl0AVRGD2GRCYZM/+eVGjYLm+PL0W+/M5AYvJu2JA3QwOeSWqUG3
         yZoYkar/trbILSiiM454yG5TDe7VG2jn32cernhij6R+PYvCKZinC+eAsc/Yigm6Zpyq
         WOZ6hs3eLa8DBEWAvSBYP3gZRa4KfvDpOmig9dkbs9+BLfr+Bmkl5nLAD5lqVdSarHlP
         PbpaWM+2UySH0L6qnzlnj/fCp1G6BRupJxXGDheKcJCbgtIMEbW3hJFwD0Tj0t+TCagE
         U+EwMOH7aqsGXgcc58irIvTsaPEPo1bVQcBnKQssg4qUJIw/fTKURsblVC2YeC2TlzlQ
         dOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ROnzP60siuGiHzqktFDOH9iIayLn915GOnQp0HlYMk=;
        b=1oUGwfVlMwrKVUVrdbfkCJ8k7N+ZFw4/DVIDsADCQJba+oK9XoQVEQwfkRmpMhKM1w
         3mwr73mIuwSe2C2BC/OYLCpCmkeWf0Y+h/1v+YGcGkn9yx/ALO3N/X4/urXLHYY+C/6I
         YAoz5JGmpe6QrwT4cHLeRT5KDYkw4UPWcBntt6YRduMhx/0bXlcCpuKEl7u4LsIff4pt
         WH0UyKWJH7BnktBMIgq+fSHv45kpCY6XSdveb9Vi9eK4uMixsX+DQSpJ+NUJZdPzoRdC
         gQVWaeR6/v+OXghlJfUiuCRaeWKHJ0Se1NX/dxrVPzxFOcNKSYLMyNk6fVeqm7p9CnzL
         00ZA==
X-Gm-Message-State: ACrzQf1CHTLM499V0i3TvkoptS3G009WT4h7BNHtC0l77SkmmzYpVAJ4
        gZh+fp5LI56wnL7pT4GYnshkFA==
X-Google-Smtp-Source: AMsMyM4/C8rJdAsxQ9fxA3y4D0gF4T14Lak//zBKHECuv+eNLlugXnt6NnEZ+GqZGk9vdGO2+bKo8w==
X-Received: by 2002:a05:622a:1713:b0:39c:e41e:2b27 with SMTP id h19-20020a05622a171300b0039ce41e2b27mr36484122qtk.45.1666803835511;
        Wed, 26 Oct 2022 10:03:55 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm4370163qko.53.2022.10.26.10.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 10:03:53 -0700 (PDT)
Message-ID: <8489ce0a-3278-5509-4f82-f3d9d5ddd4c0@linaro.org>
Date:   Wed, 26 Oct 2022 13:03:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
Content-Language: en-US
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930220606.303395-1-jwerner@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 18:06, Julius Werner wrote:
> The bindings for different LPDDR versions mostly use the same kinds of
> properties, so in order to reduce duplication when we're adding support
> for more versions, this patch creates a new lpddr-props subschema that
> can be referenced by the others to define these common parts. (This will
> consider a few smaller I/O width and density numbers "legal" for LPDDR3
> that are usually not used there, but this should be harmless.)
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>

Julius,

For the future, write cover letter which describes why you are doing
this. You explained the "why" some time ago in responses, but all such
information should be in cover letter (plus the applicable part in the
individual patches).

Grepping through past emails to find "why" is unnecessary burden.

Best regards,
Krzysztof

