Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00956DAD12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbjDGNA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbjDGM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FEE7ABC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p34so23998972wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872389; x=1683464389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzQKBxaJfTtZgFEarsLsGgbh5GyaHaFrFFoVYkzh/dE=;
        b=K2vzmWWospCRq76TbSi0+wZ0zMOAZOd66LLHAM+Se1ayJWZERPQSuBte/as9oVyjD3
         f8mwiVgf6KGir7oVhrBQqNKvF11/FNBcQ6mq8TiQuOU5a3AF/EkIFarwb6g+4tej2EeO
         hpwiu9aFwihF5ikzZhFHv9WR1XejjVR5P74yytQs49OYXl7LwXUCYxS4WheqY77H9q7E
         FPUZxnW5ZXZg+DCIEiHf/Qa0uA3kAF5YFK79uKBhxw41/97OcAO4HO7fHcGYjYIky7SB
         /VEJ9f1Oaq3fsA6OY58J5j1o7LZt9sRsSwJ+68pd4v/CzJ3rlPIJN/Ld7mDtJWt2ctw0
         +txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872389; x=1683464389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzQKBxaJfTtZgFEarsLsGgbh5GyaHaFrFFoVYkzh/dE=;
        b=G6mRg00IoZpmIzOtAjMhm14j1vW5cz741ijfKt4rDP831MM22MDbomXnxjqB9eALV3
         0dYx1jBGm2RUGZMqZFWTn1GP+0Le6mjYgtYJShZYfjWwJIxnhX6nBRnesYctyyPysBtX
         WjhXm2OroxxDhzYtte/H4EfW5x4CXxBxiP2CJGoA2dx5Y1CAIL2ucQOJTUsIj/BxZo3K
         Ri4Tw5wNcqlzWAL/3JOUboXd/VM0kT67EC15BxgsmUWbNipGtunRPm61VhA6eKqsDOR5
         K7raHvg4HQoBvq1/FWEtSF9q0REm5ZpXYVsMKlOkiTpcuGDesMKvycxTp14tKgRNZ8Zl
         a9FQ==
X-Gm-Message-State: AAQBX9cvTOxtYwDebj66PG2yWyLLAPA6m581ByiRi7Yw8vTIzTPjhOHq
        0f9MTLU/Rgb9KJonhguFDctRtw==
X-Google-Smtp-Source: AKy350bWd6lgb4gDck+DlVQj2J0iHuLZOOw26vgchmUPYoKgKSyc6rI/TX/f4fqvUU+b4kFoLaqAKQ==
X-Received: by 2002:a7b:c018:0:b0:3ee:775:c573 with SMTP id c24-20020a7bc018000000b003ee0775c573mr1193944wmb.20.1680872389150;
        Fri, 07 Apr 2023 05:59:49 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:48 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Fri, 07 Apr 2023 14:59:26 +0200
Subject: [PATCH v5 07/12] arm64: dts: mediatek: set vmc regulator as always
 on
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-7-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=uQmwTOCvAzVnfNhZj39MxdhTEW1pXL/YxThy6HLL1ww=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO6rfi7KOma1wba+5EHCCCpE0+U968VihmrZRL3
 gq5NwieJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURWp8D/
 42YBkFy2+WquX3mRrxbZJ8Dac+sLIewP1YqIuM3q06ycYB8BIdJqrDBFJyyVjEwt0s09zwfjHT6+/e
 yddcPaWPc2NXga342qGRH40A/JxGRYvb9MJcfElPLvmzyIRlvbzqXuo1nnIgSXRZ1zqtqFz4sbc+un
 WBAsyBDKiJROyq2Ecqel3H61Y7LECl71uOaiD61eiUdHfLTTZx6wCXb83rjVHhZSHmICs24KFokAQc
 sTxyCNu8yUnzDtyCpVIlyUPDesu8ZSdhisNZN1oieipy2IMGJJS21UZYkt/rtLsBt4eFUVQyBw2/6z
 2NNlqyio4BMXNhZCa6mf62UJNQtJEHjmQl16o2XGWnpCLSfHxVR438KQUi3kZwl8SeSn4BeGXVCckK
 ItdROA8MG6H260+80QYf0MFHdDX+oISQOPI6WSNVBEzBs8TM05TAqylZ1Fe5lcn7cBnP6efeJpC5Sz
 XMyZPZhzo4IdICPYIJ4UIHp8lnxFHMSrah0nit6HYHV0OIQmcWmarsD6mJILDTZA2mV5CAHCu8vskW
 EQIqADAf7s661lVED4BlpPN6e4Kvz4sb+xk7n1OSv0nrC3KVSWOwfb6zXZWfqoeHLdRceEqnx8BcwL
 9DcDxtJbhqXmgu9akX/Ve6fJc7MbMUuxyiP4woh7oRRwKkYy3FN1adOcuEgw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

MSDC1 IP block is powered by VMC. Make sure it is always on.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index cd920d09c3fe..1c36d8f19525 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -137,6 +137,11 @@ &mt6357_pmic {
 	#interrupt-cells = <2>;
 };
 
+/* Needed by MSDC1 */
+&mt6357_vmc_reg {
+	regulator-always-on;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

