Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C3718569
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjEaO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjEaO63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:58:29 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 07:58:27 PDT
Received: from mta01.prd.rdg.aluminati.org (mta01.prd.rdg.aluminati.org [94.76.243.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785D1C0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:58:27 -0700 (PDT)
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
        by mta.aluminati.local (Postfix) with ESMTP id CF029C09D9;
        Wed, 31 May 2023 15:48:57 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
        by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id C25A1203EC;
        Wed, 31 May 2023 15:48:57 +0100 (BST)
X-Quarantine-ID: <HRnR79ostaMS>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
Received: from mta.aluminati.local ([127.0.0.1])
        by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HRnR79ostaMS; Wed, 31 May 2023 15:48:56 +0100 (BST)
Received: from donbot.metanate.com (dougal.metanate.com [90.155.101.14])
        by svc01-1.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 9CC2D1C0003;
        Wed, 31 May 2023 15:48:54 +0100 (BST)
From:   John Keeping <john@keeping.me.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Keeping <john@keeping.me.uk>
Subject: [PATCH] mailmap: add entry for John Keeping
Date:   Wed, 31 May 2023 15:48:39 +0100
Message-Id: <20230531144839.1157112-1-john@keeping.me.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map my corporate address to my personal one, as I am leaving the
company.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a289b25ea2c7..4f67bec31116 100644
--- a/.mailmap
+++ b/.mailmap
@@ -233,6 +233,7 @@ Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@syn=
aptics.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
+John Keeping <john@keeping.me.uk> <john@metanate.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
 <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
--=20
2.40.1

