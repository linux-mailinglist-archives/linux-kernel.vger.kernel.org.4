Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC96C2B66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCUHdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCUHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:33:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AB346B5;
        Tue, 21 Mar 2023 00:33:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32L7X0hF110994;
        Tue, 21 Mar 2023 02:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679383980;
        bh=0XBTEZ79mbLEVpXuAGrTpBXMM5uOKstNINZmPr+L0C8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gDh/CZKfO7Qpg2R8UBs8j1j5YMt2OfSZ474E+1GNWHl2TNUZdu9baSFNMLOYfj5dC
         ExG4RT31idMxhAznJEcuYBNga0wQWbi4ADe6vz1kDXtXDg1Wiajz488fajRqzv/63Z
         a85NX/MchnFUgF5+XuuHhq5GtQl+BThRJvixQngI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32L7X0f4085510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 02:33:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 02:33:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 02:33:00 -0500
Received: from [10.249.131.164] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32L7WuJZ034534;
        Tue, 21 Mar 2023 02:32:57 -0500
Message-ID: <b651a7f5-3d61-fe8b-13b0-7f0caf0f21fd@ti.com>
Date:   Tue, 21 Mar 2023 13:02:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: j7: Add device-tree nodes for
 MCSPI
To:     Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-luthra@ti.com>
References: <20230321065447.6997-1-vaishnav.a@ti.com>
Content-Language: en-US
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20230321065447.6997-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 12:24 PM, Vaishnav Achath wrote:
> This series adds device tree nodes for Multi Channel Serial Peripheral
> Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
> MCSPI instances are disabled by default and can be enabled through overlays
> as required, the changes were tested using spidev loopback test for all
> instances and the data verified only for main_spi4 which is connected
> internally as slave to mcu_spi2 for all existing J7 devices.
> 
> V1->V2:
>    * Address Nishanth's feedback, combine main, mcu domain
>    MCSPI node addition changes to single commit per SoC.

Vaishnav,


As per TRM "MCSPI4 is directly connected as a slave to MCU_MCSPI2 by 
default at power-up. MCSPI4 and MCU_MCSPI2 are not pinned out externally".

The above is applicable to J721e/J7200. Similar mapping might be 
existing for j721s2 & j784s4 as well. Add this information in
the commit log. Other than that For the series:

Reviewed-by: Keerthy <j-keerthy@ti.com>

Regards,
Keerthy

> 
> Vaishnav Achath (4):
>    arm64: dts: ti: k3-j721e: Add MCSPI nodes
>    arm64: dts: ti: k3-j7200: Add MCSPI nodes
>    arm64: dts: ti: k3-j721s2: Add MCSPI nodes
>    arm64: dts: ti: k3-j784s4: Add MCSPI nodes
> 
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 88 +++++++++++++++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 +++++++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 88 +++++++++++++++++++
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 33 +++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 88 +++++++++++++++++++
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 33 +++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 88 +++++++++++++++++++
>   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 33 +++++++
>   8 files changed, 484 insertions(+)
> 
