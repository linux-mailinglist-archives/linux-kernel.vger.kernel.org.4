Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49A5F9811
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiJJGF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJJGFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:05:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9538201AB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:05:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y1so2780337pfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nm7YKL49tk7wRZ/a00qBsDIN6e5MXIummpQ4woA5c14=;
        b=aQKkENST6CPEq0eO3HKe4qKzPkPrnjeUPOrb5SdGU2Ra0Gvhw4P3PWtN5kaLi8/TqI
         L8+PLC5sVLeEJwdGUwQvvYZHN+rzSdvK8Vjg22Kmn2Xrur8aE9yia3RWe3+y8O/4d/Z+
         rGaUijoc659F133JvbySVKEufaxvBy2rEbQoSwq6IRxPRW0D/cr9s5ZraJ1m2F695Bye
         Cphlv/J5fGJY+jpfT/DoVJeZ0jEg1EkRccyf1PVnqhsUxvmxpjoVjaW4mKftnN452UIv
         gVZcQmUVBffXXlZOX96tF23slqg+TSF3StTblLue5arE0WPYfAFy35sJDgwUx+xRNhoR
         ZXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm7YKL49tk7wRZ/a00qBsDIN6e5MXIummpQ4woA5c14=;
        b=V2PW+3rrjF00FkuVfup4RnmRuMb0/zulXkmUvvl/2zZn972wcJLHylICUAYkPQ3LQs
         +oo3CZOj7Inl4t8pXGBCA0/oSXuSMgo9YlUSU3oiTMft5IyAHTLDBNSfBdRRW+/iAqUu
         VWgs/oElHTTyMzsK0PVenxb0KOzVswKlzMha5qBbVJ/1GrgBrkRGg5XsYrubtgKu+rSz
         qU30Lx7X9ptBlrwv8i/xaKnDVno2hZbmQeVwC/M//5k1tMT7AgbYe61sjd+916H0vwpw
         KCfqpr6Fa4gq8WF8Y/rbqk7K69NvQiY5qIq24aB7N3UkdlikIUDNBwhrdLuSsXY2SH6M
         uaSA==
X-Gm-Message-State: ACrzQf01a7KpH2HiaVMDrVcT8m8JbN+mDU20tXUcMeru5oqpI+am0ltb
        6ASveKNgfx1mC4GSZxHQoXoueqxtYCj4Iw==
X-Google-Smtp-Source: AMsMyM5eqpRu3hcShDlRN0xT43nRbWeP6tnG5AhlUAtINev9Y4zNBPEifY6RuMia1cixXaChZEvSnQ==
X-Received: by 2002:a05:6a00:10cf:b0:563:34ce:4138 with SMTP id d15-20020a056a0010cf00b0056334ce4138mr6542532pfu.6.1665381923244;
        Sun, 09 Oct 2022 23:05:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a5-20020a63e405000000b00462ae17a1c4sm803759pgi.33.2022.10.09.23.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:05:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     amd-gfx@lists.freedesktop.org
Cc:     regressions@lists.linux.dev,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: fix array-bounds error in dc_stream_remove_writeback() [take 2]
Date:   Sun,  9 Oct 2022 23:05:12 -0700
Message-Id: <20221010060512.3064524-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5d8c3e836fc2 ("drm/amd/display: fix array-bounds error in
dc_stream_remove_writeback()") tried to fix an array bounds error seen
with gcc 12.0. Unfortunately, that results in another array bounds error,
seen with older versions of gcc.

Building csky:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:
	In function 'dc_stream_remove_writeback':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:527:83:
	error: array subscript 1 is above array bounds of 'struct dc_writeback_info[1]' [-Werror=array-bounds]
  527 |                                 stream->writeback_info[j] = stream->writeback_info[i];
      |                                                             ~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:1269,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/basics/dc_common.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:27:
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_stream.h:241:34: note: while referencing 'writeback_info'
  241 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];

We could check both i and j for overflow to fix the problem. That would,
however, be not make much sense since it is known and provable that j <= i.
Also, the check introduced with commit 5d8c3e836fc2 does not really add
value since it checks if j < MAX_DWB_PIPES. Since it is known that j <= i,
it would make more sense to check if i < MAX_DWB_PIPES. Unfortunately, that
does not help to solve the problem observed here: gcc still complains.

To solve the problem, replace the subsequent check for 'i != j' with
'j < i'. This is identical to the original check since we know that j <= i,
and it makes all versions of gcc happy. Drop the check introduced with
commit 5d8c3e836fc2 since it is not really useful and does not solve the
problem.

Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Fixes: 5d8c3e836fc2 ("drm/amd/display: fix array-bounds error in dc_stream_remove_writeback()")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ae13887756bf..9f568d618cd0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -520,9 +520,9 @@ bool dc_stream_remove_writeback(struct dc *dc,
 	}
 
 	/* remove writeback info for disabled writeback pipes from stream */
-	for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
+	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
-			if (i != j)
+			if (j < i)
 				/* trim the array */
 				stream->writeback_info[j] = stream->writeback_info[i];
 			j++;
-- 
2.36.2

