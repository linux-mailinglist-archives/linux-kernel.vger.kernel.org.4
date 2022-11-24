Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D7763725F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 07:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKXGai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 01:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKXGag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:30:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE1DC31E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 22:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nrrU1iMKOJ5VEz3svZcTtdqaJ4tTExkhjMaB+q0Gp5U=; b=OIR7QCm6YrBs+YtT8gxg4DcqSM
        6IbvdUIASWuj3JmhiIu+LfVzD33y7RF9bqv+3VSLm+ttHw0/cfaDbPwN/M82ofacMS/m/2ulr746e
        dsq9W0OOL81gg1UyhDXq+w17TgAyrI1TOq88MkFgrUO4adSDCHmpbdlRQpQrEj4P9y8RRotcKpvpj
        FydAOumK4KIcjJx6EjWjPvhCfLjbaSasNkcSIkKFFuesgLz/XO55OXYUo8mETGs5rTlLvUKa63EnG
        cr3N6IvPFRDTx8OP+HaWjOXnIn1hk6+67ZxOkcqGnkO4uyVn+HHRN05Zc4P414ihxkQWljZxZYar6
        rx+X9f3Q==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy5kd-008SBB-HZ; Thu, 24 Nov 2022 06:30:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] irqreturn.h: fix kernel-doc warnings
Date:   Wed, 23 Nov 2022 22:30:13 -0800
Message-Id: <20221124063013.28479-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

irqreturn.h:6: warning: missing initial short description on line:
 * enum irqreturn
irqreturn.h:15: warning: Enum value 'IRQ_NONE' not described in enum 'irqreturn'
irqreturn.h:15: warning: Enum value 'IRQ_HANDLED' not described in enum 'irqreturn'
irqreturn.h:15: warning: Enum value 'IRQ_WAKE_THREAD' not described in enum 'irqreturn'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/irqreturn.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/include/linux/irqreturn.h b/include/linux/irqreturn.h
--- a/include/linux/irqreturn.h
+++ b/include/linux/irqreturn.h
@@ -3,10 +3,10 @@
 #define _LINUX_IRQRETURN_H
 
 /**
- * enum irqreturn
- * @IRQ_NONE		interrupt was not from this device or was not handled
- * @IRQ_HANDLED		interrupt was handled by this device
- * @IRQ_WAKE_THREAD	handler requests to wake the handler thread
+ * enum irqreturn - irqreturn type values
+ * @IRQ_NONE:		interrupt was not from this device or was not handled
+ * @IRQ_HANDLED:	interrupt was handled by this device
+ * @IRQ_WAKE_THREAD:	handler requests to wake the handler thread
  */
 enum irqreturn {
 	IRQ_NONE		= (0 << 0),
