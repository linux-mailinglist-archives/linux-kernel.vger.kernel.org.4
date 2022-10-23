Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDE60942A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiJWO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJWO5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:57:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52A5C9D1;
        Sun, 23 Oct 2022 07:57:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v11so5122096wmd.1;
        Sun, 23 Oct 2022 07:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNepXipGDeJQVdil2MM/OA4hZBASj3NiREHHvlf/RXY=;
        b=N5ocY8LPkrECmPbCUP5uVZnlbVjTNrJiVbq1owEIcKUOPsEgV7i/vjpUkPwiMMu1kW
         5hSIikD1VO15M08WNrdtB9Ox98Y2PqOMsWeseV+HKgWVTv6U88wKfG537lKiJ3c/ptcZ
         Z9h8t2BDNEsruHh0hS1hgDARxbW8xuXpuZcWQsYYBrT1QR0E2uAtgM/7FiJudOGjlOxQ
         IX1WXxIA0oSdnDMCd26HLPFv2R1tDvWmatQ6chYyC6F18bMCzIHD/RUBuAfJAdceGtaf
         XDEiUs328+77QwjifszCig6RA8Sbk/n3NpjwN0LYUzUU4fWwUVdOSjv+G13PPHM9fqdQ
         TD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNepXipGDeJQVdil2MM/OA4hZBASj3NiREHHvlf/RXY=;
        b=bKEbQ1NM+nR0QzUmC+Vqzl0gmIZ1jgFzLkVUW5uG+9RoHNhM9az1atX3+vmEMztNrp
         DDQyDwDVcm4cb7gN96z2eKBkDCxNqlbzTf+Al6F/QWK8DV+NXoOrjP8znIooFQqtzJY5
         CZ7I5/OFhgcX5ArGb7Ut2rWc+/Omik2Q7EpICn5tiQNzYolUL6Nl2Bgif0EXoHJLnisk
         64RVMsBIR+LftVmLMnQ6Xb+0VvJ81ZlDqXTwOimsEYN4IRlZ5D5qnBTqn67tWsfa7pYx
         bHTYAsnGYQbUbEaYDoPfNLf6BBV8MaMgeTqdjLJax5T6KmpaExuQ7q2/J/qf3ECqqRF6
         QkvA==
X-Gm-Message-State: ACrzQf0lZ7Lcjw52oHnzTuPY8MDVQkCv7grXebh6GvuH7IZip4EDiGtD
        J63/BP0H7Vi4Ign9UqnZ32E=
X-Google-Smtp-Source: AMsMyM6wytrKNgTyh7Lmv+UbUvZzrlOg+CLkYo1mM4UpmbcWQzOXUPWTAB5Kg/wtt2cWDBfVo/u/PQ==
X-Received: by 2002:a1c:f008:0:b0:3b4:fd2e:3ede with SMTP id a8-20020a1cf008000000b003b4fd2e3edemr40780835wmb.133.1666537027289;
        Sun, 23 Oct 2022 07:57:07 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id j8-20020adfd208000000b00235da296623sm9139763wrh.31.2022.10.23.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:57:06 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] dt-bindings: ingenic,x1000-cgu: Add audio clocks
Date:   Sun, 23 Oct 2022 15:56:52 +0100
Message-Id: <20221023145653.177234-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for audio-related clocks on the Ingenic X1000 SoC.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/dt-bindings/clock/ingenic,x1000-cgu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/ingenic,x1000-cgu.h b/include/dt-bindings/clock/ingenic,x1000-cgu.h
index f187e0719fd3..78daf44b3514 100644
--- a/include/dt-bindings/clock/ingenic,x1000-cgu.h
+++ b/include/dt-bindings/clock/ingenic,x1000-cgu.h
@@ -50,5 +50,9 @@
 #define X1000_CLK_PDMA			35
 #define X1000_CLK_EXCLK_DIV512	36
 #define X1000_CLK_RTC			37
+#define X1000_CLK_AIC			38
+#define X1000_CLK_I2SPLLMUX		39
+#define X1000_CLK_I2SPLL		40
+#define X1000_CLK_I2S			41
 
 #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
-- 
2.38.1

