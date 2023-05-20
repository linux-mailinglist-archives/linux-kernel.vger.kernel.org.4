Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5070AB27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 23:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjETVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjETVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 17:38:57 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9219F;
        Sat, 20 May 2023 14:38:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 4783040315;
        Sat, 20 May 2023 23:38:55 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1684618734; x=
        1686433135; bh=uW/Pj1AFyhgRgOzjlpGQjJyF6cL/aUOxR6xtJ/BltvY=; b=3
        VjIxle5pdQDefRZFR1AiIO9Nrrlqx7cb+uxMAo0BHZqbUjSSA8y1Kf+q+FpOv08+
        XLjjZhYQu71w0skTIcnP97KdcQQjeRLMjMHYz9Byz8A6NTCl7tAos825RrItGzVe
        r+nZcukqzSNaXwwlpnlbRZ+0HUGcamQzVGzpGOmr/pNG7zJndw+wy1INeHOtJJpR
        0ItFWn4fBby2fAobB8KWpz3wAs/Z/gPMsQ9w/d5fc12Sdfk6eRV7lHo8EuffmMb8
        E+Qmr9tTNVuvGydr07qwAUqtkA5NvFvZP3Bb/riPtIqdUFQOonpmmWFCOh01/Qzw
        tUF+rjF7XIe46YjKowRRsRkg1nC0Tn+lpOaj0a/eRwa9UFNcMF89lZ5U8W6rX5fW
        2B6GnRcSTe6OfuAtQqzTPZ7nFCuIkEy3jh35uCx5LZjjfBd5KlPzRTzcAJxFLGKS
        NRDSX2b4IPrv829+PojwlWCBTgRfNuMQwKHrzlWhXsMrwCmX7FWLj4MSpcXMdknb
        LHoXKTWVqdryG3Jl4PxVizutR6x4IFq6RunpkUXdhvuDZ3h+vmNtvjuQQ8Obbcuo
        xSgId1slatkXUwHy2frv74j3OH07pRmtsBC5iVpfyPpWeyjwKV2PGMf35VjEH1nE
        3J+K0y54iMC1dWGYfC0mAiQntEqA/rlY9uCrbQSNe4=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gvzix2uiyLxp; Sat, 20 May 2023 23:38:54 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id BBA46400B4;
        Sat, 20 May 2023 23:38:54 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 3C3D52991;
        Sat, 20 May 2023 23:38:54 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sat, 20 May 2023 14:38:35 -0700
Message-Id: <20230520213835.1932087-3-alison@she-devel.com>
In-Reply-To: <20230520213835.1932087-1-alison@she-devel.com>
References: <20230520213835.1932087-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for the U-Blox Zed-F9P GNSS device.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
Acked-by: Rob Herring <robh@kernel.org>
---
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
2.39.2

