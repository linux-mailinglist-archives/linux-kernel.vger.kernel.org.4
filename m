Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECE709E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjESRq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjESRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:46:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF0F9;
        Fri, 19 May 2023 10:46:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34JHkF7e092139;
        Fri, 19 May 2023 12:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684518375;
        bh=mvgHgAjtNtEc5wR3hXz1aOWUW+FIRVlbJa7vD91+qXA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=UaXPRiEpTodIOOXHo/2nZg8cuRPFJMKZyiJkfbZ5MXQHDJmAxZm+S/dOq4qmNAZZ8
         4klkI0qlJnSrkw/Siq10f+8HHEpzprLzDc+ncVsgJ32wbWb3jycQ79jxY3MQ5W4q4a
         hVHhQyCAcheG0OqNYYokTmMauhbZBYgLXyZDrUBM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34JHkFYJ006433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 May 2023 12:46:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 May 2023 12:46:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 May 2023 12:46:15 -0500
Received: from [10.250.33.177] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34JHkEMe110088;
        Fri, 19 May 2023 12:46:14 -0500
Message-ID: <21d73701-c8dc-765d-8d2f-bf15ea4caad0@ti.com>
Date:   Fri, 19 May 2023 12:46:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Add initial PCIe/SerDes
 support for J784S4
To:     Achal Verma <a-verma1@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515070219.2381457-1-a-verma1@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230515070219.2381457-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 2:02 AM, Achal Verma wrote:
> From: Matt Ranostay <mranostay@ti.com>
> 
> J784S4 SoC supports two PCIE instances as follows:
> * PCIE0 - 4x lanes
> * PCIE1 - 4x lanes
> 
> J784S4 EVM board has the following PCIE connectors:
> * PCIE0 - 4x lanes
> * PCIE1 - 2x lanes
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
> 
> This patch depends on:
> https://lore.kernel.org/all/20230310111630.743023-1-s-vadapalli@ti.com/
> https://lore.kernel.org/all/20230425131607.290707-1-j-choudhary@ti.com/
> https://lore.kernel.org/all/20230401112633.2406604-1-a-verma1@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   |  65 +++++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 126 +++++++++++++++++++++


I would split this into two patches, first add the nodes to the MAIN domain
dtsi file. Then after enable the SerDes and PCIe nodes for the EVM board.

Also, drop the pcie0_ep nodes, reasoning here:

https://lore.kernel.org/lkml/20230515172137.474626-2-afd@ti.com/

Andrew
