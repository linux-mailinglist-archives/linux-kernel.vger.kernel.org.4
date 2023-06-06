Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ED3724A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbjFFRcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbjFFRce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:32:34 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D619BB;
        Tue,  6 Jun 2023 10:32:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356HW86V011929;
        Tue, 6 Jun 2023 12:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686072728;
        bh=Pmmtr5kE/2WIyrPRla4X9Xf7ooGWHcGEtH8GBca0038=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Gz3Wypd2FcFKyF97cedgue7RauwlaihssjzNHFECkCjh8i8nUScWlNOk7vHHfzPI7
         rEZRWMGLh5+stpvGKL8MAxXVAs3iKPcTELo/rb68T3scBHZFj3f/h3rh55KwPnwsOc
         bX+6bo+RCxu4dquRa90HXlTCut+mLeGsUgVN8X38=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356HW8W7060656
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 12:32:08 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 12:32:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 12:32:08 -0500
Received: from [10.249.138.31] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356HW5mT032554;
        Tue, 6 Jun 2023 12:32:06 -0500
Message-ID: <83a8f3c0-5938-7a0b-dc99-6409ff0dd09c@ti.com>
Date:   Tue, 6 Jun 2023 23:02:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a: Add timers, wdt and fixup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20230418012717.1230882-1-nm@ti.com>
 <168607161908.2072651.15533240609144219974.b4-ty@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <168607161908.2072651.15533240609144219974.b4-ty@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/23 10:51 pm, Vignesh Raghavendra wrote:
> Hi Nishanth Menon,
> 
> On Mon, 17 Apr 2023 20:27:14 -0500, Nishanth Menon wrote:
>> This is a series that adds wdt, timers to am62ax support, and adds the
>> missing description for uart1 and wkup_uart that is used by firmware.
>>
>> Nishanth Menon (3):
>>   arm64: dts: ti: k3-am62a: Add general purpose timers
>>   arm64: dts: ti: k3-am62a: Add watchdog nodes
>>   arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart
>>
>> [...]
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/3] arm64: dts: ti: k3-am62a: Add general purpose timers
>       commit: 68dd81a75192248a2c29650d21da495069c74ffa
> [2/3] arm64: dts: ti: k3-am62a: Add watchdog nodes
>       commit: 804702e4c2aa5eae4611e9389833631a6b22e913
> [3/3] arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart
>       (no commit info)
> 

I ended up picking up [0] for 3/3 instead:

[0] https://lore.kernel.org/r/20230425221708.549675-1-bb@ti.com
