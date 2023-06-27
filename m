Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6407673F707
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjF0IZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjF0IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:25:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B33F1BCE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:25:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QqySX5pmszBKnl9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:25:00 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :subject:to:from:date:mime-version; s=dkim; t=1687854300; x=
        1690446301; bh=i/70Ikne81aPCBqCqoBhw4LYaqe2ZHcwjQz4T1WMXXY=; b=k
        ZCnUJWA2am1t3rIwlQlClMtXwt837Wlj444lYpITUsBXm6ErmyaRIZOHLfpaClOH
        O9CXfleuqlbkYm63eQiyHpz9t8bB+Znhp6OwNpgiMAC+J0H+2DCAVntNczdzszzP
        BxGrmTHOpFCdUYLSZ82rwVawkZ+AASQT02Uw+bowAs2uG8z7uw+CqK7ViCyKE5P9
        x+BksIO1lEYJVEs2x1EJRuCtaFdqFgkoKto9r/Su9s9bI/2CQXlsckwq9xKoAp0D
        r4pq2IrlpFkdqoGJBOo66o8sn/sPcVU5vahv6LfxAtRIVQpKaIWMOPmqThQr8bx7
        sgc1Ywk22Y+uEfhUaVvfQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6wuxyN7MdYDu for <linux-kernel@vger.kernel.org>;
        Tue, 27 Jun 2023 16:25:00 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QqySX0VHszBJBHT;
        Tue, 27 Jun 2023 16:25:00 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 16:24:59 +0800
From:   baomingtong001@208suo.com
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        neil.armstrong@linaro.org, minhuadotchen@gmail.com,
        andersson@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: ucsi_glink: Remove unneeded semicolon
User-Agent: Roundcube Webmail
Message-ID: <1aeccd98845a7dac584c08578b43a6c0@208suo.com>
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

./drivers/usb/typec/ucsi/ucsi_glink.c:258:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c 
b/drivers/usb/typec/ucsi/ucsi_glink.c
index 1fe9cb5b6bd9..9b9685199d1a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -255,7 +255,7 @@ static void pmic_glink_ucsi_callback(const void 
*data, size_t len, void *priv)
  	case UC_UCSI_USBC_NOTIFY_IND:
  		schedule_work(&ucsi->notify_work);
  		break;
-	};
+	}
  }

  static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
-- 
2.40.1

