Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E560564D03F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiLNTsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiLNTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:47:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094F42B259;
        Wed, 14 Dec 2022 11:47:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id v8so24118506edi.3;
        Wed, 14 Dec 2022 11:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/pdRu8+DHcrMelvbEuUo+8sJIjuRyafDUypUYPd0m5s=;
        b=mueDwdWaXiiPqMSF4hXy6FtVy02TiPVCU9twXxlMP5lYHcgTETxrSG83SP/hhHirBc
         X3lyQ8ubwxspEvO6U6ftXzcsnOd92zKry6ikSgli94zVfrnDa2/ixP4fU06Unsy1OEEj
         FyvlXBqg4UBLRHCnDJ8wLAgcX7TVjA/f7AXLryCc6PZiJ+2+dsGN0uV20nbR2sPzfQBS
         u0GItbkXwv9YhrQOlNMaqZ04QXcfoIj+Z/vRdhaPnQ5qVUeWuUb17QBRobHBrbdVC5s3
         /jAcNU288q5+y5ljwRWYW4QyhJI0UMzNGe1k0ld94tEAiKX461iRB7MTo3RpyMy2McCU
         b14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pdRu8+DHcrMelvbEuUo+8sJIjuRyafDUypUYPd0m5s=;
        b=lckg2tzx6PelBKW/OIeyCN6b2q/fcWu77hqqOYQA6K12RIj23wncnmp7KZTRDtyyfn
         nu0loPTizNtr018EggLrrW1bgBluePd3KeOGLdN7bwBp2xhTKLE0yiP1CqULXWK2gxOQ
         3J94MbRSmdwW/JJv69gAMG/DYcK0nSm4bbfyLVSv/UpnkvNEgK2My+5gvgD8Zb9rj5YB
         6RVdRSY9XOxiOwm7gKFHFxlJToJWfpNQi/22wpr0Bty2BbYp/xjk6FmfAzCuS10jewaK
         mb6pR89lAb1MHDx052l5Hx07zbSW0l/2gallHZCRiz8LBbZixsd1vmOInZRd3XNUhMq2
         Xq0Q==
X-Gm-Message-State: ANoB5pmCSkvdZGtQIcwBKzqUv/a4nvYU+kw7Hs+oyE7u9e1EFIMJi3ni
        tcNDd4URmHz82+2XL+QhGuyi6Nf6ouw=
X-Google-Smtp-Source: AA0mqf53mN3u+fCBd3RoUE9vTHS5eErQeEO7ojQNeDJnWRuWvAaHyL5eV6u5tkplBiAJs59UVu1Nwg==
X-Received: by 2002:a05:6402:c0b:b0:46c:a763:5889 with SMTP id co11-20020a0564020c0b00b0046ca7635889mr28925680edb.25.1671047260484;
        Wed, 14 Dec 2022 11:47:40 -0800 (PST)
Received: from hal.gr.local.zebar.de ([2a02:8109:8c00:1c73:ecc7:4b4b:dc6c:b68b])
        by smtp.googlemail.com with ESMTPSA id v18-20020aa7cd52000000b0046ae912ff36sm6658701edw.84.2022.12.14.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:47:39 -0800 (PST)
From:   Herman Fries <baracoder@googlemail.com>
Cc:     Herman Fries <baracoder@googlemail.com>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nzxt-smart2) Add device id
Date:   Wed, 14 Dec 2022 20:46:28 +0100
Message-Id: <20221214194627.135692-1-baracoder@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for new device id
1e71:2019 NZXT NZXT RGB & Fan Controller

Signed-off-by: Herman Fries <baracoder@googlemail.com>
---
 drivers/hwmon/nzxt-smart2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 533f38b0b4e9..2b93ba89610a 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -791,6 +791,7 @@ static const struct hid_device_id nzxt_smart2_hid_id_table[] = {
 	{ HID_USB_DEVICE(0x1e71, 0x2009) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x200e) }, /* NZXT RGB & Fan Controller */
 	{ HID_USB_DEVICE(0x1e71, 0x2010) }, /* NZXT RGB & Fan Controller */
+	{ HID_USB_DEVICE(0x1e71, 0x2019) }, /* NZXT RGB & Fan Controller */
 	{},
 };
 
-- 
2.38.1

