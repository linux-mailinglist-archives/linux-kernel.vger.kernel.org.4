Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2661A2A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKDUoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKDUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5935945EF9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667594585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QLfNlA1GCQXJ7R842kayw5n0l6+Ih1F81EObg8YgABk=;
        b=YOHPgMoeOnSvtI/xX+6Tc4NHv0ohd7kAJdJLRYKqPahpW6M7LrFDlbMo+lbETSgsiOL30i
        uJ6IRX899fse/C2LmwZ8M4qIzXbvTg4oTu4mVtPkUaXes16tFNK4lIqnil3GWxhu+sGyQC
        4kDDShDWa5vDwi8kFNDrtXSRo/wtb6A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-FrGLllYoPnO_hKdqC4zyTw-1; Fri, 04 Nov 2022 16:43:02 -0400
X-MC-Unique: FrGLllYoPnO_hKdqC4zyTw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADAFC29AB41F;
        Fri,  4 Nov 2022 20:43:01 +0000 (UTC)
Received: from worklaptop.redhat.com (unknown [10.22.10.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6605D492B0D;
        Fri,  4 Nov 2022 20:43:01 +0000 (UTC)
From:   Cole Robinson <crobinso@redhat.com>
To:     linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com, bp@suse.de,
        Cole Robinson <crobinso@redhat.com>
Subject: [PATCH] virt: sev-guest: Add MODULE_ALIAS
Date:   Fri,  4 Nov 2022 16:42:45 -0400
Message-Id: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes driver autoloading

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..4c426dbcd166 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -744,3 +744,4 @@ MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0.0");
 MODULE_DESCRIPTION("AMD SEV Guest Driver");
+MODULE_ALIAS("platform:sev-guest");
-- 
2.37.3

