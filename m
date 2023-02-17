Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1496A69A68E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBQIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBQIGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:06:38 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D281F16AD8;
        Fri, 17 Feb 2023 00:06:35 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(23443:0:AUTH_RELAY)
        (envelope-from <chiaen_wu@richtek.com>); Fri, 17 Feb 2023 16:06:24 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 17 Feb
 2023 16:06:23 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 17 Feb 2023 16:06:23 +0800
From:   ChiaEn Wu <chiaen_wu@richtek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <sre@kernel.org>
CC:     <cy_huang@richtek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <peterwu.pub@gmail.com>, ChiaEn Wu <chiaen_wu@richtek.com>
Subject: [PATCH v3 0/2][next] Revise Richtek RT9467 documentation compatible name
Date:   Fri, 17 Feb 2023 16:06:04 +0800
Message-ID: <cover.1676648773.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series revise Richtek RT9467 documentation compatible name from
"richtek,rt946-charger" to "richtek,rt9467" and rename the file name of rt9467
documentation yaml.

This issue was reported by Rob in this mail.
(https://lore.kernel.org/all/CAL_JsqJ4gueN3UFfea5JC6xfPjaH6a+7+dioTw=s0W-gBf6Anw@mail.gmail.com/)

Thank you,
ChiaEn Wu

ChiaEn Wu (2):
  dt-bindings: power: supply: Revise Richtek RT9467 compatible name
  dt-bindings: power: supply: Rename the file name of RT9467 charger
    yaml

 .../power/supply/richtek,rt9467-charger.yaml       | 82 ----------------------
 .../bindings/power/supply/richtek,rt9467.yaml      | 82 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 82 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467.yaml

-- 
2.7.4

