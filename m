Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8745BFBFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIUKG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiIUKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:06:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1485AA7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so12347891ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=i7AiJke0RXt3Y3gefpg024oHyymEk36+1L9tZaTyjZQ=;
        b=t6+YqmRo2WFruAVVMiAUGdnIJlq1p0yLTMFevb2kYhYeYvpy4T1UvGBSg7PiELpuho
         yZZhIdh6b4QvllAVxv2url55QjqY6KTbA3UjrK9RE2jUopTautClbplRgLEp0buJBZ0R
         gGWTn6bqC+/ebZQxGqzFv2py0Mbk6cfaKdGooPdBYso/V6+vYccINUbEN/3vgJL5/BB6
         orkD5otB5j0sq9tO1z1zgVwwbH7M4SuOAUMs1iBLHu1dxpZQaCmv4KqSuiMuAdgL5av2
         vaXpQCNDduyUl6jpfyqpyLOnL4nAm9Ve8gUb1JVu602ULji+YIM/cMGJdniO3oUUoSzD
         T/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i7AiJke0RXt3Y3gefpg024oHyymEk36+1L9tZaTyjZQ=;
        b=YK3MABS+8KBtBbyXMyUftVrImu7rIdrDRk8qTNBa63rnS76ctlO8PJ2kcAvucPvOva
         W+N1dAv6PavgZ/Ssv3I7qcX92RqySJNVBsWnBBNwt+dAWtbZaduwAQ6ruuj5WApB7zo5
         n+W9u04m0xKcSggni/l3uIv0C6qZwXxgX9boX37cccyjcL/MC5DVV47IwhgTpnNbUvK/
         Lyrx4fu5hm3HG4wQ7zgLT/LGFsmVNkxApKIcqjcfWpieUWjhOgJ6PF84w1dz+x4zAyr/
         SIPeHw8ePDIHhWthw0UVmQa8cDCcj6QsvOfKSnc9tfMGNSeYv/CGmXvrfeJfUbB6hDrM
         L2AA==
X-Gm-Message-State: ACrzQf2/xHteDf++AO1VYpaQREKETr7d1EHnYgebQf0EAsaLE5ZtB3HQ
        SX4N6YRj/JcpzBs6eOZ8j/rbCw==
X-Google-Smtp-Source: AMsMyM50oCeyjRxK+fmYG030jR8TngTYGZrmO525DVI9C+v/ppgfZYe2k1gzpHyS6YpuEkF1O2lgBQ==
X-Received: by 2002:a17:907:320c:b0:741:1e55:7a69 with SMTP id xg12-20020a170907320c00b007411e557a69mr20507637ejb.740.1663754795366;
        Wed, 21 Sep 2022 03:06:35 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0074134543f82sm1087710ejd.90.2022.09.21.03.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:06:35 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v7 4/4] MAINTAINERS: add TI ECAP driver info
Date:   Wed, 21 Sep 2022 12:06:27 +0200
Message-Id: <20220921100627.124085-5-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921100627.124085-1-jpanis@baylibre.com>
References: <20220921100627.124085-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds driver info for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d4999f68bda8..fa92518b22ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20322,6 +20322,12 @@ T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
 F:	drivers/media/platform/ti/davinci/
 F:	include/media/davinci/
 
+TI ENHANCED CAPTURE (eCAP) DRIVER
+R:	Julien Panis <jpanis@baylibre.com>
+L:	linux-iio@vger.kernel.org
+F:	Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
+F:	drivers/counter/ti-ecap-capture.c
+
 TI ENHANCED QUADRATURE ENCODER PULSE (eQEP) DRIVER
 R:	David Lechner <david@lechnology.com>
 L:	linux-iio@vger.kernel.org
-- 
2.37.3

