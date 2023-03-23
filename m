Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6856C611C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWHsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCWHss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:48:48 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490E3C06
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1679557722; bh=RmpGlYG4FoshPFhy10u7baOgH7lztF14xIMw0Eycjzw=;
        h=From:To:Cc:Subject:Date;
        b=e6exhZ9VnShn1ScAggl1iQb5wmHiHnT4GBgCrruv2TOtfQDF0hahvD8bjynXU90vf
         u5nahP2gW9DPHoQQo72WhBuN3xpRF1O4ZioO7xeWZ5tNnassjeVwVEwbOO/hyDTWBy
         lJfUuFm5V3AxIa17cBUs8hpbsl4j1Dj8uMataDfc=
Received: from kasumi-star.localdomain ([183.52.244.165])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id A13B185A; Thu, 23 Mar 2023 15:40:19 +0800
X-QQ-mid: xmsmtpt1679557219tq44vf6k1
Message-ID: <tencent_05E1F458BDC2625F47DA84DCA219A830D407@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8IjvNU5WLVHtkfU1cLYXLFfEEEkIs1twCA6Hjg2KEpAej6BlCtw
         QE07Ht3Y4IOP4Z1MbnBRJakXokUrsV91rp5C34PB3MtJ9I5B6kqVSqR69om1xtjemsPP5V4IEFft
         E/buXjh3bfukbeA7Z5f9Ow3FQ9hahrG17uo9pyKq0K4U9exz50KN4n7UNXZv8D6dRZ/N9EnRWx0B
         ve/4IDyOZ7w8W5R7L7MVBKu277YQOiHvNopZNsWHlg0dKIm7loPQzHM0WLSu8Xvun1g8g0TV0GJi
         XrUgc4Lls0E6kIFNPvyI1GPyC2Gq3ISWkq6RyRL7sn3Yqdx3s2nNNtsANrDaLLTs88/ntFnIF5su
         0KrpvCUDvNj7OeXdqkXvyjD5Q00Leh271F6MVWd5MgOJtBEPDZnEUBtmT5/jKiYE0FpZsrAN9hUr
         Kro5sUGAKyvrB2C0MOQQHRKWPDTqfZzjwgEpOhf0c87n2F8NlDEM3GxAoihmwOZXvxSLlzHrlubJ
         DwaEx0b5pKbMlHDAkf4t63zXdnTEArcJcZUGbcvH3TRW6uW1xnDFRSpquzHx2ZY0093tTtcsKZ3S
         OCkm0wBSeOiVEU4EAg8nKJx1Vgra8oI8d036xowFdkfZ3P0hDjE+DLZU3AFE98INVY+8lpDU6auL
         C8tmg8kr2vw/KSniPGqOeWt6HvYp+EiN6K5u9qNDYlLothPh3JppCgfkkF0nB1qBsXEtmLmDOIA+
         gOiyWFgyUxZCtErIbb2oBo636TTMQWGPYOlnoykJ9sYXVp3Px3Bk14flUv5gkuGsZp1+8e/UP8ez
         1nhTJVYSvjdJ5guFHftQQCvIBdRdEVJdhX+7HX/+XLzWUD9Hahw/Heb1o791oTCeEoSxLsm4o/CD
         TEK4isymVIQznxjZc6QFZIQvulHzsjUnpvrdEMRB0dynXbEJFCrdC05lnGfeRUS7hOCMLIY0ZLDl
         0Xn0PSfAvl47OA3r3X9AFFQ1ZCXMAxOCwR9a67XrdgBrrb5PUbnONy1kC7dX74yfuwMrsCcys=
From:   Rsplwe <i@rsplwe.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, Rsplwe <i@rsplwe.com>
Subject: [PATCH] ASoC: amd: yc: Add MECHREVO Jiaolong Series MRID6 into DMI table
Date:   Thu, 23 Mar 2023 15:40:19 +0800
X-OQ-MSGID: <20230323074019.5878-1-i@rsplwe.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Rsplwe <i@rsplwe.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360..b3b0afff4b4c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -269,6 +269,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MECHREVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
+		}
+	},
 	{}
 };
 
-- 
2.40.0

