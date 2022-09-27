Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5375A5ECBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiI0SQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiI0SPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:15:48 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24563F27;
        Tue, 27 Sep 2022 11:15:44 -0700 (PDT)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.195])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 935608000A3;
        Wed, 28 Sep 2022 02:15:37 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     linux.amoon@gmail.com
Cc:     heiko@sntech.de, robh+dt@kernel.org, michael.riesch@wolfvision.net,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH-next v1] arm64: dts: rockchip: Enable NVM Express PCIe controller on rock3a
Date:   Wed, 28 Sep 2022 02:15:30 +0800
Message-Id: <20220927181531.5546-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
References: <CANAwSgTyt2D-aEMMowO6d+0ddTQb46o0pWMahnr7ny2rjY7iaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGklPVhhDGEJLSUNOH0oaS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJOWVdZFhoPEhUdFFlBWU9LSFVKSUtDTk1VSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46FDo4Lz0hPg44FxM5PBY8
        SB0aCyJVSlVKTU1PSEtJTkhDSkxOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJOWVdZCAFZQUlOSEg3Bg++
X-HM-Tid: 0a8380295c56b03akuuu935608000a3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 27-09-22, 19:16, Anand Moon wrote:

> As per the schematic below pice support with 2 regulators
>
> VCC3V3_PCIE        (SCT2250FPA)
> VCC3V3_PI6C_03  (PI6C557-03 is a spread spectrum clock generator
> supporting PCI Express and Ethernet requirements)

> [0] https://dl.radxa.com/rock3/docs/hw/3a/rock3a_v1.3_sch.pdf

Thanks for sharing, I rewrote this patch, can you try again?

> No, it did not work on my board, see bool logs.
> [0] https://pastebin.com/Lk93VFxg

From the boot log, looks like ethernet is broken:
  mdio_bus stmmac-0: MDIO device at address 0 is missing.
  rk_gmac-dwmac fe010000.ethernet eth0: no phy at addr -1

Actually I had this problem too, and reusing the "snps, reset"
property solved it. What confuses me is am I doing something
wrong or there is something wrong with the device tree now?

Thanks,
Chukun

---
Chukun Pan (1):
  arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a

 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

-- 
2.25.1

