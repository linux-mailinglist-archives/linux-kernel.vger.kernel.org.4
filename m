Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14525F3E7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiJDIh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiJDIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:37:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AB637F85;
        Tue,  4 Oct 2022 01:37:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id au23so6530578ejc.1;
        Tue, 04 Oct 2022 01:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6398PXCM0Z75TAhOXIJvZ7VMvOm+wU8M/apzJQ0fPNo=;
        b=Jj8QhHRVv8XhN9gn3Zy3845Ep6P4N74frrh8J0sNy9Nvw6cZWznxO4pAfFKytDI/eI
         hxT50YyaGei0d7lEZGu5Tjq1q5j2QqMGVH46bdZAvFqoWOFZi+iNpiQaLIrDiTskySPy
         NAjOl+xcOvnGKdpu4PyMmTpGjV8VaFqhFpkZjKSdXnx/N6FNXcc/no5e9ku9J5Bcj8Xp
         ICAFBJ5HnF1XGxuI0aSIZpzIRWtNNDXVd+cdct8UjrTwEZIqswMZMRar4T99qJLnjY68
         IK8QbPlcw+DznnZ27auF6JEbvLSc73GnTbAu2YYvw0ZhOoJmx3orZmn6Bx8yKNJ27c1w
         xR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6398PXCM0Z75TAhOXIJvZ7VMvOm+wU8M/apzJQ0fPNo=;
        b=wl//nKRqbIxF2mzzd0AM+bORfJ29CUnr5MeTjDVnuqEef7XAYxUE1LlTBjVPZjXSqP
         Kut2Rcale+5/9BHjciZtwGs9j+gUj1bSBSNz1T2OZGaF3HnF227druoYmM+gedahvTjz
         GSAHjczjPe7M1qnRth+4wVYYJw7q672tAHrT9tieELcl1XYV+155i0cerw3F2x00Ks/C
         Vys1RZi7zro1lN9cThovuZ2ax2rP97VlE9pTLOZBsZSg4+mqRJmoV6HZNN4YSaL3bG5n
         Ko7K+gMM3oi3clEnqHOZfCTdGMr82dPIhUNc/7QW7uivsr3KY5B6jZUBUelYwpx/kRwt
         ceFg==
X-Gm-Message-State: ACrzQf1r6lgW5NwftuLc6JRRyOHPI0NxTagZyS2bA2op/1LQPNZ20bk5
        EMMu8Za65cB00HHY+FluapE=
X-Google-Smtp-Source: AMsMyM7cfAEIqqHDiP3VOzpl6zLgLsij94Pp+OMaOlNjEIfk1WYSByfc/0f+6a0AmTLhdUg0r58joA==
X-Received: by 2002:a17:906:5d16:b0:783:78d5:e47a with SMTP id g22-20020a1709065d1600b0078378d5e47amr18495748ejt.453.1664872640525;
        Tue, 04 Oct 2022 01:37:20 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00787a6adabe9sm6598376ejc.75.2022.10.04.01.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:37:20 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/2] mtd: core: try to find OF node for every MTD partition
Date:   Tue,  4 Oct 2022 10:37:10 +0200
Message-Id: <20221004083710.27704-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004083710.27704-1-zajec5@gmail.com>
References: <20221004083710.27704-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

So far this feature was limited to the top-level "nvmem-cells" node.
There are multiple parsers creating partitions and subpartitions
dynamically. Extend that code to handle them too.

This allows finding partition-* node for every MTD (sub)partition.

Random example:

partitions {
	compatible = "brcm,bcm947xx-cfe-partitions";

	partition-firmware {
		compatible = "brcm,trx";

		partition-loader {
		};
	};
};

Cc: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2211e0ed6cc9..07249af4f890 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -551,20 +551,22 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
 	const char *pname, *prefix = "partition-";
 	int plen, mtd_name_len, offset, prefix_len;
-	bool found = false;
 
 	/* Check if MTD already has a device node */
 	if (mtd_get_of_node(mtd))
 		return;
 
-	/* Check if a partitions node exist */
 	if (!mtd_is_partition(mtd))
 		return;
+
 	parent_dn = mtd_get_of_node(mtd->parent);
 	if (!parent_dn)
 		return;
 
-	partitions = of_get_child_by_name(parent_dn, "partitions");
+	if (mtd_is_partition(mtd->parent))
+		partitions = of_node_get(parent_dn);
+	else
+		partitions = of_get_child_by_name(parent_dn, "partitions");
 	if (!partitions)
 		goto exit_parent;
 
@@ -588,19 +590,11 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 		plen = strlen(pname) - offset;
 		if (plen == mtd_name_len &&
 		    !strncmp(mtd->name, pname + offset, plen)) {
-			found = true;
+			mtd_set_of_node(mtd, mtd_dn);
 			break;
 		}
 	}
 
-	if (!found)
-		goto exit_partitions;
-
-	/* Set of_node only for nvmem */
-	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
-		mtd_set_of_node(mtd, mtd_dn);
-
-exit_partitions:
 	of_node_put(partitions);
 exit_parent:
 	of_node_put(parent_dn);
-- 
2.34.1

