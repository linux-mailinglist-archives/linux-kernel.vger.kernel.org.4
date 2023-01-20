Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3A9674DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATHVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjATHVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:21:15 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F7175710
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:21:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q10so4026264wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QS+zr7J2/9XVv/To9npcQgO+pWfynQOqGssuU3FGi5Y=;
        b=wi3mrkzusyt6U0jliKhTh0HGpAdXyP7syUl7b2XQNJEmEDY/BGma3qfn8nGsbcK+iu
         LPF288oFOBVff4A0ViGih64u1IA8qqlvapgd2rn85Ojftha7KhkHwEJTEXu/VvxfwBJt
         hyq48tJjIp9KIJ4Uif1+XFLIuwuFFoBM4TaBDocOn7jKeNhm/3Xq9gOnp9maO+FO9q3t
         kri59CzOsZrXa6G/q6UF9g3UK8c8l32QxgUxcdep3b3UHr1iIHMCxdMWVfgFkCdstX+K
         2rsq7tMr9E1faxRfhYMf7r9iRrDCiaTsdmHKRJexxWAgPnaMAuatLBjqXKbIZBop9VKl
         p9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS+zr7J2/9XVv/To9npcQgO+pWfynQOqGssuU3FGi5Y=;
        b=OX6/fk7ygWPvtRZups59YaDsdEoctkEoqsXUoglcchfYcQ4Pv+8rD9BSfZpeitewDV
         bxQAKxPbGt9/m+gTEP0HlGGKE908FOz8DkWVHm7uG0dKEYWXT9++ZIpKp7glYu8mawuG
         PQcCfdXA4GFT9nXDqSsLL2+vMia9ymvMVeq04wk+BCtFkyWfpcP+O9D7OD56/p6zklz1
         MmSAgl1ili8CPcQlsvUckh8UplvEsEgmjhBOmgKspqABDeZljVlTmF7OrrpXPhB1yYKO
         7o+77U644Yr2pdkhYqH00qXtpgOLZfnVcZknInnPYB/6HZCPPT2UxciRMy3O91v+0Hk3
         fi1A==
X-Gm-Message-State: AFqh2koyjuKVHa2cdEKxeaiZa8z+lj1caxEUyKpPqqzy/G7rv++kFdcG
        qAUnN3DZiIXAD+VM515u0Chtdw==
X-Google-Smtp-Source: AMrXdXvvUFXBd7OqrLeAl/oKe+DMJDGCEQdiQfSt9ivW9aAjKqDqfR5lUhQPz3zc8wW45uVgVjaYiQ==
X-Received: by 2002:a5d:618c:0:b0:2be:5075:16cc with SMTP id j12-20020a5d618c000000b002be507516ccmr2481318wru.31.1674199272612;
        Thu, 19 Jan 2023 23:21:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm36025376wrd.40.2023.01.19.23.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:21:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: stih418: align OPP table names with DT schema
Date:   Fri, 20 Jan 2023 08:21:10 +0100
Message-Id: <20230120072110.138627-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT schema expects names of operating points tables to match certain
pattern:

  stih418-b2264.dtb: opp_table: $nodename:0: 'opp_table' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/stih418-b2264.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
index 34a518b037ab..fc32a03073b6 100644
--- a/arch/arm/boot/dts/stih418-b2264.dts
+++ b/arch/arm/boot/dts/stih418-b2264.dts
@@ -42,7 +42,7 @@ cpu@3 {
 		};
 	};
 
-	cpu_opp_table: opp_table {
+	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.34.1

