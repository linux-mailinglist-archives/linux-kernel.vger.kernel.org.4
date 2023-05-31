Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493D3717D17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjEaKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbjEaKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:19:35 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B58E50;
        Wed, 31 May 2023 03:18:43 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f4b80bf93aso6362769e87.0;
        Wed, 31 May 2023 03:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528308; x=1688120308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6GPjeoHUHTaUuJ49rPZArdhLwRx1KXMFV6aKCSWWIg=;
        b=EtPaYmBbaFITqxeHc9x5nZdYuiRoiTTIXeW8d5eCxYqm3kKMkIxzftECIea+FcgrOx
         YlBzUCLHgRZBoppqQzHvMYZzxg6HzuOROkuNJUGcndQa0CyuSwOTmHCEWnu22s/UzMtw
         ALDPFhIsvYhWNKJSnnNGTXLT2W1v4OsarPQETSEdVIB1UE/wKtt+qM+jmYJXHA8nVHtJ
         /QrGQOlkWo2WDtUqG5/PZEngf2cJ8nC3yZCZxkLeJZr7diQkuGp+Ils2M8lEQHFg+eJG
         vqTEfDKWmaGbdq5F0fMdiwqf5XGAdTBvRw4Ot51sNLvbJ6ZU0Gh6QFAtM7aBTejcQ5Au
         SYxw==
X-Gm-Message-State: AC+VfDxHFiyPcDY3qt/zvDNxjdlbq6v4e/h31vzoc0w/NH73z/X/kz7j
        Rm+8v7ZaprVQtq+yduKNW9c=
X-Google-Smtp-Source: ACHHUZ7VEEsZgO547Ria6nWXtLVSiMK/xoGPSAEwQPvKsZ1jcG25xLrufP0Ux9b14EaHl33BOHN1jA==
X-Received: by 2002:ac2:482c:0:b0:4f1:1ec4:109b with SMTP id 12-20020ac2482c000000b004f11ec4109bmr2005801lft.15.1685528307990;
        Wed, 31 May 2023 03:18:27 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id l19-20020a19c213000000b004f37a541f0csm658008lfc.270.2023.05.31.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:18:27 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: organize subsystems
Date:   Wed, 31 May 2023 13:17:15 +0300
Message-Id: <20230531101715.3256681-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1e4436e-b428-0f49-ecf1-079955aaecb2@gmail.com>
References: <d1e4436e-b428-0f49-ecf1-079955aaecb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
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

as requested.

Add classes:
* Core subsystems
* Storage interfaces
* Networking interfaces
* Peripherals interfaces
* Embedded interfaces
* Other subsystems

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 87 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 55c90d5383ef..20655f6092c2 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -10,6 +10,22 @@ is taken directly from the kernel source, with supplemental material added
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
+   scheduler/index
+   timers/index
+   locking/index
+   cpu-freq/index
+   mm/index
+   power/index
+
+
 Human interfaces
 ----------------
 
@@ -22,46 +38,71 @@ Human interfaces
    gpu/index
    fb/index
 
-**Fixme**: much more organizational work is needed here.
+
+Storage interfaces
+------------------
 
 .. toctree::
    :maxdepth: 1
 
-   driver-api/index
-   core-api/index
-   locking/index
-   accounting/index
+   filesystems/index
    block/index
    cdrom/index
-   cpu-freq/index
-   fpga/index
-   i2c/index
-   iio/index
+   scsi/index
+   target/index
+
+
+Networking interfaces
+---------------------
+
+.. toctree::
+   :maxdepth: 1
+
    isdn/index
    infiniband/index
-   leds/index
    netlabel/index
    networking/index
-   pcmcia/index
-   power/index
-   target/index
-   timers/index
+   mhi/index
+
+
+Peripherals interfaces
+----------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   usb/index
+   PCI/index
+   hwmon/index
+   leds/index
+
+
+Embedded interfaces
+-------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   fpga/index
+   i2c/index
+   iio/index
    spi/index
    w1/index
+   peci/index
+
+Other subsystems
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   accounting/index
+   pcmcia/index
    watchdog/index
    virt/index
-   hwmon/index
    accel/index
    security/index
    crypto/index
-   filesystems/index
-   mm/index
    bpf/index
-   usb/index
-   PCI/index
-   scsi/index
    misc-devices/index
-   scheduler/index
-   mhi/index
-   peci/index
    wmi/index
-- 
2.40.1

