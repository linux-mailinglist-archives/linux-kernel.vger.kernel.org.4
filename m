Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1207156F7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjE3Hia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3HiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:38:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BFAA8
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30ae61354fbso1549436f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685432297; x=1688024297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHQhsBTFDkuQhoxNpEokv/0r+NXaRqu/3vue/LdQVcI=;
        b=NSOr/9NzVuIrWpU6M3oICUcM65vj2wa4VFC/pcBxdk8yg4wjDOTQUDdkQ10UFhmPzq
         NJa0zm2sk03VGltrRT1+CShBUhnQ/AOjVzFhMMWfn9gKcv585Ws9KZberZYvwh45snpA
         04nJNegcoOGvx49C6xQ84Er0YKRpYuepLFLi99cuEcYYd7U2nxAOfQki+zGqTd74kICZ
         ++NDlHLm0jvvGKrfpqPycT7zc5vZftiQ4ZJ5BO2diBjF+HHw6Iha7ZH6FqFas5z2rxgi
         S8oAvmLzGOsABsiTiqB8NbzlYfNV3c9MmIH1/9hPvf3tPV2zSWVhTp3xsFd967HsyhJH
         gh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685432297; x=1688024297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHQhsBTFDkuQhoxNpEokv/0r+NXaRqu/3vue/LdQVcI=;
        b=R+ifqBf+XdhN0+LbJ97ArMvATkkRARun25Go4QaRCq2fx4jknQ6rR30wYY0iiS+EIX
         2JLJm6G3/W4vwH0y+rKyw/4HJhqY7qBik6FF5SoRovUOKZlW1jiHk2ocs3uYRQoSF4+a
         EfpysWb4ZQH741ZaZsU0B9C/+1QBbd+W8hnJ/9dP9kw/HmiCQxPkt4LIXP4yleAcLBbi
         0iqdwPwmEpGjq+qmgLjvmEV18Moj0AHV1+T5xSg6ZgUZu0djHcZnIq+vjK2Ne4KxALXk
         7OH1ubBqJK3UTpOh4wNiLuVnbZ2EB+lSgx4kleOQdePzRpTKKcAEJ7IKVo+sQFL5rASz
         fF7A==
X-Gm-Message-State: AC+VfDz0jN2Bb9y5Jp6fVF+15XKHmnMTXPw1PVv+HS1Bqx7SvKDh+hT4
        /oSC5KSgxpF+bvDAgKLnshKlOw==
X-Google-Smtp-Source: ACHHUZ6D/mVI8auwcawNxpq0Xwa8T4pYrpgGAj/BIL5QadBoX48IUg3ysPom8OfSEaTzDh2KrP2T4g==
X-Received: by 2002:a5d:4f86:0:b0:30a:e977:de3d with SMTP id d6-20020a5d4f86000000b0030ae977de3dmr890345wru.28.1685432297110;
        Tue, 30 May 2023 00:38:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d4a04000000b003079c402762sm2312013wrq.19.2023.05.30.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:38:16 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 30 May 2023 09:38:04 +0200
Subject: [PATCH v5 03/17] dt-bindings: clk: g12a-clkc: add VCLK2_SEL and
 CTS_ENCL clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-3-56eb7a4d5b8e@linaro.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KbKcybkRo8Mj5Fjr+ajJFo4x0AGSd+2AQZgecUYttyQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdafe+1xMsg6o2539TRqhiYXrKqUICj4jB9MBjpMp
 SAripaKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHWn3gAKCRB33NvayMhJ0SocEA
 CVAPoxbACS10ENLyJwe5NXAcDDtbSY50/qd5b4dHarLbYdYx+nKJuL20lukVeblk0hTeMLb1Re82Cy
 YLIfoRF1KIcy/UtGwtNXjO1LP5b24dkydr16RZLaQaZoTPcW5o9TK0RguGOtunUkhwWAh9NRmFj4mv
 LK1ZH05YFPMP2OklXlNnUq1d4LHNapDo4IgItrbKyJOtIYODWLelfGKbhAtOAa6s2PCkHApOt8crWG
 7Wvk2pFohYNDnfJu5BlpMZyKFLDvhudotjT5qW8zjnpcTbceygYgwifx033UE4PG8WVhvWqEo/x60c
 ulseD7mSf1ilVWdtpCWyiqeSly6RwjZ7ORt4ChDyGzpc3ND0sGpkeFfhbJ7FOtrj6+W8s037mZEDYj
 nqFf1WlPv3jcD1OEvUGCPQVL0X1ceF3igcHHxOv9yG5vLCr8BR9EJGoH9QKeqFwwwf01lkAjUO088R
 YXQPYj4TvAlL/tKLQgalcD9oTc2i3AcJssz0hQSuIK14T3fIQB3UcLfF0X+obpMwTI2x1gKWkw+oBM
 cKxXDEBaDBG4y2AKPRRpBQkCnwanZXHE3p8muwUF2O4qayp7lRb5FdhjsksiNOEmegMHHBSCfgRudl
 999d78OkvkQ237+UYgvkfs7UrJm02EKhWXVtK58gcVwPDpnz9gH4s8Tom+7Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new CLK ids for the VCLK2_SEL, CTS_ENCL and CTS_ENCL_SEL clocks
on G12A compatible SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/clock/g12a-clkc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
index a93b58c5e18e..80421d7982dd 100644
--- a/include/dt-bindings/clock/g12a-clkc.h
+++ b/include/dt-bindings/clock/g12a-clkc.h
@@ -108,6 +108,7 @@
 #define CLKID_VAPB				124
 #define CLKID_HDMI_PLL				128
 #define CLKID_VID_PLL				129
+#define CLKID_VCLK2_SEL				133
 #define CLKID_VCLK				138
 #define CLKID_VCLK2				139
 #define CLKID_VCLK_DIV1				148
@@ -149,5 +150,7 @@
 #define CLKID_NNA_CORE_CLK			267
 #define CLKID_MIPI_DSI_PXCLK_SEL		269
 #define CLKID_MIPI_DSI_PXCLK			270
+#define CLKID_CTS_ENCL				271
+#define CLKID_CTS_ENCL_SEL			272
 
 #endif /* __G12A_CLKC_H */

-- 
2.34.1

