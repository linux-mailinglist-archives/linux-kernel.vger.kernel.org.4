Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535D55C03FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIUQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiIUQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:21:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E1DADCC9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:05:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e5so6398673pfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=THUFniOK+VEaZvk3WrlhDVy764x1MLYSOQIxcILEvxQ=;
        b=X0gOecgOXbR09B7uWiGNA3l57ZH5gzdV7m2fMkuQmBtbM0SHP5TFh/xGTkWyKMdd6k
         bYpQNI35i3B3pvOfI+0U3gvY9f46t3tfzi3Cngcf2p06SP/YugBowaJzwFQnjtycWsIm
         yvQwRVcp/HB0tQHhH92QQfiTU3aLyBnLZx8zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=THUFniOK+VEaZvk3WrlhDVy764x1MLYSOQIxcILEvxQ=;
        b=Am6/dBz4guy56t7XBk4va/i7Fm54PJLCVzc8MasW8HlPfxvI7PIyiUWlvakf9Q7m8l
         FsM+LxRzhANRDarjhZHTYlBRFty6qmPEUTNUov8bouhXBPL4ribYess4Eemmbe40KkP4
         jzAiJ9ql5xYxWtf7dyRurL+EeDxT6AxR0gJCF5tbE2udJPRlhtFgzehBRMuhyL/pKQuf
         FNbrTs+vjP+iHEWrfoQJccee8/cWiOdGozgUCrIC7+G5Dw3rjUmfIs2QEUKVXxbplgQg
         0wfhXU5m/4CuW1gipkRJ8eqx4nfRENNLpWydDZ5xCErxzlZEqqSoPwFHu3eXN41TXUyJ
         4m9w==
X-Gm-Message-State: ACrzQf0JdZ647jvuNRquUzoEC8vWfZDzZoF6BY/mLp9CdZSoHgturf7y
        t8NiRHsLMEAPP8WHxSWi5L4G8nBYiEG4Lw==
X-Google-Smtp-Source: AMsMyM7Y39hoLqgIounsHo+rfvleaY90wBHu2R1tTiv/+BtlKIZ58AXKbEM8mFWmHFs9E7lq3sofGg==
X-Received: by 2002:a05:6e02:1c48:b0:2f1:db4b:66df with SMTP id d8-20020a056e021c4800b002f1db4b66dfmr12601061ilg.35.1663775541555;
        Wed, 21 Sep 2022 08:52:21 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id c14-20020a023b0e000000b0035a8d644a31sm1148061jaa.117.2022.09.21.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 08:52:21 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     rafael@kernel.org, timvp@google.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, jingle.wu@emc.com.tw,
        hdegoede@redhat.com, mario.limonciello@amd.com,
        linus.walleij@linaro.org, Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alistair Francis <alistair@alistair23.me>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Jiri Kosina <jikos@kernel.org>, Rob Herring <robh@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Wed, 21 Sep 2022 09:52:02 -0600
Message-Id: <20220921094736.v5.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220921155205.1332614-1-rrangel@chromium.org>
References: <20220921155205.1332614-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Changes in v5:
- Added Acked-by: Benjamin Tissoires

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index a2fa40dec04ea5..65b7a95956866d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1036,15 +1036,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!client->dev.power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-- 
2.37.3.968.ga6b4b080e4-goog

