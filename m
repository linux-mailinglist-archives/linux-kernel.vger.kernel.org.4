Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB74149D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF1PK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:10:27 -0400
Received: from mx.kolabnow.com ([212.103.80.153]:16668 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbjF1PKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:10:24 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id BE13D1507;
        Wed, 28 Jun 2023 17:10:22 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1687965020; x=1689779421;
         bh=PnmFSdNW/wOWghO5UEAYRn1lMYSvXrU0Di6n2YClNRw=; b=xE//y05Png43
        ekRXGwpR/cfDzHiZganpGkB5IcrbTLX8nHCaqtQbnvbzrmO9Y9L3mE+xLh6DcW7E
        cG2FXoCWfYDQpc1CLlbgb6XHlKmh/fy04egkM1QjmMHJiB9Bxn8DFArKdR6xBbKP
        67ZbvwfeCie2fO/BltPR5B+GLDer328lj0jNpPwunVYiRGcqV7P47Cev1+MNSY5o
        aXzN0gJjyGGBQ+WXRM9gCsn9zyzw+FNq3Y59jtUj3zyKmNTjXhmKCLDKFWNXThxg
        WJDZm8K6e2GVk8Lzlxs7B5+U+YQasAcKIMBUr+2kJ9tqBXuZhqa9uxGKXPQYQGST
        X369+953co8fbYVEn1Og7vVIKRv2UXFhOz4G3w2P3N0VtN/1gZvM9ZX5M+HUAWRG
        6d1fppNK7mN+RHz3xIlWg7TOMLeJJ8YE0Syt4OHEteFqEDACHJuvdAp3pw3I8vT8
        v1McwAJ/we1WgjSlYLHT8IViySn6v/qAP6T6y8O3vtYZHnnaz+N+vhXuDwG4wr6n
        mg3vF4j6T9slBBcq/zTB9D9JILLMWPqVCi6mdVKlStE8PAJm3MMwmjGxp3WvzclX
        34q+i6jbSt9twjK5xPsRtanUb6FcD8f4oXQNV5ZoG19Ci+P4Kq5YrhDGWSJOyOEt
        cIbVaaozkSfUG6WNkuxpUrZVoFSjLZE=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=4
        tests=[BAYES_00=-1.9] autolearn=no autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ibB9jv9JpPOY; Wed, 28 Jun 2023 17:10:20 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id E1F64607;
        Wed, 28 Jun 2023 17:10:19 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 016D433CA;
        Wed, 28 Jun 2023 17:10:18 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH v8 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Wed, 28 Jun 2023 08:09:48 -0700
Message-Id: <20230628150948.908273-3-alison@she-devel.com>
In-Reply-To: <20230628150948.908273-1-alison@she-devel.com>
References: <20230628150948.908273-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for the U-Blox Zed-F9P GNSS device.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Acked-by: Rob Herring <robh@kernel.org>
---
V7 -> V8 Rebased on v6.4.
V7 -> V6 Moved Acked-by tag and fixed version.

 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..86b65d4d9266 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -21,6 +21,7 @@ properties:
       - u-blox,neo-6m
       - u-blox,neo-8
       - u-blox,neo-m8
+      - u-blox,zed-f9p
 
   reg:
     description: >
-- 
2.40.1

