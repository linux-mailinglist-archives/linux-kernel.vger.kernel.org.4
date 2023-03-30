Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9826CF965
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjC3DBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjC3DBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:01:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316C59DA;
        Wed, 29 Mar 2023 20:01:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U30lbZ049077;
        Wed, 29 Mar 2023 22:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680145247;
        bh=OcCwE395WH/NUHl18D/5rlo2l+Ejn/+/wFOqolmzQhA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vOCulW2lJ0vZPyz40lFGIEW70umemc8dJanffwW7+KqDn6rtNHcHmsC9otgLrjU/w
         CASzqqOcH7RvXDD9WVntaaGA3hgEKTflHn7JTkdm42R0ZyP8rYc+bOdPV+AzqxxDoY
         zYnuD+QHYde4E7wyyBcQ4r97bud8fjS0wj0Jt1JA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U30lil113092
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 22:00:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 22:00:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 22:00:46 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U30kjj020074;
        Wed, 29 Mar 2023 22:00:46 -0500
Date:   Wed, 29 Mar 2023 22:00:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Esteban Blanc <eblanc@baylibre.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sterzik@ti.com>, <u-kumar1@ti.com>, <jneanne@baylibre.com>,
        <jpanis@baylibre.com>
Subject: Re: [PATCH v1 0/4] Add TPS6594 PMIC support on several boards
Message-ID: <20230330030046.qr5dnft6klejkxkp@ungreased>
References: <20230329142948.833800-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230329142948.833800-1-eblanc@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject: minor comment: you don't need a v1 for the first version of
the patch series.

On 16:29-20230329, Esteban Blanc wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This should be applied on top of other patch series:
> - https://lore.kernel.org/all/20230327154101.211732-1-jpanis@baylibre.com/
>   For core MFD driver
> - https://lore.kernel.org/all/20230328091448.648452-1-eblanc@baylibre.com/
>   For regulator driver

OK - lets see these driver support get into an kernel rc1 tag before
looking at these patches for merge in this cycle, though this does
hold up other series

Such as https://lore.kernel.org/all/20230313-mcasp_upstream-v9-6-6d937efe4ec4@ti.com/

> 
> This serie adds device tree nodes for TI TPS6594 PMICs found in the
> following boards:
> - j721eXSOMXEVM:
> Link: https://www.ti.com/tool/J721EXSOMXEVM
> - j721s2:
> Link: https://www.ti.com/tool/J721S2XSOMXEVM
> - j7200XSOMXEVM:
> Link: https://www.ti.com/tool/J7200XSOMXEVM
> - AM62A-SKEVM:
> Link: https://www.ti.com/tool/SK-AM62A-LP
> 
> Esteban Blanc (2):
>   arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
>   arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs
> 
> Jerome Neanne (1):
>   arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
> 
> Julien Panis (1):
>   arm64: dts: ti: k3-am62a7-sk: Add support for TPS6593 PMIC
> 
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts      |  94 +++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 170 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi  | 169 +++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 208 +++++++++++++++++++
>  4 files changed, 641 insertions(+)
> 
> -- 
> 2.39.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
