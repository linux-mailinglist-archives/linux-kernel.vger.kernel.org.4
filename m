Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EA5721DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFEGRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFEGQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:16:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D0DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:16:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso6650611a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685945815; x=1688537815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nczuT/c/Qes0P/uVYp4yXHku3U28CK0is8MzDelgl2o=;
        b=dGdsIERC+Xnwm5uOZbkItcC2LTDYZLiThyLnz4e1r4r2L/SV7h2o3tJe33fw0ZXNNy
         Eri4L/eeSQ8SUW1wwlbohIXZIrf5EyFrwlzgRf+JEYQyGqyY4A0r0cCgBHIcG1aNXGCz
         g3CyuLhHcZ3klJBYKPKiMaL5tY6s3Y08Jrk5NoggUwo3A+VL6JWDYCnPRtUGyVOJ8gWi
         fANoFRMIicjwjTtgn5+1CiVI6o4LaEN4VWq3u43EfZrLC79Goy1WLxg3JZj9f5qi1WJI
         lEEDgfORZrmxOK+35/iKC4zfKO/+yVjaPw9MMFYhK3xUeSU00mIg0UA5buHnx8LtOSct
         6T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685945815; x=1688537815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nczuT/c/Qes0P/uVYp4yXHku3U28CK0is8MzDelgl2o=;
        b=H1Rb/he8ucgS011MsfcDfODKi5yjQRNo4jCN3LuHSSgxi2HrhzqUFV7UnttJ8o6Tdh
         lzk4KweGisGbkI/OMkyh7zrxwVLKM4AetQO29M+YrKUDbgr3OLOdxznkuYIYoqXCZeSh
         9WyLpp91HK8Bg0L9WHfJZrvY6gwNU4TyCS+ebdyx3N8slrMdjqlQ2SxDuH2RFROijO6o
         4WPJpg3o1MVe6/K+94uCBhTezdqBbwM9j3ajH24zCEX2f26K3m3Blz0bcUCYj+9tLc9I
         30hKV6LYIU/Zhtm1BH+q6oefpMZzY/1HO6zAHjcWtEQ1XPQEOLKlk93jnZ7dyYS7gcdj
         8kig==
X-Gm-Message-State: AC+VfDzWATisKN1sqBAktgkuKL/pzVnadgm49K7qeJO1PP+0XLRN5A9d
        jWA7HZlv2On5ptVNHrG5tJDfQA==
X-Google-Smtp-Source: ACHHUZ6bBE8nliXwBKq7YwbjCHsuMRnaZLMDhc5vMfx5nKjs7e2D5jsjcmdxmbMWUlA6eMT8kBd5hw==
X-Received: by 2002:a17:907:9815:b0:974:4f34:b043 with SMTP id ji21-20020a170907981500b009744f34b043mr5962530ejc.1.1685945815186;
        Sun, 04 Jun 2023 23:16:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm3893187ejb.35.2023.06.04.23.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 23:16:54 -0700 (PDT)
Message-ID: <afa6aceb-3435-f146-ea1b-e205c1610858@linaro.org>
Date:   Mon, 5 Jun 2023 08:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
 <512e8b06-3ef4-66ae-5ca3-5a863a10c51f@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <512e8b06-3ef4-66ae-5ca3-5a863a10c51f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 04:59, Ravi Bangoria wrote:
> On 04-Jun-23 5:08 PM, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> #regzbot introduced: 9551fbb64d09
>>
>> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
>> searching code") as first one where all hardware events are gone from
>> perf for ARMv7 Exynos5422 board.
> 
> Is this inside KVM guest? Does this help:
> https://lore.kernel.org/all/20230525212723.3361524-1-oliver.upton@linux.dev


It's not a KVM guest. It's regular board as listed at the end of the mail.

Best regards,
Krzysztof

