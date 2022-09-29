Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81325EF585
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiI2MfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiI2MfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:35:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8FF8589;
        Thu, 29 Sep 2022 05:34:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x92so1753509ede.9;
        Thu, 29 Sep 2022 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G1eJs3Mljaulp10lM3s9KZwUJhSiD5Z54QoCFft9nj0=;
        b=QjlvRE6HJ+8CONd62XKDkJ/YO+eolaQgiqltwxHKFo55/Sn56h5/VJVJsVTfyNXPo/
         VpHg5bIlPfbFcPbx7tiVYP4w/SxBbyP8/L+TBnn28aD/wkwxId9Ndxz4lbSIqivrz1wG
         KeBXVklYXhyTTHZCjMIghKCDJISc0R4H2dP/Q/d4CJIWgUzDhrXJehlxPCJiNB9nKPUy
         00z0h7tJ3Bs93OlpkQ6PsiMZfrSTJxYtwfPGwDGawvgIOkp+VOLilccvdAB0SCM6RGD5
         ESBqJjqzMPPiPmuHj5FTt/9vPN2FW70qWJRQD+/PshqhyJEh15thqc59WBK3d7atlBm9
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G1eJs3Mljaulp10lM3s9KZwUJhSiD5Z54QoCFft9nj0=;
        b=yv5T0m9X1X929mkhzTbO2A72383yrB7hFjNZjgqCiOG5RYFfngX86o1mHrFEGHskxO
         orNj9N9VvOuyiXaq2ZZ8woLPtOsiECcdELcjbH/Y+77HxZwRpr+3LamvOzvyyQ2nPIgr
         lToQtQ8kVlhY1B42Y1WghuaiPVV7oEV6ECSgA+ZgKigd+F2sKm2+Wvu8tq9gx5rLNPWW
         B35/iux+2AzJUhQgPmS+nB+RHAP4TsrPBOkZrO0mowLKCSt4IMVUEpxhn8aZRTxb48tV
         9WPJ/536c8kNSoyz7HN4sjGl172IK/nCUlpgdkFynDhc7+S5DAMwQqSU9/wya3sGUX6r
         BPhg==
X-Gm-Message-State: ACrzQf26Uvv74MSsk1fUowY7NdSL5sghvkIyhSlTl+myXrhovomylpvW
        Q4pqvG6UMpOWH0wgNZxT/78=
X-Google-Smtp-Source: AMsMyM7ML/RyoD8oE90RBpNhAwROpSdGmW5R4R5Fdokjsu3StGo9bExGOLdoXvYBGAVhLFTZ6A9SAQ==
X-Received: by 2002:a05:6402:2549:b0:452:8292:b610 with SMTP id l9-20020a056402254900b004528292b610mr3142739edb.199.1664454898120;
        Thu, 29 Sep 2022 05:34:58 -0700 (PDT)
Received: from felia.fritz.box (200116b826e11200b190ebfd45660ea6.dip.versatel-1u1.de. [2001:16b8:26e1:1200:b190:ebfd:4566:ea6])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b00787cb1de743sm763435eja.38.2022.09.29.05.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:34:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
Date:   Thu, 29 Sep 2022 14:34:31 +0200
Message-Id: <20220929123431.23180-1-lukas.bulwahn@gmail.com>
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

Commit fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
converts amlogic,meson-nand.txt to yaml, but misses to adjust its reference
in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in MESON NAND CONTROLLER DRIVER FOR AMLOGIC
SOCS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e14e37c7c734..95caae5c2bb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13360,7 +13360,7 @@ MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
+F:	Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
 F:	drivers/mtd/nand/raw/meson_*
 
 MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
-- 
2.17.1

