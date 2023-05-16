Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E462704C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjEPLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjEPLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:33:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885A31706;
        Tue, 16 May 2023 04:33:33 -0700 (PDT)
Received: from localhost ([31.220.116.19]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mgebs-1qfvqJ3NM4-00h9en; Tue, 16 May 2023 13:33:15 +0200
Date:   Tue, 16 May 2023 13:33:15 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] MAINTAINERS: Add Honeywell mprls0025pa sensor
Message-ID: <ZGNp+1uNAxi3uxjM@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNpZM137jF5yzie@arbad>
X-Provags-ID: V03:K1:peVyRgwjHFGVxMrgmPGl1jAtQyPNxbiY2xOEXrNk74SQiTDEaK0
 6fHP1dR5YNNj/93fBEGOXD0bvPRahRQOJMHWQGe+8XBEr0ohqW2+9rfyzYQhOFW2KNNgAui
 8IsIK4BqemzPnxrCWXiZ2WM9qNOlOVqw4iOX3BJ1/1RkgW8IF0WjbpKv288sE1NUMY+O5yl
 XJos9c+Gsl+Hs2gf7uflA==
UI-OutboundReport: notjunk:1;M01:P0:07K7YA//TZ8=;iyp6BNkczS70A5Qz2B5EnqB8xe9
 1X4yUpGVtd8+1cpl0xH8+yq/d5aoYktFtEijleXqRIKh+YFr6y7XhiuRBU3VkopY8Hv/v+hGV
 5si6mI+aOmiZE5sg308j0eYjDdKIkz+lPZLZWmGOLC9/yTroRihRoYHctEIe9PG4MUqvKzx4h
 CPECRMoGybiPW3yw/xlCDCCbWjWjx3+zeyAb07w8L66i9U5adCVCPO3W0+zxn3cJwBAKJMIbL
 wYklWISxPKe7ZbFno6Mq/tmddc9XNeLnKekGTR8ZgdRedtjITihGP7g38CAH3jNaRwqstNXkJ
 RgJHnyPzobgp6sFui5nKvE60D8K4jeFiw1cAyQ633iPyk0sOLj3B2vWVc+eDmHl+cqcKY4ya8
 GnVN3DWP+esjaB0+na0KSFEBcDe12nKTMJtlIwj9SYgCvfXs+B8yqDq38c/JDUKhCGsw28Ho4
 TXe+t0d+kffDoNHJhOfqz52p65FGEg8YOoRFIRXmHc6Jrm0YbzZVSwB/lx5DhEGOXZnKQFYQV
 oPgNw9wCUv0SxODLLlRmtiDHbCUP2T4ec8aM0Gn+i/JXp1lEsm5Lm0q4VVnFI2II4KCVfuP4+
 GXBHl5l+R8ae90rbGY17dulxp1qjj1GdIp3zKt/rqcGIgguHp4kSLmignlO0XPfUdKgRT0u9q
 cj5IQ9nQBqvG1BAEIvWeJIEgOCHlDBqEQYknzG5cBQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer for Honeywell mprls0025pa sensor.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb54104..7b68ec3fba88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9361,6 +9361,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL MPRLS0025PA PRESSURE SENSOR SERIES IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+F:	drivers/iio/pressure/mprls0025pa.c
+
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
 L:	linux-wireless@vger.kernel.org
-- 
2.30.2
