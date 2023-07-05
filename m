Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A06748FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGEVWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEVWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:22:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC4B19AB;
        Wed,  5 Jul 2023 14:22:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1361961765;
        Wed,  5 Jul 2023 21:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8AAC433C8;
        Wed,  5 Jul 2023 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688592159;
        bh=zEbZvxn5fHAXN8wkkwLFfJjiHHQqVko83vXSFT/m0PA=;
        h=From:To:Cc:Subject:Date:From;
        b=SpjjCh1no/gyThf2euEDM7MLxsUeTXZpNPO/G3V13Ft73jekRwJVbA7HE8GrCMIP6
         xldTzHgZ0ZHvi1+I7m3H2A8SMK2a4YLM0/m/jE/Zqg++zKn+aPZvako9yqN+UOLWhx
         au3WTeyN+xd4S+TdB4fSy1hRVYZIXiuzCWk3pPtDneNTvWorgAHKiKndwH5LogInEa
         gna2C8WpgGREiFEhE9rsjMATjh6PZ0vIgtNQiU0p9Xv/zJ5wwvrCkVxSW4Ai3eSrmI
         xKZd8ucp+xcnyQJEzdZI/qvVRwgSBdqjp9KOAc8KFd3lOMDd3EMBVAcg90MzbISuLo
         PPuoFG0R7nxcw==
Received: by mercury (Postfix, from userid 1000)
        id CB9C3106702D; Wed,  5 Jul 2023 23:22:36 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v1] Input: cpcap-pwrbutton - replace GPLv2 boilerplate with SPDX
Date:   Wed,  5 Jul 2023 23:22:31 +0200
Message-Id: <20230705212231.631525-1-sre@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the GPLv2 boilerplate text with a nice and short
SPDX header.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Based on afbc67a90c7ccef304796af15477b43de5555b07
("Input: cpcap-pwrbutton - remove initial kernel-doc notation")
---
 drivers/input/misc/cpcap-pwrbutton.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
index 5aff5a7d6a35..85cddb84717a 100644
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * CPCAP Power Button Input Driver
  *
  * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
-- 
2.40.1

