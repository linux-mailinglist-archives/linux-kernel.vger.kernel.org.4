Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6ED74C4AB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGIOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGIOMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:12:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F82A6
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 07:12:10 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzTbW2WXjzBJBg0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:12:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688911927; x=1691503928; bh=Oqo/UICIck48szuiKPT9stvme+K
        S0oG33Dm89Cb0R5M=; b=ouCVcYW+dlaWJuZ4/JGQNmLInUVJNS52fCDxtVV2Igv
        eJXE4A2Yi8HNE/r6GV9DGmvnOlGgRE69cxsL98jfggra0GFlw4M2MwlXlroFFJRI
        PIHcMv8Qy6Pjrvmj1lFnFOrPnAm+2U43g1c1+RxdT52nvyi3WsC4SXgnGuuRaDBj
        coR9qRMjIdJVgQ1zx+p4xFHVyKT1uJeghwkWIUguPf3AHC1U7UGjWnaYxUb5Y5ed
        u0Hoh14oPl2Cdm/1iUGh3BNbEyo06V0q2wPJMBfFDnSOG+lQ3R2kLGSgIvpVOr5r
        YIIiD6xJf2fhEtRG1qlBdYoiKTtCRkCgWJ+2gzpaHpw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T-rsNrxnftvv for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 22:12:07 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzTbW04HrzBHXkb;
        Sun,  9 Jul 2023 22:12:06 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 22:12:06 +0800
From:   xuanzhenggang001@208suo.com
To:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru
Cc:     mattst88@gmail.com, viro@zeniv.linux.org.uk,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha/boot/misc: prefer 'unsigned int' to bare use of
 'unsigned'
In-Reply-To: <20230709141002.8229-1-denghuilong@cdjrlc.com>
References: <20230709141002.8229-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <60256ab738fe281c1fb3ec72fba62c60@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/alpha/boot/misc.c:48: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/alpha/boot/misc.c:49: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/alpha/boot/misc.c:50: WARNING: Prefer 'unsigned int' to bare use of 
'unsigned'
arch/alpha/boot/misc.c:124: WARNING: Prefer 'unsigned int' to bare use 
of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/alpha/boot/misc.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/boot/misc.c b/arch/alpha/boot/misc.c
index 1ab91852d9f7..7d3249972587 100644
--- a/arch/alpha/boot/misc.c
+++ b/arch/alpha/boot/misc.c
@@ -45,9 +45,9 @@ typedef unsigned long  ulg;
  static uch *inbuf;        /* input buffer */
  static uch *window;        /* Sliding window buffer */

-static unsigned insize;        /* valid bytes in inbuf */
-static unsigned inptr;        /* index of next byte to be processed in 
inbuf */
-static unsigned outcnt;        /* bytes in output buffer */
+static unsigned int insize;        /* valid bytes in inbuf */
+static unsigned int inptr;        /* index of next byte to be processed 
in inbuf */
+static unsigned int outcnt;        /* bytes in output buffer */

  /* gzip flag byte */
  #define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
@@ -121,7 +121,7 @@ int fill_inbuf(void)
  void flush_window(void)
  {
      ulg c = crc;
-    unsigned n;
+    unsigned int n;
      uch *in, *out, ch;

      in = window;
