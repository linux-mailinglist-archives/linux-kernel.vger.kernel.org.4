Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054746D1981
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjCaIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjCaIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:12:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B610AA8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:12:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo210805937b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680250348;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTtJaDPcUyboDuu+t07OWOnwRGX+fzoDe5ViESVkdBo=;
        b=etOf5WG0eBsBF/DZwDCk1NoWf7JXck/1RMIMnjMsKhYGUjjAi+pR/r+Jz+0FXvUKVF
         xUJUhnBcjvfYZjWhQ+N1sqO2dT9flE7JkDWlTaKBhckEW4lz2DV2zvnIO+nuxsslQpoY
         dcpLPkidc7G8Jhvb7BLvoshjqoXiLvYGi174n84OdzAuYHYy3yFrywqwOIYl+z+lzGzb
         4vgGEKVgJ62L/7y8oXc7SOvZ5jrqxU8tSu/tp0T5qcqAhD9U11BzPK/hPkR40rUcFhwr
         jWlRDU0m3+VgAnHAlCeJ9v5R7sGouw5WzLzNb1d/yDOp+qr4+szoSgkgYOSg2ilL2iBs
         sZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680250348;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WTtJaDPcUyboDuu+t07OWOnwRGX+fzoDe5ViESVkdBo=;
        b=Pt1bHPFmu+W0lylVrUOfQw9/p0SsQO1lQQ9kswz1vJmI80gDq4JukvnQa70w5r+Gf/
         Op+EwM5ZoJPbQyjlh0+BbQUyunJRe513D3ouaw4yyDkAl2ELIC5wMAzMiAAWa8OGHLQO
         ZMlI+u7EPcw74/gNDa4CXVIKBxrHm3dnOd8Eq2kPRG1wYmmoWedA8aQzBJ0gStzqHhtZ
         b9sy2DFy/Bq7ynqyrRDJe9nUYX+sZWkipN0hDOOEbLYkk6myFtRxpyE71EeirSrEwExn
         TTM6j9FPHxTdg2Bxb199BWoRJroYNvAQEP1PirlhQjgu6fZ6TV9fzz6pSPFbpikQfmgW
         Y4NQ==
X-Gm-Message-State: AAQBX9ehHGyb69P5JI9o4TRtFII4eGBulLicne0IYvUI87C6zHUspYzg
        4BR+Pd36IE88Cc9CsNPPytC0u2lqHRhGSN7EWg==
X-Google-Smtp-Source: AKy350aB45Yl7LBUM1EirzuFdTAubRZPvlkG5VFHLryaCzixpj1DeKHLfB0MZ9AZfkSx4V5a5iUcUTFpyGC/5nh8xA==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:a176:dc3b:3b5f:c2d4])
 (user=peternewman job=sendgmr) by 2002:a81:4516:0:b0:541:b3dd:96a5 with SMTP
 id s22-20020a814516000000b00541b3dd96a5mr12669529ywa.1.1680250348027; Fri, 31
 Mar 2023 01:12:28 -0700 (PDT)
Date:   Fri, 31 Mar 2023 10:12:09 +0200
In-Reply-To: <f826dd28-0213-b7ea-494c-8c7a0ff348ce@amd.com>
Mime-Version: 1.0
References: <f826dd28-0213-b7ea-494c-8c7a0ff348ce@amd.com>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230331081209.3170293-1-peternewman@google.com>
Subject: Re: [PATCH v5 3/3] Documentation/x86: Documentation for MON group
 move feature
From:   Peter Newman <peternewman@google.com>
To:     babu.moger@amd.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, eranian@google.com,
        fenghua.yu@intel.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peternewman@google.com,
        reinette.chatre@intel.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On Thu, Mar 30, 2023 at 7:33=E2=80=AFPM Moger, Babu <babu.moger@amd.com> wr=
ote:
> On 3/30/23 08:55, Peter Newman wrote:
> > Describe new support for moving MON groups to a new parent CTRL_MON
> > group and its restrictions.
>
> Sorry for coming in late here. I am planning to test these patches. It
> would be helpful to give a simple example to test this feature.

Do you mean inline in the documentation?

For now, you can also try the patch below. These are the testcases I
used.

I'm planning to convert many of our internal, shell script-based test
cases into kernel selftests so I can try to upstream them.

Thanks!
-Peter


---8<-------
From f6d215e90db3c416bd39889b9fa1143d798245e0 Mon Sep 17 00:00:00 2001
From: Peter Newman <peternewman@google.com>
Date: Tue, 7 Mar 2023 11:57:03 +0100
Subject: [PATCH] selftests/resctrl: Test for MON group renaming

