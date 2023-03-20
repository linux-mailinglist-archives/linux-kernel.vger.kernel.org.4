Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A01B6C2563
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCTXFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCTXE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:04:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB26166C0;
        Mon, 20 Mar 2023 16:04:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so53103238edo.2;
        Mon, 20 Mar 2023 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X61cCXaE+hzLqtVmFIuVzim5tWEuqEAHzNDNeWntzc=;
        b=MvmeRaVSCe8klsomnf3mJnsEY51ulK1+6uxJnqgvu4urOW6quiwl+MzBMUbeL3GIA9
         MsYN6pjF06/vTEQpcgnF2Rye6U95lEglqN9XFUXB8bpL54p7C0G0ZlqKdAfNsvkBVgXL
         gRApzuxZQ8QtfsL6LO7mOjCRHNfQj7FHvto8lXhcu2UNo+WC9Rb4CGOUlXm9/MNSnR5a
         7FyAdhyz11UGMX7pbBcfnb/nyYbPp+POzxLW2UJTwtGFZaPvC+hMewzEYKKwssLDKGre
         Bv3q0rEwRh9XKY7Lmc192+7QOwV63qm0fMxgxFm4uI6//ciwEXEn+Qsk2vbd0U458P35
         iY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X61cCXaE+hzLqtVmFIuVzim5tWEuqEAHzNDNeWntzc=;
        b=cbinIe5Q6CXfVZXrIqZcP55MSFofbo8s8Ue3RieWJR1hUOvXsW8K43JFI1j/8dJyzl
         p9LSdC1Q84MQ0OqimAYBx/UspeNLAQglv+uFBwvuXO7DnzBaw3SERSjAWsNmWpFrarbf
         DO8UWh8qwnKM7gZm0mp85UGYg06I+hXSiyexxmcnWJXD7YKQFx3i/yrdrEIXMU7E9ncV
         eC3OQ7ozLfLh348avxotqR+CmXPAJO3V27DRQDrMy9hvQgvx4/Ark0Hcqd8RxoZNpPBX
         sm5Vcy9BV7NTU3HsTNgGB9iBMHLxfOpOz6wCLfJD/3wW5zzqdtqFtINMLVGldSA/9ENM
         mJhw==
X-Gm-Message-State: AO0yUKWCeNfqVn4wmiGUwH2B8QPsS5SWMHo4tfHPUhQs5BVmZADmMTYr
        bOUjEjDqntafAYALMWxLE1xhxKH57LY=
X-Google-Smtp-Source: AK7set9bTQei7X1ViKH2Hqjo4mruuNKD5HQQDKBlF8sx8MkbMtWeQObb2XFIfbtGU/26Kmuny5+ksg==
X-Received: by 2002:a17:906:a84:b0:91f:17a5:b359 with SMTP id y4-20020a1709060a8400b0091f17a5b359mr740698ejf.66.1679353494162;
        Mon, 20 Mar 2023 16:04:54 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090690c500b0093188e8d478sm4956403ejw.103.2023.03.20.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:04:53 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 2/3] staging: greybus: use inline function for macros
Date:   Tue, 21 Mar 2023 01:04:33 +0200
Message-Id: <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
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

Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
static inline function.

it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell what type
it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/gbphy.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index d4a225b76338..03a977056637 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,7 +15,10 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
+{
+	return container_of(d, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -43,7 +46,10 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
+{
+	return container_of(d, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
-- 
2.34.1

