Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FE62048F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiKHAQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiKHAQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:16:02 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD1524BCD;
        Mon,  7 Nov 2022 16:16:00 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 39228216;
        Mon,  7 Nov 2022 16:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667866560;
        bh=VIkVQ5MTYduxA9TI2MvsFc6HLebHjxk8Luy5qKBI/ok=;
        h=From:To:Cc:Subject:Date:From;
        b=HIioipVNI5LZeGOhYsQxaD1DVC05XZ2NBPQpUo/BYR70nUO9y0A4gk9yKPSz5Dhoz
         mXCjsgZk07ildLOPSNOZ5bTxKau1Tv6i4Ir8Tc59b+UjTh6aBEl8fIBV3yhz+dQFIA
         g1fG/872VyNtaIrf4lfEnn23NBv+H1EYpHfCaekw=
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
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
Date:   Mon,  7 Nov 2022 16:15:49 -0800
Message-Id: <20221108001551.18175-1-zev@bewilderbeest.net>
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

Changes since v1 [0]:
 - rearranged patch 2 with macros to reduce boilerplate
 - added ack from Krzysztof on patch 1

Thanks,
Zev

[0] https://lore.kernel.org/lkml/20221105013321.2719-1-zev@bewilderbeest.net/T/

Zev Weiss (2):
  dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
  ARM: dts: aspeed: Add Delta AHE-50DC BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 418 ++++++++++++++++++
 3 files changed, 420 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts

-- 
2.38.1

