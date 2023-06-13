Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E948672E4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbjFMOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbjFMOBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:01:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDECE;
        Tue, 13 Jun 2023 07:00:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35DE0kCa029992;
        Tue, 13 Jun 2023 09:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686664846;
        bh=AirbliOyuSWWs91uv2JHWAl9G1WVDzgNFAvtMfpXgwI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qznXiAORyfRiNMto8Cl3acHuWXX9qRJaF4Kn/3VIkhjIab7cEYiqX5EDF6DRhGT5l
         c/it0Ea00rrA8h4VyGilDH27+N/qfN9zDWJKcANxvy85lzrJbJmiOIWoZpqzFizP7Q
         J8gQnp1E+MMloP1WPb8kkApalUUwRzHqlFagv3HA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35DE0kWg020812
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 09:00:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Jun 2023 09:00:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Jun 2023 09:00:46 -0500
Received: from [10.249.141.75] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35DE0fjc056318;
        Tue, 13 Jun 2023 09:00:42 -0500
Message-ID: <ed28db1a-dc59-3a90-edcd-7e9f5b94f7fd@ti.com>
Date:   Tue, 13 Jun 2023 19:30:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/8] arm64: dts: ti: k3-j784s4/am69: Add uart, i2c,
 eeprom, misc
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>,
        Dasnavis Sabiya <sabiya.d@ti.com>
References: <20230602214937.2349545-1-nm@ti.com>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230602214937.2349545-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nishanth

On 6/3/2023 3:19 AM, Nishanth Menon wrote:
> Hi,
>
> This series picks up from where [1] left off. After fixing the mux
> regions, introduce the basic i2c, uarts, ethernet, and a few alias
> fixups sprinkled along with it.
>
> This series also takes over [2] and rebased on top of [1] and my series.
>
> Test log:
>
> Dasnavis Sabiya (1):
>    arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header
>
> Nishanth Menon (7):
>    arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
>    arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
>    arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
>    arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
>    arm64: dts: ti: k3-am69-sk: Enable mcu network port
>    arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
>    arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom
>
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 165 ++++++++++++++++++++++-
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts |  56 +++++++-
>   2 files changed, 219 insertions(+), 2 deletions(-)


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>
> [1] https://lore.kernel.org/linux-arm-kernel/20230503083143.32369-1-t-konduru@ti.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20230316104743.482972-3-sabiya.d@ti.com/
