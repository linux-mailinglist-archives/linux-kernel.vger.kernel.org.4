Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35C6619BD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiKDPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiKDPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:39:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2BA627D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:39:16 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 78EE05C012A;
        Fri,  4 Nov 2022 11:39:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 04 Nov 2022 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667576354; x=1667662754; bh=AWuyVgNZ5N
        X5XYa72JpSx89IAy74SR0YpbdPJ6sn2uE=; b=ahSAhFPj0BXH9eemkB0r3x797M
        Oy9TkHBvbH4GA5qiXfKVhQehTcDjWFyz+kC2AaUD/Ta1lxkhjA5csDRYJPuGGsVO
        gR0j8YfQZTVcEg1Zs/XG9Pt2af4EeV0th4TpP4zxm57GvUftKs2s6L5SlbvzrJdi
        aql3KPFDUyfTGmuOkRxIGLXfjqakzOIc3MHQmg8ZSFY97pk2zWKIHStaTSUyfXfb
        iXuu6SfKpElBM4dWRWrYZVS77aFB3VfdFJTg8nXQutby6IFsxZKLL5vQVYIJ/nue
        nWWzZtHBQHUpJDOblIIMomNWULU/zFwDJZv6w8k97Z/Qhi8QELcA2Hs2uDfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667576354; x=1667662754; bh=AWuyVgNZ5NX5XYa72JpSx89IAy74SR0Ypbd
        PJ6sn2uE=; b=nUcvVRc3SwF/ylqQMXBOLjkzjAXE1I8i/u3p3V1Qp4I1c1XtoWH
        d9aIeKZUQ7x62GmT28op0g7a0viOaBHK+8duCMgFC+U0xmUiaVLGVd18jg6pDMoz
        rOfyfS+Xi/cOeRFx5dp0OzPR+RuqMAqRrbf8AM5zbly3pzA2/6sEz9RhjkCyMrJV
        oMocTuze0pszi/NuW9DO0WLaVnk+6Qg3LdXJ6Nm7xgmrxdc27pYOAVKWp3SRRCAw
        1heCOUnjVZ7nJHeWFQhu3H5rnvGL85SJiMr8E4ttfwkRopqXwencsYyaatwOq4rh
        W8WJ7v/BRH2CobIUQRAjMGG4dxcAepfzQ4A==
X-ME-Sender: <xms:IDJlY8EYbauaGtbciFWggHjd3esTKjZJd197m3TxYPLoXl5fybociw>
    <xme:IDJlY1UMk3lzi9cnWl_DTuIWTjZueg5ohLb9On2pRi_JhuyeOh1P70VUXgaeSQ6Io
    KDsN1bB2Hlj28A_0Lg>
X-ME-Received: <xmr:IDJlY2L2bOxHLBC-F7TI1uVPjTZm3XOIKZX91OfI1ZefcNuNljDGv-E8gIp3QGn9PVBAGcJ6og6QNIw2OGzjbVdNY7503c4_NckSmB4OScf8rl_gWky5QWQr5EWrqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:IDJlY-Ff_PLIWG9hG_F3xZ-XAA_fbGXEvBlAxBaV0geST3lRGyEZgQ>
    <xmx:IDJlYyW9SPHBMElzemNOV-V8gQq2aQhs5tYZG8Rk16mTQ9EvPVPTOg>
    <xmx:IDJlYxNj6gofcs_xlFyAj_1jirAGuuU7LqcFQPA59moX3E9bPfzusw>
    <xmx:IjJlY0IwxqN49BJGSLs3d4bPPVXJV31l0_0uu78eM544X-uElFWcMg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 11:39:11 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: apple: sart: Stop casting function pointer signatures
Date:   Fri,  4 Nov 2022 16:39:02 +0100
Message-Id: <20221104153902.78999-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: b170143ae111 ("soc: apple: Add SART driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/soc/apple/sart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/apple/sart.c b/drivers/soc/apple/sart.c
index 83804b16ad03..afa111736899 100644
--- a/drivers/soc/apple/sart.c
+++ b/drivers/soc/apple/sart.c
@@ -164,6 +164,11 @@ static int apple_sart_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void apple_sart_put_device(void *dev)
+{
+	put_device(dev);
+}
+
 struct apple_sart *devm_apple_sart_get(struct device *dev)
 {
 	struct device_node *sart_node;
@@ -187,7 +192,7 @@ struct apple_sart *devm_apple_sart_get(struct device *dev)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	ret = devm_add_action_or_reset(dev, (void (*)(void *))put_device,
+	ret = devm_add_action_or_reset(dev, apple_sart_put_device,
 				       &sart_pdev->dev);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.25.1

