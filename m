Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F336913A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBIWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjBIWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:44:48 -0500
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 14:44:47 PST
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [IPv6:2001:1600:4:17::1908])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B8188
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:44:47 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PCWxN2RGvzMqhcv;
        Thu,  9 Feb 2023 23:38:48 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4PCWxM4sQtzMqmwt;
        Thu,  9 Feb 2023 23:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1675982328;
        bh=3C2A52d/ypevFEfK5Ea/Q07EcfdWxoWV4VrxTpkOYRA=;
        h=From:To:Cc:Subject:Date:From;
        b=La36TCzeFX5lX49SxEtSPPD8CEhSE2x9ZeQ0A9fkUYcedOS11sncjEhOmyWdsfQKE
         oGXZmeLD2PbnJl73Lkze+9USZb8ysFygbQTeceHAB9w89BWi0d/37Nnc6OAQrhNdmI
         e5nT9GX4Vv04N1Am8qlUrlsDJNMohqU+l50aJ2H8=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Landlock repository
Date:   Thu,  9 Feb 2023 23:38:14 +0100
Message-Id: <20230209223814.308370-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I only use the kernel.org repository for Landlock.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20230209223814.308370-1-mic@digikod.net
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a36df9ed283d..70f13280921a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11686,7 +11686,7 @@ M:	Mickaël Salaün <mic@digikod.net>
 L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
-T:	git https://github.com/landlock-lsm/linux.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	include/uapi/linux/landlock.h
-- 
2.39.1

