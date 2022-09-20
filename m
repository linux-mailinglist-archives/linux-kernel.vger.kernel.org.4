Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71405BDBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiITE0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiITE0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:26:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2908158B69;
        Mon, 19 Sep 2022 21:26:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l65so1588573pfl.8;
        Mon, 19 Sep 2022 21:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kNFWWy7bwpQVYleHcT5hR/K7/r+CDpNqO6pCTqZ+Bqk=;
        b=iEoOYDQuDeKqlyz9GzDA5FBF1n+Te1LRLAVTNZY+LC9cDRaDrwdI07j386rCcjd/+b
         jWSruN7EDHX7ArOufpN/hDIWzVfTZfN7YgrBRuGcWQRg6lH7e4sbajvVJ9oXiNQeCaTe
         76+dqf22D4yzJl3PPTKcG948hM6pO+PlHjvyW1vtG4Sf/nbJjMVxVWNCn+HTUe/cLsui
         8Q4bs1P5Jh8MAmvTVnp2O1IF6BBq/6nJcVdYZob/VlrrTIXE574cAKRnKWGGVpINxWHM
         QY90cN6dlVwwMtoWODH+RcX8nJPUGlI0HUXd3nEsZwXziRBq/UEfUkb12AkCK+HSvolf
         RFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNFWWy7bwpQVYleHcT5hR/K7/r+CDpNqO6pCTqZ+Bqk=;
        b=ppK0yN/1ku2O2bVs7Y2RF3keynMe2yF8Wg4UkjNTyBsdD0gi5MFk3k15ufj3tuwQYH
         zSkUmLvBpfYsnCEylpG0tegKwA253Ric6l4k9bPrfIq8J+V+8IXbfVRke96C3hqEq1mY
         9m8077tPfZPuCax5Zogqn5jcbn8NWuheEAkXCEO68T67qbypPJil0s2mKFLyEAiimu4r
         kGhq7oVPuW69bzkZOgFSf6PK9gahzyIgAaiZhbA7wyTVyj/sMYZDUjDR5PqJRQ4lPZwl
         BM4pjgjCVYz1vIGzELH6OjqgDEs4UOjJyTubDOWybiDLBARw9lrPkr+4tNm2rfK6d/J5
         vdCg==
X-Gm-Message-State: ACrzQf2hCE87QpaB7n0rQmEdmG/Xe33j8f5TA8Xh1lCh3hd/XJ1TNYGt
        3JKOtJznVCFzJ/V9cShkSPY=
X-Google-Smtp-Source: AMsMyM6kjzieQk2rKnAzOxto0IPCpm9CxxoKAfWuP0jfdKwCKYLBCjC1iEbrRHSMs6hoOtRm5gZHew==
X-Received: by 2002:aa7:952f:0:b0:540:e8ee:a077 with SMTP id c15-20020aa7952f000000b00540e8eea077mr22001999pfp.34.1663647973928;
        Mon, 19 Sep 2022 21:26:13 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:b095:5d5d:4c28:8088])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090a024f00b001fab208523esm337518pje.3.2022.09.19.21.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:26:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-input@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-binding: input: egalax-ts: fix GPIO and IRQ in example
Date:   Mon, 19 Sep 2022 21:26:06 -0700
Message-Id: <20220920042608.1865560-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
References: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
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

The driver is using level triggered interrupt (low) which is backed by
and active low GPIO that can be used to wake the controller by driving it
low. Let's annotate it properly in the example.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../devicetree/bindings/input/touchscreen/egalax-ts.txt       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
index 92fb2620f5e2..ebbe93810574 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
@@ -13,6 +13,6 @@ Example:
 		compatible = "eeti,egalax_ts";
 		reg = <0x04>;
 		interrupt-parent = <&gpio1>;
-		interrupts = <9 2>;
-		wakeup-gpios = <&gpio1 9 0>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
 	};
-- 
2.37.3.968.ga6b4b080e4-goog

