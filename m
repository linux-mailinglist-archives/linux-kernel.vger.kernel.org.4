Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EF6A10C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBWTqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWTqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:46:35 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DE4A1ED;
        Thu, 23 Feb 2023 11:46:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ee7so31237516edb.2;
        Thu, 23 Feb 2023 11:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LRpyWijqVyBIlwSuNRfzUQ+ZyqaAsfdjoJlUPAZASg=;
        b=eiKKSe9UeePiVEO64ojOtxKiPLmGaZ/nMjseZGtFE1mHQ/dw/eAfDtPDodcqVozXUA
         8ouHsxCJDV/s9IRvv4PDdc+v3FSNXivEqL48uYolADGle5prCL6/1cVeB+2iC4rY2Qtg
         ju8Tb28IBNNKtcX810XhnsoV33LxMT/2YBLUVwr90z6SHsyB0XxvEWB4mjy6l5ZS2B5u
         8imWQ5oG70AF5JpbyjhPLKN/9aO2P0QFL4zqltsEVWFAtji6yf+9IuJS2t+K1YQFIy4M
         yaexE1Dk/dyUSLhc0m4Wn7nXEEEYmxSy22sJYCXYK8vmuuVlpFT6hCwMeJCERZYrFFAY
         UGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LRpyWijqVyBIlwSuNRfzUQ+ZyqaAsfdjoJlUPAZASg=;
        b=Y7w2RgUZawc5cqTq3OxWLWj90+9iOgrXIoozo6HNaaY8/8bzxEDNP07+5M0BM1TkIf
         eL8r8CVDqiOCO4vemQ8MptB/4AH5fHvm6RJzCXa2F+vBcDWw2sc/DMAVodnc52nbHv9Z
         lwjKUIK1ThB8Fc5qOiM/LUhpOphAAwp5hnC4xgPvj9mUFrGR/qVVib8zxrMCzryNNOsc
         OH006YExXVPMppatfzVneJsoRLvyR+1MuVW+BTJ6k6SNwfKv8aJ37QVOMypYodNq0OHr
         IHp/AuxUQdiZi2aqAHenyOUb7qv3Ha46IIaRZLtZPxXZNgLaaYJY5EcNS+/3cFcNBCmt
         oALA==
X-Gm-Message-State: AO0yUKVrf8AnZZyYipgPJ+MTmq4eqO1z4PYrTsQGfsf5kluC/blF+MQS
        Np6tRlDRhWHzXtkxxWqJs3I=
X-Google-Smtp-Source: AK7set/L1t843g5XkUkLOvox4r8KPibycedF4hiL/gNFQX5exFdwNgcdM0cnvDhKLdr/jDZ0jWjWcw==
X-Received: by 2002:a17:906:44b:b0:839:74cf:7c4f with SMTP id e11-20020a170906044b00b0083974cf7c4fmr20087502eja.8.1677181591729;
        Thu, 23 Feb 2023 11:46:31 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id mi10-20020a1709071a8a00b008e938e98046sm1960676ejc.223.2023.02.23.11.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:46:28 -0800 (PST)
Message-ID: <774d712d-bcdf-677a-2d9c-a49ed829e965@gmail.com>
Date:   Thu, 23 Feb 2023 20:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/7] dt-bindings: gpio: rockchip,gpio-bank: add unique
 hardware GPIO ID
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
Content-Language: en-US
In-Reply-To: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a unique hardware GPIO ID to the Rockchip GPIO nodes with
the "rockchip,gpio-controller" property to be independent from aliases
and probe order. "gpio-ranges" can't be used for that, because there is
no semantic restrictions on how they are set up.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

See discussion:
https://lore.kernel.org/u-boot/CACRpkdZx8EaSFLeh4vruRsdC+Sx_ieBiKmuE7t37zhiYqtS3WQ@mail.gmail.com/
---
 .../devicetree/bindings/gpio/rockchip,gpio-bank.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index 2e9a5179c..39ac41e9d 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -52,6 +52,12 @@ properties:

   gpio-line-names: true

+  rockchip,gpio-controller:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 8
+    description:
+      Unique hardware GPIO ID.
+
   "#gpio-cells":
     const: 2

--
2.20.1

