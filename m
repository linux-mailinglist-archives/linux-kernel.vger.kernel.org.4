Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF2D6C254F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCTXAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:00:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9E483CE;
        Mon, 20 Mar 2023 16:00:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KN0idr024180;
        Mon, 20 Mar 2023 18:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679353244;
        bh=RQOIEpCSGYjhwGa7ZpvSmcbm5++KjQDdyIMwuBvzfPg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w75XUw1UDclBUMUud0wsCvVk+PTI4agX7owjXXq17FA7yZO0at+pgeFje0RPZbNDM
         YlV++jYfoVWFWmTZ3J2TppyQUbKFInm83lrDv2iycSOfLkFC5o5/4K/VezL40oK2IV
         vNEFTmjhQTvXaMkjqZGlGrpUyzvGIiXNAVsqepgw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KN0ijn104946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 18:00:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 18:00:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 18:00:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KN0iGg096961;
        Mon, 20 Mar 2023 18:00:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v3 0/4] Add DT support for J721E CPSW9G and J7200 CPSW5G
Date:   Mon, 20 Mar 2023 18:00:43 -0500
Message-ID: <167935322172.215185.12851063500203208364.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230315062307.1612220-1-s-vadapalli@ti.com>
References: <20230315062307.1612220-1-s-vadapalli@ti.com>
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

Hi Siddharth Vadapalli,

On Wed, 15 Mar 2023 11:53:03 +0530, Siddharth Vadapalli wrote:
> This series adds the device-tree nodes for the CPSW9G instance of CPSW
> Ethernet Switch on TI's J721E SoC and the CPSW5G instance of CPSW
> Ethernet Switch on TI's J7200 SoC. Additionally, overlays are also added
> to individually enable CPSW9G on J721E SoC and CPSW5G on J7200 SoC in
> QSGMII mode with the Add-On J7 QUAD Port Ethernet expansion QSGMII
> daughtercard.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j721e: Add CPSW9G nodes
      commit: a2ff7f1108f6eeaa73a60378ed891b634a3bba61
[2/4] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII mode
      commit: 86e7de8bf908a03ac8fba4afeef25c54a1c2ef4a
[3/4] arm64: dts: ti: j7200-main: Add CPSW5G nodes
      commit: d3bac98015da55866891054a2aeb42af7904fca8
[4/4] arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII mode
      commit: 496cdc82e05f5683cdca5ab157938091e7744c95

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

