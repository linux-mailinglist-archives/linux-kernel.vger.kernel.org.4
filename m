Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364370FF76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjEXUvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXUu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:50:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67E12B;
        Wed, 24 May 2023 13:50:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae454844edso5430625ad.1;
        Wed, 24 May 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684961458; x=1687553458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+kCS8NmWh8J3rptO4tJyXuUGglRPpK4fkLORybVjSro=;
        b=TH8yxjEGgCPqsHlvuDYZXFS1SUUnpo3HgCA7hD10gV3eVWv+XCC4O8Gjl3Th9GGBIz
         FBEPj/rKHB9yXKMSpf+JiXA1lbbhT2SpxSouY9dVFzS3te99iNEeEx1pPczgdCOdoxbF
         o28mDQkkS53f88pnp956dWOrVAlzBfZMavlaEsmDHAn4pcqih1soB63MrDzIt7QCY33E
         WFp4aTdT9T7cV3Vd71rrBbboX+YkGwgskQXyRkI6gWfHf5Z4s5jbUW6rIPyHlGRN3JzS
         h5HOkJzAqF1P5imbKnyTKS55BWu0Yl510RmsVCTFzsVipY8BTnC1W3elNDYd3Ay7GZ7n
         Lcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684961458; x=1687553458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kCS8NmWh8J3rptO4tJyXuUGglRPpK4fkLORybVjSro=;
        b=OIKuHdT9igXM2wdzkKZGI+f8ByHUPv6c9iO0mUYsslt4ImUCFNxjJRsOrhdumwF8Dr
         gmUC14WrqhbfFyBdbQzE18hPnp0EQ9PqA3G5qCzhItAp7ofScpsKCOwww8yze4zgC1y6
         UP7eE8U5qtu5X0hI0oSy98/IIWCUk+w5y5mAKUUT83m1evpsEFmRncZNeSjqHJ2ALCft
         I4NG4XdiD9czEr5ZIfEUNPqeyw3lTEpDw+GyIx8/zd4tICfJqOfKMPxdbD4OvHkAIZPE
         Iu32kpaYaIWi0Ejkw5Lt3GgF+YROVDxuaG2v6S7ag+ew2tLqlftMKacIM1bKaKbpEiaI
         8qUQ==
X-Gm-Message-State: AC+VfDw9MCqsMKOYAazqwULvmcslyxPcJigN1mBkOSkgjw/h9XHTPfEV
        AIC4ldn2lMZEB9ZcInt+bOU=
X-Google-Smtp-Source: ACHHUZ57bKxvD7dBDENTyhr/3CDKkVM6zBTDEgKVPSWGx0QMm82m0EzGfFv19YSFanzkapXbzk/7lw==
X-Received: by 2002:a17:902:c20c:b0:1aa:ef83:34be with SMTP id 12-20020a170902c20c00b001aaef8334bemr18075841pll.47.1684961457892;
        Wed, 24 May 2023 13:50:57 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:121:f908:b42d:c399])
        by smtp.gmail.com with ESMTPSA id 31-20020a63185f000000b00513973a7014sm5215340pgy.12.2023.05.24.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 13:50:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v2 1/2] perf annotate: Handle x86 instruction suffix generally
Date:   Wed, 24 May 2023 13:50:53 -0700
Message-ID: <20230524205054.3087004-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AT&T asm syntax, most of x86 instructions can have size suffix like
b, w, l or q.  Instead of adding all these instructions in the table,
we can handle them in a general way.

For example, it can try to find an instruction as is.  If not found,
assuming it has a suffix and it'd try again without the suffix if it's
one of the allowed suffixes.  This way, we can reduce the instruction
table size for duplicated entries of the same instructions with a
different suffix.

If an instruction xyz and others like xyz<suffix> are completely
different ones, then they both need to be listed in the table so that
they can be found before the second attempt (without the suffix).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b708bbc49c9e..7f05f2a2aa83 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -70,6 +70,7 @@ struct arch {
 	struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
 	bool		sorted_instructions;
 	bool		initialized;
+	const char	*insn_suffix;
 	void		*priv;
 	unsigned int	model;
 	unsigned int	family;
@@ -179,6 +180,7 @@ static struct arch architectures[] = {
 		.init = x86__annotate_init,
 		.instructions = x86__instructions,
 		.nr_instructions = ARRAY_SIZE(x86__instructions),
+		.insn_suffix = "bwlq",
 		.objdump =  {
 			.comment_char = '#',
 		},
@@ -720,6 +722,26 @@ static struct ins_ops *__ins__find(struct arch *arch, const char *name)
 	}
 
 	ins = bsearch(name, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
+	if (ins)
+		return ins->ops;
+
+	if (arch->insn_suffix) {
+		char tmp[32];
+		char suffix;
+		size_t len = strlen(name);
+
+		if (len == 0 || len >= sizeof(tmp))
+			return NULL;
+
+		suffix = name[len - 1];
+		if (strchr(arch->insn_suffix, suffix) == NULL)
+			return NULL;
+
+		strcpy(tmp, name);
+		tmp[len - 1] = '\0'; /* remove the suffix and check again */
+
+		ins = bsearch(tmp, arch->instructions, nmemb, sizeof(struct ins), ins__key_cmp);
+	}
 	return ins ? ins->ops : NULL;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

