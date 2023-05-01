Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41BB6F34F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjEARRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEARRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:17:17 -0400
X-Greylist: delayed 499 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 May 2023 10:16:49 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556C81727;
        Mon,  1 May 2023 10:16:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 6265F4112C;
        Mon,  1 May 2023 19:01:47 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1682960507; x=
        1684774908; bh=IeHcnYGT8x5oIMpt7vaj6WJo5TzDUMMrc5PAh+gHWeM=; b=g
        H8zMfSm/g4Vp9Qa85RFMbzfPxPx+R4NV1on17YilXuQiiQGfqIZWkSKNUwKO+YqT
        FhpFxfkmicdbWvzkkc7EUAowwYPOTtbnh5NMX7YPklUJy5JLsDj+qDrk/VO9YYlz
        S3M48OR3lJs4lDuG4PlXRDKVAnuFRFmifwnJzsGPyU381hjf6RXoL+4VqMS3+il+
        fmJV7WM3pQMOZH1BiDXP6nuajOcueifbiNCYsbyblpzS73MQvPhhokN+af58u/4b
        AvT5a3AMfadV5pEw/8qdlqaUDF/zpWXxarnTXAnZGpYZej7Hk5OCJYCMuxpRBRT8
        LGfJzNnDqZAEdxFD9LSbobpZYIhHSS0pQ2sihUJjZDN9oCvI36Tib8+npyyIylmV
        nuyUSHaew2SUkO9hoa9DUqTd0OqO6pI+sOBRuBRgUl5sEMIEA3qrTNbc9Skfk6SY
        dVEoEuiSjR/wTBenIYv/REfOuzR2mHRuXdgjs7sObLFGhH6PD+5XiqbxRhoLJVBG
        un1a/hb3x8rdEjp083QxjTtUT1iMa6wPRdxBvtcRVCypZWXJgqKxIe4LS7ET0xOb
        DFr7txNwKsi9w+lOOHBIQr2w20oVabKK/aQ+x4FY2x1XXbDoZMZ8aryCT4u8PPv/
        dMSn8Ac10dD+peI+gU99uBTRJwWH+ognZdcZiVnW28=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id td_WHPxP5L4p; Mon,  1 May 2023 19:01:47 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id C531F41869;
        Mon,  1 May 2023 19:01:46 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 68A3875AD;
        Mon,  1 May 2023 19:01:46 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alison@she-devel.com, achaiken@aurora.tech
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Mon,  1 May 2023 10:01:24 -0700
Message-Id: <20230501170124.1218603-3-alison@she-devel.com>
In-Reply-To: <20230501170124.1218603-1-alison@she-devel.com>
References: <20230501170124.1218603-1-alison@she-devel.com>
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
---
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

