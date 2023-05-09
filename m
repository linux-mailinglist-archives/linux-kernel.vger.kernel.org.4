Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6E46FC332
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEIJut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjEIJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:50:26 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56190D9;
        Tue,  9 May 2023 02:50:25 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so41093170b3a.1;
        Tue, 09 May 2023 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683625824; x=1686217824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpHqB1C/P0ODmloRTkBUYjFxBRGC705v3QDRT3fRYTs=;
        b=r1eHqu1dw4xbs3AkMn+R0MqCfekbvg+F8DEcfNQu6JG3ZmWQomABCEW9rciHTNxw5v
         izFwnS8odfsvpQugRJnSD7xs0HRpBgZFJnWT76NU20L09VZpTDWXuMcOWKpLdxWb4+MS
         42qeaI/7QedvphiZt1t8tXvpPolM9yoqrz1hl38vvbhTA1EeZgQIF3aXV4PV+LqxOQf1
         9SZ2bdykKmPveMQ53eR2kjyWBOuFw5QRefYan0pwnJW8xqYCYIjAFe+MVptfMx7lUZc9
         uqvyPlXnZyZm3OGl82mms6jo8xL+41ya7nO70GaXmA6GSkLyHkDt0lnJ1UwKDrI5mJCJ
         /svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683625824; x=1686217824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpHqB1C/P0ODmloRTkBUYjFxBRGC705v3QDRT3fRYTs=;
        b=ZSme2oIbNpBzXoX9J1l6q/ZN56pq6n0sHFr9x598LZysneT4RyuZts8XCEu5I1/EJN
         05bYeIz3C76lR8K95I4kd04R/qxKLyqUCFX1jbqXa4vsJBrRFsA9DclGn9GFnJY+JajR
         nEBeQ6iViosjP3fP+7PD1RFgaXfodv55oJJvGrSUW3azg630AjfOGghGr/+9SpQu7YT3
         HkMWUNDWp0EDi/EOWBOpnJf/J/rhY+WogehUfr68NRYV6Kdv8mbLhFrPjO3IyhAQl0GH
         Ee7yt21mo7+s+IVe6JLy7PTg3Fn4U29CNYJNFaLUHWhVZ7c+VC130wxmOPIzdHLUjoDc
         gNYQ==
X-Gm-Message-State: AC+VfDy2St259Rd/dpBWODz0mOeQR5C0FnUXWXG4qz1jO9nBq6mB//Lp
        rkDUVqtE2XRMcDNONg9Z6lLUxDOl1AY=
X-Google-Smtp-Source: ACHHUZ5oJndAhNNdvHlVegIPiOssD/deQWFoPGVaEvuWHtKfMyofHZOG5RbwoQU2lghlJvdlO6oyHQ==
X-Received: by 2002:a05:6a20:3d91:b0:f2:e20a:c8f4 with SMTP id s17-20020a056a203d9100b000f2e20ac8f4mr14703954pzi.31.1683625824437;
        Tue, 09 May 2023 02:50:24 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b00571cdbd0771sm1361998pfh.102.2023.05.09.02.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:50:24 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Fixing check patch styling issues
Date:   Tue,  9 May 2023 09:50:14 +0000
Message-Id: <20230509095016.138890-1-raghuhack78@gmail.com>
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

