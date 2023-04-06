Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD76DA597
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238199AbjDFWLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDFWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:11:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D6A5FF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:11:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r7-20020a17090b050700b002404be7920aso40165985pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819102; x=1683411102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=;
        b=oJM5K77GjRqMv6Bpd41LC+NHvLVwDHVeu2rOMxPUtB9Igmf/Kop7pVnXl76pepMJQy
         b9vH/wn3kFN+cNfHVUkmK3n20RfdehkT94Z60l6/uRkfBAYmFuQujl0e1GVhxa4HDb6p
         763KisdDmgJ1+wvBHVgmAmlFIh3/BZ9+GQM2Vy2fGsqAWtLPjXu1vu4FT3toI4B5aUq+
         G774AR4WIXDbg9iri4cN8n36gzC0V90lSFDJXQJMthhUuj4jFZ4X/tXw5Hcw8UPsuGTH
         nrb10qut9SMXCO2456Eo2PwJ40uCiEj5ZZG6DEFc2WEgCOegoCRGKqTPqbeAa4kTkuAY
         xt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819102; x=1683411102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coZsMe54O2WSL+5w5BoY6nl+KvcdiCirzHOFGrcIRw0=;
        b=Kk5yMqtIB2ZdSbPGPtUTPivwCTHob+K2BcgcdbECmJP2f2Phtxw//gz9iQFCBLEfbv
         m6B9pOAaBkqHx1CJ/wafXHKHg5R4POwucJHrweLYjWjxztZR51C0/u9SMQF3Ockl5kk/
         oBunarWPajD/iAiIXLNR5dCAQkVOeNRQoHlaRQqp7DlgW5mBV/mT5D1lzVsDTDDDt3w0
         IEbAQu/j9jhVdfA9XCoi7/VHBF4OLfQYDESG6pQz7GyT6RG27DayINIKVnZaa2hjIAM9
         ulhT6ipzNuwN+5xhZ3TL3RADE0byalkQ1kGFXlbPem6BBheBFV3bBtIyq5N+L+ASWf1h
         EG1A==
X-Gm-Message-State: AAQBX9cPBTp3khmumBlwil3Sj2zTgAK05gvT8dg202kroNY8lEg31BJm
        Fqzn5dIBglzcIZe1UwR1WOl0/d3oeyI=
X-Google-Smtp-Source: AKy350Z9b02DnKIe8F4w9l9G+VBL5Gc07oMYUeX0T6YbRsAIQMypA0GOgfmY3OCYtWtHm5MC9FLfVg==
X-Received: by 2002:a17:902:db12:b0:1a2:afdd:8476 with SMTP id m18-20020a170902db1200b001a2afdd8476mr776461plx.2.1680819102029;
        Thu, 06 Apr 2023 15:11:42 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:d05a:228f:924f:be2])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001a053b7e892sm1807465plj.195.2023.04.06.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:11:41 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix passing relative address when discard zones
Date:   Thu,  6 Apr 2023 15:11:04 -0700
Message-Id: <20230406221104.992322-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

We should not pass relative address in a zone to
__f2fs_issue_discard_zone().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc0734e4fb92..84e2e558ea99 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4942,9 +4942,8 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 			    "New zone for curseg[%d] is not yet discarded. "
 			    "Reset the zone: curseg[0x%x,0x%x]",
 			    type, cs->segno, cs->next_blkoff);
-		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,
-				zone_sector >> log_sectors_per_block,
-				zone.len >> log_sectors_per_block);
+		err = __f2fs_issue_discard_zone(sbi, zbd->bdev,	cs_zone_block,
+					zone.len >> log_sectors_per_block);
 		if (err) {
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 zbd->path, err);
-- 
2.40.0.577.gac1e443424-goog

