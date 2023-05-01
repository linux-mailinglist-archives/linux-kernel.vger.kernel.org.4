Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6A6F3318
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjEAPni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjEAPnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:43:35 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F106133;
        Mon,  1 May 2023 08:43:26 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so25210105e9.3;
        Mon, 01 May 2023 08:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682955805; x=1685547805;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cQC0B97M3uB3IEi10h3QlCjXmckICpStzC7xQEPoc0=;
        b=gtvrOgzrSX9U8e3Vph+0tENBiAtj5akKJuJJxGhmBnAotIqTHiXTxB/C6bjQE6nSZD
         aSTfg7wD+Iq/pNctyPKXJ+8ACj5SZn/EldZA8bFNBLKgzNS2+Go3DmVoG+MKn6hY46KO
         pWRITUTVdhat4S5HcG4v15mKTPfhiVLNi0HTQuXems0rEnC9TBk3phY5hSycBqC6/iV+
         HTyz8K/SXm7LND9IDInWtUPVRAdcIWW+GZEOXCq6odQrH0Crl1rO7YKqPlfaJLy7oKPL
         sq6AuaU+DVetAlspp5BMCUa7Jn3I/w43J1eTtLorkH6ieAWpZPPsbar+odfMgZcTX9d3
         fjjQ==
X-Gm-Message-State: AC+VfDyjtLOegp4eE8vwLyIqS1dregryjU1l9LbSRjoMB+tJJTZWxXwk
        Q3KZofVYyL1OALK1Z/rgIeJqqTySO3eYfQ==
X-Google-Smtp-Source: ACHHUZ4BkXq5PAB8mcOH8rMtRLe0Z7xEvnCSkBrmm29zl9XHU1cIrWw1PbKGe+NA7mDtz4lxmN3uBA==
X-Received: by 2002:a7b:c8c4:0:b0:3f1:78d0:fc4e with SMTP id f4-20020a7bc8c4000000b003f178d0fc4emr10544692wml.32.1682955804524;
        Mon, 01 May 2023 08:43:24 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003ee5fa61f45sm36632520wmq.3.2023.05.01.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:43:23 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] docs: consolidate human interface subsystems
Date:   Mon,  1 May 2023 18:42:58 +0300
Message-Id: <20230501154258.277866-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
Reply-To: <87h6sw9iq0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
+---------------
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

