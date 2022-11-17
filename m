Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41162D3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKQHU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbiKQHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:20:48 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBB2F001;
        Wed, 16 Nov 2022 23:20:47 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7KXmt050883;
        Thu, 17 Nov 2022 01:20:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668669633;
        bh=GbhEspxYtZvsVIkMe3h+Fk8YTaJfyuiLvBfhQnpj3K8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tKSYrM6S/nhDUKN8fQQog7hfarmnKVUeckQY70GVNx+JkhoL/kZk2s/4WkrZ6wACk
         arSDwM/SXGL9H3pvtTFdXKzEMh07KWw2DTRVVAwXg6wzTm/vZGfWGAjRi2MoPU9cCm
         ZGI4LxIFQ2jOe8Dgy8eWT4vJdWcszM5pKqq5drw8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AH7KXQM008956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 01:20:33 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 01:20:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 17 Nov 2022 01:20:32 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AH7KWH5037519;
        Thu, 17 Nov 2022 01:20:32 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <vigneshr@ti.com>, <j-choudhary@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kristo@kernel.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator
Date:   Thu, 17 Nov 2022 01:20:32 -0600
Message-ID: <166866942229.20019.9156819999833538961.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221031200633.26997-1-j-choudhary@ti.com>
References: <20221031200633.26997-1-j-choudhary@ti.com>
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

On Tue, 1 Nov 2022 01:36:33 +0530, Jayesh Choudhary wrote:
> Add the node for SA2UL for supporting hardware crypto algorithms,
> including SHA1, SHA256, SHA512, AES, 3DES and AEAD suites.
> Add rng node for hardware random number generator.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

For the next time around:
Maintain consistent formatting 0x%08x for addresses, formatting to line
things up etc. I have manually edited to do that for this time.

[1/1] arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator
      commit: 027b85ca972f321629af85793bb49d45382e9006

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

