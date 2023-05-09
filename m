Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA76FCBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjEIQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjEIQw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:52:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F9273D;
        Tue,  9 May 2023 09:52:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e24b0193fso4570087a91.2;
        Tue, 09 May 2023 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651146; x=1686243146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYPARB+FDAPIC1iGiHJac+PhsLJC+b/BHISNxMUhiko=;
        b=n799oQATYUag4eDiYJhr8B1dM/lNGI3pIIxyzovxfYBMpLepeGRVwP4MwQgVMSza4b
         Ik0qlmfXn2oqyxLYWgkhYqHaQjalTOhEGXBMhxURAWRJdRGGzBktpIEBoszSpLSDA8WL
         5Ri63AaddJsbrP7RaI8Svcs7XOStHu4NWdEor00MZWmSU/L/bbupiyh2Qf4V5wqtdHU0
         ob01+KdLekC+oEqMaxr6Ka2LiL3VVR+l871kBRjEfVTw3Dk6JS0B52FfPZ2WW0k3yROM
         ftHMsuabGvc3aiB22md5dTpSHocqULG7T6s2vde+OXITuAVje7cdUmv9d1a9r3lNM7g5
         5Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651146; x=1686243146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYPARB+FDAPIC1iGiHJac+PhsLJC+b/BHISNxMUhiko=;
        b=P3t5Esgvat+AfDMpBsoNQ4kA7vg2igyJdLv6aIDdAKFRTAhzTGLzFGEjWSdd4yDXxS
         bAItyHQAFijVBHf9QIQdY5QI3PhjFL2q4j6TpeXsiQY+aNRM3PCMDokTOFYykWvMR3zI
         S4skh0i2NfebQXLbX9eKQ6pwmgyvsyhcA+oOjCUqPDxZO6GuU1uXscz1aS2YO7YiFK3j
         X1ZFB3qU7BKCD0JyBFdzy7VpllUqPoKL0UA4k9d01N0ve9KB0uRMlhlI5Q7m11Bb9Qw7
         xbtb41kl8xBa6UzwTyD9trm4b3fHcj/2bhiy4Be3gYyCWkUze74IuODDH1i95n/0fm0u
         YyNQ==
X-Gm-Message-State: AC+VfDz7zOJwN3IjW+m4iyjTRyylFSDu624cI57Bbs4lo3wpDwFrPmMT
        WYcteDCPUarLxPNj5X1prJJ2y2QjgbY=
X-Google-Smtp-Source: ACHHUZ5gp2GYnnrwRr3gmTuF/ijx0wQLzeHKD0EPd32YNR7fxTdPXlxOkcEjav7qCTJhQK4gipOdeA==
X-Received: by 2002:a17:90b:4c8d:b0:250:9d96:9999 with SMTP id my13-20020a17090b4c8d00b002509d969999mr5217781pjb.27.1683651146159;
        Tue, 09 May 2023 09:52:26 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id lw6-20020a17090b180600b002505f8b9c53sm5503986pjb.38.2023.05.09.09.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:25 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Fixing check patch styling issues
Date:   Tue,  9 May 2023 16:52:15 +0000
Message-Id: <20230509165218.139568-1-raghuhack78@gmail.com>
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

v5 changes:
- Updated the missing reviewed tag in "cxl/mbox: Remove redundant
  dev_err() after failed mem alloc" patch (Dave Jiang)

v4 changes:
- Updated the respective patches with reviewers tags for respective
  patches(Dave Jiang)

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

