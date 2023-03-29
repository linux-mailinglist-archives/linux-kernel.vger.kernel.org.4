Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8D6CD83E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjC2LQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjC2LQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:16:16 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5451C40C4;
        Wed, 29 Mar 2023 04:16:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 92C1532007BE;
        Wed, 29 Mar 2023 07:16:11 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Wed, 29 Mar 2023 07:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1680088571; x=1680174971; bh=EgJegEsODD
        1iHmXtfNr/Zui5mid78ECp1tcuebLe5MY=; b=aLLP0sO0B2Fm5X9DzOBQJ1YY27
        jCEYtWdPoDC7yW7oHhQm9k07/k/IkUuBgjJblUCRD3LmMWQlzsGE1hAq5cpKcZAS
        vm/vwUg99Rtvq1q/mKC5edlcVjtqks29tOeW2kxJM7VUTmWKlu2IzSYEWighJDmO
        Y/QpebIL9J7F8P5daREGwrwslMgg9KKEbX1NrbGgOoBg9aOWSBnAGEvZIPn+wQ9z
        DdI2Zkbw50/2MaDuuAUhBKMVR9RZg36wf+v8spbAc0UtqP3pxlKIEoMQcZKkNeai
        B5YyKn8c4hgX1HtTYjaB2opXLOk7XQVWbks6DPsAZsFCAzgpCYxFaLAig7SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680088571; x=1680174971; bh=EgJegEsODD1iHmXtfNr/Zui5mid78ECp1tc
        uebLe5MY=; b=uffdnpnPDByb3kl4Wv6aIyHQddxA1WdzwNzJgD0gKhdR4CoRqyG
        8QgWk9lKNxkJhctskxPMfpMj5/ukN2lyttiEW3QqqW+nQARsQNfsqUnBVOgVJOol
        QPVs/u9dG12MMLo5EwSNHPMG/phSIY0eflunYZPWfddBfawnLBU8O7WeNS29sOE3
        xX65ghEPqiR4uOOFLDXsukY3Qn4aNuCKojfepPpITX7GtokUnwrE1gQgOWf48uVt
        vjzrDqf1X8zf81mJXhPcUHtrBlosD34Z71Ol9zsmfQPWoE9zrJYNyEZJ4pcvtuss
        ADEGO/Q/S3nOg5/FeF1fmJQPDnYTf1Nkytw==
X-ME-Sender: <xms:-h0kZKXBrY-RQOYYcQsk4vIsHrwWPBE25nWvvfT5BL1eYWZuAz_iaw>
    <xme:-h0kZGnNByuAQdUecu12R_Ig46A39Dowq2kCacgDTK1Vlm3D-WCRLcPzCU8scwMM1
    Fo0QjHcGcLHCT8-aiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvvefutgesthdtre
    dtreertdenucfhrhhomheptehlihhsthgrihhruceorghlihhsthgrihhrsegrlhhishht
    rghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeefffelhfejhfevteelheffueduje
    eutdfhieegleehffeigefhfefgjeevfeetgeenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:-h0kZOYjC7dvoQlLAzAjyBgkBX9SAImfA39WEFgnPYK_D1lSrUAI5Q>
    <xmx:-h0kZBVZ6sLkOMry5DeeDSFBvV-fxUEL0koQjLQVKvBPhVb9lvKU5A>
    <xmx:-h0kZEmQcBtbWadRgkMnTgcTBLo7X8AYkxBzZc66KgC2ga7MTrbzVQ>
    <xmx:-x0kZDuOa8VinHerTnXZGpGWO_ijKt2t0x2ptBB7a8ml_0z4hiBGVw>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 915E42D40090; Wed, 29 Mar 2023 07:16:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-237-g62623e8e3f-fm-20230327.001-g62623e8e
Mime-Version: 1.0
Message-Id: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
Date:   Wed, 29 Mar 2023 21:15:50 +1000
From:   Alistair <alistair@alistair23.me>
To:     ye.xingchen@zte.com.cn, sebastian.reichel@collabora.com,
        linus.walleij@linaro.org, sre@kernel.org
