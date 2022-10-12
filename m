Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7545FCE29
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJLWJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJLWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:08:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7417AE8A8C;
        Wed, 12 Oct 2022 15:07:15 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i65so7738818ioa.0;
        Wed, 12 Oct 2022 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gz3ruQwRwGia88EdDAW7kbLDOehTl93TnM6D2ybY/Wg=;
        b=iED7XSfAvBbNfYwi4SUeIhFj0fpSRU/Ap+xNhS6ZwbDTMnMR12yJj+SbaQ/QoMy1xX
         BQdQXuXC5vew57+S4dcvZZFScg9ulNO6q5zM9TqUhMATU/Wtz78jSD1KxOu9ESEE3jM2
         YrbGGnwJe8yEb4PEV8UqZa8gNDawdhM005rBz9org2rlr6XR7GPLTcXGRfIdoYT9p//1
         4ekwkm4nBHXUkLlxvABmYcxcHT4/+UmgWD87kYXz0Zdc29tfrEGpgu9JWnzz2Fi4nel/
         FgcTi0yd67Q9wHAIVYEpj9n5eJGrHJBJU8XS2qLGkhc6kRq+7iqboCjT4GP8dipbEGBe
         nc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz3ruQwRwGia88EdDAW7kbLDOehTl93TnM6D2ybY/Wg=;
        b=RIAv7mEEHmv3STiq9/JO+4Ty3AXmyyTZ8dyg6qZX5WUh3H+wOqYM0Tp8DCssURwECb
         vJEH88x1j310fUypYrm5BvcL23Kwk+dOVXe9ptLHUU1AVryuIaeC1vsvymdlnVPTobob
         4c1U2osYeXMRwiYeZ9J+H/TVaCVLA6aDC4oNxPSBYNtXc6+fQ2LXuqeK68EbTFdapXU1
         uFLGHEQCoKmPMwn5sk4Oo3NX+NaFgMsvzTybg+OJbD+ezST0mo63WLrXHaUgPLJLZbDo
         5PJ2ScuLWvd0atsGd0ENCjY1W6Cmf8gDAuxYnAvVb1SNtY/cpEHW9rxfESNcSf2n5ulK
         tIAw==
X-Gm-Message-State: ACrzQf1px8SgrMndW4/VYC4/Y26vvbOTXAccOmdAnnw1J70S4qq/gfkh
        LxJ0WmAC35a8bBn+gBxHjrqX8QbA/qA=
X-Google-Smtp-Source: AMsMyM5JNuNvpQPQRx+/5BdiGBWFQ5yEsmMVL7MvWVZ7ksgaVdLxv8OhR3e8clk3Zx7SaiOhkd5V0g==
X-Received: by 2002:a05:6638:1612:b0:363:e0e0:b77f with SMTP id x18-20020a056638161200b00363e0e0b77fmr3435182jas.45.1665612401237;
        Wed, 12 Oct 2022 15:06:41 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:edc6:cbc9:4de4:ae71])
        by smtp.gmail.com with ESMTPSA id a16-20020a056602149000b006a4ab3268f3sm6958021iow.42.2022.10.12.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:06:40 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: of: collapse overlay entry into main device tree entry
Date:   Wed, 12 Oct 2022 17:05:48 -0500
Message-Id: <20221012220548.4163865-1-frowand.list@gmail.com>
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

From: Frank Rowand <frank.rowand@sony.com>

Pantelis has not been active in recent years so no need to maintain
a separate entry for device tree overlays.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Based on Linus' top of tree, 676cb4957396 d0d51a97063d,
Wed Oct 12 11:16:58 2022 -0700

 MAINTAINERS | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a198da986146..a497bd2b0ea6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15359,17 +15359,6 @@ L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
 
-OPEN FIRMWARE AND DEVICE TREE OVERLAYS
-M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
-M:	Frank Rowand <frowand.list@gmail.com>
-L:	devicetree@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/dynamic-resolution-notes.rst
-F:	Documentation/devicetree/overlay-notes.rst
-F:	drivers/of/overlay.c
-F:	drivers/of/resolver.c
-K:	of_overlay_notifier_
-
 OPEN FIRMWARE AND FLATTENED DEVICE TREE
 M:	Rob Herring <robh+dt@kernel.org>
 M:	Frank Rowand <frowand.list@gmail.com>
@@ -15382,6 +15371,9 @@ F:	Documentation/ABI/testing/sysfs-firmware-ofw
 F:	drivers/of/
 F:	include/linux/of*.h
 F:	scripts/dtc/
+K:	of_overlay_notifier_
+K:	of_overlay_fdt_apply
+K:	of_overlay_remove
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 M:	Rob Herring <robh+dt@kernel.org>
-- 
Frank Rowand <frank.rowand@sony.com>

