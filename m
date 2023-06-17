Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E3734186
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjFQN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbjFQN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:57:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F96295E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so434960a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010233; x=1689602233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n97eu40lLD5raDHeMPetald7UVarkQD2e/uUhF7bu8w=;
        b=jJhZIW2w9dd6qxCPFexKLtSZrWzRWdkzy4CE5/xSqnc5hhN+bVOwF3/+Yt/jZBaRZc
         UgQA8N4Y0ne6z0Dj/KjiYRPA1MlSyZefDaVSnxbLsmtKRvBmJU7K5YiiE0dimWtrECOi
         V+T6EtOvWHNLVuYpKuz+5uRV23LCfZjor0OgYzfjoaFFCKBANEHfR81LrAWkR51YTySc
         XuvPJljf+hTvl5IluRvR48W6naJkHvdqzF1zF6HZHZEF7SfzEjc0/1cLaJBjiq2m31bP
         adRv3KSTH1eTGcpbXDHSyRNwS8/9wcaASzQrPPdKlJ+FpEv06JAuupF+gojg40OwP9r3
         LCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010233; x=1689602233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n97eu40lLD5raDHeMPetald7UVarkQD2e/uUhF7bu8w=;
        b=XISbN/Dkei4M93jK44Y+M3DMTVbFaB1GEFHYZ/2cHgmjlvzq6vcr7QHeaGxLMs8/Tr
         fwORLMPL2j9ttjJJgXNjNiuHT9A/OAB+hvkP3hGSPuuXTJIrD21bDIkZCYwy0f/jOzoj
         +YRdOI0RbuNTVadlNhx+uZy83laIRKlz8IaBRPOnEd1T9kxnHq/030G5uIgJUJ6Uy7oU
         xFMp96w4OOLxMvWbYe0REtgDD0YBeCQZQZwDTAB7ZKQNhmbsXk0IKPbbJq4VO0CQYkd/
         Ft/IX2kDmC6PjvXiwJLlcueMVCVpDZyFHYS7CfxUo1a/g1PHhca0m01p910euZAL9pnh
         Rr+A==
X-Gm-Message-State: AC+VfDx0zIxJ3gleT2IT5+h3VECy4ch0sOJmrJAcg2KNQIvdToqZd9IM
        3nUDNS4rTPEexP+mwNyGQ2Y=
X-Google-Smtp-Source: ACHHUZ51QYtle5vgneRhqcr45ejHRlOFJUQ13ZMfe927Im7i+hYhIBOvVx5Tj1BSf7vAFfOEPEEgCg==
X-Received: by 2002:a05:6402:4312:b0:50b:c57f:d464 with SMTP id m18-20020a056402431200b0050bc57fd464mr4147455edc.1.1687010232769;
        Sat, 17 Jun 2023 06:57:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id p26-20020a056402075a00b00515c8024cb9sm195856edy.55.2023.06.17.06.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:57:12 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:57:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: rtl8192e: Rename rtllib_state to rtl_link_state
Message-ID: <f21541c16c83356e3cd1e08059847ef9a9eb2ef8.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename rtllib_state to rtl_link_state to align with rtlwifi driver and to
increase readability as state is to general.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 2ebacd6720f1..1aabbe11b484 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1119,7 +1119,7 @@ struct rtllib_network {
 	struct list_head list;
 };
 
-enum rtllib_state {
+enum rtl_link_state {
 	/* the card is not linked at all */
 	RTLLIB_NOLINK = 0,
 
@@ -1489,7 +1489,7 @@ struct rtllib_device {
 	 */
 	struct rtllib_network current_network;
 
-	enum rtllib_state state;
+	enum rtl_link_state state;
 
 	int short_slot;
 	int mode;       /* A, B, G */
-- 
2.40.1

