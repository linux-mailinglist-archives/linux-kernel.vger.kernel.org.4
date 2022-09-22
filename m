Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C778C5E6D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiIVUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:50:16 -0400
X-Greylist: delayed 1431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 13:50:12 PDT
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [91.232.154.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4C895E8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Po6vzZmNzClxxFClWVg7wKpKmGDMlAFUgeKGJciLKX8=; b=fczVQSSe3ThT328pKIesOrdoVO
        taOSt5Nw4KgACRRWMfYeZA3NVvx4ODXnwGoeJOx9O9hWu3lCLh2VvmvjgggAb4lGFJPzHzVrXrIfz
        JsIszOWHOeQVGeAq+y6dZNLpCnCwXhImpoVmuPXSANP+i6rpe1ofKSpxaN1k/jPXxHxgvTYoWUI5U
        oC4/6IZ2/oVyOu3XGPyQqBRcIVjNKpyAOI+Yv1LjwZvqLvj0kxGy/LZqewKBoly1ZZL9kRr25PNh2
        hivePFlhIJYcZYfqoP9lwHRp8wBVVxFOLt1ygN/SfWlhO/zw9g9pB3JitNM3ExIj1OntMvuPsadGS
        zEmCa4wg==;
Received: from a88-85-156-139.mpynet.fi ([88.85.156.139]:50262 helo=localhost)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obSld-008pZa-3o; Thu, 22 Sep 2022 23:25:54 +0300
Received: by localhost (sSMTP sendmail emulation); Thu, 22 Sep 2022 23:25:50 +0300
From:   Mauri Sandberg <maukka@ext.kapsi.fi>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Date:   Thu, 22 Sep 2022 23:24:56 +0300
Message-Id: <20220922202458.7592-2-maukka@ext.kapsi.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922202458.7592-1-maukka@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 88.85.156.139
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: [PATCH v2 1/3] dt-bindings: arm: add DT binding for D-Link DNS-323
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for D-Link DNS-323. It introduces altogether four new
compatibles: dlink,dns323, dlink,dns323a1, dlink,dns323b1 and
dlink,dns323c1. One is for the common parts between the devices and
then there is one for each three hardware variants.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
---
changes from v1:
 - split patches, this one adds bindings
---
 .../bindings/arm/marvell/marvell,orion5x.txt         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
index 748a8f287462..ead80ed2262f 100644
--- a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
@@ -23,3 +23,15 @@ board. Currently known boards are:
 "marvell,rd-88f5182-nas"
 "maxtor,shared-storage-2"
 "netgear,wnr854t"
+
+The D-Link DNS-323 has three different revisions. Their common parts are
+collected in:
+
+"dlink,dns323"
+
+The three different variants (A1 being 88f5181, the two others being 88f5182)
+are specified with compatibles:
+
+"dlink,dns323a1"
+"dlink,dns323b1"
+"dlink,dns323c1"
-- 
2.25.1

