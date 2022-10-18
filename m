Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CFC603147
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiJRRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJRRCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:02:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49675EE095
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:02:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k2so33856337ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNFUcsg6CZf4Twcacgk4/TpKqaK+NR+PSADwLx1Qqk=;
        b=NO9Rpc7gw8DAzJvh3gLWr8+d5iG6WcxapUthrhBuntkU2o5NzO/8iuTamVLA9MXUef
         51252nvKL7xcVLOqjbS2w9Bb5VeQL9KTFGmb91bdUa2ErDtAZA9HN2935cd3DrnCuS8n
         8AWDbR2NL5Uz1HOBQnVoP5KJ3aVbsnfFKLVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvNFUcsg6CZf4Twcacgk4/TpKqaK+NR+PSADwLx1Qqk=;
        b=mdprqCnktLZbcdUb2T3CP2gkK/snwmBmvnStvvihEG0cR36kN0xMAMdH4xYJI5lSCk
         HnpHaIwfrEAoI3rkfn0+WT00xrlWfkXEqgMSgImRRtt3eZg8w+ytv4PFRSRho68RmedY
         pv3Wzg7Uy2cqHzjQ+no2YSwoSOESOMTNyXUFmpMNgcTwg60Emnjnb4HXqNS/lOW1Dap0
         lqBQNIZoGb8RizvwLeo8o4VU1CRNRMxks++PoH2Uh6ei7kEiAAypdNRAajjAdsBp7No7
         qq2DbFpsh1OhKlwW0hwKV3q7cONHXy4Bwk1QQOc8eXS4DbZvHpXWrvVbTuNneMErvpkx
         ZxHA==
X-Gm-Message-State: ACrzQf1k7XEdGTpTUy+4eiZMyJNEEcOJ+7m83hA+3lrcC3qnU0ayWPjJ
        t9kfTMSwB+wJNzqiRU8Jy18fXL/zFW7UYQ==
X-Google-Smtp-Source: AMsMyM4q3YBmgS6KrU83dbcB1kBOFrQFy9UtekLB/JjiyoNbuFAncc1vBQQxAPX+fG/ip0Bf8WJ9eQ==
X-Received: by 2002:a17:907:3ea4:b0:78e:25e2:c33b with SMTP id hs36-20020a1709073ea400b0078e25e2c33bmr3113366ejc.603.1666112538617;
        Tue, 18 Oct 2022 10:02:18 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-101-110.retail.telecomitalia.it. [95.244.101.110])
        by smtp.gmail.com with ESMTPSA id d7-20020aa7d687000000b004580296bb0bsm9172616edr.83.2022.10.18.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:02:17 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: nand: drop EXPORT_SYMBOL_GPL for nanddev_erase()
Date:   Tue, 18 Oct 2022 19:02:05 +0200
Message-Id: <20221018170205.1733958-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is only used within this module, so it is no longer
necessary to use EXPORT_SYMBOL_GPL().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/mtd/nand/core.c  | 3 +--
 include/linux/mtd/nand.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index dbd7b06524b3..7737b1a4a177 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(nanddev_isreserved);
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
+static int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
 {
 	if (nanddev_isbad(nand, pos) || nanddev_isreserved(nand, pos)) {
 		pr_warn("attempt to erase a bad/reserved block @%llx\n",
@@ -136,7 +136,6 @@ int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos)
 
 	return nand->ops->erase(nand, pos);
 }
-EXPORT_SYMBOL_GPL(nanddev_erase);
 
 /**
  * nanddev_mtd_erase() - Generic mtd->_erase() implementation for NAND devices
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index c3693bb87b4c..b2996dc987ff 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -999,7 +999,6 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
 
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
-int nanddev_erase(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 
 /* ECC related functions */
-- 
2.32.0

