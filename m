Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6CE7069FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjEQNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjEQNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:34:15 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF7493FB;
        Wed, 17 May 2023 06:33:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae52ce3250so6412065ad.2;
        Wed, 17 May 2023 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684330429; x=1686922429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rbMQ0v3qCDD0ikHRHPJXrlACnnN8XxCRviK30k53MMg=;
        b=RdHpAmHAmgLsJMNhFGmDLliPlydekszKQt9Tz6yED4lbjlyJO4WP+zJvjbG2AEPCBE
         qZYxCpEgK72p119skAHTvpTu/9wKzeUFsKVv/61qVsje+kxlLhrjYrzqvsRLhufEwVYx
         FGTVULU3Nd+prqhRnzpbDs6IhiwIvP+9lKTvIKQQ8PzikNiQQVnkp7DpZkeNMUuPXz1I
         b+rCUMMmkjCPF8Gp1mVtDNGaIVhndd6XCSwzm4MbruhtfDrYbaafrXrEbkfgcSJlgs8E
         ZDi81QQF9NjPkeISnDfrD+Bby7q3cAnq4j92YpUmuJMo17tJvXPBzIka8C2pgw5A+yyb
         a6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330429; x=1686922429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbMQ0v3qCDD0ikHRHPJXrlACnnN8XxCRviK30k53MMg=;
        b=Ti7VTpASYhBag0yzRzjOJfViAJWjUOakuINHVOK95t8QWCVQ8ei71EQ5BRmNE2ku3U
         yvElxLsb5t+l0cTdi9+sOEw/01FRqZDqIIkFjJjeNwrP1uyNKQS4hfUoIrlY7Zt9x8sK
         x3xP4UOqfHSPpwaQ2RdIMiLFQ4odwJTtPA+c99tF0UM3iq1XRdBvUoyPcWZb1RJlCIOC
         kUIhhGU57w7+20BZ5o+5rCm61qbezkPyKfGVFS12bO1xRvx4cb7ud2lD3LzTpBUn/G2z
         GYKv6U9onCY3udd1cvl7LCu4Wy7Nk3bUtI+qg1bZJ1+u6uSb18UIsgn5U/EOWy8eHJYC
         de2Q==
X-Gm-Message-State: AC+VfDzOHcknG+7waMRzGqXdY7yB1dmo/qNxmGBvApnZQ+5jiLhF6vpg
        75E0RD2luw4ZW+K5Mf4cwow=
X-Google-Smtp-Source: ACHHUZ5neLbN65pdb8800vQuzivVb7/qsgL/pjdYn69YBg2IaPl14+iRcWaf3Y3bIRvpHHYhq3gkMw==
X-Received: by 2002:a17:902:da91:b0:1ae:f37:c1ab with SMTP id j17-20020a170902da9100b001ae0f37c1abmr16417374plx.25.1684330429024;
        Wed, 17 May 2023 06:33:49 -0700 (PDT)
Received: from localhost.localdomain (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b001ac7f583f72sm17519253plx.209.2023.05.17.06.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:33:48 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2] arm64: dts: qcom: sm8250-xiaomi-elish: remove redundant empty line
Date:   Wed, 17 May 2023 21:33:40 +0800
Message-Id: <20230517133340.21111-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a redundant empty line introduced by
  commit 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
 - Drop fixes tag

 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 8af6a0120a50..eaac00085894 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -504,7 +504,6 @@ panel_in_1: endpoint {
 					remote-endpoint = <&dsi1_out>;
 				};
 			};
-
 		};
 	};
 };
-- 
2.39.3

