Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC55EEAFF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiI2BeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiI2Bdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:33:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBC511D618;
        Wed, 28 Sep 2022 18:33:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z20so6297328plb.10;
        Wed, 28 Sep 2022 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SCE7PjRLwj6A9cf3VX+SP/oH5MxVVQmwgQMAjTSH2Qk=;
        b=jAF6Kl+KBatJ4TdNA+yUuC8UMdWGlXX5zL2vFLW3FLtFt6xZw0aqGLwM+vyMMW0aZX
         dMggX1U42LMu6YJFLqtp9Ucdfg57nn0Cvi642Ld93JaRXaRhovih4/XWQc2iLi2VLDqr
         b4WpbpZ1OgwAtQ+vI5nNCawldyNp36KT4JzOHFY4rM4CF9Zg9IwJNRmftaM3AbX6mByO
         5AFSKv8GYFXw9joJ2tOAbBp2yMozZnhBCFWHaTyWRp/uBFYUDms8FqdT6vWHUf1e6VJn
         0HBmWV/glteO3FxFDFBx3cegX0TcLX8nr+NjehAOl9ojY15iOJ8t0+3hcK+IS2uvUOac
         /nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SCE7PjRLwj6A9cf3VX+SP/oH5MxVVQmwgQMAjTSH2Qk=;
        b=7/2U85PK2TKlL5L7hLGUODOJzFtyqTr6R3bAuMtxpura+U9G4QoF3fGooMfLsWQzt/
         Dthpb+113dscrt78I4nnZ/iF6Lef+7MbrGJBc7w5KZEmWbbH6ozki0rZtNKQdg+2rOGo
         idzmoPmxn1nU8ZJlOBP2uGsGvqnNljYxGKG1/mzRmustZshoGZGSb0zxoot3YXbUzJEw
         i66LEF3rS0ZbhmwUZQu8aNEPkOTop3neMv1LJAnkgtTG1OTN/0cJ9wiIDT38Z/gkHrM5
         enrvKIzntSYu3Ts/LjSC40Zxp96qBwWYDtDZXIJhdUiWVQEsvGUZax5je8v22u49sR+4
         jiPg==
X-Gm-Message-State: ACrzQf12K4F2Diqd4C9AW30fcLmt+flS6iA4HjpvKwV3dba7iR80Q3uO
        NBpUQhIbk+U3PMp29U0Q1aY=
X-Google-Smtp-Source: AMsMyM47MXtDCAX2ikBp1yZXTWIPood4dSA9Pz+ro+u16jHFVf9tdhjGaHL4tvO9itCSAKrNkXFuYg==
X-Received: by 2002:a17:902:e545:b0:177:e335:9757 with SMTP id n5-20020a170902e54500b00177e3359757mr886201plf.152.1664415226760;
        Wed, 28 Sep 2022 18:33:46 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902ca0300b0016f85feae65sm4385587pld.87.2022.09.28.18.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:33:46 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: update and fix gpio-line-names
Date:   Thu, 29 Sep 2022 09:31:29 +0800
Message-Id: <20220929013130.1916525-2-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
References: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update new GPIOM7 line name, and fixed typo of GPION6 line name

New GPIO:
- GPIOM7: USB_DEBUG_PWR_BTN_N

Fixed GPIO:
- GPION6: LED_POSTCODE_5 --> LED_POSTCODE_6

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 1f72017c1e2d9..f5986f5909cd0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -984,11 +984,11 @@ &gpio0 {
 	/*M0-M7*/	"ALERT_SLED1_N","ALERT_SLED2_N",
 			"ALERT_SLED3_N","ALERT_SLED4_N",
 			"ALERT_SLED5_N","ALERT_SLED6_N",
-			"","",
+			"","USB_DEBUG_PWR_BTN_N",
 	/*N0-N7*/	"LED_POSTCODE_0","LED_POSTCODE_1",
 			"LED_POSTCODE_2","LED_POSTCODE_3",
 			"LED_POSTCODE_4","LED_POSTCODE_5",
-			"LED_POSTCODE_5","LED_POSTCODE_7",
+			"LED_POSTCODE_6","LED_POSTCODE_7",
 	/*O0-O7*/	"","","","",
 			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
 	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
-- 
2.31.1

