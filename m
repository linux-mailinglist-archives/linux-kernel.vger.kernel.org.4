Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA61648274
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiLIMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLIMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:39:02 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7CD63C4;
        Fri,  9 Dec 2022 04:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+lmps+iNRof007bY87b6I1jGaYlYB55DbUGOqqbhaCE9gZof4H3ZZwadsSY8ig9cqAOre73jAOSx8K9ATMR0vls37zd0JnUZB3KMIxcIcTs7pbby9K0hkiePf2wo+UVK9ktciWp2fZVECzi5oDrQ33883dXruZiMcBcN0eJzwR5szoMI4wj+I43CKPLbPT1pY6lzccCQyc8rrCEabeEZrCDkq3SHns8omzECilZU6n7f0a3SG6l5F6mqqgCxCpCT7LtF1nxJ8MY9JvphvPqj0dvowN+h5pR+2lNpfSkhcosvffnsmWEiATzHQvrMp3L8Fhm+LzY2JKSh7liCoTtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le4nIM4c0zX17a4c0R0CLv/V2WPWk43fFIRlqAADmm0=;
 b=nLHirrre++HbzsHe1/vur9oXwm+lRT8+NpKrJyLCVnEwcB9loWgR1NVrxQYRPDC11bl+gQt89VNI0cHP5WoxpB5poJn+uUP56frl+bxQT0/zdfbH4N+NimA04XtA0NHpvQV4bNnTnru0q4hOFdKgJ80M7G+NcZEfJP5i7BazXEH6TOWWzOCXcOD+deNwbt49PBwQr+SNMK4Dkint3LmHxhHP9tBOCfFIlO6B0ZDvyE+HBfHuc7Eqkl0jFsCF8iS27DJgTTSCeoweWW8TnZMnxiK9MonnIkficQ2lIkZshusl41WPP7HkycFqUPGCVHK0Mngo3loFvjfqpNFihT2D4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le4nIM4c0zX17a4c0R0CLv/V2WPWk43fFIRlqAADmm0=;
 b=JZdKj0zRvnzv5gRfCr520t2d4aU6FJec2tCjxBFk1UqRLdzXAxnQUzKVSmqDYbe4DfN7L0ST/dwz8s+dikS9MwTzBI6MnqsyMMovUmeImmKQmhOLm3OSDoRnKo4AMKg2xn/owVFkaZDRhnoTf72qjaVWE/C1fdnR+Fa1MY2T64kvlUnioitWXe1Cdc1Z/bg1IVHVrS65SUHnrTBVaMLe0xgj652zw8QTb6IMZJNtdJuh+S9kB+yu8dSXTnq0ywYY4N4ZMlaKbbK9mTmh3KxrCdtgQVMHWB7RMaWboPh/mhXHZVTsnIW4oMPKL/+FNjYg7ybABi3y1BIDs1E0C9oLnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8423.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Fri, 9 Dec
 2022 12:38:57 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ebd:cd48:9396:76f6%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 12:38:57 +0000
