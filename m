Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1466ECA4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjDXK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjDXK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:28:18 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCE94EDB;
        Mon, 24 Apr 2023 03:26:21 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OAQAYP102616;
        Mon, 24 Apr 2023 05:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682331970;
        bh=d+YTj+kYAOw9gOaSfCjVLld1MKVE0O7Qk46YIombHhc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ZIl9xhTefuioFN3E4SSDNOluX8IzBtBCA6wasrmzsWul0gGQ/rxwK4ZLPpT3dpzmq
         8mNJKl19fOLLdqEZ8ZRTaS1+uGO64/xelAgckQI5EHDlrm2YXYOYfmpSkB2HGVUeLB
         NMQ9l3fCLmI9FIjzUrTvN/d4dTOtahYEnqTra4wI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OAQA0T008858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 05:26:10 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 05:26:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 05:26:09 -0500
Received: from [10.24.69.26] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OAQ6ve040882;
        Mon, 24 Apr 2023 05:26:07 -0500
Message-ID: <3a28e15a-ba67-3dfa-6445-bd21e523980b@ti.com>
Date:   Mon, 24 Apr 2023 15:56:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Mark Brown <broonie@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
References: <20230420121615.967487-1-d-gole@ti.com>
 <24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com>
 <CAOiHx==7TV3879ADbiWGbHT0NysNck4FUQXkXEocjkD2BzEoRA@mail.gmail.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <CAOiHx==7TV3879ADbiWGbHT0NysNck4FUQXkXEocjkD2BzEoRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On 24/04/23 13:50, Jonas Gorski wrote:
> On Fri, 21 Apr 2023 at 19:17, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 4/20/23 05:16, Dhruva Gole wrote:
>>> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
>>> it may introduce build issues with certain configs where it maybe disabled
>>> This is because if above config is not enabled the suspend-resume
>>> functions are never part of the code but the bcm63xx_spi_pm_ops struct
>>> still inits them to non-existent suspend-resume functions.
>>>
>>> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
>>>
>>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>>> ---
>>>    drivers/spi/spi-bcm63xx.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
>>> index 96633a0051b1..99395932074c 100644
>>> --- a/drivers/spi/spi-bcm63xx.c
>>> +++ b/drivers/spi/spi-bcm63xx.c
>>> @@ -617,7 +617,6 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
>>>        clk_disable_unprepare(bs->clk);
>>>    }
>>>
>>> -#ifdef CONFIG_PM_SLEEP
>>>    static int bcm63xx_spi_suspend(struct device *dev)
>>
>> Don't we need a __maybe_unused here?
> 
> Actually the premise of this patch is wrong, and should rather be reverted.
> 
> The bcm63xx_spi_pm_ops struct is initialized with
> SET_SYSTEM_SLEEP_PM_OPS(), which is defined as
> 
> #ifdef CONFIG_PM_SLEEP
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
> SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #else
> #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
> #endif
> 

Thanks for pointing this out, I must have missed this.
Anyway, I have sent another patch to migrate to using
DEFINE_SIMPLE_DEV_PM_OPS as per Mark's suggestion [0]. There I think it
would be necessary to remove the CONFIG_PM_SLEEP checks in the driver.
So no need to revert this patch.


> so for !CONFIG_PM_SLEEP it won't initialize the struct at all (or
> reference non-existing functions), and therefore there will be no
> build issues.
> 
> Regards,
> Jonas


[0] 
https://lore.kernel.org/all/e65683c1-9f1b-4cfb-8e14-087ef7d69595@sirena.org.uk/

-- 
Thanks and Regards,
Dhruva Gole
