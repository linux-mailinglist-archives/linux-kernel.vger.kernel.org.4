Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037816E9CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDTUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjDTUBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:01:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D925FCD;
        Thu, 20 Apr 2023 13:01:35 -0700 (PDT)
Received: from localhost ([185.104.138.31]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJn8J-1pZyUK3Zij-00KBW7; Thu, 20 Apr 2023 22:01:14 +0200
Date:   Thu, 20 Apr 2023 22:01:11 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Add Honeywell mprls0025pa sensor
Message-ID: <ZEGaB7giQt5eoIpV@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGZYiS0znC2/fZC@arbad>
X-Provags-ID: V03:K1:4POYiiMygpm3hHLWPppWuZwx2MtHDx0BLAP76vXTnZBCUN2ayUv
 xLJ9xM+bxDOjghy9JZ15RpcmDoXmXuG0Yclle+s5Az+59EZNgN4/45MPSRpXdEa4vEQXN+J
 vx7k1vuZDK+xXPnPaT6raFNAu2nLX9eIeu35NejOiKGel9jJu5kJow0T3LhLiXrkT7GvULj
 0ZlLOk3x//ZAe8tDbHg6A==
UI-OutboundReport: notjunk:1;M01:P0:XAmakBmbzsA=;d9g+1FVnKmNn+jk8GveAKlYEuv2
 PGswmCESj29qpgoNNcGGGhJOw7YudhlfHqW8cDg/olGzuPm4FdeZRueamjQ5rsSpXMpo6ki/Z
 vgMDkuWR6Qfp0MdXDMX47MSJoTm89k5uyFmRkub60KMTZnQlD2wcdzpHysvBdYef4fq4cZ2qu
 7xZ9wzqMqXN3+8gdUy0a/6mKxhr7fY0WSJYVkW+J0sIGnnF/8r7sN68c/sdVC6f/m6HbV4wQC
 1rWVrDIjzh1cZmSrIghIwJzuAxUvaNRhb49OBp8A/5ftZ6VLxJrxcq/LidY4AgwzUCROdoufB
 9CFe3WcPeq2XctQzhnUaqiyTkUaVpqCH8PdwoLdxfo+WiErQ23Or49Vxec4vBUxxe3Sx2kRoE
 WrCTO4oSRKXZyTqBd9hfmZtzEvH4M8sDBcOqqmZmEa29lsDlNaA2j0ovJnyDw6v0l5N/VcYKT
 gTJkPDv70NaiUwDr08Gg9+N6aFK92eSqARv5UFic5pz6nqCuG5cKrstp4Q8P6uh/mD3vZyhlS
 JCI+4NvOPIlKZwUjIKI4C6t+OxaZ0NpbHZ15IlAdhnrGSTCRKbFB1nOwgXwW+4NnyxWPyGtDv
 6m/3a9Pf+FGRueIo8zYEmia00Tfl/1GGDNpLSEufyAVQxSjPxE2S/7njlggjInBi8FrHOJhcI
 ISv/rLH32wogLGnVPwnfrhdgFErN/xyjNi5D6teMLA==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
index f77188f30210..0f42f88f8959 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9475,6 +9475,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/vm/*hmm*
 
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
