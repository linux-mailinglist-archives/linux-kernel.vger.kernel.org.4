Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9532C642CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLEQYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiLEQX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:23:59 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCE13D66;
        Mon,  5 Dec 2022 08:23:57 -0800 (PST)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.194])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 9A038800056;
        Tue,  6 Dec 2022 00:23:39 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     aholmes@omnom.net
Cc:     devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        frank-w@public-files.de, frattaroli.nicolas@gmail.com,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, macromorgan@hotmail.com,
        mark.kettenis@xs4all.nl, megi@xff.cz,
        michael.riesch@wolfvision.net, pgwipeout@gmail.com,
        robh+dt@kernel.org, robin.murphy@arm.com, s.hauer@pengutronix.de,
        yifeng.zhao@rock-chips.com, Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
Date:   Tue,  6 Dec 2022 00:23:22 +0800
Message-Id: <20221205162322.149967-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221112114125.1637543-2-aholmes@omnom.net>
References: <20221112114125.1637543-2-aholmes@omnom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRkYVhhMSxhMHUlDGkpNTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6KQw4Ez0fSw8*TA0VNSsP
        DUswCQJVSlVKTUxLSU5MT0lLT01JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJPWVdZCAFZQUlNTE43Bg++
X-HM-Tid: 0a84e319a72bb03akuuu9a038800056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The register and range mappings for the PCIe controller in Rockchip's
> RK356x SoCs are incorrect. Replace them with corrected values from the
> vendor BSP sources, updated to match current DT schema.

Hi, Andrew

This patch broken pcie3x2 on my board.
And the wireless card on pcie2x1 is still not working.

[    0.405341] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    0.670522] rockchip-dw-pcie 3c0800000.pcie: can't request region for resource [mem 0xf2000000-0xf2ffffff]
[    0.671527] rockchip-dw-pcie: probe of 3c0800000.pcie failed with error -16
[    7.354521] pci 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    7.355116] mt7921e 0000:01:00.0: enabling device (0000 -> 0002)
[    7.355812] mt7921e: probe of 0000:01:00.0 failed with error -28

--
Thanks,
Chukun

-- 
2.25.1

