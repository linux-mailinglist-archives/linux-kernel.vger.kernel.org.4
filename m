Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30D60CACB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiJYLV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiJYLVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:21:25 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E71F63C7;
        Tue, 25 Oct 2022 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+YhmmoZMLY7XrNhYbkL+EQRVhqHSiXfciFzZavrXBJg=; b=NJg02Upj0PEyhmA81VlVsjmBPH
        8A2RCWamtgL1y372jrQ4PJrhaYtAuAfyZW4g/FC+8a8A6bdj/Dbb/RZtMcYdil9ZXq6bnZotxF2L4
        AUOfC/Gz89HejPyjPgHjT59vYJ14vp7ZYR9uERNbQ5DdbrpgtdtY3Tgbh0wOGPr0baptndvI+PqpJ
        mXHGpRD6Bb/ner9r/s4N+zHenQgijZQxsmqm1TqdTvEE5Ee1ibdh7gfndUqAeKb1h/WNKAX0j8/sk
        4LxDbx7ltzbnsy0jOOe1E5nKV0QOA/AUzQ3BRoMdnDm0c3AjpacJ++bzDDsvnoK+UT5OeU4znCnFS
        0uLZCpJg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:38524 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1onHze-006z2X-4R;
        Tue, 25 Oct 2022 13:21:14 +0200
Message-ID: <56af1cc3-c10e-5694-d25f-252304732568@norik.com>
Date:   Tue, 25 Oct 2022 13:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] watchdog: imx2_wdg: suspend watchdog in WAIT mode
Content-Language: en-GB
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221025072533.2980154-1-andrej.picej@norik.com>
 <20221025072533.2980154-2-andrej.picej@norik.com>
 <13126397.uLZWGnKmhe@steina-w>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <13126397.uLZWGnKmhe@steina-w>
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

Hi Alexander,

On 25. 10. 22 11:38, Alexander Stein wrote:
> Am Dienstag, 25. Oktober 2022, 09:25:31 CEST schrieb Andrej Picej:
>> Putting device into the "Suspend-To-Idle" mode causes watchdog to
>> trigger and reset the board after set watchdog timeout period elapses.
>>
>> Introduce new device-tree property "fsl,suspend-in-wait" which suspends
>> watchdog in WAIT mode. This is done by setting WDW bit in WCR
>> (Watchdog Control Register) Watchdog operation is restored after exiting
>> WAIT mode as expected. WAIT mode coresponds with Linux's
>> "Suspend-To-Idle".
>>
>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>> Changes in v2:
>>   - validate the property with compatible string, as this functionality
>>     is not supported by all devices.
>> ---
>>   drivers/watchdog/imx2_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
>> index d0c5d47ddede..dd9866c6f1e5 100644
>> --- a/drivers/watchdog/imx2_wdt.c
>> +++ b/drivers/watchdog/imx2_wdt.c
>> @@ -35,6 +35,7 @@
>>
>>   #define IMX2_WDT_WCR		0x00		/* Control
> Register */
>>   #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* ->
> Watchdog Timeout Field */
>> +#define IMX2_WDT_WCR_WDW	BIT(7)		/* -> Watchdog disable
> for WAIT */
>>   #define IMX2_WDT_WCR_WDA	BIT(5)		/* -> External Reset
> WDOG_B */
>>   #define IMX2_WDT_WCR_SRS	BIT(4)		/* -> Software Reset
> Signal */
>>   #define IMX2_WDT_WCR_WRE	BIT(3)		/* -> WDOG Reset Enable
> */
>> @@ -67,6 +68,27 @@ struct imx2_wdt_device {
>>   	bool ext_reset;
>>   	bool clk_is_on;
>>   	bool no_ping;
>> +	bool sleep_wait;
>> +};
>> +
>> +static const char * const wdw_boards[] __initconst = {
>> +	"fsl,imx25-wdt",
>> +	"fsl,imx35-wdt",
>> +	"fsl,imx50-wdt",
>> +	"fsl,imx51-wdt",
>> +	"fsl,imx53-wdt",
>> +	"fsl,imx6q-wdt",
>> +	"fsl,imx6sl-wdt",
>> +	"fsl,imx6sll-wdt",
>> +	"fsl,imx6sx-wdt",
>> +	"fsl,imx6ul-wdt",
>> +	"fsl,imx7d-wdt",
>> +	"fsl,imx8mm-wdt",
>> +	"fsl,imx8mn-wdt",
>> +	"fsl,imx8mp-wdt",
>> +	"fsl,imx8mq-wdt",
>> +	"fsl,vf610-wdt",
>> +	NULL
>>   };
> 
> So the models listed in Documentation/devicetree/bindings/watchdog/fsl-imx-
> wdt.yaml not supporting this feature are
> * fsl,imx21-wdt
> * fsl,imx27-wdt
> * fsl,imx31-wdt
> * fsl,ls1012a-wdt
> * fsl,ls1043a-wdt
> ?
yes, you are correct.

> 
> But all models are listed as compatible to fsl,imx21-wdt. So there is
> something wrong here. IMHO this sounds like the compatible list has to be
> split and updated. Depending on that this feature can be detected. Maintaining
> another list seems error prone to me.
> 

So basically the compatible lists would be split into two groups, one 
for the devices which support this WDW bit and the rest which don't 
support this?
You got a point here, but...this means that every processors 
device-tree, which has two compatible strings (with "fsl,imx21-wdt") 
should be updated, right? That sounds like quite a lot of changes, which 
I'd like to avoid if possible.

Best regards,
Andrej

> Best regards,
> Alexander
> 
>>   static bool nowayout = WATCHDOG_NOWAYOUT;
>> @@ -129,6 +151,9 @@ static inline void imx2_wdt_setup(struct watchdog_device
>> *wdog)
>>
>>   	/* Suspend timer in low power mode, write once-only */
>>   	val |= IMX2_WDT_WCR_WDZST;
>> +	/* Suspend timer in low power WAIT mode, write once-only */
>> +	if (wdev->sleep_wait)
>> +		val |= IMX2_WDT_WCR_WDW;
>>   	/* Strip the old watchdog Time-Out value */
>>   	val &= ~IMX2_WDT_WCR_WT;
>>   	/* Generate internal chip-level reset if WDOG times out */
>> @@ -313,6 +338,18 @@ static int __init imx2_wdt_probe(struct platform_device
>> *pdev)
>>
>>   	wdev->ext_reset = of_property_read_bool(dev->of_node,
>>   						"fsl,ext-
> reset-output");
>> +
>> +	if (of_property_read_bool(dev->of_node, "fsl,suspend-in-wait"))
>> +		if (of_device_compatible_match(dev->of_node,
> wdw_boards))
>> +			wdev->sleep_wait = 1;
>> +		else {
>> +			dev_warn(dev, "Warning: Suspending watchdog
> during " \
>> +				"WAIT mode is not supported for
> this device.\n");
>> +			wdev->sleep_wait = 0;
>> +		}
>> +	else
>> +		wdev->sleep_wait = 0;
>> +
>>   	/*
>>   	 * The i.MX7D doesn't support low power mode, so we need to ping
> the
>> watchdog * during suspend.
> 
> 
> 
> 
