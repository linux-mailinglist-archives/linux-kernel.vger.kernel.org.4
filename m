Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C199F6F2C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 04:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjEAC6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 22:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjEAC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 22:58:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460C419B9;
        Sun, 30 Apr 2023 19:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 767F760E93;
        Mon,  1 May 2023 02:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A5C433A0;
        Mon,  1 May 2023 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682909874;
        bh=0FgOAeLWITfHqxmvydovCvhdnSidBbTih1SuweCVZcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFYac7n2BCJGwBIZuv6RrXOOu/JhyQfH2Gf5ZJ2TgSuSrfZ3GyLHPW3UOBu/hMFZ6
         6u7KWBc/5ZluQ9fLg69NAfd8ya3qDXw5vg6WQWhaxQCteyNcxW1GgEfRckZUbZLVY8
         lbQQo/U2cB+dEBskxktNlhxwY0jAjM7zQDxvp0Tnd8FCssuJW1eKRr5aAqQyRfRiCX
         kFXlBywKlbTLNJH6O6KfpzMrHo+C500EtR1aDttLUcJ7AzGMOX1vs4gkt9kivraofM
         sCNkKzr2hQZItr4r/TSspraF9LezObDg/cwxETPMAWCC/o0tZsC3720yXEcTWO42mu
         hKkq1wDBg/jlg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, isely@pobox.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 16/44] media: pvrusb2: VIDEO_PVRUSB2 depends on DVB_CORE to use dvb_* symbols
Date:   Sun, 30 Apr 2023 22:56:04 -0400
Message-Id: <20230501025632.3253067-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025632.3253067-1-sashal@kernel.org>
References: <20230501025632.3253067-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 1107283b3351bef138cd12dbda1f999891cab7db ]

A rand config causes this link error
vmlinux.o: In function `pvr2_dvb_create':
(.text+0x8af1d2): undefined reference to `dvb_register_adapter'

The rand config has
CONFIG_VIDEO_PVRUSB2=y
CONFIG_VIDEO_DEV=y
CONFIG_DVB_CORE=m

VIDEO_PVRUSB2 should also depend on DVB_CORE.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/pvrusb2/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/Kconfig b/drivers/media/usb/pvrusb2/Kconfig
index f2b64e49c5a20..9501b10b31aa5 100644
--- a/drivers/media/usb/pvrusb2/Kconfig
+++ b/drivers/media/usb/pvrusb2/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_PVRUSB2
 	tristate "Hauppauge WinTV-PVR USB2 support"
-	depends on VIDEO_DEV && I2C
+	depends on VIDEO_DEV && I2C && DVB_CORE
 	select VIDEO_TUNER
 	select VIDEO_TVEEPROM
 	select VIDEO_CX2341X
-- 
2.39.2

