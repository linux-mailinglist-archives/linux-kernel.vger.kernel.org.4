Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CD864DBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLOMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLOMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:54:52 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B6023E8C;
        Thu, 15 Dec 2022 04:54:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id t2so6780386ply.2;
        Thu, 15 Dec 2022 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UmlOmP5OIuY96blSL/MNkEAEiqWxXnotQM20lgKLL9k=;
        b=e7S1edbY39wn4e7lJOdyFqfX4IAD0xN0tJVrSN9Sb1eM1MCzuBqfLy3P3kot2vKnKm
         nuizN+ItQxP+1CCKxJ1CCwFnMevgIm00wqdOHpzU4cEjrEMxUA2EXrp74W2g5fmDtjRz
         JFAGBLZ/eB+Oi7woE0xvrbB8oJKOVH/UMcGoFWAMg12BKVZdSfUYY657iJu6mNO9oo0M
         YJh/0FxbHCxmOXQgNuQFPo33+H3dRwKVhkaXBACImdX4SMzDeQ/xIdEEBGaFFax7EiDq
         l2DZW2b5ODbCrZK41nO6dbf4Z2IRXrt/X05vshf6+9El7Y7mm98eKJGmy5pVaJ9sGsZz
         jCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmlOmP5OIuY96blSL/MNkEAEiqWxXnotQM20lgKLL9k=;
        b=5fIO98vBz1fwFG/BCDoNEyCRta/q+174LEYhd6ui1v7eyFg+wQV6iqwr0+8crZw5rm
         BB957rN1ltI6xswie+bfWDcfGsSR+IwieGI7zo5oQfwwbOvNXTwM8ccmzHTIUgkhpZOp
         riQE+/gzV2tl5R/Z7ZxTii7yFo4nPDW76XiEydkM7gJ+4Xutz3zt5pPQi6NBke9u7vYr
         Qk44g/VeKEhC5uif5gUCdUSBOkCptaxDOcnYv/SwN6RX0vD4rmKx77NaUmNDibkby7QZ
         yBokgKP+RSGD3IKMayAqvhZjD2/Nf5guz8VyFyY/4EWy01BQGw830L+9kNTiBdqo5Lki
         DwMw==
X-Gm-Message-State: ANoB5pmUlinN+M+fjePP2xQ4ujrBNgl7W4R2aMCg+Mr4FwQePNjgbycz
        7ryyUot+jj/N5TDv6ltxkfs=
X-Google-Smtp-Source: AA0mqf6lIDWw9Or0jmdQnSDu4u9iSBEUFWCTjnP8gDPE0TpF93FvsNr1e4kLDvvyh58Gi97VJqyk7g==
X-Received: by 2002:a05:6a21:999d:b0:a3:d250:2964 with SMTP id ve29-20020a056a21999d00b000a3d2502964mr42458758pzb.40.1671108891309;
        Thu, 15 Dec 2022 04:54:51 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id c136-20020a624e8e000000b00574afdc0391sm1683406pfb.174.2022.12.15.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 04:54:50 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Update MAINTAINERS to remove "F: arch/*/kernel/*/perf_event*.c"
Date:   Thu, 15 Dec 2022 20:54:29 +0800
Message-Id: <20221215125429.99826-1-likexu@tencent.com>
X-Mailer: git-send-email 2.39.0
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

From: Like Xu <likexu@tencent.com>

In the v4.17 cycle, the file "arch/metag/kernel/perf/perf_event.c" has
been retired with the commit bb6fb6dfcc17 ("metag: Remove arch/metag/"),
which means that the last file matching the expression "arch/*/kernel/*/
perf_event*.c" has disappeared, update the corresponding perf 'F:' entry.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a608f19da3a9..a8a53da0f775 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16355,7 +16355,6 @@ F:	arch/*/events/*
 F:	arch/*/events/*/*
 F:	arch/*/include/asm/perf_event.h
 F:	arch/*/kernel/*/*/perf_event*.c
-F:	arch/*/kernel/*/perf_event*.c
 F:	arch/*/kernel/perf_callchain.c
 F:	arch/*/kernel/perf_event*.c
 F:	include/linux/perf_event.h
-- 
2.39.0

