Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC362E2B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiKQRQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiKQRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:16:45 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C1C786D9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:44 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id h206so1843088iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wlb4nC9DiXpO42QAvf6JoYYqoUdGTO9JI9f6xMWbJYA=;
        b=awTeIDv6fg3KHIIIrRiWuAGtdhW00GmDoj4Wnpn0OOhaVTbA4ZxNVZWHvmD/RSWWwn
         QSZ8dJZis0G7sL/0xt9hR1po6coA0mHVOwgRrPQUuXW04PyrVlhk5CU24yyKGQuMRidI
         kU+s0/UCbgNdoDlAXyjcfqYFJS4tt8UuHd8w5hspXqKLg2+DkKf7lLq+07ETeGsDCrOr
         LQNwiJ6WcZFaBD/LTZXRvjwPPiQuM1Y+D6YVEJNv2urkcJRVRGJ0+x4jYqCdVDDfc5yo
         7kp5ZB04aWLleSC476bymda6lNDdPQ0IymleoKlXkXQNXN04lofzu1FXEudfPCCfNEZD
         K0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wlb4nC9DiXpO42QAvf6JoYYqoUdGTO9JI9f6xMWbJYA=;
        b=felK7abin8ZmY6fPNFu62gJ+fLTvgdh5ERpcijzJQ55AXV206U+z/QUew7SlHqVBB2
         8S5UHoKtFjKqqvVir49CJK5oZnxR99Ar22teof0DvtnsImlLrk6NbvjDIL0wXqyy18Uz
         wwH+MTSZmeOSKP/JveuUQDltexXyfaM33Qx/Kriwbe8DhpVmoqrweeI5wjIq/rzA1I75
         2IPf4qctSLCegR9Rb698lK9qR52W0UXzG/Ek5s7S9sIF+qi9ROKJ2tgm7+GrKzS5cpQX
         sRFkD0rTeqUCoat0TCFYLEuHZ+At4E980x2toeoFNL/ltBSmlrizrFkF350d4H0mV0zR
         bMkA==
X-Gm-Message-State: ANoB5plEbiGkfquyGdb5xS2mn5CQTzk01XgRyuAHVJctCG7d2TmXAIL3
        WLiDFtOY6I144JLxLF0FtaI=
X-Google-Smtp-Source: AA0mqf6/UwSv2HIQjy4BOxI3VoRGYVYxR6pVWI++hEqbk7GM3RSWNmA8aY+EOmEBnSkFViHId3WLcA==
X-Received: by 2002:a05:6638:4308:b0:376:246:e637 with SMTP id bt8-20020a056638430800b003760246e637mr1517322jab.260.1668705403314;
        Thu, 17 Nov 2022 09:16:43 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o1-20020a92d381000000b002faf6559e90sm495322ilo.51.2022.11.17.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:16:42 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] vmlinux.lds.h: add HEADERED_SECTION_* macros
Date:   Thu, 17 Nov 2022 10:16:33 -0700
Message-Id: <20221117171633.923628-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117171633.923628-1-jim.cromie@gmail.com>
References: <Y3XU59mj80wvTD6Y@kroah.com>
 <20221117171633.923628-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros elaborate on BOUNDED_SECTION_(PRE|POST)_LABEL macros,
prepending an optional KEEP(.gnu.linkonce##_sec_) reservation, and a
linker-symbol to address it.

This allows a developer to define a header struct (which must fit with
the section's base struct-type), and could contain:

1- fields whose value is common to the entire set of data-records.
   This allows the header & data structs to specialize, complement
   each other, and shrink.

2- an uplink pointer to an organizing struct
   which refs other related/sub data-tables
   header record is addressable via the extern'd header linker-symbol

Once the linker-symbols created by the macro are ref'd extern in code,
that code can compute a record's index (ptr - start) in the "primary"
table, then use it to index into the related/sub tables.  Adding a
primary.map_* field foreach sub-table would then allow deduplication
and remapping of that sub-table.

This is aimed at dyndbg's struct _ddebug __dyndbg[] section, whose 3
columns: function, file, module are 50%, 90%, 100% redundant.  The
module column is fully recoverable after dynamic_debug_init() saves it
to each ddebug_table.module as the builtin __dyndbg[] table is parsed.

Given that those 3 columns use 24/56 of a _ddebug record, a dyndbg=y
kernel with ~5k callsites could reduce kernel memory substantially.
Returning that memory to the kernel buddy-allocator? is then possible.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
---
 include/asm-generic/vmlinux.lds.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c17f94785253..c9a475a30803 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -208,6 +208,21 @@
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
+#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_HDR_##_label_	= .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
+	_label_##_HDR_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
+	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
+
+#define HEADERED_SECTION_BY(_sec_, _label_)				\
+	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+
+#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
+
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()						\
 	BOUNDED_SECTION_BY(_ftrace_annotated_branch, _annotated_branch_profile)
-- 
2.38.1

