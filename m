Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65256598B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiL3NZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiL3NZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:25:01 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578BC1ADBB;
        Fri, 30 Dec 2022 05:25:00 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOsWw049180;
        Fri, 30 Dec 2022 07:24:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672406694;
        bh=4q9ZMuP5XyaMk39sAjDAxTfJTHxsXiUyfKRXYVMkn3A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=j2hVpZPOawIReqkqozeAMhsCkpWYq/2ymyA5Mj5zExwIPjhirpJYN4UbCr5V6l6Wu
         86wt6GGilNKhpGpe4aMzwulDiL/RzdhIyxMMMmP1rK/c6Dzrv78PaIyQCyYiVak9d+
         W5a6upLiQO5/QjIEgzQO4A+lrb/MKSY8jPqOsgf4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUDOsxb042916
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 07:24:54 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 07:24:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 07:24:54 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOsmp044619;
        Fri, 30 Dec 2022 07:24:54 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: remoteproc: k3-dsp: update bindings for AM62A SoCs
Date:   Fri, 30 Dec 2022 07:24:52 -0600
Message-ID: <20221230132453.32022-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221230132453.32022-1-hnagalla@ti.com>
References: <20221230132453.32022-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI AM62A SoCs have a C7xv DSP and Analytics engine for deep
learning purposes. The DSP part is similar to the C71x DSP found on
K3 J7 SoCs, but additional hardware accelerators and IP are added to
the subsystem for deep learning.

Compatible info is updated to match AM62A SoCs.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
V2: Fix indentation and review comments.
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index cedbc5efdc56..f16e90380df1 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -31,10 +31,12 @@ allOf:
 properties:
   compatible:
     enum:
+      - ti,am62a-c7xv-dsp
       - ti,j721e-c66-dsp
       - ti,j721e-c71-dsp
       - ti,j721s2-c71-dsp
     description:
+      Use "ti,am62a-c7xv-dsp" for AM62A Deep learning DSPs on K3 AM62A SoCs
       Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
       Use "ti,j721e-c71-dsp" for C71x DSPs on K3 J721E SoCs
       Use "ti,j721s2-c71-dsp" for C71x DSPs on K3 J721S2 SoCs
@@ -109,6 +111,7 @@ else:
     properties:
       compatible:
         enum:
+          - ti,am62a-c7xv-dsp
           - ti,j721e-c71-dsp
           - ti,j721s2-c71-dsp
   then:
-- 
2.17.1

