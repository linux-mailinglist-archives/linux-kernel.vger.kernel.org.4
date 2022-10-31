Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26C613494
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJaLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiJaLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:36:42 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FFEE0A4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:36:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e129so10437334pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk8T8KciNnKClZtt9a7oM7hEZLA8ALbiZujS1/Z8e40=;
        b=G53K5YU2JkveyKH2PbOn8K0UpNz0e894Cw6udPOu0c1h6+GqY5Pr/RdmUwR25EglGo
         dVr2iMlunxBMeCd7VlrfZ6FOqnpiIkFTAAWFBSl8Q4XAd+oQB/Dplv4mi0fUeni1/VSA
         f9bFtE4IRkYFEEa7yjr7imth2RhnTy3FvwawI9TSlIxH9uOrI94cDL04KBgGMBLIrtSv
         AVcKFyn++ITHCwWzIoHXrY5U4c8CXQGTnk6epkRhbjp5ss3lpRisch5j3fh8/oxJbzfE
         pNIuzd/lzEpSUpEqec7HqJAOVvTAs4uSf3lCBxm1oWnAucIg6xUZ64QAcLjrN52oe2NN
         ruRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk8T8KciNnKClZtt9a7oM7hEZLA8ALbiZujS1/Z8e40=;
        b=UFAyBOM5ByfemFo4XpURDWdchtPX3/gBMzA5fX7dEhO5Gwpwn6u1mSJlXIplSmM9eC
         Nrv61o0wbH0CNT0yKFx21mWEq3U2YR0fqK/yfS3k9yd5fLinZvHDlwVuuoxeQ+KBUlXu
         cUfSUwpx/94kS8wJwYXaXyBrPnbPTA+Ffq2BIjdFWuDq2rBMoCpFl2NHTLyOH15hHcRk
         u/+9IyNXPQT7NcvgkJ4ek17isJw1mBQK5g3+TinhiWWbWpRi0EjttPcTYV3VgRBKxhdM
         YMdbayxBdsz9MpMuCm3HKzND7hlrFJZuAIvP4746OiJPp1mwyGAXBjoSo56p98Zbbozr
         wYuQ==
X-Gm-Message-State: ACrzQf0CqAv9Gse9Kv98pkpvfrmba54kiRcHmbClpLBVjLOyKKeIvwSF
        /vyv/BRWq/b7uNIRBGimylM=
X-Google-Smtp-Source: AMsMyM4f8k2ljHcxbiskh8CAxXa8u4HJT5cN8F4TcPs0gPwUvckU0zmHtc1dUz4LmrD1ReEhoFGIeg==
X-Received: by 2002:a05:6a00:14cc:b0:56b:9969:823 with SMTP id w12-20020a056a0014cc00b0056b99690823mr13659260pfu.36.1667216201343;
        Mon, 31 Oct 2022 04:36:41 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id v17-20020aa799d1000000b0056bb191f176sm4526205pfi.14.2022.10.31.04.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 04:36:40 -0700 (PDT)
Date:   Mon, 31 Oct 2022 20:36:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     John Thomson <lists@johnthomson.fastmail.com.au>
Cc:     Feng Tang <feng.tang@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <Y1+zQShofiGTxcKG@hyeyoo>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-2-feng.tang@intel.com>
 <becf2ac3-2a90-4f3a-96d9-a70f67c66e4a@app.fastmail.com>
 <af2ba83d-c3f4-c6fb-794e-c2c7c0892c44@suse.cz>
 <Y180l6zUnNjdCoaE@feng-clx>
 <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4285caf-277c-45fd-8fc7-8a1d61685ce8@app.fastmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:05:58AM +0000, John Thomson wrote:
