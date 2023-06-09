Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779172A58E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjFIVs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjFIVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:48:26 -0400
Received: from cheetah.elm.relay.mailchannels.net (cheetah.elm.relay.mailchannels.net [23.83.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028AF2685
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:48:24 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 71DB1641ECD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 21:40:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BF584641DE7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 21:40:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346809; a=rsa-sha256;
        cv=none;
        b=64dnX2IxTQFPffu/cPT3pvqh1pypwCovc7t9PUH2pDGILdpObz7Xe3l7eiO4F+t4QZrKcX
        mT13AwH05MGnbaU0gnUZmlXD+dl09nHIXI/Ak4jgOthky6bZspbfoThpVcH4nRS2qJ/1en
        BZS69eXKJn7yZaTpe0CwHfqB2eAmNNb+KDiXt4Y1GenE4jeXK5Dl9gAlj8QYW27Mi7rEqf
        93eLQWaqn239C89S8pwpaav7OU5kGG5/wTE6LYIZd+pfqG6uRebsino0rifVqFR9wBKQ0A
        HMDHO+WrIuMeRnL8aJFZKWm5oU5gaiwYN6uVxu6Mqh+SMdnq/AhM9ie/TFt2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686346809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
        b=aLp3q0miw2oMbCKqpGuSAQy3Qkp832keXHDTOx2U5Taa/tZi+VMiurA7hambOHPbwix+5/
        4uDjVEsb+xEXms1NZuegxEfaOChsj73sJcuqJdiNXdI7gktHfwKX+j0492yn9Wo9JiaSdQ
        yRawN75DYgF3kdttZ44/O7jA8c0Bgz12SeTA5YMesHmvxFL3tBU+VPQxOhxzbwZxnKzcdg
        PsEyy3kfNy+M0HHkvgE5I7LoLung9PEg/lBUsCCsQRCjohyp9RNh1UbiIp7pdkpmX+BIoK
        VlrIiPwW3zsDbV69f+1kVPKaAazoQfd0HgVEqn5kdtZL6xMkiIILPc4/i7V0Mg==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-pkmv8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Towering: 0e58c6a54370a5b2_1686346810254_1212588394
X-MC-Loop-Signature: 1686346810254:3830252414
X-MC-Ingress-Time: 1686346810254
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.21 (trex/6.8.1);
        Fri, 09 Jun 2023 21:40:10 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDyJ6ClCzY0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686346808;
        bh=u6VFkU8CeRSXxG9CpKygUWaCfdMHq1wUPGyeNaB+TlE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=QsiYEL0kWz0Vg4dpqakHu1f++lQpIiR15twBL0XHHlFWLWW1js6m7dubqPCVWtD/a
         BfekR5k/2B1i7DaNj8jogY7UTN8Jg12cPrKzrJ1YcaEb/L4BxpmkdzZ0ODevVjCutB
         luF2kGOfqxyWCxitlqdZUhB+OUUeJUgtE2EXvEqA=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 14:40:07 -0700
Date:   Fri, 9 Jun 2023 14:40:07 -0700
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
Subject: [PATCH bpf v4 1/2] bpf: ensure main program has an extable
Message-ID: <9253ce691956f19adc93be7dc4c3a7aabe3db3de.1686345886.git.kjlx@templeofstupid.com>
References: <cover.1686345886.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686345886.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When subprograms are in use, the main program is not jit'd after the
subprograms because jit_subprogs sets a value for prog->bpf_func upon
success.  Subsequent calls to the JIT are bypassed when this value is
non-NULL.  This leads to a situation where the main program and its
func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
has an extable.  Extables are only created during JIT.  Now there are
two nearly identical program ksym entries in the tree, but only one has
an extable.  Depending upon how the entries are placed, there's a chance
that a fault will call search_extable on the aux with the NULL entry.

Since jit_subprogs already copies state from func[0] to the main
program, include the extable pointer in this state duplication.
Additionally, ensure that the copy of the main program in func[0] is not
added to the bpf_prog_kallsyms table. Instead, let the main program get
added later in bpf_prog_load().  This ensures there is only a single
copy of the main program in the kallsyms table, and that its tag matches
the tag observed by tooling like bpftool.

Cc: stable@vger.kernel.org
Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5871aa78d01a..b62d1fc0f92b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17214,9 +17214,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -17242,6 +17243,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
-- 
2.25.1

