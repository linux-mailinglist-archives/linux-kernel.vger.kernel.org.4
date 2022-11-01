Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7DD615388
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKAUwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiKAUwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:52:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C2418B34;
        Tue,  1 Nov 2022 13:52:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n39-20020a05600c3ba700b003cf71011cddso1355801wms.1;
        Tue, 01 Nov 2022 13:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcZrSM0NMDEUGkRu1zNxv5heHBVcDpwHzAaIVD3JgIk=;
        b=ZS3GLTdZqJ53CpP+xPle8E1+BSh/wmgbOKPfFiRRm6QVT3RHkrzF8Dtkz+nR+SsOQN
         IrVsiL7Aqf4FOb12Ne7xjiSN0NWtxGj3TaIP3MZktbdcA3XpB1qj3RQBq4SJjInTcGQK
         M7ZjT4qBlpNEUq693Uhx+uhhwek7ODLtM8N4OThyZJFF+slhZBi5xRt3N68EFk5P6pcI
         aPPDGMmNS4joo6fPiWOKW80ElZvZ59vqAJptJRy79sKhUGx+eB9mzwzucRG0UBU2Rs+d
         a4lEg6LZcC7PXVGki45XLylwsoNjsUltJ2D8eFx1KnNneakddUWdNcU1O1CUN/hLtao3
         vzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcZrSM0NMDEUGkRu1zNxv5heHBVcDpwHzAaIVD3JgIk=;
        b=YdpQCyRF6X1OhL1fKc27cxfBk4CGgiKSp97NsBXa258r9Sm9CrY8klRYhZZeqBpwBn
         bCyOGn2//QKZgK+96OxbUz/ClMYK8+jFXSVAsmkFHzP/3WzJCYJL40wITeOUdqHBCdO9
         T3EIMVT43qNT68aJLQGUW04HSwTA7icCzD6L50LMqdQCRJ7shBaUjxJv/tIl2MDyu0Do
         uYTim9bLuLQiu5jaTvnwIbdmnqHF462AA3KeqBEATaycCi40HZP0od5qJsvEJDZR+08G
         DdzmeSJMuawluDzXZGiWpVZTtRj2RQSGzC8dq3EbAgFIlSBI8WvdLfaVMYNNrLlTFT1T
         MaGA==
X-Gm-Message-State: ACrzQf14bPTbcV+eetzIiJYvYdOiA9v4X2eghqo/blQqB+uydTt0OWEB
        gKevTd4qDDT2fpuTUX/nlcY=
X-Google-Smtp-Source: AMsMyM6gk8mDOEiGyHIxhwlExnrHZFmtZtZ7p7Q4ccWgyzAeOaB/W8T7TR4QdHIbV5SfLLliCpzPsQ==
X-Received: by 2002:a05:600c:4d08:b0:3cf:674a:d3c2 with SMTP id u8-20020a05600c4d0800b003cf674ad3c2mr12728240wmp.157.1667335962502;
        Tue, 01 Nov 2022 13:52:42 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id jb1-20020a05600c54e100b003c6b874a0dfsm11854413wmb.14.2022.11.01.13.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:52:42 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs/pinctrl: fix runtime pinmuxing example
Date:   Tue,  1 Nov 2022 23:51:59 +0300
Message-Id: <20221101205159.1468069-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221101205159.1468069-1-lis8215@gmail.com>
References: <20221101205159.1468069-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example declares "struct pinctrl *p" but refers to
"foo->p" which isn't declared in the context of the example.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/driver-api/pin-control.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 19a41c68d..0022e930e 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -1399,11 +1399,11 @@ on the pins defined by group B::
 		if (IS_ERR(p))
 			...
 
-		s1 = pinctrl_lookup_state(foo->p, "pos-A");
+		s1 = pinctrl_lookup_state(p, "pos-A");
 		if (IS_ERR(s1))
 			...
 
-		s2 = pinctrl_lookup_state(foo->p, "pos-B");
+		s2 = pinctrl_lookup_state(p, "pos-B");
 		if (IS_ERR(s2))
 			...
 	}
-- 
2.36.1

