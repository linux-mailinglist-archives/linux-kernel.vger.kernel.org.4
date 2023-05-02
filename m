Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304636F3BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjEBBvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjEBBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:51:14 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3698A30CF;
        Mon,  1 May 2023 18:51:13 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3062678861fso1564775f8f.0;
        Mon, 01 May 2023 18:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682992271; x=1685584271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNyrpU7tvbNFLr00b0UkT0J+lENE3vJhw2P346SQMpo=;
        b=BCuztcCH4htXQOJSN386EAU0pa+BMKGwY4R3cPISNnGOIx4ZgXYYWlE3bqqNTboEdg
         j1yiVbGPg2nkAuIfcqZpGw7xyTAZGticKYKlKy8rZ9J78Hd/G27My5GPU8pZwZ+6GoHG
         JZY336D+uHux/Z6SC78ASZWuNFWkHTcSR04Ej0Sz5F++l5E8US+aMNWs1DKgB4LyrWTY
         VW3jpZM/A43gLzJCI0dFvPdjojaJRyfpauGSWuX6EPR1SDUdaeYWNCdbpoNe/Mt4xrth
         dP5w7OGKmHy1Qqbo/mkBHf7RxNvREo9XmCnEDWZcsRJyxANoeQpKa+HkI9wikWz5ej2j
         Pg9Q==
X-Gm-Message-State: AC+VfDyN6RoXv2coqGnOYldPcgsX/UnqJXPvroRN7ieJHqLENIUTgKp8
        YQUdfuyB78lfsmCpkp7fVm4=
X-Google-Smtp-Source: ACHHUZ4oFZ3aVUKqG35t1gvcum6lP5hqKSDt3WDjDTuJOz2/M+ydprx3aNUSbEwbd9JyL/DZAccL0Q==
X-Received: by 2002:adf:ec04:0:b0:2f9:a798:602c with SMTP id x4-20020adfec04000000b002f9a798602cmr10900635wrn.12.1682992271083;
        Mon, 01 May 2023 18:51:11 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id f11-20020adffccb000000b002f90a75b843sm29486846wrs.117.2023.05.01.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:51:10 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] docs: consolidate human interface subsystems
Date:   Tue,  2 May 2023 04:50:40 +0300
Message-Id: <20230502015040.329394-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <0754e279-ae06-9b57-f655-cc7cc9eb6ecb@infradead.org>
References: <0754e279-ae06-9b57-f655-cc7cc9eb6ecb@infradead.org>
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

to make the page more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
Changes:
- fixed typo
- fixed underline

---
 Documentation/subsystem-apis.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index b51f38527e14..287799ee2419 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -10,6 +10,18 @@ is taken directly from the kernel source, with supplemental material added
 as needed (or at least as we managed to add it — probably *not* all that is
 needed).
 
+Human interfaces
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   input/index
+   hid/index
+   sound/index
+   gpu/index
+   fb/index
+
 **Fixme**: much more organizational work is needed here.
 
 .. toctree::
@@ -22,9 +34,7 @@ needed).
    block/index
    cdrom/index
    cpu-freq/index
-   fb/index
    fpga/index
-   hid/index
    i2c/index
    iio/index
    isdn/index
@@ -40,12 +50,9 @@ needed).
    w1/index
    watchdog/index
    virt/index
-   input/index
    hwmon/index
-   gpu/index
    accel/index
    security/index
-   sound/index
    crypto/index
    filesystems/index
    mm/index
-- 
2.40.0

