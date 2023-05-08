Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5996FA231
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjEHIZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjEHIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:25:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B161CFCB;
        Mon,  8 May 2023 01:25:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aae5c2423dso41727745ad.3;
        Mon, 08 May 2023 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683534343; x=1686126343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pyFK5UrdspkzOxfeQrbNUYCVL5SWjB+7sHgXNn87wM=;
        b=ZnTDU5UlUypgjlFsIhPqVdp/u8atpbTXSozUFcJOn0Bh9xlI+ZylDPqrrlLlcxpNrh
         4lo22/NA4H586IAD0y+bqDbTbZJxEiW99NlZar/ZjWgCUMzWgjD32PrPhlwih45c0+7l
         j4kEj5H1MCszviFs/pR4AOstcDmwaHxkQmRYgBnH72h6KSBvHDr2qtbhQCSjhcQDOWOx
         26NIAWCrMUZZpoZ8keMa92dKlnQ14ri4Fztyw2SaNaujqekxykcQrlcs9wszbCvmpOe0
         nD1k4eJ6qjAH1HkvTgJFGVEW2Spi3EhW5Xis9g9Gnwmhbm9uwuST8KoUPH3R1ZSyRRky
         FPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683534343; x=1686126343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pyFK5UrdspkzOxfeQrbNUYCVL5SWjB+7sHgXNn87wM=;
        b=VX85KCLjJYu97auCMLahREJFEHuslaKLkxLN6uwGrFnWNV3PKHvsl/tFAhG9LXP80e
         58Oi/z2T6NmGG3Ch+Rgc83mEEPQyKvdJa//fuYjLlorCYEkKi/WbuI4frO2y/dI9uYS8
         LzGuN6Qzb+xTcFJCsFACnolOjLrkaLkzOeor1U6EUrmIJNWoZoOoVX/bDwR+Sa4DZlUa
         pEt/fQfIZY8QpnyLefCyFXMpvzTXakba3yIzM/0wSQJK4N1p9MruhBQIx23H8NEpIO5A
         65Xt94QiTaqq5bKM2oPmtsZIpDBTLRwBkMQ6O5UEabqJxaoMni5tDBlflTWoi8UzUpQI
         o4/Q==
X-Gm-Message-State: AC+VfDypD2KMtXxpELprPammm57z6g5cytJ69rSuLYgM9ABfRNzgPEKa
        u52H7un5lqftlw4xg3RtSxSUphnL4Jc=
X-Google-Smtp-Source: ACHHUZ6Jm+eD4xs2UCPFuDlauaPRQzMGRBPhk2GINWrHWfiiEoSYenh9C4ZNUTvC4fd6HIskef7XvA==
X-Received: by 2002:a17:902:9349:b0:1a9:4fa1:2747 with SMTP id g9-20020a170902934900b001a94fa12747mr9006870plp.47.1683534343103;
        Mon, 08 May 2023 01:25:43 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b0019c13d032d8sm6497933plb.253.2023.05.08.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 01:25:42 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fixing check patch styling issues
Date:   Mon,  8 May 2023 08:25:29 +0000
Message-Id: <20230508082531.136281-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 changes:
- Update the cover letter and commit message with full author
  name(Fabio/Alison)
- Correct the "typo error" in commit message(Fabio)

v2 changes:
Thanks Alison, Ira for your comments, modified the v1 patches as
suggested.
Dropped the patch containing tab changes in port.c

v1 cover letter:
The following patches are cleanup or fixing the styling issues found
using checkpatch

In cxl/core/mbox.c, in case of null check failure, returning errno or
-ENOMEM in this case is good enough, removing the redundant dev_err
message.

In cxl/core/region.c, the else is not required after the return
statement, cleaned it up.

Verified the build and sanity by booting the guest VM using the freshly
built components.

Raghu Halharvi (2):
  cxl/mbox: Remove redundant dev_err() after failed mem alloc
  cxl/region: Remove else after return statement

 drivers/cxl/core/mbox.c   | 4 +---
 drivers/cxl/core/region.c | 8 ++++----
 2 files changed, 5 insertions(+), 7 deletions(-)

-- 
2.39.2

