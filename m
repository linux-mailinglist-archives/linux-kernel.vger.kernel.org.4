Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0321969F367
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjBVLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjBVLXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:23:23 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02EF32E59
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:23:17 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id ec13-20020a0564020d4d00b004a621e993a8so10080712edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8i/WK5WDKl3YN3JBPYbZztdEmPTBn08cMGx5hPood4=;
        b=cZnEB9p9Pz0nSB06JAlWcDXzyA6WyXGkDkRBoviUDXqZ357KJtFGr2jClJdpQe0jAG
         3jF/l5p+WO1yB/Hn9jLPLm8XBSj5MSMZRdHMijcyLHftg0jkHm+kMAgojNm9XvK2uBBW
         qxz+0Vb0J+c8xocZHuAt8Ep27kzRoZ/45k5tHLoAAEnYF6VSRiDhwQ0eLVBrNvA5ZkmV
         ejg/9nP3YuTLIiiGnRcr5CxAdTjgxgJMxIt44vO5XuQO5agwaOhxP2b//PUiWc4//Hwb
         H1OmxFX0m+LENEZ6/xqcV/eN4rMn5RSHwFFyICPvc3YOCuvRXjjNBAIZ/KpUzjx8jsS/
         atRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8i/WK5WDKl3YN3JBPYbZztdEmPTBn08cMGx5hPood4=;
        b=XZMsRhvAvuPdhR69NUEnzwdGy+o9bhrxEHs+SwFuWXfvari/k5g2BSHwBdcUVvSIOg
         D7pYhZ12ullolhfPJZUmmZGueIosWzUEBo2ForsUO1wq3TaO8r7y1YIdBlqk9KDQoBmE
         monT2vIhBfhpqGZBT6KcSqfDfFL47RD7hPMLKbKRBV3PJ1Jbc7DMFr+MpoaViqCD0X9z
         wixAq1stn/tVTZpl1mFeU58vZFQaqwTqdrclcT7Nmhq33OOeeKCNYFIb8w66I84ybrz3
         4aAhznpoeU+8ApFEd0MBUbu9TrwoutCfJhxgp25OK+NZXjh7x+IaAYXtfrPg4/7R5II5
         j9TA==
X-Gm-Message-State: AO0yUKUqAcFxy1GyMer7IOCK9HD5J3IZ1aV8X2S9jm3o+5xrFK21Jb8K
        I6N0Mg959hW4QGVph/r08ygfIW/eS17km5G280nVeAzrwaRAkorXKPvUae7jUOnt/jecRrM7LPA
        xQc9YA9byg1Wp9dEd2R/3gM0VlkWimDmzKY/5+KKHdMGTW0gH/Smg+aHMOuCMUUihTUo8MoZ+Qp
        M=
X-Google-Smtp-Source: AK7set8ltdrvzD4QI4G2la/6RrmITWIM2bXrDbWr+TR8suA5T1OZxb0XBPUAravS+cfn5N02JT0wV7D84N5w0g==
X-Received: from lux.lon.corp.google.com ([2a00:79e0:d:209:35a9:4800:d90c:e9bc])
 (user=maennich job=sendgmr) by 2002:a17:906:1c4b:b0:878:6488:915f with SMTP
 id l11-20020a1709061c4b00b008786488915fmr7746205ejg.10.1677064996450; Wed, 22
 Feb 2023 03:23:16 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:21:45 +0000
In-Reply-To: <20220201205624.652313-1-nathan@kernel.org>
Message-Id: <20230222112141.278066-5-maennich@google.com>
Mime-Version: 1.0
References: <20220201205624.652313-1-nathan@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH 4/5] lib/Kconfig.debug: Use CONFIG_PAHOLE_VERSION
From:   maennich@google.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <nathan@kernel.org>

Now that CONFIG_PAHOLE_VERSION exists, use it in the definition of
CONFIG_PAHOLE_HAS_SPLIT_BTF and CONFIG_PAHOLE_HAS_BTF_TAG to reduce the
amount of duplication across the tree.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20220201205624.652313-5-nathan@kernel.org
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 lib/Kconfig.debug | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f71db0cc3bf1..0743c9567d7e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -328,7 +328,15 @@ config DEBUG_INFO_BTF
 	  DWARF type info into equivalent deduplicated BTF type info.
 
 config PAHOLE_HAS_SPLIT_BTF
-	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
+	def_bool PAHOLE_VERSION >= 119
+
+config PAHOLE_HAS_BTF_TAG
+	def_bool PAHOLE_VERSION >= 123
+	depends on CC_IS_CLANG
+	help
+	  Decide whether pahole emits btf_tag attributes (btf_type_tag and
+	  btf_decl_tag) or not. Currently only clang compiler implements
+	  these attributes, so make the config depend on CC_IS_CLANG.
 
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
-- 
2.39.2.637.g21b0678d19-goog

