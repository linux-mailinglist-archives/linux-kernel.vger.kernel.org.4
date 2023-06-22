Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E473A3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFVO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFVO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:15 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C631BF9;
        Thu, 22 Jun 2023 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PHAQXj72YwnlygCv+bURlekJBj3OCPKU5CLFZlp4W1g=; b=sFY6YOpAcf2in17XA6cp4cTBa0
        /6faN1EVK4Qm2grpbsXqxh4JpUGR7JyPKkMLeEfWzU77dLdwWvN5WLG48NcndIPO/oKET+F7IiKMh
        KrMjNhX00BesYK4i0hRQJYwMWseG3tZN1av8N+BzhTbSGkRGZ49BdZrlbk9x0cLxknsA=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlA-0002fr-60; Thu, 22 Jun 2023 10:58:08 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:47 -0400
Message-Id: <20230622145800.2442116-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 04/17] rtc: pcf2127: remove superfluous comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Noted while reviewing new PCF2131 driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 443c9544f575..b10878a9224c 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -137,10 +137,10 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	tm->tm_sec = bcd2bin(buf[0] & 0x7F);
 	tm->tm_min = bcd2bin(buf[1] & 0x7F);
-	tm->tm_hour = bcd2bin(buf[2] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_hour = bcd2bin(buf[2] & 0x3F);
 	tm->tm_mday = bcd2bin(buf[3] & 0x3F);
 	tm->tm_wday = buf[4] & 0x07;
-	tm->tm_mon = bcd2bin(buf[5] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_mon = bcd2bin(buf[5] & 0x1F) - 1;
 	tm->tm_year = bcd2bin(buf[6]);
 	tm->tm_year += 100;
 
-- 
2.30.2

