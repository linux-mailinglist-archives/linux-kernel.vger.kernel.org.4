Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0900659AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiL3RXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiL3RXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:23:51 -0500
X-Greylist: delayed 170 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Dec 2022 09:23:48 PST
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473E6FD19;
        Fri, 30 Dec 2022 09:23:48 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id BF6D81468;
        Fri, 30 Dec 2022 18:23:46 +0100 (CET)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1672421024; x=1674235425; bh=fO2Ta8gQoZusE1bBuaw
        217knTKoCUDuwlkal8bO/pZc=; b=stoRQRgUZaZP+9RRiZOa0fBrItmxqx9CpFD
        I6GcCG1eS1EPz+dDlPs3I2IhV5jlOTR6hMT+Hphmotjah2jp6FGFIpNs5NJlilrI
        fnKR71YKO+Wm2yQyzZraxsLQ2BBWGbHn4VrPefba196HmlFydB7dVIWW160bUc0z
        Ssm/WZKA9etZMRwucEIZSMouYcAEvMrJXo7gVx+26ZqqM0X/c/dKwKrJOFBLmWwF
        3GD13UMg5Ltm0JboZ3sP3kYAa0QCTwq9E7hOibOEYFBwn3dCyhz8NDtcMmUWaPFN
        lCYXK1GS24ONpSNntsI7xKVnzd8FDbdKq4qJZ+KUSja2TIji9IX40zD98Z7vQALW
        U7j0s5A8vgMWfV5Iq0CbC8Cyi4rfaIi/a2RSvNPutQJnmPmQ6PZf7/wXWwI99s+T
        jpTVJs2v1YlYfCEGrZ7xSr6kugecEF9usD75FvOgha0ow+R2s9NE6PaG7LBGtWe4
        KXrmX6tO3vFK72RBHViM/kHQmYZ6azUJSEJhYpMrvoAxRSbVFdYRCqE5l70bHGZQ
        o9whxJ87hTD6KR7WTyViax/+GvJx/0n3NTA6MKGKUzaMMP7hQE4XKIy9pXGVgyH2
        GewHDKBzWv3CjEDm6efgXrXySM0qPtpx4yin5Ic+9gNjjOEjMEwRXCWw10UJQ3zY
        LGE759MY=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q2XVluE6iL6v; Fri, 30 Dec 2022 18:23:44 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id DBE1A1467;
        Fri, 30 Dec 2022 18:23:42 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 922E1254E;
        Fri, 30 Dec 2022 18:23:42 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] doc: fix typo in botching up ioctls
Date:   Fri, 30 Dec 2022 18:23:28 +0100
Message-Id: <20221230172328.58612-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type contained a typo `uintprt` -> `uintptr`

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/botching-up-ioctls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v1 -> v2 fix the typo in the commit message

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

