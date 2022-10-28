Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046A6114DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJ1OmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJ1Olt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:41:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278D1EEF1A;
        Fri, 28 Oct 2022 07:41:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so13376041ejc.7;
        Fri, 28 Oct 2022 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=neowCr6oVr3vuPg1WjdiJZukZ1wtscf+gZ4yxqYQOrI=;
        b=SHZTjrmp9L29dDhO6NAh0ZPr0eez3l/Oxd5GjIFS18GwLCGLpjYvOk0miK/lOxzIZQ
         7Bb0siqxcEdzp0W3oRSh8Io0s0AMwR20GENJHCne0egP6cqfBfYMFWnTNwuNsknN2aC+
         j0Q4cFeH8clH73Ej4qqWRQJYb+L96vPXHJEipua3ZVlsj3PfPZmCBQ/WXhXyZ3m9xczM
         DnRwgdP+imsiKs/e+bW4TZfq6EaTivmNI7Dk5OcQ+gn8+2ezHmFAKUmX2SEF2zIADMr2
         wdF6cm+Q6pp0Q4MH8TVgsUtZkhsjPVFNvbCg3GNhUqtB1ST7RcDl8ErxvH0GcqHn14OM
         9uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neowCr6oVr3vuPg1WjdiJZukZ1wtscf+gZ4yxqYQOrI=;
        b=zBeO329YHJ41oA8paF4D1e+B7GFsrW6gJAtjENqLbq3a5gPYseTj1xskHpIE56MfC3
         ri+8ElSITmWdEct0KoVX2rhHkYsaC/eGLWPiD+squQC9eh6DufPsW6+SlFPV/jyCxriJ
         NXdhcN8x63TzEbVV83Nqx9HorfQ5Xc+Q1360XstWVXAznyieqJLVpZ51YEKEst7Up9e3
         uByliYxO0PlASOHPdap1u/YMxpYtRXzXjvcDK/jPcpRzYWQaAtFVoXzhXgmZYCk1b02k
         3ay7cZVCCvOdA4NFtJLXRXq9IV+wm9l/SSOW2f5IyVejXID1Yg9BQ0USo/eJcFRzoVeR
         ML0Q==
X-Gm-Message-State: ACrzQf0cgpKObLLdgnvZjHVFs2EA50093nwdXBXH6jcl10Z7zl1/qU7D
        IiiTK98sTYBFKZKLuLP3wooIG//hNsg=
X-Google-Smtp-Source: AMsMyM5OBcO+LDLOQHxISLu95CbLOxbNR+n9EWCWrV/yBJI/GkvE+GKGE/5SNpSkKQ4JuXH8kKV5yw==
X-Received: by 2002:a17:907:8a24:b0:78d:cd60:1022 with SMTP id sc36-20020a1709078a2400b0078dcd601022mr46727644ejc.384.1666968092017;
        Fri, 28 Oct 2022 07:41:32 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh3-20020a170906eca300b0078dd4c89781sm2239439ejb.35.2022.10.28.07.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:41:31 -0700 (PDT)
Message-ID: <0e57f38f-bace-8556-7258-aa0b3c0ac103@gmail.com>
Date:   Fri, 28 Oct 2022 16:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: timer: rockchip: add
 rockchip,rk3128-timer
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

Add rockchip,rk3128-timer compatible string.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
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

