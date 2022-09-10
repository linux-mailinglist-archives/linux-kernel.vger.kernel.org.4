Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244695B47FE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIJS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 14:56:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E7481E2;
        Sat, 10 Sep 2022 11:56:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so11411209ejy.5;
        Sat, 10 Sep 2022 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=3PplGYcFwa58sgJyq0s6GKaVr3wUW1D0jH7TKWDQs/0=;
        b=qWwmi4l9tkhs+K+eUHh6fIlNVbj02RW1SDpguvVyPuvThzzfNg9bg2OztEF1cYiRTc
         s5H9IgSqdamsiXQz/SkWKrUKZqxF5WgDo+x7IWiMS6thkN0YtolScBTDH1lZLNQJYxsI
         g/GWUO/FqZq9YixXfYdM6Si5IlRsN4IU1G8e5H4Fq42KGQZnEAaqKLWYnSWx6A1KdWFO
         PyiTSUaX0lrZ0K8rlKFMaR1jpnQVutklE1v+xncU3wblKEgj8qiVEdatVCyWn9qnEa/l
         A4AeCDK9ZlWhr1t4SD3CTNS3qXjz6cNlJC4VDYrGLbJYefMw5dF8j0xUZ42lVAO5KPR2
         0QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3PplGYcFwa58sgJyq0s6GKaVr3wUW1D0jH7TKWDQs/0=;
        b=y8m6rrrSroreOh8k3PCywa/ra/zFeOL8i+sgSZnXldhb4wtWEBOwx64cltLHzJ4PWD
         ef0glHNndAY777R0iMtUPUtbyCmAnyNhobHTyfIG+O+lr9d8m/NYW1X3CCA9bv2G4Iv5
         ctxCY9n5Ume5pIyEekbCWXgnqsAeljPTBH9vLjHZz8k29GCvqJpvqUsrZXB2v0bs+f0y
         gBUEiWSq8s2K1b6DD1vSDiNS2f37QsFoBIEHeTT6hbbDvzhzp/hdzlDkWOI44pR1cbI6
         ujla5ld4GdHziClsqLNpLWQVPKIRVlEHtVcYNlG84kCp/7QyXghBsMsFOPCRnF5MtFen
         2r0A==
X-Gm-Message-State: ACgBeo21fS7+hWR2LHEqotHN5qsyoEY83mCrb+WXl71x/W60t+9LJWKC
        5bpuMyCCBckuf7cMdlYuV9Y=
X-Google-Smtp-Source: AA6agR77n+mQgZTAm6u67SKl30loSrOlLzz5oqTb2H7JEQJz++WyB3Qxbiq6/Hgq/4xQMVJbsUKIrg==
X-Received: by 2002:a17:907:96ab:b0:779:b7d8:41ba with SMTP id hd43-20020a17090796ab00b00779b7d841bamr6352676ejc.449.1662836190148;
        Sat, 10 Sep 2022 11:56:30 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0072f4f4dc038sm2045125ejo.42.2022.09.10.11.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 11:56:29 -0700 (PDT)
Message-ID: <64d03f6e-c578-3155-e3fb-53dbe53573eb@gmail.com>
Date:   Sat, 10 Sep 2022 20:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: spi: rockchip: add power-domains property
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip rk3399 TRM mentions that pd_sdioaudio includes
sdio, spi, i2s and spdif. Add a power-domains property to
reduce notifications with spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 52768894b..66e49947b 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -82,6 +82,9 @@ properties:
       where the "sleep" configuration may describe the state
       the pins should be in during system suspend.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.20.1

