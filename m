Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365B6D6A85
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjDDRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjDDRX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802235FDF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so133640503edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWNaFjjalHwpYTlFI10ff7cViPg4jdonFx6GrJYQjf8=;
        b=qTt1wU5ZCDaAEz5fBVWHiMsHvtaUHaWDjMbKnjrfv95y8t6TugeagPxy+QM+fNLRrL
         NOedmsRO1sTNoOD9WI4dfMw9hT7ShcSxr79ms6aH0zdwHcuGnf56fN+/nFvmtWAtK5Uq
         tpaGZ+CAXBBqTB5L1rfgpwJ864/vZkwR/rM3g0E+TiyBmbElaHC2cOahEj2YesXiX/9G
         7sn5xhW57/fw8Nu92zc9pg5rdgQWtOtArWFxvArSrKl/NJN3E0WHxrAJRf04PNKfBi25
         MUgM0Q+ioBg7NFYWi+mGYhWGN3dXKvqTEQ7/m6nxZK7jSq//G7MQ+KMgka9YhpgzbWh9
         /SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWNaFjjalHwpYTlFI10ff7cViPg4jdonFx6GrJYQjf8=;
        b=1v6CLKG824yo8iTnKp9JdAounemVmqRqCBeUUhdN1lsNXelUZ5HGOsBiPRZ3dl6Upa
         eahPTcbhK8YassQB3M0kCzwkC83jO9l8+YQRwOn7ej11tF89p5eWIAocq775UvwcRN2z
         +JWblSqSoS27PRcBnZIp0WZWF0MbHt2NBhZpwsrCppF0NHCSKjhgs9V5lC02F+LTBtaY
         bjrFhWLZmQXmq4T1JHb/WjPwZgqDmWfEp0SXdWncOxcjSl7YBRid1C6iuCEjJTPy+iNP
         6IoxdWKKH0hbGi4bnrc/X5psaMubjmaaB7a5Vp14SMwCygxTpJwRt2oXOZOl/YiVkVoP
         bIeQ==
X-Gm-Message-State: AAQBX9fhJYBQdqoNvOz7I38Ro7UlWwChET02UMIk1atMRbSaXVN+Pms2
        3SGRz3gikpCfRhikT0ORWNfzoQ==
X-Google-Smtp-Source: AKy350ZBRe4bdYk1W67YW57UF0cZmvQp8VXkUcHNgIADK+bT/Zd2bV+erfY6GpZ+e8KjuprszH1KXw==
X-Received: by 2002:a17:907:9607:b0:930:3916:df19 with SMTP id gb7-20020a170907960700b009303916df19mr485434ejc.5.1680628997109;
        Tue, 04 Apr 2023 10:23:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 40/40] nvmem: layouts: sl28vpd: set varaiable sl28vpd_layout storage-class-specifier to static
Date:   Tue,  4 Apr 2023 18:21:48 +0100
Message-Id: <20230404172148.82422-41-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
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

From: Tom Rix <trix@redhat.com>

smatch reports
drivers/nvmem/layouts/sl28vpd.c:144:21: warning: symbol
  'sl28vpd_layout' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/sl28vpd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/sl28vpd.c b/drivers/nvmem/layouts/sl28vpd.c
index 9cc1715c2fd5..05671371f631 100644
--- a/drivers/nvmem/layouts/sl28vpd.c
+++ b/drivers/nvmem/layouts/sl28vpd.c
@@ -141,7 +141,7 @@ static const struct of_device_id sl28vpd_of_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, sl28vpd_of_match_table);
 
-struct nvmem_layout sl28vpd_layout = {
+static struct nvmem_layout sl28vpd_layout = {
 	.name = "sl28-vpd",
 	.of_match_table = sl28vpd_of_match_table,
 	.add_cells = sl28vpd_add_cells,
-- 
2.25.1

