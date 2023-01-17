Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01766DEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjAQNem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAQNei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:34:38 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7286F65A6;
        Tue, 17 Jan 2023 05:34:35 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HDYQUj046175;
        Tue, 17 Jan 2023 07:34:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673962466;
        bh=1r0ZTGQvgLPf7ei0hCiziyMQKc87/3gnPfGB80ixdBY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OJxSzDBEkCsszWSX2ALO9W5Z2xk6z350iLGJuneY8FVhdvP+1k6Vaqw+ASYUeS/va
         2+bUn/0BgD093nkNelF88kMFzU+Sy9VSsDMd73FXZGsb3yetDlRfLjM5h2iIfRVsnx
         2XPiQszdgDTD2gawVJxOtrgDjFuHI0JHfJOC//qU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HDYQCu003796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 07:34:26 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 07:34:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 07:34:26 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HDYNJE017157;
        Tue, 17 Jan 2023 07:34:23 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        <devicetree@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Date:   Tue, 17 Jan 2023 19:04:12 +0530
Message-ID: <167395338058.410173.2545278634752217876.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103054840.1133711-1-d-gole@ti.com>
References: <20230103054840.1133711-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhruva Gole,

On Tue, 3 Jan 2023 11:18:40 +0530, Dhruva Gole wrote:
> Fixes the clock Device ID's in the DT according to the tisci docs clock
> identifiers for AM62x
> 
> 

I have applied the following to branch ti-k3-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
      commit: 6be5d8e5d1804eb4cec29cd8a85dc9cb18683b5d

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

