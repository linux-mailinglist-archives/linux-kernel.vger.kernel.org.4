Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC4653E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiLVKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiLVKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:38:33 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Dec 2022 02:38:29 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A676542
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:38:28 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202212221037241505da12e8e9da2411
        for <linux-kernel@vger.kernel.org>;
        Thu, 22 Dec 2022 11:37:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=henning.schild@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FKMNskZUyu+3zsjd2lYrkSASIEGUhfqqUjLO0ieJ4pU=;
 b=ArRN8+AZRJ21b/InE16Ovq09jtA0kZ86UoY6Y2hvO0FT3oYU1mBTF4KXXkGNVYo0RGslvz
 eUK64wWSYQrGzTVVHdSAcSQTks7fQOtS/CZNbb+M8mPbpiydYMAjtwHgdOY84jHSOUtYMs9w
 B5YFuZMgUmgFjtPSgiY8IYr79m4Hc=;
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/2] platform/x86: simatic-ipc: add another model
Date:   Thu, 22 Dec 2022 11:37:20 +0100
Message-Id: <20221222103720.8546-3-henning.schild@siemens.com>
In-Reply-To: <20221222103720.8546-1-henning.schild@siemens.com>
References: <20221222103720.8546-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-52304:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPC PX-39A support.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 1 +
 include/linux/platform_data/x86/simatic-ipc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 2ab1f8da32b0..b3622419cd1a 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -47,6 +47,7 @@ static struct {
 	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
 	{SIMATIC_IPC_IPC477E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_427E},
 	{SIMATIC_IPC_IPCBX_39A, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+	{SIMATIC_IPC_IPCPX_39A, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G},
 };
 
 static int register_platform_devices(u32 station_id)
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index a4a6cba412cb..a48bb5240977 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -33,6 +33,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC127E = 0x00000D01,
 	SIMATIC_IPC_IPC227G = 0x00000F01,
 	SIMATIC_IPC_IPCBX_39A = 0x00001001,
+	SIMATIC_IPC_IPCPX_39A = 0x00001002,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.38.2

