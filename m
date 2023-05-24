Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720B70EC56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbjEXECM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239304AbjEXEBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:01:40 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED421726
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:01:15 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3909756b8b1so229364b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1684900871; x=1687492871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56NnY1XWFQglCZDR+mXGOsAUP2AtRPFO/hDy6QbeiT0=;
        b=pX6jYKKyXPNBmGORsYEu7PRQVhYNbdpl1YaYjBy/aeSgqr0CzpvTG/pfdpAues51RH
         0snUZpxxCA4USH4auk+FePnrAq1BC2hEhDUmsbzA5l28EFYqyvK3RENGsepZSOsmUDYT
         V5QoAO6owrK/vZvYZb6h4OL1clq6NnVyRv+90PFBRdV3sOW9Fi8Ajm71UuL7T+WU0yf8
         NvN25SnWmy3T8uNCYQUy5eYaZAcZrP2Hq6cJxVQ3UitlWika8inZmZdsGojsdHnJ1m/Q
         688NicqabaUMCX1uE7zknvKqXYv+ozrkD4jM8CKxPUgVYLNdIUEcfzbPOjKC1mLbkcAv
         /3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684900871; x=1687492871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56NnY1XWFQglCZDR+mXGOsAUP2AtRPFO/hDy6QbeiT0=;
        b=HzoehCRO2PUfQH70XhsMFJ+fN0KD8oJ/JzeEWQod85P8GF7uiVQhDpKkn/9xnsmrL7
         J4mGJWjU1NFFP/MM+1++UkIMnu03TaOhzlri+6AJIcR9Ye/Ovg88zc3TT0jNXd7K16lb
         hZBkALGNsny0fSUC3+pt1aXL9tEIqmG2YASm//PMhswmi4Pv5hfbDUArBJq0r4JdGJK9
         Odc1UKX6iUxB77DXAmHIXcuhOPelmk+MGq/ZzlIB1Wv0c7vr5KKHXa9qfg1jNvuZk/zR
         WIpcMyPqut/iwbnf5kSOthyhqwMyjqNl6X6wp4+vpSfD0bVandayznuj9q9QK6p3zvrl
         fMGg==
X-Gm-Message-State: AC+VfDxrQhY1BQlKE4zvRHkhmy8j8cp5HQk8ophaR1SZhyTg4OlGrjFc
        0qB+LAVJ8aQk+JZYi5J2z6kzfA==
X-Google-Smtp-Source: ACHHUZ6iqjajerA//gB/3ydUlqEaddMg7Ge5NDXXlR+0Fb5i3qEO6Pv4DvSWlDTFTB411LY9dai80Q==
X-Received: by 2002:a05:6808:6d0:b0:398:4385:baf4 with SMTP id m16-20020a05680806d000b003984385baf4mr1244105oih.49.1684900871125;
        Tue, 23 May 2023 21:01:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:63:8ae3:4d1f:9fc2:9fe6:c88e])
        by smtp.gmail.com with ESMTPSA id v203-20020acaded4000000b0038ee0c3b38esm4761418oig.44.2023.05.23.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 21:01:10 -0700 (PDT)
From:   David Tadokoro <davidbtadokoro@usp.br>
To:     gregkh@linuxfoundation.org
Cc:     David Tadokoro <davidbtadokoro@usp.br>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix BRACES warning
Date:   Wed, 24 May 2023 01:00:51 -0300
Message-Id: <20230524040051.235250-1-davidbtadokoro@usp.br>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning "braces {} are not necessary for single statement
blocks".

Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 4b0ebe96302e..ea993cbb7bf7 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1099,9 +1099,8 @@ static bool _rtl92e_set_rf_power_state(struct net_device *dev,
 		break;
 	}
 
-	if (bResult) {
+	if (bResult)
 		priv->rtllib->rf_power_state = rf_power_state;
-	}
 
 	priv->set_rf_pwr_state_in_progress = false;
 	return bResult;
-- 
2.40.1

