Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139906ACC7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCFS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCFS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:26:14 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABD580F1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:25:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so42643311eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678127128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQzsrijClWNNzU3MRuhrnrc1rJRiQBgGk6WQ0sbFW3w=;
        b=hOraMv8H7Cyz5xH6F7BK/KyRTvjXIZqXW9MxDPz7cE2clNcvKPVAVWnMOGnD8OCJYt
         bbnDcAlBA40qUUqzWql2ZfFMYGK87mnXjnQEzZBq2+FV2TugN15eYHqXRWiV5tJTi0nV
         0Iu0OfdTHVYuVav3UMc4jZGk9SRBfCuI4QuE+qTuuRfEmxH4frYRr4qH2QhVDc4KSAXo
         iV063p5qOo5CAFYkLs5heOtOof1RMogLbiJGS0ePSKgOsgiiLMbBI7mgvgy+5zb0Mj7j
         rgIZV7el8QgPYEic7w2QZdqobAOpKz8CQloM07aqIjjny0rfbWGGq7tBaVeMpDf9LWiD
         JfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQzsrijClWNNzU3MRuhrnrc1rJRiQBgGk6WQ0sbFW3w=;
        b=kViSgg6dKXRRaFVrzoUUtiZRXuP3l/ekxObp0uw55+OkX9gDpSxR0hJ5qmefRQhxO4
         K4LBFpOsqcpOVwjfds9Yr6y9IfSAvpXlulZebg8jCBUMN9mc9Zik0AaaAxvPK1rzw9OX
         4lh7r6cCV90s5yoMOP5LJeSy2gRT13VJ+QD7gavWab51LmDcei+rJIy9sOX+ophyuoqj
         CnFOxan6/z3iv8K81K5gebnnDEi1sov957g8kwPSl1taGhQ+oNI5eaDhTsNFD77zt2a9
         ZJ9RxRorM58mGtFxpGCy+1OjqVZWCbWMhTwGYvKXo3+oKY+rXViD2yjRjtaDvG5ukwd6
         4ZkA==
X-Gm-Message-State: AO0yUKXjnMNElang/gYjcD7O2a4tSY/93shlJfWxSAlGGWRNTh/s1wX8
        JvvNePsrygjcz/F4XpfPiNu9rw==
X-Google-Smtp-Source: AK7set9JT2Nj4Pw013wQ3FbV4jgAzrH9Kxatn5KcWt4QQiYFaLHZ4DdRvS6lee8MRRyNPFu8gIV/1A==
X-Received: by 2002:aa7:c44e:0:b0:4af:502b:54a8 with SMTP id n14-20020aa7c44e000000b004af502b54a8mr9877761edr.6.1678127128376;
        Mon, 06 Mar 2023 10:25:28 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:dcb0:1567:5d06:3be8? ([2a02:810d:15c0:828:dcb0:1567:5d06:3be8])
        by smtp.gmail.com with ESMTPSA id x20-20020a50d614000000b004aeeb476c5bsm4816005edi.24.2023.03.06.10.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:25:28 -0800 (PST)
Message-ID: <16bee433-0088-d651-9592-96a2bb827b7f@linaro.org>
Date:   Mon, 6 Mar 2023 19:25:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/27] memory: tegra: remove MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-16-nick.alcock@oracle.com>
 <c6f39365-e840-d782-8ec0-e34ec3681b98@linaro.org>
 <acc27e8f-73ce-39ee-3666-461f5c72d39d@linaro.org>
 <87h6ux7qhp.fsf@esperi.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87h6ux7qhp.fsf@esperi.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 18:13, Nick Alcock wrote:
> On 6 Mar 2023, Krzysztof Kozlowski told this:
> 
>> On 06/03/2023 15:30, Krzysztof Kozlowski wrote:
>>> On 24/02/2023 16:07, Nick Alcock wrote:
>>>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>>>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>>>> are used to identify modules. As a consequence, uses of the macro
>>>> in non-modules will cause modprobe to misidentify their containing
>>>> object file as a module when it is not (false positives), and modprobe
>>>> might succeed rather than failing with a suitable error message.
>>>>
>>>> So remove it in the files in this commit, none of which can be built as
>>>> modules.
>>>
>>> Applied as well. Squashed with next one. Same subject messes with b4, so
>>> prefix should be corrected if these were to stay as separate patches.
>>
>> And all dropped. Run checkpatch before sending patches.
> 
> So... which of the 27 patches n this series is being dropped? It would
> also be nice to know what the checkpatch problems were, because all I
> can see from checkpatch is one error per patch, an apparent false

The ones I responded that I applied - so the memory controller ones.


> positive:
> 
> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 8b41fc4454e3 ("kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf")'
> 
> The commit message says:
> 
>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> 
> ... which unless I am seeing things is precisely what checkpatch.pl is
> asking for. Perhaps it can't handle wrapped lines, but not wrapping a
> git commit log line *also* (correctly) elicits a checkpatch error...

It's not a false positive, but an error I am asking fix (assuming there
are no more ones) There is no problem with wrapping lines - checkpatch
handles it.

Best regards,
Krzysztof

