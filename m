Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4116B6048F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiJSOSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiJSORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:17:45 -0400
X-Greylist: delayed 2124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 07:00:53 PDT
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126EC09AD;
        Wed, 19 Oct 2022 07:00:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7D5E40760;
        Wed, 19 Oct 2022 14:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1666184110; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=URJvSDdj3A8sCZTu24AcBhZBWiNAekT3eymuvA4CTvQ=;
        b=nk5pD0nBky1Ni3TLvDrlFvI6m6eWQGc6nEoWEDZdiTKwoJmeJfKGBk2EjaojXTPaDgb3Jj
        xVXTiL6+DVMOh/YH2zjkuiS80pqpW5hKPZwmWAr7OubLfLzo9YqHa6Ym1Ytd1RKM+V7gmA
        Elr0EfpItibsuX0WgFeVlqXw/Wq/kFivh7TqvACLES4SND+3Ph0fWzM8X3Gc/ZlVzIxKEM
        VNn9Lt4139dmnJyd1IGOjDHTrdfqZ5lvg8FolIcVEBXlnLp5nN9iP0RZ1SEZWWjPXxPwFA
        1I4kD0uVVLY3IF9sOIc9gPoUW87g7rKZI0TChJQgApFNuPcQUo9Sye6fHOr5bQ==
From:   Mitja Spes <mitja@lxnav.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc:     Mitja Spes <mitja@lxnav.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] doc: iio: pressure: ms5611: added max SPI frequency setting to the example
Date:   Wed, 19 Oct 2022 14:52:52 +0200
Message-Id: <20221019125254.952588-3-mitja@lxnav.com>
In-Reply-To: <20221019125254.952588-1-mitja@lxnav.com>
References: <20221019125254.952588-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

