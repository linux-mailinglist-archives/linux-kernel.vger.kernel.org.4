Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADDF6D3A2A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDBUKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDBUKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:10:18 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006EF3586
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 13:10:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so109540218edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680466213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnxQcOPVYR7k4CaWywjABG48rhsOcDbUEyAkzN67jW8=;
        b=HXrO6Iv+msAIRLMyfiiOA5kgnymy+5OPmnzyNvz5T3phIb7inN94B5NfeW3invv5Dx
         14lRxTM1SCca26QYwaWBT99TfFbtx9iyQiOAlcGFnCOpXRmslcYN5GGQ1A13GC/hn3Nm
         fFlREChISwZ8TLwKbA7sFpOHXKz912jL1kw1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680466213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnxQcOPVYR7k4CaWywjABG48rhsOcDbUEyAkzN67jW8=;
        b=8QTRhhvajOkmkSrkE+fuBYWgINBqmRj+Rn+LYEr6MmaNxY7eZppEaQ6TrnDgy/OnVa
         mZREMxtSdBhPI2p1IqWYLWIk/qo14gPz7B1ca7V0fo/YtzsBWfT8T2RkGcQ9kC8nogr6
         IdUXFq7VZcGbbLpdTA48lXS+aA9DMcMCkhjwpDC8P8iCl+3oyIalrVA1AmQUCL8uHvnB
         VRTNYJp8Ix9K/roEf45jk2xDvUp5nMgUtitjI3VLtxiI+PcUc8DEjQQltBib0cjuDMZS
         qkXll3djWOJmorp/+zmHm4gCIP94Wploc0YchxXR48Z0v5d3Ru2rT4iasnvDA0GG4Zqc
         iePw==
X-Gm-Message-State: AAQBX9eE8xOkXlzL02MDQvYFqzHw6x3xXZhp8PkU3aIBBLPBVEv920LY
        XiJ0kN9UEFfeepliz/XZn0jgcN5WG34KId3dnBM=
X-Google-Smtp-Source: AKy350aF3K6mdvb0KQu5hX2QaXeyFNvhkq14byiQ89idii4MKdAdLF74v35B/POymS0/8Fc3+a8LeA==
X-Received: by 2002:a17:907:3e1a:b0:932:853c:c958 with SMTP id hp26-20020a1709073e1a00b00932853cc958mr41589723ejc.25.1680466213180;
        Sun, 02 Apr 2023 13:10:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-248-31-153.retail.telecomitalia.it. [95.248.31.153])
        by smtp.gmail.com with ESMTPSA id gl18-20020a170906e0d200b00924d38bbdc0sm3553127ejb.105.2023.04.02.13.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:10:12 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 1/9] Input: edt-ft5x06 - fix indentation
Date:   Sun,  2 Apr 2023 22:09:43 +0200
Message-Id: <20230402200951.1032513-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
References: <20230402200951.1032513-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matches the alignment to the open parenthesis as suggested by
checkpatch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 36 ++++++++++++++------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 2746649561c7..daba6472fc65 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -241,11 +241,11 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 	/* M09/M12 does not send header or CRC */
 	if (tsdata->version == EDT_M06) {
 		if (rdbuf[0] != 0xaa || rdbuf[1] != 0xaa ||
-			rdbuf[2] != datalen) {
+		    rdbuf[2] != datalen) {
 			tsdata->header_errors++;
 			dev_err_ratelimited(dev,
-					"Unexpected header: %02x%02x%02x!\n",
-					rdbuf[0], rdbuf[1], rdbuf[2]);
+					    "Unexpected header: %02x%02x%02x!\n",
+					    rdbuf[0], rdbuf[1], rdbuf[2]);
 			goto out;
 		}
 
@@ -618,7 +618,7 @@ static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 					  tsdata->offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
 		edt_ft5x06_register_write(tsdata, reg_addr->reg_report_rate,
-				  tsdata->report_rate);
+					  tsdata->report_rate);
 
 }
 
@@ -757,7 +757,8 @@ DEFINE_SIMPLE_ATTRIBUTE(debugfs_mode_fops, edt_ft5x06_debugfs_mode_get,
 			edt_ft5x06_debugfs_mode_set, "%llu\n");
 
 static ssize_t edt_ft5x06_debugfs_raw_data_read(struct file *file,
-				char __user *buf, size_t count, loff_t *off)
+						char __user *buf, size_t count,
+						loff_t *off)
 {
 	struct edt_ft5x06_ts_data *tsdata = file->private_data;
 	struct i2c_client *client = tsdata->client;
@@ -965,12 +966,12 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 		case 0x70:   /* EDT EP0700M09 */
 			tsdata->version = EDT_M09;
 			snprintf(model_name, EDT_NAME_LEN, "EP0%i%i0M09",
-				rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+				 rdbuf[0] >> 4, rdbuf[0] & 0x0F);
 			break;
 		case 0xa1:   /* EDT EP1010ML00 */
 			tsdata->version = EDT_M09;
 			snprintf(model_name, EDT_NAME_LEN, "EP%i%i0ML00",
-				rdbuf[0] >> 4, rdbuf[0] & 0x0F);
+				 rdbuf[0] >> 4, rdbuf[0] & 0x0F);
 			break;
 		case 0x5a:   /* Solomon Goldentek Display */
 			snprintf(model_name, EDT_NAME_LEN, "GKTW50SCED1R0");
@@ -1051,14 +1052,17 @@ static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 		tsdata->offset =
 			edt_ft5x06_register_read(tsdata, reg_addr->reg_offset);
 	if (reg_addr->reg_offset_x != NO_REGISTER)
-		tsdata->offset_x = edt_ft5x06_register_read(tsdata,
-						reg_addr->reg_offset_x);
+		tsdata->offset_x =
+			edt_ft5x06_register_read(tsdata,
+						 reg_addr->reg_offset_x);
 	if (reg_addr->reg_offset_y != NO_REGISTER)
-		tsdata->offset_y = edt_ft5x06_register_read(tsdata,
-						reg_addr->reg_offset_y);
+		tsdata->offset_y =
+			edt_ft5x06_register_read(tsdata,
+						 reg_addr->reg_offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
-		tsdata->report_rate = edt_ft5x06_register_read(tsdata,
-						reg_addr->reg_report_rate);
+		tsdata->report_rate =
+			edt_ft5x06_register_read(tsdata,
+						 reg_addr->reg_report_rate);
 	tsdata->num_x = EDT_DEFAULT_NUM_X;
 	if (reg_addr->reg_num_x != NO_REGISTER)
 		tsdata->num_x = edt_ft5x06_register_read(tsdata,
@@ -1306,7 +1310,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	touchscreen_parse_properties(input, true, &tsdata->prop);
 
 	error = input_mt_init_slots(input, tsdata->max_support_points,
-				INPUT_MT_DIRECT);
+				    INPUT_MT_DIRECT);
 	if (error) {
 		dev_err(&client->dev, "Unable to init MT slots.\n");
 		return error;
@@ -1320,8 +1324,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	irq_flags |= IRQF_ONESHOT;
 
 	error = devm_request_threaded_irq(&client->dev, client->irq,
-					NULL, edt_ft5x06_ts_isr, irq_flags,
-					client->name, tsdata);
+					  NULL, edt_ft5x06_ts_isr, irq_flags,
+					  client->name, tsdata);
 	if (error) {
 		dev_err(&client->dev, "Unable to request touchscreen IRQ.\n");
 		return error;
-- 
2.32.0

