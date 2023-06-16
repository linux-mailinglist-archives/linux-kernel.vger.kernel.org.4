Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3C733202
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbjFPNSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjFPNSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:18:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFA2D76;
        Fri, 16 Jun 2023 06:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EAC611CE;
        Fri, 16 Jun 2023 13:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C670C433C0;
        Fri, 16 Jun 2023 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686921522;
        bh=KVFfsiSxn7JYS8i36Z43httvnNgyY9og4aYrwJralzM=;
        h=From:Subject:Date:To:Cc:From;
        b=pyP+ra7lVMuR8hw2VKf0j2poax3sye8mRqMuZH7wMy8POznEDsk30mqhEq8NhudFk
         GhaIL06bmJBdPMb+gqPDYPSEgzEDKGNSQKn+FPnvdsNV7r7K7LTHqTsXeSVndqUuMS
         PivBEY53X/VNzD4t5z0METK4UuzpEhSgGfz54aiId5srHvYTPNuTqpP1w3yXFQtFnn
         120IRfJoZAW96d9Xrr2ub6zSjphpKR8zPoTYmB6bwA/8kpkA+iD6nAxC/IvlUUc19n
         tgx2Bl0+7BVdmMB3esjx7x68G13tvqek7J6H2PIwOaCXPI6TbOBQWpO95EHKdQTTnE
         6FFV+/lvrNtPw==
From:   Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/3] ARM: dts: lan966x: kontron-d10: device tree updates
Date:   Fri, 16 Jun 2023 15:18:38 +0200
Message-Id: <20230616-feature-d10-dt-cleanups-v1-0-50dd0452b8fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC5hjGQC/x2NzQrCMBAGX6Xs2YUkYv15Felhk3y1AY1lk4pQ+
 u6mHodhmJUKNKHQrVtJ8UklvXMDe+goTJIf4BQbkzPuaHrb8wipi4KjNRwrhyckL3NhnK8+Olh
 3shdqtZcC9io5THv/klKhu5gVY/r+l/dh235PPcV+ggAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes board reset and SPI CS# of the Kontron D10 board. Since the
MaxLinear PHY now correctly handles interrupts, we can add the correct
hardware descrption.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
Michael Walle (3):
      ARM: dts: lan966x: kontron-d10: fix board reset
      ARM: dts: lan966x: kontron-d10: fix SPI CS
      ARM: dts: lan966x: kontron-d10: add PHY interrupts

 .../dts/lan966x-kontron-kswitch-d10-mmt-8g.dts     |  2 ++
 .../boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi  | 29 +++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)
---
base-commit: f7efed9f38f886edb450041b82a6f15d663c98f8
change-id: 20230616-feature-d10-dt-cleanups-e79bd2e12518

