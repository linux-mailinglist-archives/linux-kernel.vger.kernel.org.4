Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B9F6B8362
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCMVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjCMVAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:00:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73C46BDC5;
        Mon, 13 Mar 2023 13:59:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j11so54038085edq.4;
        Mon, 13 Mar 2023 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678741197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPpFzY0H3ocypf25nzBsMZcz2jHpyh97I8lhoOmDtHQ=;
        b=OHbagyg5bjoVCvA1hrlo5J1nAhIBkYk4wwpEghya4UrayOuB7UPK30gEC/jjivdhEQ
         xflR/CW8VYKLUAuhmaIsrCVEUsAhfzk5BT4dSLMJ4F4wjE0s1ecLWA/PR1UK7Iewxv0t
         RsfCqVU/p+xVNZyQXsSghzAhnu22KZHSbj918dK8eIbXI1d499psPnXipZnQPyUImJU2
         en8D3NR/740e8Ok1RP5cCAcztQY9Wv59n2p9z0dXxjSEOc9kMSx3q5j8Hoi51LfqcDc1
         jS+M1Uo4I21dM6n5UY71t2VHBoMoAobD4eOBriJ2WSU9iqenAnck/PMR8VqaeFs4w1cV
         DpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678741197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPpFzY0H3ocypf25nzBsMZcz2jHpyh97I8lhoOmDtHQ=;
        b=bNznXDK27UR6y6W+KnuaNuBdcjxj4Bkv9ZIGgMaVKiMkEA2F0qWBRU+m7jyAedxv7N
         tQ0SIVnrNhxnS1cvRFnttN2m3U7gWQNXXfcgJ6YvfmS+/6f99NMasG4QhQxAnFZBuCnq
         FT0tIpc25cvMu8wU/6cgBvkItT81PHYRB7A0zl3MKyTLI0r2gwLSjvpKUxDXnNEgJ65M
         7sTpONv3JsFBREh4vwaGjy50zdbY+Q2yCAkxpw5hrq1zbji4blipxdf0g8M8/bcjseo3
         U4zuLB6kjeseNcMqltU70fe++A8QxQsGEKoVYmCQeFSHeaUu1Lh2eFlfQ5mShUrdQbZk
         f4ig==
X-Gm-Message-State: AO0yUKU2f8gJ4Kw/NvfEfh0g9mPIs6mDEv/5AdLS4pftcBNjCg5KqfPz
        s0oNJ6NdTkrLVFeXhvqwJ4U=
X-Google-Smtp-Source: AK7set9icf3Izry9u+GElnyac3XCLodvzYP9CrmqTou6BbTyanMvqHTnSw5zFhiuwRjnmYr5BdEksg==
X-Received: by 2002:a17:906:eda5:b0:927:6e70:e245 with SMTP id sa5-20020a170906eda500b009276e70e245mr6281060ejb.63.1678741197194;
        Mon, 13 Mar 2023 13:59:57 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906830b00b008ee5356801dsm219853ejx.187.2023.03.13.13.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:59:56 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 02/21] pinctrl: ralink: rt305x: add new compatible string for every SoC
Date:   Mon, 13 Mar 2023 23:59:02 +0300
Message-Id: <20230313205921.35342-3-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230313205921.35342-1-arinc.unal@arinc9.com>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Add new compatible strings to make every SoC, or SoCs that use the same
pinmux data have a unique compatible string. This ensures that the pin
muxing information of every SoC, or a set of SoCs that use the same pinmux
data can be properly documented.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/ralink/pinctrl-rt305x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/ralink/pinctrl-rt305x.c b/drivers/pinctrl/ralink/pinctrl-rt305x.c
index f6092c64383e..fa3743c7680f 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt305x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt305x.c
@@ -118,6 +118,8 @@ static int rt305x_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id rt305x_pinctrl_match[] = {
 	{ .compatible = "ralink,rt305x-pinctrl" },
+	{ .compatible = "ralink,rt3352-pinctrl" },
+	{ .compatible = "ralink,rt5350-pinctrl" },
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-- 
2.37.2

