Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7774617AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKCKND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKCKNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:13:00 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4310F;
        Thu,  3 Nov 2022 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667470379; x=1699006379;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=KQ5MZxmzMqipMNv3LipYIyEv8lFKRPZyn9ap+tlMmH8=;
  b=GRwW1sP2xukiObUGYg0ULrg1CnFalpNExoLCxtsJNo54iEjzSdmV6Poc
   2dfTpmQgOxwiV5DDKnO0DckAyRQFQNGrWMUMUryTWuemIwABZxx7Ei80h
   eRNVCv04sOIY6gC0b56fbvWZ0Dd8WDGtVWpiCPSFw/8iFV4lx1jd4Q64H
   65rQuaXCFdUQmL/R0kNF0JRMB/Hnxd4UpGLvU2DFcdkHIpc29L1urGCpn
   zLMud9xF+cAd+adELugNTXug6m6ogTurqPirI2zipF3w4bT9p7TFY2OpG
   cbBDMsYL4ckV5IJlJeSKiEYFSdNAEUjimAqLgtgFtFftPafgWLV9ehu8w
   A==;
X-IronPort-AV: E=Sophos;i="5.95,235,1661788800"; 
   d="scan'208";a="220544914"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2022 18:12:58 +0800
IronPort-SDR: Xw0G43gBpyR8BKiUAPqAZfXrNwaiLWS6IHXL99+BiENo54ee5Q6UjQYbGO08Sz8P3r9VSjrAlA
 zBmf7+m/OpC8r6jH5mBiBnvNgrH+EE0FezfPXPQFMYjoIazb1Jv+ODO3sr3LA9L0lr9WRSQmC8
 6ikO7wr3MvNIwk6/SEpJHrR5gSE9PcMKm5Q6biOUTC/Ahag5vc2/q4KDnwNR0ToDfI8CVz6Hkl
 QbqriPnazHFpRjYEtbNJf7V9Pe0rLyzwnQD9a35xDrIanEEsSOtGvI25wxXz+oqreNJLXlRcWs
 YWw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 02:26:26 -0700
IronPort-SDR: CRgbyRFKkYNc5Hf/NNABsDUDm9hBPHBMdvH9y3tjpTGOC2R4SbVuUX2z1x2wUAidd5Q+XsowoR
 kcyU1OtOx4InTVT5r5S4P9wV7rSYsknkv/ASc2a9eWBheN0xhEMVUwZbTA538dzNmo/A51FSJp
 4Fsk0Liw1ZNwmjnde72aXUfE+c24jr6Tnv1QYSUDw4k0egXMORxbl/gamsfsS4Tn9h9wLT1EHD
 XXWbCUrvm/87nizd5r9T4DjQBRX/agEj4Icip+jt3GEVfadASfnjhwTizp0EfFKpRhPB86CJvZ
 TwI=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2022 03:12:57 -0700
References: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Dennis Dai <dzy.0424thu@gmail.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rust nvme driver: potential sleep-in-atomic-context
Date:   Thu, 03 Nov 2022 10:57:16 +0100
In-reply-to: <CACMswuMVERF_+R3Qxb0xGHCBQUCuxtBLA+eDo__Coed3BoVC3A@mail.gmail.com>
Message-ID: <87r0ykny6w.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dennis,

Dennis Dai <dzy.0424thu@gmail.com> writes:

> The rust nvme driver [1] (which is still pending to be merged into
> mainline [2]) has a potential sleep-in-atomic-context bug.
>
> The potential buggy code is below
>
>     // drivers/block/nvme.rs:192
>     dev.queues.lock().io.try_reserve(nr_io_queues as _)?;
>     // drivers/block/nvme.rs:227
>     dev.queues.lock().io.try_push(io_queue.clone())?;
>
> The queues field is wrapped in SpinLock, which means that we cannot
> sleep (or indirectly call any function that may sleep) when the lock
> is held.
> However try_reserve function may indirectly call krealloc with a
> sleepable flag GFP_KERNEL (that's default behaviour of the global rust
> allocator).
> The the case is similar for try_push.
>
> I wonder if the bug could be confirmed.

Nice catch, I was not aware of that one. I will add a TODO. Did you
manage to trigger this bug or did you find it by review?

I am not sure if it has been decided how to pass flags to allocations
yet. There is a discussion about the interface for Box here [1] and
there is also some discussion on the list [2]. For reference, I use an
atomic box allocation here [3].

The NVMe driver is very much a prototype and I expect there are many
bugs like this still in it. So while I am not surprised, really I
appreciate the report :)

[1] https://github.com/Rust-for-Linux/linux/pull/815
[2] https://lore.kernel.org/rust-for-linux/Yyr5pKpjib%2Fyqk5e@kroah.com/T/#mb55cf54067002d503ca63c5ad0688d55c6184cca
[3] https://github.com/metaspace/rust-linux/blob/nvme/drivers/block/nvme_mq.rs#L261

Best regards,
Andreas Hindborg
