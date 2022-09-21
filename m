Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EEE5BF7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIUHas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIUHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:30:45 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C87644F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:30:44 -0700 (PDT)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by gw.atmark-techno.com (Postfix) with ESMTPS id C11B9600E1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:30:42 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id n18-20020a056a000d5200b0053e16046751so3096463pfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=d/9r2HRGkHewxskRelSy8RAGjwIqCd1bVPDTOTNKeW0=;
        b=WXn7wrsDcLdAfj3Cmii8vGQA7xnOad/371tlTrSyrGoxiDoQgxyTkqCZkWQ6fXlYp6
         YUubQrq0k9xHoXhXfDEg9Qzy04VmKuIp84jmCU/XLPTM0VBKr1S+4FKkaa/viERcclMy
         B8oIF+uCrVS5C8w4IKB5VVXci5Ihod2h4aNid6UfJyRxRtnhRPgq/silSzXcZ5TPEdLb
         5FWLeNywTT/JjoTjCUyHp9T1ABEzqYewWB3uyYahy43C7HFK42GhUzAaBiccfme50i90
         2BNPZSlRKg21YpwBLwr+Ks2531Cg8po2O4sjmdlZpLXTgXxHq+m46AiMcpbEoQp599s0
         3R7A==
X-Gm-Message-State: ACrzQf27yncEhweCSuO7gDNIK8UlAoX3cZw6O7MSv+GEfM9k4lpd8Xn2
        t/IMgdrZlnkLB0PmBvM+537+0ym/MCC/xypzfs3xmxtuHXPXwBATITMfCFzPhMCkXP0+64vKMsN
        T36gruGCMnIf4zNsDwxzLmRv4btIT
X-Received: by 2002:a17:90b:1d0e:b0:202:809c:2d70 with SMTP id on14-20020a17090b1d0e00b00202809c2d70mr7914746pjb.14.1663745441796;
        Wed, 21 Sep 2022 00:30:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FQgLj2yNSd9il7Tzy7KZrR0PQ+ABSmLfUo30ZNoFp2FIsvHQz34HhZNqsT2/8TNoT6Hn1sQ==
X-Received: by 2002:a17:90b:1d0e:b0:202:809c:2d70 with SMTP id on14-20020a17090b1d0e00b00202809c2d70mr7914730pjb.14.1663745441551;
        Wed, 21 Sep 2022 00:30:41 -0700 (PDT)
Received: from pc-zest.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 14-20020a630b0e000000b00438ce2800e5sm1211848pgl.7.2022.09.21.00.30.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:30:41 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1oauBr-00DO50-16;
        Wed, 21 Sep 2022 16:30:39 +0900
Date:   Wed, 21 Sep 2022 16:30:29 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org, Yu Kuai <yukuai3@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Message-ID: <Yyq9lfH3AP8I/pwd@atmark-techno.com>
References: <YuwUw2JLKtIa9X+S@localhost.localdomain>
 <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
 <YuzI7Tqi3n+d+V+P@atmark-techno.com>
 <20220805095407.GA1876904@falcondesktop>
 <20220901132512.GA3946576@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220901132512.GA3946576@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filipe Manana wrote on Thu, Sep 01, 2022 at 02:25:12PM +0100:
> It took me a bit more than I expected, but here is the patchset to make fiemap
> (and lseek) much more efficient on btrfs:
> 
> https://lore.kernel.org/linux-btrfs/cover.1662022922.git.fdmanana@suse.com/
> 
> And also available in this git branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=lseek_fiemap_scalability

Thanks a lot!
Sorry for the slow reply, it took me a while to find time to get back to
my test setup.

There's still this weird behaviour that later calls to cp are slower
than the first, but the improvement is so good that it doesn't matter
quite as much -- I haven't been able to reproduce the rcu stalls in qemu
so I can't say for sure but they probably won't be a problem anymore.

From a quick look with perf record/report the difference still seems to
stem from fiemap (time spent there goes from 4.13 to 45.20%), so there
is still more processing once the file is (at least partially) in cache,
but it has gotten much better.


(tests run on a laptop so assume some inconsistency with thermal
throttling etc)

/mnt/t/t # compsize bigfile
Processed 1 file, 194955 regular extents (199583 refs), 0 inline.
Type       Perc     Disk Usage   Uncompressed Referenced  
TOTAL       15%      3.7G          23G          23G       
none       100%      477M         477M         514M       
zstd        14%      3.2G          23G          23G       
/mnt/t/t # time cp bigfile /dev/null
real	0m 44.52s
user	0m 0.49s
sys	0m 32.91s
/mnt/t/t # time cp bigfile /dev/null
real	0m 46.81s
user	0m 0.55s
sys	0m 35.63s
/mnt/t/t # time cp bigfile /dev/null
real	1m 13.63s
user	0m 0.55s
sys	1m 1.89s
/mnt/t/t # time cp bigfile /dev/null
real	1m 13.44s
user	0m 0.53s
sys	1m 2.08s


For comparison here's how it was on 6.0-rc2 your branch is based on:
/mnt/t/t # time cp atde-test /dev/null
real	0m 46.17s
user	0m 0.60s
sys	0m 33.21s
/mnt/t/t # time cp atde-test /dev/null
real	5m 35.92s
user	0m 0.57s
sys	5m 24.20s



If you're curious the report blames set_extent_bit and
clear_state_bit as follow; get_extent_skip_holes is completely gone; but
I wouldn't necessarily say this needs much more time spent on it.

45.20%--extent_fiemap
|
|--31.02%--lock_extent_bits
|          |          
|           --30.78%--set_extent_bit
|                     |          
|                     |--6.93%--insert_state
|                     |          |          
|                     |           --0.70%--set_state_bits
|                     |          
|                     |--4.25%--alloc_extent_state
|                     |          |          
|                     |           --3.86%--kmem_cache_alloc
|                     |          
|                     |--2.77%--_raw_spin_lock
|                     |          |          
|                     |           --1.23%--preempt_count_add
|                     |          
|                     |--2.48%--rb_next
|                     |          
|                     |--1.13%--_raw_spin_unlock
|                     |          |          
|                     |           --0.55%--preempt_count_sub
|                     |          
|                      --0.92%--set_state_bits
|          
 --13.80%--__clear_extent_bit
           |          
            --13.30%--clear_state_bit
                      |          
                      |           --3.48%--_raw_spin_unlock_irqrestore
                      |          
                      |--2.45%--merge_state.part.0
                      |          |          
                      |           --1.57%--rb_next
                      |          
                      |--2.14%--__slab_free
                      |          |          
                      |           --1.26%--cmpxchg_double_slab.constprop.0.isra.0
                      |          
                      |--0.74%--free_extent_state
                      |          
                      |--0.70%--kmem_cache_free
                      |          
                      |--0.69%--btrfs_clear_delalloc_extent
                      |          
                       --0.52%--rb_next



Thanks!
-- 
Dominique
