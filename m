Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF45E58F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIVDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiIVDHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:07:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79684A2637;
        Wed, 21 Sep 2022 20:07:09 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c24so7547912plo.3;
        Wed, 21 Sep 2022 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Tm3wrEigpwVQPgTQHOrie8IO6Eqm4KyU1Upk9ggQSA4=;
        b=FHVYxNzdpIDSx1JOQJQRPdaj3OaseAuUkuNofy+hxm5Ebj33t85qEvpZCGt5DRN9ku
         Xf13LHSBKJRIaf7KVl+5hbB7vtt++PUguO9PNw7tXlqvYrFgx2Ja+qw2nOb1L2uSDjti
         O3XXxH9SUorSMuWWYsablPN93ZN14pLNP3auFkHsEMAuxEMPnLzZTfO2Ipid3/6CV7Ed
         4dYYFrDXOuAWQmJXNN2mos8TxQpexBmhUQdx2/zTFcaAhXDJQqZLekm7amIwM/xdQ59A
         xtYmsWjNUPD61WT9590Fk9NyjjanbT0AV7OaFj11aQfRfRXSDBR2uwTCgnHpJCoI47Np
         QsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Tm3wrEigpwVQPgTQHOrie8IO6Eqm4KyU1Upk9ggQSA4=;
        b=XEA6feBxx34dUun9hgIFdEjWL6IYXhpO6pYIlwW04bedR9E0hpf6cT1QC2/W0Ae5vS
         /KDEAXiNg1fbQqbRGtzlujmfEsHWGXTBDLwfpznhnGSZUWvuAkc3AhUd8+2Ouyy03/0l
         Vy4LUzO8U8iSt1Ys2oq9IaAF2bRLc3CpXQ94wz4w/tyopOI5glL4aKgqdKqEoVXC+SqO
         laqmHzO0yfx+OTwwulftXBTTOv+RhCKTPZ5UQhVfkPJc7aw5MshR0tyXEse0clcjKFFG
         Xhcm8Bkk3ARVka6XmgC2dR5owPxnmKEfMjtdomHZT4S9k1s+VLiqiUdyS6Ml7KbwOoPO
         r2tA==
X-Gm-Message-State: ACrzQf15Ob6G46h66pJrHEZwBVwvgMKOD6lQ4qoU2S5YQVP5tC84mrfg
        bwSZYKeL6WK7MVjRBmFh8ZdeYNQWBlcQXw==
X-Google-Smtp-Source: AMsMyM5TE0GkdL7nr3AlfTWoVVHIUXVpm8Nenvh9GihYq9oBpQRAgBn4igRi9lKL2W78aFcn1awrLg==
X-Received: by 2002:a17:902:d40c:b0:178:4439:69f9 with SMTP id b12-20020a170902d40c00b00178443969f9mr1224379ple.118.1663816029006;
        Wed, 21 Sep 2022 20:07:09 -0700 (PDT)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id n36-20020a635c64000000b0042ba1a95235sm2595198pgm.86.2022.09.21.20.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:07:08 -0700 (PDT)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     mike.kravetz@oracle.com, songmuchun@bytedance.com, corbet@lwn.net
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: hugetlbpage.rst: fix a typo of hugepage size
Date:   Thu, 22 Sep 2022 11:06:45 +0800
Message-Id: <20220922030645.9719-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.37.3
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

should be kB instead of Kb

Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 8e2727dc18d4..19f27c0d92e0 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -65,7 +65,7 @@ HugePages_Surp
 	may be temporarily larger than the maximum number of surplus huge
 	pages when the system is under memory pressure.
 Hugepagesize
-	is the default hugepage size (in Kb).
+	is the default hugepage size (in kB).
 Hugetlb
         is the total amount of memory (in kB), consumed by huge
         pages of all sizes.
-- 
2.37.3

