Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E1610DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJ1J6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiJ1J5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9186B5A827
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951042; x=1698487042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r/Wt8wTrrxLwn/R3qKGQRI/nbpEUQa2isveXNykvGmo=;
  b=D70giHajM4Owq1IwKDR7pbSjdFwyqMvIkpVbizjof3Sp5Xg4sQlr/FaE
   MwwyX8CeEYZySeq5VbHMAppG7Ncsgrydd2JiahEjxko1H3hg1IP5yft9H
   2OFPSKLW8pgrEp9E9H2ZVEiey7Wl8PUL0jLBUJAABXb1OEzahwWCxypIc
   MxWN3BGIkpIQ0daQnIGyDYCB5/lT+gpWBTJoL+2eGeWj4bv4vCpH7Vk7q
   5j6wZZv7wy8+GxKp/pJDFA7R/h7d1KxKjuMFJne5H51eu4Lz6oqtHQsCQ
   k6+Kp/Nx8/Ir5Ku8rHPe+Lcc5i+EIRxyLLh6mFKgoFQzahkSb+ftJX63Y
   w==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="327068497"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:21 +0800
IronPort-SDR: U+qZsvGaWMfcwF4H6obUyXcSpY9JF5saundO8oftyR6Xbgxu6oG5i/TplnS9Kbm7qccDmDwwmg
 YtTbqQEbbsdROLqisET1H3fM4hjG/5TN/uQMkaPuw0rqKpBYEioU30K+4/4/HAKi+PZZluA7T+
 zU3T6RmZCV80MaIBWfj/vCIAOb+HIO2Ukg0B6Bqb7f/UuRBKJ1OmcafexhZKHqSrfb1/+4V/1W
 s91gvbGfb5Uj2KVNvQ131b8L2xrRifNq1vj+B0mvd7zzTKvgdUrCVFVwSjhxWfmN0trkqT+3Yk
 dNwh4ZEGTi1pRrz22OdoNkMI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:41 -0700
IronPort-SDR: M8kz8t4jbCtprmaG5BDc51msI0JF5TZOfvfJJbEbJ447jrHir47xUu5YO0cSUHiJuWV3mBPDhc
 gPuLdJCfl75CWcLVoWkehFPxlT9wcyumlBYvDHXNK/ZMx3F6o4/0jtMYqiHB4y7TVqfq1Q1Yr7
 iLUQ+zcCjG+foHeOKpl0gzVfLWSCuJNyRv6wpSI1c+TXaXB72qXOTlgOrqNi2SFQc4mGV+ehtH
 sIFm6iAcbt/FRf4oHNWQx+YeuM+/DErv3++ww/1eye69QAmWXskAqqkQHMHsap72ec02AGk2Ty
 Bk8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyn2WZ2z1RWy3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:57:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951040; x=1669543041; bh=r/Wt8wTrrxLwn/R3qK
        GQRI/nbpEUQa2isveXNykvGmo=; b=J/XB7nV3s8VIP3A2o68BCRLdofvNTcUQoQ
        WBFb7oiY2q3ZtHUgU/oyAMv/aTGdkNAeTg4zioNsvN7N0Hvi8camt+2Vqc4Qmkma
        qD0h9f2TouksOrzl9VGkBu3QSVWJZF96fMvqslYzl6fx0nuuG0EApS6wBlbZT/Ju
        ylvGiB/zfeLKclZ6F9BQzXJ3tz8BueH6n7jBLDHqU0xCaJBqIduYTbdnPuq9nUUV
        Ys2p0lfJmr7fykFMktiyg2cVClc1P5j8dlG3k/YHZfjvLL0WFRrE/yew1NptDn2O
        JaS6AJcDVjHiv/l5rwKPGC4g9b+fPyNrNQTpGA3BdKyqPUbB63JA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O-6iK4hps_tj for <linux-kernel@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:20 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyc2BBbz1RvLy;
        Fri, 28 Oct 2022 02:57:11 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 4/6] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 28 Oct 2022 19:56:30 +1000
Message-Id: <20221028095632.1081262-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Using the new __kernel_futex_syscall*() functions let's add support for
32-bit systems with a 64-bit time_t. We can just direclty call the
publically exposed __kernel_futex_syscall_timeout() and
__kernel_futex_syscall_nr_requeue() functions to do this.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20211209235857.423773-4-alistair.francis@opensource.wdc.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 tools/testing/selftests/futex/include/futextest.h           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7..556bf3e74755 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", (long long) ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index c786fffecb8a..1686f94667b1 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/futex_syscall.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +70,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+	return __kernel_futex_syscall_timeout(uaddr, op | opflags, val, timeout=
, uaddr2, val3);
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+	return __kernel_futex_syscall_nr_requeue(uaddr, op | opflags, val, nr_r=
equeue, uaddr2, val3);
 }
=20
 /**
--=20
2.37.3

