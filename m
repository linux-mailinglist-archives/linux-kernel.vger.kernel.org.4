Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652BF657685
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiL1MhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiL1MhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:37:08 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8881057D;
        Wed, 28 Dec 2022 04:37:07 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BSCatOp126422;
        Wed, 28 Dec 2022 06:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672231015;
        bh=O2Hz9Uvtnd+mG34FJzY1H/GA1klNaJL0QZfQb3d9kfY=;
        h=From:To:CC:Subject:Date;
        b=TI1bvCpWE/6Ij7fMFfjrHZck0cNcwJYaRqLDNA4kxmvY+C2qQmPePk5OzEZ4tgOCN
         g+Y/rWANr8f/RbmW6lO0XljFPnkJoxGvrroSx+HjAi+s+2u5SDbsDuvqAgPhduKmzX
         T6MiPH0a2jupG9V92SkPj4djhGIE5L6EpYQ9nros=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BSCatlQ055671
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Dec 2022 06:36:55 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 28
 Dec 2022 06:36:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 28 Dec 2022 06:36:55 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BSCatiw064113;
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
Subject: [PATCH 0/2] Add C7xv DSP for AM62A
Date:   Wed, 28 Dec 2022 06:36:53 -0600
Message-ID: <20221228123655.15384-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
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

AM62A SoC family has a C7xv DSP subsystem with Analytics engine. This
susbystem is intended for deep learning purposes. C7xv is similar to C71
DSPs on K3 J7 SoCs with additional harware accelerators and IP updates
for deep learining.

Hari Nagalla (2):
  dt-bindings: remoteproc: k3-dsp: update bindings for AM62A SoCs
  remoteproc: k3-c7x: Add support for C7xv DSP on AM62A SoC

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml         |  3 +++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c            | 12 ++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.17.1

