Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623BE7308F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFNULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjFNULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:11:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD110EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:11:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5185f195f05so4686901a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686773461; x=1689365461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9EkKKYYY8csgF7Nu+oj6eisL8ER/DT9CHRKdsrScRso=;
        b=I4R5pCSu8GbE0HEGfLFdYmhgsgWTBdeF9oVGFwF23DiiiR0e4zB8EI8BhbWvoqTzbR
         e+XmCmtvMhQd3ZqLMOPcZvb1yuRNqjYrsX82tjBq5qEtSiOARvJxxvA/FZnu49JX6ozD
         qs19SSGyqTwD6oYfRtOGZQ4ThK9C0Nq1mlomE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686773461; x=1689365461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EkKKYYY8csgF7Nu+oj6eisL8ER/DT9CHRKdsrScRso=;
        b=eW2kpAjkjkKtASS49S5DmqwYOqk5wUXEoudcmN7pco5fN3k5PUhhiyFsOO/qy+698/
         uv64CovZLL5COdoZ9jBgNPdLSUmRJdiJIr7LzS07OMMR56KXQgLtbno/0e6OGU6i+/Ay
         dF7RsCKcBI5BQgtueST9XHFM+2XShZ6pVOTimTSPdDhrpbuvMrtmRXeJn2+K9ccZMI9v
         QvQ/NTpngKVAFve+G9k51C9nR93ihfu1uKEbgIfLgXlFy4Ue+M8veRfZfpIrzSp4xGqt
         Uh3g9n0Dn5JSZni+NjIsXuvizosq7M3yn9BSLGKsyEY8gFNZOVIsZjgBbDLdmoYfBUGX
         BwBw==
X-Gm-Message-State: AC+VfDzKkzXekVIXalSMfmKe692Mwz7iAJ0wGcHueZsPCARV8LK9zuRH
        ChHuAZqP2R/d1S7U9byFu5IFCdPetmzX2FU5QPF3iA==
X-Google-Smtp-Source: ACHHUZ5tNZByS5hCdD1ZesuxVKXsxMqK69r8rkj77kxF1UAlbi5hjf2Vem9iEcj1p3b5kiWkeFDx6A==
X-Received: by 2002:a17:907:9454:b0:973:d857:9a33 with SMTP id dl20-20020a170907945400b00973d8579a33mr16203428ejc.11.1686773460727;
        Wed, 14 Jun 2023 13:11:00 -0700 (PDT)
Received: from localhost.localdomain ([80.208.70.1])
        by smtp.gmail.com with ESMTPSA id cd10-20020a170906b34a00b0094f3d700868sm8399950ejb.80.2023.06.14.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 13:11:00 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: eeprom: at25: add st,m95640 compatible
Date:   Wed, 14 Jun 2023 22:10:56 +0200
Message-Id: <20230614201056.379080-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The st,m95640 is a 64 Kbit SPI eeprom in the same family as the two
existing st,m95* compatibles.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---

In case its relevant the data sheet is easily available from
https://www.st.com/en/memories/m95640-w.html . It seems odd they chose
right-pad with a 0, 640 instead of 064 (m02 means 2 Mbit, 256 means
256 Kbit, so there's some logic to that), but here we are.

 Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 11e2a95a7bcb..0e31bb36ebb1 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -33,6 +33,7 @@ properties:
               - microchip,25lc040
               - st,m95m02
               - st,m95256
+              - st,m95640
               - cypress,fm25
 
           - const: atmel,at25
-- 
2.37.2

