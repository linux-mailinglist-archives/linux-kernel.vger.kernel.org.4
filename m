Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F581702636
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 09:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbjEOHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjEOHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 03:40:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA241A5;
        Mon, 15 May 2023 00:40:27 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30644c18072so8121501f8f.2;
        Mon, 15 May 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684136426; x=1686728426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9M/xlGjj8uezUUI5VU+MiWkSI0a+AM38qzNIvvv+aI=;
        b=Uk5lEy8jAy6CqyhPyvb7mqv6z8FznUUWvUp7CocpKcoWwZsily3Ef6JdAwnEj+QW6s
         rSV1lWYh6uFC5tNgrqMMhWl4vepk+Fbeda776wsRgbbouw/mAKyjLrWYzHXct8c9INVk
         GH30GV4fI8h+SHkml5mPDjuuEsdsNxIiv1ifZsyLHlQOWjtMHV+dkiE0G7g+zFE0Cm8h
         Ce2zkvC+F1MR8RxR30JhW8ThGz6mzxsfHBwmCUbejORLxwGyGxQ0IK1y9PBY1zA4re8x
         HgAu1aaVkKVH8b5GTj3MpdTl6UgetHxwjTw84/a85FDGoGr8dQeLX1J0i2hGfapQx8kO
         8VOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684136426; x=1686728426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9M/xlGjj8uezUUI5VU+MiWkSI0a+AM38qzNIvvv+aI=;
        b=OVD1U+GCDob1vPGRorpYoPucEjjxOVAoCM/QqlY12nUVoTPEAlqhEwmazWQuKZ4cSa
         vBHzgfX6l/yd9zZd9K1TVCMP6/ugNwebHdKbW1dWW5ZuzgI/DJfD6c0qGBrX6F5f9kPz
         IpYdllaLdtt8W/9mZ15z0mnKxHSkmyVFQWrlvRwq03VMIncn5kUe3nLJoTIQNmTw3GY1
         5y+c6KSbHQC14IPa8ukh7GKBQltv8FhfSdo/zh9rYl72NC+KQ7kf0L9p/HSeHsLbmMs9
         YpUDF6CRoDTEaHikaEGioErU5s5PFVDv2kjH2o5mHAeG6nJ0yFYxVxxsuabciPpQqUA1
         XcTA==
X-Gm-Message-State: AC+VfDw6eAByCmg4UfzefxMGeZO5jXKyBYc35/iO/wO1LtjvTNPjbRP6
        JWrKLRV3rcIcrV9frKTgn4qCDhJHVrQ=
X-Google-Smtp-Source: ACHHUZ4ncHlBCVI7q+Rc6+IFosohfQINR4EVgYffbNmugjX/8tQE1/uxTttYptQO/BuZfuWzXJ5gBw==
X-Received: by 2002:a05:6000:100a:b0:304:77a0:4ccb with SMTP id a10-20020a056000100a00b0030477a04ccbmr21980975wrx.2.1684136426023;
        Mon, 15 May 2023 00:40:26 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b003062675d4c9sm31476370wrn.39.2023.05.15.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:40:25 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: vendor-prefixes: Add ESS Technology vendor prefix
Date:   Mon, 15 May 2023 08:40:20 +0100
Message-Id: <20230515074021.31257-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
References: <20230515074021.31257-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix "ess" for ESS Technology <https://www.esstech.com>.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---

Notes:
    v1->v2
    
    Add Krzysztof's Acked-By

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 82d39ab0231b..95c42e32e02e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -438,6 +438,8 @@ patternProperties:
     description: Seiko Epson Corp.
   "^esp,.*":
     description: Espressif Systems Co. Ltd.
+  "^ess,.*":
+    description: ESS Technology, Inc.
   "^est,.*":
     description: ESTeem Wireless Modems
   "^ettus,.*":
-- 
2.39.2

