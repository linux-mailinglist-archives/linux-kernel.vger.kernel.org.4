Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60D742CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjF2TCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjF2TBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC7A1BC5;
        Thu, 29 Jun 2023 12:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2371B61610;
        Thu, 29 Jun 2023 19:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E17CC433C9;
        Thu, 29 Jun 2023 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065274;
        bh=Cl2JZtp7JTFAtrbbJEFEFkb7VgCs98txtHTIsGFO6tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ck16IiUrc3SZeA8pVRKnMuzRX6TxFyoJpEtefR19QmzbbuixazEKtkmt+HWwJicvm
         04DcfiEopG2b8X3ZpIbqbQF0BTtw83BCF42AM61ToCM0X1lOUbgX0hqzD0VsIL1CfT
         2ELP1mlwabI30lbo2QXGTxRcqFRqQSWMQxLcfyrR7xdBDz82K3/WZhBRovaotzuh3A
         bLQvXJFYZnCyCJkD6y59zgC8SXVT5ti+z5q2jIxZYTdpVQ0hRUqKYGGjHVqTeDQQT4
         Xst/CDCVVFoBFvFIGbb3ozbe4REjXwWSGmhpCKDhCPhRP8eChZ8A6RAvYdcmVGVT+f
         8o6UI46Pi6ILg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, michael.hennerich@analog.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 08/17] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Thu, 29 Jun 2023 15:00:37 -0400
Message-Id: <20230629190049.907558-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
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
index 5cf218c674a5a..c246370cd48c6 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1349,3 +1349,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2

