Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC8643DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiLFH4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbiLFH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:56:11 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2EF16585;
        Mon,  5 Dec 2022 23:56:05 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id 759E02014B; Tue,  6 Dec 2022 15:39:52 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670312392;
        bh=Y9VjQYUTWPgGPU+gA/sW1CnStQU+2E1SsBU/ovcKpcM=;
        h=From:To:Subject:Date;
        b=KE2Jd6WrU4ZruEWCJdTbqYmQjZ62QPHk7PjRfJvo59bmUrsg5r+Zibr/7UlKA8qZX
         iSpTCQHt7S0dn7auxrjlABdufaU1BNRdlpy/dE4+zFRUSSEJm8QZDIJ7rVDXErp4Yc
         jPvIYLACUuGL2rQunJmAG2K84oz/UGEQWxWP1kPSVWpvh0p8AMkPlGwstcA5MmeUM7
         IrdoZLaBTlS8YeraaHrkO/b2EdIm8KOZJJ1tdYXdOgKAfJEshrjyn6lNlBUmOQlNsu
         geX/hIYpRAEFWddSs0Qv/2zkJjuFbj0fC/8alf1KtcMXEBrVkQ/R+od4bozQ7lSxv7
         E96EKobUpQb2A==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC PATCH 0/2] Add reset control for mfd syscon devices
Date:   Tue,  6 Dec 2022 15:39:14 +0800
Message-Id: <20221206073916.1606125-1-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series adds a facility for syscon devices to control a reset
line when probed; we have instances of simple register-only syscon
resources that need deassertion of a reset line for the register set to
be accessible.

Rather than requiring a specific driver to implement this, it'd be nice
to use the generic syscon device and the generic resets linkage to do
so.

Any comments/queries/etc are most welcome.

Cheers,


Jeremy

---

Jeremy Kerr (2):
  dt-bindings: mfd/syscon: Add resets property
  mfd: syscon: allow reset control for syscon devices

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +++
 drivers/mfd/syscon.c                          | 23 +++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.35.1

