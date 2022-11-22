Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5285263384C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiKVJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiKVJYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:24:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9243FB9A;
        Tue, 22 Nov 2022 01:24:36 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so11535105pjh.2;
        Tue, 22 Nov 2022 01:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8JJhKrnJnq6IJLlykHCdHSIPjJqB9EfI3hBa0xq0Z4=;
        b=ApwQoSk3UzPJuhdouqlGiHxWAKrD6pOmDT4dwFzyGbs3A7/SR2g5gF622jQdsP3JLY
         cPc2/2OrLw1jaQR3jaB1Oxzmq/zbtwR5yOvfGKpbMnn6KlDFwHW57OYd/sMzdoEycH1e
         uYiW5dm/S1PGbjgakOk7FgI3wzyrjky5pKOuvlkg6rRGSO71ehsIkpKxoa4eegi7Y/ip
         YSFsLDoYHB6KnX/FFadOGTFshDS57b9CwqKljn8eIyktEp9Q9bYDKgb1jzMmkmcubz65
         FKuc03AEl8Zn0G79sAhV9hCqrEVMnn4R3ZicatsjvmfXiFf0Rg7jREbfSdjLNaoVx6h8
         HgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8JJhKrnJnq6IJLlykHCdHSIPjJqB9EfI3hBa0xq0Z4=;
        b=p3XAviXVIUA++0MtR5zZm9Pn1m88h7x18RySSqpJhQziQVsQkjyChIvtZRfowhbWyC
         1CwxZcwV6Ojn1Ls7jaLwxtk8mX7Kj0c9jcPnVTnz3GXfWrKDD/I7eyjmxF6NafpgrSsK
         CLr472SGRRwV+I8QDfnsViBwcQ4Ny/2tXAsgAd/JwEr7Ksy64bBZn2OYbJrBnLwW0XWY
         puVb2GhTjvgsDFrOlvxKWjyVl+GQ/rGA1GE2o5zdpwAhCvSwZhmXCMTRI8Qwx6c1xAVw
         XzumedKz+iT1D2smE0dD1xANnnvCpv7BcjMqKxsLVbfZKM2EVdulQCMqYm++NC8I/+It
         mKPQ==
X-Gm-Message-State: ANoB5pknnIyifsAL+ZwR74JVdI8aITrfJ4cPV3gnVcuq/6XOv3ojUnC0
        WUb20BgwMYzr24UJTQ4Jn2gS19tUxaA=
X-Google-Smtp-Source: AA0mqf7/zp4lIFi/fI8JMT9QscNTXT6F9SMwB9Q3FaO9A34ebbKbaO/+/n3Hr1gKQpX3YP7vsip75w==
X-Received: by 2002:a17:902:d091:b0:187:337a:b692 with SMTP id v17-20020a170902d09100b00187337ab692mr2899058plv.166.1669109075733;
        Tue, 22 Nov 2022 01:24:35 -0800 (PST)
Received: from debian.. (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090abd0d00b00213ee5a12c9sm9126826pjr.55.2022.11.22.01.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 01:24:35 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Stefan Roesch <shr@devkernel.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] mm: fix indentation of bdi sysfs description
Date:   Tue, 22 Nov 2022 16:24:20 +0700
Message-Id: <20221122092420.19363-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122175057.52f0cd9f@canb.auug.org.au>
References: <20221122175057.52f0cd9f@canb.auug.org.au>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786; i=bagasdotme@gmail.com; h=from:subject; bh=2zvRF+e1ifZB6Yjvr2jerEU0wt9FSzO7N8oT7Xykiqs=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMk1U118/zVJuKZFp93M+flin/wNtnn3bqX+i8+dXJhkNokx Mi26o5SFQYyDQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMR/MvwV16wa8mn3f0GqrlHjyoU9S xSZktKNKrcPG8XU7eloHDgMkaGh48em88L3yx4VvUu9/8pAmffTWc/MfPo/rxvRpvyTjzPZwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warnings when merging mm tree:

Documentation/ABI/testing/sysfs-class-bdi:76: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-class-bdi:89: WARNING: Unexpected indentation.
Documentation/ABI/testing/sysfs-class-bdi:48: WARNING: Unexpected indentation.

These warnings are due to inconsistent indentation in description of bdi
sysfs symbols.

Fix these by following indentation of surrounding text.

Link: https://lore.kernel.org/linux-next/20221122175057.52f0cd9f@canb.auug.org.au/
Fixes: 93e6d447506d8a ("mm: document /sys/class/bdi/<bdi>/min_bytes knob")
Fixes: a0eef74439b213 ("mm: document /sys/class/bdi/<bdi>/max_ratio_fine knob")
Fixes: 3aafa9ff1d4f67 ("mm: document /sys/class/bdi/<bdi>/min_ratio_fine knob")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-bdi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-bdi b/Documentation/ABI/testing/sysfs-class-bdi
index b4ed0db680cf69..0d2abd88a18cbd 100644
--- a/Documentation/ABI/testing/sysfs-class-bdi
+++ b/Documentation/ABI/testing/sysfs-class-bdi
@@ -54,8 +54,8 @@ Description:
 
 	The 'min_ratio_fine' parameter allows assigning a minimum reserve
 	of the write-back cache to a particular device. The value is
-    expressed as part of 1 million. For example, this is useful for
-    providing a minimum QoS.
+	expressed as part of 1 million. For example, this is useful for
+	providing a minimum QoS.
 
 	(read-write)
 
@@ -78,10 +78,10 @@ Contact:	Stefan Roesch <shr@devkernel.io>
 Description:
 	Allows limiting a particular device to use not more than the
 	given value of the write-back cache.  The value is given as part
-    of 1 million. This is useful in situations where we want to avoid
-    one device taking all or most of the write-back cache.  For example
-    in case of an NFS mount that is prone to get stuck, or a FUSE mount
-    which cannot be trusted to play fair.
+	of 1 million. This is useful in situations where we want to avoid
+	one device taking all or most of the write-back cache.  For example
+	in case of an NFS mount that is prone to get stuck, or a FUSE mount
+	which cannot be trusted to play fair.
 
 	(read-write)
 
@@ -95,7 +95,7 @@ Description:
 
 	The 'min_bytes' parameter allows assigning a minimum
 	percentage of the write-back cache to a particular device
-    expressed in bytes.
+	expressed in bytes.
 	For example, this is useful for providing a minimum QoS.
 
 	(read-write)

base-commit: d45f43b2c12b5ec8492c48574cb015c63304161b
-- 
An old man doll... just what I always wanted! - Clara

