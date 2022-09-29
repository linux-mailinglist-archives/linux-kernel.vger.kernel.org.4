Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CBC5EF71C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiI2OEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiI2OEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:04:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A201577E5;
        Thu, 29 Sep 2022 07:04:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 13so3033649ejn.3;
        Thu, 29 Sep 2022 07:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=lOIr10qng5aLPZ0etG+Hq+3fdw3/2uRq+u/cuL1bsUo=;
        b=pP4ha6IQQWSyGXsRFLlusYzCDGnGAoqkhrT0gaC/E/ELqjMzuZ1xCIQObAzd6VtWCz
         WYVa8gavgTY4U1qICCz2uF837VFbIz2wXktnZhqn4Pa8sRLWiHVatF/SwCy+nj595AOu
         C6Q8fzDACB64FKeRZE3kNR4TL8ph+t/boPeJXU1ZpCkkZaBSVuQ1eqI5SUrcB9EIUphy
         htXn2i52Y8eo5Y4lfnTN2KqEbhbkxDE8N/PqOWRKGy5lO7bfKCTRBrnHh/9W5DnLi+/J
         ObscbDs0p0P95mN893mIR0JC4xdHEfKTYfmBdq8c0Qf6zMZq/2p8ULwumQsEKYh/Z7Vp
         /HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=lOIr10qng5aLPZ0etG+Hq+3fdw3/2uRq+u/cuL1bsUo=;
        b=xo7weqSHOb+sRaUbCcKSjjBMqxmCCphz5m1LFg7o1/dQOwuEVYPsZ5odhB4qiu7YK3
         YQdBzCrInAsqQX2wL+o86ZBKsPWUZuF29SomCMdUhMMDms7eyJBY70wF9md06csvuwwH
         /DqpIcgWTLcVWuoWacbyj5CZt35ITFbKWLNyu8tZfy4kpIZ/r5VxHgB9YvPiv5bGSYtd
         TYPrRxwA8biLzGfUqAsR95x5cruni+qWfc9oMB99XgqmENGAY5ugENsUmAe3P1WHKqN6
         LPNwNitPUJLjg20GclQt0/L+axW6WrBO19i+U897xtYdvTGecIxqlRQc81uoygAzGABj
         fPZg==
X-Gm-Message-State: ACrzQf14nQH4v3MMtResjWV00EBTugF4/gJmng+j48k8KPiooW35vNNw
        xzoC7BjG5e4U23yP83Pa6/Q=
X-Google-Smtp-Source: AMsMyM5RqEf6W8++5Wd/dZ8xiTnvX4qBJZfJOg/gc26XMHarfk00dJSZvruYtjBdG2kEV798u2we9w==
X-Received: by 2002:a17:907:6d03:b0:782:abba:936c with SMTP id sa3-20020a1709076d0300b00782abba936cmr2857513ejc.758.1664460242976;
        Thu, 29 Sep 2022 07:04:02 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y4-20020aa7d504000000b00456d2721d93sm5411275edq.64.2022.09.29.07.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:04:02 -0700 (PDT)
Message-ID: <94bcb278-7bb9-d173-497c-fe12682c4a17@gmail.com>
Date:   Thu, 29 Sep 2022 16:04:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts
 property
To:     heiko@sntech.de
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com, wxt@rock-chips.com,
        kever.yang@rock-chips.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
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

The Rockchip SoCs have 4 or more built-in PWM channels.

Configurable to operate in capture mode.
Measures the high/low polarity effective cycles of this input waveform
Generates a single interrupt at the transition of input waveform polarity

Configurable to operate in continuous mode or one-shot mode.
One-shot operation will produce N + 1 periods of the waveform,
where N is the repeat counter value, and generates a single interrupt at
the end of operation.
Continuous mode generates the waveform continuously and
do not generates any interrupts.

Older SoCs have an interrupt for each node.
Newer models share an interrupt.

Add interrupts property to the pwm-rockchip.yaml file.
DT describes hardware. Rockchip PWM driver support for
interrupts might not available.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index f2d1dc7e7..f7634069d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -37,6 +37,9 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   clocks:
     minItems: 1
     maxItems: 2
-- 
2.20.1

