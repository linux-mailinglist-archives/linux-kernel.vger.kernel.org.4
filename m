Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ECD7020D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjEOAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjEOAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:40:48 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86546171F;
        Sun, 14 May 2023 17:40:47 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 2EDB9139D;
        Mon, 15 May 2023 02:40:46 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1684111245; x=
        1685925646; bh=xl+VA9Ad46B1yVLIPQ7112+42HpIeEILYeifuWaP7dU=; b=R
        cNn4zzG1k2XgCWVF3m+AJm324PsoQWpu2R3umtF/0x4gcsHOLWxxokWZ27Pjbtsw
        qcX8sMiAGnkhWw8gycQ5FzU2jkv1Z28TObH5ZoZAheEAj5hOeC/iqGW/7wsd6OEa
        U+yOw5p3My3S6CzI14broinzSGO5BzTTtmc1MUDQ8zVdd+jVvleKZX3s0pD1wh2n
        WQiesrpqEgwsPg358b7gxP5dpHLaMtAfXE5hsPtMGlCEbpCLzIH7BZwLsH1obaQe
        H3zKFYkS8aUOeh+r2Grq0DmE/rjK8xCLiqC1CgLjnhjoj00tJTo/zLoPvp09zEzx
        b1kMp6ghqJHOCkkrpN44NfzrB5AMgmjdZfp+GNH93cZMIg/jvGabgai4lgkbRJHO
        rDvdGmYe35ZTynMVCUK9TbA93dpe+lZvvpL93AZTlGRSm8lnQlA/biSYiF+tQMqF
        qGe1OeP1BqeOraotTbuQFWlS9XwZ7YOS5++J49owOle+6EJboP7DVOfz3LmwZSFo
        UuDxAzNWpKGNm681SxfYQTr0nuT5eTyoejGVOuns5wy0erbp/+77KqAIqEDTvAXO
        C/fU9WibwKVQQJe61WTftMKA6xAHwGsbABgQmpwjBNSLfuxt8HZJDcfTKtRNikU6
        tGfOL7EPtpzJ2+ONLrM9uN664Z6GbaTcXwRPo2reW4=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 997h_OOvf3ad; Mon, 15 May 2023 02:40:45 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 4092B1071;
        Mon, 15 May 2023 02:40:45 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id A57253E6D;
        Mon, 15 May 2023 02:40:44 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech, Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Date:   Sun, 14 May 2023 17:40:25 -0700
Message-Id: <20230515004025.1133572-3-alison@she-devel.com>
In-Reply-To: <20230515004025.1133572-1-alison@she-devel.com>
References: <20230515004025.1133572-1-alison@she-devel.com>
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
Acked-by: Rob Herring <robh@kernel.org>

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

