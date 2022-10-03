Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB755F2778
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 03:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJCBR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJCBR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 21:17:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567803687C;
        Sun,  2 Oct 2022 18:17:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8705256pjk.2;
        Sun, 02 Oct 2022 18:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ea4Dhkf8Ig20YxhTpzRQu+OV4A/Sn5CkcLr1NVTi+sA=;
        b=HL1mdIq7pLpR3vycDeQtDjZeGvJNS9D/d4CdKocJqhd5RvK/IRHuVqfJOoMMQE+6NZ
         i7caAs1PYW8WXQBMxsigZX9cv7La2sZa+eKqdGCT9Qpja2e5bRfLMKkweH99i+plSYd7
         xRnjO3dpBtcmCz9vPlDfD+7VIYyf8npu8ZYIYNmkPlFP7OczYk41GnhqQbhhHubpX/Z1
         uN64IpeWHyhr3pi6+nkqkS1BJEBRasMb4xvlenyn2kRiaAepZXE1QoNyY6Fop26zSIW3
         SoK98jIn/mOqqoF5zPUH/M4nx2EkyV4SMk0zzrryrQuOFhSdO7gieWO9mFWHA21D/Ik2
         PBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ea4Dhkf8Ig20YxhTpzRQu+OV4A/Sn5CkcLr1NVTi+sA=;
        b=cH9vePKtq8J29fuWziN0o27WDGe0zZdJDIM7crz8b5V579RaBAevsBaexkKChsOvCl
         w7Ct81Whp/WoMq4zalgv8q2o8nvzwwbYcpPVEtWMjDp1MRwdLDnDprknm+jhMYe1D/a7
         hBzXs03nD0uk9+g5eJ6VX2Te1H/aJ0kz6Vr9DWwg20evvzlScD5fKrCmUUFhA7u1JI5x
         oGWKDxqWWY9c4QFRFk6Q54eJx6fvvaPwrQUbL5dbj5yFTXQZT9U6qyDy6W1+J+AxA4rU
         9NM+WZUz+dxhT8pzNkN6pC5N3yMPMho9D5IrI8FaqdOvzavN0aIt5kv2RNUxGW9Avouy
         L0CQ==
X-Gm-Message-State: ACrzQf3Q0B4L3oJ6TCqQUuKXoB5QXE/EAY6vjksO/tyhClNrsNWkAUyw
        OwLhxAfPgqQzcQKp28ZKVg8=
X-Google-Smtp-Source: AMsMyM6w9sh2i5hUtEQewTYJ7NhuCibvLH5gbmY1x36M9nuSBB7frEZMSns2+eoU0CN0707ENCZsaA==
X-Received: by 2002:a17:902:8bc2:b0:17f:5908:9a01 with SMTP id r2-20020a1709028bc200b0017f59089a01mr3029018plo.133.1664759844825;
        Sun, 02 Oct 2022 18:17:24 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0015e8d4eb26esm5869326pll.184.2022.10.02.18.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 18:17:24 -0700 (PDT)
Message-ID: <92ef6be6-dc99-555d-8263-77484b7d0f12@gmail.com>
Date:   Mon, 3 Oct 2022 10:17:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Joe Perches <joe@perches.com>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        Theodore Ts'o <tytso@mit.edu>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux@leemhuis.info, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
 <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
 <b119fee5-807f-1940-3378-f5ad638794f5@linaro.org> <Yzen4X1Na0MKXHs9@mit.edu>
 <70759d05-2646-57e5-0b87-3a196488f622@linaro.org>
 <dabbb4aa-d5e1-10d5-082c-1386f3314fc8@linaro.org>
 <f7f6a67c5ee662f24885579ba09b281a5d597b0a.camel@perches.com>
 <de5e732e-4857-dc69-a6c1-f0c1d52f99ef@gmail.com>
 <b5731dab6be760fd226097602cf31c610d69bdac.camel@perches.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5731dab6be760fd226097602cf31c610d69bdac.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Oct 2022 16:55:05 -0700, Joe Perches wrote:
> On Mon, 2022-10-03 at 08:04 +0900, Akira Yokosawa wrote:
>> Hello Joe,
>>
>> Thank you for chiming in.
>>
>> On 2022/10/03 0:49, Joe Perches wrote:
>>> On Sun, 2022-10-02 at 09:58 +0200, Krzysztof Kozlowski wrote:
>>>> The easiest to achieve it is to run with --no-git-fallback and CC entire
>>>> output. However it does not mean submitter must run with
>>>> --no-git-fallback. It is only for this generic rule - CC entire output
>>>> of get_maintainers.pl.
>>>>
>>>> If you add such rule "CC entire output of get_maintainers.pl" and do not
>>>> mention no-git-fallback, some folks will think they need to CC all these
>>>> people who made one commit to your file...
>>>
>>> false.
>>>
>>> git-fallback is _not_ used when there is a listed maintainer for a
>>> specific file.
>>>
>>> If there is a use of git-fallback, it's because there is _no_
>>> specified maintainer for a specific file.
>>>
>>>    --git-fallback => use git when no exact MAINTAINERS pattern (default: 1)
>>>
>>> i.e.: It's not "your file" if you don't maintain it.
>>
>> Joe, I sometimes see unexpected output WRT --git-fallback.
>>
>> Example:
>>
>>     $ ./get_maintainer.pl -f Documentation/doc-guide/sphinx.rst
>>     Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION,commit_signer:1/1=100%)
>>   <-- ???
>>     Lukas Bulwahn <lukas.bulwahn@gmail.com> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
>>     <-- ???
>>     linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>>
>>     linux-kernel@vger.kernel.org (open list)
>>
>> As you see, --git-fallback is used in this case. Why?
>> It looks strange to me as Jon is listed as a "maintainer".
>>
>> Having "F:	Documentation/" in MAINTAINERS does not suffice?
> 
> No.  It's not an exact pattern match as the files below the
> top level of Documentation are not specifically matched by
> "F:	Documentation/".
For me, calling this is "not an exact pattern match" sounds
inconsistent with the explanation (quoted below) near the top of
MAINTAINERS:

	F: *Files* and directories wildcard patterns.
	   A trailing slash includes all files and subdirectory files.

What am I missing?
Does this explanation needs update?

Regards,
Akira

> 
[...]

