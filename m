Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3665EECCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiI2Ea1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiI2EaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF5F6F25E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664425812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RznIbSNju5lEWDowOue9vOjILmb6RsNdRY/73lTO8jw=;
        b=grHWfukDmivmxL948T3UXeSnT3BpKrmYv1n4+c2K+ksnpnR5e+flR6glRh3sma5CYitY3u
        bJsAawLUr3pAoIsqymez99PWB/ntvGNHnUsXAY8Vhzp75hquWPRF+Gyb2yCjWiITydAPEg
        dl8JRDtg60Wyvltk1B1XBBlWbz5Rv/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-p6iGadHTNZ23Iyl0i5pPMQ-1; Thu, 29 Sep 2022 00:30:08 -0400
X-MC-Unique: p6iGadHTNZ23Iyl0i5pPMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8656A80D08E;
        Thu, 29 Sep 2022 04:30:07 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-179.pek2.redhat.com [10.72.13.179])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AED47AE5;
        Thu, 29 Sep 2022 04:30:01 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     kexec@lists.infradead.org, ebiederm@xmission.com,
        Chen Lifu <chenlifu@huawei.com>, Baoquan He <bhe@redhat.com>,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        pmladek@suse.com
Subject: [PATCH RESEND 4/4] ARM: kexec: Make machine_crash_nonpanic_core() static
Date:   Thu, 29 Sep 2022 12:29:36 +0800
Message-Id: <20220929042936.22012-5-bhe@redhat.com>
In-Reply-To: <20220929042936.22012-1-bhe@redhat.com>
References: <20220929042936.22012-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Lifu <chenlifu@huawei.com>

This symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/arm/kernel/machine_kexec.c:76:6: warning: symbol 'machine_crash_nonpanic_core' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org
Cc: pmladek@suse.com
---
 arch/arm/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index f567032a09c0..a2e9ac763a9f 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -73,7 +73,7 @@ void machine_kexec_cleanup(struct kimage *image)
 {
 }
 
-void machine_crash_nonpanic_core(void *unused)
+static void machine_crash_nonpanic_core(void *unused)
 {
 	struct pt_regs regs;
 
-- 
2.34.1

