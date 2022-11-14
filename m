Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED0C628762
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiKNRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNRpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:45:00 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0CA190;
        Mon, 14 Nov 2022 09:44:57 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 03D965C017E;
        Mon, 14 Nov 2022 12:44:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 14 Nov 2022 12:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668447897; x=
        1668534297; bh=oXWjxeEcaEjt1Kdvuu2aUDoMsSbIcDNUNLWbktQ23lI=; b=D
        eRyyqOgj14aphwVKCfuBEM5pyy+IhOggzAAd+Y4mhitJJgkYuS1R/gMRBj6INEpx
        i0J5hLhJpkpBnHj3i14QXQlw8fddT3sx7P2W9hBDCTFkOInB6oD4u2yp0YuWFBsT
        Shrd+PVr0Exx9NMyLZ2bIWzYo+eX+p8CoBgR0gRIBHZWOYKxVzIY5aCcZQmwtzbn
        s0YyQfr+5XprUNDDvCekyNGvkSJ+ObM/FFAyjz0RLo691IchbKAMNhQW9H0b9bte
        o6uUhPqTkOg8a3FOAS8k8cFhyh03cceVQ1JSJJm+ICBeWHTr2CLGk8YiVvZfih1c
        YI/pmPf3DYfCD7eyY8R8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668447897; x=1668534297; bh=oXWjxeEcaEjt1
        Kdvuu2aUDoMsSbIcDNUNLWbktQ23lI=; b=WJh+2gi3v/W/5OQtkcWaqDFKakPg3
        mIA6YRDyAwvOGF34iQ2bBncnhfSgVX0Utu9pik+9P/eRVcccPJZVhGdgYROFrnOE
        mUXyl2JkD9c++MC/dub20aDgBJ419AuS1/Wh9fZojmEslF4sKh81AcFet4jGqy5f
        BE9xHwUewUYitRq1KboHuj5JnVrDc0NYswOP5ldkx9V+YO13/QMzJOQ4tL8v/Zsy
        5nB0kryK6oRfuSEXpGhn8oTXgEXRT5jZP7FORPuJyVKeAJeWIh/XYwIaVwxKcpbU
        yjLC9iSx/fFzd5vbSlh0jFQfInRZMANNvw3OIXV7ipL/TRnUO3TGFH4DA==
X-ME-Sender: <xms:mH5yY936SnSe3i0Px6IRBq2TexddiPorRRsrcfpt2wtWVv7JLAl56w>
    <xme:mH5yY0F6ARPy1ZwrOjCk204lScGn4F3d6e6JWP6ufTgPq_EZ_1u7zdO4Rxigxtm3w
    O2CJduiB04_GcBcKTQ>
X-ME-Received: <xmr:mH5yY97Lw3Q4XUdV7kiXqnhaf668c-_gU7TbtdBLDGdOQvw_PdQDEpyakMKTFQXHCSxUaPgpX2ihnOJDmcKTlhu57Se53VA4_deHVpJASxSmm8zOzfzZsL7HSvbWyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepjeeiheehkeegvdejhfevkeejgfdutdefhfethedtieffleekieeuudefleekjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:mH5yY62tElr0WKd38mWMA__VXYOdNSshgN4H3Y0LsfXoEngmvrrnwQ>
    <xmx:mH5yYwElvX_dKNvkNOTYhrnokrHrPLNSYlNW30lzGgcGu6nEVxP-1A>
    <xmx:mH5yY79Dms75aFvW6h4h74Kdbvn7mqVHTvMrnqEvvzQBnRSgTFZvUg>
    <xmx:mX5yY0DCOcOQ1t18hWRYCDJEu0mlXgEAxYwmM2KOIE4GoCGY-w0clw>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 12:44:55 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] usb: typec: tipd: Move tps6598x_disconnect error path to its own label
Date:   Mon, 14 Nov 2022 18:44:49 +0100
Message-Id: <20221114174449.34634-4-sven@svenpeter.dev>
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

While the code currently correctly calls tps6598x_disconnect before jumping
to the error cleanup label it's inconsistent compared to all the other cleanup
actions and prone to introduce bugs if any more resources are added.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index c35501a92b4d..22ff212e05e6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -850,16 +850,16 @@ static int tps6598x_probe(struct i2c_client *client)
 					irq_handler,
 					IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(&client->dev), tps);
-	if (ret) {
-		tps6598x_disconnect(tps, 0);
-		goto err_unregister_port;
-	}
+	if (ret)
+		goto err_disconnect;
 
 	i2c_set_clientdata(client, tps);
 	fwnode_handle_put(fwnode);
 
 	return 0;
 
+err_disconnect:
+	tps6598x_disconnect(tps, 0);
 err_unregister_port:
 	typec_unregister_port(tps->port);
 err_role_put:
-- 
2.25.1