Message-ID: <28b4be7d-1bad-b16f-9445-620d7ac0c07a@theobroma-systems.com>
Date:   Fri, 9 Dec 2022 13:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        Minas Harutyunyan <hminas@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
 <Y5IIaeip81DIvEZ6@kroah.com>
 <69c0f9c0-5c89-e99e-c807-9963ca377093@theobroma-systems.com>
 <Y5MmhEMMx2sy91LS@kroah.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <Y5MmhEMMx2sy91LS@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::21) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a69842-03c8-416c-b7a9-08dad9e25749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6HQHMYQ00uTeh95CE/3pLHIDi74URbwv4EgNl13PRv7oW0/pCM/9DpQk2UZDL10m2tpGea68nyJi1UtLW0/wjr8PDiYQbJFvmmfkx6fj+cSOtUdQqTjnVUfsqnv60SznY9IXtTg4CY1o6CYUcZPSEgljl8H8KSs7NsyUAzOWYcouj6nvhyNIEkko4VQf5KE2vT0eAtHLuPaoOZ20C3mExKCJi3afO8TABcsN4BccVlWw3ysfmaRaJ1DatfV2a3xGQWijwDfNZS/1noncyzoUfifCbezDpKJxbkN9+aTnEF8GdGKojfSfUHmLe1p8cLvXj5e2U0cCI69Hn7TSuiTivFOa0ZfkwgfIrdcN/rjsGVXCFgf3DyjCiFnw2vMOvZ3Q+ZwRI8HKjvr74IU5wtF8JFsQBrfP+zQx6AFxRH7V1Y83xl7sYnQ04SSK3Oa0nm/jChq+d8WFkLHQ3226/T6CaMJvMZaZmtq5Z0g9SYO/sqWzk0WRX+o688QYKH+fatYM/QNB53ovZwIgJWrI/WUZUow0hKwMrPg7GxfHthaYCF/8tRsTAJmm1GB567+PxrihjPRb9EfwwLTOXnMMpCi0AMfRmtlynH5fIF0ILy67pJQhSXgV5XRE/j3qWKv3pkN7zS1bH1Qsgv+Deqm/LwaIYcKyqk9tJ47bEXexlwguom6hMS7XhlwL7SVAVCkdr2n7tufJAR+E2Ghv6XNPcAa7QIx/J00Ooq3doAFzDt2nAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(451199015)(2616005)(2906002)(66556008)(66476007)(66946007)(4326008)(8676002)(83380400001)(36756003)(6486002)(38100700002)(478600001)(26005)(186003)(6512007)(44832011)(41300700001)(31696002)(8936002)(6506007)(86362001)(5660300002)(53546011)(6916009)(31686004)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?empwL2hnZC9IT3UvcXBhZ2E4V28ycDZITXJUMGQrbnExMTZKNHdJeDVmd25Y?=
 =?utf-8?B?ek4zb1c0Zkc0UlE0T25sditWb1BKbWhXcUF1dFJzOWs5RmZmZFI0SnVVdEMx?=
 =?utf-8?B?QzUwOVZUbjRHdExVNDZsa1RPYTNveEVJRkRSNFdHYmxHU1pwTE5wWCtBV1lS?=
 =?utf-8?B?YmlxU2x4VVFLZVVoc1l4VkFPMUhXTmhwQzVFTkpBUTFxZENmTndVWUUyeHkw?=
 =?utf-8?B?VTgwQWt6aG9hTUVObmErMGczUlFQWjZmN0cxY1VNTS96L3hYdnBFcEdmbUp2?=
 =?utf-8?B?STRvMTYvTVNXMjFEUytRNnBweW45cU9kc1o5WkRWRTF6aWxFeS9MZlFCRzhj?=
 =?utf-8?B?c2ZWZ3NReWp4UmV0akZFbmd4c25ncFp5N1JEZnQxdEltV1drNFZYcHh5S0pC?=
 =?utf-8?B?d25IcHIvekFkNWxUUGwxdGl2NDFHMWVCdHM0bTdXT0wrZGJPL21aWjZSakhz?=
 =?utf-8?B?OTJGS2FxQkxjdEY3UndKc2ZoODRuaXJyNERibHhMOVEzY2hiQUlpNDM4aWt1?=
 =?utf-8?B?ZGVaeXZLclJwS0t4QWtrK3F0RmQ2WVFWUC9XMEdtMW93b2dTNzdDbUVYWjRL?=
 =?utf-8?B?VkV1VW1NWnFXdmg4RkxFTC95YlRhUWNUSkVWWlhTMkVXSTh4WHQxbllDeW5l?=
 =?utf-8?B?TkI4aDBodXd4a3RuS05raFVnSUVWV0NEUmRMSStYd2NMbUVCYTNNYXlQMlJP?=
 =?utf-8?B?VVRXdHIrbTJOdzBCTHpBU2xqNW1SZEhCZG1EVGVYQ3dPMkdITUdiMTI4dUZ2?=
 =?utf-8?B?SzE5U2VUejIzOHNTNXRkZCtUSHpCK2tKY0NyMlJPOWZoK1FpS04zNWM2clRS?=
 =?utf-8?B?a3Qxa3hzOThJRkRtT1d6cDYwKzk4NENPR2JOL1RWRjVDR1h4ZlFvbDMvTWhY?=
 =?utf-8?B?Z2EyYVBsaVZzSTF2b0lVMjlFaTAwQW9YcFNMa2tEdmFTVEd4bGwra3hxTFh6?=
 =?utf-8?B?L3FpU1ZnVVZSbEFoNEx2eG0wWmhlRzNqOTdiUGxaOE1XVFZGTG00ZlJvZG02?=
 =?utf-8?B?NlBjMkhBUjBCUmhiWEtCaE5DR082bm55K2k4YnpUMGI4M1Vtc1FGK2JJZTNl?=
 =?utf-8?B?K1p2d0MzZnlIN1kzMjFmWmVneU81ZVJQaEZZWFZkdkdDTTMralRaM0RpbXdZ?=
 =?utf-8?B?ZklFWUllQmVscnFleEpqbktocnc1U3hxMkdFMDZUbmlQaXdVLytsNjhPSXZK?=
 =?utf-8?B?NHpZL2N1Q1ZPd2NNa0I3Wm4vU1F5aW1oUGlVYU1pb2pRN1VoS2Z5UEQ1anZL?=
 =?utf-8?B?a3VIZWkrN2tIcERQZjdHTlkvcFppMzFBelJyZGhrdjVqNjd2NE5vQjdNUy93?=
 =?utf-8?B?WHBnTGxBYUtZNmhOcEpYRENidEZZMU9jZWlZNWsvQThQUEJkL1BPQldSTWZ0?=
 =?utf-8?B?dEZpU0RGc2ZoWmNVdCtTQmZ0QlpONHVlazdpT1BCbS9hOHVOUG1haExwYXNC?=
 =?utf-8?B?S0JoT21xRmdqRE9rbFQ3ejhhVG01clpRb2ZRRU1qaGlUbXpEd3NUMWpCNER0?=
 =?utf-8?B?QmU1SERhMG1xbzdkSklya09CQWhkN2VNamlsVXFneWkzeHdHU2Y4bFdwT0F6?=
 =?utf-8?B?Z0IvdGd1UlRUTi9aVlpwTERUUlgrd20rWUxFdm84RnRLaHpmTlBnZUhJSHho?=
 =?utf-8?B?V2hMMEx4ODh4ei9xekdBbDVRYmMrbUlVMlB1MXlPVUdLeFJydmFZR3VyVkYx?=
 =?utf-8?B?Z3lacnNwaGNJbS9FbDN3SnJpTUtuQW9IL092dStmQVdyYk1oeVJ0eG1OcVNp?=
 =?utf-8?B?ZzdoRSt2VEgyYWFiU0E1OG9yM0hkYkhCZ0syb3dNT2svWFdBb1ZpcFBhL1hr?=
 =?utf-8?B?clZXb2lqUzZJL0xtWkN3T2htNGNUdWtTZTBKK1ZBWkNZVkVoR0dyWmdYYlRa?=
 =?utf-8?B?UW5FUmUyVDNMZE9LaTJxRllEckJZU1p5OGhFM0c3WWZ1Vmo5Q1VSVlEwOTBh?=
 =?utf-8?B?aGRocEFPS0hTeFlsaEhHRDZMa2ZMb2ZMNFREQWxxdktkd3pYMlY4OTdTdGY4?=
 =?utf-8?B?ZkVObTBSejN0ZFE1K0wrMU5oSHlSaFdWZXQ0NWJmcWtXOTRHeWZET284dGVY?=
 =?utf-8?B?ZlVGcGxXRTVCUURkZVgxUXdNMk1ERTN1aEhMMG5nVjZ4NjNYYitjVmpsU05V?=
 =?utf-8?B?M2wxYTI2VjNoVU5aT2lWZHVzeVNHbDd2NVRzazdobXVrMitpUWh1VVl2WmZX?=
 =?utf-8?Q?NNtB6hDuSaOXhh0ianxgNVU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a69842-03c8-416c-b7a9-08dad9e25749
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 12:38:57.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU7BN8I/tSjM5JEyc8lmZssoybSstJy+zIsTw884Oi3QgP8xFh6ZZm9sDjOoxIj6/2AAd/WYZIxvUYUCWd3d9BGvB+Zo+70BHTMIz0jk9L+7aV2+lpTw6dXIn5FPgvN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8423
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/9/22 13:13, Greg Kroah-Hartman wrote:
> On Fri, Dec 09, 2022 at 12:15:34PM +0100, Quentin Schulz wrote:
>> Hi Greg,
>>
>> On 12/8/22 16:53, Greg Kroah-Hartman wrote:
>>> On Wed, Dec 07, 2022 at 02:19:18PM +0100, Quentin Schulz wrote:
>>>> From: Bin Yang <yangbin@rock-chips.com>
>>>>
>>>> The usb phys need to be controlled dynamically on some Rockchip SoCs.
>>>> So set the new HCD flag which prevents USB core from trying to manage
>>>> our phys.
>>>>
>>>> Signed-off-by: Bin Yang <yangbin@rock-chips.com>
>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>    drivers/usb/dwc2/hcd.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
>>>> index 657f1f659ffaf..757a66fa32fa8 100644
>>>> --- a/drivers/usb/dwc2/hcd.c
>>>> +++ b/drivers/usb/dwc2/hcd.c
>>>> @@ -5315,6 +5315,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>>>>    	if (!IS_ERR_OR_NULL(hsotg->uphy))
>>>>    		otg_set_host(hsotg->uphy->otg, &hcd->self);
>>>> +	/*
>>>> +	 * do not manage the PHY state in the HCD core, instead let the driver
>>>> +	 * handle this (for example if the PHY can only be turned on after a
>>>> +	 * specific event)
>>>> +	 */
>>>> +	hcd->skip_phy_initialization = 1;
>>>
>>> Wait, doesn't this mess with the phy logic for all other chips that use
>>> this IP block?  Have you tested this on other systems?
>>>
>>
>> I have not. I asked this in the cover-letter but I guess I should have made
>> the patch series an RFC for this reason?
> 
> Ah, should I drop the first 2 in this series that I already applied?
> 

Up to you. I need the three patches to have it (somewhat) working, so 
only merging the first two isn't going to improve the current situation 
much for me. I don't mind carrying them over for a v2 (or how many 
versions are needed).

>>> I'd like some verification first before taking this change as it seems
>>> very specific-platform.
>>>
>>
>> There's already some platform-specific callbacks for the driver (see
>> dwc2_set_rk_params in drivers/usb/dwc2/params.c) but this gets called too
>> early, before hcd structure is actually allocated. So we either need to use
>> some "proxy"/shadow variable in dwc2_core_params and then update it right
>> after hcd gets allocated or have another platform-specific callback only for
>> hcd (post-)initialization.
>>
>> Nothing too fancy so shouldn't take too long to implement. Any preference?
>> Something else?
> 
> Which ever you think would be simplest.
> 

Got it.

Cheers,
Quentin
