Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C856C977E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCZSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCZSmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:42:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5515149C6;
        Sun, 26 Mar 2023 11:42:34 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l12so6465021wrm.10;
        Sun, 26 Mar 2023 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679856153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebu4nwIgN7mEFNHKsFucsdmAM5v0jx+vLanNvV8aD6M=;
        b=cGz6oQovE41PdbF6K1/CVSq1xgIlGN3j3bfO9pQBmzHxC2QOJbQ5PbwYwTSUPaO7mo
         DOja5/t+qf6iA4WrGKoreqfTdEO40FlqKRp+QAXJKu4xFdZlJAvVExQdl3fGYN4WIsQ5
         BhN5O5BDe4+AAZJqtjPBlgJghEIqKRcwg49R7wMR9rigM/bshrhQNOtwxZMNdxg+K/J2
         tHuP37AvyYrlpZGqwexBnAtTpWNPCSDI+SJmlFoqgG+2KJlI2xgGcsK32/j0A0AmUBCg
         iP7hGv1BDnl1RWZHwlxdWjARFCs7ev5NxTWymHFICyfQNEAzIfft0d/Lk59BTOI88AuM
         U9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679856153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebu4nwIgN7mEFNHKsFucsdmAM5v0jx+vLanNvV8aD6M=;
        b=B4z8gEe/JXoSd1iYGvabsNGA7L8RmT/GZAD9ENXo+X2HLQsOLlVDCuc1QFyo3H5KMT
         pLbMg6akUhh8cKRuUyK7y55S9AWd4+FQNcDENSt1tGIR4IoaQjnzOLbk77gIvfrt7XB0
         qvsqgTioaf/eVj5+B744msFcGXTyagdB8QId6fOL9ELVxaEnEWTtyAeEeMVeqnvxyC3p
         7gwhp9SX8ns4G0NPa5BPnjBg0MfE2kzxbwPZXUs0xfTWFlqrvbPGeRCeTIjyt2WJZV8k
         ImN1UngJhRIdxFeizQP3i6lezBqTIoy0rJXUg6J20zoOv8I6a/q4Ya2+X2uWmjZe8xgL
         w2Qw==
X-Gm-Message-State: AAQBX9e6gv99UtxxFrxd6LQ4is+G/AkOn4qi2gI9+vvocH5zVPYcbZNE
        VgJWzNiKqJpHp5x1BSscfSk=
X-Google-Smtp-Source: AKy350bweOuSB+T+41j4g8mueKqP5Qvj+aUaZwJpzR2ZP/2Qg+Yog2owKwKJUym5uQAAIrQHowdXJQ==
X-Received: by 2002:adf:fc8c:0:b0:2c8:9cfe:9e29 with SMTP id g12-20020adffc8c000000b002c89cfe9e29mr7294653wrr.38.1679856152883;
        Sun, 26 Mar 2023 11:42:32 -0700 (PDT)
Received: from wasp.lan (cpc126518-gtya5-2-0-cust190.4-4.cable.virginm.net. [86.19.196.191])
        by smtp.googlemail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm23194725wrx.116.2023.03.26.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 11:42:32 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, bigbeeshane@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: Add FriendlyElec NanoPi R6S device binding
Date:   Sun, 26 Mar 2023 19:40:40 +0100
Message-Id: <20230326184040.33008-3-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326184040.33008-1-bigbeeshane@gmail.com>
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
 <20230326184040.33008-1-bigbeeshane@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the needed bindings for the NanoPi R6S SBC based on the rockchip
RK3588S SoC

Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 35f74eda30ae..b8574a93e0fd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -201,6 +201,11 @@ properties:
               - friendlyarm,nanopi-r4s-enterprise
           - const: rockchip,rk3399
 
+      - description: FriendlyElec NanoPi R6S
+        items:
+          - const: friendlyarm,nanopi6
+          - const: rockchip,rk3588
+
       - description: GeekBuying GeekBox
         items:
           - const: geekbuying,geekbox
-- 
2.40.0

