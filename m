Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9656DFD56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDLSSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDLSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30DBA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681323449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LrssHurPM5N8vIL6ydvz7U3hf7mj1eq54keYVOaBZJQ=;
        b=aVWLEmXEr2nCcidJ9EM7N/Cv1lJAVSk0MmlZVRQwfFJFDNvBPOsgbXrCiGAO73dIP7rTsv
        r1Hz1rUBJ8OIgfFrTmtJm4cQ893H+I3/iHvNopbMZ/JT9Rh/xkl9dIM1MJnHDUZxwe62+3
        aaxMJv22sONaXzg8714anINaUksBq6w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-oB_Wy7iINdS4oJYIQQ0djw-1; Wed, 12 Apr 2023 14:17:26 -0400
X-MC-Unique: oB_Wy7iINdS4oJYIQQ0djw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D2085530E;
        Wed, 12 Apr 2023 18:17:26 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B19040B3ED9;
        Wed, 12 Apr 2023 18:17:26 +0000 (UTC)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     nipun.gupta@amd.com, nikhil.agarwal@amd.com
Cc:     linux-kernel@vger.kernel.org, alex.williamson@redhat.com
Subject: [PATCH] cdx: Allow build with COMPILE_TEST
Date:   Wed, 12 Apr 2023 12:16:58 -0600
Message-Id: <20230412181658.529415-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase compile test coverage.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/cdx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index a08958485e31..8e3cca77ec64 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -7,7 +7,7 @@
 
 config CDX_BUS
 	bool "CDX Bus driver"
-	depends on OF && ARM64
+	depends on OF && (ARM64 || COMPILE_TEST)
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
-- 
2.39.2

