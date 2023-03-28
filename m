Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DBB6CBEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjC1MMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC1MM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:12:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC593D1;
        Tue, 28 Mar 2023 05:12:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SCCClG118932;
        Tue, 28 Mar 2023 07:12:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680005532;
        bh=bBUSi456e1BUIENl28eny9NwPSGtSu5fNgL73OGAADI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YxkLq3sQ2k6jDqDVilN1bo3XWTrlKCXrW8n8PV8VWcflZtZPsPrN321PXTz3f+8GT
         ld/kyqLNqtM9VftxS0eUlSgmk6YwO664aNnuyrJ9vS6ttZyqDuP6bzQwn27BdyQg1R
         gNuj39qXNf9KjawmeKgJKP5Xo+zJ8rDeBs/eV+Yw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SCCCcU039341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 07:12:12 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 07:12:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 07:12:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SCCC3H026278;
        Tue, 28 Mar 2023 07:12:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO lines for Rev E2
Date:   Tue, 28 Mar 2023 07:12:10 -0500
Message-ID: <168000552285.589760.16281695652330219261.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230315120934.16954-1-sinthu.raja@ti.com>
References: <20230315120934.16954-1-sinthu.raja@ti.com>
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

Hi Sinthu Raja,

On Wed, 15 Mar 2023 17:39:34 +0530, Sinthu Raja wrote:
> Rev E2 of the AM68 SK baseboard has updated the GPIO IO expander pins
> functionality. To match the Rev E2 schematics, update existing IO expander
> GPIO line names and the corresponding node which uses the expansion(exp1)
> node.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO lines for Rev E2
      commit: 276fa0066b03875f77dba67867d9902361e646fc

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

