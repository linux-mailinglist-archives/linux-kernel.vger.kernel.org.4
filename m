Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0756B0C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCHPHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjCHPGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:06:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09473BCFE3;
        Wed,  8 Mar 2023 07:06:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so63304587edb.11;
        Wed, 08 Mar 2023 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678287991;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGwSSBiuYrO44oxKM/UeXdd9+wzu8I3tozxPCbkUE+c=;
        b=MGyby3tMiKc3nMQZRk1C5uDTxfxSv/oZWpdf7CFvXeIQUUK/SzpxkdPQa0+a/aoY4j
         38s5BxcJzekRfVFbWiHSEJ/EF3HvWp/CsIYxUjrnuKhOATBZWPgvRra0JMPFmInqaT/m
         9LT2qkbncQWmOYka8ZR9Zu0HLqM7h/2Mm1cF+MY1j27mdng32K4hXX+sTEotWaUp22eS
         /HKZH6GzKj/7S22ddpoJeiIN/bZYwZvz4ycLk9+Z4w+kTz6Wj7axtOlSFk6io4ERVZ2J
         YWgKaiwMvvcB1SHsVj0WpEYIuWMS8XOM1IGsITXnVaXDs4w+GsTPUmiksaZ5+XgWT2Pq
         9IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678287991;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGwSSBiuYrO44oxKM/UeXdd9+wzu8I3tozxPCbkUE+c=;
        b=L2js26B6YmBuLTSnEAsSjpaKBIHWFaPI2LSrtI++UM+17zc/E5B/6Vav0CeTy9AoNY
         R7Gu/zYN+N8VSNVJU5UhvHfVtNw30DKpMg3/cLSTNwDzmWVs9dssFQMdXljhMEvJ1G+X
         LnimpdxAmCuP5/35UnPJKYwBvLOWngaIgCLKgGAS4u0XLtD2Ez62hvp6EaKqpS+uOb+6
         M3JdkNfnTQFG/6UzknUUOabSAGX+Ezg+vKpDbxmoN6vENCnLTn6IuyKM3JBK7wQTJAZo
         J5qlOD23CMW304twH+3pYOy9+FbYxSnFMsAXg69FFfGg0nioHom4dVO/QmDHa97AiGGW
         qMWA==
X-Gm-Message-State: AO0yUKV7AxJGgV63sG5xiZM8Jh2mxpSR5R7bMn42SI1XqL55PY9EXzpU
        hNlONAMCsFTFWW0LGmaQWxI=
X-Google-Smtp-Source: AK7set+f7s6HeZilTNW4B7+qRpHv9TLRl9kJ1OjqiH5VHRyWcvQ7Uw7lBtdFh9i4WtBMrE1pLxA75w==
X-Received: by 2002:a17:907:787:b0:8b1:7de3:cfb0 with SMTP id xd7-20020a170907078700b008b17de3cfb0mr23399678ejb.2.1678287991489;
        Wed, 08 Mar 2023 07:06:31 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id l5-20020a170906078500b008e1509dde19sm7570341ejc.205.2023.03.08.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 07:06:31 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Olivia Mackall <olivia@selenic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        akpm@linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove the obsolete section EMBEDDED LINUX
Date:   Wed,  8 Mar 2023 16:06:25 +0100
Message-Id: <20230308150625.28732-1-lukas.bulwahn@gmail.com>
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

By now, many developers are working on Linux for embedded systems. There
is no need to point out single developers. The linux-embedded mailing list
has only little traffic, and most of it is just spam.

Remove this obsolete section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Andrew, please pick this minor clean-up patch.

 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 99adcd74b06a..8b9b4fc2dc71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7516,12 +7516,6 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/admin-guide/media/em28xx*
 F:	drivers/media/usb/em28xx/
 
-EMBEDDED LINUX
-M:	Olivia Mackall <olivia@selenic.com>
-M:	David Woodhouse <dwmw2@infradead.org>
-L:	linux-embedded@vger.kernel.org
-S:	Maintained
-
 EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
 M:	Adrian Hunter <adrian.hunter@intel.com>
 M:	Ritesh Harjani <riteshh@codeaurora.org>
-- 
2.17.1

