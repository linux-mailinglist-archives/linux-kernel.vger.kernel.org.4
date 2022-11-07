Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A57D61F688
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKGOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiKGOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:48:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815FD1581D;
        Mon,  7 Nov 2022 06:48:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z14so16575551wrn.7;
        Mon, 07 Nov 2022 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1N3AZluJC5PMpvDgMOhDOY9j2qE8n3HGiZz4zfJ5qE=;
        b=Rkma8QkCBGz3zCp7ddqCDHMuRgU+2izMkr6rzs57tin6XmNxRbMNYFmppsEOzu3wC2
         hNmOzbRFJE+74isWC8SSJm7e2W//5OXwaD5IZp6A80s+S2134FKGJMc1T7caEhBPYP5w
         7ODJYi3CQclJS72auvHJd6ht/V6ADz7jr1t9FL5VIocQO/UsL71DL9GmAFrc+eQUE2+O
         D0rqz+TcfQVdd5x4LTIdEMp1GkUeZH0Ngi+uhZmZNrw8jszu3bRqG18DtubxS2SjrwCa
         I3iJbFsxOfOH9aauVXOPlJDmwRWMZGRG/hiFsjVGtIR+1TChqqjGiUqHgw6BjOjpMGgk
         Rhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1N3AZluJC5PMpvDgMOhDOY9j2qE8n3HGiZz4zfJ5qE=;
        b=Y5ILIWttf4c9U058Mca3LTdbGS8DCy9plRqTP/L9nPf0NDkU3VKGKckBAmoRh8Okzs
         kBTwQ1puRIWlrJ9Ists12gKis9bwR4+wuAip3liZoggF4vyqZ+qpu0mtpGz8bn9kplqU
         y0cdA/kJlnKQfaJQ+XyC8WOBMWWGrrpE+3T+wk3PKDuEj2J8YjIgS9sXakEIplixeo+E
         I3nmI3rrw8PwuAmKNbhzRUOy2NuFu0nD+jUxpKAYv3cpXlao0DnUva+SE/LgpJ3UVfiD
         P7HrXZ1too4Q8iL6lTa9OBlVng+hy8sH/ltz0GvNH+153PW3N7TghxjPNRzP7r1+qEzw
         s50A==
X-Gm-Message-State: ACrzQf3ycsBwCc7iftKn+ob1lV5vBTUY93kgLgeuJWB6jbDEAi3QoXnN
        n+LT5AN4KSHvNCx0vxUny8w=
X-Google-Smtp-Source: AMsMyM5csMmCF4sPQjKZxYDdIAvNi0HAaSVzsB8zbHm1KYlUHCevLnyCUiLlWhfuEGTYLQivB1eXpQ==
X-Received: by 2002:a5d:5e84:0:b0:236:cdb8:c67f with SMTP id ck4-20020a5d5e84000000b00236cdb8c67fmr25941828wrb.159.1667832514985;
        Mon, 07 Nov 2022 06:48:34 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003c6c3fb3cf6sm8418820wml.18.2022.11.07.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:48:34 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] extcon: usbc-tusb320: Call the Type-C IRQ handler only if a port is registered
Date:   Mon,  7 Nov 2022 17:48:10 +0300
Message-Id: <20221107144810.588755-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.1
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Commit bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
added an optional Type-C interface to the driver but missed to check
if it is in use when calling the IRQ handler. This causes an oops on
devices currently using the old extcon interface. Check if a Type-C
port is registered before calling the Type-C IRQ handler.

Fixes: bf7571c00dca ("extcon: usbc-tusb320: Add USB TYPE-C support")
Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/extcon/extcon-usbc-tusb320.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
index 41041ff0fadb..037bc11b2a48 100644
--- a/drivers/extcon/extcon-usbc-tusb320.c
+++ b/drivers/extcon/extcon-usbc-tusb320.c
@@ -327,7 +327,14 @@ static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	tusb320_extcon_irq_handler(priv, reg);
-	tusb320_typec_irq_handler(priv, reg);
+
+	/*
+	 * Type-C support is optional for backward compatibility.
+	 * Only call the Type-C handler if a port had been registered
+	 * previously.
+	 */
+	if (priv->port)
+		tusb320_typec_irq_handler(priv, reg);
 
 	regmap_write(priv->regmap, TUSB320_REG9, reg);
 
-- 
2.38.1

