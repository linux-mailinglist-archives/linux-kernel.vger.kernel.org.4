Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EF742D48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjF2TGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjF2TDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0F3C26;
        Thu, 29 Jun 2023 12:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02FC6615FF;
        Thu, 29 Jun 2023 19:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F36AC43397;
        Thu, 29 Jun 2023 19:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065320;
        bh=ZBPDjQTOm9nfTKy8pCEe02sdJ5H5tTrv77pYuNH3HnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/3EAn8LKsDfljV4aww9xtBNRUQH98pa7uazxPXJzxZA8evXwGchJkbGnnhoD6HBi
         IZrLAfQea/ksuYD/dcEFoiKlu76sLST6YQ+3OK0qSUP1G+onc8DxAeNnP8JPkVFZnz
         7cxOkBHFC/0tmBn+P28diMrKFxGbLqDcjan4pvVxbKxGI8UU2+19R40nYAhytvO6fY
         M5gtyTG9tCui6SD+qpDTBEYawVSD4hRCkkMqeOdiwpFHy0W950JNpIN19B1Zbw4jEP
         dqqi7Vgdv1VdeYMfqzkGyV0XWyHsbTP1KCKvyLz1foIh7am2LDK2dyhiCGmaCA5PWy
         YuYon/2//1rHw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, michael.hennerich@analog.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/5] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Thu, 29 Jun 2023 15:01:53 -0400
Message-Id: <20230629190158.908169-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190158.908169-1-sashal@kernel.org>
References: <20230629190158.908169-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

[ Upstream commit f593a94b530aee4c7f2511c9e48eb495dff03991 ]

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 07adbeec19787..7140573eca72b 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1351,3 +1351,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2

