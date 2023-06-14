Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81072F5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbjFNHOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbjFNHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:14:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4FD98
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:14:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgxVn2SpFzBQJYP
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:14:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686726849; x=1689318850; bh=ZkSEV9T4m9A5Dk91EECTWaD8pX/
        puAJicguo1fQWDOc=; b=oY3pe124ZkZWhhSAIDdR0kEyqPA9r6yNz1Sja8qiKpq
        D8grX5BG+NOgwpDYCsb9jJsaGaL+ldWbxfRqc4wtADZDDD52cQx9c+alDycRiBVn
        UrW0egadHubKUO24mmIUM5nUjLRBlW3gNWN3E9Y4l5VPRYhtG5F/+XOGPxyYafX5
        DeFKaOg1sIj1ngOGqm3mcoeldEh8aUa3VYrJmiFvZRguyUsJiz6W4f4SXRW/F71P
        NK2psj2zgewl9bxboaBZ4q9XTtTkl96nAsSEy5AHalyO2iH7yYG1hmwu7uyoWgYT
        opADniCXdiCFMr7SxfJTIVDQfOnestdoxQOYVqdrzTg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7Ir6jmMnpv8q for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 15:14:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgxVn165zzBJLB3;
        Wed, 14 Jun 2023 15:14:09 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:14:09 +0800
From:   baomingtong001@208suo.com
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: zstd: remove unneeded variable
In-Reply-To: <20230614071235.55955-1-luojianhong@cdjrlc.com>
References: <20230614071235.55955-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <8c519982c1b73dfb4aa84c8215c8a5ac@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:

lib/zstd/compress/zstd_cwksp.h:220:17-27: Unneeded variable: 
"slackSpace". Return "ZSTD_CWKSP_ALIGNMENT_BYTES".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  lib/zstd/compress/zstd_cwksp.h | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/zstd/compress/zstd_cwksp.h 
b/lib/zstd/compress/zstd_cwksp.h
index 349fc923c355..36c574cd3d6f 100644
--- a/lib/zstd/compress/zstd_cwksp.h
+++ b/lib/zstd/compress/zstd_cwksp.h
@@ -217,8 +217,7 @@ MEM_STATIC size_t 
ZSTD_cwksp_slack_space_required(void) {
       * n_1 + n_2 == 64 bytes if the cwksp is freshly allocated, due to 
tables and
       * aligneds being sized in multiples of 64 bytes.
       */
-    size_t const slackSpace = ZSTD_CWKSP_ALIGNMENT_BYTES;
-    return slackSpace;
+    return ZSTD_CWKSP_ALIGNMENT_BYTES;
  }
