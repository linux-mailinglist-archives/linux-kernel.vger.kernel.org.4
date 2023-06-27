Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB8773F117
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjF0C7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0C70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:59:26 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3581FD6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-656bc570a05so1053322b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687834756; x=1690426756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=651hNwclVHYOX/BiFQ2258R7Pq6s76Z2CiYetCzEGb4=;
        b=xvSF2Nf2dR9QNfEru7jjBTHeokur94W29qiuQ7CkwpG4G7dWKoRX131PtUXFsA5yRq
         MLKdOtW1Y+RodNRaRfluu9RZiG+sZi1aenbKa3gN7DzxtnNDPOGNyDWoiXPfg3MYVfwd
         h3vfNsktHq9mHStiIEjUmOswjmTGRBcuhy+VUI6JmeuR0ttu1akFUcu2tiiccSvdH7HM
         mCZrJA4t3yrLrdfHo61RLN1EMQSJpEv4nWUquPv33+xU0StmnyezchJMezWosrQ99udv
         3gWaj8lZlVlerx+kcAvCx8e42USCSyTw60qBGoPibTnawd4eNohHa6jQQf48cF5IWh2D
         29jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834756; x=1690426756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=651hNwclVHYOX/BiFQ2258R7Pq6s76Z2CiYetCzEGb4=;
        b=EfFTvLnV8PltVCGT/I7ej1pW59pnbP5qfhw+rklOw2ntqP+ahHKEIY3FMfBTQcTOKp
         nhbcRwJMgjP3+L136QC/+hLg3sSLk/FXZemsGnR/S0YFmC7t8uMabbl74CWk+qp+YtTE
         YvtjEVMo8JSh30nMWaghh/xFsrGTEkLdwmlRDjdiwxIcP9W6SNTMF7Ue4TgisYHemPTm
         3RD8COVR2nLQvKAjUlKNTGhZ2rqlwlb3q7knhQBjC8mQCtQUrvVU5xmI3gmEqiWnk09I
         Ax+MQI+nF0VQRauDfF4mf3ri/wb8V+h79LiWIXPXuj33XSYdmS4T1H8kHFD2r7NZ4KnA
         gA8w==
X-Gm-Message-State: AC+VfDyF457ez460hRd2assN06wu53u8DCbe8abuUiJFw5CiK7/L38oj
        ugCq4aKYZDWNjO7BQBezan7l5eKpWnshmvF21lg=
X-Google-Smtp-Source: ACHHUZ4aYnmEExumhtkmRQ46NbURG2TOLErX1sNi8Ibi+w7v9uYR9pS2ygX2bnznLMZcphlSW2MYbw==
X-Received: by 2002:a05:6a00:1f95:b0:677:3439:874a with SMTP id bg21-20020a056a001f9500b006773439874amr5271946pfb.3.1687834756150;
        Mon, 26 Jun 2023 19:59:16 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f9-20020aa782c9000000b0066a31111cc5sm4417821pfn.152.2023.06.26.19.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 19:59:15 -0700 (PDT)
Message-ID: <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
Date:   Mon, 26 Jun 2023 20:59:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 8:05?PM, Kent Overstreet wrote:
> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
>> either:
> 
> It just popped for me on xfs, but it took half an hour or so of looping
> vs. 30 seconds on bcachefs.

OK, I'll try and leave it running overnight and see if I can get it to
trigger.

>> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest/generic/388
>> realpath: /home/axboe/git/ktest/tests/bcachefs/xfstests.ktest/generic/388: Not a directory
>> Error 1 at /home/axboe/git/ktest/build-test-kernel 262 from: ktest_test=$(realpath "$1"), exiting
>>
>> and I suspect that should've been a space, but:
>>
>> ~/git/ktest/build-test-kernel run -ILP ~/git/ktest/tests/bcachefs/xfstests.ktest generic/388
>> Running test xfstests.ktest on m1max at /home/axboe/git/linux-block
>> No tests found
>> TEST FAILED
> 
> doh, this is because we just changed it to pick up the list of tests
> from the test lists that fstests generated.
> 
> Go into ktest/tests/xfstests and run make and it'll work. (Doesn't
> matter if make fails due to missing libraries, it'll re-run make inside
> the VM where the dependencies will all be available).

OK, I'll try that as well.

BTW, ran into these too. Didn't do anything, it was just a mount and
umount trying to get the test going:

axboe@m1max-kvm ~/g/k/t/xfstests> sudo cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff000201a5e000 (size 1024):
  comm "bch-copygc/nvme", pid 11362, jiffies 4295015821 (age 6863.776s)
  hex dump (first 32 bytes):
    40 00 00 00 00 00 00 00 62 aa e8 ee 00 00 00 00  @.......b.......
    10 e0 a5 01 02 00 ff ff 10 e0 a5 01 02 00 ff ff  ................
  backtrace:
    [<000000002668da56>] slab_post_alloc_hook.isra.0+0xb4/0xbc
    [<000000006b0b510c>] __kmem_cache_alloc_node+0xd0/0x178
    [<00000000041cfdde>] __kmalloc_node+0xac/0xd4
    [<00000000e1556d66>] kvmalloc_node+0x54/0xe4
    [<00000000df620afb>] bucket_table_alloc.isra.0+0x44/0x120
    [<000000005d44ce16>] rhashtable_init+0x148/0x1ac
    [<00000000fdca7475>] bch2_copygc_thread+0x50/0x2e4
    [<00000000ea76e08f>] kthread+0xc4/0xd4
    [<0000000068107ad6>] ret_from_fork+0x10/0x20
unreferenced object 0xffff000200eed800 (size 1024):
  comm "bch-copygc/nvme", pid 13934, jiffies 4295086192 (age 6582.296s)
  hex dump (first 32 bytes):
    40 00 00 00 00 00 00 00 e8 a5 2a bb 00 00 00 00  @.........*.....
    10 d8 ee 00 02 00 ff ff 10 d8 ee 00 02 00 ff ff  ................
  backtrace:
    [<000000002668da56>] slab_post_alloc_hook.isra.0+0xb4/0xbc
    [<000000006b0b510c>] __kmem_cache_alloc_node+0xd0/0x178
    [<00000000041cfdde>] __kmalloc_node+0xac/0xd4
    [<00000000e1556d66>] kvmalloc_node+0x54/0xe4
    [<00000000df620afb>] bucket_table_alloc.isra.0+0x44/0x120
    [<000000005d44ce16>] rhashtable_init+0x148/0x1ac
    [<00000000fdca7475>] bch2_copygc_thread+0x50/0x2e4
    [<00000000ea76e08f>] kthread+0xc4/0xd4
    [<0000000068107ad6>] ret_from_fork+0x10/0x20


-- 
Jens Axboe

