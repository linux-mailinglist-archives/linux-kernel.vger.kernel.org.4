Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6186B0B38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjCHObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjCHOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:30:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F30F46155;
        Wed,  8 Mar 2023 06:30:16 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id da10so66603742edb.3;
        Wed, 08 Mar 2023 06:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678285812;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAN9+ZOptTrJHDc9J/pvGJu6tT88Otl4KlrOdjgdjxk=;
        b=hoUMihzIGkavLUfhJznY22uHPF4Tmn2x6jn1DZ4t2jCt5kPNMFZ4w/NWBvzVNNYpI4
         axxFXa6Jo99KT9a2FY0/ce1qWsH3hGkunyyhZBaIdhI4MYxkCezFw74L++oc8Enu7qti
         ExRQmHICUggumz0LfWomrQq3NYcd5mM870qhI4IG/RKSOOnok7fxfar2MrWyJLe04AOd
         aT1VxvYd6y7Q1hNdKfI7LYk/cWs/F+hgLC++KpbNUfFkS7797mVj2XtGH0FvFbGu2J6r
         BHkic0KgQoF3UEEEuhFMyCsxKsRsuX7K7Y7ghNMdA260bAagUF0b1B7znZpQAYf2Iij0
         JKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285812;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAN9+ZOptTrJHDc9J/pvGJu6tT88Otl4KlrOdjgdjxk=;
        b=ZL/aAjHlJJfDLOu4UE1c+r5C56UvHdXohwcf1RoHxhVToLTN/q3BtAEuscy8psfzRj
         fK0vdbCzEB25hLYdjLNle9T8bSUPpa/7oq6//SNabnTQEBlnayyOya5OCwUKCcw5LnT2
         Wjto6FZC6zNn9foe4RDekn67y5cpzbghk6u4+scN1vjBgtDLbITpLNtka9TLZutsL2qv
         63M+BYwDyYxwf6zco1MLAN2DEVW0eh5bji5KOb+AIzjeQS909QwOPoi/kzbl9rCqTaV/
         1n/4dR1hChSEiak5cIUkTalhKgvAOwCGIjYwc7dpqlAEUMvsgnSIGbQA9RLOzuP7hHlT
         gADw==
X-Gm-Message-State: AO0yUKUOdz2grhsSydcJIZRjeMbL5X4Bs86Hlr5eVkQpKQBHImkwnXzH
        vD86mDqnKpBvQkkiL8T7K+lZGxdLCvF/NA==
X-Google-Smtp-Source: AK7set8JUDC6Op30t1qpJ524iWF7urf8TzvMEmLBYMe7KUjZDDwSBVZ/x3DhwnQ7CK28oP7ZxktvzQ==
X-Received: by 2002:a17:906:a882:b0:8aa:a802:adcd with SMTP id ha2-20020a170906a88200b008aaa802adcdmr16525524ejb.30.1678285812312;
        Wed, 08 Mar 2023 06:30:12 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id o22-20020a509b16000000b004c4eed3fe20sm8289678edi.5.2023.03.08.06.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:30:12 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        John Johansen <john@apparmor.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair a malformed T: entry in APPARMOR SECURITY MODULE
Date:   Wed,  8 Mar 2023 15:30:09 +0100
Message-Id: <20230308143009.4039-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
or topgit) and location.

Add the SCM tree type to the T: entry.

Fixes: 7b4bd1274d35 ("apparmor: Update MAINTAINERS file with the lastest information")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c293074040b..2091b15ae695 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1490,7 +1490,7 @@ W:	apparmor.net
 B:	https://gitlab.com/apparmor/apparmor-kernel
 C:	irc://irc.oftc.net/apparmor
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
-T:	https://gitlab.com/apparmor/apparmor-kernel.git
+T:	git https://gitlab.com/apparmor/apparmor-kernel.git
 F:	Documentation/admin-guide/LSM/apparmor.rst
 F:	security/apparmor/
 
-- 
2.17.1

