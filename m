Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2012F60ED2C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiJ0Av5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJ0Avz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:51:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C480DBBE2;
        Wed, 26 Oct 2022 17:51:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so298745ejc.4;
        Wed, 26 Oct 2022 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zKQQQwNdmP0I/7sbEgciKRJH80dN4WVefIoocRKiN3s=;
        b=UxmhUtWDYn/Ae6ytp6eFL+jck/3SwSMRCNKSTifMbbyR3oX9qwJCmtQ/PUcfWiLcp3
         l00zgYXE+C16PItqTNArXlv2jbXvYzk2LDX8aeKZgP64K+H5t9xb+CPWLCE9qNZ4nLvu
         yi0mfrtoI/WKUh01I1UMoxsOrW8A4tt86uRtGOim8VxCwRrcRj70bCydOewQvh0yRVH1
         Vtdmz3BZ1mr1XDpYQ2eBW30Ut1eLE6BF8ABZukZn7fHVBpcnnQ9ILQXIYrFqH4roK9Iq
         2qgJVdyYCFaGPc3AmlaANX+/aRGrgfaTdoLcD4eMwRXg4uFmikTok4HkphdvWDCfwm7l
         +YWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKQQQwNdmP0I/7sbEgciKRJH80dN4WVefIoocRKiN3s=;
        b=u9O+gjTgrrkgD2HbyY2Fc8rrSo33+ZMS0fXL4SaKtPc+Jt2bokFjsORlp/kevKSQKw
         28YkZRUIkDS00zL3LEe8BEVLI8Too1V+RVjylaTk/lF5sG12tjdnZPJmcbajV3KV1t11
         eUpGPYisXxGmy0caBIVpVBZjeSWJXqJXv4QfbcpzLb2wgQ4HG6/G/QfFt8nEpM7ScAxh
         AHf14tW1NVpZtdpbNne2LzO4FE2zxtsqKNx6ZMbk6qcUeCoWXl97i9vpQ+Sof69Itgpb
         nZmMSQ2mHUzVXvaB0ESE2wkSuK0UUixlEj/NXQRfdJ0cfZPiVQ1ceVmRg1o3jkCYk9Kz
         AS8A==
X-Gm-Message-State: ACrzQf1a/fu8N0rn9t8kQj5FDV6MKDyBU0vjMHKUtyPP6RiBFyhh1UrY
        JBiE5yJIx4C75IwEp+XMA58=
X-Google-Smtp-Source: AMsMyM6BPmm4tam1hIVqE5W6S7kMh5eIMq81+FlGsJXakTWmualZq8N+pHVhJ18p5o7fy2DyAl3kLw==
X-Received: by 2002:a17:906:9bca:b0:78d:bc5a:9137 with SMTP id de10-20020a1709069bca00b0078dbc5a9137mr41992336ejc.25.1666831913177;
        Wed, 26 Oct 2022 17:51:53 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bt20-20020a0564020a5400b004614fd33789sm60029edb.18.2022.10.26.17.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:51:52 -0700 (PDT)
Message-ID: <16afe467-7b9e-6e99-ca27-7eefce50a066@gmail.com>
Date:   Thu, 27 Oct 2022 02:51:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/4] dt-bindings: arm: rockchip: Add Rockchip RK3128
 Evaluation board
To:     kever.yang@rock-chips.com, heiko@sntech.de
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
Content-Language: en-US
In-Reply-To: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
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

