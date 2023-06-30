Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF450744323
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjF3UXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3UXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:23:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D542D69
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:23:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313e742a787so2076767f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688156619; x=1690748619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdr5uua22K5TJGpzaOfABOdr5K5CbriCXYV51/z8W3Y=;
        b=L+sHJACYpzXZftQt2XgnVsxk+sgo75Y8QLeAwlAnYV4JdA3BKB8d/5naTKmiWrZ8Gu
         IPOBbpSi88lya7nMyU5rIbRTsFTndbNoliSAFxWyuN0gQYpo1td0kUUOvu6UBtB2bZX5
         xyxtR3hqU8X1cFf1r1CLec9rHXWkQyb7JqnKvovp9XEsKN4j6n2EDXg3c+iBJM4onSPx
         pAi4SQMUiJEaNsCPo0EiBDuS3Z5+NbO7URAC2MDlBePcWzTi5vqBSxuMszlJNmYsrkys
         eEpQNn9hSo+lemAqhkt26KQBM4pN+7vNelMt1fCyRGqHysRp/H1mO6fWCwpHYbFzAXfY
         73Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156619; x=1690748619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdr5uua22K5TJGpzaOfABOdr5K5CbriCXYV51/z8W3Y=;
        b=iDvVnGhVoX1L3/2251dkV2KnK0D4+OfLjLzP+9HF48O/RKnZ0KNe3BPycmbQX1JbLf
         5TIqH0wJCpsQtALaqnPO1V8CyKExMnJR1j2wnFUBLoxW3Sd9KPtRYACTMFv0t1z3s9Se
         YDhyfjP03L+V88GO2tawl2YdTyhs9fFce6FSqSvvJR194M2DSjuOAEhUEG9nIubNOatQ
         QtsloU3VS17diAW3IEWzRlP8pZdAdzOAZlEgXI10P1qsp9A1Vj257qOk+EeeGLVRVkge
         y+NWbdJ8gR2uVadBccXniN2jwoKQcOWPUT6syoYIySnmTN93jZBBd/B2m76u+Pto1xUH
         kmxw==
X-Gm-Message-State: ABy/qLZXwWQnUnIEvsJJgrRT+XjNPV9jplOXPUXbE+hBMW7LZC6+tnGH
        FvbClfE7f2iJpoccnIbmCn6jJorBj9hOVw==
X-Google-Smtp-Source: APBJJlFg2M1eH3eoCsGuUFotLghMasL8ut4MDUyUF6EpvRS5zA1Gz6lqWO+GwTvwKH0SP96MZnd5Kg==
X-Received: by 2002:adf:f44b:0:b0:313:ef62:6370 with SMTP id f11-20020adff44b000000b00313ef626370mr3669617wrp.10.1688156619074;
        Fri, 30 Jun 2023 13:23:39 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d610b000000b00313e2abfb8dsm18485371wrt.92.2023.06.30.13.23.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 13:23:38 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: add myself for spi-bcm63xx
Date:   Fri, 30 Jun 2023 22:22:54 +0200
Message-Id: <20230630202257.8449-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed the driver is unclaimed. Since I was the last one doing
substantial work on it, add me as the maintainer.

As it is only found in legacy products, mark it as "Odd Fixes"
instead of "Maintained".

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc201627c2e0..d12da512dceb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4169,6 +4169,13 @@ F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
 F:	drivers/spi/spi-bcm63xx-hsspi.c
 F:	drivers/spi/spi-bcmbca-hsspi.c
 
+BROADCOM BCM6348/BCM6358 SPI controller DRIVER
+M:	Jonas Gorski <jonas.gorski@gmail.com>
+L:	linux-spi@vger.kernel.org
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
+F:	drivers/spi/spi-bcm63xx-spi.c
+
 BROADCOM ETHERNET PHY DRIVERS
 M:	Florian Fainelli <f.fainelli@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-- 
2.34.1

