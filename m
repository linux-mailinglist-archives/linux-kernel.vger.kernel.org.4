Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EC6D1A61
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjCaIhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjCaIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:36:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0E1D93D
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:35:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t4so16350149wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5/X3/1Tx5hLaqv79uU7wuySkv7lfnq2I4RAVqFuiIk=;
        b=JRJQX3qf6nbWRRhjPQNrARTIyJRjN85WbOZTRhfjLkq95loPYQtmcz9uuRtmXD+gF0
         pbjlvjWUpM5s35eLwCfaIEAjNdqCVJqUbIoJ0QQ+NUMzZjtV7Kxbb9qHdGemp2rn+kMY
         Iogew4j3vSCvnnTWMPSv3pUmltFB4eJLvdhtB7DgxhbLKFxRNR7Kae+MW+amWDOuGH+K
         0TIBTDavzQ/ATWYsYCgjlgvssAy0cZ+yRGjNI/IOQWRKqbCot7nTCcwYctdEE3g9Fhow
         0GHMU5sij/cF06KleMdx4uNj5gz06aYrtqcKb/iZZ8GuVraLGpO2QvwZWp3MdMXVyQ6A
         wvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5/X3/1Tx5hLaqv79uU7wuySkv7lfnq2I4RAVqFuiIk=;
        b=hY+Ui3pyMmLekb/ZudfGj4q6O86ncZ/vMC8SsuKV6+kHPcI5E3TkYOe7j5bju4Til8
         b66xUxivJA2Bpli8dF/Wy3L67U8v+2JvUf5SyVQS3FdHJP7n/9f2Y8NiJuZdAwc9KXWY
         HT6fOGovLu7dAjLGK4b4FhZaH6jiu/ehrjuJuHtCPhXdvYzKUZaspLEXh69q2/s/lROW
         3YAuKuD+Cp6Da25Zzz7KtrB85LG+DrWaFNohdN7VyWslcJHR3Vcc5LsAca9dyYXPUCcx
         OL4ZYAnatbhe5ZQs7rmpOLbc6pWp+Pt6DDI/N+fXO4t25akAjM66T4NgiTYiqjT90Mr+
         SnkA==
X-Gm-Message-State: AAQBX9cOI35fdFe6Zi5NdthzYkHiv5t9ViiFDiqyEc4Ba3wAzNrnSxSk
        kKo+uWyth64th52woDlBpAqXFp6Oei6VCXszlSPt8w==
X-Google-Smtp-Source: AKy350aYemXoWmOPKcUW9zRssljXvnRo5Q8xdKbF8v8OuSCqLpxJ51RrFOLM7mEYYMCY0HOKI4STBA==
X-Received: by 2002:adf:f04b:0:b0:2d8:57b1:db6c with SMTP id t11-20020adff04b000000b002d857b1db6cmr18990831wro.9.1680251709411;
        Fri, 31 Mar 2023 01:35:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d4e8b000000b002cde626cd96sm1563153wru.65.2023.03.31.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 01:35:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 31 Mar 2023 10:34:56 +0200
Subject: [PATCH RFC 18/20] irqchip: irq-versatile-fpga: remove obsolete
 oxnas compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v1-18-5bd58fd1dd1f@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v1-0-5bd58fd1dd1f@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 IRQ controller.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/irqchip/irq-versatile-fpga.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index ba543ed9c154..5018a06060e6 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -242,5 +242,4 @@ static int __init fpga_irq_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
 IRQCHIP_DECLARE(arm_fpga_sic, "arm,versatile-sic", fpga_irq_of_init);
-IRQCHIP_DECLARE(ox810se_rps, "oxsemi,ox810se-rps-irq", fpga_irq_of_init);
 #endif

-- 
2.34.1

