Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96B7315AB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244998AbjFOKoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjFOKoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:44:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75611BC;
        Thu, 15 Jun 2023 03:44:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAiQ64067295;
        Thu, 15 Jun 2023 05:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825866;
        bh=oynmoNFXypS3EI43XeRyeaMIVeGb1kv63LOW56GViR4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UxJ1gvL7ZqYHbsU7bl6P2B8pqHKAsgqGQDovsSb6rtZwON6sPqS/pFl6d8hdYlr9l
         rpmlbbhv8TcruZECANa3m1c9Mq3wibl4O3M6GviWiVvlQqqr/TYlfllsjRsq40EnNT
         LMVvqXe+DB2VbLO9lh0lOMvMFUHh9o+nMO9Qa5dc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAiQXs090771
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:44:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:44:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:44:26 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAiNDu059396;
        Thu, 15 Jun 2023 05:44:23 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Wadim Egorov <w.egorov@phytec.de>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: Add LED controller to phyBOARD-Electra
Date:   Thu, 15 Jun 2023 16:14:21 +0530
Message-ID: <168681817161.2098323.16260853934392057080.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230505131012.2027309-1-w.egorov@phytec.de>
References: <20230505131012.2027309-1-w.egorov@phytec.de>
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

Hi Wadim Egorov,

On Fri, 05 May 2023 15:10:12 +0200, Wadim Egorov wrote:
> With commit 9f6ffd0da650 ("dt-bindings: leds: Convert PCA9532 to dtschema"),
> we can now add the LED controller without introducing new dtbs_check warnings.
> Add missing I2C LED controller.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: Add LED controller to phyBOARD-Electra
      commit: 2dc39c564982f2ca77a9589a3d9906ecaf5a42e4

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

