Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5865FA689
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJJUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJJUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:47:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BC73910;
        Mon, 10 Oct 2022 13:47:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bi26-20020a05600c3d9a00b003c1e11f54d2so5979088wmb.2;
        Mon, 10 Oct 2022 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drTzHbRQQFHjsXnd1u1kp4ih15JnyJfUG9D4wGRNrUs=;
        b=dct34Sx87AiGlY8Xp6vKwc1341MnDHCxSGjj3S9sA7XG/iP2+AVcgRIfwC9xJH/YZH
         ai6RjnzvaHCY2OYGAoNs8PB0yL1SguDOc1/k1ALnrHSF2c9R5gVEVCNVl53TpxV199SD
         jWJzJrQG4psVbB2O8utqEY67tZo3H3TJjFLgdiFW/6qcw+Ew01ocjuFwj090/QHwJazF
         yNluEucdBpdv+PILc5pNThoWlYH3gTFukIAhlQoDLcMKueU9PFF4nIUGaxyISIbs3Rwy
         Okqi7SCxRhyJwjZCV2gSbZOV0VBprycrmHwLa4sLkdX0CL/qzsO+HxsWzdRiLo58iJJP
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drTzHbRQQFHjsXnd1u1kp4ih15JnyJfUG9D4wGRNrUs=;
        b=YhKhgOhABi0tMgXSRFvI86c800CQluIEQZfPqPOPjAddFMPTIxThpkiGTRpPKmQfqp
         m76Spn/RmXmeSK5/amCCtkFlO53DtUBCCssZ+doHW+Crx/uv38sAaSqIea+1eXzTxfUh
         Qir9fMECVDfo9Hr/jDwiCro6k6yJB4A0C1P3zlYAcu42HUjUNQ+VmqM5Lnj95ugDZqVw
         IzFLTYVUoZCk/1u4hX19D/2m0Zj06T4e7rzSXEV6LPoQQVW0Jl7424pLK6YZdbmHV0hy
         g+oVDPT3EYKdIrLPG9E8XztIurLOQJYtpPC0W9kKVaEtkqL5INbCIr5JTMPQ4Yf4aqrV
         zTOw==
X-Gm-Message-State: ACrzQf0mXAHed3q88LyaMTRf0NCMb8X+cAPSlL1eq0PFFgUEKprwmN3r
        1D6r95RI7jwMfwdqCaIAW/8=
X-Google-Smtp-Source: AMsMyM6xCxEtZkXB/efTvv/30iDgPyBDwxRAGDYlofDt0x7tiEaSblSnily8IOo+14djeFH41booPg==
X-Received: by 2002:a05:600c:1c1f:b0:3c6:bfda:d485 with SMTP id j31-20020a05600c1c1f00b003c6bfdad485mr2571521wms.59.1665434865104;
        Mon, 10 Oct 2022 13:47:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y17-20020a5d4711000000b0022e47b57735sm9560955wrq.97.2022.10.10.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:47:44 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: Remove redundant assignment to pointer p
Date:   Mon, 10 Oct 2022 21:47:43 +0100
Message-Id: <20221010204743.3224265-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The pointer p is being assigned a new value that is never read. The
assignment is redundant and can be removed.

Cleans up clang scan-build warning:
fs/ufs/dir.c:179:2: warning: Value stored to 'p' is never read
[deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ufs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 391efaf1d528..bf19cd882965 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -176,7 +176,6 @@ static bool ufs_check_page(struct page *page)
 		   rec_len, ufs_get_de_namlen(sb, p));
 	goto fail;
 Eend:
-	p = (struct ufs_dir_entry *)(kaddr + offs);
 	ufs_error(sb, __func__,
 		   "entry in directory #%lu spans the page boundary"
 		   "offset=%lu",
-- 
2.37.3

