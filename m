Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C386DC982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDJQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDJQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:48:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7341723
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:48:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f26so7698753ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681145294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbCXv5qDEx3ekAoTD6YJ0lRywyUIKUCMvH54ZZXXl9U=;
        b=emTmAfqIrfaOlyO/x2I5Pda62SsRb7jUuAW+pKK780JRJ49zC+lkHm6NdwqubC7kYE
         AzWdaLfaWgUIHDe8FEzSMz3p5bPf9yio0um6/Aql7GzePa6/LOTbyjrC2VYJE7ZSyjWa
         VWYzlZ5llBv6ZJ2PUOjGGXsxJVlUXCGFU+nBPKBynN/wKZy6HcmRxsI7weQdOXu771Gj
         e0fNk25wsfXOguHaod3UYJar0u9VJXaqQISI7t1qLTKecSVqd/jwH5A+X5cXVayf9UzR
         5oto3HrGasabD2ZQLIiL3oC83X0UNw4SkmnHXZ1mbtS/i6tjlYAeAwH/xNEzRASskRIP
         MSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbCXv5qDEx3ekAoTD6YJ0lRywyUIKUCMvH54ZZXXl9U=;
        b=VE2GVdwwiV+IYAOPnREBeALVb2kKN8thdJvU5DiA639dJnBqVYY1d8ORjobXUpsMiw
         i4ixYAAp2CQNsQ89GKIzdwltv7VOEomYCCI9KKVUpd08DLt1W4ckjJgsupVFkGGqL3QZ
         OKIO8FLJVzHhNMUhlO+kA63SDMz1JKBLluJf1UneNNlGsq6kFuDRQssvo9gihlyOtWbV
         b2M1sop5bh9h9hj7J5EDqHYzELSfPBi8xPSBPaCM+aUFaofnLu6LOpQL5hkezlTs/dfs
         gPG+AjoYOy7jf/TUT9vSR7nk8MfM/cGmbPxJbUHO7oh+gSuxEOHsrzv9rdJOFZX2C+zm
         iGzQ==
X-Gm-Message-State: AAQBX9eq7FxwWite9RP6UKGv/m6L+Ad6cC5EE2dSG2s99YAV0IjE0GKB
        hCuB7B+19xLDIEGXwk6Y0SsKlA==
X-Google-Smtp-Source: AKy350YV+onsGG9cen8vaOwiN+d2LNvm+KtD3DQ1bpm4lAS4g2yukoYS1gCoJZR9mfMZSc7MLnUAEQ==
X-Received: by 2002:a17:906:2a48:b0:92d:145a:6115 with SMTP id k8-20020a1709062a4800b0092d145a6115mr7722620eje.38.1681145294126;
        Mon, 10 Apr 2023 09:48:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id xa10-20020a170906fd8a00b0094a4d8f1e86sm2341892ejb.190.2023.04.10.09.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:48:13 -0700 (PDT)
Message-ID: <a6e07080-0c0d-0461-52a2-768d60af53c3@linaro.org>
Date:   Mon, 10 Apr 2023 18:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
 <0395eff6-694e-1a2f-de78-8cb9d7b129a7@roeck-us.net>
 <20230410055634-mutt-send-email-mst@kernel.org>
 <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2facc7cd-81fa-b8b7-6974-217392906578@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 16:03, Guenter Roeck wrote:
> On 4/10/23 02:56, Michael S. Tsirkin wrote:
>> On Fri, Apr 07, 2023 at 04:08:30PM -0700, Guenter Roeck wrote:
>>> On 4/7/23 08:01, Krzysztof Kozlowski wrote:
>>>> Statically allocated array of pointed to hwmon_channel_info can be made
>>>> const for safety.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> This depends on hwmon core patch:
>>>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
>>>>
>>>> Therefore I propose this should also go via hwmon tree.
>>>
>>> I am not going to apply patches for 10+ subsystems through the hwmon tree.
>>> This can only result in chaos. The dependent patch is available at
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const
>>
>> Doesn't it cause build errors or warnings there?
>>
> 
> Are you saying that "hwmon: constify pointers to hwmon_channel_info" applied on its own
> on top of v6.3-rc5 (as done in above branch) causes build errors or warnings ?
> I have not seen any such reports, and I don't immediately see why that would be
> the case. Please elaborate.

My tree and patches are extensively tested by kbuild and there was no
warning reported (when the above patch is applied with above dependency).

Best regards,
Krzysztof

