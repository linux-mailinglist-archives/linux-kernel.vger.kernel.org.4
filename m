Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7C644F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLFXPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLFXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:15:35 -0500
X-Greylist: delayed 603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 15:15:34 PST
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7032BB2;
        Tue,  6 Dec 2022 15:15:33 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1F0AB26F48C;
        Tue,  6 Dec 2022 23:57:43 +0100 (CET)
Subject: [PATCH 0/2] Fix Apple silicon PCIe iommu device tree node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/Ij2MC/02OywrCMBBFf6XM2oEkrfXxK8XFJBntgGlDpopQ+u
 +mrlweOPdwV1AuwgrXZoXCb1GZpwr20EAYaXowSqwMzjhnnemRSuo7jIsi5fxkzEGqM6f0wpM3sY
 vH2LXuAjXgSRl9oSmMe4KURkGdAy5na9q/5S7nwnf5/J4Mt237AvIylruZAAAA
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 06 Dec 2022 23:57:35 +0100
Message-Id: <20221206-arm64-dts-apple-pcie-iommu-v1-0-210c56e48c01@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.11.0-dev-022da
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=j@jannau.net;
 h=from:subject:message-id; bh=ZZFxTynA+6FwFphugHBhRyAYwzV6YNAFXdLaVWc0NPo=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuT+E8+utnEf+f2ny/n3hEMMfovTsu59ySq6/nbzjSO3/51O
 /XBjbUcpC4MYB4OsmCJLkvbLDobVNYoxtQ/CYOawMoEMYeDiFICJ9B1g+F+ocaUo/6TH9b0xvB/UD3
 /LbfHoF9J2L84zvFWy8NDTz7sZ/go0LTt/aroEezBf3deChRdLpd3nvVrS9Lg0zfXCyrSju5kA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

the iommu nodes for the PCIe ports were added with the non-standard
node name "dart" instead of the recommended generic "iommu" from the
devicetree specification. This series fixes this for t8103 and t600x.
Patches are based on the asahi-soc-dt-6.2-v2 tag in the asahi-soc
repository (https://github.com/AsahiLinux/linux.git).

cheers,

Janne

To: Hector Martin <marcan@marcan.st>
To: Sven Peter <sven@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>

---
Janne Grunau (2):
      arch: arm64: apple: t8103: Use standard "iommu" node name
      arch: arm64: apple: t600x: Use standard "iommu" node name

 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 8 ++++----
 arch/arm64/boot/dts/apple/t8103.dtsi      | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: d32c1530c7230b756ca9a6b6cf92ce6e60788594
change-id: 20221206-arm64-dts-apple-pcie-iommu-7b0d4d5d4329

Best regards,
-- 
Janne Grunau <j@jannau.net>
