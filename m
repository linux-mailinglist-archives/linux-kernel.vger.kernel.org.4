Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AD368BA30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBFKaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjBFK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA0E2279C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:46 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso10413679wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaIgu0YxFRaKPZtwF2qRE9W0+zjPXCAIOvzNRgewnbQ=;
        b=pBUbTt+KfrQL2U+XmkDuU/2DUqiMZ5kveF2uT7WMBYnwHgoMJkE8dFpHDWx49qwXsY
         QbCDG7WhwtMfkSWdKV8gwcAUOLlmwiCoNgrWNXJiAgqLXFyLNY+GzQdG2rNrGkCS6tk8
         n0Doo7+hQhSST2nKRvZluQaIS8n14JOvip/QBy8AV1cxyB+FwGE8NU6JclSPpZdnoxFL
         sibXzf6z3CnGWs10Nw+WUIdfy3up04w/JxFRcIdQmGAqPyXFFqHC9nMnZbMz5CmnXrgS
         vYSx0R/JSXrNl2OjtX7ZpbjebJm02Zq5Bs89h6g8GJ8CzDJ6Oi1CXnXrvbyBIH7eGcwH
         9NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaIgu0YxFRaKPZtwF2qRE9W0+zjPXCAIOvzNRgewnbQ=;
        b=vE3l1fDKKir9Y9vgeOxClJEm0Kdkt5I4ow/xfM6ZGtkfZdB8SUM7/r8SRb1wcQzXiF
         2Pv74njU7SxJhBHV8rEvNNEEb+13mIFm30nqPc9ltLtWYAbzqmdQqzxLOb5evF7kHujx
         nwU1HwzW4NiPEe5nl3IJEW4E+MD4MlKILT8116j+0idC+lzHUfuwaW11auu6LIb7TkJH
         t4iH5t+1JJZbyGNhr1nFhGrmIkmuQW3ZLo8Lqq0kv3BCPEm+I/aBNqeQxiZvhcI0ftQT
         BRFHG6hl1OXP07H17kDbqHQAiZmCjbNytkSSYYyDY26Mzoqo0HN4vu29iiONh6NaUQbU
         RA7A==
X-Gm-Message-State: AO0yUKXlhJcjd0y4ql6qVYlf5T9DSwu1HzoP7ckD8thrHYD4hJj9yfUK
        dnrsCpYmzWQcMx6cqYXGcX7ggDfC5r02lnRy
X-Google-Smtp-Source: AK7set841ssJ2wWAPycfsUFiTMC0OlAf+Sqq24HLvfg1pw7roiegELXyt9u4p+K9LDlZVDzdh6Ws9g==
X-Received: by 2002:a05:600c:4f93:b0:3dc:5823:d6c0 with SMTP id n19-20020a05600c4f9300b003dc5823d6c0mr18860272wmq.6.1675679326231;
        Mon, 06 Feb 2023 02:28:46 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 26/37] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Mon,  6 Feb 2023 10:27:48 +0000
Message-Id: <20230206102759.669838-27-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Following the introduction of the bindings for this NVMEM parser and the
layout driver, add myself as maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a02a59628f5c..5988fe6a4d5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15607,6 +15607,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/oxp-sensors.c
 
+ONIE TLV NVMEM LAYOUT DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+F:	drivers/nvmem/layouts/onie-tlv.c
+
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mips@vger.kernel.org
-- 
2.25.1

