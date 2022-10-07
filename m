Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709675F7EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJGUil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJGUii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:38:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98338A3D;
        Fri,  7 Oct 2022 13:38:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id iv17so3546314wmb.4;
        Fri, 07 Oct 2022 13:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shmREDLmMVUwWwDbGe5AomtgsX89LM/LCOdNvmYLfow=;
        b=R6jLDbJ4wHcEOysJUGrqqIAlzZEl78LCXrdwjCFWp40P8Ra/tNXtxqTy26H4WRxhIi
         O1q5PqPgnYOsVmfW3is0qziIVGvAIpIWHGUEgOLAjUXdcVJ+V3pJSicvT80OB5EcLajl
         htw5COVf2xsGhtoirJ9UMuv9ursKCFg+F6TRo1Enp4zFDbkIHRz1DOyYbUyyxvglpAxX
         3pMPSGTdeR06EbAAAckUZQpHMXjdZtizn2i0K7Q7I/fEJz4qyVvIsSoDKh3JymmLGC6+
         U8cQpI76KTljd5P80Cojvfm3WFM4BM7dnh1u0s4rXdC+qNlo8/nqC+GveIEV3Wmwa5kT
         HrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shmREDLmMVUwWwDbGe5AomtgsX89LM/LCOdNvmYLfow=;
        b=VODb03Zx+mGn0CYrl41mdMphAjozu59QRaXjl7tNYGJhpWAyvC24uLcGlmfA2Dlh49
         4JFDVeaVyKhqCYsPqGqXayvCtVSiDBA5pNgk6kyP//BvPzZkT9u9XJdzdNydkMiCyhv0
         Arb1Oa/IUHKem/HnIJPky8j4c8Fo/ik7qLPoKRvhb13cs3atn04wdxjvdwYoW4QakYl8
         bRRwe7xsYQtoa8si6/12uLxz5Zo/Z8d86dr6gszMydDfhbbuQS0tmogFj1fH/CH4RTtl
         lAFgct3z5D5f6RIdQfOL/qwvXlkrMWHAlzdM+tUvFRspIkz7e6JRlyloc5HLHuJ0o9vm
         0rhQ==
X-Gm-Message-State: ACrzQf2O/LF9zreWQUyuXXWN8QUL+V4gT3TZiiZ3a+xQ4joMcpVQ1WZy
        Z0KD4nvdJjDeXNQfSGKJgf8=
X-Google-Smtp-Source: AMsMyM40aSLUnvrloCho2H63ihMDShb9a66aAC1vISKRhTZm1jwHV+Isz3kj/UmPDX8hBUo/yj1+WQ==
X-Received: by 2002:a1c:7315:0:b0:3b4:e1b8:47b2 with SMTP id d21-20020a1c7315000000b003b4e1b847b2mr4452330wmb.165.1665175116004;
        Fri, 07 Oct 2022 13:38:36 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p2-20020adfce02000000b0022a3a887ceasm2848095wrn.49.2022.10.07.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:38:35 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] freevxfs: Kconfig: Fix spelling mistake "endianess" -> "endianness"
Date:   Fri,  7 Oct 2022 21:38:34 +0100
Message-Id: <20221007203834.2757219-1-colin.i.king@gmail.com>
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
 fs/freevxfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/Kconfig b/fs/freevxfs/Kconfig
index c05c71d57291..0e2fc08f7de4 100644
--- a/fs/freevxfs/Kconfig
+++ b/fs/freevxfs/Kconfig
@@ -8,7 +8,7 @@ config VXFS_FS
 	  of SCO UnixWare (and possibly others) and optionally available
 	  for Sunsoft Solaris, HP-UX and many other operating systems. However
 	  these particular OS implementations of vxfs may differ in on-disk
-	  data endianess and/or superblock offset. The vxfs module has been
+	  data endianness and/or superblock offset. The vxfs module has been
 	  tested with SCO UnixWare and HP-UX B.10.20 (pa-risc 1.1 arch.)
 	  Currently only readonly access is supported and VxFX versions
 	  2, 3 and 4. Tests were performed with HP-UX VxFS version 3.
-- 
2.37.3

