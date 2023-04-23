Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4516EBD42
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 07:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDWFsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 01:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWFsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 01:48:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376FE19B1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vWpzRzo8cm9efAzaoFwYkqDS+jJeQhHNqJ+MkOQpCN4=; b=Z0rNnvswabJzlpm94qEF+uOGN+
        opX9a8X/xSZZyiF4ewvOhUVjIUhgVuU3ZukEaaBk00W1DWkGbO+EJwDcTF3tmUsW2EB2Kli4jbAoh
        kFwCU90vsDjyuxzIcOwc4WlZjnboLjmrN3Gx9TKczkqiql0Ea7Vfmtn6K48P8Ufaf5s997wBobHBh
        A//3rqE3S63FmLMafJ/yQbmqSWnvvZ+Fd+EUEYUlxuSvE9woly3sP+EYyH+QCc1SuMNkSXP6yUDxB
        zCD30TxbGP8+2C0Go6v8T+KrdrQeH2c1udGiaswq8Cm7L8bA36qMtUz1Jt+znb7DMp/YdLZDVM4gT
        Kyzq1WnQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqSae-00DneG-2R;
        Sun, 23 Apr 2023 05:48:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kristoffer Ericson <Kristoffer.ericson@gmail.com>,
        Russell King <linux@arm.linux.org.uk>, patches@armlinux.org.uk
Subject: [PATCH] arm: HP Jornada 7XX: fix kernel-doc warnings
Date:   Sat, 22 Apr 2023 22:48:45 -0700
Message-Id: <20230423054845.27204-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings from the kernel test robot:

jornada720_ssp.c:24: warning: Function parameter or member 'jornada_ssp_lock' not described in 'DEFINE_SPINLOCK'
jornada720_ssp.c:24: warning: expecting prototype for arch/arm/mac(). Prototype was for DEFINE_SPINLOCK() instead
jornada720_ssp.c:34: warning: Function parameter or member 'byte' not described in 'jornada_ssp_reverse'
jornada720_ssp.c:57: warning: Function parameter or member 'byte' not described in 'jornada_ssp_byte'
jornada720_ssp.c:85: warning: Function parameter or member 'byte' not described in 'jornada_ssp_inout'

Fixes: 69ebb22277a5 ("[ARM] 4506/1: HP Jornada 7XX: Addition of SSP Platform Driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202304210535.tWby3jWF-lkp@intel.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kristoffer Ericson <Kristoffer.ericson@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: patches@armlinux.org.uk
---
KernelVersion: 6.3-rc7

 arch/arm/mach-sa1100/jornada720_ssp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff -- a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  *  arch/arm/mac-sa1100/jornada720_ssp.c
  *
  *  Copyright (C) 2006/2007 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
@@ -26,6 +26,7 @@ static unsigned long jornada_ssp_flags;
 
 /**
  * jornada_ssp_reverse - reverses input byte
+ * @byte: input byte to reverse
  *
  * we need to reverse all data we receive from the mcu due to its physical location
  * returns : 01110111 -> 11101110
@@ -46,6 +47,7 @@ EXPORT_SYMBOL(jornada_ssp_reverse);
 
 /**
  * jornada_ssp_byte - waits for ready ssp bus and sends byte
+ * @byte: input byte to transmit
  *
  * waits for fifo buffer to clear and then transmits, if it doesn't then we will
  * timeout after <timeout> rounds. Needs mcu running before its called.
@@ -77,6 +79,7 @@ EXPORT_SYMBOL(jornada_ssp_byte);
 
 /**
  * jornada_ssp_inout - decide if input is command or trading byte
+ * @byte: input byte to send (may be %TXDUMMY)
  *
  * returns : (jornada_ssp_byte(byte)) on success
  *         : %-ETIMEDOUT on timeout failure
