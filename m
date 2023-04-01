Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA66D2F38
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 11:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDAJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 05:11:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0851DFB1;
        Sat,  1 Apr 2023 02:11:10 -0700 (PDT)
Received: from localhost ([31.220.113.145]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mtf39-1qZPI03zax-00v4wo; Sat, 01 Apr 2023 11:10:32 +0200
Date:   Sat, 1 Apr 2023 11:10:31 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add Honeywell mpr sensor
Message-ID: <ZCf1B9kfw/N0UX8Q@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:+SpYBL9XUuaxVvcOd+Xa/H15Sggz4tlt2F5ussYBUYtGy2o+lRJ
 nTkYE1a+U7gwjcIvIPvF8TW9iEbrMEW9F9fdkwqNg2OeugAIulNUjelciOFemS93YbkzRYI
 Q4r/LtG0sqDckIFPsFADPEfMEtsPn+NkAwkhySHN4h3qyFns7yYhfZmB9F+kl7qj3Xib2Ig
 U6bNX6FT8J89CUpivor9Q==
UI-OutboundReport: notjunk:1;M01:P0:gR3PWmdETf8=;ELNuFfHEw+Obv/7hew4ApnBsZwr
 yG+vUL0qa/aT6O838DrY5eLsNjNd+zokfRpZ4RQoWlUxZEJ9AMzMQWpU1tX2TDF9lKje3VphV
 I3Ocwlhrjfi4wgEcG7CV+A5XA41LoOQon2AnRABbxWdnWK62iMmoWB/UVMqWrExWUox6M+/Lb
 opl/Dm4O3d9Jo66e55+ilrUMmRNOesq0Cgb9U0qj1ih+ctgQk9WSfztCAtN3CkH6xeItqOwOL
 CjPL8gikeXvCaoVwFOpKo3GElCDij+jlUModA5YVoXmwmyCfE2KAk/4wYH4PF3mqDqBRcW/rs
 z991ln1GOrTtxV527albZAbpGv6ub9WrXAoQspo9FuigGNsDbpzCGhHyUKMcArrg5AQRvFPAD
 1VarKgyqc5quwSY6LUVMpK/3X+DRYGmfyX+XTSomT4tKwqYL9VHZ2H6tiHDu7uUJNL/X34ZuD
 SsfTZt8qvaNYbzYuyA8jbq+MCZW9OMh+OwN0+m9qVg6yZwNrWklbMZOT4qzUBxV4KJzbOz9wS
 YIWl/ax3KNGWZz2+Jh6AGPpinzA6daj0db+0fSuwlY3Mvk0K+yw3rQUYzFku9a6Y+4rHO+W+y
 FGlDPyV7KUNOhCvnfNngDbTLXwMMk3+6VjtGGeSf4KwJ9QYfzkleoH1SJvJSmRX67LeQdP67Z
 2WVgjbKF2zN83fBRB6o8cL+LyHIuia33tXRwA8+YsQ==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a maintainer for Honeywell mpr sensor.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1dc8bd26b6cf..126a67f6dbc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9360,6 +9360,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL MPR PRESSURE SENSOR IIO DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/mpr.yaml
+F:	drivers/iio/pressure/mpr.c
+
 HOST AP DRIVER
 M:	Jouni Malinen <j@w1.fi>
 L:	linux-wireless@vger.kernel.org
-- 
2.30.2
