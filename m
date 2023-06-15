Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61328730D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjFOC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:29:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AF1FC7;
        Wed, 14 Jun 2023 19:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYkE3Dgcg1WzJwLU3LiOofEEhDWfsPKvpHbdson1onEdpA757LTme9s81wpPZXqurxfitCSIs6EPMsBSCDqWY63oa39AntjvcE88NBl9iFqRsqlD6oNj3nvpH0wfq6RS50UvT1L53A+Ow30x7YmQnZQDTJjmNtMCT0ut9RU52e9m847nYFioLklcQ+HmJXOkcqqsCCjBNlZOlmymeOqafp5H71jJOJUsXIgW9L4pB6sIjtwOEaBPJzwikpaXau+0sbE00sMuuzT+Byr/ahYM2MJhyoDrwVOConhYLCMbWvGL2oYdcIjgzBvHvIFDa9hbnBoD4fy3IJ3eQ8vc919ODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jVDmEeeFOq0dRI3J9WFpOQgyT/WQd2f/DNCijrUMog=;
 b=aSOn/nfPPBYnI5N1Wir/EjrmQ6BbeOj9hOHJUm79kpenlyPG77IIv9+xvtPdmh0hdBBx5mC0pNo0h754pG7QQw7qiE55hKDiYewx6JzLXVGEeJbOrJJVtSMioqix7QaOyZiHwPo480CW9C2KxlqMU1c+zW+JirrQhrfNh4gAs9KUP+Pk4kPCjL2k4LZz9eJ7KPbJDdEgO9/a7y47beDz8afA0S0r2v7MvbnHc+keBF5fyQGnatHWTz2Or1CCrz4lrg0UWlpDQF9dUjPI2tcDFnrS9oMRadznMCfu42Cu9aN3hhMxqV+l4muGzNxk88ezZncqvoHE9P+3fut7vaLsng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jVDmEeeFOq0dRI3J9WFpOQgyT/WQd2f/DNCijrUMog=;
 b=ZhDu9+Tqxgf3z+hbNyJ/smHFX5pY2MZQTbBFpXoZhVvj9nXBgn/YT+pOx/Jozxr3U9UeGk3i9ZjsQPocgLCusCShuOfvnby8prohLNIb810IuWg0kRG4w+pv9DuTrnMPaa8PZrDqUXF7qjCXeD2R5GgJwS7cxMn8ZWeMKNY9GM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 02:29:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%6]) with mapi id 15.20.6455.039; Thu, 15 Jun 2023
 02:29:16 +0000
