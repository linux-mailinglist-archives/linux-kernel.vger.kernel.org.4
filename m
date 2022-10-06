Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1A5F7175
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiJFW5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:57:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6073BB041
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:57:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 387805C00D8;
        Thu,  6 Oct 2022 18:57:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 06 Oct 2022 18:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665097064; x=1665183464; bh=b5
        XUZk2mUE1/iao/j42pTqa0KQh0Vq/p61ZJZ5jY18I=; b=jwgAn3XAcipVn1klJ0
        SyxDIdbbnJw5PnU6L6sV1++NlGCPbafHCOT0aIQ9Qdnu4xPQ6pEKpum2R3c7D1NL
        O5fe6WaEXaIIohEmpRPadcg2S8kfzc8eUSab0/0/0SVMQZmGarnnYhmqpXmRsx4f
        XK6jeL+tEeeuiVDEtsJTqLpc28E58ATjcRuTZcd/MBtArCkRHs8fx/A2SJqdPEGH
        8BHOgPonTMJedug3A7F15vBnKdsOXhVKfZbYCS/H0NISEuuOIqepc7T4D+GqrQHS
        q6WymY++VmvBpZL2BVpgBWAMGrZFME78PWX32CRuQSxcFWprZbE04qGUF8Pait6P
        pW8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1665097064; x=1665183464; bh=b5XUZk2mUE1/i
        ao/j42pTqa0KQh0Vq/p61ZJZ5jY18I=; b=CQe3AXuMeuy0b/qGv/tfoHnqqh3fX
        9Fo/AwWT9pHXsbgwDjMZAuebXrdO1bH6FyED3DNxHO3+Wvc1jpcDz5UlVlOZSAJI
        YnuzsnpIsXr3MnHDoMmMkjymml3MzXsfBhBKK6u6dnjqKW+dzTPo+zzA5x2Kv+2r
        tV8xySFnRbkcG8/5+uBkpWgscapbahYQQXEl/gj3jDd4zMEPKsrK7zuq02vXETeT
        x7G5opZa0NKFOZKbcG/ooR2SYfBPDeKn7JNTjF6SEJeA0I/qVY0/fw2iuIZ8319B
        TtLfeqTLrUcRT/TeI3wVVAmY0Kvc35iJZTmcwWY8N0YBMuqpun2mf7wlg==
X-ME-Sender: <xms:Z10_Y3eooiZblZXf3h_THx_qprAVnWz2QX26bTOtaWK8thQy5XKTGw>
    <xme:Z10_Y9PARl4JRuZMCgnNrwfCgcHsSOhlyzntQkY00VEjkoRjBwgrCFctkUfjkxT7p
    4GKGW1BO3xTdwBiEJg>
X-ME-Received: <xmr:Z10_YwgEQmlcu1faVEcbfUqVDAGkv-bnz9IPRjAZibc9e_BzXUrC6f-f6CGtTcXmZvWR5cLmdvWVxYh773eBhgSmMGYFfeOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeefmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhitghkucghihhl
    lhhirghmshcuoehprghtrhhitghksehsthiftgigrdighiiiqeenucggtffrrghtthgvrh
    hnpeefveeihfdvgeeguddtveeuudeuvdelgeetleefhfeukeehteekieeujeehtddtjeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrh
    hitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:Z10_Y49T_gyIllh6Z6IhNZElTJOIWrWrPpksFyroceI7ds9kqYHRuA>
    <xmx:Z10_YzvSc02JoAiuUWEVzeU9bxs0wBhHGEX2YuKbA6jgGYhJ8c8xgQ>
    <xmx:Z10_Y3EhfIJZ2GvogYZ9HvNd3gsNzYFD1wckD43-AD5YQjfkMgHfCQ>
    <xmx:aF0_Y5D-GUn-k8pHNYgWigQfH9ixrDETFIbIWUrcBPXtS2eAlWoRMg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Oct 2022 18:57:43 -0400 (EDT)
From:   Patrick Williams <patrick@stwcx.xyz>
To:     potin.lai@quantatw.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        michael@walle.cc, miquel.raynal@bootlin.com, p.yadav@ti.com,
        patrick@stwcx.xyz, richard@nod.at, tudor.ambarus@microchip.com,
        vigneshr@ti.com
Subject: [PATCH v4] mtd: spi-nor: winbond: Add support for w25q01jvq
Date:   Thu,  6 Oct 2022 17:57:37 -0500
Message-Id: <20221006225737.3560091-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222085148.21594-1-potin.lai@quantatw.com>
References: <20220222085148.21594-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Potin Lai <potin.lai@quantatw.com>

Add support for winbond w25q01jvq chip

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/winbond.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index ffaa24055259..e60ad92c0ace 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -139,6 +139,8 @@ static const struct flash_info winbond_nor_parts[] = {
 	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
+	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048)
+		PARSE_SFDP },
 };
 
 /**
-- 
2.35.1

