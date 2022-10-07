Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C85F7EFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJGUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJGUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:40:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B577B03CC;
        Fri,  7 Oct 2022 13:40:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b4so8890775wrs.1;
        Fri, 07 Oct 2022 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xno8DvPJDMlxcVtto8QzuqlpStaL3vI83oHShJE2jU=;
        b=YzHEfDXbKJ9+2wHbnZQNvajFf73uxxRr+wT6grsEaJBtNYK+NMZljyYq90jt/nzTOz
         tifAYemIrpriWZmamazG6vNEaaxsUR90LrjeqF6smKN9YXOZ+2lEWqRupmcdYYIKy527
         opDedPeBaXJkZbuC6R7mT4QaCMLmSUatoK+1GUtpJutKGM5JgNEkPlm4dQYRRIvsCMeG
         lXb+/GYd+sy0oKfJgSKXk3p0Hwj7D/eF4q0aYbEkBuPBq/7WyP/uMETg8bfb0kYiCU6l
         Dm1gSEHuaXkp4Ty8jjVxjOCcq0JlyTZU2tK4u73lP1mxL3t5Tr/aiF3GwQMFMzFTveJh
         bAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xno8DvPJDMlxcVtto8QzuqlpStaL3vI83oHShJE2jU=;
        b=vOMG+I0XyM4zSeJiL4exrE6rKlDknQH3fRpzP14kOq0rJ8uIM0Xj0CTbjjJpkHFe08
         TrAwp92ZNwq3u7Kn8vGqxQ9NVNUJAW/w8ud++iVvC28deCoYGE7EKFjr5GZBfzbWzzY7
         yDgZlN6i+GVo/D2vwaFtm9+ta+S6lWCmt4+BVvKm8K41NV9HPYyg9BLQm1dMI25cjuF0
         A+kzyy8epy0JTFbM8XzqZe4N+ia9KGfv/d/EZRDOZd/IBSHRhYRJTfJ+Ee0lRe4VdZio
         AHApxO9pIr3Orlq/uvX8veTFDJa+c3RWg5veIVSyuoDyftk2WTu18GA2rdVy/l3VjALo
         4UOg==
X-Gm-Message-State: ACrzQf3tSTMrMFSsEvpRF5GIw0rf2HiCNVVvcLZcKkVxx/PBoJFM39ZS
        Ddq67To99pO8q20u1MXmGE0=
X-Google-Smtp-Source: AMsMyM6trq2An6Jv7nmktxh1tAYT1BHNZPIsZRp3vEWbagzIGyQU9YJEExejAkmm8C8T0JkiD1wzkQ==
X-Received: by 2002:a5d:4b8b:0:b0:22e:4185:bcc7 with SMTP id b11-20020a5d4b8b000000b0022e4185bcc7mr4583362wrt.174.1665175255183;
        Fri, 07 Oct 2022 13:40:55 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d468b000000b0022add5a6fb1sm2839992wrq.30.2022.10.07.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:40:54 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: Kconfig: Fix spelling mistake "undelying" -> "underlying"
Date:   Fri,  7 Oct 2022 21:40:54 +0100
Message-Id: <20221007204054.2757493-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/overlayfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
index dd188c7996b3..6708e54b0e30 100644
--- a/fs/overlayfs/Kconfig
+++ b/fs/overlayfs/Kconfig
@@ -96,7 +96,7 @@ config OVERLAY_FS_XINO_AUTO
 	depends on 64BIT
 	help
 	  If this config option is enabled then overlay filesystems will use
-	  unused high bits in undelying filesystem inode numbers to map all
+	  unused high bits in underlying filesystem inode numbers to map all
 	  inodes to a unified address space.  The mapped 64bit inode numbers
 	  might not be compatible with applications that expect 32bit inodes.
 
-- 
2.37.3

