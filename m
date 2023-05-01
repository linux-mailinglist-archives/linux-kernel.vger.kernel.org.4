Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157E6F3194
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjEANke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjEANkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:40:32 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241AA2
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:40:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 74B7F32008FC;
        Mon,  1 May 2023 09:40:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 May 2023 09:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682948424; x=1683034824; bh=mgmJtCjaxq0+a
        63USa1qAsiAk/liNTedyXWkBUVmjxc=; b=V9yduIYORVjgobwgyPvBiHLe93Tj/
        zJWdkzJnsCBmpPC2JwGQjex96x3x9G1mz4U6ehdjBfpmiXx1MzJ4kajIRCiFGrQJ
        C4vlEpKcAgCeRfWb4C/Po2neMYPGQcQBJD1RzeuCtiu4u7WKDeQ1aoXsk/XtC0HX
        UzbHObiykZ+kiL8picprDSWfyPKqBD/unpNGS4WlAiFmuYvIiXjHDINkp191TkVj
        P49Kk9rsregmTSGGVAVDvV46Qqu2BKXTuK5yPtGvRTe6FvnynbPuEQg4F5ApXUIw
        PfEj/Z1T1rtoBDck6UgQaUqwXiwRfAYKjdiaMVzmIw6VQGhQkNNDIaN2Q==
X-ME-Sender: <xms:R8FPZGgXqMoniz-4OdjgWITBVDN7SJX2h0iCkENHlG3S7ruiwfnbew>
    <xme:R8FPZHCDb1qNlTf1nSbWEcX4YiRfB1Dfbn9xixG3spXznCcNtP-RaxzqGI-_Pc35g
    z_AazoV2SjlzNc>
X-ME-Received: <xmr:R8FPZOHuMfTjP_0qOlnu6hpB81cRyW7beeT70ckteFrFpbkPkyVGJTSstLft>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepueeiieduveefieektdfhhfekgfevudeuleefieetgeffhfdvvddugeduhfff
    heegnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:R8FPZPRHMHDwpWElLjkMLgk9O_4BUIQB8-pc-fqMjUlLiqDRfeuCzQ>
    <xmx:R8FPZDyfZ06A9ym7tCmQRH9O6QylZCRohxSpVnNE1r6OpyfBThi1zA>
    <xmx:R8FPZN5QZc-DP3sYWwUMRpqp9BgB5VOMjZIrLSPULrfjQU47BUTknA>
    <xmx:SMFPZKzJgFbN6m0vF4Zo6ts70tasGDDz5hXe-RbFIsxAYidSutQVWw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 09:40:22 -0400 (EDT)
Date:   Mon, 1 May 2023 16:40:19 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Schspa Shi <schspa@gmail.com>, longman@redhat.com,
        swboyd@chromium.org, linux@roeck-us.net, wuchi.zero@gmail.com,
        linux-kernel@vger.kernel.org,
        syzbot+5093ba19745994288b53@syzkaller.appspotmail.com,
        danieller@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH] debugobject: Prevent init race with static objects
Message-ID: <ZE/BQ5yUQZUwhlTu@shredder>
References: <20230303161906.831686-1-schspa@gmail.com>
 <87bkl9jt3a.ffs@tglx>
 <m2ttycd8kx.fsf@gmail.com>
 <87sfdw8yru.ffs@tglx>
 <87pm908xvu.ffs@tglx>
 <87zg7dzgao.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg7dzgao.ffs@tglx>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 09:54:39AM +0200, Thomas Gleixner wrote:
> Statically initialized objects are usually not initialized via the init()
> function of the subsystem. They are special cased and the subsystem
> provides a function to validate whether an object which is not yet tracked
> by debugobjects is statically initialized. This means the object is started
> to be tracked on first use, e.g. activation.
> 
> This works perfectly fine, unless there are two concurrent operations on
> that object. Schspa decoded the problem:

[...]

> This race exists forever, but was never observed until mod_timer() got a
> debug_object_assert_init() added which is outside of the timer base lock
> held section right at the beginning of the function to cover the lockless
> early exit points too.
> 
> Rework the code so that the lookup, the static object check and the
> tracking object association happens atomically under the hash bucket
> lock. This prevents the issue completely as all callers are serialized on
> the hash bucket lock and therefore cannot observe inconsistent state.
> 
> Fixes: 3ac7fe5a4aab ("infrastructure to debug (dynamic) objects")
> Reported-by: syzbot+5093ba19745994288b53@syzkaller.appspotmail.com
> Debugged-by: Schspa Shi <schspa@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://syzkaller.appspot.com/bug?id=22c8a5938eab640d1c6bcc0e3dc7be519d878462
> Link: https://lore.kernel.org/lkml/20230303161906.831686-1-schspa@gmail.com

Thomas,

With this patch we see the following warning in the kernel log during
boot:

"ODEBUG: Out of memory. ODEBUG disabled"

In which case, the stats are:

# cat /sys/kernel/debug/debug_objects/stats
max_chain     :24
max_checked   :37
warnings      :0
fixups        :0
pool_free     :4297
pool_pcp_free :84
pool_min_free :0
pool_used     :0
pool_max_used :6615
on_free_list  :0
objs_allocated:15616
objs_freed    :11319


If I revert this patch, the warning disappears and I see the following
stats:

# cat /sys/kernel/debug/debug_objects/stats
max_chain     :25
max_checked   :40
warnings      :0
fixups        :0
pool_free     :1219
pool_pcp_free :209
pool_min_free :289
pool_used     :1578
pool_max_used :8026
on_free_list  :0
objs_allocated:32304
objs_freed    :29507

The following diff seems to solve the problem for me:

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b796799fadb2..af4bd66c571c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -21,7 +21,7 @@
 #define ODEBUG_HASH_BITS       14
 #define ODEBUG_HASH_SIZE       (1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE       1024
+#define ODEBUG_POOL_SIZE       (16 * 1024)
 #define ODEBUG_POOL_MIN_LEVEL  256
 #define ODEBUG_POOL_PERCPU_SIZE        64
 #define ODEBUG_BATCH_SIZE      16

In which case, the stats are:

# cat /sys/kernel/debug/debug_objects/stats 
max_chain     :28
max_checked   :64
warnings      :0
fixups        :0
pool_free     :14789
pool_pcp_free :192
pool_min_free :8120
pool_used     :1595
pool_max_used :8264
on_free_list  :0
objs_allocated:16384
objs_freed    :0

I'm not familiar with the debugobjects code, but maybe it makes sense to
make "ODEBUG_POOL_SIZE" configurable via Kconfig in a similar fashion to
"CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE"?

Please let me know if more information is required or if you want me to
test a patch.

Thanks
