Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B76D6A77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbjDDRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbjDDRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF3211F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so133636072edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVPXX3tTlOF9VITPrPZIzQLL5bh3PDmTAkam+BakNc8=;
        b=nOKzTO6oUr0IHRPELYXE6MmyoXEi8c1z9gBs8OCX5c65i8GfGmROYEITTJDk6gGn2U
         zv6F8IvL3Yo1tflAeU72QQQvB16gK6U8FSxDEsgluSI8W3/62gX3fiXNlNcp8eLRBPtJ
         HwwY2eu4C3d567PoLfc7v6HcX7eSwjEtIhQdLGLfYHjO7TKzeSJnGXf/3eLtBvqpALuL
         pDzzeRx005rwHOtu4/zvTd4ET7E7YKi4tofkBR2SeggoAIbq+PLeZuUbzrux+sUULGFj
         isJue0fX7c/rm3BDDlj2DSBZLBPDX+/sK+aFjmRaXyou1eKvoRYT+CbYRkK7AzCgWhT2
         qC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVPXX3tTlOF9VITPrPZIzQLL5bh3PDmTAkam+BakNc8=;
        b=JPd2imA8Jn3eTaeOdxNDjpQv+2pX6RAn6gvPzKcUqmKftDvVGaKaZW//BQ3YwsKCLH
         hcRHIZqIodqY+/2+o1VNHg0LtANKB8oIhTzJL5qfUl6ZxaRJDW045vp0e/OG8467my40
         XfsIMsBhspwSkOFjQl+rbPDg/8AXjbjaj84MwYLnu9oVjNH/A1iiJ8tUPcT/mwNd8vqm
         9hkR/ey+FETsiFDzzYjA1gRm36vyfElrUiHZoPcWNyTSkDIn4P0F5Ylfp80SaV4sLdo7
         TfGKkijvh2JanJl3LIMPo5idxjvmmWwEuzerpkPqQrRF2gL/+7Gy8vTWMGuAN7d0DFse
         x4pQ==
X-Gm-Message-State: AAQBX9dIHTJWNpok82vcsfkNh8X1ouBqobjWAME9eicFcoNqvvUxf1dB
        iWRvfUoqf8k4GUzRaM3JMpipUw==
X-Google-Smtp-Source: AKy350Z6otpVTJvM+YnDshzT92pqnew/dA56DAuh7nHo+LL39OQyHtawKtZB1dgaAGSgkFfLy4S/bQ==
X-Received: by 2002:a17:906:278e:b0:932:e43f:7367 with SMTP id j14-20020a170906278e00b00932e43f7367mr379152ejc.35.1680628973353;
        Tue, 04 Apr 2023 10:22:53 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:52 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 22/40] MAINTAINERS: add myself as sl28vpd nvmem layout driver
Date:   Tue,  4 Apr 2023 18:21:30 +0100
Message-Id: <20230404172148.82422-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add myself as a maintainer for the new sl28vpd nvmem layout driver.

Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d4f778ede5d..a7763063ffa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19175,6 +19175,12 @@ F:	drivers/irqchip/irq-sl28cpld.c
 F:	drivers/pwm/pwm-sl28cpld.c
 F:	drivers/watchdog/sl28cpld_wdt.c
 
+SL28 VPD NVMEM LAYOUT DRIVER
+M:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/kontron,sl28-vpd.yaml
+F:	drivers/nvmem/layouts/sl28vpd.c
+
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
 M:	Pekka Enberg <penberg@kernel.org>
-- 
2.25.1

