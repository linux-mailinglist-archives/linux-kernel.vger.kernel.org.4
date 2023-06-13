Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419EA72EDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjFMVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjFMVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:20:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDB129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:20:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5187aa18410so1143243a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686691201; x=1689283201;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jWvY4U8tYba+wNIbdqcQVeFZy9Nih1yvcvBjp24Mas=;
        b=qRU/dUZpnh2AVwkbsKA44WLQyrmK9X/p/rf9IDKCQ7dB+mze0KgTsdLfaIX5G2wkNS
         yiSAHuQ1Ge+PQVcRvhs9MbIryKEnqv9UkSRDAKl2VSOCdNncZbX1sd2EfqURYQi6VDfV
         exuCx1pEhcm74sgwNmWlXfb2fkCl6L9jYeDLWCzlc1zR4J1MVvQrcNnuLQ8NjSqdnPS+
         c4o/AzAvZ0WGsawlk2bSyJINvtuy4o2KjkMff5ia2un8U/ZoPwWH3cEjrPFbW0jGXL6o
         0uax62fbwF84CRgCFWS5TdWKFckCZGQT3s+RQ/fzY4MGeXb+WPqGziPP4+e45OSg4SxI
         Ul3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691201; x=1689283201;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jWvY4U8tYba+wNIbdqcQVeFZy9Nih1yvcvBjp24Mas=;
        b=j5cE1J6/uNBbAHulEl+Oe0i725LXPDJ6/+MhwnRpR3QpsaP7EocelDsB/H2nFaY//0
         2ISRBmR1+8z3+xUkB/iCrFZQwhyTwZEQwBMeO9Q2cwZVA23+rtG5ntHQWC/xRWTV84WU
         yDKRQDXRMqcUqvLGp2BTkv/Yi868eMyHM0ZVfEgAfXAnjb+PE1LR2gMBYeQkRtJAZKZM
         Fev645OMc05Qkev4zjVkRzMIHcvU1xwsy3reKItC+3wttv5R9GaCbUnVKK9bDcY9EV6v
         tP+nYJS3siXYbDgBnir2qzl2QeoOI3POqM2lmVWnUMr9ivaIkzFUek6gcFRBHsG1z7Fi
         4jkw==
X-Gm-Message-State: AC+VfDx1m1Eg7TlhvMyyQi6k615LMCwAMDthgM4fPs2VOVibI45CraXV
        kmGhQ8Zsha5gKI4URcsrDE4=
X-Google-Smtp-Source: ACHHUZ7ttPM6Lmzp02stCVrPtQ12GVqkzGdupAadZLlbQZwynuS3qmelOCVeX/cFVP2wQFJlS/feKA==
X-Received: by 2002:aa7:ccda:0:b0:518:7a40:b75e with SMTP id y26-20020aa7ccda000000b005187a40b75emr1817076edt.25.1686691200508;
        Tue, 13 Jun 2023 14:20:00 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b00514a97b6b80sm6922313edo.78.2023.06.13.14.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 14:20:00 -0700 (PDT)
Message-ID: <aaf4580a-a368-8f70-c9c4-21b5ed4dd599@gmail.com>
Date:   Tue, 13 Jun 2023 23:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 1/2] mtd: rawnand: add basic sandisk manufacturer ops
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic Sandisk manufacturer ops support to get
SDTNQGAMA timing data with the nand_get_sdr_timings()
function.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V3:
  Separate serie
  Change prefixes

Changed V2:
  New patch

---
Limited to one chip model for now.
In need for someone with better knowledge of the Sandisk product
range to expand and improve. Documentation is rare to find.
---
 drivers/mtd/nand/raw/Makefile       |  1 +
 drivers/mtd/nand/raw/internals.h    |  1 +
 drivers/mtd/nand/raw/nand_ids.c     |  2 +-
 drivers/mtd/nand/raw/nand_sandisk.c | 26 ++++++++++++++++++++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/raw/nand_sandisk.c

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 917cdfb81..d93e861d8 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -67,5 +67,6 @@ nand-objs += nand_esmt.o
 nand-objs += nand_hynix.o
 nand-objs += nand_macronix.o
 nand-objs += nand_micron.o
+nand-objs += nand_sandisk.o
 nand-objs += nand_samsung.o
 nand-objs += nand_toshiba.o
diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index 7016e0f38..e9932da18 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -73,6 +73,7 @@ extern const struct nand_manufacturer_ops hynix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops macronix_nand_manuf_ops;
 extern const struct nand_manufacturer_ops micron_nand_manuf_ops;
 extern const struct nand_manufacturer_ops samsung_nand_manuf_ops;
+extern const struct nand_manufacturer_ops sandisk_nand_manuf_ops;
 extern const struct nand_manufacturer_ops toshiba_nand_manuf_ops;

 /* MLC pairing schemes */
diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index dacc5529b..1a89ed796 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -188,7 +188,7 @@ static const struct nand_manufacturer_desc nand_manufacturer_descs[] = {
 	{NAND_MFR_NATIONAL, "National"},
 	{NAND_MFR_RENESAS, "Renesas"},
 	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
-	{NAND_MFR_SANDISK, "SanDisk"},
+	{NAND_MFR_SANDISK, "SanDisk", &sandisk_nand_manuf_ops},
 	{NAND_MFR_STMICRO, "ST Micro"},
 	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
 	{NAND_MFR_WINBOND, "Winbond"},
diff --git a/drivers/mtd/nand/raw/nand_sandisk.c b/drivers/mtd/nand/raw/nand_sandisk.c
new file mode 100644
index 000000000..7c66e4187
--- /dev/null
+++ b/drivers/mtd/nand/raw/nand_sandisk.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "internals.h"
+
+static int
+sdtnqgama_choose_interface_config(struct nand_chip *chip,
+				  struct nand_interface_config *iface)
+{
+	onfi_fill_interface_config(chip, iface, NAND_SDR_IFACE, 0);
+
+	return nand_choose_best_sdr_timings(chip, iface, NULL);
+}
+
+static int sandisk_nand_init(struct nand_chip *chip)
+{
+	if (!strncmp("SDTNQGAMA", chip->parameters.model,
+		     sizeof("SDTNQGAMA") - 1))
+		chip->ops.choose_interface_config =
+			&sdtnqgama_choose_interface_config;
+
+	return 0;
+}
+
+const struct nand_manufacturer_ops sandisk_nand_manuf_ops = {
+	.init = sandisk_nand_init,
+};
--
2.30.2

