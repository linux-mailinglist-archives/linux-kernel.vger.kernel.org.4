Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C124734510
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjFRG3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRG3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:29:51 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13797E51;
        Sat, 17 Jun 2023 23:29:50 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3110ab7110aso2066554f8f.3;
        Sat, 17 Jun 2023 23:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687069788; x=1689661788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kVdcijOpIuUfsXa/7yUYV8tahrXAsxjueUTSgD3qp8=;
        b=fIf3RAr/PXadXa++2uSc7dLjzJXN7bNqAOaY6aiCQ8PiGmZDoSXRyFjXIoLsEfxwJr
         d5z+SP3rROU5jhqp/ZWZN5YNiiIzzlrYG3r6gJ+EA+Z2TKyx+6vqDF6K29bLfSX7kZEC
         +/tpg4cPvmbAWNmfxrdgIQoAnRlnK1LQqGTyqT29bOby2JMQgSbmSp0bFoKz6DzRiVEl
         FXvHs9OZcgjfbd3NrEVvALxgqXCXt0qAa7RFHPu2PZNVQNHyLzpmkZ0BPNOcOT+Slkr6
         THcautXwnp39N8yvRHFYpfUvSdLvRy6uKY+0SIAItTNJ+7IQ8iO/hsfEtK/40PFrP8IK
         K/Kg==
X-Gm-Message-State: AC+VfDyld1vcir11cztyHBAGmmpz8oYgifJNThSPga6Og/uJmkX9kpPz
        OoprpPnekavOUmZcqA70dZIwbGsmkH+IzQ==
X-Google-Smtp-Source: ACHHUZ6ZbnURw/CVYWDl9YzpGIputEl07AhKursQyXeSC4U6a7TWrl7sOOOImEUOnLqLJzNaj7JAzg==
X-Received: by 2002:adf:fd4e:0:b0:30f:c153:2f08 with SMTP id h14-20020adffd4e000000b0030fc1532f08mr5247859wrs.33.1687069788313;
        Sat, 17 Jun 2023 23:29:48 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id h4-20020adffa84000000b0030647d1f34bsm27932929wrr.1.2023.06.17.23.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 23:29:47 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] docs: consolidate storage interfaces
Date:   Sun, 18 Jun 2023 09:29:37 +0300
Message-Id: <20230618062937.481280-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <87h6rhoyag.fsf@meer.lwn.net>
References: <87h6rhoyag.fsf@meer.lwn.net>
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

Changes:
 v4. rollback to single Storage category, add 'TCM Virtual Device'
 v3. add Integrity, Virtualization and Miscellaneous per Bagas Sanjaya
 v2. add Core subsystems, Networking, Peripherals and Embedded
 v1. add Storage category
---
 Documentation/subsystem-apis.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 55c90d5383ef..b67a1b65855b 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -22,6 +22,18 @@ Human interfaces
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
+   target/index
+
 **Fixme**: much more organizational work is needed here.
 
 .. toctree::
@@ -31,8 +43,6 @@ Human interfaces
    core-api/index
    locking/index
    accounting/index
-   block/index
-   cdrom/index
    cpu-freq/index
    fpga/index
    i2c/index
@@ -44,7 +54,6 @@ Human interfaces
    networking/index
    pcmcia/index
    power/index
-   target/index
    timers/index
    spi/index
    w1/index
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