Signed-off-by: Peter Newman <peternewman@google.com>
---
 tools/testing/selftests/resctrl/Makefile      |   2 +
 .../selftests/resctrl/test_mongrp_move.sh     | 120 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100755 tools/testing/selftests/resctrl/test_mongrp_move.sh

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selft=
ests/resctrl/Makefile
index 73d53257df42..0b696e7cf19b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -5,6 +5,8 @@ CFLAGS +=3D $(KHDR_INCLUDES)
=20
 TEST_GEN_PROGS :=3D resctrl_tests
=20
+TEST_PROGS :=3D test_mongrp_move.sh
+
 include ../lib.mk
=20
 $(OUTPUT)/resctrl_tests: $(wildcard *.c)
diff --git a/tools/testing/selftests/resctrl/test_mongrp_move.sh b/tools/te=
sting/selftests/resctrl/test_mongrp_move.sh
new file mode 100755
index 000000000000..6d9bfc4e0c8d
--- /dev/null
+++ b/tools/testing/selftests/resctrl/test_mongrp_move.sh
@@ -0,0 +1,120 @@
+#!/bin/sh
+
+set -e
+
+rc=3D0
+
+cleanup()
+{
+	rmdir _test_*
+	rmdir mon_groups/_test_*
+}
+
+skip_all()
+{
+	echo Bail out! $1
+
+	cleanup
+
+	# SKIP code is 4.
+	exit 4
+}
+
+expect_success()
+{
+	if [ "$1" -eq 0 ]; then
+		echo ok $2
+	else
+		echo not ok $2
+		rc=3D1
+	fi
+}
+
+expect_fail()
+{
+	if [ "$1" -eq 0 ]; then
+		echo not ok $2
+		rc=3D1
+	else
+		echo ok $2
+	fi
+}
+
+if [ "$(id -u)" !=3D 0 ]; then
+	skip_all "must be run as root"
+fi
+
+if [ ! -d /sys/fs/resctrl/info ]; then
+	mount -t resctrl resctrl /sys/fs/resctrl || skip_all "no resctrlfs"
+fi
+
+cd /sys/fs/resctrl
+
+if [ ! -f info/L3_MON/mon_features ]; then
+	skip_all "no monitoring support"
+fi
+
+if [ ! -f schemata ]; then
+	skip_all "no allocation support"
+fi
+
+echo "1..11"
+
+if [ -d _test_c1 ] || [ -d _test_c2 ] || [ -d mon_groups/_test_m1 ]; then
+	skip_all "test directories already exist"
+fi
+
+mkdir _test_c1
+mkdir _test_c2
+mkdir _test_c3
+
+mkdir mon_groups/_test_m1
+echo 1 > mon_groups/_test_m1/cpus
+
+mkdir _test_c1/mon_groups/_test_m1
+echo $$ > _test_c1/tasks
+echo $$ > _test_c1/mon_groups/_test_m1/tasks
+
+if mv _test_c1/mon_groups/_test_m1 _test_c2/mon_groups; then
+	echo "ok 1 # MON group move to new parent succeeded"
+else
+	echo "1..0 # skip because MON group move to new parent not supported"
+	cleanup
+	exit 4
+fi
+
+set +e
+
+grep -q $$ _test_c2/tasks
+expect_success $? "2 # PID in new CTRL_MON group"
+
+grep -q $$ _test_c2/mon_groups/_test_m1/tasks
+expect_success $? "3 # PID remains in MON group after move"
+
+grep -q $$ _test_c1/tasks
+expect_fail $? "4 # PID no longer in previous CTRL_MON group"
+
+mv _test_c2/mon_groups/_test_m1/cpus mon_groups
+expect_fail $? "5 # moving files not allowed"
+
+mv _test_c2/mon_groups/_test_m1 _test_c2/mon_groups/_test_m2
+expect_success $? "6 # simple MON directory rename"
+
+mv _test_c2/mon_groups/_test_m2 info
+expect_fail $? "7 # move to info not allowed"
+
+mv _test_c2/mon_groups/_test_m2 _test_c2/mon_groups/mon_groups
+expect_fail $? "8 # rename to mon_groups not allowed"
+
+mv mon_groups/_test_m1 _test_c1/mon_groups
+expect_fail $? "9 # cannot move groups monitoring CPUs"
+
+mv mon_groups/_test_m1 mon_groups/_test_m2
+expect_success $? "10 # groups monitoring CPUs can be renamed"
+
+mv mon_groups/_test_m2/mon_data _test_c1/mon_groups
+expect_fail $? "11 # cannot move subdirectories of a mon_group"
+
+cleanup
+
+exit $rc
--=20
2.40.0.423.gd6c402a77b-goog

