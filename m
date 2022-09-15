Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EC05B96C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIOI6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIOI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:58:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043D8A7C4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:58:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so14568209pja.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gIZNqT2ZAkXaZyWINWYq7lo5YTszTa54rmQ3wSSWBaA=;
        b=qmlmS3qMsCul9iyvY0vf+5+TDMlH8Zsq+g9M8nLTXxBwEqWrtCjp2IiNR+Y5PFQ5ab
         eSspG7jaUROyDOJcqLZJTXg0h9UmYW15gGEy6aF2JJLJsIAKxYiLCFEyRpXYhFn0/zEY
         T7dhkCTlrPP/45zyMtEF+OQzFF3s4A1BWzdaKPIc2j9QVoEU+EzwQwyBZY/vxk4H6NuJ
         TxBCjxr1oxvJadtQAH/pqFqClJ1x7rFFIrHkVIEnB+Yj4sev6FAKFVMOTc6D7BHJSyyq
         UrulUSbhkAXOxYC8WotWOnj0X+14PVw16EQx7AoKrxfjfDxpBZ9LmWU5ZSx8yR8eQ2dO
         r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gIZNqT2ZAkXaZyWINWYq7lo5YTszTa54rmQ3wSSWBaA=;
        b=hPSb2zc/0/+JMhGHYrZtormRNPBQnsr4krYjCkyQSSxh//U0uaVrv9Y8LkhbL3AmgN
         Z1CWIlsAza9xU5Z4dr6mDFFsayylo5dLNuPjAVKlbXlreJnMq9BlJ6SNMXb0doTvbYVX
         hZGm+vCDxOh7I4DCFC70IYh3tw+aZMEkZVHwmKt/siMJDqglFCu/6GwyPobArAqbBBrL
         T8TY6RBDn6Uol4dKEpXkMI8Y0QYl2DKplQKVzcpxjQU4xgVzkuwX6Te6hEjZJ8j+RnuE
         Tltu4HLhandaq76b2v3iKLA5Kf4v1bHdkJeL3PGV+Pcbpgpjtrjc5sYqU2kfx/HKY6oc
         kI0Q==
X-Gm-Message-State: ACrzQf2bfHycvg/pd3m7NeZKhxGcxnL374ApDAswOjxf5BZIg2sdARpM
        Hef5l0hD4xqXzptDUaSscPrpBUu/xhQPKjlc
X-Google-Smtp-Source: AMsMyM7ejkhm5/VC/t4JV5rikoTNn5ptleg8X5r7xPTj/rsmYp9R0cHyLpbw+HxDWam1i0v3OK0Jzw==
X-Received: by 2002:a17:903:110e:b0:171:3114:7112 with SMTP id n14-20020a170903110e00b0017131147112mr3362731plh.114.1663232317417;
        Thu, 15 Sep 2022 01:58:37 -0700 (PDT)
Received: from jonathan-VirtualBox.ip (122-56-198-116.mobile.spark.co.nz. [122.56.198.116])
        by smtp.googlemail.com with ESMTPSA id iw11-20020a170903044b00b0016f196209c9sm12276080plb.123.2022.09.15.01.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 01:58:36 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH] Staging: Android: ashmem.c: Fixed missing const modifier
Date:   Thu, 15 Sep 2022 20:58:27 +1200
Message-Id: <20220915085827.19701-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed missing const modifier line 370

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index c05a214191da..a04488efd5f2 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static struct const file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.34.1

