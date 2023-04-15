Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC936E3177
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDOM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDOM7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:59:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00954469E;
        Sat, 15 Apr 2023 05:59:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v9so26377466pjk.0;
        Sat, 15 Apr 2023 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681563548; x=1684155548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6c68/5Md7cMne98kE77HsjaBJtVJyno9SAqmLPxY1A=;
        b=Ds+41jTpjxLYPMonaWSA9NV0cbqD7MKNu//FBd69LMSD41ilBWn59eaeJYOdmov4ZW
         br5Su2Sad2nC7rENA/q++U+FaDSOxRmOUT2U8Le7/F4o5AJllk+XPX8w4erIUwbAHlEf
         PKOpM3mRluzikjfNIuq92C/FwZoEuGfIZnYPh4j9vZF2/JMPzFMvRuXnFYEK6wNU0pFq
         +5mmNlZL6tQpOlx4dO6Mj/s5LG/5i22420mqvykLxgYJkswJAly/8c1ldO9b6zH5KOoY
         Fmx0A4tjZ7YwS/TMthMonh0s6EwTNvTD3xub/hDXalgYBTp/ZWqNICjKgwSZQ6BPqcbT
         ZIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681563548; x=1684155548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6c68/5Md7cMne98kE77HsjaBJtVJyno9SAqmLPxY1A=;
        b=J1mQVQzPtTOmYxq3CMauMGYn6E8Kk6XPLu7I5323ZOCIlq6BpYuHpChO4QOdTecIco
         s3Cnbw+LJOAP/FmHrOdoJwJY4kwN44j4Fa1X6fefTzzsuLDUeIIbceIxsh855EPwZ4HD
         v858BJ+BKCav41ku6fH8Y+lRJgeT43igmeYl2GRxADV5IH+4x8CuM6QOgl7qsRW2IbaK
         99udwv5yvIB1shLjzGgdj7ov8ebU5T6vGg5ef8VfYUBsw3VrD8ZP+aK35dc5FCqTH2IX
         sET+XN88xKgfidfbS4IyV91YC3OMJm1ArQXsSxj3R2U//VonF0rGGFoBOUHRqy7N8vZ7
         jtvg==
X-Gm-Message-State: AAQBX9eacI2JyqowPL3FsvFjNDLQ8pib9I5sXvx2Rj8nUhf0oamnJMRa
        KxRjw7S4PsU1958T3sgJ088=
X-Google-Smtp-Source: AKy350bkxms0+aQkAoCqjmSKCYMGfDeGzcEtdFWF0OMTt6hpFf5wNG6lf3lQHtTQ6CqNlKRzag7e/w==
X-Received: by 2002:a17:902:c40f:b0:1a0:549d:399e with SMTP id k15-20020a170902c40f00b001a0549d399emr7805986plk.21.1681563548149;
        Sat, 15 Apr 2023 05:59:08 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:5729:d52f:4a1c:173f])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b0019a773419a6sm1039472pll.170.2023.04.15.05.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:59:07 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     lkp@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     akinobu.mita@gmail.com, axboe@kernel.dk,
        oe-kbuild-all@lists.linux.dev, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, akpm@linux-foundation.org, hch@infradead.org
Subject: [PATCH -block] fault-inject: fix build error when FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
Date:   Sat, 15 Apr 2023 21:57:05 +0900
Message-Id: <20230415125705.180426-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202304150025.K0hczLR4-lkp@intel.com>
References: <202304150025.K0hczLR4-lkp@intel.com>
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

This fixes a build error when CONFIG_FAULT_INJECTION_CONFIGFS=y and
CONFIG_CONFIGFS_FS=m.

Since the fault-injection library cannot built as a module, avoid building
configfs as a module.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304150025.K0hczLR4-lkp@intel.com/
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 lib/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6f64b49a2a8e..ce51d4dc6803 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1979,7 +1979,8 @@ config FAIL_SUNRPC
 
 config FAULT_INJECTION_CONFIGFS
 	bool "Configfs interface for fault-injection capabilities"
-	depends on FAULT_INJECTION && CONFIGFS_FS
+	depends on FAULT_INJECTION
+	select CONFIGFS_FS
 	help
 	  This option allows configfs-based drivers to dynamically configure
 	  fault-injection via configfs.  Each parameter for driver-specific
-- 
2.34.1

