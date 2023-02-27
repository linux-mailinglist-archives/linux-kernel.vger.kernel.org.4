Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD946A3F19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjB0KG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjB0KGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:06:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC111E5E8;
        Mon, 27 Feb 2023 02:06:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bx12so2409149wrb.11;
        Mon, 27 Feb 2023 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWPtIeGJuLp2sNqEUD7UlToTJ4p0ZWwdgktgqC9Ag+M=;
        b=kpmv7ygLhic7CkQUH8FSQ1S84c4UmufxDVATvkq61obO/OPQQElNy/sFDO3FBUbGZY
         m37m29y10lmsdhgCh9fEaOCaHza+cuQugNbK38FDRg5JO09TuapmOTiJ6mCtC0lMFIto
         iYx/y08+hxxOUAUS3KyvKXIE3b/LiaVk4GNZr6vRUT6yW0AP5XBxwEK+/LZjNXLHmzH2
         agwe6H1/UBFQdohk6U1SZ4HaHs3lcCkHl/IqxYt+DxIF1dUXoSfyqGNkGd9FLtQJM8qN
         cxJVisvE6b+D9/CL6dXjltIZmKbwtiPy5nQYZBqNFW6w3bZC+AEjwoN/m1Kk3hjeoqy0
         nFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWPtIeGJuLp2sNqEUD7UlToTJ4p0ZWwdgktgqC9Ag+M=;
        b=xXFhMlSH4jr2JARIoT8hDA8RJkXrE4ccyjwnCBlnioQO/J385laniRV5nthxnOtvZM
         j10ipxvaAvZOLYiW35e13AwcpDeaHzVUedGeUzUdwNPaT9w0OTFjRJPVDrRhYJWjWfyz
         8T2xc/ZakOUOwtKy3SPxaajI0Y8N6jsRn0BgeQ7KfKNpVGZHmh1AJrPQnJrX6GNh1YF+
         wrpQbHY/ohEuk7CxmPRpkWaalSAz9JVEchBfdu9h4ukDeF2ew97Jb7spaLkibSC+bYUm
         qItUhvQ6BmngtbhCUdll7MD4mf+DLXjVYadvQs6fBEFpmDhCqFPZXmBuFiB5zTucMi0U
         txLw==
X-Gm-Message-State: AO0yUKUaShDsHhUeVVOxpuM7+EVCgneAM3i0mFyAx/OKGvvm7w1ILwhg
        Ett+CU/aaRkNSzi06JdsbOUptrr5POk=
X-Google-Smtp-Source: AK7set+EYtKmyM2Jpl/lq7Xexv+iRyoOjpkhf8PuQko9ygB3oBuXA0vflCN2lZwL/NosTd6RfgHw2g==
X-Received: by 2002:a5d:4e47:0:b0:2c8:840:26ea with SMTP id r7-20020a5d4e47000000b002c8084026eamr7842180wrt.12.1677492377048;
        Mon, 27 Feb 2023 02:06:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d4ec8000000b002c704271b05sm6665807wrv.66.2023.02.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:06:16 -0800 (PST)
Date:   Mon, 27 Feb 2023 13:06:12 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] dca: delete unnecessary variable
Message-ID: <Y/yAlDytLH0ZNLNz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more readable to just pass NULL directly instead of using a
variable for that.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This subsystem seems unmaintained, but I already looked at the code and
wrote the patch...  Andrew, could you take this?

 drivers/dca/dca-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index c40c2ebfdae9..ed3dac546dd6 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -294,9 +294,7 @@ EXPORT_SYMBOL_GPL(dca3_get_tag);
  */
 u8 dca_get_tag(int cpu)
 {
-	struct device *dev = NULL;
-
-	return dca_common_get_tag(dev, cpu);
+	return dca_common_get_tag(NULL, cpu);
 }
 EXPORT_SYMBOL_GPL(dca_get_tag);
 
-- 
2.39.1

