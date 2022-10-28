Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3456114D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJ1Olg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiJ1OlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:41:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF640E9873;
        Fri, 28 Oct 2022 07:41:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b2so13440076eja.6;
        Fri, 28 Oct 2022 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SVxJ12c1A+xM0aCvd/9/hnx+Wg8Tkv2AsxQ0FKrV7Fo=;
        b=e8PuIJKYvVwZG8pMIVdsuACZ9hgCDCdCOOm6qZ9QEXRFloflT70eDzvCkEx02u8Eda
         A9wmqY1bfVxFQ7oZGfaGC/LFp3NhBBLwH91Llp1msKGVILazbrSIe6cz1PnC2rbhAWuG
         Lap2dQLywubkbNeFVdmBrX4fKMuAJfbKnLCuICMcD8nqoeoeEBFL6zO7Juarwj1CcA4A
         vaCof7MQlpnqykdvT6ZcdfNYA4jnC9IAuW5VPOKgSFKZzBvnU3qQta5s3ZkcRxzvG5H4
         5QCPzg0derVXMseJUguLo1RS7bwdblG31/bqP9a92i8FRKom98aLXGBHzvsYcTDY88Cm
         URYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVxJ12c1A+xM0aCvd/9/hnx+Wg8Tkv2AsxQ0FKrV7Fo=;
        b=bMG3LW+73wtJZfc0tj5VtZWnJWYBass6XvuXNdpvQlAJHPQtbLFosVP85D8LSrQQO4
         +0x2aa7zjhXhqUPL5C3GyEns0slJBqInACNrPMGcIExkFVZFdCT0MRYIxWexuxK4Wx2M
         9b2RDi/RY6Lm+UIp5F+EQpz9ZjulwLxjiVIQiGpS//RUg+CTU0MD/pdshuVT+wzRKVWS
         McMrdWebyIFxXi3zy468WKYyTD+XrVG29Ikuj1OyX0XpSZFV+YsEWbs1I98IHGV050Sg
         JgmLh0aBp1ey1Den7pIY7N7jEQzaFg/HOVap32cSwa0opK0T130Qrvk7XNLi5egtun6G
         uOyw==
X-Gm-Message-State: ACrzQf0vKRMk2Ty7OzTXsuDBL6TmIt83CGRLSmE+l2SBuQL/89IVpzxR
        DXxl1s50t0TrmT5gUosS8zA=
X-Google-Smtp-Source: AMsMyM7HXQ72bbrXuPMgRLSwI+e9C5ONtGcWO383f1AvM3xeoYFRDCq0hKSnjGHViuvp1OXIqoWYtw==
X-Received: by 2002:a17:906:730f:b0:791:9b75:2ca1 with SMTP id di15-20020a170906730f00b007919b752ca1mr45292306ejc.140.1666968074370;
        Fri, 28 Oct 2022 07:41:14 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id my7-20020a1709065a4700b007417041fb2bsm2237114ejc.116.2022.10.28.07.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:41:14 -0700 (PDT)
Message-ID: <dca18633-54d4-1264-725c-213d82fdf1c5@gmail.com>
Date:   Fri, 28 Oct 2022 16:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: rockchip: Add Rockchip RK3128
 Evaluation board
To:     kever.yang@rock-chips.com, heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <e83964fe-ad87-0905-4586-e235757c6b2b@gmail.com>
Content-Language: en-US
In-Reply-To: <e83964fe-ad87-0905-4586-e235757c6b2b@gmail.com>
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

Add Rockchip RK3128 Evaluation board.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 72bf2fbfe..e81d9d1ef 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -662,6 +662,11 @@ properties:
           - const: rockchip,rk3036-evb
           - const: rockchip,rk3036

+      - description: Rockchip RK3128 Evaluation board
+        items:
+          - const: rockchip,rk3128-evb
+          - const: rockchip,rk3128
+
       - description: Rockchip RK3228 Evaluation board
         items:
           - const: rockchip,rk3228-evb
--
2.20.1

