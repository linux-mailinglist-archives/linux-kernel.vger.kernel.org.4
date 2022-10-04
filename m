Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0255F3D13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJDHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJDHNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:13:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33125C66;
        Tue,  4 Oct 2022 00:13:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w18so11144164wro.7;
        Tue, 04 Oct 2022 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=E64n4JdOT43nWMb7866a7qM+s/AANtw76wVVuCsaV50=;
        b=V6/V7N5ybsYZMdzg5RO9dODHr6C7ODksdf/ha/z7V+/C3YglnmsqNWsnDfS8X65q9I
         12hnETsgPho7DJ0oAyv8XKsne+QhineYYY7SO1YWQEkKrLJwjYNq3lcqYWd95Jq8U5zn
         JEPNaKHqjgWRuqlbIKHegUD9jp9YLhcilGV6xsg+fuiNVUyWPV5q2OuTeKz1NNiHQOqn
         Qg+bzJya3sqLkIDHMdR8mbHa4TOQ7MeVf9y4FgDfv62rdy+hvanyleQ3tY2pH0rYcuSc
         b9r9ho8WEaOtxnDQzzopy35otNnFCCx2r6w5Ql30RsazgaPwBvoikmw0Mw44QY+kI6QK
         +Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E64n4JdOT43nWMb7866a7qM+s/AANtw76wVVuCsaV50=;
        b=t/pktzyeNmrU4HQ991gKalmwx2QpkR+csylmHILIm6S8vmrzBbt0feRVqqywJ5BDbn
         zoMCaJBN0xxxvT6o50tRdhvOBqVFPwDDDaLOJFf0W9ckqj5EBIAyKDlqCAOk/1l/HTBQ
         iYiVTvO8lotwGcHX3Y0wTGUEWvlkRm1c+Np92RHrvSWOOSleXWgmpKlhaTRH0FeP/j8u
         fhXnvWduxZqRYD6EAoEfKMcHOs2UZ/IcWjOZqIPg4rfcfLX491y/TCXgyoTa5kQKa8MX
         04qQLZVRejMtOu+nUloNc0ae/E2shejfJnowXq88/wynH2MHSihcdJBLYpqV73N0iveH
         7MPg==
X-Gm-Message-State: ACrzQf30TRUbQ47xx/lMdWo4IzyceJEU5kb6qC2ioyeP3f+EdvLrztri
        7fsSWkhaQVcW2N5uWT0S+TI=
X-Google-Smtp-Source: AMsMyM5g3ea33r3NOLjhasfyXIRV/op8Fp+R/M3qT+UJbUoiYB1Eyq4jPvgQNZLjj6iiWADrb7gHCg==
X-Received: by 2002:a5d:64e8:0:b0:22a:bbb0:fa with SMTP id g8-20020a5d64e8000000b0022abbb000famr15906713wri.372.1664867612624;
        Tue, 04 Oct 2022 00:13:32 -0700 (PDT)
Received: from felia.fritz.box (200116b8268459002106a0d517b7b65c.dip.versatel-1u1.de. [2001:16b8:2684:5900:2106:a0d5:17b7:b65c])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6b03000000b0022860e8ae7csm4608378wrw.77.2022.10.04.00.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:13:31 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] alpha: remove the needless aliases osf_{readv,writev}
Date:   Tue,  4 Oct 2022 09:13:02 +0200
Message-Id: <20221004071302.11471-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 987f20a9dcce ("a.out: Remove the a.out implementation") removes
CONFIG_OSF4_COMPAT and its functionality. Hence, sys_osf_{readv,writev}
are now just aliases of sys_{readv,writev}.

Remove these needless aliases.

Link: https://lore.kernel.org/lkml/CAHk-=wjwvBc3VQMNtUVUrMBVoMPSPu26OuatZ_+1gZ2m-PmmRA@mail.gmail.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus says: minor cleanup... - Janitor says: Yes, that is my job!

Completely untested.

alpha maintainers, please pick this minor cleanup for your -next tree.

 arch/alpha/kernel/osf_sys.c            | 12 ------------
 arch/alpha/kernel/syscalls/syscall.tbl |  4 ++--
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 68ec314d3fac..c54469b369cb 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1278,18 +1278,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	return addr;
 }
 
-SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
-		const struct iovec __user *, vector, unsigned long, count)
-{
-	return sys_readv(fd, vector, count);
-}
-
-SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
-		const struct iovec __user *, vector, unsigned long, count)
-{
-	return sys_writev(fd, vector, count);
-}
-
 SYSCALL_DEFINE2(osf_getpriority, int, which, int, who)
 {
 	int prio = sys_getpriority(which, who);
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3515bc4f16a4..8ebacf37a8cf 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -125,8 +125,8 @@
 116	common	osf_gettimeofday		sys_osf_gettimeofday
 117	common	osf_getrusage			sys_osf_getrusage
 118	common	getsockopt			sys_getsockopt
-120	common	readv				sys_osf_readv
-121	common	writev				sys_osf_writev
+120	common	readv				sys_readv
+121	common	writev				sys_writev
 122	common	osf_settimeofday		sys_osf_settimeofday
 123	common	fchown				sys_fchown
 124	common	fchmod				sys_fchmod
-- 
2.17.1

