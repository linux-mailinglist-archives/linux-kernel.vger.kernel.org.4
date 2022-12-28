Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A365750D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiL1KEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiL1KDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:03:36 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ACEDB5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:03:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id ge16so12109964pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZR5Lk2p6F6iFuRFOmyJe5Nk54JFtY0MngXtWbJ9xVs=;
        b=Isp/wP80yS1tT/rqZ+sZ2C7KiMwvaP0ZdU7RxLpMcTiV+uHZGI9BpPfIyTkpqmhvzr
         35ac/i+folEILmnpTAoSxhbbi7buXvAP1c+PjerD4pUMULClg+DhxoA3qXduuffh/chj
         ezrtGLtvtwv861WQlDk/le+GiKaaYqHYo9iJNcjbRbZrxQt3xCCVAe0wX0kbI0pTkHQR
         Unxf1hnmPhBH71NWHultxupDT/plwfhzy7FtCI9X+loo+42B2y18GVnZFoZFXose4pJr
         RB27dXg1dQ0q1m9FALN01bH9dA1Zo2tMPjAGTqvk68Q8cE9LTTQ7EIACAdmgVYJl2yz0
         JJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZR5Lk2p6F6iFuRFOmyJe5Nk54JFtY0MngXtWbJ9xVs=;
        b=3Ds8DsBvp9f+IpHrXfYJMr02ZqxVXoDF6qECkDQyCSFdSgCNT8RKyIV1n6gS2jsyDl
         miT0Xo637SvsXu1Blb0Osq657zL2eLVGSd4IHQJRDpBqnxlxWXRaml55+lOhCHutf+oe
         BA+0qvvo1dWSBws6IWCPtr6xmJTpQWHU2uzw7bg8Klo1eRq1UsO9EWXhlvGvc26TCMkn
         ddrXeEOF/QeRqhRGPl1RnPXh+q1khRiDS8uzItGArH7eklOH36oR/mZkpNGWwt4hsShN
         G03l2EZsatNtrzhFYNqr6qIAR5ibiero+xo33xSCKSJETDrUdPQxZyeAVD1jwG/vXlx9
         mR5A==
X-Gm-Message-State: AFqh2kpOdP6KI6LIBQbq4lQ77J9CmthnNZywaky3a/gdkfGpTbS2jZ8C
        tbEbBHrvBNqGwv+K/UyOWbQ=
X-Google-Smtp-Source: AMrXdXsTEaaGu8tGtQwafMiMyRCoS0Th7VtpwdcuzJflpeohl1DzYIEA5Ed3SgyepoqYZSM6A7UhaQ==
X-Received: by 2002:a17:902:e054:b0:189:fba2:3756 with SMTP id x20-20020a170902e05400b00189fba23756mr23059519plx.66.1672221813886;
        Wed, 28 Dec 2022 02:03:33 -0800 (PST)
Received: from localhost.localdomain ([185.216.119.110])
        by smtp.googlemail.com with ESMTPSA id l2-20020a170902d34200b001893efd3e03sm10691385plk.119.2022.12.28.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:03:33 -0800 (PST)
From:   Wang Yong <yongw.kernel@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net,
        changbin.du@gmail.com, linux-kernel@vger.kernel.org
Cc:     Wang Yong <yongw.kernel@gmail.com>
Subject: [PATCH] Documentation: x86: fix typo in x86_64/mm.rst
Date:   Wed, 28 Dec 2022 10:01:41 +0000
Message-Id: <20221228100141.382325-1-yongw.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

change "64Gb" to "64GB".

Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
---
 Documentation/x86/x86_64/mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index 9798676bb0bf..35e5e18c83d0 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -140,7 +140,7 @@ The direct mapping covers all memory in the system up to the highest
 memory address (this means in some cases it can also include PCI memory
 holes).
 
-We map EFI runtime services in the 'efi_pgd' PGD in a 64Gb large virtual
+We map EFI runtime services in the 'efi_pgd' PGD in a 64GB large virtual
 memory window (this size is arbitrary, it can be raised later if needed).
 The mappings are not part of any other kernel PGD and are only available
 during EFI runtime calls.
-- 
2.25.1

