Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E807C72F7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbjFNIbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjFNIbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:31:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5F1FCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:30:59 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgzCP3mRzzBQJYn
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:30:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686731455; x=1689323456; bh=BeMI+RRIGeECSvPNxvrh+SCG+fs
        Zlrc8ALkYqEnCFpE=; b=X2do0Y8SUbG7v4j5bPuDuutaiQKM1SqfruSGUeRZfoi
        F80d1GM4I5zpMaurOPOvkTaI8hyozYfhTDSgwMBGLmuQrJxXSNG32YGUZ/qH6Kw3
        ue/nrCiMxF7j/GGzzCwDsTYSGrh7ul6kVOVd5XnP8nhUMe/lgw17386QVuh+lpNE
        oWFrgo2pdGedfaHM1beMQP0rp6nXVlAR0jNwundAyLEzJ0mXkYSys63fECvsWDaP
        vs5y34WbsdIx9qeS1vl4J48ZL3Ko/iJU6ahRmeoOlVZzS/bvA4xd6C0AOiK6gXIH
        e3RwAKu9nzA2GVy6UMab/4BQYhkwtC3LN0i+bia3dUg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UomKeUm5mDiS for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:30:55 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgzCM120QzBJJCt;
        Wed, 14 Jun 2023 16:30:55 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:30:55 +0800
From:   hexingwei001@208suo.com
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Subject: [PATCH] lib/test_printf.c: space required after that ','
In-Reply-To: <20230614082523.63191-1-panzhiai@cdjrlc.com>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
X-Sender: hexingwei001@208suo.com
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

Add missing spaces to clear checkpatch errors:

lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).
lib/test_printf.c:562: ERROR: space required after that ',' (ctx:VxV).

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  lib/test_printf.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7677ebccf3c3..9d17c564fdf6 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -559,7 +559,7 @@ static void __init
  bitmap(void)
  {
      DECLARE_BITMAP(bits, 20);
-    const int primes[] = {2,3,5,7,11,13,17,19};
+    const int primes[] = {2, 3, 5, 7, 11, 13, 17, 19};
      int i;

      bitmap_zero(bits, 20);
