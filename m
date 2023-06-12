Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F572BF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjFLKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjFLKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:30:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712E42B9D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:11:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso6174207a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686564603; x=1689156603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NrWkYN+T1PuofiMKnG6dXc8ZUYCBSKcJmUWA7/nNhc=;
        b=iGVxi7WynRgu2Mvkpuu6WfSaTiMeQk78vcuT9skZSKAkjf/OQZZLKfRVGlyizob6dH
         easHar4p01pWftrl2U4/45zhILGm9sPTWJ1jNvO+BL38xc4BzSMBv1e3VdnCI17kmfmL
         KZY7QyrkyiTLmoEy3xRDyoEaHDJzinxoi9RjPQSJGDjIOwQ0Ayy9CMWAh+HpUNotvMnV
         4NBKuSP0+fgRlrnE56wBkGkuZzWGoDxAJI36rTjyD/8Fy/o6l9/DgBebvHKxaGnpzVgg
         oxbiIaTlI6SIvWYX3OQ6wEsdmyQplFS7aNmyd9xxr+xgX8mLFcD1grUNQ7PuOKb4OaHs
         u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564603; x=1689156603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NrWkYN+T1PuofiMKnG6dXc8ZUYCBSKcJmUWA7/nNhc=;
        b=NPiCPQq4vDoWSfxbtT0mLE2+agFzKalRG4yp5fb/RTrG2rLOJwLUXRRR1ZNjQ2maqY
         cn74xJ4ucT07ppWOv5DC5oL8n8KheSc6JQT+XBTQUXJgn4RErbqC4M1C3PkLdMKMAMNX
         3Nvwl0y0PucHVBR1lM3MXHfZr673R1pTjLQDzxZR+fVk9V5KCEk/G16TVGopJRdLfV1A
         GNWagKBaqdw2CEiQSCKAYhAn/bWyAXAgacXwFKFO6P333d4cIXxNU98h5yBVac6bTYoN
         1xC2k7RdOUlkOEtHYWpHUYezg5y5Nyi3oQkOYmj1rf+NMPiTIMGZt2BJvksk8TJVubW3
         nFOQ==
X-Gm-Message-State: AC+VfDyOxH5qoTpYqMuJ6JZVYA1po8RQ8819HKFqO+JNnxelLrxW0WfU
        5EGSiEVfOaasMy8Bmsn4AWcnvsDcyqTmGxA3NXkhLg==
X-Google-Smtp-Source: ACHHUZ6UbFF7XinpTrt0jXBpOVxMXkcAEgZfOmFyUIfEmeQZYaZ2yudSohukq1I9n1QgkdhoX5dpBg==
X-Received: by 2002:a05:600c:3793:b0:3f7:8fd5:567 with SMTP id o19-20020a05600c379300b003f78fd50567mr7016692wmr.2.1686563864354;
        Mon, 12 Jun 2023 02:57:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bcd19000000b003f7ff520a14sm10829525wmj.22.2023.06.12.02.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:57:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:27 +0200
Subject: [PATCH v2 10/19] dt-bindings: clk: g12a-aoclkc: expose all clock
 ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-10-38172d17c27a@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7gny86gEdGuVv1Xi4BFHu+2b+JlYB0+AahzkDT5GhB8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhuwJUlUTItdC3kUPmDRVJZidNU1HOd9NfqDOUhnU
 bzLCyWiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIbsCQAKCRB33NvayMhJ0e6sD/
 9L2RHqJBZ/WvUasGVtJfG0CFUUkWOgmyPk/3wNkO1BBXEh3pG16D+iz8phOPtBXy4bZeoIy9yrECAg
 bFiUwZljtqSHiC2xuxI6NZZxhWtVL7a2O8REQF/c9l3Uvm6QK7QVKwAaHZ013tWz0vwXGEDwvB5vbg
 39OL+HRj3gashe6POOxBPzkHvLRVPxYJbn5ki7VXalUGOlilNXSgt96xPL3Cb7UHQGKRd2N8bpqVe0
 YFSsrd3LEVswisxTAIzkIdVYvQNtkPhH6pBRlbbI3RiaJ1N/iLU5UTF5Ryi7bd9sg5o4e4c5CGAjGI
 GnX8os6dWBlsfaZCgR9EMJr6szIRjyPlqvSN8iSeNpYdBhT7kfxhrTnRfiSIHzjVhe1Re94rzi+74H
 hOqm7JplhUOTBlT+0h5EUaUKPo9ywReTbZseoJbZbl/px/he34vURUqtFWHXi7yHVACZ+qk97hIp2n
 Z8+fa1H1gG3oAE5ebW2P19Tx0EbZDmTgT9HARMP2ryNONbEuEEq2WSSWNyZgloju8gzBB/+5TXJrf3
 XWTSI3xP1UjIxWKeBIm41DJ0iiuZl+rHFp95rfv5lEOUkR6xl8f5WbBFR6NU7aJKptewbC5ZD0bndK
 /qbPrEkrVh9LJgadhJxLHK0Fugi2baKtbZXSOL89x7kLcHpcv8G7u22wbJGQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every g12a-aoclkc ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/g12a-aoclk.h          | 17 -----------------
 include/dt-bindings/clock/g12a-aoclkc.h |  7 +++++++
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/meson/g12a-aoclk.h b/drivers/clk/meson/g12a-aoclk.h
index 077bd25b94a1..9d6eeb24ae0c 100644
--- a/drivers/clk/meson/g12a-aoclk.h
+++ b/drivers/clk/meson/g12a-aoclk.h
@@ -7,23 +7,6 @@
 #ifndef __G12A_AOCLKC_H
 #define __G12A_AOCLKC_H
 
-/*
- * CLKID index values
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/g12a-aoclkc.h. Only the clocks ids we don't want
- * to expose, such as the internal muxes and dividers of composite clocks,
- * will remain defined here.
- */
-#define CLKID_AO_SAR_ADC_DIV	17
-#define CLKID_AO_32K_PRE	20
-#define CLKID_AO_32K_DIV	21
-#define CLKID_AO_32K_SEL	22
-#define CLKID_AO_CEC_PRE	24
-#define CLKID_AO_CEC_DIV	25
-#define CLKID_AO_CEC_SEL	26
-
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/reset/g12a-aoclkc.h>
 
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
index e916e49ff288..8fe7712fb12d 100644
--- a/include/dt-bindings/clock/g12a-aoclkc.h
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -26,10 +26,17 @@
 #define CLKID_AO_M4_FCLK	13
 #define CLKID_AO_M4_HCLK	14
 #define CLKID_AO_CLK81		15
+#define CLKID_AO_SAR_ADC_DIV	17
 #define CLKID_AO_SAR_ADC_SEL	16
 #define CLKID_AO_SAR_ADC_CLK	18
 #define CLKID_AO_CTS_OSCIN	19
+#define CLKID_AO_32K_PRE	20
+#define CLKID_AO_32K_DIV	21
+#define CLKID_AO_32K_SEL	22
 #define CLKID_AO_32K		23
+#define CLKID_AO_CEC_PRE	24
+#define CLKID_AO_CEC_DIV	25
+#define CLKID_AO_CEC_SEL	26
 #define CLKID_AO_CEC		27
 #define CLKID_AO_CTS_RTC_OSCIN	28
 

-- 
2.34.1

