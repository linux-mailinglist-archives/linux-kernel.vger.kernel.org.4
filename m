Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27046D18FE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCaHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjCaHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:50:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED991CBA9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 00:49:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32V7nC89032086;
        Fri, 31 Mar 2023 02:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680248952;
        bh=M9rGFzZVAKQIHFo+6Vrn0/FJ6eEqdHqLhsMOa8+fA2g=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=i+p210SuKELCHvyTRorWzQJSGHo4Nglx39hmKW2uZZNPiaSfJBLEudFl5jocVGgaZ
         aKzj93o2mr9EIE6gQkX3YxqcAEieRAQ0pqCASd+dYS5j9UkmpCPGubRmUDW444aFNZ
         nF8w5fIw7ctpmHqhWJxzITaei0WvNjA6nMJoNxUs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32V7nCb1116419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 02:49:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 02:49:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 02:49:12 -0500
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32V7n9xx084053;
        Fri, 31 Mar 2023 02:49:10 -0500
Message-ID: <b5e426fb-8af9-c372-1076-63194e4de781@ti.com>
Date:   Fri, 31 Mar 2023 13:19:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
CC:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/2] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in
 J784S4
To:     Roger Quadros <rogerq@kernel.org>
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <20230331062521.529005-2-s-vadapalli@ti.com>
 <cfcdb25b-5426-2532-ab8c-224a5e33baf3@kernel.org>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <cfcdb25b-5426-2532-ab8c-224a5e33baf3@kernel.org>
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

Hello Roger,

On 31/03/23 13:15, Roger Quadros wrote:
> 
> 
> On 31/03/2023 09:25, Siddharth Vadapalli wrote:
>> Each of the CPSW9G ports in TI's J784S4 SoC support modes such as QSGMII.
>>
>> Add a new compatible for it and allow the usage of "ti,qsgmii-main-ports"
>> property for J784S4.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  drivers/phy/ti/phy-gmii-sel.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
>> index c87118cb2af9..fba5c0c0771c 100644
>> --- a/drivers/phy/ti/phy-gmii-sel.c
>> +++ b/drivers/phy/ti/phy-gmii-sel.c
>> @@ -235,6 +235,15 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
>>  	.num_qsgmii_main_ports = 2,
>>  };
>>  
>> +static const
>> +struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j784s4 = {
> 
> Please make it into one line

I was simply following the convention used for other SoC data structs in the
same file. Please let me know why this has to be an exception and I will post
the v2 series with the change accordingly.

Regards,
Siddharth.
