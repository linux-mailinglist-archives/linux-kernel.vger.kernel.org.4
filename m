Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647E7018D4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbjEMR6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjEMR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B12D2D52;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856F061CB1;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4577BC433B4;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=6CuqLMQiacBTAI5w3xjsfm0X5Hpovbdiy3/b17aiww8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4JXMw+HBStUnuVsn29oAAHAlFH2iZPow7WevxUXMPEvj2oJofU6Q2pHucRcllGGG
         aRsNa+pB2MsfMONwmvzMJjt+tLzEgdNsqhNdLd0Hya8ZCA0lEvuMQ6ilbcJuK8fXtH
         7gT4vEb52pi7HVgbB8gpJmsha3sdPval9L9ItggPyjU9p99LSKFkuQSnprxbrSFMYw
         Znwy/MrrPnIKrL5d0FzvU4H1SiELBhLxNB9PnKtvt0WMar8ohRwEuWVv0xz+4hWA8m
         Uml5eeh93jbsGG4EzO5SVKtaOFo1bTC5u2ZMcs9vbWJLMstCiz15ZNVHtHk1UmU2KX
         CQltketXd3ztA==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyK-1r;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 19/24] media: dvbdev.h: do some kernel-doc cleanups
Date:   Sat, 13 May 2023 18:57:36 +0100
Message-Id: <09c80cb59d5f9f45714bec8e0d0b1254c7846d83.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kernel-doc warnings in <media/dvbdev.h> were introduced. A fixup
patch addressed them was already merged, but Randy's approach from:
https://lore.kernel.org/linux-media/20221203060931.19953-1-rdunlap@infradead.org

Had some advantages, as it moves the @dvbdev to the right place inside
dvb_remove_device() documentation and it makes clearer about what
refcounter struct dvb_device refers to.

So, apply the changes suggested by Randy.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/media/dvbdev.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/media/dvbdev.h b/include/media/dvbdev.h
index 8958e5e2fc5b..e5a00d126612 100644
--- a/include/media/dvbdev.h
+++ b/include/media/dvbdev.h
@@ -130,7 +130,7 @@ struct dvb_adapter {
  * struct dvb_device - represents a DVB device node
  *
  * @list_head:	List head with all DVB devices
- * @ref:	reference counter
+ * @ref:	reference count for this device
  * @fops:	pointer to struct file_operations
  * @adapter:	pointer to the adapter that holds this device node
  * @type:	type of the device, as defined by &enum dvb_device_type.
@@ -266,10 +266,10 @@ int dvb_register_device(struct dvb_adapter *adap,
 /**
  * dvb_remove_device - Remove a registered DVB device
  *
+ * @dvbdev:	pointer to struct dvb_device
+ *
  * This does not free memory. dvb_free_device() will do that when
  * reference counter is empty
- *
- * @dvbdev:	pointer to struct dvb_device
  */
 void dvb_remove_device(struct dvb_device *dvbdev);
 
-- 
2.40.1

