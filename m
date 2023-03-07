Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84626AE7BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCGRAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCGQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:58:51 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175E943BC;
        Tue,  7 Mar 2023 08:55:20 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F2D4C000A;
        Tue,  7 Mar 2023 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678208119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k63jGN/pF5yVaAtIx4C9Ich6YXdGC8EJlNRF1GK/q1I=;
        b=UFBRY4l/f08YOv+HYmfpChl6+sKBr3zSHIW7SXpp4bKwfeufsZPq1IsDhyAzOmm047DR+0
        9R++NTCF2LyrXgZTT3rJnUhVvm8CPYRIbwH2lD24DoHadXsRsqA1b55QFAh7UKwpK2O+jC
        PaHVdYBhp/QRio55ivxzKm2ztdvm6EJ3z+eQqOeq4yKg02abSwqJTdFiRdjF9tBJDwBgYw
        6M8BPviPJgdHwdw1Y7pe/2EC1UtMZdhut64C6H/n9bLE9qttt3yPM/5m7SA1YZaR51nAxw
        aLW3pS2fEAAOu8XNHGFrxAoK+rS61UJffI7S5gv9V7yessuyF4pj6Cw1Mv1Isw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 21/21] MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
Date:   Tue,  7 Mar 2023 17:53:59 +0100
Message-Id: <20230307165359.225361-22-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307165359.225361-1-miquel.raynal@bootlin.com>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the introduction of the bindings for this NVMEM parser and the
layout driver, add myself as maintainer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70aa4547d784..60b8f2c07e7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15577,6 +15577,12 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/oxp-sensors.c
 
+ONIE TLV NVMEM LAYOUT DRIVER
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+F:	drivers/nvmem/layouts/onie-tlv.c
+
 ONION OMEGA2+ BOARD
 M:	Harvey Hunt <harveyhuntnexus@gmail.com>
 L:	linux-mips@vger.kernel.org
-- 
2.34.1

