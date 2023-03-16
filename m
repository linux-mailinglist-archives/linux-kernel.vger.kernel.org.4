Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724846BCDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCPLQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCPLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:16:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D22BBB15;
        Thu, 16 Mar 2023 04:16:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so5966695edb.13;
        Thu, 16 Mar 2023 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678965394;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfjSPidc5pyhIjhycYrYynfFm6hlfBhZw9y/nZ4/67Y=;
        b=WxdArsdAYr4fk0dWLGtqTHtrj6klABluPaNoEoRS+hnaZcm1OoFRtNNMvGPxQvMjXx
         cNVUR8DgmDTpELX0ZyUkQopcSbTfcWDg+rhMHdp2YvnsNFRw0Fpl5H3D8oEfAKcZtnV3
         si+whSMJ3ZxTJ868ssF76X17ZSC9I8+YgoN4RoJ5rjIZpEg0JdG99Gut9V2jgEvF9vKE
         xmgxEgel3MKcHFPMGS+QsEXMD7R6voxnvwf+Z3/MRVG8WFsmGvd11OZyJnZSv5CZeCU8
         xXPv5G91hbFnpVyjK/71C5pQRQGTyp/3xu/JsZZZo/GN01QObZdv6NjnjUTttoIV/zzG
         FstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678965394;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfjSPidc5pyhIjhycYrYynfFm6hlfBhZw9y/nZ4/67Y=;
        b=6dminVI27YqZgJCB7rlch2ZjOV2a1YOKbprCIEhQpwz3KdOIRZ7+lM+skVSC6jWuFv
         VFKjusjpAq5O7n7ml/EDTKe84nQM+XVq02gXs+4UrGLu1DGyclopAAtZ7PbXSMUqgH+k
         HsZmJ9zSZQMiOIGVNMftUWntCogu0qzI5IdG6XxoxAGNQE5bmIQf4zmLx362ighTgVly
         rRbOrzeWyT4B9wxZs0UWTDgCbXXFQT3zJGX1yb+OFVsmsD7W3s9UXKVqtHI2qiKAJ8s8
         RbyraJzgYjAludCLtUqUkt7G2HuEmqobT5IUj11XoKBrYi6o3nOW/xOBAUaZtmEJRTid
         CYPw==
X-Gm-Message-State: AO0yUKU8WFmgzZAuwbbUje4kdDfm/pgF8sBlpNg3UYPceU2SpWk06bTv
        foJjNpJu9dyJHQJg1btyfwo=
X-Google-Smtp-Source: AK7set86pLM7AMgzdBVkzaZKIiaXpyIOBZ/aEXxSow8ZQjQPCY3mEBF3kqIJjz3w8nY9ds6lKLYaDQ==
X-Received: by 2002:a17:906:c244:b0:86a:316:d107 with SMTP id bl4-20020a170906c24400b0086a0316d107mr9706530ejb.72.1678965393665;
        Thu, 16 Mar 2023 04:16:33 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a05c:be0f:b1e7:779e])
        by smtp.gmail.com with ESMTPSA id qa14-20020a170907868e00b008f702684c51sm3704245ejc.161.2023.03.16.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:16:33 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] block: remove obsolete config BLOCK_COMPAT
Date:   Thu, 16 Mar 2023 12:16:30 +0100
Message-Id: <20230316111630.4897-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit bdc1ddad3e5f ("compat_ioctl: block: move
blkdev_compat_ioctl() into ioctl.c"), the config BLOCK_COMPAT was used to
include compat_ioctl.c into the kernel build. With this commit, the code
is moved into ioctl.c and included with the config COMPAT. So, since then,
the config BLOCK_COMPAT has no effect and any further purpose.

Remove this obsolete config BLOCK_COMPAT.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 block/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 5d9d9c84d516..941b2dca70db 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -204,9 +204,6 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 
 source "block/partitions/Kconfig"
 
-config BLOCK_COMPAT
-	def_bool COMPAT
-
 config BLK_MQ_PCI
 	def_bool PCI
 
-- 
2.17.1

