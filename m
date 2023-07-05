Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5397487F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjGEP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjGEP11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:27:27 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A44010EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:27:23 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V6.0(297522:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>); Wed, 05 Jul 2023 23:27:09 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 5 Jul
 2023 23:27:09 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 5 Jul 2023 23:27:09 +0800
From:   <alina_yu@richtek.com>
To:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [PATCH v2 0/2] Add Richtek RTQ2208 SubPMIC support
Date:   Wed, 5 Jul 2023 23:27:07 +0800
Message-ID: <cover.1688569987.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alinayu <alina_yu@richtek.com>

This driver adds support for RTQ2208 SubPMIC regulators.        
The RTQ2208 is a multi-phase, programmable power management IC that
integrate with dual multi-configurable, synchronous buck converters
and two ldos. The bucks features wide output voltage range from 0.4V to 2.05V
and the capability to configure the corresponding power stages.


alinayu (2):
  regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
  regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver

 .../regulator/richtek,rtq2208-regulator.yaml       | 228 +++++++++
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rtq2208-regulator.c              | 550 +++++++++++++++++++++
 4 files changed, 791 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
 create mode 100644 drivers/regulator/rtq2208-regulator.c

-- 
2.7.4

