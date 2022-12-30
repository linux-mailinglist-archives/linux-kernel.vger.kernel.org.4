Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D806598B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiL3NZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3NZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:25:04 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1551B1D9;
        Fri, 30 Dec 2022 05:25:04 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOsn1099259;
        Fri, 30 Dec 2022 07:24:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672406694;
        bh=vj4G8ceWT12ju3zLi2UxXx36sPVz5Hq7S2KQBG8t39A=;
        h=From:To:CC:Subject:Date;
        b=YgTU1HmJ+FwLQAfS0ZbZr0SYCSpe81ZMhkONaho9B4cOekstAK2V/LVbv1CwUDLkn
         kv32qIlV5wlLMEMnrBfsbW0GtUP1M+DW35zv3Wiwl9PkN2pGbNYj9+xtN/aIYk6LBf
         zrMRg+j22nTRvb8IU9e1/pDeIxRZtpUr6n1BAJ4g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUDOsZP012810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 07:24:54 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 07:24:54 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 07:24:53 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDOrZN020588;
        Fri, 30 Dec 2022 07:24:53 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v2 0/2] Add C7xv DSP for AM62A
Date:   Fri, 30 Dec 2022 07:24:51 -0600
Message-ID: <20221230132453.32022-1-hnagalla@ti.com>
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

Hari Nagalla (1):
  dt-bindings: remoteproc: k3-dsp: update bindings for AM62A SoCs

Jai Luthra (1):
  remoteproc: k3-c7x: Add support for C7xv DSP on AM62A SoC

 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml         |  3 +++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c            | 12 ++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.17.1

