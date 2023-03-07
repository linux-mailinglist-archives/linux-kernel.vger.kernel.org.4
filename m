Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046DE6ADE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCGMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCGMKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:18 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764D2574FD;
        Tue,  7 Mar 2023 04:10:16 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1E96A26F891;
        Tue,  7 Mar 2023 13:10:15 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 07 Mar 2023 13:10:18 +0100
Subject: [PATCH v3 12/15] dt-bindings: clock: apple,nco: Add t8112-nco
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230202-asahi-t8112-dt-v3-12-d1a5f6383d95@jannau.net>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=j@jannau.net;
 h=from:subject:message-id; bh=fMPj5crwscCjCF6wuCOksaYtnate8ApH0BFsWpiUj9Q=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zYUcwvvjZbb+lw5e1NEhlrBVQjHu1OKA1GNhgdu7q
 8L0O/g7SlkYxDgYZMUUWZK0X3YwrK5RjKl9EAYzh5UJZAgDF6cATGSVAyPD0l7dbZUrYzdP8nZ5
 ePZq8sdjqo3mr8Wnr956eV76gy3Z8xgZbm4xDPu6I6OzeNPBOLOLe5fKTKxVdiu/bDt5/XRr36a
 THAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block found on Apple's M2 SoC is compatible with the existing driver
so add its per-SoC compatible.

Acked-by: Martin Povišer <povik+lin@cutebit.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/clock/apple,nco.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/apple,nco.yaml b/Documentation/devicetree/bindings/clock/apple,nco.yaml
index 74eab5c0d24a..8b8411dc42f6 100644
--- a/Documentation/devicetree/bindings/clock/apple,nco.yaml
+++ b/Documentation/devicetree/bindings/clock/apple,nco.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - apple,t6000-nco
           - apple,t8103-nco
+          - apple,t8112-nco
       - const: apple,nco
 
   clocks:

-- 
2.39.2

