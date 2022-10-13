Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C15FE486
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJMVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJMVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:50:11 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0ADA196
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:40 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u15so3215442oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=QcsGS9pCWiz35HaFjQpA6eM2fSoaXtjyWfVqthwui1E=;
        b=FZ7FEH1Wtrfc9QDdVOBy5CzCdQhRkY6lPlCovTkrAJ4Wh9FN4spjoHS9PV8HOBP7T3
         af2yX/KcAkgzwJyFTmvotX96clBIeQmitTOD+w/3NjyKZsxBmB5o8VvEo63AQATDSVuM
         C9612TblOhlUt6rSuhjjWLgmIrdWHhLxBe1By8Ms4z/A+F9CgMAUOr96Ult+f2kaCY4A
         6zL8YxuUlNsVCfw8VLiRmm4thJwAvfclRK4ykqo3VDCH8j47rKTqKzk+Y2N1dqfguKF0
         w79VxKzuzaK1+EH3rRxWQCTR7CMW6NJsGSwHlnC5X5SGxWOanF2QM7JIyZN0ldbR/SBJ
         yDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QcsGS9pCWiz35HaFjQpA6eM2fSoaXtjyWfVqthwui1E=;
        b=w+ln02Kv/kfBIX6vKLIXwwnMgcvOER86hPbLodyc1eyWYrBacFuP1X4F4WBCEO1rEU
         BdXctQRo4DjsnGiDBbQ22zcoscFVRazmFbDlXd1a3pwfpA/LmiUa1OdhOjn6y5NN3pUC
         3qltgYE+aqjET9h+sc/tZBxXGwTfeR5b+gBeKy+zNWByKL0VJWq+z0WBmPFFLxviIZin
         tK5arms3/qcEsNguqP7rQ/x/40QKawizvVemvFJPtb4IbCj6C5i9Nz3d3jkyCvwrd/Y0
         MOcabpmxPgk9aC+tv+OqdgEZUWUaTeSPoB5VaVdi25k2aKP9qq4VfffYB63tdbUjPUPC
         4z+w==
X-Gm-Message-State: ACrzQf3uC7ImK6rXNN5VPicIeS+0csbk/46AcF4OE+0VE+QOCnmtpY2K
        Xe5/OFZuKNFbV1c9tVAof5dwCIAxSyCtd2GA
X-Google-Smtp-Source: AMsMyM4VnoT30K0ug4Hx0ZMJskQ5b6cv20L2wg9XQl6F+sqxa9afE9MTp11Uc83yVDcSkysywN8UMA==
X-Received: by 2002:a17:90b:3850:b0:20d:54f2:a780 with SMTP id nl16-20020a17090b385000b0020d54f2a780mr13570971pjb.115.1665697760519;
        Thu, 13 Oct 2022 14:49:20 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 5-20020a630205000000b00442c70b659esm159138pgc.91.2022.10.13.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:20 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for ndyer
Date:   Thu, 13 Oct 2022 14:46:39 -0700
Message-Id: <20221013214639.31094-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org,
           Palmer Dabbelt <palmer@rivosinc.com>,
           Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     nick@shmanahar.org
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
index 79f17e53cb30..f552f839dd32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3372,7 +3372,7 @@ F:	drivers/net/ethernet/cadence/
 ATMEL MAXTOUCH DRIVER
 M:	Nick Dyer <nick@shmanahar.org>
 S:	Maintained
-T:	git git://github.com/ndyer/linux.git
+T:	git https://github.com/ndyer/linux.git
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
-- 
2.38.0

