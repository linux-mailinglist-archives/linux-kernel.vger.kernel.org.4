Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4939E67FFDB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjA2PVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2PVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:21:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E71557E;
        Sun, 29 Jan 2023 07:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675005665; bh=xRgh7PbWbByuQaQYTffFheMpg4Zu7Fic4S+r4wSdVRw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ThSei0M1nvQljzV080X0oty9H14FXdAQeZoA2Mw6aWnuxzTWg4xwfdMNtHFcIWRw+
         53ZIvcf+/t54gavCLDIyI6jSctjETndFfR44DWFp4JrlreUZPHx2S4Zx/H5nlpjOWQ
         NdxRV9kgRget5G9LZuBzUqagFrd2CFHEv1r7eKyffLfwcb3TVj0HHfBXqUVRbdIoEg
         2hlZ9nMi1QnqMpTOVlZbnrY7D0B1KiK8FUiC+1uXwHjo21fYFNrZQ9TeeIAjlg+xRQ
         EGtnogea+/bJo+HNWbjqAuHHA93d0xgFUP2mq2YPqNS4XtoFnWi+PsDzImLLxpZbc1
         Us0N2TJogHygA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1oqiPr0q3e-00nAwo; Sun, 29
 Jan 2023 16:21:05 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mips@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: dts: lantiq: Remove bogus interrupt-parent; line
Date:   Sun, 29 Jan 2023 16:20:58 +0100
Message-Id: <20230129152059.1535947-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:79+nw1R6XzrDUiZM56FJ3RqShSSXfL5QGkYw2TG2nvX2Fn3Lfhc
 Lr3ck/8z/+VDVpR1ruxmNKAQkTpujQjkmwFSj3QvIdBeqZIUat5MLNSCc/D+wOhwKtjKGRM
 yPrsmNeRGlFS3dJxp2svz6SnhQh19cO7QReZrZI13BNltEDIQ6ZLb9BPjuiJ/9ZMGBAx2L7
 2nuvoWj5Kxiq8Z5N8FlaA==
UI-OutboundReport: notjunk:1;M01:P0:GjLIrHJYGHI=;bZzdnh82rfg+slMLyZEISZYjev7
 i+betdkgaSyESjBL4YtqItqH8xWRPFYNDUleTl9kR7ulLnsyOP1M2Wu1HuIroUzXmir0fdyUU
 j7/Y6A9+Edm4jfnIdKZhaTm6Xv2dODzEgAjP4hhg7j6ISWPzAYfX0SJnIAgoAI9SMO76UVcmA
 /l2fzTGL52BSXTaX9lvYGJHrSCQgkJhR+7woVfbw4Kyd+KR5RM7AeTnOcp4KmvVcro9vuDSh3
 RnJgpm5e9iz+rn3ZwrWD7jk7JaYhJCzsF/6qLRa9PhVq4bKnNWK/lfM2MH8Ubiho2YEqKPgTN
 crUn5z7GfSL57g2Oadc5e1hH79tzNIiRHk7UMEMHGgk5Hy63rObfbmKbIl///XGYZnjLbyM4P
 Fc46SC8adAPP6k/F4b3d9Ep13dbh+2uBJQq96c8ycpL6J38tdvvGjsMp1sT0haMsHehIhOkPt
 jQX82XOPCEdglTgGigsvSM+E2UvTcsUfMTR8bL+2mFz6hZd/FtXRo477qQfd0GTpsd9P3Eg0I
 MhKkZ1nSZgTUF4PRmhqboa/6NOkwRWNIKhgxGVGMLtnAKHJ3xOMBylCDc4Bk6X5e1Cm+Pw16H
 V/kvbVOMj8fuWXzleVtjSk39NZLEbJ9AgA+kubdEbnHbnZi2qVbhSNnhzjN2TUK1tuKw0LfgM
 fay5ox2Er75EEbOobSiH9DSpsrHN3fDw7D/id5hWz4NX2G0e1TtLPTBStHy9svE+Y3lLRQv2f
 mmP00cKwBxACoAezuESwqtLLMaqfbs6wJobn6daCXyEKnPbV4vWxT6I3XdWSje/+9tYsdCtBD
 yhRLpWMZK0DBgB1ONmQpfN4biHz1TCKJvW/uk6zoT/k2d2RNZdSxjq4XrQJrF1pEkwZ7P6N6a
 Zo9VCmrJCx7ivQ2yKeWgP3tbnJgtAKj6Cwwqwjd09DDtf+yO3OOjzF/o+KeLz+GLsBo21pipP
 Nbj6dMkCm0ciI7SqB3OJ9+GG4MI=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specifying interrupt-parent without a value (in other words, as a bool)
doesn't really mean anything. Remove one such property in the Lantiq
Danube DT, at /sram@1f000000/eiu@101000.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/mips/boot/dts/lantiq/danube.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/la=
ntiq/danube.dtsi
index 510be63c8bdf1..7a7ba66aa5349 100644
=2D-- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -40,7 +40,6 @@ sram@1f000000 {
 		eiu0: eiu@101000 {
 			#interrupt-cells =3D <1>;
 			interrupt-controller;
-			interrupt-parent;
 			compatible =3D "lantiq,eiu-xway";
 			reg =3D <0x101000 0x1000>;
 		};
=2D-
2.39.0

