Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7979A62BEA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiKPMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKPMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:50:26 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E0B3D;
        Wed, 16 Nov 2022 04:50:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 21so26418664edv.3;
        Wed, 16 Nov 2022 04:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiGro6ozvASLxm710qclktaIhbfsoyOS4Qzb18JkaHI=;
        b=fxTvvyRqzMF0aRrGwb85R8pbPp8jXrXXb0R6XLrj8JyUCHFjzuH4cFvn7e/Yk6zCXC
         jZvmUvnw5aTeS7TxqqcuuZrOtw32WjuGWv1CbhgjO7+oX/T3vv3Mb+f4sjwyO6xrQeB/
         HtcGdu/X5ymbvMURCshBldUlfq8NMGizmrbNDieUqyPI/5hHFC5/xDgBtAtS/J//MR9E
         iJnjhVtjhYdj7+48rfKLqhf1xoNa1jFwdGCBD9US1CZtp6+Iuh4uCJFDyzEFeuQQn4r0
         asJHsNYLaF013MWBt19AYQm7bQIU/L3I4ysLGT9/c26IozYuZ41TjuqvYsTdNu6iw+wS
         jbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGro6ozvASLxm710qclktaIhbfsoyOS4Qzb18JkaHI=;
        b=MEyKzVsF4ZJ10fJWlPWjLQd9SMogV01Nnec8gc5iaGOr7KN3iDcwyOmWjsH8sRczun
         NuY3Vq3LfmwdXNhW0S6kKU7EzaGyNuwPicmu3wrtxc4nnuNOY3xnuGjCX6BrHLM7DMqH
         eR+qUQbSUNBrNYg2EczF3OZRH8oJlvdTC93sR8z2e6fcQSRAPvq1upKFIxLjeVwrgGKJ
         amjHT9DK5wMwsZwvxGKG00K+AUpQwDcfrSPl4uX4wxBfGKPO1qsHg58vv9rrekyRljEZ
         qNnV9Phhk6GX67XQGFrYv8wzCioxLd/jUXU3AAKePL7pCJ4RnWJnFamF1nCKEmExdD2d
         +DMQ==
X-Gm-Message-State: ANoB5pmF+qfLoVKwTHC4wS6Sq+wzEYFPPdTY3rdJgim7vaX1KMcpM42O
        vh8o42hBAcw4e8ge7CxivK8=
X-Google-Smtp-Source: AA0mqf7lyRizo8KsR7noBHMDFnXAq2zDiXHyiUBLhzcX3gG3UHIlwai5NPf2VPyY9Fuy7wP6zehjXQ==
X-Received: by 2002:a05:6402:413:b0:463:a83c:e019 with SMTP id q19-20020a056402041300b00463a83ce019mr19078409edv.253.1668603022157;
        Wed, 16 Nov 2022 04:50:22 -0800 (PST)
Received: from felia.fritz.box (200116b826c55000c59461cca0b9a159.dip.versatel-1u1.de. [2001:16b8:26c5:5000:c594:61cc:a0b9:a159])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090630cc00b00780b1979adesm6833452ejb.218.2022.11.16.04.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:50:21 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908
Date:   Wed, 16 Nov 2022 13:49:32 +0100
Message-Id: <20221116124932.4748-1-lukas.bulwahn@gmail.com>
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

Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.

Probably due to concurrent development, commit 002181f5b150 ("mtd: parsers:
add Broadcom's U-Boot parser") introduces 'Broadcom's U-Boot partition
parser' that depends on ARCH_BCM4908, but this use was not visible during
the config refactoring from the commit above. Hence, these two changes
create a reference to a non-existing config symbol.

Adjust the MTD_BRCM_U_BOOT definition to refer to ARCH_BCMBCA instead of
ARCH_BCM4908 to remove the reference to the non-existing config symbol
ARCH_BCM4908.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/mtd/parsers/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index c258ba2a3a6f..daeae79e64f9 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -22,7 +22,7 @@ config MTD_BCM63XX_PARTS
 
 config MTD_BRCM_U_BOOT
 	tristate "Broadcom's U-Boot partition parser"
-	depends on ARCH_BCM4908 || COMPILE_TEST
+	depends on ARCH_BCMBCA || COMPILE_TEST
 	help
 	  Broadcom uses a custom way of storing U-Boot environment variables.
 	  They are placed inside U-Boot partition itself at unspecified offset.
-- 
2.17.1

