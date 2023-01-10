Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76914664F98
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjAJXJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjAJXJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:09:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F46BDE4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:09:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so15185114pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asZlnaSDBFZfcR4dBbu7+u86J014YdwzTazLrkO1nNU=;
        b=n+MlT5zvfTv79aZ3my+IDH+q4f/n6Q07oMtia96ewo14nvSPIHDDuENXLJAS1gZLq/
         A0YTsv14YEL/cQ3VUp8Dj/8/ZxbZAw8LGaiwyDxBNfznTc1XHl/fbYYQK9+5BvSsePmx
         ++y998swSOw56mxkw7vXTQ2BAevG6/zdgd7dtYEgF9eR5hzwMUSm4Fz4nNGfq/emiUE4
         txF9POerzx3frO5cmjIc5Nt44aknDySLQuvtJfPEKop63hhkqv2mecBagsl1CacPsCf4
         qMHGy2frbE3oPnpz2ltnOeGZu6IxwukJS59FHgTEaqmzbHAvGs9Ortj27sIjduwHYNwE
         PrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asZlnaSDBFZfcR4dBbu7+u86J014YdwzTazLrkO1nNU=;
        b=wQmn8ysFdNdPIFaPBV7fofTsBqLhnXVgrlP1/BKqTrO7wBerpVklEvTdgP32f+f/X0
         xhslpXjQE0f/Qq1xdEwmoZuvFXl2p5v3Modf9X5J+XtmOqIZFQ2R99ZDmnUHHsyg6/71
         jwIw31w+rtlAJpgryw+5D/337MBJ9oCJxvJB8j2R7AoChKgHH8BmJbMjKlKNIZSIS2iM
         VLpkhqOR8NGcLKLQL0RQHhcjQkIyWca0u4SBymW96pqoiSwl0S1iC8DV5GWdbmAMlr3S
         zTmUBHyWLPGjAh7IOF7th5VClzs0Y0xkerZlHQDjwu2jKTJJKV7x2r4RdHqZ19SyqmA1
         CQLA==
X-Gm-Message-State: AFqh2krD0fIxIP6GdfwJF5qkpzok+BLlxhNtHZ6jsS+jdMY0BrezdbtJ
        Gc9CIrUfOdN4T7xbjLD66c3L7Q==
X-Google-Smtp-Source: AMrXdXs4aHVWfR/3SWs1+bZYpU08L8hFRxB3gnaTo9Ol7qhiwZCXwd8nWMH0bdh3X6+eZcCReYPlbw==
X-Received: by 2002:a05:6a20:7d81:b0:b5:f180:6d2c with SMTP id v1-20020a056a207d8100b000b5f1806d2cmr2102763pzj.4.1673392153505;
        Tue, 10 Jan 2023 15:09:13 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p6-20020aa79e86000000b0056b4c5dde61sm8862630pfq.98.2023.01.10.15.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:09:13 -0800 (PST)
Message-ID: <e0d7b1ed-1ffb-c97c-13fa-055db635f404@kernel.dk>
Date:   Tue, 10 Jan 2023 16:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [syzbot] KASAN: use-after-free Read in io_wq_put_and_exit
Content-Language: en-US
To:     syzbot <syzbot+0ef474eead6cc5d7f8f9@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ebcfaa05f1f0e161@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000ebcfaa05f1f0e161@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think we can stop reporting issues on the same buggy patch... But
in any case:

#syz test: git://git.kernel.dk/linux.git syztest

-- 
Jens Axboe


