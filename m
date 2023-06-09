Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1A728C43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjFIALh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjFIALf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:11:35 -0400
Received: from grey.apple.relay.mailchannels.net (grey.apple.relay.mailchannels.net [23.83.208.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D91706
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:11:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1249B141412
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:11:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A1535141EAA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:11:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686269493; a=rsa-sha256;
        cv=none;
        b=zXRgaR82G2lkyJ2cW88PyKLu7UkP3x4W5Q1+TraOxDhMYkmCnAP9RKolodvBJ0IuVQSD92
        Gm6qKLxswUZ0z+9yqfVuUUMf9P2uBKhN7HzpJ8wkqO1IgJtHn7WYIR4ZaPLeUzapVqM9F6
        DvFNwiEbbzGWi+HakoCWNOzHpCYtLQWwyoLQTyfOPyjUCvBe5sFw2ffkAUK0GP4wBGOquo
        XglTcwnR3KYsdVzrsTo/Qi1P4+mbxfEG6HC58wZ+TURwQXNehNbD8j/G5X1P1FB0VJGX8O
        2XRl3iO4gCOpc3NJmjtAl05bEe6KT/FTb/oYuVX/DaPK87FxonkW9g0G83Rkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686269493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=F8KPdDJs/fafqK8befrWeYqM6/tlnupScz2H0Ba6c8I=;
        b=pNBIg1SVrp5ApxMJi3cXhWmLWWa1EQRWfsTW/B6A/bLcACJO91o2KoZD34ZQtGLOnVEyda
        ozetTw8AJbAySBEBgo2hizecLOplJebFXS5q5ywlF2BEVm99TmwiQC3vLnQFImAr7RAZkx
        gjwBgNAS0QNbeI8PTHNt4suaks45ag3MUl+uRTmG+tsnrXVUkKskb0FzDN0rX5T3f+PAba
        KwR1QTtTFPXJtXZZd7dNQ/bnglO+SwutT5nZBE79LaJTmWiZ8zulpzDUXg4iJxcGTPTBeA
        /PM5z1gs3/Sv25k6ldFXeNAxHUUxFceDxses6pdSC5JqhV3NQG8eq8UMaZ4tUg==
ARC-Authentication-Results: i=1;
        rspamd-6f5cfd578c-f2pt8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Power: 6c3660031629f650_1686269493890_955765820
X-MC-Loop-Signature: 1686269493890:925410726
X-MC-Ingress-Time: 1686269493889
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.22 (trex/6.8.1);
        Fri, 09 Jun 2023 00:11:33 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4QchMS6BFMz1pQ
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686269492;
        bh=F8KPdDJs/fafqK8befrWeYqM6/tlnupScz2H0Ba6c8I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=qVzIX9VesNFlL8xB712fCTbGsLi9rI2jI1DX5TdbS6CrxTdRRv9ANQSv2kARsBEph
         4a9nkcq5WkqySs7iXyVDSKtZDMg9VNW63YrkPY/JoCjmhjUz0tPlfCHQXe872HSpzN
         G9Kez1ZTlvoiV4boKKxid0qGi6Naxgp2hfuSZ6AE=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0042
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 08 Jun 2023 17:11:31 -0700
Date:   Thu, 8 Jun 2023 17:11:31 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram extables
Message-ID: <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686268304.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain situations a program with subprograms may have a NULL
extable entry.  This should not happen, and when it does, it turns a
single trap into multiple.  Add a test case for further debugging and to
prevent regressions.  N.b: without any other patches this can panic or
oops a kernel.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
 .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
new file mode 100644
index 000000000000..2201988274a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "test_subprogs_extable.skel.h"
+
+void test_subprogs_extable(void)
+{
+	const int READ_SZ = 456;
+	struct test_subprogs_extable *skel;
+	int err;
+
+	skel = test_subprogs_extable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = test_subprogs_extable__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+	err = test_subprogs_extable__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
+
+	test_subprogs_extable__detach(skel);
+
+cleanup:
+	test_subprogs_extable__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
new file mode 100644
index 000000000000..c3ff66bf4cbe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} test_array SEC(".maps");
+
+static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *data)
+{
+	return 1;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+SEC("fexit/bpf_testmod_return_ptr")
+int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
+{
+	*(volatile long *)ret;
+	*(volatile int *)&ret->f_mode;
+	bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

