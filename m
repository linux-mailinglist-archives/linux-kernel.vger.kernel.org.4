Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A265ED8A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiI1JPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI1JPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:15:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32A15837
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:14:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso241299wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=ukcH9izbAP5JbbCU27Xnw6w8tsrzXCXDV6b5IQ0ixeQ=;
        b=QxjGHTZ0p7BByxvc2O2aAUnv4wvGikP6vzJ0Z1ToZJfD2Bpjg4bkDEFq718v8GYPjz
         ZqVPXp6TuW/E7eCuLjl4Pl23SiJ2jeYruGS0a5J50vWE7OjuoSnFHkqfLpGe1UWeUXwu
         EYsjmPw53mOIisdme9PCva7Jk35RsccPmL7sr4FI/2VlYigMGn2CZSeP56AS6N25UDwT
         LaIh7eJ/KasbCQARp7Q2ef1EUWZZfHpU+0AqfGEir71WUpzVRK7HxqUvNR+Ac4puhp/L
         bRE70NSg6MMdpU8sIjDLMn5G6vWWUKkSF/qG0xMLg6H/RgNkK94SPvWJRF5vLRS2BH4s
         G/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ukcH9izbAP5JbbCU27Xnw6w8tsrzXCXDV6b5IQ0ixeQ=;
        b=UQ0As6jaM5+PZbvyPXfkwL0pEb+bdIEOuad/l/pEoJ79kHuMbXefV1oc6zLHLtNMLy
         +sDZr0twJzRqcO4m+CCEBzONYMknLzqeXScxTgTm0YzxIw2ulBoLF+ByszrZY+2AGTad
         zkiVQ/9X4IAb0G2eMkbb9xr5lifcMS9fwxATb07/wcolPlS3UQDB0uTmLmJRfhv48uQO
         3/5y/oHlo868LEkUKm/OiIitOSL1eL9HpQpMfb3RP7VSmiYm1+7zYinTcSn6o+KF6qVa
         qHqy4dS9vl0L/iJMZ3GIm5nS0Hueg9i10Yc3n0MIRjjWNovGy6yeVqwOqK+DdY9ddaAr
         r1eg==
X-Gm-Message-State: ACrzQf2jEZ7hTzzsMeNrrH1MfJ5/37EfftNnBOu8N4y/FA9itIO3799i
        LONbilw+8N3cZKq2odFneJZihQ==
X-Google-Smtp-Source: AMsMyM5PEpuJuYKwbLsUDoi8U8WJYZ+yh8v8wsSMrV19Z1OoierBr+cv7QaBAW54+Ds5Bqvfv7Zwgw==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr5794271wmb.20.1664356494751;
        Wed, 28 Sep 2022 02:14:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d6382000000b0022a53fe201fsm2420016wru.68.2022.09.28.02.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:14:54 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 28 Sep 2022 09:14:52 +0000
Subject: [PATCH v1 2/7] arm: dts: qcom: mdm9615*: add SPDX-License-Identifier
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v1-2-b6e63a7df1e8@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the licence blob by a clean SPDX-License-Identifier

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
index 0827de5426c1..073c15354483 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
@@ -1,46 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
 /*
  * Device Tree Source for mangOH Green Board with WP8548 Module
  *
  * Copyright (C) 2016 BayLibre, SAS.
  * Author : Neil Armstrong <narmstrong@baylibre.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
index 49de1821ac3a..146ecee50998 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi
@@ -1,46 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
 /*
  * Device Tree Source for Sierra Wireless WP8548 Module
  *
  * Copyright (C) 2016 BayLibre, SAS.
  * Author : Neil Armstrong <narmstrong@baylibre.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #include "qcom-mdm9615.dtsi"
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index b47c86412de2..b06bbe25fdd4 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -1,46 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
 /*
  * Device Tree Source for Qualcomm MDM9615 SoC
  *
  * Copyright (C) 2016 BayLibre, SAS.
  * Author : Neil Armstrong <narmstrong@baylibre.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
 /dts-v1/;

-- 
b4 0.10.0