> On Mon, 31 Oct 2022, at 02:36, Feng Tang wrote:
> > Hi John,
> >
> > Thanks for the bisecting and reporting!
> >
> > On Mon, Oct 31, 2022 at 05:30:24AM +0800, Vlastimil Babka wrote:
> >> On 10/30/22 20:23, John Thomson wrote:
> >> > On Tue, 13 Sep 2022, at 06:54, Feng Tang wrote:
> >> >> kmalloc's API family is critical for mm, with one nature that it will
> >> >> round up the request size to a fixed one (mostly power of 2). Say
> >> >> when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> >> >> could be allocated, so in worst case, there is around 50% memory
> >> >> space waste.
> >> > 
> >> > 
> >> > I have a ralink mt7621 router running Openwrt, using the mips ZBOOT kernel, and appear to have bisected
> >> > a very-nearly-clean kernel v6.1rc-2 boot issue to this commit.
> >> > I have 3 commits atop 6.1-rc2: fix a ZBOOT compile error, use the Openwrt LZMA options,
> >> > and enable DEBUG_ZBOOT for my platform. I am compiling my kernel within the Openwrt build system.
> >> > No guarantees this is not due to something I am doing wrong, but any insight would be greatly appreciated.
> >> > 
> >> > 
> >> > On UART, No indication of the (once extracted) kernel booting:
> >> > 
> >> > transfer started ......................................... transfer ok, time=2.01s
> >> > setting up elf image... OK
> >> > jumping to kernel code
> >> > zimage at:     80BA4100 810D4720
> >> > Uncompressing Linux at load address 80001000
> >> > Copy device tree to address  80B96EE0
> >> > Now, booting the kernel...
> >> 
> >> It's weird that the commit would cause no output so early, SLUB code is 
> >> run only later.
> > 
> > I noticed your cmdline has console setting, could you enable the
> > earlyprintk in cmdline like "earlyprintk=ttyS0,115200" etc to see
> > if there is more message printed out.
> 
> Still nothing from vmlinux with earlykprint on UART unless revert.
> 
> >
> > Also I want to confirm this is a boot failure and not only a boot
> > message missing.
> 
> Yes, boot failure.
> Network comes up automatically on successful boot. Not happening when no kernel UART

It is really weird that I see no boot issue on my MIPS emulation with almost same
config, with different target - Malta board that QEMU supports. it just boot fine.

Can you attach debugger to the board?
(Which I hadn't tried. I had tried it only to QEMU)

[...]

> >> > 
> >> > 
> >> > possibly relevant config options:
> >> > grep -E '(SLUB|SLAB)' .config
> >> > # SLAB allocator options
> >> > # CONFIG_SLAB is not set
> >> > CONFIG_SLUB=y
> >> > CONFIG_SLAB_MERGE_DEFAULT=y
> >> > # CONFIG_SLAB_FREELIST_RANDOM is not set
> >> > # CONFIG_SLAB_FREELIST_HARDENED is not set
> >> > # CONFIG_SLUB_STATS is not set
> >> > CONFIG_SLUB_CPU_PARTIAL=y
> >> > # end of SLAB allocator options
> >> > # CONFIG_SLUB_DEBUG is not set
> >> 
> >> Also not having CONFIG_SLUB_DEBUG enabled means most of the code the 
> >> patch/commit touches is not even active.
> >> Could this be some miscompile or code layout change exposing some 
> >> different bug, hmm.
> 
> Yes, it could be.

What happens with clang?

> 
> >> Is it any different if you do enable CONFIG_SLUB_DEBUG ?
> 
> No change
> 
> >> Or change to CONFIG_SLAB? (that would be really weird if not)
> 
> This boots fine
> 
> > I haven't found any clue from the code either, and I compiled
> > kernel with the config above and tested booting on an Alder-lake
> > desktop and a QEMU, which boot fine.
> >
> > Could you provide the full kernel config and demsg (in compressed
> > format if you think it's too big), so we can check more?
> 
> Attached
> 
> > Thanks,
> > Feng
> 
> vmlinux is bigger, and entry point is larger (0x8074081c vs 0x807407dc revert vs 0x8073fcbc),
> so that may be it? Or not?
> revert + SLUB_DEBUG + SLUB_DEBUG_ON is bigger still, but does successfully boot.
> vmlinux entry point is 0x8074705c
> 
> 
> transfer started ......................................... transfer ok, time=2.01s
> setting up elf image... OK
> jumping to kernel code
> zimage at:     80BA4100 810D6FA0
> Uncompressing Linux at load address 80001000
> Copy device tree to address  80B9EEE0
> Now, booting the kernel...
> [    0.000000] Linux version 6.1.0-rc2 (john@john) (mipsel-openwrt-linux-musl-gc
> c (OpenWrt GCC 11.3.0 r19724+16-1521d5f453) 11.3.0, GNU ld (GNU Binutils) 2.37) 
> #0 SMP Fri Oct 28 03:48:10 2022
> 
> 
>  I will keep looking.
> 
> Thank you,
> -- 
>   John Thomson



-- 
Thanks,
Hyeonggon
