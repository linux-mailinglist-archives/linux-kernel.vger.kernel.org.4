Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F96701647
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjEMLHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjEMLHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:07:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B950109;
        Sat, 13 May 2023 04:07:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53033a0b473so4859001a12.0;
        Sat, 13 May 2023 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683976023; x=1686568023;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wsEDY8MjhwZxqbrqnZrn1iSo+nyjU7FlSe6AYZfgqkg=;
        b=r/ePbU+d2mTetEFk6NqPRa5o+WH1ZHJ93DxFZoTtDKvuaS+d8TSSKQQrN1W0QNXiSe
         tiBYBqd/0vDnbF5bjhD6RjpxbxcIkuK953qisYOkjo7uDo7Sj4NPzZp5sVI2QkUAMn17
         4BvnSZC5pBA4UmY+Z4GBk51nI3BqcXDmCzhlHVbp6OuvcQrKmBSuo4cGTKsLarKNxtH1
         AqV5vMRkVxHHldUJF4X5O/9XYOmLw2/WsjZnAnHvX9+qBxsXCWvDh9vzt6YkLt+UX1QS
         BV6vIrD8+5PeBOYd0SFpGCDeb5luneIHwTlr7Ir6aks/YzImneR0WlWTJcVkDXwxYMhC
         zHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683976023; x=1686568023;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsEDY8MjhwZxqbrqnZrn1iSo+nyjU7FlSe6AYZfgqkg=;
        b=EFfkaPU1YkulK2i4PwuAPJww1EW0krYfL1oFBZ0tbukWRG3vHpzHFz2NIQLHt2W12D
         li8xrU6QQp3tLVEwvy8CmA1KAB9Oz0ybkR4xkHSlsw+0izNsZzN6S+zEDadDiS//wBbx
         ub8dMpJHiK9mvzLbjWSg6ywbUebwT9r7kwHSMpb6YAl9GgePTtVN8pV1W4Yyu1zC8wd1
         VN2HK2fdSbAdlQ7GQvox0zd2KfNthvouxamq0UUEOBUUx8ylWbIzNZ3xDPD9SE1t8Tes
         5Nfy89cY/XS232ElYTKEJHr4R/GyVIbZmH2ganinHitV0NbNW7zjYGNaJciVKzhFK8ga
         6pow==
X-Gm-Message-State: AC+VfDzbb3/zr7IEBol3UzbKM6ylhyKy3giDg/+VDLK/+FK+IfJ8TEV4
        j5DO8e6IHNfHv0ekMVNlQQzzmX76GFmqBeOp
X-Google-Smtp-Source: ACHHUZ7wIUzZC7I8IyHXbG6qQ8xnNj1LKopAUnFj8CsA8siqJ3HytTLU401w0W9ewczBl0sTjpfzOg==
X-Received: by 2002:a17:90b:1081:b0:24e:2f20:1ce1 with SMTP id gj1-20020a17090b108100b0024e2f201ce1mr26373461pjb.34.1683976022439;
        Sat, 13 May 2023 04:07:02 -0700 (PDT)
Received: from yoga ([2400:1f00:13:e6d6:c26a:8a2e:20db:e1a0])
        by smtp.gmail.com with ESMTPSA id jx12-20020a17090b46cc00b0024e0141353dsm18499236pjb.28.2023.05.13.04.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 04:07:01 -0700 (PDT)
Date:   Sat, 13 May 2023 16:36:54 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next] net: ethernet: microchip: vcap: Remove extra
 semicolon
Message-ID: <ZF9vTsEU4u3dORz5@yoga>
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

Changes:
V1 -> V2: Target tree included in the subject line.
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

