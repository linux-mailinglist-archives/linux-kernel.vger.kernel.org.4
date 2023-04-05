Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD566D77B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjDEJFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDEJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:05:37 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F53171A;
        Wed,  5 Apr 2023 02:05:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 20so36615016lju.0;
        Wed, 05 Apr 2023 02:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680685534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9y5P4/XPzhY5HNIcg2ZV9bZxBWcJJ9qyhMDWI2CB0Q=;
        b=SBzmHtUVK3dOnxf4k4YoSleqPGACxvG+7TTYN8at/0/KkGRVIYYV4uOyH40zk9Uzr0
         DHSnUnkOZkG6KLqrYZ8boB6NSraio5Mz6jjoYMgit4kppHFw2Xyp4jbmItS080Yz+ewj
         3nkA919Fiy/Gd6LOIVxX8/8QFpx4mJ32bgDzHg7S7OnN4zW9Ka+ULIfFSt8PHgVDK89S
         XfVCFajXblbnfee43AFzrnYTBl4lKb+xPlkxNqDXMahILPuYrHXd2VyN7DNAAszSatWT
         uxp6UXZs6CCr4Omm45f/o1CoL/nIwLi3L52A35+RNk2Wl+OybSovuCTt0jS+/0fVv+zK
         EoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680685534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9y5P4/XPzhY5HNIcg2ZV9bZxBWcJJ9qyhMDWI2CB0Q=;
        b=1pJk0vuuKq2vzsexpzyRjHWuboYVEzyMgidyjBv6P+w4+DtjahoBOua50LBIqc2Bsx
         AV1MbE1DfOprVlfNCUCuAGqGIQukm7iEDjgNSH6B7+p/W00kVtFX0c33oIDyU4HKA59m
         bXZ/+urkuszIP4PN3BZRcNgODBte6Xkjcnhi2LvG7N7Ao84NhM69q3UNHjM6MbC8zyfK
         bZkeR8m9+mrC5+VEmqXjPXkMH/MvKHySQu3J9QJ1llpKhAvMxOhwV1TDJwGX1x8jDjLO
         Y5TOn/+HMrL5P9+7gC9lI563dN0YaRTINrDqAvyOaqvafkKOez/jN7eb8D4E5sY2UWp1
         LYWQ==
X-Gm-Message-State: AAQBX9dkhF7F8zIlYP8UhMZ1HOR9Wv8FjHICJr/Rp5ap2Adskvdr4xc9
        U+9QeLXBcjEO+Y9fSQf/rcY=
X-Google-Smtp-Source: AKy350bvUFfeFo5yhEWKTR03FTd/KqL2qooNeo2CrD1I1YgYQxUnHz5fRREFzx7buKqi9qtR5m/JpA==
X-Received: by 2002:a2e:9c57:0:b0:29b:d29d:c781 with SMTP id t23-20020a2e9c57000000b0029bd29dc781mr1632916ljj.19.1680685533783;
        Wed, 05 Apr 2023 02:05:33 -0700 (PDT)
Received: from pc636 (host-90-233-209-177.mobileonline.telia.com. [90.233.209.177])
        by smtp.gmail.com with ESMTPSA id l22-20020a2e8356000000b0029352fc39fbsm2670123ljh.63.2023.04.05.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 02:05:33 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Apr 2023 11:05:30 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        =?utf-8?B?5Luj5a2Q5Li6IChaaXdlaSBEYWkp?= <Ziwei.Dai@unisoc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?546L5Y+MIChTaHVhbmcgV2FuZyk=?= <shuang.wang@unisoc.com>,
        =?utf-8?B?6L6b5L6d5YehIChZaWZhbiBYaW4p?= <Yifan.Xin@unisoc.com>,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        =?utf-8?B?6Zer5a2m5paHIChYdWV3ZW4gWWFuKQ==?= 
        <Xuewen.Yan@unisoc.com>,
        =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= 
        <Zhiguo.Niu@unisoc.com>,
        =?utf-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
Subject: Re: Re: [PATCH V2] rcu: Make sure new krcp free business is handled
 after the wanted rcu grace period.
