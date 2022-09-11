Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA05B4CBD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiIKIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiIKIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 04:48:00 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5958A32A89
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 01:47:56 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 38540 invoked from network); 11 Sep 2022 10:47:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662886074; bh=zTGL6yt8YAH2AxgKZxN+HtlBpnR7VOF2iiAevzJvzQY=;
          h=From:To:Cc:Subject;
          b=tDkKCJa1OfCHJMtIbsycFd7rSAYWJoUO7G6cNvXRA4U2XdxiRyJU7Ba4GZFFFCmyW
           jwBZ0+EIVzHK8WyJeDjmVes0sYKkYIxqHB4hC179r/HgeANKr9UR0prAqm7vmQQ158
           W2HpWxW1rGn0JM2k/YHGVS9tjZfZ6L7HR1azfW1s=
Received: from aafh243.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.137.243])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Sep 2022 10:47:54 +0200
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 09/10] x86/Kconfig: document release year of glibc 2.3.3
Date:   Sun, 11 Sep 2022 10:47:10 +0200
Message-Id: <20220911084711.13694-10-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220911084711.13694-1-mat.jonczyk@o2.pl>
References: <20220911084711.13694-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2167ce314221207ad3dca84bf1b65b5b
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [8cNE]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder how many people were checking their glibc version when
considering whether to enable this option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
---
v2: shorten prompt.

 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 31f778b0cd0b..4612c356da4c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2278,7 +2278,7 @@ config DEBUG_HOTPLUG_CPU0
 
 config COMPAT_VDSO
 	def_bool n
-	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
+	prompt "Workaround for glibc 2.3.2 / 2.3.3 (released in year 2003/2004)"
 	depends on COMPAT_32
 	help
 	  Certain buggy versions of glibc will crash if they are
-- 
2.25.1

