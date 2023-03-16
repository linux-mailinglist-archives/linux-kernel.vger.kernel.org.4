Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324B6BCD22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCPKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCPKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:47:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649FFB5ABD;
        Thu, 16 Mar 2023 03:47:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32GAlCpn063704;
        Thu, 16 Mar 2023 05:47:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678963632;
        bh=8N7UDAd9h+tkPeZKWixIpN4DpYK+DwiCK0MdWQSdz2U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=cmnMivZz63dUZ1Q1r4aNdkFPQy1h7tcbtuPVKKeInsgBpx68e5/w3GocNrL8NFoV4
         ZOCYOEs0viUPG4XSrb4ddKS8SS2eAB2PZnocJg84MoC5gqrpnFPeDEtvEYe5U65rQD
         QHxx7bZqEV/uaHbFfj7KqVXb8pKUIA7iZsGb0aEs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32GAlCOG047276
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 05:47:12 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 05:47:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 05:47:12 -0500
Received: from [172.24.145.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32GAl9q2070053;
        Thu, 16 Mar 2023 05:47:10 -0500
Message-ID: <e0758199-9ae4-9dc6-67c5-315703dad238@ti.com>
Date:   Thu, 16 Mar 2023 16:17:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 0/2] arm64: dts: ti: k3-j721s2: Add support for ADC
 nodes
Content-Language: en-US
To:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230316095146.498999-1-b-kapoor@ti.com>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230316095146.498999-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/03/23 15:21, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add support
> for both ADC nodes in dtsi file. Add pinmux information for both
> instances of ADC in board dts file.

Link to V6 : 
https://lore.kernel.org/all/20230314112939.139894-1-b-kapoor@ti.com/

> Changelog v6->v7:
>   - Created 2 commits for k3-j721s2-mcu-wakeup.dtsi and
>   k3-j721s2-common-proc-board.dts instead of a single commit
>
> Bhavya Kapoor (2):
>    arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
>    arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux information
>      for ADC
>
>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 44 +++++++++++++++++++
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++
>   2 files changed, 84 insertions(+)
>
