Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0811A6D08F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjC3O75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjC3O7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:59:51 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9610FC16D;
        Thu, 30 Mar 2023 07:59:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UExMmc005030;
        Thu, 30 Mar 2023 09:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680188362;
        bh=8DZkW36nrbs0H4pGSSHQDlmnjQ7hcArGjyRNSZ2ArI0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DJURShdBb3VPgHDdHzvooZv7J6L1mjzLtc/nkV4akeS/sg06lVKK+K3UR968fWf8D
         kJ7VwOwnStbpJc0DxY8ZrGPDFUMVyWEXE+89TFRaS+2NZhXoQeDdj9j9bMAGrQysb7
         uA/oCBpKtZKlybRezd3d9x2GWqX/UEUT7Aq/oK7c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UExLqB049658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 09:59:21 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 09:59:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 09:59:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UExLdO128517;
        Thu, 30 Mar 2023 09:59:21 -0500
Date:   Thu, 30 Mar 2023 09:59:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 0/2] arm64: dts: ti: Fixes for Beagleplay SD
Message-ID: <20230330145921.5pnmcjgwl5wllhvq@await>
References: <20230330105921.3639185-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330105921.3639185-1-vigneshr@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:29-20230330, Vignesh Raghavendra wrote:
> Couple of fixups on top of ti-next branch:
> 
> The SD supply on Beagle is really coming from PMIC LDO1 even though its
> controllable via GPIO, hence fix the DT accordingly, this also means
> PMIC regulator drivers need to be built-in to allow SD card rootfs
> 
> Nishanth,
> Better to squash into respetive commits if possible
> 
> Vignesh Raghavendra (2):
>   arm64: configs: defconfig: Make TPS65219 regulator built-in
>   arm64: dts: ti: k3-am625-beagleplay: Fixup SD card supply regulator
> 
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 +-
>  arch/arm64/configs/defconfig                   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.40.0
> 
Thanks Vignesh, I will do the fixup.

Chatting with Roger offline, also realized that the board circuitry will
need the following change as it is using a 1/3 voltage divider on SoC's
USB1 as well: I will add this fixup while at it.

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index f75e79e54dfc..a4eb54722743 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -484,6 +484,7 @@ &usb0 {
 };
 
 &usbss1 {
+	ti,vbus-divider;
 	status = "okay";
 };
 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
