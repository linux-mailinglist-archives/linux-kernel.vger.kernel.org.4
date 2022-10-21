Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46E607914
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiJUOAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiJUOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:00:22 -0400
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5FA10069;
        Fri, 21 Oct 2022 06:59:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C9CAD40764;
        Fri, 21 Oct 2022 15:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1666360773; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=URJvSDdj3A8sCZTu24AcBhZBWiNAekT3eymuvA4CTvQ=;
        b=G+rLlFNGUJHICgyDaEQ4utGFtVOgemmaEn0rDs2i73omeThkUrTeDP6cAdE+zfI7PgwjzX
        kwqtp8L5nKmm/8RLkUIgSnXy8orX2u/ayh192CKme68jgPWgLihWb+VBc+nKQOmEJV+6C4
        OStRoty1o52+u28fRJvRP8PcmnVRMYTyn8Ucv2lF12GVzInr7hhEZBztSlRLBnvbaI70aC
        7DosExs8+aoQwMjvWqKf+UUfjUZF6p2f3NL6Ls3qfeSYqXI5cgw7Gx4NkhWCJRIXN8SeAD
        mxybCK65UMS1qHripm9cC0PSr2DvckSCRwD05wiaywC9uN+HBnIuK222EXEXYA==
From:   Mitja Spes <mitja@lxnav.com>
Cc:     Mitja Spes <mitja@lxnav.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: iio: pressure: meas,ms5611: add max SPI frequency to the example
Date:   Fri, 21 Oct 2022 15:58:22 +0200
Message-Id: <20221021135827.1444793-4-mitja@lxnav.com>
In-Reply-To: <20221021135827.1444793-1-mitja@lxnav.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added max SPI frequency setting to the example. It is now honored by the
driver.

Signed-off-by: Mitja Spes <mitja@lxnav.com>
---
 Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
index 4f06707450bf..08bd06e6dabe 100644
--- a/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
@@ -52,6 +52,7 @@ examples:
             compatible = "meas,ms5611";
             reg = <0>;
             vdd-supply = <&ldo_3v3_gnss>;
+            spi-max-frequency = <20000000>;
         };
     };
 ...
-- 
2.34.1

