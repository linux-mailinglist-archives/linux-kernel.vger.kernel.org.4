Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718E6831EC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjAaPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjAaPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:55:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BAD3402B;
        Tue, 31 Jan 2023 07:55:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so14690695wrv.0;
        Tue, 31 Jan 2023 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZO3OXoklLdjvq1ElI0EhzGrI2GyGBeJ7SHRlnQtpNk=;
        b=DN2ilcPcEGj1u9H9FXqp6nulPpgvCZxOHQnTbrDwur8O5FM9ON/+7CizpyATxu5BRz
         D4H7cpf0mbE6+DL/2V+ubMcbq+ByztUUWF42aswATqm4HQ2rMwGes79HzqTkwe2ApvFE
         NEdc4aE6HqHFtoxvtQMcwQDqWJ4PzjPbM18kz6KFltSmhhorDEe7FBvRRSCrGyh2xOeA
         VBkitRRbxh/RzNGvalSJL01BaYEykQyIc+sA23zZ0XSBQg2VC+tf3Bsp+uHrnAmlsQhm
         LHVTqX95/l6sMRWiNjB96NTyAUp4YEqeHqJ0SfDv9Ov21WL760YdjzIrUaYqySXnk1h1
         wPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZO3OXoklLdjvq1ElI0EhzGrI2GyGBeJ7SHRlnQtpNk=;
        b=yjOC34y/8MCkyf2jbWo1/Pl6VLe0ZOcJvk8IVUEWUiml7zOfwFB8JFpS7tGcKuLnf9
         cK425gEEURkbh5MmAEAaV433TlVKk5vc1yTTmFfp7rIc6LRQ8hQ+4xblLkpQ0KqeytJO
         Xawb89HFioWelCj9yknyDddsJ11rt383qRqacFuvNcFDXCzbvhhY8xRNmWwGoB6qBwf9
         1yVRHFNY0OuMnxpyoDtivMa8H0OjUAZypCUbdQtuYgBeHgIBmd2ySV+Gqotut01484Me
         m5qntFcD1Jaw+EWtut8YBleJ2+sMv+hnNtPn5EorQ2Dslhf+c0T5fVMZLvmcX6qA23qG
         lsyQ==
X-Gm-Message-State: AO0yUKWtKRNME7glD4+Kw+8mY0ROxWaNm1S4yfrJquulP3sKdPayJYQx
        Flgp9I8dLAi322qa1vkVagEf52auVxw=
X-Google-Smtp-Source: AK7set/u3WxPaikwkA8y3DKENc0uI1hUprGHYaSwKCccfUZwSJv65dyMoqkB0I3I/MeM/y0DniS+kg==
X-Received: by 2002:adf:ef12:0:b0:2bf:c364:47b3 with SMTP id e18-20020adfef12000000b002bfc36447b3mr18137390wro.26.1675180540252;
        Tue, 31 Jan 2023 07:55:40 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w10-20020adfcd0a000000b002bff7caa1c2sm4106908wrm.0.2023.01.31.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:55:31 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH] MAINTAINERS: Update OpenRISC mailing list
Date:   Wed,  1 Feb 2023 00:55:24 +0900
Message-Id: <20230131155524.2700453-1-shorne@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailing list at librecores.org is being shut down due to
infrastructure issues.  Update the the newly created list on
vger.kernel.org.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..6037a1131ccd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15658,7 +15658,7 @@ OPENRISC ARCHITECTURE
 M:	Jonas Bonn <jonas@southpole.se>
 M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 M:	Stafford Horne <shorne@gmail.com>
-L:	openrisc@lists.librecores.org
+L:	linux-openrisc@vger.kernel.org
 S:	Maintained
 W:	http://openrisc.io
 T:	git https://github.com/openrisc/linux.git
-- 
2.37.1