Message-ID: <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
Date:   Thu, 15 Jun 2023 10:29:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <21914890.EfDdHjke4D@pliszka>
 <3120c2d5-4473-5b72-29bf-d841e806878f@linaro.org>
 <1966575.usQuhbGJ8B@pliszka>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b5b5c7-5170-4c0f-a94b-08db6d485044
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5sJiyPNkYy9W3F/1xsa5CqN0ECu1qokcbrZoGoZQwaY4hwZ6vA3ZsZEJA7TpXQk0S8y0HrLwvuGttkBnOTTi3PUTLEz/PWTuULy/rwIA3ULxDXIdCNO9ezpPXZ0IXFn7XfMB0JIrNewf/shRXeQ8YYxLRYqP4RyzLmOAi5NV29twrjtkZaNfrSr204jmU+aDOD5MT46rPcnpXVA2KQi7GiF+28BVWyHPzuSy6fYade0syPxT9YWnpZf1vJcG97IrYZNdx/1FUYTzBata1lW4shNV5iZ+3nXwAFLLJXwWEvRVIWe5xur9EyvudrAVGSOCghKJD56Ph6WILO6jgGdPsUP/3x1oJlcBNf3jiuHYZSmRUMH4Aze0B0TI+TLPW3BnlFPqEl0iCdbOE1aAniDY/v2p4Z77sGASgUOm0TAlbbJqP49nEZURyZCt40PPch5J3msrg6V+5ac2/lgy01VrWViszlgin3VAI1mJQ+SrsUlvakxZNVUUcE4ExM4baiHa35ClUuTBz79GqVsFV8LbS/tlvjRAK+AFfoI0qckx6JcJeqmAW8pHGI8NIHBiRJGwFfj9O1gZW/smYRLAP3+OWloCvXDilPl+LaDgW8TkoLug7d7dVi9aLE0aV6b3htp0jKMtWdLb/4Dzs16zQ2dmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(110136005)(31686004)(8676002)(41300700001)(86362001)(31696002)(6666004)(8936002)(6486002)(66556008)(66946007)(66476007)(316002)(4326008)(478600001)(26005)(6512007)(44832011)(7416002)(5660300002)(6506007)(83380400001)(53546011)(186003)(2906002)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXMrZi8yanUra0diNEt5M21Sd0FQdkZjWW9XWHJHN1RRN1l4OWlaenJtSzV6?=
 =?utf-8?B?cHhNV0dVb3Vqcjk5TGIvRDVsRklVNHcxTTRleGpHbWh6czBlN1pZZVNmNk5S?=
 =?utf-8?B?VnNCa3REV2JFbU15dlk2cC85dHhLZjVBUUc5Z25nRUNXZkpqZkFNQUhVOVA4?=
 =?utf-8?B?LzlXSDc2dnpBZEF2ZkxkSXpMZVJscnBvakI0Y3JvWkxPZXo0Q2hUbDVZUUo2?=
 =?utf-8?B?YnF3U0NvZUxZTDVTaTBCK1NVMktwWStDR0FYTHdMOGswdGU1dlJVdzkzUFQv?=
 =?utf-8?B?NU1RWmExL2lMV3B3TW53TVljOTA4N010MEgrWGNTWkd1UkgvVXB4V2h3bU0v?=
 =?utf-8?B?TmU0U25TM1AyV2pndFJPZXJNL21zbXU4TjIrYnlwejNDVWNOOHFSU2JmRENC?=
 =?utf-8?B?a2k2OHk4T1d5ekhTZDFuRkdTL2dhWHZzcTZaTWdLYUZTMzJZN2FaUVFJZ1Y2?=
 =?utf-8?B?NGJ4OFBzbDR0d2YyT29BeUI5aVhIUXdzMGdGWFVERDF0QjE2bWVvWHVFbExG?=
 =?utf-8?B?RGptNUVzdFBCMXg2eDN1SUhpY0svTGNYU0NxZ3VEdWhDZXFXNWJiYnJTMUxv?=
 =?utf-8?B?RjI1ZFdGaE5PZTdyWDgxa1Iva01YbmRyZ2Q1ZHhMb3U3NmU4R1d1YkliS0tE?=
 =?utf-8?B?R0JKdWJTd1BmMGFHLzYyWDIyYUcvZms5QTBwa0lmcldreFAvRU40T3Rqc3FN?=
 =?utf-8?B?QVdFVnN6ejdCclp2U3drVTZ6MXlad1ZOd3daSnY3bFE4TER2QUdlUVpqWWtH?=
 =?utf-8?B?eDdSeU11dHl2UUVaMHFVTkFoU2YwODdvVWVFVUlzTW1NaXoyL2Q0N09qVjJE?=
 =?utf-8?B?MmNubDU2ODVYc3JLQjZ5bHVMblZ1aGNlTHI1MjdHS3hFOVovdGdlb2N0aHdW?=
 =?utf-8?B?dk94M3AzTk9KK0tsUzIzQ1ZVdERlM2pLYVVZS2RRRjVLb2gxb1BhRXNhcnhm?=
 =?utf-8?B?dHJ1S1RWRVZ5SlJrdmkzcWxmMGlHQ0l4MWRjdTc1WGkxbkRkQlVoYllYL2JN?=
 =?utf-8?B?QVQzK0wxcXFUaTBDSUYrQi9FT05jZXkzYUtJNmVkdGFsa2ZJTmJHSUJmU1E0?=
 =?utf-8?B?YzhjT1d4VWV0anFKc294NHMvUEpFK3NBRFRCdlRFbWx2VS9MbG5HYVRXclpC?=
 =?utf-8?B?Y2s0eXVJeWVFckQ0R3o4NU5FZmJiSzMzdWViZlJSMlBFTW9Ram9kd2c0QVZR?=
 =?utf-8?B?NWU2OXVnVjZWWTMrVGlOS3hySlZmUEdESEltUldMUlBPRGxwQ0xwTmxSSVUw?=
 =?utf-8?B?LzRCZFJYQlBDN1lXYTFZRXlEK2doeVpLWGM1MXBKM2RyWS9hME1JdkpTM0hP?=
 =?utf-8?B?RTBWblNUeWU0M21Xa0ZsUmNyN3RrdHlCYjV4WENxU1lqSlVLSXRUeWJ0V203?=
 =?utf-8?B?TDBDelA2aDdnOExOalh4bVJIb2dnaTM1NFN3aE1lUVJ6bjlSZVBHNU1yQ2hq?=
 =?utf-8?B?bWNlblNwYUltMHBIRHo1SXNnOTV4Mk1OZUdoL3RNYjVQRmd0UkFtTTV1WmRK?=
 =?utf-8?B?TDBJbUljdnlQbUhRS2VlcitTakRwdjV1MmQ1aHk1dHhJNk1QenkrLzVJZXdN?=
 =?utf-8?B?UUN3WjR0OTVFZy9ETFoySVUrdWNIK0ZPTFF1ak5kaVRzbnlLc3hwSWtSTGFM?=
 =?utf-8?B?WjB4YlJjMWZ2QkhWZ1NvN1d3NE0zSU5ZaDVSTG9aL2UwT214TFg3ak9iMWdJ?=
 =?utf-8?B?N05tTnd6eDNYWkVyQkk5Q0J1R0loYnQ4eDZsY3h6bTZBVnNmWTNvTVJlZEli?=
 =?utf-8?B?VlM2dmtmc2lZZnhBbU9EU3ZSc0p5aWNpVXpuUVc3V3h1YisxUDF5Q3JITUdP?=
 =?utf-8?B?YkhtSTkvanFIR3gzdGRuRWRyL2t6YTVpRVF3WGVWM1ZhaStGZWg5QlYzcHg3?=
 =?utf-8?B?K3JGZk1EME50eHNTUFpZVHdhb1k5cUNub1cwZ3VpOXRzLzgxMXF5SGRjVWdF?=
 =?utf-8?B?a2kzRGJuRXVzdmdVaE0yNjlMMVlVM0pXb01ZZnJjSWJNb1oxWk9IOXBabllX?=
 =?utf-8?B?dFplNCtKVkxqL3Q4VDNnWGZZWWlaN1lKT2t3SlFRL2hMc21jSWJPam5EWm54?=
 =?utf-8?B?MmdXQnZCc1FKQzJpMXBEQklKbDdoNmpIRjl0VHpickNxeWptWWhMZlNqdWNU?=
 =?utf-8?Q?zT4kmA6GxCW1fjj+Yl0K2jr6o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b5b5c7-5170-4c0f-a94b-08db6d485044
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 02:29:15.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV1qoCFEydhvXtK2zOl/dHty6WQbrfwwyCQBYEnsu5AcNGMqUQUT2+PgCrU7Fyw6w8MFP3bPDl5Iib9JRunMyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
> Caution: This is an external email. Please take care when clicking links 
> or opening attachments. When in doubt, report the message using the 
> 'Report this email' button
> 
> 
> On 07/06/2023 19:42, Sebastian Krzyszkowiak wrote:
> 
> [ ... ]
> 
>>> Hence, the thermal_zone_device_register_with_trips() is not called, the
>>> thermal zone is not created neither updated.
>>
>> Again - that's not the case the check is there for. It's there for 
>> zones that
>> do exist and that do get registered, because REGS_TMR only gets set 
>> *after*
>> all the zones are already registered (the driver as it is right now 
>> does not
>> know which sites it should enable before registering the zones). 
>> Because of
>> that, the first value a zone gets after being registered is always bogus,
>> because no monitoring site has been enabled yet at all.
> 
> Ok, I misunderstood. I thought that was for failing registered thermal 
> zone.
> 
> Would enabling the site in ops->change_mode do the trick ?

No. ops->change_mode not able to do the trick.

devm_thermal_of_zone_register->thermal_zone_device_enable
->thermal_zone_device_set_mode->__thermal_zone_device_update.part.0
->__thermal_zone_get_temp

The thermal_zone_device_set_mode will call change_mode, if return
fail here, the thermal zone will fail to be registered.

Thanks,
Peng.

> 
> 
> 
> 
> 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
