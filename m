Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062906F58B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjECNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjECNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81F75BA5
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2fde2879eabso4837428f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119443; x=1685711443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mgnb7olp8WsAGre/rjyOBmnAxn0zQrK1napy4mUiZ7c=;
        b=LBzLfd6iwdjc82euMrcwbO5DrdxdgrYIto1dXumjAUCDiEeVMkd+p8eIVWqNc5arMD
         TxwhAU12RWvcJ7kjxvmbFSdFmZU/EDCL+eI5OTcA75A+uqEOaaXyMZzWn++KzP3ZXeKO
         9Mk+Mt7bbcMp+pIM+1bNZ/XDSJZ4clOhBRQ3Lipomb9t8QUon7kCRLO42Qwuj6ZDBXjA
         /+vc0HFmbyFFnXCksqv5xvC78YrK9hTmQUre3xxAzPI6JUFTOkBKPkJ/r/rmclvo4eBM
         DFP3id+kcJKvHwQQGUrbxN3qC9JSOhoUqzA8vtEVJRUixQFFOljytd7oKg+VrJJOHoXi
         vvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119443; x=1685711443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgnb7olp8WsAGre/rjyOBmnAxn0zQrK1napy4mUiZ7c=;
        b=c8HHSz4ReIaxgAFdSV7rW+D2bF79Nv2ndx5NQ2QLu3yKzsHJmzhYG7Ytgsd7wMYeRE
         9YFVg42XNJuawMJchC9N9YDGATDBzTKR87dCrzB3T0Ovwb0sZTroJfrEkVIkAFhQh7ia
         IOt40aozNLy8yjHPXeM7OWephQR99RmnecNvxoNxT3K/qtS0zrjWiAZD7TDIT/r+3SW7
         3SDg73Lsw+UNady+JtOqM4MzY4koFKx4qsL9BU/beCEMy3FOTBdTZxbiTi6zaSAJng9q
         1tgFaR9yMzhUDaxUcPShauRa2PhNCK40MCvhMHijCDW++sEo+pb69nyJ5rn7dfEuwSyu
         3atQ==
X-Gm-Message-State: AC+VfDyR3Gync8QHr9k5D9z2DPi0auo6Lsf4J6pMJgM7JIPczkTS0Irm
        F1tUwDYeGs7dQPVxeFt9IlMWFg==
X-Google-Smtp-Source: ACHHUZ5onCrk1ZGwnojRx6Fmv0L11HQqcNEMV8jAhZN2+tOFWR1L3qHGyd8YXq52eqrfy0QexubjLA==
X-Received: by 2002:adf:e948:0:b0:2f4:fcd:98dd with SMTP id m8-20020adfe948000000b002f40fcd98ddmr81717wrn.4.1683119443204;
        Wed, 03 May 2023 06:10:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:37 +0200
Subject: [PATCH 5/6] arm64: defconfig: enable FSA4480 driver as module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-5-d1ee9397f2a6@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=658;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Ikn25ScmA3SvVEXK30s7bBDPVtR1+xG0E4owtB5JoJs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1NI53nTosyH2S+NdPlBq0zcFvS0oMpzKzvbjob
 zl3xDCmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdTQAKCRB33NvayMhJ0R/gEA
 DOn45TLjrU4TgLfa+a2LbpBKMyy+JyTNXyOVgAm6TpTvr9AF76sZL1bYn25QHSxjEHzRuFa1OvwwXj
 ieOTugcP7tiyaY0eCJIhqoIlDp6zaVUGZfw1Z6ndtwuX7P0/l9ynwI/rDlmYFl+MnfGv4OJ2vfkXVo
 lLLqD9z4jk/AXUNeSPbom00HTK/3X4G/vdT0485W28ac+64ld9KD93iKmyDkmVs+mZC5I/4iOr50Vb
 MdIvKrrdxqLhmJIPnlRoUjwT2cXIyFalSFnFXUZJxPoJ2ERJURslKjHxlmuZQQaWHNHqC2izxMYpOS
 LkKAkjLC3UJB3R2EqxNX3xGHCH+hhbb8xwHRi3NA2nNOJKEGbHq0bea/sjlRu4X0Gm7JXw2gOFYdSJ
 vCFzkulXe5TtXhXDMESW10QIEwz3u4bvMaU2JJSbklcTzn3zal+NZ9MAZvQgdA3jhed6eoEwP/Eeon
 mMOJ79mqtGFkiLllml8HvuA4uoVpuG68tcCL1ynJEza3WPZpnveKhQ0LhidJmYPdiraD6aHlT4tLmT
 vzxB20d9c09yCVL1ax0PCEyKm00Ebb7vmiVObpXQU+Uu4cTqoldZK9E3PF7XSctBsFniNUCXPgcm5X
 chSnrBRWKn9Iebel4k5UJuPnjMb6PYrXGswOLg9YvXQdeBGQ0alm+O/QdO8Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the FSA4480 driver as module for HDK8350 and HDK8450
platforms to permit USB-C Altmode support.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..e548bb52260e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -992,6 +992,7 @@ CONFIG_TYPEC_FUSB302=m
 CONFIG_TYPEC_TPS6598X=m
 CONFIG_TYPEC_HD3SS3220=m
 CONFIG_TYPEC_UCSI=m
+CONFIG_TYPEC_MUX_FSA4480=m
 CONFIG_UCSI_CCG=m
 CONFIG_TYPEC_MUX_GPIO_SBU=m
 CONFIG_MMC=y

-- 
2.34.1

