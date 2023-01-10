Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1F66397A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAJGtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAJGss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:48:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038B33D73
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YozUQi9rtbflYdfoNzE7G0b9pFLGtmnx+61KeVcyisI=; b=IG5q4IGUjapGCV4ADH/NHHK0Cb
        Fq6GOV/OemtAD5BcFVDiyszFS+LyyOtC+BE492/C+HZ4EyYJMJcUChLyWphN93xfkY3DJ6w9bKiBF
        uew8TXi4KN+Hmj/bm/9gcTJh4to4MYVHve3uKcxAAWOEgRhiShLDx/wpQa9irXgRS+gVzRsiLD+tk
        HCUfo6Q14KsZiEp3mc5FtZQIx2o9AXg/1jlIlD7dZJdvcmr63ucsBWdWFuLFF+YlRdnEx8JR5xEt6
        OQNRfhgtddAN8anNBLpJSgjCrbllACjLBhKOt8OpOqND31XO3DD5167EqeCiK0tlpQkT205etw1tE
        ZWE5ykWg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF8RB-005WDz-Ul; Tue, 10 Jan 2023 06:48:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        David Schleef <ds@schleef.org>,
        Shawn Bohrer <shawn.bohrer@gmail.com>,
        Frank Mori Hess <fmhess@users.sourceforge.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] comedi: use menuconfig for main Comedi menu
Date:   Mon,  9 Jan 2023 22:48:44 -0800
Message-Id: <20230110064844.18533-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring the Comedi menu in line with most other device drivers
by using "menuconfig" instead of "config" for the top-level entry.
This also fixes a menu presentation issue with xconfig.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Schleef <ds@schleef.org>
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>
Cc: Frank Mori Hess <fmhess@users.sourceforge.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-config COMEDI
+menuconfig COMEDI
 	tristate "Data acquisition support (comedi)"
 	help
 	  Enable support for a wide range of data acquisition devices
