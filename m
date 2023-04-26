Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25A86EF5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbjDZNyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjDZNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:54:15 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7013F6E92;
        Wed, 26 Apr 2023 06:54:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QDrt5r104345;
        Wed, 26 Apr 2023 08:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682517235;
        bh=W+58kcFlpy4zgiGRyo/D7WwXuTR569I4K9Q6sc5aV3E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XUugwJa7nkquxPKr0eoptX+pmb+SukwwgupUIGVSSZh8/i0h1cq++G4BpMcQLk8eu
         4WDQYzu3Wocqtra1zxDKkBZCdlmTamETVc0zV+ms/wMlbVhFzCiB6+/anzVPn75uN3
         v/YV5xjFk0qdQRBXoP+9Zuw+rNPYzyJEH3/nBiFU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QDrt5t042588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 08:53:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 08:53:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Apr 2023 08:53:55 -0500
Received: from [10.249.133.231] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QDrlDf037318;
        Wed, 26 Apr 2023 08:53:48 -0500
Message-ID: <223be03f-78dc-9be8-8a90-66cdd5a368ba@ti.com>
Date:   Wed, 26 Apr 2023 19:23:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] arm64: dts/ti: am65x: Add Rocktech OLDI panel DT
 overlay
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230426060612.19271-1-a-bhatia1@ti.com>
 <20230426060612.19271-2-a-bhatia1@ti.com>
 <20230426125334.flj6ndo6s7esmcho@scotch>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230426125334.flj6ndo6s7esmcho@scotch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Apr-23 18:23, Nishanth Menon wrote:
> On 11:36-20230426, Aradhya Bhatia wrote:
> [...]
>>  # Boards with J7200 SoC
>>  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
>> new file mode 100644
>> index 000000000000..aed6dcf3bd7d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.
> 
> product link please.
> 

Added the link in the commit message because believing that is the
status quo. Remember referencing this patch[1] a while back.

But a deeper look now tells me that, that might not be the case. Or
perhaps, its different for dt-binding patches and devictree patches.

Will correct this in v3 and send again.

Regards
Aradhya


[1]: https://patchwork.freedesktop.org/patch/357122/
