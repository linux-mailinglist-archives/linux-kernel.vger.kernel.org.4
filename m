Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B076393F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 06:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiKZFKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 00:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZFK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 00:10:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771271A839
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 21:10:28 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669439426;
        bh=bDIxcxkuTt1CVPb93jhG3KHHhCYP/VYgbfXwdy3Az4s=;
        h=From:To:Cc:Subject:Date:From;
        b=G23bT3f7aypq2wGM8D1gp67YAeyYSHs9EevYehqImsq914voa6TFrJbK/dCcmHoob
         PxBCILTEYNeMnNd63TcdGp8wH/DZteS271vEf4/lugPSA0T5LZgkpUSSgKChvJVfBK
         Rp/disrLphhMh/5YwUR5LnU+V7ZmyEeW5N65cT+Q=
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] firmware_loader: remove #include <generated/utsrelease.h>
Date:   Sat, 26 Nov 2022 06:09:59 +0100
Message-Id: <20221126051002.123199-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669439380; l=778; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=bDIxcxkuTt1CVPb93jhG3KHHhCYP/VYgbfXwdy3Az4s=; b=fFTES36NcD7vL27XygxIwaM3a4swpMuD3MsBDdgf6SgoftWjxKuVjdLBJA9xj+Azk1WWb37F6j3Y 2qHNLnknDUVPUzHSMqhXMgtTBjtHHS4RQGpqByVbekki4atV9mTS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

utsrelease.h is potentially generated on each build.
By removing this unused include we can get rid of some spurious
recompilations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/base/firmware_loader/firmware.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index fe77e91c38a2..bf549d6500d7 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -9,8 +9,6 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 
-#include <generated/utsrelease.h>
-
 /**
  * enum fw_opt - options to control firmware loading behaviour
  *

base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
-- 
2.38.1

