Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13A659AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiL3R16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiL3R14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:27:56 -0500
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F5113B;
        Fri, 30 Dec 2022 09:27:55 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 6F4051B3C;
        Fri, 30 Dec 2022 18:20:56 +0100 (CET)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1672420853; x=1674235254; bh=99ByR2tq5JLhQR4+MTv
        Sm3Sw418P1F9GiyP9tDZjzi8=; b=DLo/055cOipsDakQEGTmNlmF/IhKun4L7TX
        y0AUE+3PKDaSJrxF4aYe9Kc1MyFdW1zuFmsuM/VAqCj8eKF5NmsxHT2KdCxLUuh2
        t2LoeBHkG8mpVUHq+8/ramKshSqH3uPWyS7m36tcnKsNz5KkgrrE5ZRe0U+GCycn
        VwgNUe0uINh0ft0fOYudUutJBoddr2FJoB+pcvWaig75DqmZF+8nl9uIMJ1kOA7f
        9b24GlS1NDlP8DMkvbeq/5HWdMPC+0DKcMBe1sbDtIjIMumCRD5jFkXovXhvXA9w
        FvZBdwVgZwBEE87d8b9UcnN54Y6fR75H2b64UIvJgwmeTlHswBb2TK2biakktM7D
        kQQHYRl2oZqwcCDTtkOYjYq7wzI5JqRRevJYseNkEZ3D1X1o5z5FRA2b54/VZXyX
        eQysVg9x0nTI43kfpIZUYqHdAlHw3TmksdUrwBiDa6i/fnTBixsOe6yjG0GFubhw
        4M/eZ7NF+unrclsrdCH+czjJhnVjdtk5OsBw9F1r6+pkgksuQad6ElpSmqE48ROb
        Df8VGN/Ghe1yPa0lF1iVFNU9XcJ4yvdTIOzhR/2rT52y/C6kxZTM+E7B3AJpLo0E
        RPfhGQX0DsZsGFK6EcTcxMjrTJ8ZyF6Ih7DcsV7zeBE24TTfvdkPuBSwi2IX1Jxz
        hUk1IjIc=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xLYFPb-k0vU6; Fri, 30 Dec 2022 18:20:53 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id BBE911B36;
        Fri, 30 Dec 2022 18:20:52 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 341D0BC4;
        Fri, 30 Dec 2022 18:20:52 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: fix typos in botching up ioctls
Date:   Fri, 30 Dec 2022 18:20:24 +0100
Message-Id: <20221230172024.58372-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type contained a type `uintprt` -> `uintptr`

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/botching-up-ioctls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/botching-up-ioctls.rst b/Documentation/process/botching-up-ioctls.rst
index ba4667ab396b..9739b88463a5 100644
--- a/Documentation/process/botching-up-ioctls.rst
+++ b/Documentation/process/botching-up-ioctls.rst
@@ -41,7 +41,7 @@ will need to add a 32-bit compat layer:
    structures to the kernel, or if the kernel checks the structure size, which
    e.g. the drm core does.
 
- * Pointers are __u64, cast from/to a uintprt_t on the userspace side and
+ * Pointers are __u64, cast from/to a uintptr_t on the userspace side and
    from/to a void __user * in the kernel. Try really hard not to delay this
    conversion or worse, fiddle the raw __u64 through your code since that
    diminishes the checking tools like sparse can provide. The macro
-- 
2.30.2