Cc:     pali@kernel.org, sravanhome@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: power_supply_show_property Kernel Oops
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I am working on mainlining support for the reMarkable2 eInk tablet.

I haven an out of tree max77818 power controller [1], [2] and [3] that I
haven't upstreamed yet, but am using on top of the mainline kernel.

My driver worked with the 6.2 kernel [4], but since rebasing to the 6.3-rc4
kernel [5] I see this kernel oops:

```
[    2.107861] 8<--- cut here ---
[    2.110964] Unable to handle kernel paging request at virtual address 002080a2 when read
[    2.119064] [002080a2] *pgd=00000000
[    2.122675] Internal error: Oops: 5 [#1] SMP ARM
[    2.127302] Modules linked in:
[    2.130369] CPU: 1 PID: 49 Comm: kworker/1:2 Not tainted 6.3.0-rc4-00043-ga28b4b2f86cb-dirty #6
[    2.139079] Hardware name: Freescale i.MX7 Dual (Device Tree)
[    2.144832] Workqueue: events power_supply_changed_work
[    2.150081] PC is at string+0x80/0x158
[    2.153847] LR is at 0xc2826fff
[    2.156996] pc : [<c0da9314>]    lr : [<c2826fff>]    psr: a0000013
[    2.163270] sp : f0dadd98  ip : c2827000  fp : f0dadddc
[    2.168501] r10: c2827000  r9 : c2828000  r8 : c10ec1da
[    2.173733] r7 : f0dade34  r6 : 00000002  r5 : f0dadd98  r4 : f0daddb0
[    2.180268] r3 : 002080a2  r2 : c2828000  r1 : 00000000  r0 : c2827000
[    2.186803] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    2.193949] Control: 10c5387d  Table: 8000406a  DAC: 00000051
[    2.199699] Register r0 information: non-slab/vmalloc memory
[    2.205371] Register r1 information: NULL pointer
[    2.210084] Register r2 information: non-slab/vmalloc memory
[    2.215753] Register r3 information: non-paged memory
[    2.220814] Register r4 information: 2-page vmalloc region starting at 0xf0dac000 allocated at kernel_
clone+0xa4/0x360
[    2.231542] Register r5 information: 2-page vmalloc region starting at 0xf0dac000 allocated at kernel_
clone+0xa4/0x360
[    2.242265] Register r6 information: non-paged memory
[    2.247326] Register r7 information: 2-page vmalloc region starting at 0xf0dac000 allocated at kernel_
clone+0xa4/0x360
[    2.258048] Register r8 information: non-slab/vmalloc memory
[    2.263718] Register r9 information: non-slab/vmalloc memory
[    2.269387] Register r10 information: non-slab/vmalloc memory
[    2.275144] Register r11 information: 2-page vmalloc region starting at 0xf0dac000 allocated at kernel_clone+0xa4/0x360
[    2.285953] Register r12 information: non-slab/vmalloc memory
[    2.291709] Process kworker/1:2 (pid: 49, stack limit = 0xf6b02a82)
[    2.297990] Stack: (0xf0dadd98 to 0xf0dae000)
[    2.302356] dd80:                                                       ffffff04 ffff0a00
[    2.310546] dda0: f0daddf0 c07b982c ffffff04 ffff0a00 f0dade34 c10ec1d8 c2827000 c0dac10c
[    2.318735] ddc0: c254b420 ffffff04 ffff0a00 000000b7 f0daddf0 00001000 0000120c ffffff04
[    2.326924] dde0: ffff0a00 dbe877b2 f0dade38 00001000 00000000 c254b420 c15262e0 0000120c
[    2.335113] de00: c2827000 c254b400 c11145cc c0dac3e8 0000004d c03363ec 00000001 dbe877b2
[    2.343302] de20: f0dade30 dbe877b2 c09ca444 c10ec1d8 002080a2 00000000 00000000 dbe877b2
[    2.351491] de40: ffffff04 0000004d c2827000 c2181000 000004d0 c15250b0 c2827000 c0ea7d94
[    2.359680] de60: c11145cc c09ca5f8 00000000 00000006 c254b420 c2181000 c254b400 c2827000
[    2.367869] de80: c0ea7d94 c09ca7d8 c254b420 c2181000 00000000 c10f3358 00000002 00000000
[    2.376058] dea0: c0ea7d94 c07986e0 00000000 c0ea7d94 c11145cc c0d8f7e8 f0daded0 dbe877b2
[    2.384247] dec0: c254b420 dbe877b2 c0d8fdf0 c254b420 c2181000 c0d8fe5c c09c88d4 dbe877b2
[    2.392435] dee0: c254b420 c2822f00 c254b400 00000000 c254b634 c254b5f8 00000000 c254b634
[    2.400624] df00: c254b400 c254b420 c15a2fa4 00000040 ef7d4880 c09c8af0 c254b5f8 c27f1e00
[    2.408813] df20: ef7d4880 ef7d7c00 00000000 ef7d7c05 00000040 c013ddb8 c1403d40 c2321100
[    2.417002] df40: c27f1e00 ef7d4880 ef7d489c c1403d40 c2321100 c27f1e18 00000008 c013ea40
[    2.425191] df60: c27f1e00 c2620340 f08f1eb8 c27f3880 c2321100 c013ea14 c27f1e00 c2620340
[    2.433380] df80: f08f1eb8 00000000 00000000 c0146218 c27f3880 c014614c 00000000 00000000
[    2.441568] dfa0: 00000000 00000000 00000000 c0100170 00000000 00000000 00000000 00000000
[    2.449756] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.457943] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    2.466136]  string from vsnprintf+0x158/0x424
[    2.470603]  vsnprintf from vscnprintf+0x10/0x24
[    2.475241]  vscnprintf from sysfs_emit+0x50/0xac
[    2.479975]  sysfs_emit from power_supply_show_property+0x1d0/0x26c
[    2.486269]  power_supply_show_property from add_prop_uevent+0x30/0x8c
[    2.492815]  add_prop_uevent from power_supply_uevent+0xb4/0xe4
[    2.498753]  power_supply_uevent from dev_uevent+0xc4/0x21c
[    2.504352]  dev_uevent from kobject_uevent_env+0x1cc/0x510
[    2.509953]  kobject_uevent_env from power_supply_changed_work+0x7c/0xb4
[    2.516675]  power_supply_changed_work from process_one_work+0x1e8/0x3e8
[    2.523396]  process_one_work from worker_thread+0x2c/0x504
[    2.528986]  worker_thread from kthread+0xcc/0xec
[    2.533716]  kthread from ret_from_fork+0x14/0x24
[    2.538443] Exception stack(0xf0dadfb0 to 0xf0dadff8)
[    2.543505] dfa0:                                     00000000 00000000 00000000 00000000
[    2.551692] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.559879] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.566507] Code: e2800001 e150000e e2811001 0a000002 (e4d3c001)
[    2.572682] ---[ end trace 0000000000000000 ]---
```

As it's on a consumer device I don't have a way to connect a debugger. So I'm
a little stuck on what the problem is. The only related change I see between
6.2 and 6.3-rc4 is commit a441f3b90a340e5c94df36c33fb7000193ee0aa7
"power: supply: use sysfs_emit() instead of sprintf() for sysfs show()", but
that doesn't look like it would cause this oops.

I would really appreciate any help or ideas on what the issue might be or how
I could fix it

1: https://github.com/alistair23/linux/commit/5f1579e12c35d75529328e84d78b36ac11da8cd4
2: https://github.com/alistair23/linux/commit/c6383382278c5e594bb889f62dab853da8b73532
3: https://github.com/alistair23/linux/commit/5d8f2d3a08b8604a0ca5282f2b0aea9ebe7ee5fa
4: https://github.com/alistair23/linux/tree/rM2-6.2
5: https://github.com/alistair23/linux/tree/rM2-mainline

Alistair
