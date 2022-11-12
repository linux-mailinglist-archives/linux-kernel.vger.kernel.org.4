Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3002626BE0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiKLVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:35 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB2A116E;
        Sat, 12 Nov 2022 13:21:34 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id u7so5645079qvn.13;
        Sat, 12 Nov 2022 13:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9s8/P3zcC35a/7U8wwUtQnHUttoN7Pw9xSfTjSoDyA=;
        b=lS7cf1+1z6f/If/JJO2IahlbNk2YHn+QDZi2DLAe50NrMq6e9i7W/+gNE8pm8R+tCj
         rBFr0PRY2lSXCq0+qjR6j7EKo6RgeOKtdjbwn8iqEmM5FZZ3XkILmTkr9eEJk3sitOqb
         XT55PetzmpaYeX15oVC1VmTD6Jf4SEY+Qqm19TnlBLZB+1vLsGOjYmmFoIrulEzkO5Jl
         SfTTj9Vien8cfb97+pjJNlDiV1A+XXbHPgMB6R3gBFsgvZBawMSR3fJOJNsVUNvuisND
         fwGNxUaLocC7X8UN6k9SlgTQslxmqF1cOEbslU5sSvKUB0+idTP9gHWtWbLbpd+YdKbE
         SpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9s8/P3zcC35a/7U8wwUtQnHUttoN7Pw9xSfTjSoDyA=;
        b=0gxjIZhBYKHQxYc6yu0/45tWAs1l80PvaNRd8KDEJguGKtkQS1HqxxoZ2gzKCyOiDo
         qp8bANcxVeNLfs+PPNAI615b6UXY7ir73SHiVnRMAIkG4Wu6hibcpL12wuehRrPFIqxQ
         pXNbXxKrTmA1cgzxX70o0Uoe9O8kd/xfxnbmU1CNWnUaATQpLN2Nu0ivFQl58ZPmSHNr
         WZ8tpnb1Xfs2n3VmLKv1JGNZpmGvwdr6fLSEM7ToiXlh87GHx7Czo40Ti8o0VRdu8hYc
         lVEm13nBgFD3GzrX9buDd3TpNYNbSUb55+f5JMzyxLAcLtM0lnMRFc2WEZ0c5SVMdrJp
         T6Ww==
X-Gm-Message-State: ANoB5pmFHRzWJS+th4Hin2x2Vc+7aGWpfwHW7r7aPT404gL9UtEbuAOQ
        eM1SED8lPOyK0KMRr10V67/Q002kC5zlLA==
X-Google-Smtp-Source: AA0mqf4oGVW5Jxi8N45W8IDFia/ztpx3l4FXI2ndBnJ1vVDNtabMyBR+M28zGdNJiczwkf3dqdUVWg==
X-Received: by 2002:ad4:4f11:0:b0:4bb:7436:49de with SMTP id fb17-20020ad44f11000000b004bb743649demr7014739qvb.27.1668288093369;
        Sat, 12 Nov 2022 13:21:33 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:32 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 02/14] serial: liteuart: use bit number macros
Date:   Sat, 12 Nov 2022 16:21:13 -0500
Message-Id: <20221112212125.448824-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
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

Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 32b81bd03d0c..1497d4cdc221 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -38,8 +38,8 @@
 #define OFF_EV_ENABLE	0x14
 
 /* events */
-#define EV_TX		0x1
-#define EV_RX		0x2
+#define EV_TX		BIT(0)
+#define EV_RX		BIT(1)
 
 struct liteuart_port {
 	struct uart_port port;
-- 
2.37.3

