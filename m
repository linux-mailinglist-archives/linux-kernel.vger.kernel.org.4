Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30E65FE47A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJMVtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJMVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:49:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E036BF6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i3so3115359pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=HU/Gcb/2UahetsVrfFKFSRpifT9WH9AovTUmej45BRM=;
        b=SXetiZgzOZy/gRXhaW1c45RlvPilcMDdnFIzQYxFCkLqDpOjY0zv/u+xapn1G9pin8
         x0aKVLobV7U3pIoDH4luAyRfpGtgJ8G+DbIhypSGdzj2+L9m858860OyjsDJzk4g6yHc
         6Fat5EM06SW6JlueCAJml+Pbsm+KE7dl4WPx2/rhe1trQXOESw3l03tBAABzupHfz+iX
         h4sQ8Ev5HFUYF6pH7RILs1nAGJD72ttEpKbqW6x47Hb7LDpoKY6zKpF6rpSLovkrEn5N
         DmfiV/pupk3XlkkHfh0/bB+7sICDbVsf1h610RdYVs7HHE8zEvkncyoLlVNHQRbTs/1E
         Sq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU/Gcb/2UahetsVrfFKFSRpifT9WH9AovTUmej45BRM=;
        b=T5sujewslUl1DePycdCF++p25TqDs+yjyaT/YaNjVTBEIQt7wYKRy9A9m5GVPi2X8Z
         SDtBwbm62DCFHmFoKgf26eYsOqQbpukwM7bDdmuE1NJYH+K09vchkrWqWADzKXTzDQNp
         b+juV9D5aLFCmXnLXiYoiDHcQcWMAiAWx381thowpwXX5B5m2FMiP5GvXHrX3EFv0sgs
         K5d036kdFGkG4GeQ4DGkQWR2upVGJzbmnsjzm2Dhd+oo7xFTuS3U8rD1/kxBT7guNUKI
         VxDj/aCFUzzX59vXGISTBC+zkyL0gQr/5B6n+bNfniDfPkidcm60aLogehRvZLZ/w9uf
         aCIA==
X-Gm-Message-State: ACrzQf2gsx1Yi6J+AIa9nieRzPUB8oaaqh2MshabI+OUBiF2aY+4f4ZM
        ca2EaQXdBsYS2fEmQHP8XpCOgvwQLUdAp0vQ
X-Google-Smtp-Source: AMsMyM60OkHIOwoPqQ6hTn09WuntLhSe+6TG9sOifv9QZgzwwhSqU+qtIUu+gCz5eCx/9FtHd8DBew==
X-Received: by 2002:a65:4585:0:b0:464:4538:c0bc with SMTP id o5-20020a654585000000b004644538c0bcmr1701513pgq.455.1665697747885;
        Thu, 13 Oct 2022 14:49:07 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z188-20020a6233c5000000b00561c3ec5346sm164607pfz.129.2022.10.13.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:07 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for jonmason
Date:   Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30913-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9c396e2d8a0..796ba37dd4ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14465,7 +14465,7 @@ M:	Allen Hubbe <allenbh@gmail.com>
 L:	ntb@lists.linux.dev
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
-T:	git git://github.com/jonmason/ntb.git
+T:	git https://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
-- 
2.38.0

