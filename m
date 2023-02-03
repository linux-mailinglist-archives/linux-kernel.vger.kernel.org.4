Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB1689765
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjBCK7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjBCK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:59:30 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 02:59:29 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD88825E1E;
        Fri,  3 Feb 2023 02:59:29 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id CF2E13C4;
        Fri,  3 Feb 2023 02:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1675421655;
        bh=Ch3jIrqzLLO1RgMMeN6WVOGy2TVSQx5KsM9SaZGkzB0=;
        h=From:To:Cc:Subject:Date:From;
        b=RYnORqcuYn2xQA6rNMqf2uDffWYNIB5eOt4Pb8fBD+9LtPs2UvlqoPHkCqMBoqI+3
         JPpRuy9y87ijlkKMD+ywMS0yPZikDEYYgfjaEH9KANtxVc2S9+xOizDJbxlEtOuzU4
         vKPy0dX/X4XDhIKCPmpmQ/8cVEmVNKHXW9EdadwU=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: aspeed: ASRock BMC updates
Date:   Fri,  3 Feb 2023 02:54:03 -0800
Message-Id: <20230203105405.21942-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
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

Hello,

This patch series contains two small device-tree updates for ASRock
BMCs -- an LED polarity fix for romed8hm3, and enabling the ast2500
PECI device on e3c246d4i.


Thanks,
Zev


Zev Weiss (2):
  ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
  ARM: dts: aspeed: e3c246d4i: Add PECI device

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.39.1.236.ga8a28b9eace8

