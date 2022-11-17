Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8562D3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiKQHN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:13:52 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E988140AA;
        Wed, 16 Nov 2022 23:13:49 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7DcWn049206;
        Thu, 17 Nov 2022 01:13:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668669218;
        bh=SQXtzhzt/WkjQRhnSsM3FxuxE4yVSlV+r4SKcbpDthY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VGagE5EHV2yTn4gtRnbheoAV5Ozr0wR0qJ4SYnRDDujIey1GTAmGiCKR3ifFuKsxX
         Yjbd42/55sLOS2YEhVornVRD4kiJKungBTePDCdAcmXVVkLjWpMIVw4+ZDyeO/JiWu
         DPZJQZ1Uh2DFci2mF756G8+Mp6X76BtfBuk83D10=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7Dcm9009657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:13:38 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 01:13:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 17 Nov 2022 01:13:37 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7DbG2026080;
        Thu, 17 Nov 2022 01:13:37 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <j-choudhary@ti.com>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: j721e-common-proc-board: Fix sound node-name
Date:   Thu, 17 Nov 2022 01:13:37 -0600
Message-ID: <166866903430.17927.6536583425817839282.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220928122509.143342-1-j-choudhary@ti.com>
References: <20220928122509.143342-1-j-choudhary@ti.com>
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

Hi Jayesh Choudhary,

On Wed, 28 Sep 2022 17:55:09 +0530, Jayesh Choudhary wrote:
> If root-node has no reg property, the unit-address should not
> be appended at the end of node-name. sound node has no 'reg'
> property, so remove the unit-address.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

When I applied, I dropped 'Fixes' tag for a few reasons:
a) It was trivial node cleanup fix, which per stable-rules dont make sense to
   get backported
b) The fixes format itself was wrong
c) The commit on which the fixes were to be applied would'nt apply (There is
   churn since then)

[1/1] arm64: dts: ti: j721e-common-proc-board: Fix sound node-name
      commit: f789fd29650b6fcee8995f53077d03d509a5d9f5

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

