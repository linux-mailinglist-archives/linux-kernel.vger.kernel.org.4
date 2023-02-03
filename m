Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2268976B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjBCK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBCK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:59:30 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 02:59:30 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07176485BB;
        Fri,  3 Feb 2023 02:59:29 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 89C96C9B;
        Fri,  3 Feb 2023 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1675421655;
        bh=zMTD0629OFytbQ7QmqrxIeQqcloKLZRLUV9dsgDvbA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+Hs0J7jyfUIkqau7qT3JMRsZFycqKYbbAMBk3zfAw6Q7y8s3yo46pZ6SFGlP6XmW
         jdT9Tz3LjfirlOrh4t1QCWl6EBwB6N1BwAuRjVJ1ND9qq/rLkYvcFASIo89sF5OGzP
         6QhgXGEmdDZxc5T6uRsSeVaARWIn4YyjNjTaYimw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: aspeed: e3c246d4i: Add PECI device
Date:   Fri,  3 Feb 2023 02:54:05 -0800
Message-Id: <20230203105405.21942-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203105405.21942-1-zev@bewilderbeest.net>
References: <20230203105405.21942-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've got driver support for it, we might as well enable and
use it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..67a75aeafc2b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -202,3 +202,7 @@ &kcs3 {
 	status = "okay";
 	aspeed,lpc-io-reg = <0xca2>;
 };
+
+&peci0 {
+	status = "okay";
+};
-- 
2.39.1.236.ga8a28b9eace8

