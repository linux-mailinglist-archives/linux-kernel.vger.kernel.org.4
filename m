Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69F667DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbjALSO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbjALSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:13:28 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBCB6D504
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:42:30 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q190so9367416iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvAQiiZmTGdSV6CVcDlCK72GqmZAsS7eBjqDC+1TliM=;
        b=1kE5uUJGTn+m7E4k6/2BXZo4Or7BVUvHbddS+r8XEWkQJGwIRroTcLjlTCjj1JFD9m
         JOFBFerlwx+wENJRenYGikJyIHgowaGHbq8Iixd/LMwK7oBu975juAdzAUiCgUQQ5nZT
         9x9QXnMKgIq+GuzS7zxFZAx7T40+UWdOvUYTA6yxfVpg365+DnMH7mRECMkZSm7HKGHt
         2fNCp4BrIwIn/9Eo8LtfXXq1W1adSesq3A9bNKv7wAWjf8J8Ut/6t0LpYoidxw3QM7Ap
         ydhpB6efkmsYgJgBJU6l7n36UhbByYk6k6/VP3jpaEby6pBvZoIDuswKnhOEI/hMVfw9
         Leow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvAQiiZmTGdSV6CVcDlCK72GqmZAsS7eBjqDC+1TliM=;
        b=nEbJnpjc1nwmhx/rbuZnMQEc0W9EbUoX6Y1qhme6ffoXYH+5cR9FQLu+xVaKK6nv8v
         ryeaiN8egZEtS9QieRP/ldKavdJnGBwmFe0vz/dQkMCpx2WsNgzpjsa0M4hnMAEvGpEQ
         GdEOo5MdmFXwyvfZbe4dv5TBRECZ8bj+0VBEz8uhUpAmFApe3oVgobV4GMy4+G8wv91q
         OcJDjo8c2DzXn/OGnuA9RHAAwjK2k5yEf8raJ0fLn86bOGOPO9fU3IWDLUKojF4oCf2Z
         Q3XCpxOeW0xH6W50W6RQZX5OZH2p1RNk0L5gpwsRzhJn2n054F9QySHKVAQiYGhn+8dH
         G2gw==
X-Gm-Message-State: AFqh2koCN8MQnSPI3xu5zCpj8uPAoNNKTl2raE/NXxXy0a1mWAlDhcWX
        l1gMhk1/R01Sg0FN7r0+/N5hyQ==
X-Google-Smtp-Source: AMrXdXvk9xhzcaFoZxxmmknHJy44EbqiSOphFJECV2pokMptWalRXsAA0qmsiyW3lmBDHZEgRkUD3A==
X-Received: by 2002:a6b:7702:0:b0:6e2:d3f7:3b60 with SMTP id n2-20020a6b7702000000b006e2d3f73b60mr9591641iom.2.1673545349977;
        Thu, 12 Jan 2023 09:42:29 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d18-20020a0566022d5200b006cecd92164esm6179854iow.34.2023.01.12.09.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 09:42:29 -0800 (PST)
Message-ID: <0b47feda-b3b2-02e8-36bc-f55a3e27bc35@kernel.dk>
Date:   Thu, 12 Jan 2023 10:42:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in io_fallback_req_func
Content-Language: en-US
To:     syzbot <syzbot+bc022c162e3b001bf607@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000cf0f4905f20e504c@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000cf0f4905f20e504c@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 3:09 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=103269ce480000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc022c162e3b001bf607
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

#syz test: git://git.kernel.dk/linux.git for-next

-- 
Jens Axboe


