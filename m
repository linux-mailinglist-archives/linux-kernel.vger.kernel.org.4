Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4356A6ED8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCAOyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjCAOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:54:00 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0E28D2C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:53:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a1so8433022iln.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1677682439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwI8tOfzfdazowf72DLvwukg9+Hal0tmqWNmV5upb6I=;
        b=BEv6V4RdIovKT4Th0D3aQS7wvrYFLKYoH/ySvcerlNwAdKAyA8H7w6rxRmU96F8LUF
         Axg/n7BS6qEkurzOhgmzD3LfrrI9+n5ITu6aaIJv7QX/+DkBh/IkfLN8ECsd6CFQm7RX
         zFNrfQCmCXuvcz2JegWq8dJS3Cyorvkah3AT7Jvc2ngpwMJxGmU5zX1TOoDjihWwlioq
         +WPM4HJdUx08/IblJRh68r1khqaLo3+g94rUSsR7b6quIzeYISTkQqls5RWZpEd8l5oL
         PUxtaOVuLsNKfH16iGM82R1Ztn6+UG1RCkF7AhsGdW81+nZASG+/9fcJO4F5C3vTn10r
         A2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677682439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwI8tOfzfdazowf72DLvwukg9+Hal0tmqWNmV5upb6I=;
        b=PualpaOv+472oUlVx2rkg05TWt174F95/IwIssQHvnWTMn6Z1XztaJGOvn7IJTZgYZ
         H1IXSXOt4cZWF1BWTu/F9uhxND7WbxHGmOJYxVwTahEVABHgBwTG6n3JUSKa2CHVu4Lw
         4dqEAqjQtPrtawo5rQCFiToGX0ZctUxKczhfUlxMwSllfWMNIKYXIOu4lcr3UAogO5eT
         qpWsNaJvk2yz0iG0IY68u2tKSqxBmKTYHic2SQi2f0uR8funs8mn4VwT/DiQZpH3MTPM
         8wYMLHvxvkd7YMbgUauV4aurx7fXAEU5F8I5thVVpoSEZXWyT+IEKWZR4vQS/h96SoqT
         kP+w==
X-Gm-Message-State: AO0yUKXVfogekS4UF19Z/ecco4ouRZubAHhoI6tAjs7EuGgPRuTlD6R1
        CJ8UwiQNSXzYWqKI0v+r0gn0grvaiYMHXZAI
X-Google-Smtp-Source: AK7set9wUTQIAy9iDR60wz+zEI48LqNnzQUExlEWqfvjXXoFgtFvDZW52iAyrGkkt59GUz7nwuJOxQ==
X-Received: by 2002:a05:6e02:1a8d:b0:317:1ca3:f518 with SMTP id k13-20020a056e021a8d00b003171ca3f518mr5691984ilv.0.1677682438994;
        Wed, 01 Mar 2023 06:53:58 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v10-20020a02cbaa000000b0039c492ae300sm3696122jap.114.2023.03.01.06.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:53:58 -0800 (PST)
Message-ID: <5ff2b3c0-eb96-c423-dcee-1bdf6604e9df@kernel.dk>
Date:   Wed, 1 Mar 2023 07:53:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: INFO: task hung in io_ring_exit_work
Content-Language: en-US
To:     Sanan Hasanov <sanan.hasanov@Knights.ucf.edu>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <IA1PR07MB9830E72E8A3426B8151185BAABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <IA1PR07MB9830E72E8A3426B8151185BAABAF9@IA1PR07MB9830.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 11:23 PM, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.
> 
> Kernel Branch: 6.2.0-next-20230225
> Kernel config: https://drive.google.com/file/d/1NS9N8rvftQ7BouImn2OVnC96qrNhAeuO/view?usp=share_link
> C Reproducer: Unfortunately, there is no reproducer for this bug yet.

Not sure what we're supposed to do with this, without a syzbot or
c reproducer? You can get into this condition if you SIGSTOP the
task so it can't complete its task_work, for example. But impossible
to glean anything from this report.

-- 
Jens Axboe


