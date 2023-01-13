Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D14669487
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjAMKoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbjAMKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:43:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1510B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:40:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v6so30551885edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Lqi2qWaYx7n535U9XW1h+a9NyBOyBXflTHaT9eqtA8=;
        b=katVxa8Ex4CRGJJsmULTkQpgVjYkfuaha0loi+rl8WUbpcAQT4V2z8CPyeSITTmNYD
         HZfeRT2iR5GUCsa/WBEnejwzMJH9au4lfLBfDfzRF6ptb5mb+9EisCz/S8j5sD5MaDs/
         svhsdOgVlABpi9DSPrnWrJTxO7SWsXK0z1tYRMBHp5vCYmRWXQQlG8ad9J+8YHNR1sVM
         3ctYe1WEPIZVCNWTss688WMd+ZdAyGxEQpQsU2RjUiOwsXzzEJjwzSwNqYwOmucjR429
         4+GMq6Sy2jJ5GnNidtfWugLMQ1AQJhELs+sDzzYPHBs3Au/Nfe24IjRITqfWcrhRyp6U
         huAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Lqi2qWaYx7n535U9XW1h+a9NyBOyBXflTHaT9eqtA8=;
        b=kczUg1kFIYGX0mvFDnV6zwyMBugjK++3gl9GpsiD2v8hjYEPaw04mRCG3gC1sQbbbE
         9aftmmeBOJkuf/pR0OiRCt7jev6HkLmetAKR9fFWuYfBob6PAJKMfJIxpOi94QwquVv5
         N2qs3AYwxz0QeDNdQm49sAaMZtXpoG8PBO+P6FXoMWpzM99edaZ/YSOTHPpsP4s749D9
         s6D0JoPM+q6GRape7OtkxJBWGIwiF4N597E0x8Z1gTWYy7oR1MJCAh8l7AVMz0iyokNf
         2AUOAFSmEh186NIPP4sASb8uMPzG1N5Pmrcl5SfyaP7QizTamJuB50JkJKcCbabRR7zb
         cLwQ==
X-Gm-Message-State: AFqh2kq1nLdDRdKu/U7qnbBL+d7VXXdHRHtw3Fd9nNdA41OqSxWgknHR
        mG5nEpOBoSYKbiQH28MCeb4Kxw==
X-Google-Smtp-Source: AMrXdXvfKSBwZfcNaY/Pu6VHyPSddMrHdhz+zLTeAISc8G4XMM5ykJJqZPAcV65C4vSZeM/gjyFLyg==
X-Received: by 2002:a05:6402:360b:b0:491:ad51:33f7 with SMTP id el11-20020a056402360b00b00491ad5133f7mr30525424edb.22.1673606454375;
        Fri, 13 Jan 2023 02:40:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c7029b24dsm8424538ejc.151.2023.01.13.02.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:40:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: arm64: tesla: correct pattern for directory
Date:   Fri, 13 Jan 2023 11:40:50 +0100
Message-Id: <20230113104050.30856-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The path is actually not a pattern but a directory, so correct it to be
effective.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e75dbca5c..2f0c17c15391 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3010,7 +3010,7 @@ M:	linux-fsd@tesla.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-F:	arch/arm64/boot/dts/tesla*
+F:	arch/arm64/boot/dts/tesla/
 
 ARM/TETON BGA MACHINE SUPPORT
 M:	"Mark F. Brown" <mark.brown314@gmail.com>
-- 
2.34.1

