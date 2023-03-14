Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224966B9ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCNSn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjCNSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:43:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827BE1AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so34811657edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678819386; x=1681411386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TA9zaJ5cm57+RQC5jLFl72abHNghx3LQzCmXrcIYNDI=;
        b=LggMcBwAP4URtNCS2KXeD+vsh8cUFnRZcAeMOaPoaQMUEJeFMnc6gpVgVt9fUplcsn
         dS1wXcboTSxV6Oxiaus9hD61AFByPwEEaS9ZxwlFlnMS8OpuAUv2lCbQOkB8XJSZc45b
         D1cPF5UF2OldJbwB0uIsotEblsniokvsdxJ4B2OIj7GfmWpcS4msRAG+eOvIlYOPB7KS
         mDw2KoUPd/UIJUlz1ZksJm7T0v1E9vp8wbjr/Xq+hVtXIP6st5lxjTfM2aglaR5E7J6m
         Y+q3Sk2RuOvXgrEGJgsWQMe5du52LNQW3kRyJclHsGvy+eYmynwkAeAlEo/DYaeogg7S
         mX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819386; x=1681411386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TA9zaJ5cm57+RQC5jLFl72abHNghx3LQzCmXrcIYNDI=;
        b=NZuu3G4/nX6ejevqb9O60qufVbx9v/Ez+u8rmb2DFswuWzijQe22OS1+une4JSutm9
         K28EqmEx4+N8q7L05ykdrRF4qfM+HWMQ60Ciw5w271YmvN2kykkvrL1Bw5pdeWNV5Rzc
         QG+FpIhNjOW8mgRuAazTbZMT8d/804pjNLmAB9XCjXLEoygU1SAfGJ/QNRp5dBjdcR7u
         JrEepru7+wWlZXgGjv8TeuNoYgo9XhdjsLx/drqogfe4puyHgdiMj9iUs6y4QJ0SW/AL
         jA4Q6ijZB855Zh7FxcftVL6opqM3w/4gN3s9r0JlQHPpM2wljsPeiToM/EABDZnhQ6zR
         GLKg==
X-Gm-Message-State: AO0yUKU+1ysUChDAuLJH+tZIZwZSOru6TDoh+Xbt2u8KfZP5sal7xwWL
        ior0T19qCU2DiPL/Ru+UvkFSeuBsFlE=
X-Google-Smtp-Source: AK7set90F8apQmTQepJarCZvWAZB0Il3suuwXupQV/v2GNqcTmWfdE05HneKUQON1vmy/qZKtTjP7g==
X-Received: by 2002:a17:906:109b:b0:92c:f016:7ac2 with SMTP id u27-20020a170906109b00b0092cf0167ac2mr955084eju.0.1678819385820;
        Tue, 14 Mar 2023 11:43:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id hb25-20020a170906b89900b009294524ac21sm1495274ejb.60.2023.03.14.11.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:43:05 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:43:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] staging: rtl8192e: Join constants MACPHY_ArrayLength
 with ..LengthPciE
Message-ID: <881ce5739e4237ea9a31029acaa535422d41fa5f.1678814935.git.philipp.g.hortmann@gmail.com>
References: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1678814935.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Join constants MACPHY_ArrayLength with MACPHY_ArrayLengthPciE to
RTL8192E_MACPHY_ARR_LEN to improve readability.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/table.h      | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 54596982bc76..29918a529f77 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -291,7 +291,7 @@ void rtl92e_config_mac(struct net_device *dev)
 		pdwArray = Rtl819XMACPHY_Array_PG;
 
 	} else {
-		dwArrayLen = MACPHY_ArrayLength;
+		dwArrayLen = RTL8192E_MACPHY_ARR_LEN;
 		pdwArray = Rtl819XMACPHY_Array;
 	}
 	for (i = 0; i < dwArrayLen; i += 3) {
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index d984380bcca3..611756517ce6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -9,7 +9,6 @@
 
 #define MAX_DOZE_WAITING_TIMES_9x 64
 
-#define MACPHY_ArrayLength			MACPHY_ArrayLengthPciE
 #define RadioA_ArrayLength			RadioA_ArrayLengthPciE
 #define RadioB_ArrayLength			RadioB_ArrayLengthPciE
 #define MACPHY_Array_PGLength			MACPHY_Array_PGLengthPciE
diff --git a/drivers/staging/rtl8192e/rtl8192e/table.h b/drivers/staging/rtl8192e/rtl8192e/table.h
index 439847b1f52b..cb424c8fbee0 100644
--- a/drivers/staging/rtl8192e/rtl8192e/table.h
+++ b/drivers/staging/rtl8192e/rtl8192e/table.h
@@ -17,8 +17,8 @@ extern u32 Rtl8192PciEPHY_REG_1T2RArray[PHY_REG_1T2RArrayLengthPciE];
 extern u32 Rtl8192PciERadioA_Array[RadioA_ArrayLengthPciE];
 #define RadioB_ArrayLengthPciE 78
 extern u32 Rtl8192PciERadioB_Array[RadioB_ArrayLengthPciE];
-#define MACPHY_ArrayLengthPciE 18
-extern u32 Rtl8192PciEMACPHY_Array[MACPHY_ArrayLengthPciE];
+#define RTL8192E_MACPHY_ARR_LEN 18
+extern u32 Rtl8192PciEMACPHY_Array[RTL8192E_MACPHY_ARR_LEN];
 #define MACPHY_Array_PGLengthPciE 30
 extern u32 Rtl8192PciEMACPHY_Array_PG[MACPHY_Array_PGLengthPciE];
 #define RTL8192E_AGCTAB_ARR_LEN 384
-- 
2.39.2

