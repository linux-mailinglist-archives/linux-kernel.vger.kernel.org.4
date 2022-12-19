Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA759650850
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLSH7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiLSH7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:59:51 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5407EBE21
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:59:50 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:87b:c831:2ca7:222d])
        by albert.telenet-ops.be with bizsmtp
        id y7zn28005471bjf067znpQ; Mon, 19 Dec 2022 08:59:47 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p7B3q-000Zlc-Tw; Mon, 19 Dec 2022 08:59:46 +0100
Date:   Mon, 19 Dec 2022 08:59:46 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     mm-commits@vger.kernel.org, davidgow@google.com,
        brendanhiggins@google.com, arnd@arndb.de, geert+renesas@glider.be,
        akpm@linux-foundation.org
Subject: Re: + lib-add-dhrystone-benchmark-test.patch added to mm-nonmm-unstable
 branch
In-Reply-To: <20221216224923.58770C433D2@smtp.kernel.org>
Message-ID: <alpine.DEB.2.22.394.2212190857310.137329@ramsan.of.borg>
References: <20221216224923.58770C433D2@smtp.kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Andrew,

On Fri, 16 Dec 2022, Andrew Morton wrote:
> The patch titled
>     Subject: lib: add Dhrystone benchmark test
> has been added to the -mm mm-nonmm-unstable branch.  Its filename is
>     lib-add-dhrystone-benchmark-test.patch
>
> This patch will shortly appear at
>     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/lib-add-dhrystone-benchmark-test.patch
>
> This patch will later appear in the mm-nonmm-unstable branch at
>    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>   a) Consider who else should be cc'ed
>   b) Prefer to cc a suitable mailing list as well
>   c) Ideally: find the original patch on the mailing list and do a
>      reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------

Can you please squash the following small fix?
(Obviously I'm still not used to using a newer gcc than the good
  old 4.1, which would have warned about this for sure ;-)

Thanks!

From f03a6abd766c685741dccc59157f4d1addee7ed4 Mon Sep 17 00:00:00 2001
Message-Id: <f03a6abd766c685741dccc59157f4d1addee7ed4.1671436679.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Sun, 18 Dec 2022 10:51:59 +0100
Subject: [PATCH] squash! lib: Add Dhrystone benchmark test

v2:
   - Fix uninitialized use of ret, as reported by kernel test robot
     <lkp@intel.com>.
---
  lib/dhry_run.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dhry_run.c b/lib/dhry_run.c
index 31a1d442e4a0fc19..f9d33efa6d090604 100644
--- a/lib/dhry_run.c
+++ b/lib/dhry_run.c
@@ -69,7 +69,7 @@ static int dhry_run_set(const char *val, const struct kernel_param *kp)
  	if (dhry_run && system_state == SYSTEM_RUNNING)
  		dhry_benchmark();

-	return ret;
+	return 0;
  }

  static int __init dhry_init(void)
-- 
2.25.1
