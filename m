Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2337C6D2245
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjCaOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCaOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:22:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60791D2C8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:22:51 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t10so90096241edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680272570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DALbSHEn4AqSZILtcopWk6ItUnpljvj/yr+9gMsLC6Q=;
        b=OvOCpPtOH+9NxFOTq/R9b14rcLyyaA8lnRaHHFPPuLkxH3F/YDghfWgEVXJmiTYrHM
         vZD8zr08GIT5zuzE9ftaRWWVcDgpOM14VzyUqk0rqKoEfJ5R/NrfDdJ1blJvAB6UK/az
         sNSM9BlCq9ryuwatU6nvTl54xgH+DQkz3unVFRhJvTfJNaJe+1z9IejpuZ/4JSMUHO3/
         TaKuZYVKfYRPMsGlKCrVlolCdgtL/O4EivH5KeMyaIX2+s+FAdCXQRXWXbdgNSzI0vvv
         f+U0eFVETd+0l9v7ittCVzkOSp7R8w+LBCZ0PzhVuV5eaoGQqbZ81yRCZyVj+6D/nZpc
         JSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680272570;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DALbSHEn4AqSZILtcopWk6ItUnpljvj/yr+9gMsLC6Q=;
        b=IR/CeWzkhIgd6FawwApYHBw2LnKkH5NuzgpXH+Pc01p+AKS0jYa8TKmHkNp+F49dbU
         C+T+0V45K2wODpStRA9MfXv/OQ//eGZwgilNmCT9N6AtHQZDni89l6V7p9TpKVFcKWlr
         e3cBNWZGLtcdKTqTmElX6sn9INl+Bywrbyw5219hdVrP6YCKx18D8kqOHSDKazVxJYIU
         rBcS2VWZZmWupreJSrZK7PV4O76Ns2OlGJgj2Yt5Awr0VkZTRoJRNTAJIFQPpbtY33P3
         P9Xc4HSMN+Gb9JSrZDVXtUK8LYmPHTitblVCtmk9YruCaGhu+vMnjFm7ocMSgWlCbkG1
         QORg==
X-Gm-Message-State: AAQBX9ezM39jV4guS2UJM1yPyXt27J9AuNjvDUCKgawFzdyzKqvQKRsp
        lGAsXA6QEU/m56ysCqQA0jxlzg==
X-Google-Smtp-Source: AKy350a8XVvZ48xZMQYC78wiy/ZgV53SZYI4rk4oZhyHioBEZ8JOv3u/hLwfN9XG/5wXPj0wZUyDZA==
X-Received: by 2002:a05:6402:10d8:b0:4fb:2296:30b3 with SMTP id p24-20020a05640210d800b004fb229630b3mr26057313edu.15.1680272570271;
        Fri, 31 Mar 2023 07:22:50 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709067cc300b0094776b4ef04sm1057862ejp.10.2023.03.31.07.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:22:49 -0700 (PDT)
Message-ID: <280400a1-2dfa-fc8f-92e0-0087b10b37e8@linaro.org>
Date:   Fri, 31 Mar 2023 15:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change the current atomic write way
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        jaegeuk@kernel.org
Cc:     Daeho Jeong <daehojeong@google.com>,
        Lee Jones <joneslee@google.com>,
        syzbot <syzbot+b9c67110e04430822b08@syzkaller.appspotmail.com>
References: <20220428181809.2352352-1-daeho43@gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20220428181809.2352352-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 4/28/22 19:18, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Current atomic write has three major issues like below.
>  - keeps the updates in non-reclaimable memory space and they are even
>    hard to be migrated, which is not good for contiguous memory
>    allocation.
>  - disk spaces used for atomic files cannot be garbage collected, so
>    this makes it difficult for the filesystem to be defragmented.
>  - If atomic write operations hit the threshold of either memory usage
>    or garbage collection failure count, All the atomic write operations
>    will fail immediately.
> 
> To resolve the issues, I will keep a COW inode internally for all the
> updates to be flushed from memory, when we need to flush them out in a
> situation like high memory pressure. These COW inodes will be tagged
> as orphan inodes to be reclaimed in case of sudden power-cut or system
> failure during atomic writes.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: removed inmem tracepoints. changed page flush timing. fixed hole
> handling.
> v3: removed unused atomic related page flag.
> ---
>  fs/f2fs/data.c              | 180 +++++++++++------
>  fs/f2fs/debug.c             |  12 +-
>  fs/f2fs/f2fs.h              |  33 +---
>  fs/f2fs/file.c              |  48 ++---
>  fs/f2fs/gc.c                |  27 +--
>  fs/f2fs/inode.c             |   3 +-
>  fs/f2fs/namei.c             |  28 ++-
>  fs/f2fs/node.c              |   4 -
>  fs/f2fs/node.h              |   1 -
>  fs/f2fs/segment.c           | 380 ++++++++++++------------------------
>  fs/f2fs/segment.h           |   4 +-
>  fs/f2fs/super.c             |   6 +-
>  include/trace/events/f2fs.h |  22 ---
>  13 files changed, 302 insertions(+), 446 deletions(-)

This patch fixes the bug reported at:
LINK:
https://syzkaller.appspot.com/bug?id=50ac8d898487cade14315bf673e8d74fd4716ecf

One may find the strace log at:
LINK: https://syzkaller.appspot.com/text?tag=CrashLog&x=11f5de2ac80000
and the C reproducer at:
LINK: https://syzkaller.appspot.com/text?tag=ReproC&x=111facdcc80000

The patch does not apply cleanly on stable/linux-5.15.y. Backporting the
patch is a bit risky for me as I'm not familiar with f2fs. I'm seeking
for some guidance. Is there a plan to backport this patch to Linux
stable? If not, shall I try to backport it? Would you advise me to try
to find all the prerequisite patches for this patch to apply cleanly on
stable/linux-5.15.y, or just to fix the conflicts?

Thanks,
ta
