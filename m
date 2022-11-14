Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACA62875F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbiKNRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:44:56 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E18190;
        Mon, 14 Nov 2022 09:44:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B290C5C0184;
        Mon, 14 Nov 2022 12:44:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 12:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668447894; x=
        1668534294; bh=ePEQ+K9udupnlN1ckTjNp1CUO4deTP+rgDBrWOphwU0=; b=T
        4UjzoNT4HJ5sQ+Qz2kfXVb59W6eDlirUYEkJV5EYo1vm65tYQOgLcNMueBJDjQN+
        NMPlHbxsItjZp2NTHkEd7BmquJJ2k6dbQq1l2uyRjC+DCX/iMKvqVYqxa9RDDN7R
        hr14q1X/jKI/uiHVFdvyUZPYLa2myvno4uLqY3Vkqcw1WfgzMKKRxCwR9Yggkkrr
        +Yr9F7yfoYzpQGJ9JUapmRo7YhK0wnFAJexlzFDEZ1c0MiIs/Cj6tSH5sx27e6wj
        ylqkz8ti+U2Fck1HWZGxZFS2MMeWuSifqNaF/kmBY8Ors4y1sJm9zbCynwJOeWL1
        yI4L4weXKbPeSW1ai90tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668447894; x=1668534294; bh=ePEQ+K9udupnl
        N1ckTjNp1CUO4deTP+rgDBrWOphwU0=; b=oj1FN3pZslHl+5+KAsxWERCfe9RXP
        uWYWO9EEvYKe8iDYr547F+K58qWVgROtVUyK/0TuK8nS7tIuwcVxauOfIjkMshmK
        Xrqx8CCiG8BJuinyTu2S7bAJVAQrATUkiAH2Zb9SNJ2LLJ+OZJeRgOGuEwTjzLGq
        VN2nIrVZ5TCHGYs/puP+ctDPQyzXWbjImhuV8CI6fBGs98Nxv/260ZRJEJRb3CtL
        bMeHvtJgu7uiQtpf8l3AO8QL5hbR3g+nq64Dx1BvntGsi3pTmCyQf2sP7FEw49Fj
        YJMNTX6J6gG+ST7EraY4CSwY68jH4IfhDDbkYGkECZYsx0qFW7aGQ8bCA==
X-ME-Sender: <xms:ln5yY4fXrjoMlOu11HjgZ1e14v23EVS-a4kQ_BPi8Yl-CTHdb9VaTA>
    <xme:ln5yY6MqfxxU1Ht-ivIkqhAKNOFA-etD3FOPmsoKv728TZQsz7Kr5WL-IV8oVnDAP
    eIE4upnDYVBoxSvyA0>
X-ME-Received: <xmr:ln5yY5jxFwKj14Ke9q6hiex0DilhgNRAzalultoyOF2tYFSlFFxEOYZ_YNRb69M6uoqWCe42oZnq11KwZp3FfE7Kd3i5Me8Y0qQ_SvHDa73KTJTvPiPC9Iqyf8EnyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepjeeiheehkeegvdejhfevkeejgfdutdefhfethedtieffleekieeuudefleekjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:ln5yY9_ZQzQWnJ20vgHbgkicdCzq8ERAVB2rA2GiGNX86IRSza2tSw>
    <xmx:ln5yY0viea54urPVQoFKdEYSlT4RaOYNb2UmnDm4Mkfgt7ES6tRdpQ>
    <xmx:ln5yY0FYP_M4h2q1qTiJdF4ouhls48mTJwMlXq34QxMUTnzygvXWOg>
    <xmx:ln5yYwIlCLniR6gQ0yc-J5wW1m4CMsoptYpSzzML88ZmEheCvvBadg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 12:44:53 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] usb: typec: tipd: Fix spurious fwnode_handle_put in error path
Date:   Mon, 14 Nov 2022 18:44:47 +0100
Message-Id: <20221114174449.34634-2-sven@svenpeter.dev>
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

The err_role_put error path always calls fwnode_handle_put to release
the fwnode. This path can be reached after probe itself has already
released that fwnode though. Fix that by moving fwnode_handle_put in the
happy path to the very end.

Fixes: 18a6c866bb19 ("usb: typec: tps6598x: Add USB role switching logic")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/usb/typec/tipd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ebc786d728e2..824e573af570 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -834,7 +834,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		ret = PTR_ERR(tps->port);
 		goto err_role_put;
 	}
-	fwnode_handle_put(fwnode);
 
 	if (tps->status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
@@ -858,6 +857,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	}
 
 	i2c_set_clientdata(client, tps);
+	fwnode_handle_put(fwnode);
 
 	return 0;
 
-- 
2.25.1

