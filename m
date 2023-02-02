Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7F6881C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjBBPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjBBPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:24:07 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 07:24:04 PST
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF476A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1675351444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uWwpvteQUwmwKhSS9o8HppM0gMs4+njU0DW+fkM+w/E=;
  b=KE4DO6o9X+dAgW78N4SGPMj3e3AjexT2EKFgPIJq6+RQ+OOEEYEGRwkQ
   Owaz1siEEcHopvyQ9W02LIQW8JoLTRUtu6aoX+PSIwrd34++JnpTpdSlx
   rZ0z03a52NU2qwndDJ3sraEf5nHMyDHRr0nVmzitUbCUaR75zVHXPS0NE
   4=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 95796629
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:U78376tvwPfi9GgP+2kzYaQfMefnVGFeMUV32f8akzHdYApBsoF/q
 tZmKW2Ob/iCZTb9e4x3btjn9BxQ65OHndBhSARtry9nESsa+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg0HVU/IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4bKj51v0gnRkPaoQ5AWGzSFPZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwGCsIXEuu1rOM2I34QctMiuU8NtTZI9ZK0p1g5Wmx4fcORJnCR+PB5MNC3Sd2jcdLdRrcT
 5NHM3w1Nk2GOkARfA5NU/rSn8/x7pX7WzBUtlOT47Yw+W/Q5AdwzKLsIJzefdniqcB9zxvH9
 zyYpTWR7hcyJuzA12bY0yKXgerTwwfafZJJFb3o+as/6LGU7jNKU0BHPbehmtGlh0+xX9tZJ
 2QO9yYupLR0/0uuJvH2WwCjvHOe+xIRRddUO/c35AGE1uzf5APxLmMPRyNFZt0rnNU7STwjy
 hmCmNaBLThutqCFDHGQ7LGZqRusNiUPa2wPfykJSU0C+daLnW0opkuRFJA5Svfz14CrX2iqm
 FhmsRTSmZ0jlss5jIjqrGrfvHGnhLjFbxEv+zfICzfNAhxCWKapYImh6F7+5PlGLZqEQlTpg
 EXoi/Ry/8hVU8jTyXXlrPElWejwuq3baGG0bUtHRcFJyti7x5K0kWm8ChlaLVwhDMsLcCSBj
 KT76VIIv8870JdHgMZKj2ON5yYCl/CI+TfNDKq8gj9yjn9ZKme6ENlGPxL44owUuBFEfVsDE
 Zmaa92wKn0RFL5qyjG7L89Ej+B2nH9gmTuMFcuhp/hC7VZ5TCfFIYrpzXPUNrxphE96iFq9H
 ylj2zuilEwEDbyWjtj/+o8PN1EaRUXX9rivw/G7gtWre1I8cEl4Uq+5/F/UU9A990ijvruSr
 y7Vt44x4AaXuEAr3i3RMSg+NuK0AcsvxZ/5VAR1VWuVN7EYSd7HxM8im1EfJ9HLKMQLISZIc
 sQ4
IronPort-HdrOrdr: A9a23:tKoZDqoRhagihA+plqALHG0aV5urL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ku90KnpewK+yXcH2/hqAV7CZnishILMFu1fBOTZslrd8kHFl9K1kJ
 0QC5SWa+eAR2SS7/yKhjVQeuxIqLbozEnrv5am854Hd3AJV0gU1XYcNu/tKDwSeOApP/oEPa
 vZwvACiyureHwRYMj+LGICRfL/q9rCk4+jSQIaBjY8gTP+wQ+A2frfKVy1zx0eWzRAzfMJ6m
 7eiTH04a2lrrWS1gLc7WnO9J5b8eGRheerRfb8xPT9GA+cyjpAV74RGIFqewpF4t1H3Wxa0e
 UkZS1QevibpUmhOl1d6iGdpjUImAxel0MKj2XozEcL6PaJOw4SGo5Pg5lUfQDe7FdltNZg0L
 hT12bcrJZPCwjc9R6NkeQg+Csa5XZcjEBS5dL7tUYvJrc2eftUt8gS7UlVGJAPEGbz750mCv
 BnCIXZ6OxNeV2XYnjFti03qebcFkgbD1ODWAwPq8aV2z9ZkDRwyFYZ3tUWmjMF+IgmQ5dJ6u
 zYOuBjla1ITMURcaVhbd1xCPefGyjIW1bBIWiSKVPoGOUOPG/MsYf+5PEv6OSjaPUzve4PcV
 T6ISFlXEIJCjLT4Je1reN2Gzj2MRSAYQg=
X-IronPort-AV: E=Sophos;i="5.97,267,1669093200"; 
   d="scan'208";a="95796629"
From:   =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        "Christine Caulfield" <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        <cluster-devel@redhat.com>
Subject: [PATCH] DLM: increase socket backlog to avoid hangs with 16 nodes
Date:   Thu, 2 Feb 2023 15:22:50 +0000
Message-ID: <6b008b94e3b295f572502abec8ae15da46133a64.1675351367.git.edwin.torok@cloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a 16 node virtual cluster with e1000 NICs joining the 12th node prints
SYN flood warnings for the DLM port:
Dec 21 01:46:41 localhost kernel: [ 2146.516664] TCP: request_sock_TCP: Possible SYN flooding on port 21064. Sending cookies.  Check SNMP counters.

