Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D85BFAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiIUJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiIUJ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:28:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA028E0FB;
        Wed, 21 Sep 2022 02:28:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id go6so5832505pjb.2;
        Wed, 21 Sep 2022 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bOVe/bW5t/7tlXq1sg3V9ekcp1S+HeZjiUuN7tJUvL0=;
        b=pZleBovTHAACHqYvBs/Sc0VeL0MfAxWMtxA37AUvQfdXFdBu9hNjaCQLlWGAhnCiJc
         ES3KQzmfrOeN6BhCnUY3LjVYWWtZyocVoXsJPduQOUEVncsnbfDDqt8fJPaazBQLKRud
         LPItU0bbr2Y/KNb9J6vd3AXixT3Mj6nnekvhyeMMKhLxdKYiTLkkv9CaaRKjcCpBHGUs
         1HCeoJHHo2QoSaN8nZ3VK2kwQQtc4lZOH/fIakGVWvFXNdXGUl5R1xN4tS2BzB4sJPVx
         P4YmPfgbzlSuezhPbYKroH0RuOdiOXrmOqsKf3Rcqp1BgjxZBCLwWCtjeFdPYc+VtfPu
         UcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bOVe/bW5t/7tlXq1sg3V9ekcp1S+HeZjiUuN7tJUvL0=;
        b=Zt91XefTbwLhGdTnLqHLEpV2UkuIExGkALgfAT0PXCx6ObEyU0tTD3PZveOTaNPaFg
         vS2Q629ABfMJ6ZzvDzQOMFG15QwTCxIKlvNaRv1L5S4w6g3XfvQvzsRGv+ATZPYUvpLi
         7md46fV+ZiwiAJ/pKe1F8v94xTAgNOBwWcHQ9ujOhLL/d/gI8XWS9Mnhz3nfUKq2kZiV
         9YjpQVJfAGSdROEYap80yxf7nCGYDK1fgAKqw7ByBTMBvyliVEqH4iibn9kzRFKSsRRn
         P/C2XdN0xbKTdekL0KqSaMd1SwPU1XN93dvRHO4AaTlGKwOinyyt/rwmjFMDjcUCd/yG
         FWrw==
X-Gm-Message-State: ACrzQf1AWJyt6QTPWuz/IXY6feIS6HTEZ1Y5G4FHGWIlCbyaD3wkXLot
        vvoh1rE0BixmqWDYWOTxHOY=
X-Google-Smtp-Source: AMsMyM43c68+Pn2zNwUL4gQJU8W1T40QS9mpwxTj9AmEHq2+tg12kFZ7gkSiiAsh+GWuyvMeyu4dow==
X-Received: by 2002:a17:90b:3b4b:b0:203:3265:d314 with SMTP id ot11-20020a17090b3b4b00b002033265d314mr8545273pjb.196.1663752520919;
        Wed, 21 Sep 2022 02:28:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm1637271pfk.92.2022.09.21.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:28:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     rafael@kernel.org
Cc:     lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        bp@alien8.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, jakobkoschel@gmail.com, wangxiang@cdjrlc.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next v2] ACPI: APEI: Remove the unneeded result variable
Date:   Wed, 21 Sep 2022 09:28:34 +0000
Message-Id: <20220921092834.230356-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value erst_get_record_id_begin() and apei_exec_write_register()
 directly instead of storing it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
combine the patchs in APEI.
 drivers/acpi/apei/apei-base.c | 5 +----
 drivers/acpi/apei/erst.c      | 6 +-----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 9f49272cad39..9b52482b4ed5 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -125,12 +125,9 @@ EXPORT_SYMBOL_GPL(apei_exec_write_register);
 int apei_exec_write_register_value(struct apei_exec_context *ctx,
 				   struct acpi_whea_header *entry)
 {
-	int rc;
-
 	ctx->value = entry->value;
-	rc = apei_exec_write_register(ctx, entry);
 
-	return rc;
+	return apei_exec_write_register(ctx, entry);
 }
 EXPORT_SYMBOL_GPL(apei_exec_write_register_value);
 
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 31b077eedb58..247989060e29 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1020,14 +1020,10 @@ static int reader_pos;
 
 static int erst_open_pstore(struct pstore_info *psi)
 {
-	int rc;
-
 	if (erst_disable)
 		return -ENODEV;
 
-	rc = erst_get_record_id_begin(&reader_pos);
-
-	return rc;
+	return erst_get_record_id_begin(&reader_pos);
 }
 
 static int erst_close_pstore(struct pstore_info *psi)
-- 
2.25.1
