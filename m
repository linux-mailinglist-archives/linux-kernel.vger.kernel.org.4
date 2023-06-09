Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC072A320
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFITbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjFITbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:31:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B772D44;
        Fri,  9 Jun 2023 12:31:08 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0236ee816so9265835ad.1;
        Fri, 09 Jun 2023 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686339068; x=1688931068;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F34e28g4Hf9Xu+fszBUHQ7hLKPkEewO0EPUPYwTOjus=;
        b=LE/fMAN1eq+8apJ5cArgFf2LnG32AfY2XmpV26YtEqBi4dZ42YoMHnEcgB7Oh3NbgB
         nckQVLFbaSRF9RRETPQkN0E1/u0TRgjpngQ987s/qhDZIdgbwMso0dcUidTLs7m5OC/r
         2yBQAZyczYX9eIwKylGrjK36/954Zt7wzHn8D1JgVEEH6bQP1EblABjVKUlm/ErO1RTs
         lLfQay2hApQRAscs3PZ3PWRCi00OmWAYUZkZq+ux2Ch2hE/mPhhjb4vfR8Ld95of43Xh
         ZTzexqW5zub3WJfGgnqPKKfWV+7FAdvMTvbbQojEtwKFZxuQdGAtAoCiAmc9k0z2Mhz4
         Qqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686339068; x=1688931068;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F34e28g4Hf9Xu+fszBUHQ7hLKPkEewO0EPUPYwTOjus=;
        b=Z6A0Cc+h75LD+9lWQSjkedSQuzgAiDMAOvFueHVNaRCKh3ZBPnMNsssSPYjOoy/Ebp
         ac7SsD0ip2v/vu2uFP84LfacFYhO1ojfBPVvo9wxSPc39LWRbk0azEyvV6WbwL4qwW1X
         LLhedgbe9x0Y1uUN8l6+WqM/BJMzFMmejJrmCiT9iaev0iB69Eeh7piPIsg+j9L5agB8
         N5UnKAERgjKpy/b52WqdORZBJLXGmhVUDA/EUvlcNeHQrt503+4pZEmtKIw7qexPr1Un
         lY5UdkAZbU0lUoZyj90RS/Lo5P4NtgiQXVAeCEIMmKAR6a66B8pbeVDK0eTyQBKbiXPr
         6Yzg==
X-Gm-Message-State: AC+VfDwoxhm/fJTR3x8nA5VKlH5TC+5ttNT+Bs0zA382Al9jcRwbKxjk
        zROJhEmza4cLSeYmY7Nja+c=
X-Google-Smtp-Source: ACHHUZ4EDmsFV4rkhZkvBQJPbuLNdV9oFboN/HmzG5iCfpmxSjR0JkyudcjqFqlMwaIKqRz2uHqlpw==
X-Received: by 2002:a17:902:f947:b0:1af:bae0:6be7 with SMTP id kx7-20020a170902f94700b001afbae06be7mr5559562plb.10.1686339068275;
        Fri, 09 Jun 2023 12:31:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001a69c1c78e7sm3654934plh.71.2023.06.09.12.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 12:31:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8a166eec-fc09-9ae8-b590-2c2e84796da0@roeck-us.net>
Date:   Fri, 9 Jun 2023 12:31:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Thomas Gleixner <tglx@linutronix.de>,
        Ido Schimmel <idosch@nvidia.com>
References: <20230607200903.652580797@linuxfoundation.org>
 <b979807a-a437-4d3f-98f9-989da52abb30@roeck-us.net>
 <d35b1ff1-e198-481c-b1be-9e22445efe06@roeck-us.net>
 <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
In-Reply-To: <CAHk-=whA=HsyDFtgQnWMZP-08ddhMh1a88OZHCXf8N-iP6hFQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 12:06, Linus Torvalds wrote:
> On Fri, Jun 9, 2023 at 11:42 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> I managed to revise my bisect script sufficiently enough to get reliable
>> results. It looks like the culprit is commit 503e554782c9 (" debugobject:
>> Ensure pool refill (again)"); see bisect log below. Bisect on four
>> different systems all have the same result. After reverting this patch,
>> I do not see the problem anymore (again, confirmed on four different
>> systems).
> 
> Does this happen on mainline too? It's commit 0af462f19e63 in the upstream tree.
> 
> It was in 6.4-rc1, and I see a clean result from you at least for
> -rc2, so for some reason it sounds like upstream is ok. But I don't
> really see why that would be the case...
> 

I see the problem only in v5.15.y, to the point where it is almost
impossible to get a clean test of all arm-v7 systems. Affected are
npcm (Nuvoton) boards (kudo-bmc, quanta-gsj, npcm750-evb) as well as
orangepi-pc. I don't see it in any other branch or with any other
platform/architecture.

Mainline is fine; I have not seen any problems since -rc2.

I have no idea what is going on either, only that I can reliably
reproduce the problem (and of course it disappears if CONFIG_DEBUG_OBJECTS
is disabled).

Guenter

