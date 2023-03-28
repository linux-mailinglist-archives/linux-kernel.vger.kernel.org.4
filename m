Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2306CBF78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC1Mnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjC1Mnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005283F6;
        Tue, 28 Mar 2023 05:43:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE6046175C;
        Tue, 28 Mar 2023 12:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA91EC4339B;
        Tue, 28 Mar 2023 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680007403;
        bh=HqRo2IiLCl8s8WIcTJePjNjvjxnKWkQIdDVbVRtFaac=;
        h=From:To:Cc:Subject:Date:From;
        b=KVZsKzaP/DBDxYyLwtrFy21b1Sfv2dexAKxDBQO7W4m8h8U5Q60MxLdueXfb6YzpV
         svzGymfxtLffzlQaZ9EB8yPnGbVy+XxY/ho5p4JPwftbWDYCJ4UXNMV2xAkLu55gMP
         9L+OfP/EL1iSRGiQ9+N584mPRTHq6OVEnD/E+FMT1KPvw8ysgk+sqdzq91RgfRs2Fz
         /CVIBJajApgNqi3Orrtcmo5H0stcdkWfcWGdKNosWXtzwtGo8w/38XSpLCxMZJFIVS
         S5srxGuWz2V6s7ZUKyfN22qhjognvA/y+MBdi/lAZW2qhsrcDIT6QTjOulYqORqtfA
         TVw72sVEm2O5Q==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-am625-sk: Enable Type-C dual-role
Date:   Tue, 28 Mar 2023 15:43:13 +0300
Message-Id: <20230328124315.123778-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables Type-C port on USB0.
Series is based on [1]

Although k3-am625-lp-sk USB is exactly the same as on k3-am625-sk,
it is missing the IRQ line from Type-C chip which is currently
required as per chip's DT binding. So we don't add Type-C support
for k3-am625-lp-sk till h/w is fixed or polling mode support for
Type-C chip is accepted [2]

Changelog:
v2:
- rebase off [1]
- add fixes tag to patch 1

[1] - https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/
[2] - https://lore.kernel.org/lkml/20230324133741.43408-1-rogerq@kernel.org/T/

cheers,
-roger

Dhruva Gole (1):
  arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

Roger Quadros (1):
  arm64: dts: ti: k3-am625-sk: Enable Type-C port for USB0

 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |  4 ++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 44 ++++++++++++++++++-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  5 +--
 3 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.34.1

