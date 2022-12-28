Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9F65872D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiL1WCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiL1WCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:02:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D5FD12F;
        Wed, 28 Dec 2022 14:02:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vm8so34225632ejc.2;
        Wed, 28 Dec 2022 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gQqaQ/wQbcI4YtddNbhttJQQrklrXjxNeRKfhUI3Hs8=;
        b=WEoYhhH4lBZb915wZqO2GOv4mkQ205jIX8gGYF+8Uwe9f5l4D/z7uIBf/Nd0mFn78s
         wzgClnhRyCHJvA/mrmbLRk/tPo1ausDMZBdvfWWyIgGduwc8TiPguV6qrPfyJkkb6hTK
         v1aoWzopfiEX/FYddIkftdy3wbQV4b2+1tvo5H3Ibp0oRFky8VZjRJtQo+gbDhSfWHmC
         ge8rvuubZKqgspwlx1deCF+Rp1TG8jFrvT1GowN8opm1bMpKbC3CqGDah8GXSuaDk+Tq
         o/X4bWyBPDbT9dISRfLZp9AE3GXS7rGl/MpbBzuRVB1S2A8FuUo5JSHVySTwH8IPk8yu
         2q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQqaQ/wQbcI4YtddNbhttJQQrklrXjxNeRKfhUI3Hs8=;
        b=ku5W+ApIO4Gdlpj7dZkxkETlOxnEuyATaFWLjoCRGF+pwIEoWUTeR+f9Lg5glHv12v
         0u8dQ2HVPY5Xyljl5azPCrO3MhRpKQNUnUgGjrPI2Ot+pdqD9iiofNo3566/96cmweQ7
         RUfqJuZoYcOn4nxdrdLy3yFNgBLJM21aQU2LQW6Fdk9y9Lj6c3OmIpYT7ru9YoXAILCc
         srn1sEkylSDDhBmPEEGHbZSyrwW9HNJl1P+3QwvnlVvK6iXuTS/w89X+DIxURJ2AO8u3
         goaYCSJUK7VIRxJ0Ibj+F/vCj9KmhTAlFaBZJtrnJn4Hkz1hIpDvb1KtO8sOe4bR6Vma
         iVVA==
X-Gm-Message-State: AFqh2kqMR9BLtWbd75XUVKivUDq4l+R6SkCDi5BzohadjGyzcRnRU/xS
        SRC1qbb95Lp6uPQC9QOhnzE=
X-Google-Smtp-Source: AMrXdXv6lktDsWMmnORsKNQ5rX8w2xCV0GkzdA+11PmuhI3tQsXEIFCqkIqh4S9j1z9kn3D+jJsoFA==
X-Received: by 2002:a17:906:524b:b0:7c1:5098:907f with SMTP id y11-20020a170906524b00b007c15098907fmr21809702ejm.61.1672264964572;
        Wed, 28 Dec 2022 14:02:44 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906308200b007aec1b39478sm7846616ejv.188.2022.12.28.14.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 14:02:44 -0800 (PST)
Message-ID: <aa942b16-1135-c202-d44a-d25f1f82787f@gmail.com>
Date:   Wed, 28 Dec 2022 23:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: soc: rockchip: graf: add
 rockchip,dp-phy.yaml
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
References: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
Content-Language: en-US
In-Reply-To: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
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

Add new converted rockchip,dp-phy.yaml to grf.yaml file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 7ac9aa5fa..36f6d85a9 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -96,8 +96,11 @@ allOf:
     then:
       properties:
         edp-phy:
-          description:
-            Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
+          type: object
+
+          $ref: /schemas/phy/rockchip,dp-phy.yaml#
+
+          unevaluatedProperties: false

   - if:
       properties:
--
2.20.1

