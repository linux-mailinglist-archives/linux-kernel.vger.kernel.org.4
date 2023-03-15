Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFC6BAF34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCOL2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCOL2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:28:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE841B41;
        Wed, 15 Mar 2023 04:28:47 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h8so19626137plf.10;
        Wed, 15 Mar 2023 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678879727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87xfMD7UQA1N/7YEjQnUAZ8ToPUTZcVN7DincnMmFNk=;
        b=dXesCEdKlXZiopMIxtSNihWcxN1g4tWxCcOWMfHB7/H6EcFXBehwV80JnXBtFdw3rd
         xFawUdfQAzyYH3y75eLjfO7khLiyv+NsauE0frs1DwloPuNDGI/2wC3XTgkbdRdVORaJ
         fT8WXUM7NFQ0ls7hGIOmGWgh+C7Caqe4jzwg8sgkimiHM2StvkCX38JjYman90BNs9xE
         O2vGX3qJ/JfJFX3/NUlDH77lgIOuHuLryZ3WJykENBjWHyaCgrLsR1EEJZ794GPHP5jH
         6+YV+QhisLwCHdRkHb6N8jv+0qoeoDxV12jGgK/q/Cvv7iKJkuc3wzlXfyqHXoV7O8qT
         mTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87xfMD7UQA1N/7YEjQnUAZ8ToPUTZcVN7DincnMmFNk=;
        b=NmXhh8J7oGNtZH3l71+hjOEfSRaCeo8zySLHnArksGH4I8nrdINeO/9ZZ3Wy4ZZLvN
         pwvkPugGvoIGO7qqMCPE/xvLYAxHY6hRxdFg/QqYgs5wMk6zFK3oqZ6GBMm0vbP31eEJ
         cgALD9aiDYTJlS+i0UziNG6ZC8nDhYyBfhsKDxcJ6kn8YH3fjQU9ppydfKE0ApacSxyF
         50rTgcK+bUCCxjCh13UAk38a9DAM8NHWe3MSYMoxm/rZ3O/tJxbzBVVbIhOXboxfwTkp
         BGkxcwiTmbZuR5zg/PenVse19onVThF+joXQ2KaN9ZlBGNQhv4nna9jHQqCTRSlmWmjA
         S+mA==
X-Gm-Message-State: AO0yUKVQcFKKkh4u4tuFaj7+KhT3MRtt3MCEZS6hpiLFkSbcgvXpOljY
        zZ9MI/kH9GKm/rcFWUTbwrc=
X-Google-Smtp-Source: AK7set+wwbzqo/hqWOvUJUA1eDtzfTw0LQaoCkEHHLMaSGTnBVZ3dqLponC/KQy/GvW1Z8xeq9i+QA==
X-Received: by 2002:a17:902:e195:b0:19e:6b56:7d8c with SMTP id y21-20020a170902e19500b0019e6b567d8cmr1945493pla.9.1678879727011;
        Wed, 15 Mar 2023 04:28:47 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id ku13-20020a170903288d00b0019acd3151d0sm3435931plb.114.2023.03.15.04.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:28:46 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hi3798cv200: Correct 'clock-names' in sd0
Date:   Wed, 15 Mar 2023 19:28:29 +0800
Message-Id: <20230315112829.165884-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ciu" and "biu" were incorrectly swapped. Fix them to match 'clocks'.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index a83b9d4f1..7112f9933 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -304,7 +304,7 @@ sd0: mmc@9820000 {
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&crg HISTB_SDIO0_CIU_CLK>,
 				 <&crg HISTB_SDIO0_BIU_CLK>;
-			clock-names = "biu", "ciu";
+			clock-names = "ciu", "biu";
 			resets = <&crg 0x9c 4>;
 			reset-names = "reset";
 			status = "disabled";
-- 
2.39.2

