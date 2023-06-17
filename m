Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3246B7343D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbjFQU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFQU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:57:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882D137;
        Sat, 17 Jun 2023 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687035421; x=1687640221; i=julian.ribbeck@gmx.de;
 bh=PLZak75GCgsTN4zIfmB6/nHpBvVltfN3cEEBjSeZxvA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tm5xsoUmWjreDv5jr8Om8OHsxl4Ukkfbkt+6BSdtWVBGgmm+Vrm8ZoMtVOBiefBX+pQ9his
 Ijr6AF0CsXRBIyJlndOvSAj0laZDyHqSYX8tbyEF8dgle0F74c+K9E7UImC9Xdfsv/Lzvg8Cf
 MaX/snbv2hyY1M45KN/b0HFIiDhqggBGGqHshMbQ/iqkttGPfbi6ZkcMUVch8RDLGURGzQLeP
 ILRpFdi51z3WsrgM/mUuFtu8FfX9L/DDYcnCX64o16eroz7gRVDOaSeUo8edb2diKchJ6LI3x
 GqyXoQvz/ZklIFZiVOtDDwxsanK+gxDXB6voZnJGBzE4jThwg6GA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x1-yoga-arch.speedport.ip ([93.242.194.247]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGN2-1qQdh51d2s-00JKRk; Sat, 17 Jun 2023 22:57:01 +0200
From:   Julian Ribbeck <julian.ribbeck@gmx.de>
To:     krzysztof.kozlowski@linaro.org
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        julian.ribbeck@gmx.de, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: sunxi: Add itead,iteaduino-plus-a20
Date:   Sat, 17 Jun 2023 22:55:18 +0200
Message-ID: <20230617205624.1178427-2-julian.ribbeck@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230617205624.1178427-1-julian.ribbeck@gmx.de>
References: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
 <20230617205624.1178427-1-julian.ribbeck@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emxx+JikUx3unGNulN2YFus2Bg8k0g3nSa0Fepw3MTAsw/6xJum
 r5G2nSwqlJyB5fuuYJBmQfJt+dnJ+MwZpJhLBNEk3+Mdb42cTPlruD910dUwsedaHzjeCho
 H9+qfOnXsPJKGk7gtaScrvP8l6tXM5/Vt5s9YUD2/E3YBCPfwQpGH9/t/3n9Fvxl1qrZbH/
 DFtMxx9cU8903+TuueFdQ==
UI-OutboundReport: notjunk:1;M01:P0:axGvYAz1uow=;+/rRoE9HnHmb3dgaP3wHkFRE33b
 xQHF63oLN2QNA/JRd3qKEkjoVmncRwBOWWxBnjAj7v7wxrUFFDl480TKCI9i93nll1+P/PTd5
 163B4NoyNyt8iAwVqcqGP3QzoXapCiKvE6JnBxHgswpPh0RCld1iGpA1WnRtQISn1sTXLL9xe
 TeWNwAKHuydDrQzUMTNAB1wyxQBHRSfk6CaSpBwccwSrz2kActlpEjyBHbrFGsrzBM8+9uy3H
 yZtiBJBNb9tpe12mXno1ez37vVXHqczvjZQX03nJGml14Y8FMCVZGqfoTdtcoqRCcRZsxgvAY
 RCyagLwMmFKatcKi3isnK0YGlj9KBzqCsliMp1tSGwIiRWyK3+dp6pJAJKZkeIGaRyi6qRnCu
 N1U4CKPL3ZU0RS/8JMtRK2xfFA07Z847QOYtHS2tpda3YXxx5TbOk1K9h/2DuoJFgp5yJxkVS
 1RefbleZ2UEFaAJROV8qpaZ6+4LCs8QjomwK/5yeNvci57R3w3sU7T4229VuVag11qVcEVq+j
 +1o1sKLixoFF7O8ECbS8zGdDTNpTtNl3f333rIQynxnsFW6cRXmpsq043YfFHKZ7ElG5rori2
 rTPMfDPTqdQmSGJdvB3y4BHhvQu2owT9p12k7oDBXWJ+kX/Qn79pnWN/b4owZkI+fcgcl38QR
 9jhL4JMhML9yIktXdpDA9OQI7uQ8wB66J9sRec4RgaYFI87HJOcFU7gNKO4M5mp4jD5tV+g6Y
 KnHOgfGzXK6ffilftSiYUtBy+luNR4DSIomhuzTnkvzatePU4euKBqa7Ly4H3ZToxFHMUwTiw
 z3uU6QDBH6/2YJBXjlrOC33TqMuWNI1HjHATH85lSNVvKkA8NFf5pywZR9Nq5jgTbqrAt8yzl
 4dgt7VAq7QOzUw0mCaeWijvAiL5187HdWaw9Ectbg3W5CjS3JGadf6BEOYil8V9ZIrZyiYmUO
 Lt8U1ay3XuyNJ/4323h0FeSHruQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add itead,iteaduino-plus-a20 bindings

Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
=2D--
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentat=
ion/devicetree/bindings/arm/sunxi.yaml
index 013821f4a7b8..aaa9a96736b7 100644
=2D-- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -356,6 +356,11 @@ properties:
           - const: itead,iteaduino-plus-a10
           - const: allwinner,sun4i-a10

+      - description: Itead Iteaduino Plus A20
+        items:
+          - const: itead,iteaduino-plus-a20
+          - const: allwinner,sun7i-a20
+
       - description: Jesurun Q5
         items:
           - const: jesurun,q5
=2D-
2.41.0

