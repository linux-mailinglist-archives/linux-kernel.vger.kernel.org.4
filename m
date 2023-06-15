Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0527F731290
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245301AbjFOIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245262AbjFOIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:45:53 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590C295F;
        Thu, 15 Jun 2023 01:45:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F8irn4011428;
        Thu, 15 Jun 2023 03:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686818693;
        bh=tgVLAW/+4tAVG3CK9szIU4oNA6kmapx5hvw30fwCBZQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oxuhACOj8Gf63Lg7bgXu5ahNbLKKjb67eFh02p4BAyA2VPUej3t9mEscnVccN9QvX
         5tqugN21Znk/aDe06FzDU45yUKO2iHg+r0RfAqyB5yUNuJPnBCJjQ81e0wQFP4k/Lm
         w9faL3uPf5MKjT2/VVin1kuT3XRcS0jv2JdhVuxw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F8irTD014616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 03:44:53 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 03:44:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 03:44:52 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F8ino5024113;
        Thu, 15 Jun 2023 03:44:50 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <nm@ti.com>, Hari Nagalla <hnagalla@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Add R5F and C71 DSP nodes for J784S4 SoC
Date:   Thu, 15 Jun 2023 14:14:44 +0530
Message-ID: <168681866421.2099541.8616274576323792454.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502231527.25879-1-hnagalla@ti.com>
References: <20230502231527.25879-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari Nagalla,

On Tue, 02 May 2023 18:15:24 -0500, Hari Nagalla wrote:
> This series adds the R5F cluster and C71 DSP processor nodes for
> J784S4 SoC.
> 
> The first patch adds R5F cluster nodes to the MAIN and MCU voltage
> domains of J784S4 SoC. The second patch adds the C71 DSP processor
> nodes to the MAIN voltage domain of J784S4 SoC and the third patch
> reserves the IPC shared memory for Virtio/Vring buffers.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
      commit: 7e5fd896c3d1ecf7b806f5fd42245c1135fe878d
[2/3] arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
      commit: 257d206b6d117d8e40742dc17ae02406747753ad
[3/3] arm64: dts: ti: k3-j784s4-evm: Reserve memory for remote proc IPC
      commit: ba12d4dde708de01d3cae5ae368a930ec5f5fd07

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

