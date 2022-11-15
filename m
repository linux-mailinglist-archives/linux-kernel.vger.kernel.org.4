Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2552662A2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKOUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKOUVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:21:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94802F64A;
        Tue, 15 Nov 2022 12:21:45 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKLYss119848;
        Tue, 15 Nov 2022 14:21:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668543694;
        bh=qwHfXH4FfaV39AIVbTMqmV/g2wcep4wife01FvkPIKw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Az5xBFh6LqYaGMP5QiFL9q3Dt187zgFmaem7vT5hjlScpcGCOetKGZPFO7Hg+cyfb
         wyZr8TrVCPmBzxnkoQfRuKzYCin4cyU1K/cJP15mLkf4C8TPt8k250g24Wntd3veYI
         fM3JoECAq02GP9ybHsNWExR+fNjEjzZ42ucmlGTc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AFKLYhQ053280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 14:21:34 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 15
 Nov 2022 14:21:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 15 Nov 2022 14:21:33 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AFKLXvg037051;
        Tue, 15 Nov 2022 14:21:33 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: trim addresses to 8 digits
Date:   Tue, 15 Nov 2022 14:21:33 -0600
Message-ID: <166854367625.10668.1943885392035260036.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115105044.95225-1-krzysztof.kozlowski@linaro.org>
References: <20221115105044.95225-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski,

On Tue, 15 Nov 2022 11:50:44 +0100, Krzysztof Kozlowski wrote:
> Hex numbers in addresses and sizes should be rather eight digits, not
> nine.  Drop leading zeros.  No functional change (same DTB).
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: trim addresses to 8 digits
      commit: 81685b3d022765e5bfeaf476f70cff0a552c65bf

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

