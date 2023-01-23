Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079AB677D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjAWOH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjAWOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:07:25 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6255FF22
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so9106287wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmthz0s8OqDS9LcQFBQmN/W5rI53YEoPrPOHEdAQ3c=;
        b=rd8QCH4i37iqGUZEDJjNBq8bpO6hkW7AfySdfhBhsEit9scjXNOfovcqO28KeDEW1V
         lzm1jhgBjZd2ugzwQuHB0CnfPElOKEhSTKiN1IpLEnOGQOTCWSsGe0cUKRp5IQuHswaG
         2QGIKf+LMKzqtrcUuUo0ybjz8yA6EuDLaoi1z6TQ534eSLD4+NqEnoaNWg21rfzNWJAO
         psOaPjL6cZ070BmKCj6LOUwEemQ/7s1wXU42l9p7MkrAXR+VwFdHKiCH4ipsB7+9IRno
         x9pEf/4wGywoL+eut/JHhRpD4HTxG6n71Evq6osVx8BWc8UQK17e9woEmzryqK6L9bMw
         gGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmthz0s8OqDS9LcQFBQmN/W5rI53YEoPrPOHEdAQ3c=;
        b=j5Zsobuz8jCnSsM2tRiV0KQECpUnuO1XqKEz9CfIvo6oInZEZdBTg/JIU1SH8aQY4+
         8f8ys4PupMPgMfcKcsPSJ6OkibUNyFC4mPrBdL/wTz1/DMTpoEro64HJviy08PTiAzTn
         crTq/KiPsT8yhz1djEF5VfMm8jOwCGZqp8bPKQrUXiElYOSsayFDiVzMvJdTql7ZYarZ
         NjtrrBLYt/k4C8Ff0MmN0GdFgI5vIhguRT9YrRdlbGR/ZF1GqIn6jI+4Rj3fQ2pOpBtm
         BFATePf22XW+Fcu2/9J8BHwhai008Xqo4lqmUo8T6rqljxwldVZ5NIE1h5lugl2rvlCK
         0/MA==
X-Gm-Message-State: AFqh2koUnu8fBYXvs1/X88LC9DgURCPSDxeqhrZmqf+tVZalne9QsMcL
        GIkLgYKGHI9FRLvWT5G2Kcpuew==
X-Google-Smtp-Source: AMrXdXuiJsbkEguxp4te7mOTpepXLy/AzWUC2thPk4yOb/qOQt775rI9bY38mOM0K7l0QqKy611Y7Q==
X-Received: by 2002:a05:600c:198e:b0:3db:1d7e:c429 with SMTP id t14-20020a05600c198e00b003db1d7ec429mr16925888wmq.40.1674482843150;
        Mon, 23 Jan 2023 06:07:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm13841655wmo.9.2023.01.23.06.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:07:22 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 15:07:16 +0100
Subject: [PATCH 1/3] dt-bindings: arm: amlogic: document Odroid-N2L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-topic-odroid-n2l-upstream-initial-v1-1-1ce5e08039d0@linaro.org>
References: <20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org>
In-Reply-To: <20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Dongjin Kim <tobetter@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed
- On-board RTC is removed
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
are available
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
is recommended or a tall passive sink is optional
- 3.5mm earjack is removed
- IR remote receiver is removed
- MIPI DSI port is added

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index e16b5fa55847..8aa6b6a92c29 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -165,6 +165,7 @@ properties:
               - azw,gtking-pro
               - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
+              - hardkernel,odroid-n2l
               - hardkernel,odroid-n2-plus
               - khadas,vim3
               - ugoos,am6

-- 
2.34.1

