Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C875E6F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIVWDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIVWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67163F1624;
        Thu, 22 Sep 2022 15:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046B362373;
        Thu, 22 Sep 2022 22:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88875C433D7;
        Thu, 22 Sep 2022 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663884196;
        bh=y+77KBXZol4WBiZ164SK0oly/RSyy8n+02CZZWHAZXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDc+79A02Ji2hLuNgXu4bjqixhtEOIRNk2WBjICG+v3bPDMTHYBUegz4jBl9NluV+
         750UjKD787VVGPN0SpdrN6SYgQYrpxqfdUdYkqrSCU1NwCZWmsKlpA3NAn87EpuxDX
         LPj9CewSqk2gHUNKm3xzmTPR1n+YtBwv5Og5ASIyzAP0gIqMZOvAOK37n99zqz/FCb
         qk6CyDnyOJl/SNeFAYgdtbq7V5xZ72FudPh6naRDSoFZYa2qAlnWSwc40LnODKFHBf
         +isAhO/IpKoOprjnoo54oGM7NJtzmL+3v19gZZ39RmEyBN+Ioqj3YZNmmGWK7l7QXh
         AnP42YNomu34w==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCHv2 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Thu, 22 Sep 2022 17:03:06 -0500
Message-Id: <20220922220308.609422-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922220308.609422-1-dinguyen@kernel.org>
References: <20220922220308.609422-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the optional "altr,sysmgr-syscon" binding that is used to
access the System Manager register that controls the SDMMC clock
phase.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: added
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index ae6d6fca79e2..aece6a337262 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -38,6 +38,18 @@ properties:
       - const: biu
       - const: ciu
 
+  altr,sysmgr-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the sysmgr node
+          - description: register offset that controls the SDMMC clock phase
+    description:
+      Contains the phandle to System Manager block that contains
+      the SDMMC clock-phase control register. The first value is the pointer
+      to the sysmgr and the 2nd value is the register offset for the SDMMC
+      clock phase register.
+
 required:
   - compatible
   - reg
-- 
2.25.1

