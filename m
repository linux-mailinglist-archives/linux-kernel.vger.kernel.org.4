Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32FB720FDC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 13:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbjFCLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 07:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFCLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 07:09:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214F18C;
        Sat,  3 Jun 2023 04:09:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 353B9mMq093223;
        Sat, 3 Jun 2023 06:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685790588;
        bh=Hqoap+yfSNixLL/77coXwHFElZl4l67f/fUvV++NvFE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dlPgVmMTWdFINyvhjYvRuCJygDA7knFxL3mL16MK50fkwpR4nQ/uN0bn6rGPQiHQa
         CeSV4520/2zvPcF+qSczEowpQHn6weZxQzy5qukI8/ACnKFb38I8T/lsuTKg/PKGRl
         DtcpSgqQiWT7sLyL/ak0e887I9GWw/WyK88NHUUY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 353B9mwR124328
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Jun 2023 06:09:48 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 3
 Jun 2023 06:09:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 3 Jun 2023 06:09:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 353B9l5Z107035;
        Sat, 3 Jun 2023 06:09:47 -0500
Date:   Sat, 3 Jun 2023 06:09:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Udit Kumar <u-kumar1@ti.com>, Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH 0/8] arm64: dts: ti: k3-j784s4/am69: Add uart, i2c,
 eeprom, misc
Message-ID: <20230603110947.weqktiz5bftcze3y@backpack>
References: <20230602214937.2349545-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230602214937.2349545-1-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:49-20230602, Nishanth Menon wrote:
> Hi,
> 
> This series picks up from where [1] left off. After fixing the mux
> regions, introduce the basic i2c, uarts, ethernet, and a few alias
> fixups sprinkled along with it.
> 
> This series also takes over [2] and rebased on top of [1] and my series.
> 
> Test log: 

Apologies on that, I seem to have forgotten to provide the link to the
test log. Anyways, here we go:

https://gist.github.com/nmenon/dca0ea1203c4e06d77f77b5c4a4a3e3f
> 
> Dasnavis Sabiya (1):
>   arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header
> 
> Nishanth Menon (7):
>   arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
>   arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
>   arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
>   arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
>   arm64: dts: ti: k3-am69-sk: Enable mcu network port
>   arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
>   arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom
> 
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 165 ++++++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts |  56 +++++++-
>  2 files changed, 219 insertions(+), 2 deletions(-)
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20230316104743.482972-3-sabiya.d@ti.com/
> -- 
> 2.40.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
