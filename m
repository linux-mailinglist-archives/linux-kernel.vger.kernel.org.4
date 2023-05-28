Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5303713A66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjE1Plm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1Pll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 11:41:41 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4304DB2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:41:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af7d6f6f41so978645a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1685288497; x=1687880497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bl3YC+K9pIicljZpxp1Y9H/zXA7QbseGMJCLEGLLPms=;
        b=G6VwHZXyhqUKcjpZHqgLQ6OGjEgSL2ZxYcpOgWYUeE/5rdXN5tSaliymhBAIDmGFsE
         HXtG5Kf3HOtaDa6af5FhSmnOKB3tr5mR26ACJBHzt1RDDBxgN6BVM4Ps7p3L7WAx9HRV
         zC+BTEOMw+sREefuTDkUMi1UCHBS7yYxClYWPo6dZzGr0iskbjn7zi5qHxZJXTdGFIcK
         tSMHBN4VU5mAAZhUd6kKx25V9Yp9LIsmfom1CRtk0hKZMJqr0A0H7Y52/6fIyWSIVtp2
         oHAMEUQUqzWOZb5w7eJilh6hKZUDoBzjK8w76UtaRwVpxKhs0C5fVX8CS2Xa0o84V6kP
         sMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685288497; x=1687880497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bl3YC+K9pIicljZpxp1Y9H/zXA7QbseGMJCLEGLLPms=;
        b=gCwKuhuUCt/lafi55ED3zB/w6aOUsLYA150oYnLK/pcE2FBpzENc+yeQZNj8sVv2Fw
         XXguxGnNeFHyzUj/GmoNKFOeX3a41oryEnFQ3A5e+1XXdKAjJSsvTkjdGJkYkL8X4ZZ4
         dWJPOcfLgA9fFmjNZrfaLdpEGhGOs0KjF6rul4Nj/h1o9RjwG/2OKp5Z6wXF89HKEn53
         6TPZ1Lxoqw8CXofeYIhnXIW5J8elbC0ruHRobocHn/yp5X4PU0w8Gny9LlIQJMVFSGQL
         K6DN28aNNMbxoys+6/6n7UWVIGLVKYccsHH/31++OclDyW4umbKgOzQPfiMCZFslGgZh
         IMbA==
X-Gm-Message-State: AC+VfDzOnwSpIi0gzXxuq03jgJ+yfyUoLsmVbr7AnoGU8rYNrlFMfLBP
        e+iGwji68C59rajwoEOcPLc/MQ==
X-Google-Smtp-Source: ACHHUZ56kjmLqsnFwcc/Efx5bHTV5PHh0c4CwKqBQbZ42GFL754umFy15oY1e530KY3sJ7ns1gENaA==
X-Received: by 2002:a05:6830:1611:b0:6af:e87e:aa5e with SMTP id g17-20020a056830161100b006afe87eaa5emr3784121otr.12.1685288497627;
        Sun, 28 May 2023 08:41:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:63:8ae3:4d1f:9fc2:9fe6:c88e])
        by smtp.gmail.com with ESMTPSA id m9-20020a9d7ac9000000b006a64043ed69sm3659217otn.56.2023.05.28.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 08:41:37 -0700 (PDT)
From:   David Tadokoro <davidbtadokoro@usp.br>
To:     gregkh@linuxfoundation.org
Cc:     David Tadokoro <davidbtadokoro@usp.br>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: clean unnecessary braces warning on r8192E_phy.c
Date:   Sun, 28 May 2023 12:40:10 -0300
Message-Id: <20230528154010.3068-1-davidbtadokoro@usp.br>
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

Clean a checkpatch.pl warning of type "braces {} are not necessary for
single statement blocks" on r8192E_phy.c file.

Signed-off-by: David Tadokoro <davidbtadokoro@usp.br>
---
V1 -> V2: Revise commit message

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

