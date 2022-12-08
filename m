Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61D1646F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLHL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHL7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:59:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA183273
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:59:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t17so1391289pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 03:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xH94kFWWuqIK3wIDtIngHE1upupdHVcUwiddW+2xMc=;
        b=N4sDHPjbLCFDqetvJx59bP1Va8x+mS9eu+FPO0dV6/8aB89WuWUMyKP6y1stK2Kyob
         yZXnl82/DG0u1pCETafI2/evTJ1lLmEziBswJQSA0pOdiKliMCHRd7emwDnjyi2DXGnH
         oWy+bVRbfMWi0iELesdhFjVcjkWfzt42FrGraNAprvzDvJwwvhFMthUuj9yGlHTefZCd
         OeUNouaZ77xyrhSfNKRPkudJw3TnhdM8UHgEm/Viepq5Sv1ulamdTZnrYS2HbHYTfcRi
         8NdWr3eu1RzECoN/hYWzJ4pglfWdqIqwc4gOGxMZg0wEqX1XzxJ44fSTcFrZ++ONFyZu
         Hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xH94kFWWuqIK3wIDtIngHE1upupdHVcUwiddW+2xMc=;
        b=R66oqyjyp9yUh204Ek/cshYrSR4aY+KPRTjF5YdsoS/7uxWTLq8bsXWBKHfB5ZcJYm
         fOLrNF+jZk4sBhjxCJDIHwMYkP7A8GkA/8ZHE8hMv1E+HHJ/x28xJzclFiWk5ktc5wwH
         BApdvzi0uHBEIF3CkqvUNS2Xmh3kDw3QOpl2iti8rq9VY50SNWqdmEGistnfeeRQ0RId
         FXS7Y6/SqqMTnueaGotgbOfhguRN/aeDNkdFe3bzDZVj8X4tPi5ICb3vBf3KuZZ9U6iB
         vtbeYhtOaEjBdXJX5yV9e+/sUQBWsW5WsNuI4zh06iEAa5+lZ22eC4GDHrwsjolW3mmi
         JTTw==
X-Gm-Message-State: ANoB5pk39nHb2YvcGnV55aKYzUlF3eHEpFEIVHjGQs/N6RL6T45J6rhJ
        C4RozD/9z/K+u7lWYtssnfO6XI0TPEqccEbIVIs=
X-Google-Smtp-Source: AA0mqf7WzrYvIJNtScflldCYQTS0t2XK4D8Ta9g67yIs5EBt+OIgIs9YEt8UmaD0jibwzKPEauogLw==
X-Received: by 2002:a17:902:b194:b0:188:612b:441b with SMTP id s20-20020a170902b19400b00188612b441bmr1889523plr.65.1670500779912;
        Thu, 08 Dec 2022 03:59:39 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b00174d9bbeda4sm16373514plb.197.2022.12.08.03.59.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Dec 2022 03:59:39 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     muchun.song@linux.dev, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] MAINTAINERS: update Muchun Song's email
Date:   Thu,  8 Dec 2022 19:55:48 +0800
Message-Id: <20221208115548.85244-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm moving to the @linux.dev account. Map my old addresses and update it to
my new address.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 514a5a6c264d..ccba4cf0d893 100644
--- a/.mailmap
+++ b/.mailmap
@@ -374,6 +374,8 @@ Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
+Muchun Song <muchun.song@linux.dev> <songmuchun@bytedance.com>
+Muchun Song <muchun.song@linux.dev> <smuchun@gmail.com>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
diff --git a/MAINTAINERS b/MAINTAINERS
index 997e75dbca5c..b44cfa7f8ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5372,7 +5372,7 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Roman Gushchin <roman.gushchin@linux.dev>
 M:	Shakeel Butt <shakeelb@google.com>
-R:	Muchun Song <songmuchun@bytedance.com>
+R:	Muchun Song <muchun.song@linux.dev>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
@@ -9552,7 +9552,7 @@ F:	drivers/net/ethernet/huawei/hinic/
 
 HUGETLB SUBSYSTEM
 M:	Mike Kravetz <mike.kravetz@oracle.com>
-M:	Muchun Song <songmuchun@bytedance.com>
+M:	Muchun Song <muchun.song@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-hugepages
-- 
2.11.0

