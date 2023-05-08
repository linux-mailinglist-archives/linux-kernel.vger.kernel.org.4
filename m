Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BB6FA386
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjEHJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjEHJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:41:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6361A622;
        Mon,  8 May 2023 02:40:58 -0700 (PDT)
Date:   Mon, 08 May 2023 09:40:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683538857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB84Jcch8OFFetmFSfMXy2RoXfFjlXXDdaovbuDB2so=;
        b=nDM+rIOLGepCiWIJEWYDohZ4uJZ77e91RN/hDNHFybCKvWIAmyLI4/scaYbqXtV/pgZEDt
        qpcoJ9zGD5YzzFodGYl0zcBcrZr5ioXgncAD9Dki3Qml/Sdn64Rr2GagEl5148/lsbDz7t
        6hDfMr1OgRgDewsEQjXBSHP6Ufp/z1FqXmarD1vmjNGxvYlJ1Tp08KdawOf4p6divTEVsX
        gjV3uFxOy0SwYDyuUPAILzrDH7jBwNKS0kcsKon1hlycatx+nkNMDVOZnDUxpiwlpG5hcU
        qTJVPx7AGnunmoFMZuC8ASod04+6oeUbes0/9mLs6Pk0r0c3c8lNi2B7lJ073g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683538857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nB84Jcch8OFFetmFSfMXy2RoXfFjlXXDdaovbuDB2so=;
        b=nLxiLZhOs8v3HamlH3e8TlQY6sgvfqcbzwmGO6a7I9s9SEKEUFX9kOc0mo5SI8FDVlGEYp
        DVuFOMNQ8nwNh8Dg==
From:   "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] hwmon: (k10temp) Add PCI ID for family 19, model 78h
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230427053338.16653-3-mario.limonciello@amd.com>
References: <20230427053338.16653-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Message-ID: <168353885634.404.3825970522999354073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7d8accfaa0ab65e4282c8e58950f7d688342cd86
Gitweb:        https://git.kernel.org/tip/7d8accfaa0ab65e4282c8e58950f7d688342cd86
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 27 Apr 2023 00:33:37 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 11:36:19 +02:00

hwmon: (k10temp) Add PCI ID for family 19, model 78h

Enable k10temp on this system.

  [ bp: Massage. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230427053338.16653-3-mario.limonciello@amd.com
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index ba2f6a4..7b177b9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