Message-ID: <ZC052slSRxsVnFXa@pc636>
References: <10f5eb13d7c741c2a0e83ff1d788f398@BJMBX01.spreadtrum.com>
 <c0d8b802-8931-44d9-8a04-6265dade23a2@paulmck-laptop>
 <ZCx7cwzJzGMEpImn@pc636>
 <85a951d2-8991-468e-94bc-7254773227fe@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a951d2-8991-468e-94bc-7254773227fe@paulmck-laptop>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:08:50PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 04, 2023 at 09:33:07PM +0200, Uladzislau Rezki wrote:
> > > > > My concern is that running the channels separately might mean more grace
> > > > > periods (and thus more energy draw) on nearly idle devices, such devices
> > > > > usually being the ones for which energy efficiency matters most.
> > > > > 
> > > > > But perhaps Vlad, Neeraj, or Joel has some insight on this, given
> > > > > that they are the ones working on battery-powered devices.
> > > > > 
> > > > > > > Either way, this fixes only one bug of two.  The second bug is in the
> > > > > > > kfree_rcu() tests, which should have caught this bug.  Thoughts on a good fix
> > > > > > > for those tests?
> > > > > >
> > > > > > I inserted a msleep() between "rcu_read_lock(), get pointer via rcu_dereference()"
> > > > > > and "reference pointer, using the member", at the rcu scenario, then we can
> > > > > > reproduce this issue very soon in stress test. Can kfree_rcu() tests insert msleep()?
> > > > > 
> > > > > Another approach is to separate concerns, so that readers interact with
> > > > > grace periods in the rcutorture.c tests, and to add the interaction
> > > > > of to-be-freed memory with grace periods in the rcuscale kvfree tests.
> > > > > I took a step in this direction with this commit on the -rcu tree's
> > > > > "dev" branch:
> > > > > 
> > > > > efbe7927f479 ("rcu/kvfree: Add debug to check grace periods")
> > > > > 
> > > > > Given this, might it be possible to make rcuscale.c's kfree_rcu()
> > > > > testing create patterns of usage of the three channels so as to
> > > > > catch this bug that way?
> > > > > 
> > > > 
> > > > I can try it on my k5.15 device, and need some time.
> > > > I have a question. Do you mean add code in tree.c to create pattern
> > > > while channel data is being freed?
> > > > If so, both rcuscales.c and tree.c need to be modified for the test case.
> > > 
> > > My thought is to run the test on a system where very little else is
> > > happening, and then creating the temporal pattern only in rcuscale.c.
> > > One way would be to modify kfree_scale_thread(), perhaps using an
> > > additional module parameter using torture_param().
> > > 
> > > But just out of curiosity, what changes were you thinking of making
> > > in tree.c?
> > > 
> > OK. I can reproduce it on latest rcu-dev:
> > 
> > <snip>
> > [   75.302795] ------------[ cut here ]------------
> > [   75.302801] WARNING: CPU: 50 PID: 721 at kernel/rcu/tree.c:3043 kfree_rcu_work+0x157/0x1a0
> > [   75.302808] Modules linked in: test_vmalloc(E+) bochs(E) drm_vram_helper(E) snd_pcm(E) drm_ttm_helper(E) ppdev(E) snd_timer(E) joydev(E) ttm(E) drm_kms_helper(E) snd(E) parport_pc(E) soundcore(E) evdev(E) pcspkr(E) sg(E) serio_raw(E) parport(E) drm(E) qemu_fw_cfg(E) button(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc64_rocksoft(E) crc64(E) crc_t10dif(E) crct10dif_generic(E) sr_mod(E) cdrom(E) crct10dif_common(E) ata_generic(E) ata_piix(E) libata(E) scsi_mod(E) psmouse(E) e1000(E) scsi_common(E) i2c_piix4(E) floppy(E)
> > [   75.302865] CPU: 50 PID: 721 Comm: kworker/50:1 Kdump: loaded Tainted: G            E      6.3.0-rc1+ #58
> > [   75.302868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
> > [   75.302870] Workqueue: events kfree_rcu_work
> > [   75.302905] RIP: 0010:kfree_rcu_work+0x157/0x1a0
> > [   75.302907] Code: 8b 05 75 f9 37 01 4c 29 e8 48 83 f8 f8 76 40 48 8b 4c 24 08 48 83 f9 01 74 35 48 8b 05 ca b4 44 01 48 29 c8 48 83 f8 f8 76 25 <0f> 0b 48 8b 44 24 38 65 48 2b 04 25 28 00 00 00 75 23 48 83 c4 40
> > [   75.302910] RSP: 0018:ffffbd4642d8bde8 EFLAGS: 00010202
> > [   75.302913] RAX: fffffffffffffffc RBX: ffff9f693d5dd140 RCX: 000000000000003c
> > [   75.302914] RDX: 0000000000000002 RSI: ffffbd4642d8be08 RDI: ffff9f5a4d608000
> > [   75.302916] RBP: ffffbd4642d8be08 R08: 0000001188654ff5 R09: 0000000000000000
> > [   75.302918] R10: 0000000000000001 R11: 0000000000000001 R12: ffffbd46812d7000
> > [   75.302919] R13: 0000000000000260 R14: ffffbd4642d8bdf8 R15: ffff9f5a47637000
> > [   75.302922] FS:  0000000000000000(0000) GS:ffff9f693e200000(0000) knlGS:0000000000000000
> > [   75.302924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   75.302926] CR2: 0000562dfe4307d0 CR3: 000000054ba26000 CR4: 00000000000006e0
> > [   75.302930] Call Trace:
> > [   75.302937]  <TASK>
> > [   75.302942]  ? lock_acquire+0xc8/0x1a0
> > [   75.302949]  process_one_work+0x29d/0x560
> > [   75.302957]  ? __pfx_worker_thread+0x10/0x10
> > [   75.302960]  worker_thread+0x52/0x3a0
> > [   75.302964]  ? __pfx_worker_thread+0x10/0x10
> > [   75.302967]  kthread+0xe7/0x110
> > [   75.302970]  ? __pfx_kthread+0x10/0x10
> > [   75.302973]  ret_from_fork+0x2c/0x50
> > [   75.302984]  </TASK>
> > [   75.302986] ---[ end trace 0000000000000000 ]---
> > <snip>
> > 
> > This is with:
> > 
> > <snip>
> > commit 8f6414680a0d539ca0e7fde80556c71b7b3da88a (HEAD -> dev)
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Tue Apr 4 15:51:56 2023 +0200
> > 
> >     rcu/kvfree: Add debug check of GP ready for ptrs in a list
> > 
> > commit efbe7927f47958a6805da5560d9a5f469ba51e73 (origin/dev)
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Mon Apr 3 16:49:14 2023 -0700
> > 
> >     rcu/kvfree: Add debug to check grace periods
> > 
> > + below revert
> > 
> > commit 6b4fef6ec689b1dda9c63be77e9a81a52cc39dc1
> > Author: Ziwei Dai <ziwei.dai@unisoc.com>
> > Date:   Fri Mar 31 20:42:09 2023 +0800
> > 
> >     rcu/kvfree: Avoid freeing new kfree_rcu() memory after old grace period
> > <snip>
> > 
> > The test is "sudo ./test_vmalloc.sh run_test_mask=768 nr_threads=64&"
> > 
> > it runs single argument and double argument to free vmalloc ptrs.,
> > number of threads are 64:
> > 
> > without revert(with a patch that is in question), i am not able to
> > reproduce it anymore.
> 
> Very good!!!
> 
> This test does not fit very will into the rcutorture script framework,
> but might it be able to guide changes to rcuscale.c?
> 
Today i managed to reproduce it with "rcuscale". Same logic. We should
use both single + double in parallel quite heavily. So at least two
channels are started to be used. I can trigger if i apply flooding
of kfree_rcu().

<snip>
tools/testing/selftests/rcutorture/bin/kvm.sh --memory 10G --torture rcuscale \
    --allcpus --duration 1 \
      --kconfig CONFIG_NR_CPUS=64 \
      --kconfig CONFIG_RCU_NOCB_CPU=y \
      --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
      --kconfig CONFIG_RCU_LAZY=n \
      --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=64 \
      			 rcuscale.holdoff=20 rcuscale.kfree_alloc_num=1000000 \
      			 torture.disable_onoff_at_boot" --trust-make
<snip>

--
Uladzislau Rezki
