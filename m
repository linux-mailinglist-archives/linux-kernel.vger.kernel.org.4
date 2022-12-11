Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4393C649477
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiLKNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:33:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4621226F0;
        Sun, 11 Dec 2022 05:33:25 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r7-20020a1c4407000000b003d1e906ca23so1846447wma.3;
        Sun, 11 Dec 2022 05:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM4eZS6DGEGN3Cnizf1+pzBydRrfLEZ8uE7yRxZjfug=;
        b=M/bPEku703yfebe0G/w9NQJej7hferrKeBULGoDdzpNnTt9NagdDR4RvaHhTRwH8a5
         mW++uu1KFz0V4hAwPsHNeI5FIHr0SJKUADokG6Zz5eYbFJDCTQwbi+rHc+jzXEg7jA1P
         2ZavUU/7qEvmwFcRzQ3PgEcr3meFJC+dkjJMaYlFSuDjKRhRXyvFxdF8+BbU3yds2gC5
         UFuOQkL54eJOKVBdgZa6+nrRcPeckbtRxipK6DkdKucm0AoN3Vd3Q9D+hmsEEQCRtZD2
         DgtlbP1VzJgm9LDD01GTvMXjjqzk3IEpSylDGb9aCeWqxy2LL1guq947Xiz1++GlrwZb
         Si9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JM4eZS6DGEGN3Cnizf1+pzBydRrfLEZ8uE7yRxZjfug=;
        b=IKgKag0mqx3MBw63OSmoYpCNkUPFYfZVhULnqe9ojnVspeiO3GOfxYuC4MrWnPfRd+
         abXSxUb5Tk0BQ332ReGAolIE8SVn/GVnPRGEu4v3ibGj6dPnMWvFCUxL4/OfxLM1h3DM
         NR1xh4awMBN+Poe388OqK0TclnY7+5hwKdQX9XpzeBpWTCWcaQPQr3Ga7UF4lVsILokj
         cKOrRxGegcUsIIq+g02R4wZ1eRbBXkfE4CA5dsLdLJZVpQRYLrUlPUs8bpF3+rt3S9Oy
         y+ZOwLiJou4NvQzz7BoyYc6wQcSeqeN285HE9aW/bJFn5z9i3Ocoa2gdaQ6JuDRwgv29
         I44w==
X-Gm-Message-State: ANoB5pk6KNRPsfsceoU4dra0v5DXd+aOnkGdXCoC2dvdl+S+gKEkTS5S
        NHBaJtZ2tVQdpTtg2UU5g/UWh2jYBUUwRQ==
X-Google-Smtp-Source: AA0mqf51xLqGjUmb0nGSAreiMIifJSFrNKimMQeqSk6JWjsdw1ZL4ChTc5j6YdjFtFWJSJvrg1ffqA==
X-Received: by 2002:a05:600c:3ac3:b0:3d2:148b:4a26 with SMTP id d3-20020a05600c3ac300b003d2148b4a26mr5283666wms.32.1670765603606;
        Sun, 11 Dec 2022 05:33:23 -0800 (PST)
Received: from ?IPV6:2a01:c22:a870:9400:1cc5:98f1:2977:d1ef? (dynamic-2a01-0c22-a870-9400-1cc5-98f1-2977-d1ef.c22.pool.telefonica.de. [2a01:c22:a870:9400:1cc5:98f1:2977:d1ef])
        by smtp.googlemail.com with ESMTPSA id l41-20020a05600c1d2900b003c6b874a0dfsm7405690wms.14.2022.12.11.05.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 05:33:23 -0800 (PST)
Message-ID: <ce1a70db-1b0b-ac9e-5829-8110b2ddbbd5@googlemail.com>
Date:   Sun, 11 Dec 2022 14:33:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     ofenfisch@googlemail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
From:   Erik Schumacher <ofenfisch@googlemail.com>
Subject: [PATCH] ACPI: resource: do IRQ override on XMG Core 15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Schenker XMG CORE 15 (M22) is Ryzen-6 based and needs IRQ overriding
for the keyboard to work. Adding an entry for this laptop to the
override_table makes the internal keyboard functional again.

Signed-off-by: Erik Schumacher <ofenfisch@googlemail.com>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index f27914aed..037d1aa10 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -446,6 +446,17 @@ static const struct dmi_system_id lenovo_82ra[] = {
 	{ }
 };
 
+static const struct dmi_system_id schenker_gm_rg[] = {
+	{
+		.ident = "XMG CORE 15 (M22)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -460,6 +471,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ lenovo_82ra, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
 	{ lenovo_82ra, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
+	{ schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.38.1
