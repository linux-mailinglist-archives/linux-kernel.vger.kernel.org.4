Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B670F6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjEXMtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjEXMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:49:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2108.outbound.protection.outlook.com [40.107.22.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7DC99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJHWeZ6lpVAZlwy61D9f7R/2CjG/SAvgFLZLYmRjknSHORbn/sACosccH1A+TOugoz3xkwJxx+gLzmBO3QQ42ayH/mSk9GHj16ilni91GOoClBuJfPUYpgw0S0qlLVV9QK2aI/7gYYSTxPDn+NcjgFkUUOA/c/6Vjb+S30jZGNWeYvQ+k6GNbhCECgqzgHnY7DDZFCCbIpTwgffiTPgCUC5qzEpdWRpCqGZrcdb1dmot+pEjdKJ2x+U6QC9+3EqXiucGMMEVXRj8lRKD5hUXw6dx9ebbX1Ie/aRK+YsPcR3b+3AOqyvszy/rGGaPPIpfKpkN3CdWq1BoqbpQVsocCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qYZR1Efk9fByFmg9J9XyUyAC5xBi6FRKJ8knwvet0U=;
 b=ZsdLkNDMX16lrUZIMI/1ar4Z8iU6QTWuDkFMaTNp9heAj+WQWjKk6RJSSR3CmXxEMpvVsCvcb4hh8iMkCT01DrdzIZZP+4fKGm9gOc6kdOf8hkaV0bRzfzkhPdm9A/bF9l38ceQGsGE56+6BjFnGxjzyCnJBKjySvocteF9VqLZlay1QKTypI4kFpij0kPiEESTBOO8p9wASSBX6LFPnCYeJnbwOrSCKVUdEakSfgER9wyrHya41vY4BcL1clV5SM9phG5qYcq3F/OpTYteaBes/XsJHbFOTK7x5cXLz3+ux1Y7MZT516ng1zb4sSUR8aQdmGAUVRQP584w2oLdcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qYZR1Efk9fByFmg9J9XyUyAC5xBi6FRKJ8knwvet0U=;
 b=jGxdLdWApinftW+hMi1/1rIaGPzTZV1RIbU0cBuuH/BopqgSyeqQhDWsIZyEaWANaEK0Mcn5ZH6F4R5ZNxuZwqxMsTvLp2jH42HAKsPqbYP7qKYrK2u6enkAuUUS6AiArJOhvxAQDy5bYmLS65nfLargubfYQyE8LUce6xVT8Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9229.eurprd02.prod.outlook.com (2603:10a6:102:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 12:49:13 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 12:49:12 +0000
Message-ID: <31f2a49f-bc48-d502-df31-667ef1a83fab@axentia.se>
Date:   Wed, 24 May 2023 14:49:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: mmio: select REGMAP as the code has that dependency
Content-Language: sv-SE
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
 <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
 <89199aca-5b57-e8df-03ca-b2658ee9d8b3@axentia.se>
 <20230210115625.GA30942@pengutronix.de>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230210115625.GA30942@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: 91933d6e-36ff-4783-739a-08db5c554637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5UxetzUmmyCxauFsXoggw+Y1N7H18umNc6dv7fKV8Kd9wJWlEHvm0ZVdExW3N5h8sJ/+QJO/AwCR8lyLsaQtuQB8QQXQ/R88bwzvAyHHbmsNuzTYHHWbvLgj8Qt7CZjnE9ekADnx7e6ke2kTaSHhvrSztI1ZcCVX5fR/SCB3bySrr1p1gOXNeXTs4wWFUsTtv24PqHVO1ARdVcT8s1dgq5E79ESLvKdPkfcuoGo4/hHtzBjo9jfoWiCbzv2UB8SVOa2EsY6ODoGvj0T2LNYQrCPBh84vAtbsFoZYKSS5SBj87QTq6syzfhAMAFeyppAdqeXj8uiWZ45ZUztcNrCR2y11jhYvYeHoxDoE+yYCtpMymaiYt/bdcmHoAXqtYZ4JLwYZmdfTPd8rPeBER9Yy0Oc5TriCHJGUf4bH2eQJBWTGBgW/10AoQjvN9N/49JDwuSnzDtfeZ0iOlnK3JF1srSEDLh9JqahbZYDIYPMuYR2MTIxDZS9jxOW36Yf70BAhE6fqJv51zfH81WmB3H8oWF70rmAO7vFDuP535GhtWyMzM/j1BzuPyNnU7a7uab7k5KBRU0QHNmcZHqBaHRPhcamqjwSNnBOgeIp+AHxB+fgisCcpvYPMOSFPMxhxkUb3Spgjiq6jUWUUMnrK84Z4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39840400004)(451199021)(31686004)(83380400001)(966005)(5660300002)(54906003)(66946007)(66556008)(4326008)(6916009)(6486002)(316002)(66476007)(41300700001)(86362001)(478600001)(2616005)(31696002)(26005)(6506007)(6512007)(186003)(36756003)(8936002)(2906002)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhaOGM4eVhhbGN2ZnpwbzYxNUh6aURpM2NVV0V1aGthbXNHQ1BEdkd6VGZi?=
 =?utf-8?B?a2tCVWEyVWlDMytudDIvSkdFYmZVSko4NW8yZXVNLzNnUzZDOUR3TURkR3hy?=
 =?utf-8?B?dE5DR3g2UUduT0MwOWkyb2w3dnNrdnZNMlR4QkRFK1lVSlpTZUlOeEw3ZkhE?=
 =?utf-8?B?RFZMK1JTZmFIK0xnaElJZStDNEFBcit6Kzh5MFNkOWlFcHlEdm54S3ZsVUV2?=
 =?utf-8?B?ZXFvcVhOZ0Y4Wnk3bHdWbWlpZWc4U24wM3I3alVkVzd6V25qSFVyY1piZTlk?=
 =?utf-8?B?Qk5MeU1qNUVsSEhGUWlpOUM4UndnbzZyRi9MSXhmMHJwUEYxSElTaWY3Um5l?=
 =?utf-8?B?b3haZmltNlRTT0t5Skk5bDFTR3YyK20xQ2VIYkpuRElxaDhqN3lpMFQ2L1N2?=
 =?utf-8?B?eUZIb3dLS08xdDlNalZWSmlTWW5EUTRFNE9CMnQ5c0dXZ1V0S2JyQ1pqdjdm?=
 =?utf-8?B?Tkdnd0tyUGJWQ2tMZjJVMEc2bWUyaXRidE9Ea1FKRHZuMnFCS2NJeCtSdHQ1?=
 =?utf-8?B?czQ1YXpGY01zWFpLOWxXN21VSDl4VWtTM2hLRU81SDZ1dmNmWWdlQ1pmOVUz?=
 =?utf-8?B?bXBySEhkRktIYmVCU3VQdTE1dE5xWmxtU0RVclRRR3lIelBoUE85T2pSYjd6?=
 =?utf-8?B?RmhlY3V2U3ByTXZ6Z0gyaDhDRUMvLzVHMWQ3Sk5QMnRERUJQUUZzc2o3eEVj?=
 =?utf-8?B?UzllelA0eUpHTUdmd3Qvcmp2aHIvS2dPNjhOYktwYk1LRDNRbjZGYTc2MEpO?=
 =?utf-8?B?L3ppRWJFMk1Gb0haa01tOGYzSlUwWm9URytiTm16N3A2TnE0MXhYM0ltWFYv?=
 =?utf-8?B?WG45RURLd2tSRnNUaTB5NnFsb3VoL2dxbTRrbHJaakFNQ0JEbDRkeDd4MU45?=
 =?utf-8?B?Z3BaYjVxT0Q3QWE5ZEY5OHJmaVNJcGFvT05IYXR2SStidDlkeXdtdE94UVlx?=
 =?utf-8?B?T3ZkNEpLcjFmRHg2K0d0SUd0bU5vYkYraUo0RDhTQ3ZPMlcrR1IwY083OHI1?=
 =?utf-8?B?UHFnSmU5aXBPOEJIa2VnWlpXRU1MMDRJclZYWkJReDNEUXNkOW9sOWVoTnRW?=
 =?utf-8?B?M1o4djIvUnNsZ2dNREtrWXJBY0FHdTBiL28wZWVaTEZtb2tzekRVMUFxd2kv?=
 =?utf-8?B?QkQwb1Rscm5ESFhvR3JRSVgxU21OVzlCY09uOE5MYkRHRDJMeWsxaE9lemM2?=
 =?utf-8?B?NXdxNTBZWDlBL0FKY0tsSjByUWp2b2g0RG9VcGJacU8rUmFsODRURDNVTWx6?=
 =?utf-8?B?RFJGcFFxZ0hBaGMyaXFnU0R1bFdRbHlDOTJYNWZmdUVZUFo0Z2h2b3JiU1hy?=
 =?utf-8?B?ajZPVmErL0Jzd0pQZE53SzR5aGgvaFB5dytqVWZvbG0wRVNxcFFFcmJtRHl1?=
 =?utf-8?B?emRoK2ltN2x0b2RSU3dwbXJzUFpoSXlUb2p6S2Q4NEkzODNBZk9MbHkwczhO?=
 =?utf-8?B?bmk1SSt0c0NFVVQ3QmFtdURZZTNNR0JKbVZWV1dPOTM0UXMvMlRYVkNFbEho?=
 =?utf-8?B?RmpaYXNDQWE1ZXk0NVJSYnlsNjVlS0NtNDZxS0NJZVBaclc1dGh3Y0xqRUox?=
 =?utf-8?B?ZmJqZFp3RXQvM3JLNldUMXNwTnF0YTZkZFROMXl4dUdQWnRzWGFnVmpnaFNH?=
 =?utf-8?B?TjlHbUwrakFWUDZsZEVuM3VNSG5JMGpuYjkwUzlKWTVEOXVQU3cyOWllWFY3?=
 =?utf-8?B?ZkdhSHcvV1NxYVU0OWNyK0V4Mnc4K2tuV2ZoOUdZNTk1L3lSYUN6cnpTV3lZ?=
 =?utf-8?B?QTZmcVhXRzFkQzVXcXgvRzFRZFRwVmQ4TjBLaHNBUldsMUVUdmdrdmdKeTFB?=
 =?utf-8?B?eUtTLzNwcGloRmp0WmtqWHd3dXNuUEdwc0hsZDMzcDh4ZWo1b2tuK1RjRHVm?=
 =?utf-8?B?VmtuRmozRzVPOVpUbXVUVjA0dDZiNS8wcFc2MFlkeWZnUVV1RVpjR0xqRnE1?=
 =?utf-8?B?N2hnZFVRTnIwdHh4S1piQWpVOEhRZFNDZjc2eDR0QjR6NUZXTDBRWmxubDNM?=
 =?utf-8?B?d3ljVEJnQlh3NXBmNXlNMGt5RmpBVXUzZzBtZFVBS2orK3JOeVF0MlZYcWVs?=
 =?utf-8?B?UnkwKzRySnBLNjJJM3NSTitEck1XejVwWVZOcEZiTHpyM2h4ajczcFE5R2dq?=
 =?utf-8?Q?YnnDV5UJCRGYkDojOlI50Rr0A?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 91933d6e-36ff-4783-739a-08db5c554637
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:49:12.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjYDDJX8acyHPHWbINDRcD3wI/YI/nQm6Nzo6GrsB95wFtW1v2Eje91GXJoxd7Gr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9229
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[sorry about the delay, busy-busy]

2023-02-10 at 12:56, Philipp Zabel wrote:
> On Fri, Feb 10, 2023 at 11:46:42AM +0100, Peter Rosin wrote:
>> If CONFIG_REGMAP is not active, the build errors out like this:
> 
> The driver used to have an indirect dependency on CONFIG_REGMAP via
> CONFIG_MFD_SYSCON -> CONFIG_REGMAP_MMIO -> CONFIG_REGMAP until
> commit 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based
> multiplexer").
> 
>> ../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
>> ../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
>>    76 |                 struct reg_field field;
>>       |                                  ^~~~~
>> In file included from ../include/linux/bits.h:21,
>>                  from ../include/linux/bitops.h:6,
>>                  from ../drivers/mux/mmio.c:8:
>> ../include/linux/bits.h:23:28: error: first argument to ‘__builtin_choose_expr’ not a constant
>>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>>       |                            ^~~~~~~~~~~~~~~~~~~~~
>> ../include/linux/build_bug.h:16:62: note: in definition of macro ‘BUILD_BUG_ON_ZERO’
>>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>>       |                                                              ^
>> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>>       |          ^~~~~~~~~~~~~~~~~~~
>> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>>       |                             ^~~~~~~
>> ../include/linux/build_bug.h:16:51: error: bit-field ‘<anonymous>’ width not an integer constant
>>    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
>>       |                                                   ^
>> ../include/linux/bits.h:23:10: note: in expansion of macro ‘BUILD_BUG_ON_ZERO’
>>    23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
>>       |          ^~~~~~~~~~~~~~~~~
>> ../include/linux/bits.h:37:10: note: in expansion of macro ‘GENMASK_INPUT_CHECK’
>>    37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>>       |          ^~~~~~~~~~~~~~~~~~~
>> ../drivers/mux/mmio.c:96:29: note: in expansion of macro ‘GENMASK’
>>    96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
>>       |                             ^~~~~~~
>> ../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
>>   102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
>>       |                             ^~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
>>    76 |                 struct reg_field field;
>>       |                                  ^~~~~
>>
> 
> Fixes: 8ecfaca7926f ("mux: mmio: add generic regmap bitfield-based multiplexer")

Right, I'll add that.

>> Reported by: Randy Dunlap <rdunlap@infradead.org>
>> Link: https://lore.kernel.org/lkml/64cf625b-2495-2382-0331-519d1cab0adf@infradead.org/
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/mux/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> Note, there is a patch in linux-next that removes "|| COMPILE_TEST" from depends.

Still true, haven't gotten around to pushing that upstream. Sorry. Busy-busy...

>>
>> Cheers,
>> Peter
>>
>> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
>> index 80f015cf6e54..9234f8c400ca 100644
>> --- a/drivers/mux/Kconfig
>> +++ b/drivers/mux/Kconfig
>> @@ -48,6 +48,7 @@ config MUX_GPIO
>>  config MUX_MMIO
>>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
>>  	depends on OF
>> +	select REGMAP
> 
> I get a dependency loop with this:
> 
> drivers/net/ethernet/arc/Kconfig:19:error: recursive dependency detected!
> drivers/net/ethernet/arc/Kconfig:19:symbol ARC_EMAC_CORE is selected by ARC_EMAC
> drivers/net/ethernet/arc/Kconfig:26:symbol ARC_EMAC depends on OF_IRQ
> drivers/of/Kconfig:69:symbol OF_IRQ depends on IRQ_DOMAIN
> kernel/irq/Kconfig:60:symbol IRQ_DOMAIN is selected by REGMAP
> drivers/base/regmap/Kconfig:6:symbol REGMAP is selected by MUX_MMIO
> drivers/mux/Kconfig:48:symbol MUX_MMIO depends on MULTIPLEXER
> drivers/mux/Kconfig:6:symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
> drivers/net/mdio/Kconfig:261:symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_DEVICE
> drivers/net/mdio/Kconfig:6:symbol MDIO_DEVICE is selected by PHYLIB
> drivers/net/phy/Kconfig:16:symbol PHYLIB is selected by ARC_EMAC_CORE
> 
> (on next-20230210).

Right. It seemed so obvious that I failed to even compile test before
sending the patch. LART applied to self. Sorry.

I'll follow up with a v2 shortly.

Cheers,
Peter
