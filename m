Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3D717A00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjEaIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjEaIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:24:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C5F125;
        Wed, 31 May 2023 01:24:55 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6042d610fso56023425e9.1;
        Wed, 31 May 2023 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685521493; x=1688113493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utJCKiNlXUA/gWjsI7HdQdSp3MeurH44qM3nLVX+hY0=;
        b=PTlfQP7IUZsTEtaz0c4g9Detm2V9gbJYhJZ5z2ZLjvonIOD4NKdqwV0eFaKZTTpjoc
         23irp+luD2uadA6RYWrq5c/5oiEYYjTOGrvxcn42XwKilBLJtWu1Jwzvu/5xgGfNT70b
         GRrVFZB+JHbIEzvv8UcMDWBthQbdM6tM+jbATX+2l8MeelqYZ6kbbKVN48UdNjLo2tgL
         Fxp7+nLezAI/1Z2GXD0TQSPTbFY1gdK8fj9l/D5IsiCvGCgbudCEOL5SUNP8hBTYSDVv
         iFLS11D9bgkNq43ZGlr1pzu6j4UsmThsZxfqPHedLRVrNmdGlHv+/pyDKu02TFAxerbx
         qMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521493; x=1688113493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utJCKiNlXUA/gWjsI7HdQdSp3MeurH44qM3nLVX+hY0=;
        b=Hh91b6hEtPAi3Yq4Y7Ayqa3cj6Veu36ZdhsdsfDhDQNugBD1FbPTjhRatXDvx85+l6
         iRu0ALfpEnj5ZkyAvn/3eqBl2hVgqtsdCsrnXiKcVhtY8JCJ+cj/Vxmjb3bxyTxLtFkP
         kSLO1d1mRSFUU60ytWmGYKS1yowv00fnoOK/WsObT129J5UXBylnIi9RvmF6ShX8/K2L
         kM1/XHacdmNUbE5cZgrZ/S1LxV0bEGySw/8ZhshOOSnqubwW3KNzZf/jsW65T1fs8Mdh
         987qX7xCVIDa5+h/8hV6+ko6fdBjDUar6dNpwTmWnWoNTwbStCEKOEMzUz+nxAZ5+skv
         042g==
X-Gm-Message-State: AC+VfDy2hKhgIpz/fAq04JQxs/UawcJYyNvghfA5ZRN2V3PaqvJu7mXI
        UCXtTbDYOcAY4mlugKIOGBw=
X-Google-Smtp-Source: ACHHUZ7PUGs/Uxa9l4rdaQUYMezCcHdiXfd4HHyQE3BDwd2sPC8GwvnkmOIS6dLbMlTZ3BvhJ08UfQ==
X-Received: by 2002:a05:6000:90d:b0:309:fcbe:748a with SMTP id cw13-20020a056000090d00b00309fcbe748amr3540491wrb.11.1685521493253;
        Wed, 31 May 2023 01:24:53 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b0030abe7c36b1sm5824554wrw.93.2023.05.31.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:24:52 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: musb: tusb6010: Fix spelling mistake "respones" -> "response"
Date:   Wed, 31 May 2023 09:24:51 +0100
Message-Id: <20230531082451.1572058-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/musb/tusb6010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index cbc707fe570f..6ab081c1b5eb 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1046,7 +1046,7 @@ static int tusb_musb_start(struct musb *musb)
 		i--;
 	}
 	if (!i) {
-		pr_err("tusb: Powerup respones failed\n");
+		pr_err("tusb: Powerup response failed\n");
 		return -ENODEV;
 	}
 
-- 
2.30.2

