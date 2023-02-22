Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4362E69EC97
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBVBzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBVBzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:55:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2A712799B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:55:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxMI_5dfVjH2gDAA--.1426S3;
        Wed, 22 Feb 2023 09:55:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB735dfVj4FA4AA--.37399S2;
        Wed, 22 Feb 2023 09:55:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dmi: Change size of dmi_ids_string[] to 256
Date:   Wed, 22 Feb 2023 09:55:01 +0800
Message-Id: <1677030901-29326-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxB735dfVj4FA4AA--.37399S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WrykGr47JFyUGw43WryrtFb_yoW8JFW5pF
        4Yka4rWF40qws7J3yUXan3XF15ua93ZFyDKFW2kws7uwn8A3WUJay3Jay8CF15Ary8ta40
        gF18Kr15GF1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current size of dmi_ids_string[] is 128, the BIOS date
can not be seen if the total string length of system vendor,
product name, board name, BIOS version and BIOS date is too
long to over 128, it is better and enough to change size of
dmi_ids_string[] to 256 for most cases.

Without this patch:

[    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/202

With this patch:

[    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/2022

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/firmware/dmi_scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 015c95a..37c39f9 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -32,7 +32,7 @@ static u8 smbios_entry_point[32];
 static int smbios_entry_point_size;
 
 /* DMI system identification string used during boot */
-static char dmi_ids_string[128] __initdata;
+static char dmi_ids_string[256] __initdata;
 
 static struct dmi_memdev_info {
 	const char *device;
-- 
2.1.0

