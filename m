Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE96D21B4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjCaNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCaNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:49:56 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159826BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:49:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32VDnixC040131;
        Fri, 31 Mar 2023 08:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680270584;
        bh=uK/BZ8vvuLt9v6L5D7PoCE7Fv3S2Fmo8V17g5twWkB0=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=QrgGhiClByg4PBMAGfzEJ+l1Bf/kx/giV51UCkg5YqRFsMebkwubtcTInOXLJN6lM
         96zUdSMfofE3IBgLlbV5N2mQDoD1dBws6vXclNckCizNJT2UA6pF2N9845xZwzqsrU
         8rZf1kTG8+98IE6bwA7K5VrcRfMn5zYmkK5zKJPg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32VDnief037525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 08:49:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 08:49:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 08:49:44 -0500
Received: from [10.249.131.130] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32VDneU1110616;
        Fri, 31 Mar 2023 08:49:41 -0500
Message-ID: <8d159cc9-ecdb-b96f-052a-42377a549839@ti.com>
Date:   Fri, 31 Mar 2023 19:19:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
CC:     <kishon@kernel.org>, <rogerq@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] PHY-GMII-SEL: Add support for J784S4 SoC
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <ZCbhRQ2B8+RrSh5z@matsya>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ZCbhRQ2B8+RrSh5z@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod,

On 31-03-2023 19:03, Vinod Koul wrote:
> On 31-03-23, 11:55, Siddharth Vadapalli wrote:
>> Hello,
>>
>> This series TI's J784S4 SoC. A new compatible is added for the J784S4 SoC,
>> with QSGMII mode enabled. Also, the CPSW9G instance of J784S4 SoC supports
>> USXGMII mode. Thus, add support to configure USXGMII mode.
> 
> Sorry this fails to apply for me, pls rebase and send

This series has to be applied after the following series:
https://lore.kernel.org/r/20230309063514.398705-1-s-vadapalli@ti.com/
as mentioned below.

Regards,
Siddharth.
> 
>>
>> Note:
>> This series is based on top of the following series:
>> https://lore.kernel.org/r/20230309063514.398705-1-s-vadapalli@ti.com/
>>
>> The patch corresponding to the device-tree bindings for the compatible
>> "ti,j784s4-cpsw9g-phy-gmii-sel" is posted at:
>> https://lore.kernel.org/r/20230315092408.1722114-1-s-vadapalli@ti.com
>> Since the above patch has received an Acked-by from Krzysztof Kozlowski,
>> I am posting this series using the compatible.
>>
>> Regards,
>> Siddharth.
>>
>> Siddharth Vadapalli (2):
>>   phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J784S4
>>   phy: ti: gmii-sel: Enable USXGMII mode for J784S4
>>
>>  drivers/phy/ti/phy-gmii-sel.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> -- 
>> 2.25.1
> 
