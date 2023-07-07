Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DDC74B2FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjGGOZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGGOZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:25:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4411B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:25:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QyFzH0DSVzBJBf7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 22:24:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688739898; x=1691331899; bh=X19fiyEPm8XRU2mImTwANWy+s8P
        UCz2HiFt7jLiJe9w=; b=1CyucdBlct7ReADRylT+PDSxMS5nBQXrS25LkCm9kR7
        AhxLm13NrtA1u//sUDVcSBrk8I5GSu0I3LsfJrLf3dNRWPRC+49ZFoREyNacyy74
        CoB0tB6+jsKRPw/bzoMSAA+KBVCpBQUD37+NFPy0H4h+zj4/Lezf8lJ68uaw5A2t
        EZQ7gnH1nhTxa/I2QXCD1I7gAX+2ZzIYKqMG2eha+/gadd7aiy90LncSAzBZHbAw
        8WB1V7vH/k5OFmpTet3TjZvAmQhITnSDnaLweeeAPgBQC0iEnD5/1yCWWy9p3HLz
        UjvahoiaFlnGuWw4L8872ulIw6q5HXxfZim6upHHFXQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LuyuGGu3c984 for <linux-kernel@vger.kernel.org>;
        Fri,  7 Jul 2023 22:24:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QyFzG479HzBJBJ2;
        Fri,  7 Jul 2023 22:24:58 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 07 Jul 2023 22:24:58 +0800
From:   hexingwei001@208suo.com
To:     hdegoede@redhat.com, mchehab@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        colin.i.king@gmail.com, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com
Subject: [PATCH] soc: ti: smartreflex: void function return statements are not
 generally useful
In-Reply-To: <20230707133447.28102-1-panzhiai@cdjrlc.com>
References: <20230707133447.28102-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d4b290f08da0c2435f3fa4676e7a5f25@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

void function omap_sr_shutdown return statements are not generally 
useful,
so deleted the return in function omap_sr_shutdown().

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  drivers/soc/ti/smartreflex.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index 62b2f1464e46..20abfb0b8f26 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -955,7 +955,7 @@ static void omap_sr_shutdown(struct platform_device 
*pdev)
      if (sr_info->autocomp_active)
          sr_stop_vddautocomp(sr_info);

-    return;
+
  }

  static const struct of_device_id omap_sr_match[] = {
