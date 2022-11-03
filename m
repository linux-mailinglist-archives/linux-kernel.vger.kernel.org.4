Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BE617827
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKCH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiKCH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:18 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE364D2;
        Thu,  3 Nov 2022 00:55:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B08B61E25;
        Thu,  3 Nov 2022 08:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1667462155; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=iM7/Cb+nw7/XhNgxvPpgpak6WIxnuT33RDfpMs3D2Hw=;
        b=Lh3j16fXa8M1UOia5EghSq6e/GqhOBuEZvdJujtSgWe862LE80kf10tGpemtmaB8Xzt2HT
        0TcrFqNT5+w0vQPDOG2E6L3/Hr/DIuVOR+r8A7az6xGjJ26j6K1mWg4vvZMZqIYsvrVLhE
        UVC/BaZXCTcsOP70DH1AuwykzjvvCJK7loXWVT3YR51BS/9VqJOOo5CPheoTVP9DfWgF50
        DOoHuLAklkbieBV32/E2DQckDBmxPnms6kGZX8Bpwnh8849Duik+kmyXHFfQc8FOS4CYYQ
        6PVcxRxuEUvjO15XybVnWHp08+oxx0KEtDa8qlSOxwImoOivu2mbZOv9dspkSg==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 4/4] Linux 4.19.255-rt114-rc2
Date:   Thu,  3 Nov 2022 08:55:48 +0100
Message-Id: <20221103075548.6477-5-wagi@monom.org>
In-Reply-To: <20221103075548.6477-1-wagi@monom.org>
References: <20221103075548.6477-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.19.255-rt114-rc2 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index fdcd9167ca0b..02781f8a2f80 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt113
+-rt114-rc2
-- 
2.38.0

