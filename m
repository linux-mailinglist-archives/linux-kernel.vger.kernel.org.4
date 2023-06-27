Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15EC73F7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjF0I7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjF0I7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:59:11 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB98F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:59:08 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqzCs3JjZzBJXDL
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:59:05 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687856344; x=
        1690448345; bh=VFd1Mh0aeu2r5IFFYYRc/0gxv1eqPXEe+CP8QHu3Lw8=; b=d
        TjBDrmsp+QBhy8/JJpianhAEMGMVZXX75WC+lFgWZ6Z63nFWMIOS22D7Xx3dPvS/
        L3vqh4xkNCVEs4vumP+Yhx25+5CQkXng1ht2ihcLVN7YTkOKCiXeRSzIazWwPG6k
        /xFkjZedF7td3bFNtpcOyDNwK9hmz4Jq7YZ0ZFtdFJ0Yvs1CEXXVHSb2lfmi1tu9
        CUfOdrOBVi9Sfd+qYxO2f1jB4rYuPBjdDCj85lVHBz9lLRHKkmH1mD93CkLeKxO9
        N66YoZywHpCHjMmlqLb/8tggA0DSN5N4plx1MxpwWhE4Ei3Q7ODZO08xF8V/YBS4
        rwwG6Si4q4GrHryvxzJjQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pxMre-9JfUNf for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:59:04 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqzCr5gMCzBJBJT;
        Tue, 27 Jun 2023 16:59:04 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:59:04 +0800
From:   baomingtong001@208suo.com
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: cht-wcove: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <e66d4beb79da0bfa18269c390f1ed5ef@208suo.com>
X-Sender: baomingtong001@208suo.com
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

./drivers/leds/leds-cht-wcove.c:193:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/leds/leds-cht-wcove.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-cht-wcove.c 
b/drivers/leds/leds-cht-wcove.c
index 0cfebee98910..e35a25990048 100644
--- a/drivers/leds/leds-cht-wcove.c
+++ b/drivers/leds/leds-cht-wcove.c
@@ -190,7 +190,7 @@ static unsigned long cht_wc_leds_get_period(int 
ctrl)
  		return 1000;
  	case CHT_WC_LED_F_2_HZ:
  		return 1000 / 2;
-	};
+	}

  	return 0;
  }
-- 
2.40.1

