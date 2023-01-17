Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3766DEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAQNgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjAQNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:36:00 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F93B3D1;
        Tue, 17 Jan 2023 05:35:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZjYG042522;
        Tue, 17 Jan 2023 07:35:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673962545;
        bh=EuTNpfYUb1WXK3Ez3UNrKb5vrziv59EKVX6L3nT3gjE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QcBtsl0B8KljuDul9ufBw8LKSQw4h7S3YkXR8wLrVMdEuTPASZSHX0LkxC/mnsijH
         3uBqzuyPupPJuJac/zQQbZtorrgkiYSZYcrAB4p5ClCwH+R2oj10lDCGP/cgnAofj9
         VPq/QYypR0bgqhSM+L8HU0eNkEvSNZqRimYhZQM0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HDZjvA109639
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 07:35:45 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 07:35:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 07:35:45 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HDZfeB079099;
        Tue, 17 Jan 2023 07:35:42 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <devicetree@vger.kernel.org>, Wadim Egorov <w.egorov@phytec.de>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nm@ti.com>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
Date:   Tue, 17 Jan 2023 19:05:39 +0530
Message-ID: <167395338062.410173.8024019186765703486.b4-ty@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230104162927.1215033-1-w.egorov@phytec.de>
References: <20230104162927.1215033-1-w.egorov@phytec.de>
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

Hi Wadim Egorov,

On Wed, 4 Jan 2023 17:29:26 +0100, Wadim Egorov wrote:
> Add devicetree bindings for AM64x based phyCORE-AM64 SoM
> and phyBOARD-Electra RDK.
> 
> 

I have applied the following to branch ti-k3-next on [1].
Thank you!

[1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
      commit: 86fc17d8495e7c221283267519561ea04a44f7b4
[2/2] arm64: dts: ti: Add support for phyBOARD-Electra-AM642
      commit: c48ac0efe6d71050f635b40116ba714961ad9d4c

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

