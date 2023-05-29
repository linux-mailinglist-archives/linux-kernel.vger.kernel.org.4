Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8297146BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjE2I5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjE2I5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:57:12 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AB0E1;
        Mon, 29 May 2023 01:57:08 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30ac4e7f37bso1742308f8f.2;
        Mon, 29 May 2023 01:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685350627; x=1687942627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC1z7TxrFRGvIM8czoQTNj2lj+LHfuh6uG4Bml/WNHU=;
        b=eNnGa1NWtqhV1Gre2Lqvt7nBp96r8ibRC5poe0nnCVb2NIt5VbxYdkJfm2CqM7iNyf
         vnJ+Lz0Nv16FuNEhny8OSCNcxRO+rOdvq2YNGFvaklyZjfQe9SV1vaD/UUydlNtVXcFz
         CFUmDNujXt0doyOB/5FiDlcVov+ncroC7wkrsF54ajpAV/2cBDPpW/amvL8bYaUpbJXe
         +vTBfy93ueB2Ak8ZLIXll8wSpJIsSWPeg9B5X/CffGJHDqB8Hdhu9gGjCMMWCiWZ5101
         4rTKc8h5nnQlsDUfdZq8cEOl5KO8cCtqfaKVaYS+OmowNQ4E23mL5n5cgPAo4P9EYil9
         h/MQ==
X-Gm-Message-State: AC+VfDzdvMoL70eNYaiKZHgGaEAx5Fw6ttcvL6jq/Ljst+800auDol0p
        bDqkpIY6uYKQr6KTMJ9EsAtD/7JA0QYRJw==
X-Google-Smtp-Source: ACHHUZ44OOaypqKpQSVa5J7G2mPJg/i80osfFw4GU+e+djItaD+sx4uNdZQoahMJ/F0ub0dCqGtr7w==
X-Received: by 2002:adf:dbcb:0:b0:30a:f02e:3f46 with SMTP id e11-20020adfdbcb000000b0030af02e3f46mr831013wrj.35.1685350626854;
        Mon, 29 May 2023 01:57:06 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b003062ad45243sm13002835wry.14.2023.05.29.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 01:57:06 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: consolidate storage interfaces
Date:   Mon, 29 May 2023 11:55:20 +0300
Message-Id: <20230529085521.2574848-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make the page more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 55c90d5383ef..f7fe772835e5 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -22,6 +22,17 @@ Human interfaces
    gpu/index
    fb/index
 
+Storage interfaces
+------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   filesystems/index
+   block/index
+   cdrom/index
+   scsi/index
+
 **Fixme**: much more organizational work is needed here.
 
 .. toctree::
@@ -31,8 +42,6 @@ Human interfaces
    core-api/index
    locking/index
    accounting/index
-   block/index
-   cdrom/index
    cpu-freq/index
    fpga/index
    i2c/index
@@ -54,12 +63,10 @@ Human interfaces
    accel/index
    security/index
    crypto/index
-   filesystems/index
    mm/index
    bpf/index
    usb/index
    PCI/index
-   scsi/index
    misc-devices/index
    scheduler/index
    mhi/index
-- 
2.40.1

