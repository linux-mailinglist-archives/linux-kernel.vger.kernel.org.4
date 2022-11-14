Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9711B62875C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiKNRo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiKNRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:44:54 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D7125C0;
        Mon, 14 Nov 2022 09:44:53 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 690E75C00ED;
        Mon, 14 Nov 2022 12:44:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 14 Nov 2022 12:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668447893; x=1668534293; bh=vMxy/5Ep6z
        8xTyah49JP7LX4W4hXdf9xwgHuikKY72M=; b=gLtoIFASX/fLQRLrI/h9jTax7p
        O/KAJ5C/fsKgbWyMcl7cxPio9Xs6o1i+kFeireANe2+loloq+rE45tpRhrLJl+8t
        nseMb0RGXgBToUHBg6vwnLxt3WfEQW47oqT0j8sU8od4WwcXGASUDsPDpPlU9Rpg
        w7sxkssw52zxtULaVVcgJsply9Mtp5ReJAPPZ7tPopQzd98vEibRNrxX5/kH2P1V
        rc+XNeL04umtrtkIl5l8eSjbuHHOgX7gRLz7yTyRZ6hIMQKb3U/xtVWgQCiYIoN7
        43Rj41gh/zNHGJ1HphUsgX7JWuWHkkUmC1ajBFjsTG21P6ImhBIH2Y/MlYfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668447893; x=1668534293; bh=vMxy/5Ep6z8xTyah49JP7LX4W4hXdf9xwgH
        uikKY72M=; b=cJhN3xTuNzHHKgf96QzXN+EEIlg/JxLrzBGuuJPUk0ZTrmsbIW+
        koz/jtenzfIifmLKnL9DxZviRsZhehyMvcNapMykOPONVeuQ71foudGItvXLMpQZ
        DFK55X5D2+Xbi0MB1GeK55GSmvhM3GAGjoOAVJYmJIvqgv2v7Ft4oRPy39hw4RZb
        mEjclqv0eOGATCwkoP7VlOjWcIwHdGeGaR7s+q79sAvDgNNHQS88ph0AjkOMJxh7
        CXZPHNaUv2cuXMv6zREocLcbR3a/XQ9h2xKe6A6mZqbCUp3JfYLrnzEVSuVMa7qs
        gG+6JSfHYlHixg4YK3OtDf7oVk0urHLX96Q==
X-ME-Sender: <xms:lX5yY7Cw23x7vuB1BPaJCmWPC20VAUjTqXVkL03AoqXOSTYwdOJ-TA>
    <xme:lX5yYxh3flTS42T63bQqVRDq2YI0o4H-TdfgcIb_PYz17ENYTeRDSb0QKoKw60kA7
    f52TvCskXUGr5r5dAc>
X-ME-Received: <xmr:lX5yY2mdWCrUd-eQ1rVjsybTXND28TPIeZEpe5goDLOGamFoyn2zVJDFNzqUpbRxmoom9L0-4acCPzKJg11EzEJ6Bs7tPgjfCcqGDQBzR0vPsX4GDNB_EnKk3_1o-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:lX5yY9zH1hQnn31FVAhYR0YkEzn0jI57wUFKZGVW5ccX1NJEmQRw0Q>
    <xmx:lX5yYwSFFhojKxjNhiLIQ5uJb-czUqm5Sx4oSdW-gR9THEWPNRElEQ>
    <xmx:lX5yYwbXru_4PkaP6JrVVK6Qq0AfKcrPAJaYbDSN_EFViZlF3YPzcg>
    <xmx:lX5yY2fXnDBkBUcBsC-dro3txGY3BGcWluC-vtWBEs6u_tekPwZq-g>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 12:44:52 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] usb: typec: tipd: Cleanup resources if devm_tps6598_psy_register fails
Date:   Mon, 14 Nov 2022 18:44:46 +0100
Message-Id: <20221114174449.34634-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

We can't just return if devm_tps6598_psy_register fails since previous
resources are not devres managed and have yet to be cleaned up.

Fixes: 10eb0b6ac63a ("usb: typec: tps6598x: Export some power supply properties")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 748ff4f6b5f6..ebc786d728e2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -827,7 +827,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	ret = devm_tps6598_psy_register(tps);
 	if (ret)
-		return ret;
+		goto err_role_put;
 
 	tps->port = typec_register_port(&client->dev, &typec_cap);
 	if (IS_ERR(tps->port)) {
-- 
2.25.1

