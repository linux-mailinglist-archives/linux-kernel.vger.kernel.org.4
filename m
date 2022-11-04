Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E31C619D75
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiKDQip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiKDQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:40 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3D2E68D;
        Fri,  4 Nov 2022 09:38:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BACF1C0007;
        Fri,  4 Nov 2022 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qX2H0ur2OnCIgQeP/+gCTgWmky+YXYnfa5R62aawbFk=;
        b=itdUWKp0OmmDnDJESvme0X3wZnc7hPuqS3zHyYW+2+mowPgKotWMs9TqhCdXNX0867vDSj
        AlDVLdR7YwdnvTMHWcBHP3HqhCpbFGD9P8/pDZLCOwYUCArMLneRHT4/aBnMCHqgIET3HU
        nAltOxSf2nXyu78KxUbEwHXGto/a27CoRB2MvdVtL01jryrnAotDVIbseMWxXN2xqSBcUX
        HCTTcCm9nwRDp1+2wXJmlabzelDqvGeE4lRILIIdldXHgRPJUQ7c3vd9d18I0rIrB3KsQm
        e+IOdAy7R3wqh120QlM5wKqxhhXJ/CBCmirCEeQZ3E7kGOLQLGWpmsUDkzNu3g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/6] dt-bindings: nvmem: Fix example
Date:   Fri,  4 Nov 2022 17:38:28 +0100
Message-Id: <20221104163833.1289857-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Despite not being listed nor required within the top level nvmem yaml
file, the "compatible" property is mandatory and is actually enforced by
all the nvmem provider bindings.

Unfortunately, the lack of compatible in the nvmem.yaml to level
description file lead to the example not matching anything and thus not
being checked at all.

Let's pick a compatible almost randomly (one which is already used with
the qfprom label) to make the example at least valid on a semantic
point of view and getting it checked.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 1eb22dba364c..0455506fc30f 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -67,6 +67,7 @@ examples:
       #include <dt-bindings/gpio/gpio.h>
 
       qfprom: eeprom@700000 {
+          compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
           #address-cells = <1>;
           #size-cells = <1>;
           reg = <0x00700000 0x100000>;
-- 
2.34.1

