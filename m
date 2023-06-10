Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B758172AEBE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjFJUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFJUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:40:58 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99AD359A;
        Sat, 10 Jun 2023 13:40:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F2F45320015C;
        Sat, 10 Jun 2023 16:40:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 10 Jun 2023 16:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1686429655; x=1686516055; bh=V+EHzWmaeU
        zDQWNrC4qnlElG9+D76Sy2HHVrlQcCXrQ=; b=LsX/QsFDMQwtTDnF9GM61MiD2E
        Ke4SVMHveckFVfAOnS15feqiFtdmBNCNysynBbSSDfNfO+oIY1ncOWx/kEhPM5Je
        vcHXUudHa1Vtz1JGTOzFGcXL6oFiR3AFnbu3mXq/QRYdlUHR5dwYCBKwDbqErYMA
        bYwWWKfCXoiUYgmsErDNCOcqzFoBJ7HR/2lDVS1e/xFiIx5nxIPNmwT2x4Nk7x3Z
        PNDQkLZGU4ptcjTPqSuX33UZcUtVQsmcI1ZZ9HbX3CZTM9x0opNuDNUvWqSq7nRl
        hBx+vAr4o4WxYIHqFqjPUpb6pR4jOUeYqRWPjyCBR7I7jW1e7wJo07iVLvhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686429655; x=
        1686516055; bh=V+EHzWmaeUzDQWNrC4qnlElG9+D76Sy2HHVrlQcCXrQ=; b=i
        v9YkUoEGZ9tVeBpBZ9yCK9uhLYBpxUOB/Rwtys3LFZRwKm3f7Fndw1d0P8hauvp4
        hb9IlGlJuBykt8wD7SG1LfAHo6QBjjt8MMzFuZii+n4OqcW1Vic+FwaoICQeldC6
        Fr3jlcR4WtzSvt3Od5nwOp3UcRMObDaj4Wkhz32LRM45pPvgLyf7E0/n7DaFd7Yy
        QKWJagpr4SkDfWkDHSx/HTo6KJAmcAgWSH4V2l1tlqxqau92UMQICcz5DqwmyQic
        IxPrFTZGlHX41/rMy1+ReyIuSBNwQwAD6rqFRBkPB+qjeog2NG0x6+Z4f3WlU3Sh
        /jYFw9vNa/i8ldC+8LVbQ==
X-ME-Sender: <xms:19-EZGdoL8JIpvDQ_LDOQY4sHbTLDvvOyKn7b115n6zo9_EMOOrJ3w>
    <xme:19-EZAMa5h4K_ezj8PfO2j42eZ9iP8YMVyM5uBkL-J-8Mvt_Ro-qcejDyo7au2oVP
    lSmgGT9x52LiTw>
X-ME-Received: <xmr:19-EZHgdfG8JEAtKniFfxroZiY2WynFKd7My6JAwsZ-SCtgZflpbIdJbJUYlICARwC3gctgNJYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedutddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:19-EZD_I1XniFSTmL6QRzm-NB0yUw8BAYDZ_U7DHqMd8d3VQsOJ5uw>
    <xmx:19-EZCuhRmo3x2aBnNsun-lmEi38nV8lkOWFJRGiUKJ40BWJPobGIA>
    <xmx:19-EZKHdaRMXrE6GcsbVqjiC9wks4O4ywNNfeE__ScPAHkE70oW9gg>
    <xmx:19-EZNmzXygjK4xdlMaBqdepXfzi0X0XZhhKcDOGFktbt2EEUTMABw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Jun 2023 16:40:53 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Lee Jones <lee@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v3 1/4] limits.h: add UCHAR_MAX, SCHAR_MAX, and SCHAR_MIN
Date:   Sat, 10 Jun 2023 16:40:41 -0400
Message-Id: <20230610204044.3653-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610204044.3653-1-demi@invisiblethingslab.com>
References: <20230610204044.3653-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers already defined these, and they will be used by sscanf()
for overflow checks later.  Also add SSIZE_MIN to limits.h, which will
also be needed later.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 .../media/atomisp/pci/hive_isp_css_include/platform_support.h  | 1 -
 include/linux/limits.h                                         | 1 +
 include/linux/mfd/wl1273-core.h                                | 3 ---
 include/vdso/limits.h                                          | 3 +++
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
index 0cdef4a5e8b1bed9884133f1a0b9d853d59d43a4..e29b96d8bebf14839f6dd48fdc6c0f8b029ef31d 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/platform_support.h
@@ -27,7 +27,6 @@
 
 #define UINT16_MAX USHRT_MAX
 #define UINT32_MAX UINT_MAX
-#define UCHAR_MAX  (255)
 
 #define CSS_ALIGN(d, a) d __attribute__((aligned(a)))
 
diff --git a/include/linux/limits.h b/include/linux/limits.h
index f6bcc936901071f496e3e85bb6e1d93905b12e32..8f7fd85b41fb46e6992d9e5912da00424119227a 100644
--- a/include/linux/limits.h
+++ b/include/linux/limits.h
@@ -8,6 +8,7 @@
 
 #define SIZE_MAX	(~(size_t)0)
 #define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
+#define SSIZE_MIN	(-SSIZE_MAX - 1)
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
 #define U8_MAX		((u8)~0U)
diff --git a/include/linux/mfd/wl1273-core.h b/include/linux/mfd/wl1273-core.h
index c28cf76d5c31ee1c94a9319a2e2d318bf00283a6..b81a229135ed9f756c749122a8341816031c8311 100644
--- a/include/linux/mfd/wl1273-core.h
+++ b/include/linux/mfd/wl1273-core.h
@@ -204,9 +204,6 @@
 				 WL1273_IS2_TRI_OPT | \
 				 WL1273_IS2_RATE_48K)
 
-#define SCHAR_MIN (-128)
-#define SCHAR_MAX 127
-
 #define WL1273_FR_EVENT			BIT(0)
 #define WL1273_BL_EVENT			BIT(1)
 #define WL1273_RDS_EVENT		BIT(2)
diff --git a/include/vdso/limits.h b/include/vdso/limits.h
index 0197888ad0e00b2f853d3f25ffa764f61cca7385..0cad0a2490e5efc194d874025eb3e3b846a5c7b4 100644
--- a/include/vdso/limits.h
+++ b/include/vdso/limits.h
@@ -2,6 +2,9 @@
 #ifndef __VDSO_LIMITS_H
 #define __VDSO_LIMITS_H
 
+#define UCHAR_MAX	((unsigned char)~0U)
+#define SCHAR_MAX	((signed char)(UCHAR_MAX >> 1))
+#define SCHAR_MIN	((signed char)(-SCHAR_MAX - 1))
 #define USHRT_MAX	((unsigned short)~0U)
 #define SHRT_MAX	((short)(USHRT_MAX >> 1))
 #define SHRT_MIN	((short)(-SHRT_MAX - 1))
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

