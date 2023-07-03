Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139517465F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGCXAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGCXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:00:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896510C1;
        Mon,  3 Jul 2023 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bxqKt58hvR1yu9IqldV+R5b5cGD0Xza3I0u2tbjL9Vw=; b=I96+baD6s7h7h0ghpfeUope7Bb
        S1fK9QrqbLZTVyD1BZBOhA5EVwMY9RhRrHClHr94wiGyKJhXTZae7Z6/qdeMOUT9+OpHy+PaSX161
        4Ld+mLzWBj13TH4wcBRleTPPCQsf6//Yuso10xD4b8UDMJywyZNnhoNfBQvDFApSogQUAcKpaOvss
        aGe9mTkeXHHDFxa9ZhM8dm69L70PnCRKnNXN8R+kjo+TTC/kHr45xYscXP2yFaZheOGWOctEgMNce
        guE8+Jq8Nabg48En20hYWyyNNLggYMfejkSSZ+7/ugT9j12Z6dAiaAstmvrumR/Gpx7tWAHLw2i23
        BP0kij3A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGSWc-00BbO7-2A;
        Mon, 03 Jul 2023 23:00:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH RESEND] input: cpcap-pwrbutton: remove initial kernel-doc notation
Date:   Mon,  3 Jul 2023 16:00:05 -0700
Message-ID: <20230703230005.14877-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
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

Change the beginning "/**" in the file to "/*" since it is not a
kernel-doc comment. This prevents a kernel-doc warning:

drivers/input/misc/cpcap-pwrbutton.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * CPCAP Power Button Input Driver

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/cpcap-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/input/misc/cpcap-pwrbutton.c b/drivers/input/misc/cpcap-pwrbutton.c
--- a/drivers/input/misc/cpcap-pwrbutton.c
+++ b/drivers/input/misc/cpcap-pwrbutton.c
@@ -1,4 +1,4 @@
-/**
+/*
  * CPCAP Power Button Input Driver
  *
  * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
