Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47CC638F77
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKYSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYSCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:02:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B1DB21;
        Fri, 25 Nov 2022 10:02:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id f18so11930974ejz.5;
        Fri, 25 Nov 2022 10:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6RjLtrdo+ScGm7pjZK3Sr+Fc1zKiBe9mhxGw4UGkKk=;
        b=n+IYRZPLWxB7TLgHjJB945226UUM747+G75kptxXbOlV4wq9bEgqApLefT4+EtvqYD
         3MkmP7gED/9MiD5GTB++vQwhDUd1howa8sCJqtwJBKHyoOYNh+rhkLdqg5EQdTA6YgF1
         TbXmUR9oJSh4bOdcLv9EcCIk8OCErnEwY8VBlPKrBsBV3oLrX2nHxdbDuR7JaLLPQFKj
         /J8HRh+NBXyuBjqLb3Agj5hWQ8jYRPaE/3UiCQUzVF+gLng6ktdeWKVZs1z9eh8EeHNq
         276aemFu3yeHmOdlwlXYuPqEKu1Oz6Bn4CPlLxt03FJLdCfiFGz38qpn53Vui+AjYMo7
         Xptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K6RjLtrdo+ScGm7pjZK3Sr+Fc1zKiBe9mhxGw4UGkKk=;
        b=ZTBkGK3oCIPdinLM/Y6gXqDTWXrS234RNSdLUWDFmXnVUanTItVRnhZjJC9tNoatdj
         P+s9gDjYIiT0nIA3rLZfskZ3rLxGc3hryOqiyPIgze3WSAg7zoX6xjR4mrgRf1RNj8J9
         t/B8TWE8264YFuY+rYslKwTF0nn2retr77dGl4i9FbBqp4mETUNwmXHLliV8yDfzGOMl
         h63YKE0mQnRZcp1SeJgNuJ/uWSTQbB2nhDcBBN88pqHK29drZmXdkYWbZ9w5ktsfiLEM
         oqZVvUBOp1C1ZSitB4umKnVVpvl7vdG6ifBr3iz5d14fC9dCI7KMjFsmbTgHeHD7MkdH
         +BjA==
X-Gm-Message-State: ANoB5pn6cfeyrCUwK02mUC2uovopDL9yMaXgLY9Qo8UMGxH5tKng8tBy
        4C9M3NPh2wGVNnUQdXWc77s=
X-Google-Smtp-Source: AA0mqf6u6ILP2rzOMm++8C87RFVzocSs3tw5fx8sFGo0Gq4MOLdpgPT/cqB4RuijdbGWbj2Wec1tjg==
X-Received: by 2002:a17:907:9841:b0:7ae:c9d4:7073 with SMTP id jj1-20020a170907984100b007aec9d47073mr32793669ejc.711.1669399350879;
        Fri, 25 Nov 2022 10:02:30 -0800 (PST)
Received: from [192.168.178.2] (dslb-092-072-004-196.092.072.pools.vodafone-ip.de. [92.72.4.196])
        by smtp.gmail.com with ESMTPSA id eg23-20020a056402289700b004623028c594sm2039196edb.49.2022.11.25.10.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 10:02:30 -0800 (PST)
Message-ID: <d8b00afb-8c60-fe9d-dad3-280a0e0254ef@gmail.com>
Date:   Fri, 25 Nov 2022 19:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   =?UTF-8?Q?Otto_Pfl=c3=bcger?= <affenull2345@gmail.com>
Subject: [PATCH 4/4] dt-bindings: display: panel: mipi-dbi-spi: Add io-supply
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Add the new io-supply property, which specifies the regulator for
the I/O voltage supply on platforms where the panel panel power and
I/O supplies are separate.

Signed-off-by: Otto Pflüger <affenull2345@gmail.com>
---
  .../bindings/display/panel/panel-mipi-dbi-spi.yaml        | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

diff --git 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index d55bf12ecead..68cbdfab5438 100644
--- 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -22,8 +22,9 @@ description: |
    The standard defines the following interface signals for type C:
    - Power:
      - Vdd: Power supply for display module
+      Called power-supply in this binding.
      - Vddi: Logic level supply for interface signals
-    Combined into one in this binding called: power-supply
+      Called io-supply in this binding.
    - Interface:
      - CSx: Chip select
      - SCL: Serial clock
@@ -80,6 +81,11 @@ properties:
        Controller data/command selection (D/CX) in 4-line SPI mode.
        If not set, the controller is in 3-line SPI mode.

+  io-supply:
+    description: |
+      Logic level supply for interface signals (Vddi).
+      No need to set if this is the same as power-supply.
+
    power-supply:
      description: Power supply for the display module (Vdd).

-- 
2.30.2
