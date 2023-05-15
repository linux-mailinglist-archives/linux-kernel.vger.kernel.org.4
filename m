Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5387038DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbjEORfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbjEORfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:35:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB41560C;
        Mon, 15 May 2023 10:33:08 -0700 (PDT)
From:   "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684171987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYa4NIoRwK77mO2jcboViBt+jqXZhNpE7ckEwsEc9Bc=;
        b=Vqt01Sx+MgrLW7k3LIc6jc5YvFkISrk/2rBg9ogFTG/hd4A2PO6SBYi9Gx8TmjTVljEH5i
        4n3KrEu5+L+S1YVDVfg4lp+d5XlSvphHZPOxKMuc6ecc7w2qvHOPWHRaU68qcskZqTIYlD
        FpKwFHSFm9RGvaWLxcCvlKPZE0X3DZaiYqvepnkCEDxoLuZrCQaOv0Abngl+/xt9oKGKaP
        cgv2ND0hPoHl2OHx5NV5ITw3eYSSYKoeQ+i+dX4fvBbc2X9ikpZa/Dq6SM3LE9MSDJquQx
        Wa8ihw+DQ2GSTxsFVm9Pb8SCNhb14nA2/sxRx/jKpKJLxUSGEnI00HmMyAWVkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684171987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYa4NIoRwK77mO2jcboViBt+jqXZhNpE7ckEwsEc9Bc=;
        b=YPomW4tfQ86omjkiMiVy0O3HDWpJ1KA3stQ3WtxlxAtCtB/akzOUPTCE92zKHc1XEp04ba
        bnaeCxQVBOuOX3CQ==
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 2/2] docs: Set minimal gtags / GNU GLOBAL version to 6.6.5
Date:   Mon, 15 May 2023 19:32:17 +0200
Message-Id: <20230515173217.64864-3-darwi@linutronix.de>
In-Reply-To: <20230515173217.64864-1-darwi@linutronix.de>
References: <20230509012616.81579-1-darwi@linutronix.de>
 <20230515173217.64864-1-darwi@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel build now uses the gtags "-C (--directory)" option, available
since GNU GLOBAL v6.6.5.  Update the documentation accordingly.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Cc: <stable@vger.kernel.org>
Link: https://lists.gnu.org/archive/html/info-global/2020-09/msg00000.html
---
 Documentation/process/changes.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index ef540865ad22..a9ef00509c9b 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -60,6 +60,7 @@ openssl & libcrypto    1.0.0            openssl version
 bc                     1.06.95          bc --version
 Sphinx\ [#f1]_         1.7              sphinx-build --version
 cpio                   any              cpio --version
+gtags (optional)       6.6.5            gtags --version
 ====================== ===============  ========================================
 
 .. [#f1] Sphinx is needed only to build the Kernel documentation
@@ -174,6 +175,12 @@ You will need openssl to build kernels 3.7 and higher if module signing is
 enabled.  You will also need openssl development packages to build kernels 4.3
 and higher.
 
+gtags / GNU GLOBAL (optional)
+-----------------------------
+
+The kernel build requires GNU GLOBAL version 6.6.5 or later to generate
+tag files through ``make gtags``.  This is due to its use of the gtags
+``-C (--directory)`` flag.
 
 System utilities
 ****************
-- 
2.30.2

