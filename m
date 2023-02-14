Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11336961D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjBNLEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBNLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:28 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34B25945;
        Tue, 14 Feb 2023 03:04:07 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id D428526F794;
        Tue, 14 Feb 2023 12:04:03 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 12:03:20 +0100
Subject: [PATCH v2 07/16] dt-bindings: mailbox: apple,mailbox: Add t8112
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v2-7-22926a283d92@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1049; i=j@jannau.net;
 h=from:subject:message-id; bh=/Ydb0OvT3qJpcDD47D2v6xuRWTuFc9FnhBetr3I9XKM=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfPvM9zrnZ9/uCjLx7PqiozwSv81d7N2HtnCdqK9p
 +HRpPnnOkpZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAFwkmeEXsytTwvMFAV9YJpnk
 Xu60USz8qVWwxTa8wEXfS/pC9DEFhv9+KdsbDmg4Ovy3Vn2/6bHqdbWzJlVz14rks651d7FkKmU
 AAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox hardware remains unchanged on M2 SoCs so just add its
per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 5c5c328b3134..4c0668e5f0bd 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - apple,t8103-asc-mailbox
+              - apple,t8112-asc-mailbox
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
@@ -39,6 +40,7 @@ properties:
         items:
           - enum:
               - apple,t8103-m3-mailbox
+              - apple,t8112-m3-mailbox
               - apple,t6000-m3-mailbox
           - const: apple,m3-mailbox-v2
 

-- 
2.39.1

