Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02F61A6A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKEBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiKEBda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:33:30 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9EB26137;
        Fri,  4 Nov 2022 18:33:29 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 85675F1;
        Fri,  4 Nov 2022 18:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667612008;
        bh=0kVuSBCQW7dnCQkFGMlB2Vk2wcSiucoD2YkTfpm6/UE=;
        h=From:To:Cc:Subject:Date:From;
        b=Jk7aKEiTgjXw62nT31xtCXGFBdlrNRSFQ7kKgJfUIboZnpAnHCfBNkgFgeOLbU1YJ
         7LQX+XtTq5P87Zznn2sw33zKvSquli93DmVKKR/F4PzmTEgMhU5woq3o33lOluErzW
         0Vf781mWTnh83efDGWXvSyznyj8ipZtO7ReT5DyA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, soc@kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH 0/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
Date:   Fri,  4 Nov 2022 18:33:19 -0700
Message-Id: <20221105013321.2719-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.38.1
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

This series adds a device-tree for the BMCs of the Delta AHE-50DC
Open19 power shelf.  The first patch adds a compat entry to the Aspeed
bindings; the second adds the device-tree itself.


Thanks,
Zev

Zev Weiss (2):
  dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
  ARM: dts: aspeed: Add Delta AHE-50DC BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/Makefile                    |    1 +
 .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 1094 +++++++++++++++++
 3 files changed, 1096 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts

-- 
2.38.1

