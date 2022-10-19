Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07554604ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiJSPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiJSPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:11:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505D21E2D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26063B824A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82974C433B5;
        Wed, 19 Oct 2022 15:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666191860;
        bh=Pi1k4R02i4ZR/ncs7Qdsgrt+18evANMUSUdhXR9xuDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWyGr6y7NBkpWDNITwVplYSgw68+4Y6PZJLGcZ4xw5sQzzYGrItD2Q++MwGqgNxlu
         HQRgwIoZVz1OMXVS1XszOFYJdPSvxJhKOGckIBKsM1gRFQeD5wzP+ea6IcDnu4DD2r
         wbLGgPGWorD3kq6B9Pu5cA3Jf+KO5xJU3+PP9IPVOT8RAIJkQ+KiqSApfol5JxS0OK
         iHiww33jy6JsHgw18EYNfAlPdaQ2y5kT0zRmsulEhtKy0l/M9x3MA1bBu7JyEIhhWQ
         OppAedxHUxq9pm/FF/KJG7qI5oSehp18dGPABp65uySh/GaWmguCbj8d8b1XdBKDwj
         lA1LUcb6Vlr6Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 01/17] ARM: at91: remove stale MAINTAINER file entries
Date:   Wed, 19 Oct 2022 17:03:23 +0200
Message-Id: <20221019150410.3851944-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019144119.3848027-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Going through the entries of recently removed machine types,
I found these two that were removed a long time ago.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..aedb7c008dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1798,16 +1798,6 @@ M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 
-ARM/AFEB9260 MACHINE SUPPORT
-M:	Sergey Lapin <slapin@ossfans.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
-ARM/AJECO 1ARM MACHINE SUPPORT
-M:	Lennert Buytenhek <kernel@wantstofly.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-
 ARM/Allwinner SoC Clock Support
 M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
-- 
2.29.2

