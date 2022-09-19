Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCEB5BD882
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiISX4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiISX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:56:12 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5350700
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663631771; x=1695167771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++5axOCldtTWM+izrbSQWpROwyvWlmGRPLJdA2yng0M=;
  b=Mnn61pXQouxDcedtf8N/mBz6S5pP6OeSTutsTy8vFuXLddEd2EaRRHjt
   gQvfMQ6dS4FucO9brRAId0fRt6wJzxRWLDymH424LYGRN5njopsgkhdFt
   +CtbQxPPrQskwUGWQDSKbUqi8UbJBbZdjpfHq0kb7n4vVBCw3BcdxvaE8
   5vAudGucKD2OcU3JhDBJki2fNrtSWt1m3QlxGVd79hmhnn5z7Kr9nMTr8
   2K15p/roUDVNSexSdREiG9IlHjDecYqzehLMmVexDWT2oz3xULSk6Qa5g
   GTjzySy0WQxymKWsTH0AU0G14eee9e6f5WXkRZIQVXIOezAoKYpcOGjuB
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,329,1654531200"; 
   d="scan'208";a="323859294"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 07:56:10 +0800
IronPort-SDR: O/z07hOjtRszYMvrYPFuAn6Qy1dJ5/Mj393vftyY7jzSe9OziX93L7KaaAnfwOnawpGIzFRJUL
 RDLPGtw0XVFbnWnOkIsp/v/nv7/oCdGGWS7/26HSWJZFTqaXLr8sjaTX1+AUoXga3LBygKfbWf
 /isvELpjS/k6//CF+8NQ4rQFNAYYZ7HuokL0KHyJ1BbHjRZoEJoVWDx76b4KnK3ch5adqOyaJs
 Ahik6pAFBOZ2cTXmhcanWwnlW4k3pRznEfv9OPZ+B1wjFz/ij0Z4v9n6a9xHlG+FwAnS2O5ibi
 WkhigQ5kt8GoRIb+qWEOfvFa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:10:47 -0700
IronPort-SDR: VvONKg5U/M/I++uFtgogWFZ/3HZMlAExqY3gDeOesNT99RnGi3ENMYUaQ5XoJI83/KbxexAhOD
 0MQGW/+tR9priecxarmUtrjz5Qpl+wJoudmF5jZUmYwGDoMV7NRKjfhSRfDfcdX+oAWY+O82iH
 4AH1WvSGQgzys/tQDKDv7qT6Z7vB6MlvNgT2aXc6Gp8qWBvbTbD47pOxrhS5L9SHOoU/y8k3DR
 dfjMP/t+Igub/BBIUHREgOk450QO803FeRM7710M31jWpIMYSMiw3HRPgrAjAfGFqtd08DvxEx
 np8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:56:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MWhQd4DT7z1RWy0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:56:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663631768; x=1666223769; bh=++5axOCldtTWM+izrbSQWpROwyvWlmGRPLJ
        dA2yng0M=; b=KumYlcFECCyMFuCCbzzjbk2hBlrl09J7H1BVMMpdpWLqTeK1Udg
        BQJQNamL7noEQ2kcOpXY79ZFm5an7hgZYNIet+ruTqKUe+qcUHcR0timQfFKEfTT
        7+EU2aANdBVmxzOTCdnC3Inc+WyuGkoiyybBjJBZHjeFfNTvNNOrWnWtJOt+7C16
        4xnnoGJ2hsBWcHs8UXmd09FBjoVunvoEbalULcIh0Y9nt/2kAx6gYcjSMb9o+c0p
        sd2cnrprJIdrUMnVB0OwM0O2rS8UAgnvJDEjxWg63PVisyECEIb91ymOK/63rc3D
        O4eDxIUJvk8GQtdY7j66BU1zyADl90ojNnQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uHGWvwxZrQwI for <linux-kernel@vger.kernel.org>;
        Mon, 19 Sep 2022 16:56:08 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MWhQV5lcDz1RvLy;
        Mon, 19 Sep 2022 16:56:02 -0700 (PDT)
Message-ID: <7872df9d-db4e-0617-84eb-e47394774322@opensource.wdc.com>
Date:   Tue, 20 Sep 2022 08:55:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v8 09/23] ata: libahci_platform: Parse ports-implemented
 property in resources getter
To:     Guenter Roeck <linux@roeck-us.net>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220909193621.17380-1-Sergey.Semin@baikalelectronics.ru>
 <20220909193621.17380-10-Sergey.Semin@baikalelectronics.ru>
 <20220919215014.GA336081@roeck-us.net>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220919215014.GA336081@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 06:50, Guenter Roeck wrote:
> On Fri, Sep 09, 2022 at 10:36:07PM +0300, Serge Semin wrote:
>> The ports-implemented property is mainly used on the OF-based platforms
>> with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
>> the same of_property_read_u32()-based pattern has already been implemented
>> in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
>> drivers let's move the property read procedure to the generic
>> ahci_platform_get_resources() method. Thus we'll have the forced ports
>> mapping feature supported for each OF-based platform which requires that,
>> and stop re-implementing the same pattern in there a bit simplifying the
>> code.
>>
>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>> ---
>>  drivers/ata/ahci_mtk.c         | 2 --
>>  drivers/ata/ahci_platform.c    | 3 ---
>>  drivers/ata/ahci_st.c          | 3 ---
>>  drivers/ata/libahci_platform.c | 3 +++
>>  4 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
>> index 1f6c85fde983..c056378e3e72 100644
>> --- a/drivers/ata/ahci_mtk.c
>> +++ b/drivers/ata/ahci_mtk.c
>> @@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
>>  				   SYS_CFG_SATA_EN);
>>  	}
>>  
>> -	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
>> -
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
>> index 28a8de5b48b9..9b56490ecbc3 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	of_property_read_u32(dev->of_node,
>> -			     "ports-implemented", &hpriv->force_port_map);
>> -
>>  	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>>  		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>>  
>> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
>> index 7526653c843b..068621099c00 100644
>> --- a/drivers/ata/ahci_st.c
>> +++ b/drivers/ata/ahci_st.c
>> @@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
>>  
>>  	st_ahci_configure_oob(hpriv->mmio);
>>  
>> -	of_property_read_u32(dev->of_node,
>> -			     "ports-implemented", &hpriv->force_port_map);
>> -
> 
> With arm:allmodconfig, this results in:
> 
>   CC [M]  drivers/ata/ahci_st.o
> drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> drivers/ata/ahci_st.c:147:24: error: unused variable 'dev' [-Werror=unused-variable]
>   147 |         struct device *dev = &pdev->dev;
> 
> Guenter

Just pushed a fix for this in ata tree for-next and for-6.1 branches. The
problem should be resolved with the next linux-next merge.

-- 
Damien Le Moal
Western Digital Research

