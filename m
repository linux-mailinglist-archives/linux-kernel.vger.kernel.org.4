Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584E6530BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiLUMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiLUMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:24:48 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9BA2315A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671625487; x=1703161487;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JP6kXKReLiKe0iNUrQQ7tFMFRaAdUy2nqah2AVaSLfc=;
  b=prygk/mw+QXJ1MZGsEmYlFptmNwH4Ksx5s7qjGf16GkcJdEWFQav+0CA
   Lk0n5o8AFmvjhnsjYySYkHz5EzJXcfpVtbyNOGXU/0WbKwQ2jYXOTNpad
   SI2lgxLE2WCrpJbhk27/ijadsbeSzF6tOVKhG0f7TECcBxA6ajCXQNoBC
   9IB8GQhvSwAmnxwIxgTAPLYpnGLNOmJNv0vs82s5eljUsKb7F1RJw2O25
   KmGUTPxGJhfI9EP/YRephA/77pHmBLC7Cu8XuKxzqVjTy7R7XW7K6+Rt+
   IJ7+EfvYD3eYR3Yi+Hod4yUR3umNOtgT1QwaGzdoY4mi6P+NPdlyu4qsf
   w==;
X-IronPort-AV: E=Sophos;i="5.96,262,1665417600"; 
   d="scan'208";a="219142419"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 20:24:46 +0800
IronPort-SDR: q+sOH5KiAo18Ulfn4D6N2Tggw5RhYkRMWLnpKVPczzmLnMN0lnl0Fz7osAa5DvRG0eFqZLMayv
 RWqcYxpA/eYOBKDGrROdmuQR8sH3k+MbMo5gdqbDXiPyMPGgq8pwpmvzl21dIis5G5esMGZpRy
 eVM7pJOdf0Dek+khlmQ+98hdgAB5ikoZH17IGaO1vBiN2cMjrih2xLiIAgV6/+vX1dobEMa875
 UP3H2SHHEQdggRx0a/6Tb2VaaL1VQ9lIC05Dry8Ln9Wr8/lyXk4YEj8SnuTTJbjalMh/MJj4mj
 WeY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2022 03:37:16 -0800
IronPort-SDR: iHJKe74ATLcHBTMg6ixk1PZDrP+iK7UeXk52eKHGvVCtoJubd8A/vy50m0A1rFtzJq/VMFG6Uq
 cWPdaFxpeotA68ozvY5U7KFXWXKfvNFoZGrhdjlnmxPW85KxTzMp5seg3+N0BSpj2eeROSK/dk
 VdOj18qjF0QKPG+wYHrnFpIQrsVUCJaVB7N22enWTUdcpjbu/CGtnrlB4Wv/ch6bo50IIE3iuI
 4Wq6Kehxqt0sRl+TNReRaUe2hxUCKhpDMxYfWRKF2DCy/sgtkW5DEzRWjYBTg3LlVTgXXzjs9P
 P9M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Dec 2022 04:24:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcXgy3zP5z1RwqL
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 04:24:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671625485; x=1674217486; bh=JP6kXKReLiKe0iNUrQQ7tFMFRaAdUy2nqah
        2AVaSLfc=; b=r8o88TIM+zit033pTSLCPBHS94VlTTniEXMuq7UJ2qaMaau9Az/
        NMdAcHYPo9Ap14bDSKslBZ2yu8o9IFqx0c3lk1cxduytSxNzVAkT2iOEMCMppoCG
        Oi1s7hk98JyhvSlkAgLEF0NadBfPwA5g2jpn7fBoilWssi77xThrfOvDL+aFLjD8
        vTkX34Y9737qhAVeUwppbVEsQ26NhfuwTTaZ0AVdcNPGezNhLORueEfhUWBIDs3Q
        LK/3VVwWQXsV/crun8iRls5edJF7B1h1d6f8BLiqbApPNjVhbjCCET+NFUeFO8zZ
        C9Y3TbxHHgQcKINLSAOiitw3exR0RWlICHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cYkTryMQ1cbY for <linux-kernel@vger.kernel.org>;
        Wed, 21 Dec 2022 04:24:45 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcXgv6Twbz1RvLy;
        Wed, 21 Dec 2022 04:24:43 -0800 (PST)
Message-ID: <54be50a6-88d2-82d8-b549-a5e49225c6c4@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 21:24:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jason Yan <yanaijie@huawei.com>,
        John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "prime.zeng@hisilicon.com" <prime.zeng@hisilicon.com>,
        "kangfenglong@huawei.com" <kangfenglong@huawei.com>
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
 <c8387766-2ca0-51f3-e332-71492b13e5c1@opensource.wdc.com>
 <7347d117-6e0b-dd18-90a8-25685f757689@huawei.com>
 <4ff0ca00-31f5-2867-ff59-cecb5d6d1048@opensource.wdc.com>
 <755d7a9c-427e-024a-8509-449ebc5a00e6@huawei.com>
 <f77c7872-3711-2216-c17c-e23591f745c7@opensource.wdc.com>
 <Y6LVaE5e9iZNAYrF@x1-carbon>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y6LVaE5e9iZNAYrF@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/21 18:44, Niklas Cassel wrote:
> On Wed, Dec 21, 2022 at 05:31:59PM +0900, Damien Le Moal wrote:
>>>
>>> What about the interrupt handler such as ahci_error_intr()? I didn't see
>>> the callers hold the port lock too. Do they need the port lock?
>>
>> It looks like it is missing for ahci_thunderx_irq_handler() but that one
>> takes the host lock. Same for xgene_ahci_irq_intr(), again no port lock
>> but host lock taken. And again for ahci_single_level_irq_intr() for the
>> non MSI case. For modern MSI adapters, the port lock is taken in
>>
>> For other cases, ahci_multi_irqs_intr_hard) takes the port lock.
>>
>> So it looks like ahci_port_intr() needs to take the lock and some
>> cleanups overall (the host lock should not be necessary in the command
>> path. But nobody seems to have issues with the "bad" cases... Probably
>> because they are not mainstream adapters.
>>
>> Definitely some work needed here.
> 
> ahci_multi_irqs_intr_hard() takes the ap->lock before calling
> ahci_handle_port_interrupt(), which calls ahci_port_intr(),
> so I don't think there is any work needed for multi IRQ AHCI.

Yes. I tried to say that above.

> 
> For ahci_single_level_irq_intr() the host lock is taken before
> calling ahci_handle_port_intr(), so I don't see why we need any
> extra work for single IRQ AHCI.
> 
> 
> Remember, while the default is that:
> 	ap->lock = &host->lock;

Ah ! Yes ! good point ! So there are no issues anywhere. This is only confusing
because of the comments I think.

> see:
> https://github.com/torvalds/linux/blob/v6.1/drivers/ata/libata-core.c#L5305
> 
> In case of MULTI MSI, the ap->lock is using its own lock:
> https://github.com/torvalds/linux/blob/v6.1/drivers/ata/libahci.c#L2460
> 
> 
> So what is it that needs to be fixed for AHCI?
> 
> I haven't looked at ahci_thunderx_irq_handler() and xgene_ahci_irq_intr()
> so I can't speak for these.

These are not multi-irq and use the &host->lock directly, which is the same as
taking the ap->lock. We could clean that up for consistency and always use
ap->lock. But not a big deal. No bugs, just a little confusing with a simple
reading of the code.

> 
> 
> Kind regards,
> Niklas

-- 
Damien Le Moal
Western Digital Research

