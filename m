Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71F609057
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJVW4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJVW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:56:46 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4A83F0E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:43 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o13so3476448ilc.7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=imJjz4YUqkUgXSc3EF12M37WxP4WbL+hgXoZMK1cg2iq0IzawOyWw6yY0b3M/ycF0F
         vJOkRIn3dyOuYiVxlWQvdQVaZG7QMG1g5iZwrWS1AZBdA02KGc3R1/7/9Nz0s79qYpZk
         tNXzRrxkTuAlEnyYwa+ni/w+C6ZQD6NGU55xBypZidVON8hhDa15OoHa+URAmKeAMP18
         uE03ABYJ/pv4Y8fZr4byStUEd1jslLOP+73mzSj+BjHUnELns8am5sV7Pe6lOJ/ZaFDX
         9JFfsC8NXkQN0kgYYHRWh51m7EZb5uFRFSGgwEnHlBSAGEXaNKjM+p++NUAN9HArfNX5
         +R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORhdzvQEaSdepN8FuCdBMVAeS8RbuY3+hyzMb2MUCmU=;
        b=MeWUh+mQxESe4GKebthmWmeToxa3g1DDMWhwGm4j9LJH5AT1zzkwza5eZrLNkfjd7t
         zGPgPTSefF7wAQ9qxjc2FJwk/tGuyzTt8Mgk2wNec+FeNctesX6GL0GpLHDNuuChEcsf
         QUetQJBX2hLPdiAx82Sw3R4W4TjhGGDAg4y5ZSwHe8lBocnrLovJITlpiTwtigGBHdNU
         A70PCEEurZVqA25H6U8xOIPRIWgKieE4I09dgxsBltQceQwQThjMLm3tpy5DAEAgN0lu
         2FuXpzJNUsPklTekk23zQlZQ3mxIwE59fhGNZchGKaG4xO3gcQwz5kuvljwdSmDZa4hp
         rPgw==
X-Gm-Message-State: ACrzQf0MC5SextgffhTjCBYvT65OOtytqj+XGwdX4oFPP2wlIoUTYK5J
        3s/UUVZWxMY9dCj/zwXA0JPtZaSCgQw=
X-Google-Smtp-Source: AMsMyM4vCHNb33AtOmVIoTD5q4sFV6dSkD3WlWKG9A8mqgbL2E+mc+pts+tNYj7eQH58cgNtisUgdA==
X-Received: by 2002:a05:6e02:1b82:b0:2fa:f88f:7434 with SMTP id h2-20020a056e021b8200b002faf88f7434mr18313844ili.191.1666479401951;
        Sat, 22 Oct 2022 15:56:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o9-20020a927309000000b002fc323a2902sm2492267ilc.62.2022.10.22.15.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 15:56:41 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] vmlinux.lds.h: place optional header space in BOUNDED_SECTION
Date:   Sat, 22 Oct 2022 16:56:37 -0600
Message-Id: <20221022225637.1406715-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221022225637.1406715-1-jim.cromie@gmail.com>
References: <20221022225637.1406715-1-jim.cromie@gmail.com>
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

Extend recently added BOUNDED_SECTION(_name) macro by adding a
KEEP(*(.gnu.linkonce.##_name)) before the KEEP(*(_name)).

This does nothing by itself, vmlinux is the same before and after this
patch.  But if a developer adds a .gnu.linkonce.foo record, that
record is placed in the front of the section, where it can be used as
a header for the table.

The intent is to create an up-link to another organizing struct, from
where related tables can be referenced.  And since every item in a
table has a known offset from its header, that same offset can be used
to fetch records from the related tables.

By itself, this doesnt gain much, unless maybe the pattern of access
is to scan 1 or 2 fields in each fat record, but with 2 16 bit .map*
fields added, we could de-duplicate 2 related tables.

The use case here is struct _ddebug, which has 3 pointers (function,
file, module) with substantial repetition; respectively 53%, 90%, and
the module column is fully recoverable after dynamic_debug_init()
splits the table into a linked list of "module" chunks.

On a DYNAMIC_DEBUG=y kernel with 5k pr_debugs, the memory savings
should be ~100 KiB.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
? does this need a new name ?  HEADERED_SECTION ?
---
 include/asm-generic/vmlinux.lds.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9f6352171f88..b3ca56ac163f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -195,11 +195,13 @@
 
 #define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _s_, _e_)		\
 	_s_##_label_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
 	KEEP(*(_sec_))							\
 	_e_##_label_ = .;
 
 #define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _s_, _e_)		\
 	_label_##_s_ = .;						\
+	KEEP(*(.gnu.linkonce.##_sec_))					\
 	KEEP(*(_sec_))							\
 	_label_##_e_ = .;
 
-- 
2.37.3

