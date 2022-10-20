Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C060571C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTGCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJTGCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:02:13 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2E578A2;
        Wed, 19 Oct 2022 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
        :To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=R+qHwRyTxbQVbHY+8ZiLC+qOo5BYT31McH63U1LpObU=; b=cqxIjwpsX1snYmamwyOgmJsoeo
        utFe/l24N8PwvPMVivljvhyccTzu16i0TmnD6qu6bBRM5dx5x1GiNdc84TXLa46GxadI24g1nMAQw
        HURC6Vi78gs2nAWg/oXB6Kbt8dOdM3G0KHroY66wBXkC6nZnml4Hyo/fX+9+gnOD4sjIWXf2spikq
        n7aqmKxyBHcvtJIdwvTdQQ5VFnh0Ri2ZpBqErwg4UOl8fg40xEY7SWvV7E0lYLoaLW4eBc3HdGEk1
        kPC1bqyq3XmsRH2KMo57iGRAI4jcbyG7PGwDMA6nKv2j7QSJkdiNrrDiZzh/T536iA2teKW/aOYYx
        6yeMtt8w==;
Received: from [89.212.21.243] (port=55322 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1olOcy-00Cf1X-1W;
        Thu, 20 Oct 2022 08:02:07 +0200
Message-ID: <027af706-dc9f-3f8a-a6d4-44294ab846bb@norik.com>
Date:   Thu, 20 Oct 2022 08:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Andrej Picej <andrej.picej@norik.com>
Subject: Re: [PATCH 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <20221019111714.1953262-2-andrej.picej@norik.com>
 <20221019153306.GC4602@roeck-us.net>
Content-Language: en-GB
In-Reply-To: <20221019153306.GC4602@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19. 10. 22 17:33, Guenter Roeck wrote:
> On Wed, Oct 19, 2022 at 01:17:12PM +0200, Andrej Picej wrote:
>> Putting device into the "Suspend-To-Idle" mode causes watchdog to
>> trigger and reset the board after set watchdog timeout period elapses.
>>
>> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
>> watchdog in WAIT mode. This is done by setting WDW bit in WCR
>> (Watchdog Control Register) Watchdog operation is restored after exiting
>> WAIT mode as expected. WAIT mode coresponds with Linux's
>> "Suspend-To-Idle".
>>
> 
> Does that have any impact on suspend/resume handling in the driver,
> specifically with the "no_ping" variable used for fsl,imx7d-wdt ?

I assumed that it has the same impact as WDZST bit, which is also set 
for imx7d. So probably no impact. But I'm not really sure (unfortunately 
I don't have access to imx7d to test). If I understand correctly the 
"no-ping" variable is used because there is no support for low-power 
modes for imx7d. So imx7d devices never enter any of the low-power modes 
so WDZST and WDW bit shouldn't have effect on that.

What I wanted to do with this "fsl,suspend-in-wait" is that if people 
run into the problems where device resets undesirably during WAIT mode, 
they can set this property and the watchdog will be suspended in WAIT 
mode. Default behaviour of the driver stays the same if the flag is not set.

This was tested with imx6ul devices.

Best regards,
Andrej

> 
> Thanks,
> Guenter
> 
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> ---
>>   drivers/watchdog/imx2_wdt.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index d0c5d47ddede..150ba83ce176 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -35,6 +35,7 @@
>>   
>>   #define IMX2_WDT_WCR		0x00		/* Control Register */
>>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
>> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable for WAIT */
>>   #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset WDOG_B */
>>   #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset Signal */
>>   #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable */
>> @@ -67,6 +68,7 @@ struct imx2_wdt_device {
>>   	bool ext_reset;
>>   	bool clk_is_on;
>>   	bool no_ping;
>> +	bool sleep_wait;
>>   };
>>   
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -129,6 +131,9 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
>>   
>>   	/* Suspend timer in low power mode, write once-only */
>>   	val |= IMX2_WDT_WCR_WDZST;
>> +	/* Suspend timer in low power WAIT mode, write once-only */
>> +	if (wdev->sleep_wait)
>> +		val |= IMX2_WDT_WCR_WDW;
>>   	/* Strip the old watchdog Time-Out value */
>>   	val &= ~IMX2_WDT_WCR_WT;
>>   	/* Generate internal chip-level reset if WDOG times out */
>> @@ -313,6 +318,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
>>   
>>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>>   						"fsl,ext-reset-output");
>> +	wdev->sleep_wait = of_property_read_bool(dev->of_node,
>> +						"fsl,suspend-in-wait");
>>   	/*
>>   	 * The i.MX7D doesn't support low power mode, so we need to ping the watchdog
>>   	 * during suspend.
>> -- 
>> 2.25.1
>>
