Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CC569E087
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjBUMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjBUMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:36:50 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1C233D1;
        Tue, 21 Feb 2023 04:36:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g14so4690610pjb.2;
        Tue, 21 Feb 2023 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5L3dF0JAJgBcduePLIvYCGmEEesF6lNT+h6CRgkwaQo=;
        b=h/tOHFqk90X4NN1IPLfzidjqDpYazUZbvc7olKGdQb0DrlHH3KDj/GfgQbKuBpe5ZM
         aHpFX1mwNg7ggmf34CFyOZgTXzmVAS8XrrIcCQQV4laUeg3Fkt2JGCiFI50QWYvbwgty
         pA1lX/F47AN6VQ0qWZkX3MRD4xyc9SB5WqO/QyaA1bOkI/mdpo3F+L4ACEyGAlDtGySX
         WoaPiDwvRr/7kpn1TVEfag0fPrvg/jhevaJJQg/R2KCAZ8xInewaZj/eOEbYImy0vcCr
         Tea0w/LrQbgr2MBJKIM7cr96W4Q/lTZZQ/dU1MSVwqWNU7rg9NpB0h1n+BMoQI5Ax5xp
         2UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5L3dF0JAJgBcduePLIvYCGmEEesF6lNT+h6CRgkwaQo=;
        b=LraeIrcq+RhXT+bDVhEQS58bJyyjIdzDJKU8JtaBoleQzdyyYFUHZYBf/TC7yYFkpS
         Ow992IfsLYr0FZridNpSONfQgWc8InOhqTfDJE3lgvAhXTzk95MHnmrOsk7W48IhtCOw
         mp/KGfMHh+VYrOiok3U4eIvTIX6oSez+ESzAUxV7hoQAM9A1bScHZWxXJ3ftCXCyS4/i
         U1NAG+oz8iIsgCyZTO0s5botHZF1yBGMwE5WtquBTyuz/ngr2momecVEOr1+z+Fj8rwQ
         s0WTIymZmZiIam5+/YrgQtlk/OR7Vunq0tWJPx251BcDrXQ/AINGbs0XvKK61OcLAVVR
         ii8Q==
X-Gm-Message-State: AO0yUKV3JQ9XS+gsVp/cXnPYCx8eae5ah82HzCoVZo8N5gfWYyhsXBGf
        AjGMnRyo05q0QNkmXuGeSuyhXyiSbGf/zg==
X-Google-Smtp-Source: AK7set929D4rdR6a3m0KR51+bCeLnOUOt0c95DWoOQbQcmYKwxoUEPNln6hcTz7Aw/ppGEy0brIzwQ==
X-Received: by 2002:a17:902:d4ca:b0:19a:9880:175f with SMTP id o10-20020a170902d4ca00b0019a9880175fmr6088717plg.51.1676983009033;
        Tue, 21 Feb 2023 04:36:49 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id jd7-20020a170903260700b00194a297cb8esm9822879plb.191.2023.02.21.04.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:36:48 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path
Date:   Tue, 21 Feb 2023 20:36:33 +0800
Message-Id: <20230221123633.25145-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing vendor name for venus firmware path. Add it.

Fixes: a41b617530bf ("arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro")
Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
index acaa99c5ff8b..a85d47f7a9e8 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
@@ -625,6 +625,6 @@ &ufs_mem_phy {
 };
 
 &venus {
-	firmware-name = "qcom/sm8250/elish/venus.mbn";
+	firmware-name = "qcom/sm8250/xiaomi/elish/venus.mbn";
 	status = "okay";
 };
-- 
2.39.2