And then joining a DLM lockspace hangs:
```
Dec 21 01:49:00 localhost kernel: [ 2285.780913] INFO: task xapi-clusterd:17638 blocked for more than 120 seconds.                                                                     │
Dec 21 01:49:00 localhost kernel: [ 2285.786476]       Not tainted 4.4.0+10 #1                                                                                                         │
Dec 21 01:49:00 localhost kernel: [ 2285.789043] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.                                                             │
Dec 21 01:49:00 localhost kernel: [ 2285.794611] xapi-clusterd   D ffff88001930bc58     0 17638      1 0x00000000                                                                      │
Dec 21 01:49:00 localhost kernel: [ 2285.794615]  ffff88001930bc58 ffff880025593800 ffff880022433800 ffff88001930c000                                                                  │
Dec 21 01:49:00 localhost kernel: [ 2285.794617]  ffff88000ef4a660 ffff88000ef4a658 ffff880022433800 ffff88000ef4a000                                                                  │
Dec 21 01:49:00 localhost kernel: [ 2285.794619]  ffff88001930bc70 ffffffff8159f6b4 7fffffffffffffff ffff88001930bd10
Dec 21 01:49:00 localhost kernel: [ 2285.794644]  [<ffffffff811570fe>] ? printk+0x4d/0x4f                                                                                              │
Dec 21 01:49:00 localhost kernel: [ 2285.794647]  [<ffffffff810b1741>] ? __raw_callee_save___pv_queued_spin_unlock+0x11/0x20                                                           │
Dec 21 01:49:00 localhost kernel: [ 2285.794649]  [<ffffffff815a085d>] wait_for_completion+0x9d/0x110                                                                                  │
Dec 21 01:49:00 localhost kernel: [ 2285.794653]  [<ffffffff810979e0>] ? wake_up_q+0x80/0x80                                                                                           │
Dec 21 01:49:00 localhost kernel: [ 2285.794661]  [<ffffffffa03fa4b8>] dlm_new_lockspace+0x908/0xac0 [dlm]                                                                             │
Dec 21 01:49:00 localhost kernel: [ 2285.794665]  [<ffffffff810aaa60>] ? prepare_to_wait_event+0x100/0x100                                                                             │
Dec 21 01:49:00 localhost kernel: [ 2285.794670]  [<ffffffffa0402e37>] device_write+0x497/0x6b0 [dlm]                                                                                  │
Dec 21 01:49:00 localhost kernel: [ 2285.794673]  [<ffffffff811834f0>] ? handle_mm_fault+0x7f0/0x13b0                                                                                  │
Dec 21 01:49:00 localhost kernel: [ 2285.794677]  [<ffffffff811b4438>] __vfs_write+0x28/0xd0                                                                                           │
Dec 21 01:49:00 localhost kernel: [ 2285.794679]  [<ffffffff811b4b7f>] ? rw_verify_area+0x6f/0xd0                                                                                      ┤
Dec 21 01:49:00 localhost kernel: [ 2285.794681]  [<ffffffff811b4dc1>] vfs_write+0xb1/0x190                                                                                            │
Dec 21 01:49:00 localhost kernel: [ 2285.794686]  [<ffffffff8105ffc2>] ? __do_page_fault+0x302/0x420                                                                                   │
Dec 21 01:49:00 localhost kernel: [ 2285.794688]  [<ffffffff811b5986>] SyS_write+0x46/0xa0                                                                                             │
Dec 21 01:49:00 localhost kernel: [ 2285.794690]  [<ffffffff815a31ae>] entry_SYSCALL_64_fastpath+0x12/0x71
```

The previous limit of 5 seems like an arbitrary number, that doesn't match any
known DLM cluster size upper bound limit.

Signed-off-by: Edwin Török <edvin.torok@citrix.com>
Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: cluster-devel@redhat.com
---
Notes from 2023:
  This patch was initially developed on 21 Dec 2017, and in production use ever since.
I expected to drop out of our patchqueue at the next kernel upgrade, however it
hasn't, so I probably forgot to send it.

I haven't noticed this bug again with the patch applied, and the previous value
of '5' seems like an arbitrary limit not matching any supported upper bounds
on DLM cluster sizes, so this patch has (unintentionally) had a 5 year test
cycle.

Although the join hanging forever like that may still be a bug, if the SYN cookies
consistently trigger it lets try to avoid the bug by avoiding the SYN cookies.
---
 fs/dlm/lowcomms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 4450721ec..105c9138b 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1774,7 +1774,7 @@ static int dlm_listen_for_all(void)
 	sock->sk->sk_data_ready = lowcomms_listen_data_ready;
 	release_sock(sock->sk);
 
-	result = sock->ops->listen(sock, 5);
+	result = sock->ops->listen(sock, 128);
 	if (result < 0) {
 		dlm_close_sock(&listen_con.sock);
 		return result;
-- 
2.34.1

