Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858BA609F64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJXKyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXKyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:36 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D5065BD;
        Mon, 24 Oct 2022 03:54:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6EBD61D84;
        Mon, 24 Oct 2022 12:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608275; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=Vx66ENX8B8kIe6BX2BaW+D/YVu0rgeih4x2rY/yzaTY=;
        b=YcpYO+CEYFZTRhRE8s5SjUiovlo5vMf0gUXngSmImmJGmzRemBlG4OOa28kRxv7BUfiyNd
        iU5cOLCZALME1hSLbi/gCXFssfBMKo9VsJehpFVW4OV/i7lShR2MsR1fqJVNPawQu1nuIZ
        kScFNk0YU5BORixjkdUDHQjrT6QY/q6gTu266LdQJr88lJXN6497RPplGZRBwyVvjRgz3x
        I8zPwWjTASRAvE+675FMAx4s4M5Xsu0+SGWU3wr+5LUxrcLMHBcSoWLkSSSwvIDEQMOZ80
        ybC/MMh4s7q0n1bw92Uf8faQ5PP4weqVJiwNBbOmSz2TRLHFrmr1dHzhWqBoKA==
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
Subject: [PATCH RT 9/9] Linux 4.19.255-rt114-rc1
Date:   Mon, 24 Oct 2022 12:44:25 +0200
Message-Id: <20221024104425.16423-10-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
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

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 localversion-rt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/localversion-rt b/localversion-rt
index fdcd9167ca0b..2ae39973e9f8 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt113
+-rt114-rc1
-- 
2.38.0

