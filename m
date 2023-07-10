Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7DD74D920
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjGJOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:38:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C69D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:38:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36AEcCfW064353;
        Mon, 10 Jul 2023 09:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688999892;
        bh=+NyYiBIVfky5FyHiALbxif/2d8M8ji1PBrAZbcEWnkY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=E0wKacmcy7Mvj34IuYLm3FNU+/mijt0hVPjXqhzW6Anbp3aUSE95p+pJW4wqQFJkI
         +fd5/S+5WmgUVefv8szEb58hWZx+r+zti33+lMhZ7FFil15JiDP2QZI4TlweWTjIje
         06kU4u8UqwLjMfnkv1Bc8tMCiIcmKioJsV4F5c/s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36AEcC3W011931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jul 2023 09:38:12 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jul 2023 09:38:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jul 2023 09:38:12 -0500
Received: from [10.250.32.50] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36AEcBeq042221;
        Mon, 10 Jul 2023 09:38:12 -0500
Message-ID: <693d7d42-b062-1e01-b920-e13c2d08ca6f@ti.com>
Date:   Mon, 10 Jul 2023 09:38:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] phy: ti: gmii-sel: Allow parent to not be syscon node
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230515195922.617243-1-afd@ti.com>
 <5ae4bd37-65ee-d6da-1ab6-c1018d9959ec@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <5ae4bd37-65ee-d6da-1ab6-c1018d9959ec@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 11:05 PM, Siddharth Vadapalli wrote:
> Andrew,
> 
> On 16/05/23 01:29, Andrew Davis wrote:
>> If the parent node is not a syscon type, then fallback and check
>> if we can get a regmap from our own node. This no longer forces
>> us to make the parent of this node a syscon node when that might
>> not be appropriate.
> 
> Could you please let me know in which cases it is appropriate versus in which
> cases it isn't?

Use of syscon nodes should be discouraged, in most cases they can and should be
avoided. The only time we would need to have a syscon parent is when the register
space contains multiple sub-devices with bit level interleaving.

Most devices should never need syscon, we overuse syscon due to driver like
this that have no other option than to make the parent device a syscon node.

> Is syscon_node_to_regmap() being retained for backward
> compatibility until the device-tree nodes are cleaned up across all devices?
> 

Yes, the old way is left only for backwards compatibility.

>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/phy/ti/phy-gmii-sel.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
>> index 8c667819c39a..1e67ed9a5cf6 100644
>> --- a/drivers/phy/ti/phy-gmii-sel.c
>> +++ b/drivers/phy/ti/phy-gmii-sel.c
>> @@ -435,9 +435,12 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
>>   
>>   	priv->regmap = syscon_node_to_regmap(node->parent);
>>   	if (IS_ERR(priv->regmap)) {
>> -		ret = PTR_ERR(priv->regmap);
>> -		dev_err(dev, "Failed to get syscon %d\n", ret);
>> -		return ret;
>> +		priv->regmap = device_node_to_regmap(node);
> 
> If device_node_to_regmap() can always be used with the corresponding changes
> made to the device-tree nodes, wouldn't it be better to use it directly instead
> of using it as a fallback? (This is based on the assumption that
> syscon_node_to_regmap() is only being retained until the device-tree nodes are
> cleaned up to work with device_node_to_regmap()).
> 

Yes, that could work too. I was trying to make the minimal changes here, but
if we feel it works better we can have the default be to check the self node first.

Andrew

>> +		if (IS_ERR(priv->regmap)) {
>> +			ret = PTR_ERR(priv->regmap);
>> +			dev_err(dev, "Failed to get syscon %d\n", ret);
>> +			return ret;
>> +		}
>>   	}
>>   
>>   	ret = phy_gmii_sel_init_ports(priv);
> 
