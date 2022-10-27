Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A960ED2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiJ0Awm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiJ0Awj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:52:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E19ADBE63;
        Wed, 26 Oct 2022 17:52:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t25so263734ejb.8;
        Wed, 26 Oct 2022 17:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybHFtQFlusC5omeu3YXQVOdQ/jnkll+XG3jlSuR3Z1Y=;
        b=JRZ5QquTA8oO61xvU2RT9SeJAOYaBWyQ2l+uIIixfdmu63ujGYkC46hk5q4a+6b4SM
         sWjQyS+RR8cE2sJOlq3cDGyLhewgzgSgCxgCa1ok5Xo2T2bqe59lPXBQdQjHcBpDbLfV
         7kAGDXLfNCIJy+ooMHI8zIANbWDh9H51ioEx4ySqhg3eu/7xs/oxJ6JLePP44H1RpDPv
         T2NWMQuTeHDBO5593g5jkbnY+uVT+Ih6UlY+sdT0VQE4tWcxg6LkRAo2XtEeRTt4Xicp
         RtcHZnKDztvyoWvx33XPB+TjdY8Dt5pJyVZfkHCmwQo1gEp+KaG+3PExt3OGOP/JCJ4L
         thUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybHFtQFlusC5omeu3YXQVOdQ/jnkll+XG3jlSuR3Z1Y=;
        b=sXmbDij9ZNUveGeXyWWAO6cZIG2wmzmf06yuBYsOgin+Z5UMYCNMdWgD76Yp8AGzCu
         6mb7rHEWGqr8JUBVlPTRx4PfiVp3sUw5qEqh57HtlKygy683Rt3ygS0L/4PtQOOFlIHA
         5Zhop1h6vve24tiAnCHtWEcBTHzUMaCTIMICnbTtC3O0YglcfNauWkmwKKlaqwpcFN9z
         lt0G0R5GuFyEqXGIvwJZcF16qZC4S1Er1IXyt/bD1zpoT6LPyX1d8mt/AjdQkRijSCie
         9IQWmt/FwiHwa+nnBV1gR/tQrUxKa2SCR3rVWgb0GkmW0G6MkQ2Q3sxG/8eAp5Jv00PU
         1gMw==
X-Gm-Message-State: ACrzQf0x/QKv+gY2rNGZwM6mUEebYS4M2FFQLDVsPnI57rwn2lsAnYyq
        zHmnzazvLVC0s1cwfdGmCfU=
X-Google-Smtp-Source: AMsMyM6+8P4B6n5+dZShu0ejqohqVlGyYoGYsVAKNdJ/Y9b8hANB/L2EB3YodE1KW9Ov62LNLFPiGQ==
X-Received: by 2002:a17:907:3d91:b0:78d:f675:5659 with SMTP id he17-20020a1709073d9100b0078df6755659mr38947525ejc.92.1666831957083;
        Wed, 26 Oct 2022 17:52:37 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b00781dbdb292asm3677685ejh.155.2022.10.26.17.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:52:36 -0700 (PDT)
Message-ID: <939d9e2c-4431-5408-5884-12d328b6a4f2@gmail.com>
Date:   Thu, 27 Oct 2022 02:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/4] dt-bindings: timer: rockchip: add
 rockchip,rk3128-timer
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

Add rockchip,rk3128-timer compatible string.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index dc3bc1e62..b61ed1a43 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -18,6 +18,7 @@ properties:
           - enum:
               - rockchip,rv1108-timer
               - rockchip,rk3036-timer
+              - rockchip,rk3128-timer
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
--
2.20.1

