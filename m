Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C25700E19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbjELRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjELRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:48:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043351BE9;
        Fri, 12 May 2023 10:48:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64ab2a37812so6527327b3a.1;
        Fri, 12 May 2023 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683913715; x=1686505715;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SnTaxXK4qJhDjoS4L+yJ0RE8GhvCZI5pF9hJGADKq4=;
        b=IiirhhaU/MyovA405scgP2AiiVVoy+WVkS1WjsBl/cY76THJSnBe20rX2+I9j3YtxZ
         2GnWMZ4aehia9TaBItvm8ZPwxrVAA8wD+OKcY/WC+hwB0DqdHCb54cw2RNYXXhvci/dL
         bOkjeZkfOFZNjquQIorn2j9nKsFvq2jRPFT4BdN1uFHH/BuVfxdUWswGEBbkgm0tO/5e
         jaX8ijY54XnvDBesZtIjcG6w8OBQT1do/pENUJn4iP/fKtlGzOpNoE1hJn+UEZ/dz16p
         on/hgBCzlZx2c/kA7gkziNlAQV3WmBoVu+GqELBg5HsSbyQjd0uMDAzq2P/vvtktkdh9
         f4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683913715; x=1686505715;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SnTaxXK4qJhDjoS4L+yJ0RE8GhvCZI5pF9hJGADKq4=;
        b=eXLdZ2SYmjOhWp/VoGuduQTOVPal8POhM2lpXambcfHHkDbYcyzf/1Vb3PCuMXc7ni
         lOyYlAwYJ1krmo3Yy3cbo6gudYeg/+uEl0/Ag6Y7AVtPW5Xz5sBkCs5R757mRpx6yExL
         ymau1e44SxPlJqohn/aImEtxPTbnPnF16tZUusJJVpe5KMXuTvJVMMU6DxsBK3ITuuuh
         caXLr6QrFCwQBuSBeC7k0jj+3aTtuC5DK1Zd5CzzXSDZIdyZ9NR5nmP1PhV/LliIGqAR
         N14WZSLrzPKhxLMDds9glb/bJbrpg+rHtOgH06ncSMQn+NpRWwwNpnvkXiAzvgkqP8HM
         69KA==
X-Gm-Message-State: AC+VfDwPdXnr2Fkg9eCDcLSx9+Qg09x7WYtJomE/82LE5xryfzmpWUpz
        1p9AzFuASbiKbu8RhNJbN+w=
X-Google-Smtp-Source: ACHHUZ4ZP+NAVyse0Mipkomi8ptcos9bFpXPDOlnhDB2wdt53262E8QxgK6AxoTHjd7a4zyPUat/3A==
X-Received: by 2002:a17:903:22c9:b0:1aa:d4ba:de2 with SMTP id y9-20020a17090322c900b001aad4ba0de2mr31800370plg.18.1683913715241;
        Fri, 12 May 2023 10:48:35 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5d8c:29b4:3ace:81ca:10f])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b0019a70a85e8fsm8192746plb.220.2023.05.12.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:48:34 -0700 (PDT)
Date:   Fri, 12 May 2023 23:18:27 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: microchip: vcap: Remove extra semicolon
Message-ID: <ZF5761tc1B32elgb@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extra semicolon at end. Issue identified using
semicolon.cocci Coccinelle semantic patch.

drivers/net/ethernet/microchip/vcap/vcap_api.c:1124:3-4: Unneeded semicolon
drivers/net/ethernet/microchip/vcap/vcap_api.c:1165:3-4: Unneeded semicolon
drivers/net/ethernet/microchip/vcap/vcap_api.c:1239:3-4: Unneeded semicolon
drivers/net/ethernet/microchip/vcap/vcap_api.c:1287:3-4: Unneeded semicolon

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 5675b0962bc3..a418ad8e8770 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -1121,7 +1121,7 @@ static void vcap_copy_to_client_actionfield(struct vcap_rule_internal *ri,
 			vcap_copy_from_w32be(field->data.u128.value, value,
 					     field_size, width);
 			break;
-		};
+		}
 	} else {
 		switch (field->ctrl.type) {
 		case VCAP_FIELD_BIT:
@@ -1162,7 +1162,7 @@ static void vcap_copy_to_client_actionfield(struct vcap_rule_internal *ri,
 						      value,
 						      width, field_size);
 			break;
-		};
+		}
 	}
 }
 
@@ -1236,7 +1236,7 @@ static void vcap_copy_to_client_keyfield(struct vcap_rule_internal *ri,
 			vcap_copy_from_w32be(field->data.u128.mask,  mask,
 					     field_size, width);
 			break;
-		};
+		}
 	} else {
 		switch (field->ctrl.type) {
 		case VCAP_FIELD_BIT:
@@ -1284,7 +1284,7 @@ static void vcap_copy_to_client_keyfield(struct vcap_rule_internal *ri,
 						   value, mask,
 						   width, field_size);
 			break;
-		};
+		}
 	}
 }
 
-- 
2.34.1

