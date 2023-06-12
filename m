Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F372C945
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjFLPDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbjFLPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:03:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3AF193
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5147f4bbfdaso6223999a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582217; x=1689174217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3hduzuBSaxb22Mp/MQNps6D7J398rtVmcYbSbMQMqAA=;
        b=HZE9ePUeklvDjtpKtqnpLU8kERqxtrhLujkNuviMPAZFzdqmLPnnCpV1xlQ9EVPlXf
         PKZSesP0sKydEdNv6wGB+Ie4WoJRqF11sSX1En2KgXThWdt+9wyOoiaT+lqlcT0iMAnh
         e8Jj26C3s1nB3+JTDTuPyuymr3YxsKiLp7B5MNoZ+GfdAhG52TG6zSeR8Rmis90/jE/g
         jb42By6+iJymx0yBgXE7xa08LuLMnKnLguCQ5NDozgQiTsiwH+N5HoPUcJDulP1PZa1D
         WCIrRh5xLqWjdgfn5BWCYTIbQ/Qzt7+0TXcWZn0TaRrGszi2wVO0B9i95DNip++shVNN
         moQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582217; x=1689174217;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hduzuBSaxb22Mp/MQNps6D7J398rtVmcYbSbMQMqAA=;
        b=aC9lDUNm9Jt2DPkx3Rdz/W7UXN+C1Mvfs9tgYtQhlISUTnm7t7jKKWxQ5pRnel3C0o
         7sLzOOusqurElO8b1Az3VQgY4FT3FUzbdVrrPS2FxebYa9EgiXhKq/edcpfmMdeqgv/g
         bGjkcoIhLKfqEEh9wL6OPfnpdTtuhTAr9YC8V6yr2wgKM51q/SvFWc3H/nJgKcnBJwzO
         ND//8FrosQSXvQZ5cpWp3aDQeWu+pDaB+BJRX0Wn2URw6X+56spjXZKVgqedYkGDA3ja
         5XwvpGpw2hKtyCE/RXfjXTCThiFVBHJNvpZjgjuyHS4Qfv5x1AKFRIOnAiUhAd1N65KT
         5eQA==
X-Gm-Message-State: AC+VfDwPMo1ASLbp3jDi3EX6s4rQeupDGdAoXHPJI9zzjHePnKTBjdOY
        PcRr3HIEzR0IMUb0f2ytKSU=
X-Google-Smtp-Source: ACHHUZ6fqgTKr/hRQnzqwp3paah/caYkP5AtFmnGC+A7mYwkejgfibrJFYryYqFC788qdUmdp0M56Q==
X-Received: by 2002:a05:6402:8c1:b0:514:9e07:f33f with SMTP id d1-20020a05640208c100b005149e07f33fmr4779364edz.20.1686582216923;
        Mon, 12 Jun 2023 08:03:36 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c74d000000b0051823c1a10bsm3454421eds.54.2023.06.12.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:03:36 -0700 (PDT)
Message-ID: <86aaf385-3c0a-21d9-46fe-f84ee26efbc6@gmail.com>
Date:   Mon, 12 Jun 2023 17:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 4/5] mtd: nand: raw: add basic sandisk manufacturer ops
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
References: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
Content-Language: en-US
In-Reply-To: <11e16c3b-6f7b-a6a9-b0ed-b7ac0cd703e3@gmail.com>
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

