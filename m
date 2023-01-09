Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88C2661F6B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjAIHtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjAIHtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:49:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E313D1B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:48:54 -0800 (PST)
X-UUID: 58e4959e74f846178f01e511ce0de840-20230109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bs2FSxIihXHb6oD1WWcKClwQlo62DnFY7LM0eETIU98=;
        b=lUcvgIYMKQE/NrQVWMff4Rk5IcBS8pKK6n1hdwu4eZC4HuTA1FrL/Ou0nNyORswl9FsxB2wmKtgMQA/ygQ9wtNh+3+rCXpvJDY+bJDTPNh96q78sgq2HFXeEwXTrIWBgb02lCdECIEz42dqkNEZqvC7ZyKRZs0XPC2rpnC6YiFk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:cd83526b-aac8-453c-abd3-749a726752fb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.17,REQID:cd83526b-aac8-453c-abd3-749a726752fb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:543e81c,CLOUDID:6e8b1554-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230109154849SCUYYH1B,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0
X-CID-BVR: 1,FCT
X-UUID: 58e4959e74f846178f01e511ce0de840-20230109
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 139872415; Mon, 09 Jan 2023 15:48:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 9 Jan 2023 15:48:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 9 Jan 2023 15:48:46 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <catalin.marinas@arm.com>
CC:     <anders.roxell@linaro.org>, <arnd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>
Subject: Re: [PATCH] arm64: asm: vdso: gettimeofday: export common variables
Date:   Mon, 9 Jan 2023 15:48:46 +0800
Message-ID: <20230109074846.23138-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YWQ9FTJUMu9PMPpa@arm.com>
References: <YWQ9FTJUMu9PMPpa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

>On Mon, Oct 11, 2021 at 02:47:56PM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 11, 2021 at 12:03 PM Will Deacon <will@kernel.org> wrote:
>> > On Thu, Oct 07, 2021 at 09:57:54PM +0200, Anders Roxell wrote:
>> > > When building the kernel with sparse enabled 'C=1' the following
>> > > warnings can be seen:
>> > >
>> > > arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning: symbol '__kernel_clock_gettime' was not declared. Should it be static?
>> > > arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning: symbol '__kernel_gettimeofday' was not declared. Should it be static?
>> > > arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning: symbol '__kernel_clock_getres' was not declared. Should it be static?
>> > >
>> > > Rework so the variables are exported, since these variables are
>> > > created and used in vdso/vgettimeofday.c, also used in vdso.lds.S.
>> >
>> > Hmm, these functions are part of the vDSO and shouldn't be called from the
>> > kernel, so I don't think it makes sense to add prototypes for them to a
>> > kernel header, to be honest.
>> 
>> It's a recurring problem, and I have recommended this method to Anders as
>> I don't see any of the alternatives as better.
>> 
>> The thing is that both sparse (with make C=1) and gcc/clang (with make W=1)
>> warn about missing prototypes, and this catches a lot of real bugs. I hope
>> that we can eventually get to the point of enabling the warning by default for
>> all files, but that means we need a declaration for each global function and
>> variable.
>
>I don't think there's anything in the asm/vdso/gettimeofday.h that is
>required by the kernel. However, it gets dragged in via the datapage.h.
>If I got it right, something like this should avoid it and we can
>include the prototypes:
>
>

I tested your patch and I still got the same sparse error. So I was thinking
that we should keep Anders' arm64/include/asm/vdso/gettimeofday.h part.

The following patch works for me (tested with C=1, ARCH=arm64 defconfig)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 764d13e2916c..d751aa6af7bf 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -14,6 +14,13 @@
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
+extern int __kernel_clock_gettime(clockid_t clock,
+		struct __kernel_timespec *ts);
+extern int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
+		struct timezone *tz);
+extern int __kernel_clock_getres(clockid_t clock_id,
+		struct __kernel_timespec *res);
+
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			  struct timezone *_tz)
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..a8d26d7d042d 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -121,22 +121,6 @@ struct vdso_data {
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 
-/*
- * The generic vDSO implementation requires that gettimeofday.h
- * provides:
- * - __arch_get_vdso_data(): to get the vdso datapage.
- * - __arch_get_hw_counter(): to get the hw counter based on the
- *   clock_mode.
- * - gettimeofday_fallback(): fallback for gettimeofday.
- * - clock_gettime_fallback(): fallback for clock_gettime.
- * - clock_getres_fallback(): fallback for clock_getres.
- */
-#ifdef ENABLE_COMPAT_VDSO
-#include <asm/vdso/compat_gettimeofday.h>
-#else
-#include <asm/vdso/gettimeofday.h>
-#endif /* ENABLE_COMPAT_VDSO */
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/gettimeofday.h b/include/vdso/gettimeofday.h
new file mode 100644
index 000000000000..0270da504fe3
--- /dev/null
+++ b/include/vdso/gettimeofday.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * The generic vDSO implementation requires that gettimeofday.h
+ * provides:
+ * - __arch_get_vdso_data(): to get the vdso datapage.
+ * - __arch_get_hw_counter(): to get the hw counter based on the
+ *   clock_mode.
+ * - gettimeofday_fallback(): fallback for gettimeofday.
+ * - clock_gettime_fallback(): fallback for clock_gettime.
+ * - clock_getres_fallback(): fallback for clock_getres.
+ */
+#ifdef ENABLE_COMPAT_VDSO
+#include <asm/vdso/compat_gettimeofday.h>
+#else
+#include <asm/vdso/gettimeofday.h>
+#endif /* ENABLE_COMPAT_VDSO */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 9a2af9fca45e..cb7a456323e3 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -6,6 +6,8 @@
 
 #include <vdso/datapage.h>
 
+#include <asm/barrier.h>
+
 static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 {
 	u32 seq;
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ce2f69552003..8c1786ae59d8 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -3,6 +3,7 @@
  * Generic userspace implementations of gettimeofday() and similar.
  */
 #include <vdso/datapage.h>
+#include <vdso/gettimeofday.h>
 #include <vdso/helpers.h>
 
 #ifndef vdso_calc_delta


thanks,
Miles
-- 
2.18.0

