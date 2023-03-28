Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E036CBEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjC1MMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjC1MMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:12:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDD93D5;
        Tue, 28 Mar 2023 05:12:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SCCYo8022416;
        Tue, 28 Mar 2023 07:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680005554;
        bh=Hemn+0/3QAwoeXpph7kNxgGoqMgwSj3ze3+kHIyy6Fw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=okGi0p/U85cJ8326HDdhNNJOEBDM6ZpS88Q24RRYaDl06mNj1e4Kcgm3RFuInGE/d
         6YskVYoOS10TwuFdWeF6RZylNanW2pvUUBmsU8Mbdih1Zx3AdZrWE3CdzZ0zT8ewtm
         GqFWFHxyIFIloRRMXBhE1uPDKECOXX07E5+LPrUI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SCCYTc065328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 07:12:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 07:12:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 07:12:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SCCXuF026508;
        Tue, 28 Mar 2023 07:12:33 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lore.kernel.org/r/20230320051304.2730692-1-vigneshr@ti.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62x LP SK board support
Date:   Tue, 28 Mar 2023 07:12:32 -0500
Message-ID: <168000554249.589847.2232339506854109334.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
References: <20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh Raghavendra,

On Wed, 22 Mar 2023 18:09:19 +0530, Vignesh Raghavendra wrote:
> This add DT support for AM62x LP SK board which has Automotive package
> variant of AM62x SoC with LPDDR4 and OSPI NAND
> 
> Product link: https://www.ti.com/tool/SK-AM62-LP
> Logs: https://gist.github.com/r-vignesh/0ad701f3df614cc5f90b6de775f2584e
> 
> Since v1:
> Drop wild card 'x' and rename compatible and dts file to am62-lp-sk.dts
> as suggested by Krzysztof.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK
      commit: 1fb3876129214f397b027eff98c614c0f015ecdf
[2/3] arm64: dts: ti: Refractor AM625 SK dts
      commit: ba0b22eaef1d2feda379ce486ca68e365ce4baf1
[3/3] arm64: ti: dts: Add support for AM62x LP SK
      commit: d956a851ac3c4e1a0ab8c9ed873281b85be01406

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

