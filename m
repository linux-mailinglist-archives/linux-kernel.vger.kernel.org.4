Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190A4657684
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiL1MhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiL1MhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:37:06 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05DF10B4B;
        Wed, 28 Dec 2022 04:37:05 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BSCauhh126426;
        Wed, 28 Dec 2022 06:36:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672231016;
        bh=Ps0r76a1FWJ/OBz35wokOV4UZ8+ehUwLp37dRHRlpnE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k2jYlZDqcsYEkgIdzXox3LLc5EtPADNFrlrLuHBxydVv8ID5PG+VYNvbk1SEwYeZN
         8HXPgSrme2ZZwyHf9GidPfMkMAH1HSRG44+JrPf7431STWTsrdYVteWQQfXyCeLvb5
         mJrnYIkebljlQF1AbEb7LJ323RG/huUYQB+W0Jx8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BSCauku084936
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Dec 2022 06:36:56 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 28
 Dec 2022 06:36:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 28 Dec 2022 06:36:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BSCatB6129791;
        Wed, 28 Dec 2022 06:36:55 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH 1/2] dt-bindings: remoteproc: k3-dsp: update bindings for AM62A SoCs
Date:   Wed, 28 Dec 2022 06:36:54 -0600
Message-ID: <20221228123655.15384-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221228123655.15384-1-hnagalla@ti.com>
References: <20221228123655.15384-1-hnagalla@ti.com>
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
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index cedbc5efdc56..846c9c14169a 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -34,10 +34,12 @@ properties:
       - ti,j721e-c66-dsp
       - ti,j721e-c71-dsp
       - ti,j721s2-c71-dsp
+      - ti,am62a-c7xv-dsp
     description:
       Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
       Use "ti,j721e-c71-dsp" for C71x DSPs on K3 J721E SoCs
       Use "ti,j721s2-c71-dsp" for C71x DSPs on K3 J721S2 SoCs
+      Use "ti,am62a-c7xv-dsp" for AM62A Deep learning DSPs on K3 AM62A SoCs
 
   resets:
     description: |
@@ -111,6 +113,7 @@ else:
         enum:
           - ti,j721e-c71-dsp
           - ti,j721s2-c71-dsp
+	  - ti,am62a-c7xv-dsp
   then:
     properties:
       reg:
-- 
2.17.1

