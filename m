Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D4710E98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbjEYOus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241659AbjEYOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:50:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A83189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so3319135e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685026241; x=1687618241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TpRYfzHZx9/tYc3Y2Xk8BfOtPKBqHSj0KnEjzeNrxg=;
        b=AaPqVFvrAOWUK3qmHkZXUicT1qRBkEZv57Fe+e/GAE0StnFP4aZxpfDnw9g8YpPTkW
         axzTngNoWUl0jSZ8kkpyUFJgVGdXm/AXUUSgnnDpcHXFoamZjOITehuH71aUTrLwVOaJ
         5n3XT4YxPJSxTx6GzBE5vqHSxRY7DvgEGy4om5YrhWdLBDhA/67jd3Dt4P9d2LjX99tQ
         RXA/i6b0wBKRnnMJRuIRHYG7B6s9M0tBOhoFNCwXgYBqSP7iH2WukkaLTpw7uUuW9Hp/
         6q+9d6xAyN6e4CyaH5qAFDm1OXHOTIeomBPn/k4Z0OOEL4VqHkANdIPqF2GWFcAIhISz
         XQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026241; x=1687618241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TpRYfzHZx9/tYc3Y2Xk8BfOtPKBqHSj0KnEjzeNrxg=;
        b=BQ6BlE17OpewxZubHGsFGJlEzFyeC+iTU/Il8XUiac9M2gyUIoFIOqYXNY1MIQrpbb
         AGqK6geST8TTH82BIhW459s9ST2H+xk3IKvjdIc6g9gAR+nTUldbPguLg105BoznCoEo
         LhrRwNV8CPu5iGisOiSSvCIXHtZc3YpjzvxB8MSbhXG2Idxwhjg6p2U/kCUk+vmVLXiI
         yWU8ZJhRxnCBleIGE3nnmKE2R3QetzxyvPRrG9iPj0CnIU3G3w7++qxMAyC99xUjCTZz
         Ay1k59IoY8KyRC+YdhcGigv20lNr2LLm9Rqt6iYOtYV6UEaNVqUUulGX2ldHaq1PEsaD
         k5og==
X-Gm-Message-State: AC+VfDw3ZQ6/Ich4XbRlKku7KKOrt+mO86e4etKwClI1/9UeXXAZQp2v
        Za4ui110JRtKJXvrUy3iI6n2fQ==
X-Google-Smtp-Source: ACHHUZ5oD1eJuOOXwhB3oSh2MYj9wjWgnlLFROvNmXdM0XO9cA+T02XHE8k1Y8GTJcBaWsddllrKRA==
X-Received: by 2002:a05:600c:3784:b0:3f6:552:8722 with SMTP id o4-20020a05600c378400b003f605528722mr2994082wmr.18.1685026240799;
        Thu, 25 May 2023 07:50:40 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n4-20020a05600c294400b003f3157988f8sm2349559wmd.26.2023.05.25.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:50:40 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 25 May 2023 16:50:27 +0200
Subject: [PATCH v2 1/2] dt-bindings: clock: mediatek: replace unusable
 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
In-Reply-To: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=OTCpf/cGWX/QOa+k7U0XGlCX28v0JhFQ08iD6/fULvs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkb3W+pK5Qktvbj+oP/LMTRHEHloR67cHOvXTgd2LW
 dFOw9wSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG91vgAKCRArRkmdfjHURfElD/
 4hfHecM1fx+yBLw5NYTj/6RqIFsLxIIyQbHNLDQ5/s8ICD8S77k6rhGsLhdrps8Buh/RmvzxD4spRV
 kCYEfz6n5CwEktvF3Wzi3p0Ybmw+WMnk2mBiP4F5Q1243KtrAr6pJbKuOxuRRXTTOmhHCWhH28OlSz
 +DhTPwzTlXfMBhkL8bF36YRgFuCEDDKd4LXk7tLd2j0SptQp8vK4emu72Z0SknrP8ISVeDf+9kc9jW
 2oFagHjJ93dMCu5s9qIuaMTvcgs6GtPcSf6HBxGKc2/6aSxnigUQr4N2Q2V5kwMrPadNIzqsXqG9Rt
 zoUskveZR0+Y4kH5SaNUpGIdOV9fTzEx/9ZBE5pCVFCxv7wE8sbLQuL8ydX/VRO8a527B0OMTmTwLC
 aHBhs2hbL/RiffOWhuyLwnhnsTm4Wxf6D4DrjkoEChXmgTCwCeYUXMo3AfU48Qp1Lwfkk3ElMXB7qI
 e38e1/pVG1tfdkhR/XFJvzDx1ATbsN6/wHC7+DB/1mBFU6PIM38y1FKiXe+zz7GT+kpgBmP+g4Pqmm
 v3NSNm7VP4tqy6NicpXR78U0hJHUREee7xc62d24qaHG0xqWZhSeU+5iEBDBtJ64xjeoYIcthDSMzS
 eTOhjSjMialozHY9QY+pZ6oa2mLQp2ydFlGWTKpnXc4qZV6ynS2OuIKU+6vg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The “mcu_pm_bclk_ck_cg” clock is used by co-processors and should not be
added to the kernel driver, otherwise the CPU just halt and the board is
rebooted by the wathdog.

Instead, add the "aes_top0_bclk_ck_cg" missing clock to prevent
re-shuffling index and then preserve the ABI.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 include/dt-bindings/clock/mediatek,mt8365-clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
index f9aff1775810..0a841e7cc1c3 100644
--- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
@@ -199,7 +199,7 @@
 #define CLK_IFR_PWRAP_TMR		46
 #define CLK_IFR_PWRAP_SPI		47
 #define CLK_IFR_PWRAP_SYS		48
-#define CLK_IFR_MCU_PM_BK		49
+#define CLK_IFR_AES_TOP0_BK		49
 #define CLK_IFR_IRRX_26M		50
 #define CLK_IFR_IRRX_32K		51
 #define CLK_IFR_I2C0_AXI		52

-- 
2.25.1

