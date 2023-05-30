Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A9715940
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjE3I7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjE3I7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:59:03 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A1BB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:59:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso7334299a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685437141; x=1688029141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QM+ARZdj9TwbVnGrYRA/jsJR3+Zgqtvr1mDQqqUsgpI=;
        b=O3n9IJuW2zZ+Lq9dYaDFvisN7rT+PJ9z7tB3RHRpuHIOObXzDD6iMjAALUU/nXF14d
         KB4XRqCFvQdG1vgcCp1e3mW725NNbhN7RGPFA+a7HPA+vwPswdq1UB/f7ym/db5d8QN1
         hTVWO+SXJeQgNmFoOHNhESy0rc+GkK7iW04OQ+6XV1S4q5bxE9EGAA1lXrxi/3yYLgz2
         rJscPNOKQe/j65iH7llmiwWhWS6y/LzD9SRkwAQ9gDkRxFVRmR8BK+PHRz91rR/eR7el
         6xBsss+7R9LgNqs1p7+Akrtc5TAMYRpN2m4nqp0Pq8IA0byAZLordBRtCQSSsmtXNaAr
         Rbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685437141; x=1688029141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM+ARZdj9TwbVnGrYRA/jsJR3+Zgqtvr1mDQqqUsgpI=;
        b=AmrT/xk/Q+JMpnPmpbBXazKF97BH6onhF5mngUDaMFNTUhpth0DfIUmD909LPFmPtE
         sQmyZOl/9F1EwUqxzqlFLShgQqDkEKGovAeRe/MgD+qzkDuSLxs13k84LpBKWTFgq4ct
         q+8FlLTTAefT8gB80IMDoS9frqe0tkKJQNPGaP0KzWvxGPgTApGC+3C/P2SONpAQKEi+
         4TgnpvhrRqjpk1u8cOyzHBiax9++Ibii+Lg5ZRtFB0UMDnh6jLteTLa9BTYCYkrtj4Cs
         9VYY5/gMR/SfZDkOtHJPl9jrqAr3MYKe/USDqC2vYRktk4hCLKpk6i/8lqQBTw/YRfMr
         ZHDQ==
X-Gm-Message-State: AC+VfDx7/PiZTlkI/4//Cq6nCZKwmm5/Q0A9QNJ/0ZVRQcpaQFsFOa9p
        tvh41OwauOcxVyQX2uMwXil/E18yFJwEMA==
X-Google-Smtp-Source: ACHHUZ6znQTeQGLWvoBOh0psBSmeFWANVylAIJzmcUmcuSJVWgbCIalI0Bn/OhuwGWTnUxeXXUQdFA==
X-Received: by 2002:a17:907:9723:b0:970:553:272c with SMTP id jg35-20020a170907972300b009700553272cmr1731009ejc.27.1685437140477;
        Tue, 30 May 2023 01:59:00 -0700 (PDT)
Received: from varodek-thinkpad-x1.cern.ch ([2001:1458:204:1::101:b2a1])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090671d000b0096a27dbb5b2sm7010137ejk.209.2023.05.30.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:58:59 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net
Subject: [PATCH] MAINTAINERS: Vaibhav Gupta is the new ipack maintainer
Date:   Tue, 30 May 2023 10:57:52 +0200
Message-Id: <20230526100718.35531-1-siglesias@igalia.com>
X-Mailer: git-send-email 2.40.1
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Samuel Iglesias Gonsálvez" <siglesias@igalia.com>

I have no longer access to the HW, nor time to properly maintain it.

Adding Vaibhav as maintainer as he currently has access to the HW, he
is working at CERN (user of these drivers) and he is maintaining them
internally there.

Signed-off-by: Samuel Iglesias Gonsálvez <siglesias@igalia.com>
Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 207a65905f5e..49e384399ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10106,7 +10106,7 @@ S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
 INDUSTRY PACK SUBSYSTEM (IPACK)
-M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
+M:	Vaibhav Gupta <vaibhavgupta40@gmail.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	industrypack-devel@lists.sourceforge.net
-- 
2.34.1

