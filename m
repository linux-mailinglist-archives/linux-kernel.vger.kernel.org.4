Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2D628760
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbiKNRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiKNRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:44:57 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3465190;
        Mon, 14 Nov 2022 09:44:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CD2135C00ED;
        Mon, 14 Nov 2022 12:44:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 12:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668447895; x=
        1668534295; bh=HV91cHyyAtejZdn17gJSrjXPYFuVs8vpuK6kjSyLhQQ=; b=a
        c6uxn8/5bNJI7SH1jDcovjMrmWa4H6xnKx7YpwXRxb6GJ33zh1ze4EyDPhalCSVp
        LY0uB4Sq2hi5rh3pB120Zp1ScfVpt0U+ySroI63Cowt46Y/q/I1X7Q1NIopK+Yk1
        5T7i3OzicEDVrcOzksRCn8l1En/6EVVVhEfG78nw/CCByZLrTiMLoiemnM/4B9yp
        J8Rw9jbh9T/coDAufVY9zwHJkZUjckGJNjXVoOfhn5CJductA2u7PWApPM5BqYfv
        O7UstElhacVW+i6lt4LJKHqdvXatCtho2lXJm7//ilBXtNk/5uYmtyqF5Zs/upty
        2Gav7VclqFyp5RvLemM5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668447895; x=1668534295; bh=HV91cHyyAtejZ
        dn17gJSrjXPYFuVs8vpuK6kjSyLhQQ=; b=B7jphw5LCpK5qz0vfAE/bzi+h+9nb
        LkCAM0CldqkwWDVJfrBM/IUZkV6e07x7nED9YD+51dcYxiKmiJWm/WsuH8qMOtkY
        7OAD2RK4jZZ4N1u/gqjgbZUWma3peyMN2ANmDkhfhJBDTj72NN1HLjrtFjabqvRI
        OGk/R0MRjz7L+V77W9eQsV3LYwLS31VpkFN7EaUgRUqCJhXZFDEM11j03xtPHL1n
        4cj6eqRLjh38EZQl7HTqeBa0S5T0R4P8oddVtoCegkxYf/B7XFCdXYm4lR/rjyqz
        AwYWXSYKGPxF0CYfjtsWTLF00mqtsEAVfP8gpHIc6293W635Y5EHNlDCQ==
X-ME-Sender: <xms:l35yY04H2AqWh4sT2SKq7KuOU52Pm5I9-_1X7adpRaJ3HSzZHIGbKw>
    <xme:l35yY15MaVw0ZndUL0SZAMlXVCvPbFd8HMk-EUQHJkrkfneV3US-SXtQsFM92dSp-
    BZK0y9aIT3DjUnJ6QY>
X-ME-Received: <xmr:l35yYzdQetV99aRlOvrmG8D9rc8VduLrAB76DhGjgJhGj1_Jch7u-E_lFsfYL5deUO9jGBegj31KnX5efLsjf2OjD0tiEV0kK2nNcL9HldxTFCtDDvGvtfwCAuiMbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepjeeiheehkeegvdejhfevkeejgfdutdefhfethedtieffleekieeuudefleekjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:l35yY5L9vLJWYtVs3XTKr06R5n1Rk0S87uScsHGtyuxB3SAdD5Nn4g>
    <xmx:l35yY4LnJIESNBRmQFi0ZX78s3SZFBpIbosb655S6nMj_F9JbM2mrw>
    <xmx:l35yY6z6c80SyXlOXtzZEfy1IN7svZNXFnsb7w5Z7bV2uBMDS5eAHg>
    <xmx:l35yY82JKHlbXABxsm9whbKg4etoxALjuKxXODr7wtbh3ST_moRuCw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 12:44:54 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] usb: typec: tipd: Fix typec_unregister_port error paths
Date:   Mon, 14 Nov 2022 18:44:48 +0100
Message-Id: <20221114174449.34634-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221114174449.34634-1-sven@svenpeter.dev>
References: <20221114174449.34634-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typec_unregister_port is only called for some error paths after
typec_register_port was successful. Ensure it's called in all
cases.

Fixes: 92440202a880 ("usb: typec: tipd: Only update power status on IRQ")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 824e573af570..c35501a92b4d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -839,7 +839,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
 		if (ret < 0) {
 			dev_err(tps->dev, "failed to read power status: %d\n", ret);
-			goto err_role_put;
+			goto err_unregister_port;
 		}
 		ret = tps6598x_connect(tps);
 		if (ret)
@@ -852,8 +852,7 @@ static int tps6598x_probe(struct i2c_client *client)
 					dev_name(&client->dev), tps);
 	if (ret) {
 		tps6598x_disconnect(tps, 0);
-		typec_unregister_port(tps->port);
-		goto err_role_put;
+		goto err_unregister_port;
 	}
 
 	i2c_set_clientdata(client, tps);
@@ -861,6 +860,8 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	return 0;
 
+err_unregister_port:
+	typec_unregister_port(tps->port);
 err_role_put:
 	usb_role_switch_put(tps->role_sw);
 err_fwnode_put:
-- 
2.25.1

