Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7324634077
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbiKVPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiKVPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:43:19 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719B1743A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:43:18 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o17so1218279ilg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FyLRcWeEt10Tp6Q2JSqZYM23I/W5i6bt7PkeloOjrY=;
        b=F/l9sfjehEkVkYFxDLcg0q15uEq2C4J1hCH5nBl+qzVe5+J2mDnJ9mMs7KO018UF9n
         HcRfwzUPjMXduEd9m9s+gdINS4UCFDrUZm00qGxYFg9CTocqtCMtFJLqMOIrHbXC+4c4
         TgS3Rn9PriIqzHHhQew7xjyzuTs7GDDiD9y7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FyLRcWeEt10Tp6Q2JSqZYM23I/W5i6bt7PkeloOjrY=;
        b=rlGFaSot5CVANu8AtPwN4PbVuiIX1cfmp++ZGUWlopAy96GRJvHl6YsMtd529cfp8P
         9X8X6Qy2BjK0fsEcGOi9Eob2MrFON02xoHU217/RCjbcTabEhnRCBAn8MdBbuwi+Y6sE
         nxrMSL2MZ8fsqtkZi1plhZ/j4zMb0WH+FZtV5yDAzaqMwgY+EHr14z/5j8R4WWRP8NrL
         pau+jVU3hZbgHQf2r2oo+yE8IvGC+AYt26137WTY0q1UsDNXN7kGtyE8xcC4P+VVJkH8
         A1AyAvDp5mV4GIus4diptnxeXxejyKNMMpxFVqa4jkGHh/e1BXMmgpUXWt+Q5O/2Laph
         8Rrw==
X-Gm-Message-State: ANoB5pmlf6PsmmRHWbIInuepc8uq/4ZdYW5DUc62AgbVZ/kfoNksMJyh
        z9vnfc5fXsrXf5QE5h/tSKcYow==
X-Google-Smtp-Source: AA0mqf4OcSywAlDHIvJRhueT8aT6BdM5aBQw7Ev2IR9uotgHMoLPe8lMebYFZgoLIm/bvGqAwFB8og==
X-Received: by 2002:a05:6e02:1054:b0:2f9:4fbf:1f4c with SMTP id p20-20020a056e02105400b002f94fbf1f4cmr2741162ilj.296.1669131796818;
        Tue, 22 Nov 2022 07:43:16 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n13-20020a6b590d000000b006ddd85d06c2sm5349298iob.55.2022.11.22.07.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 07:43:15 -0800 (PST)
Message-ID: <42c7effb-691c-c7a1-0d7d-8ba1569c0269@linuxfoundation.org>
Date:   Tue, 22 Nov 2022 08:43:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tools: selftests: Use "grep -E" instead of "egrep"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1668763704-10408-1-git-send-email-yangtiezhu@loongson.cn>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1668763704-10408-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 02:28, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>    sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/testing/selftests`
> 
> Here are the steps to install the latest grep:
> 
>    wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>    tar xf grep-3.8.tar.gz
>    cd grep-3.8 && ./configure && make
>    sudo make install
>    export PATH=/usr/local/bin:$PATH
> 

Does this change work without the latest grep? It seems to work on
grep (GNU grep) 3.7 when I ran quick test on kselftest_deps.sh with
your change.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   .../selftests/ftrace/test.d/preemptirq/irqsoff_tracer.tc       |  8 ++++----
>   tools/testing/selftests/gpio/gpio-sim.sh                       |  2 +-
>   tools/testing/selftests/kselftest_deps.sh                      |  2 +-
>   tools/testing/selftests/net/toeplitz.sh                        |  2 +-
>   tools/testing/selftests/powerpc/scripts/hmi.sh                 |  2 +-
>   tools/testing/selftests/rcutorture/bin/console-badness.sh      |  2 +-
>   tools/testing/selftests/rcutorture/bin/kvm-build.sh            |  4 ++--
>   tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh      |  4 ++--
>   tools/testing/selftests/rcutorture/bin/kvm.sh                  |  4 ++--
>   tools/testing/selftests/rcutorture/bin/parse-console.sh        | 10 +++++-----
>   10 files changed, 20 insertions(+), 20 deletions(-)
> 

Please split these into sepratate 5 patches. All rcu changes in one, net in
one, powerpc  etc.

The change looks good to me.

thanks,
-- Shuah
