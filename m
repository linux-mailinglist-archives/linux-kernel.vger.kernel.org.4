Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E631E6C7E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCXMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:36:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEF12BD3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:36:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so1690823plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679661387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soyyhMJpHSwpmm00qRiMD1A/7d0CYEqtBraKK8RFVKg=;
        b=ZO+6cgGPZXgvXHZ3/rNpn6FbnUMOVdioaOu7glDSFyaFQlNscsPq31asjnK/spmTpd
         hnVunNfmU7+kpcQoANHLUT1rWi56j8zFWhHJwMrVW+/yjJT1agro+vbTpYn2x7c/50v1
         O/xy5V/P74vctoq9sQYXrx1HRqb+Ek89pQUrBXODpfQSuM9MhxIP1ejRMuaGyLD2EI51
         W6XkqgnzRsVpSXkCY7EgTg1KB+P0RNEo7HIVNqxAJ9SCzinC6NRi08yzFcrcJ9Gpn0Ev
         HYBMxaK9EbD+C84zW/sj+evuD4iFEl2HmnIx6Zj4S8oeD2+ztBp2PFkjbosWaqD8PHUd
         40WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soyyhMJpHSwpmm00qRiMD1A/7d0CYEqtBraKK8RFVKg=;
        b=vmlAJ7fJSnrIPP9xmbp/7IBcswn9aeZD9wBwSSpayKXeTxBL644bkLORSCi0CRB33a
         2ltKj0T9SmKQkoMMWanLqPlIq2caEFZGRKI+QxUVDOJz2AIjHvWJL2YLJ03eLc0F18C2
         Nnf7IgUKzP0X2dEwRPluQrnlrvK0Am2lLzlWCXJsrBLPKM9Ah+Ws2p/9YV+StVwzipLY
         o2FCVO1LDXT0ubzYsamCAKR6IxuU4MlmOysir9flYvEc+6XqgvxTRu/mqtAcgvQwtDH7
         KTi+dJJ+BomH2jXHBLtEVZO+cKT6sEYm/rdzXid5mCJMqlJPsqn6mj6c3MYARE3vm/xw
         S/JQ==
X-Gm-Message-State: AAQBX9fFKyy8UFtSSa2Z8iUb3hOQFRL4UmLk+1wOj2ky+7v9D/Zah/Nh
        TMQZfAbFKE74WzsdLy01QExPCNlDXdQ=
X-Google-Smtp-Source: AKy350bAJBcNGT3yUU0VR9TzOykx8+t0PVg8xxK27+Y5NRJCFKHispDwVDYnx4xI6x0qh7j7pETa2w==
X-Received: by 2002:a17:902:e5d1:b0:19e:4bc3:b1ef with SMTP id u17-20020a170902e5d100b0019e4bc3b1efmr2971924plf.64.1679661387483;
        Fri, 24 Mar 2023 05:36:27 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:7090:3b84:325b:cb07])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902b18e00b001a1ccb37847sm9945959plr.146.2023.03.24.05.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:36:26 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] MAINTAINERS: xtensa: drop linux-xtensa@linux-xtensa.org mailing list
Date:   Fri, 24 Mar 2023 05:36:12 -0700
Message-Id: <20230324123612.2769310-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-xtensa@linux-xtensa.org mailing list has been bouncing emails
for a few months now. Drop it from the xtensa entries in the MAINTAINERS
file.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec57c42ed544..b915c364bcad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20647,7 +20647,6 @@ F:	sound/soc/codecs/tscs*.h
 TENSILICA XTENSA PORT (xtensa)
 M:	Chris Zankel <chris@zankel.net>
 M:	Max Filippov <jcmvbkbc@gmail.com>
-L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
 T:	git https://github.com/jcmvbkbc/linux-xtensa.git
 F:	arch/xtensa/
@@ -23039,7 +23038,6 @@ F:	drivers/gpio/gpio-xra1403.c
 
 XTENSA XTFPGA PLATFORM SUPPORT
 M:	Max Filippov <jcmvbkbc@gmail.com>
-L:	linux-xtensa@linux-xtensa.org
 S:	Maintained
 F:	drivers/spi/spi-xtensa-xtfpga.c
 F:	sound/soc/xtensa/xtfpga-i2s.c
-- 
2.30.2

