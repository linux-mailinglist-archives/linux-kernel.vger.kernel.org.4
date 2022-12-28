Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF269657522
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiL1KGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiL1KFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:48 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB5BC4;
        Wed, 28 Dec 2022 02:05:45 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id m4so15648179pls.4;
        Wed, 28 Dec 2022 02:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzi+Ui9Rw3X+XYHjLsOHBpUgiG35eMVgsV9hKdEu7Iw=;
        b=YH8WvQt8cfbYK+gfW4TIeFqiqDxUobd13/phjftV4AunnwVimnLVxCaOWioGaN/bsn
         8jw9eqQnAAVzvIMYgavXDVzysr8L/3SwZbkSd5uXlClbXiOAxnXjtNIKYVOUkD9ZE3Fc
         au8QxhvOqZXG76Qn+1uNuk9KR/pPQN5tmYLGMepixNRNhvtPvXezLCM4dPIdQlhMx+ID
         G+RBJ81P3g62UOD/G6G4tt/i17XvTXWjKMgPO2itpY67HJY0AAB9U1Ik65P9LhxxUMJN
         GqA2k3wKDIBsLYViLsQvzfH7KCbeeoX/re3RE1VdbUy9xdYqYjnMX616Wc+IprxB6G/N
         TDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzi+Ui9Rw3X+XYHjLsOHBpUgiG35eMVgsV9hKdEu7Iw=;
        b=KagUT0/exCN39OaQKdhlfiVEEryw64Lg8943nikSOQy4XD8Ro+zVaelu94OVlQi5ku
         tTiUq5NUBzt/9JgCgw5tb3s3dCDrtk7NqgFtvx40wimXP6iCS4rn7+VZGjhRLGw5cT+a
         WtooTeNPOUqROfSztHa5xHvE2ljJdvexU9pdd/4dClE0Rky5hc4yI16e69ndPdWb5j6t
         9W3KkoQlc2xc+1w5Pmm0lQv6UQH5GSY6Wc8Hwr/18XvV20frNpCueikiBYxlk3i8B7Cs
         2yZp0c0OmFQuJwjCPJCAOtoAnHHzM3uhq87+MLx9m9/+2m4WYG0FGK7rQnDj6CsVyfwP
         ozcw==
X-Gm-Message-State: AFqh2kqBCjHfZhNsDDRCGXbNo8RVnX82s7mWwY5Pa9Fq/2jmRjD1jKIW
        /PoYiupLAscM9XtbjPkG2NU=
X-Google-Smtp-Source: AMrXdXubODrYUscwAMYeQ/mYu7Q4kTIctO/0GrKB0wkpifvIlTYfyORN4CGcMsF8IwOnAfOJ45xYhw==
X-Received: by 2002:a17:902:c1c9:b0:192:6544:18b0 with SMTP id c9-20020a170902c1c900b00192654418b0mr17675539plc.63.1672221945196;
        Wed, 28 Dec 2022 02:05:45 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:44 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/11] vendor-prefixes: Add VIA Labs, Inc.
Date:   Wed, 28 Dec 2022 10:03:16 +0000
Message-Id: <20221228100321.15949-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

Add the vendor prefix for VIA Labs, Inc. (VLI) is a leading supplier
of USB and USB Power Delivery controllers for multi-functional devices
and platforms.

Website: https://www.via-labs.com/

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621..d19b7f9cef4c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1398,6 +1398,8 @@ patternProperties:
     description: Vertexcom Technologies, Inc.
   "^via,.*":
     description: VIA Technologies, Inc.
+  "^vialab,.*":
+    description: VIA Labs, Inc.
   "^vicor,.*":
     description: Vicor Corporation
   "^videostrong,.*":
-- 
2.38.1

