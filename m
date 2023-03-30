Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3D6CFF06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjC3IuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjC3IuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD903AA5;
        Thu, 30 Mar 2023 01:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427B861F32;
        Thu, 30 Mar 2023 08:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39292C433EF;
        Thu, 30 Mar 2023 08:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680166200;
        bh=7yBtHY7eyhkvfWngnjY3/w+6hO/q9OnKzV1LAIMHOF8=;
        h=From:To:Cc:Subject:Date:From;
        b=gAZ3o4VJCvsp3WH/CbyYytosKiezVnRu/u46VUC2z39ZnX/ntY3B4ZE9MbuPkPPMd
         0RA6qzV9qeBo2jWEeYXX6tey5IKaQr2chQ542lwIgZfsTG/BaNNkq049EPBDPLRFGZ
         CAvBK7vkhK1oNjITQsPcRPIVYvY1RNgk1yT3CD8qBs/UKs9LcCmgUhMZqJYg6nf4MH
         sHt5c0cHXtu5RirXOrwab6mC9t2ojAXHx6BZBY/97iUKTETW4rekDyvu9/VuZ7z8dY
         U+Y87rQYQDOAwJyFRUyAPFDbWaCQscDWWV6BkB+EmHBUnQdCFb+SO2X05uht8HEyXv
         Hy8ues3gb09wg==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 0/3] arm64: dts: ti: k3-am625: Enable Type-C dual-role
Date:   Thu, 30 Mar 2023 11:49:51 +0300
Message-Id: <20230330084954.49763-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables Type-C port on USB0 for both am625-sk and am62-lp-sk.
Series is based on [1]

cheers,
-roger

Changelog:
v3:
- include Type-C support for am62-lp-sk
- split interrupts properties for Type-C chip into am625-sk

v2:
- rebase off [1]
- add fixes tag to patch 1

[1] - https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/

cheers,
-roger

Dhruva Gole (1):
  arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

Roger Quadros (2):
  arm64: dts: ti: k3-am625: Enable Type-C port for USB0
  arm64: dts: ti: k3-am625: Use interrupt line for Type-C chip

 arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  8 ++++-
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 36 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.34.1

