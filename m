Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918F57397DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjFVHKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:10:28 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16FA1BD2;
        Thu, 22 Jun 2023 00:10:27 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3ff4299b86dso10502681cf.1;
        Thu, 22 Jun 2023 00:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687417827; x=1690009827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUZqtEVGmxwB4BpFMfmLjNjsE8N7SvG/Qu4z0YWMl5M=;
        b=DOgDA29ycta23OZStpwV3+hs/bSs1jteck+RwtkaNM/h+GXAeydaAfKsfXBP4K9tH8
         UqHcZHLZ/tqXoTuoat+8ssv2GzMs9kO3abfuqAVuMF4aJD618iB6A+Q/XBMJebpALh91
         DA0EHfg8/tWc72nRWL2oa1ZxZFRF4dVAyuL7hEMLMbQocHAKCnaV9QgJq8R1tv2dFJub
         /7Rqp41Zcu8em7axlysGiMrg2Jx35P8Wn6oTqr4M/uqVGAXJO0M1PrnoZNUBixb00+dx
         jWokb80nlCCurT7r6kAAQNWpPQOZ1/GDWFhhPl3bV/sufaD492nxo9G5vHaOR2YjF5IN
         bw9w==
X-Gm-Message-State: AC+VfDyVbi7HLnXQ4TWgX4z5UVdPsTANKiAxBg75Ffm894B/OHgyeu0V
        XWISEx/IX914boHvDH7OvNs=
X-Google-Smtp-Source: ACHHUZ6bZMOCSZJn8Lil46b8XabElDSUKxgAC4P1Hcfy/fqwBn9aJmv+Z/6c9mPGNHuzIPw6x5ez2g==
X-Received: by 2002:a05:622a:1c5:b0:3b9:e0b2:9a49 with SMTP id t5-20020a05622a01c500b003b9e0b29a49mr22205685qtw.60.1687417826691;
        Thu, 22 Jun 2023 00:10:26 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id e6-20020ac84906000000b003f9bccc3182sm3299707qtq.32.2023.06.22.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 00:10:26 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: consolidate core subsystems
Date:   Thu, 22 Jun 2023 10:10:03 +0300
Message-ID: <20230622071004.2934698-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make the page more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index b67a1b65855b..8664b05777c3 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -10,6 +10,20 @@ is taken directly from the kernel source, with supplemental material added
 as needed (or at least as we managed to add it — probably *not* all that is
 needed).
 
+Core subsystems
+---------------
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   driver-api/index
+   mm/index
+   power/index
+   scheduler/index
+   timers/index
+   locking/index
+
 Human interfaces
 ----------------
 
@@ -39,9 +53,6 @@ Storage interfaces
 .. toctree::
    :maxdepth: 1
 
-   driver-api/index
-   core-api/index
-   locking/index
    accounting/index
    cpu-freq/index
    fpga/index
@@ -53,8 +64,6 @@ Storage interfaces
    netlabel/index
    networking/index
    pcmcia/index
-   power/index
-   timers/index
    spi/index
    w1/index
    watchdog/index
@@ -63,12 +72,10 @@ Storage interfaces
    accel/index
    security/index
    crypto/index
-   mm/index
    bpf/index
    usb/index
    PCI/index
    misc-devices/index
-   scheduler/index
    mhi/index
    peci/index
    wmi/index
-- 
2.41.0

