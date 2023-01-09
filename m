Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF46620B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjAIIzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbjAIIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:54:31 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2105.outbound.protection.outlook.com [40.107.22.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB713CC0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5CPbe2KoKjql/OZa7Rb1WkIvOxOULgdjOIPDhNCAWZOkZKkvoxBklu2FD4IXmT+5bbRBsCdZRbShUifiwatGxZDbHma4Xy2Ip2HbEm1zDwENZz5yDkaH/EIYvLOJtW57mF2AXV4Mnx05UQlO/KfLjRrA/zYpZgd8Us2n1xgeesioEoc4m3x843FS7essl6HzUrBjtNUlFv0YKQ2oxbtHsLvMDBK1aTlKbzkg2EMKwLMEsdEDhXrO3hozrxhR1MAdK/T6w+U4AzhWN2I1lKq3DZVY9iB9vmNI7xnKID1bvABcxLkazyBVz+d+90ZHHrawMqc0/XbOn/dD/dgqIrqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed//l5srS7awjZm7BOjsIh6cjoRoMBj4+XYqOPo+97w=;
 b=aLpnEUft/zOSWiPEYfY1qq28lblytNPPgAu1FVp9vBK7lqsjc2GnBmr8wAY1B00bz+fKlXXtBoEPyuFHUv7MxlpKhK2rK6yOn2fnCK/C3e5N2oNEdE5CrgO7PhHt6G8Vl6W2BuxGovcbIjh62SHaZtHF2Re7a3lpqAsRjqGdaNnmTBpuWZSo8cTaL5NIqep0PUlcVTy1srC266kuWiqpGjaYSS3haRcdjhvNeICOlvlCo4cmZf7rH21wi1z0GO7dEhy9g7es+y1+MI7WpITtM0JMNWpvqCc/wx7MF24fdDaQad3s/3scZfAaBYp5kq2aGIi+VKGjvLZTKbFDWLme5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed//l5srS7awjZm7BOjsIh6cjoRoMBj4+XYqOPo+97w=;
 b=IXp3Q311AqwtmMdyDiueooA3PQuo8ddtDako62up3KcMlAiWVI0FATTvYJA9lV1jS3Y+xbTUauMYqBHoPdDWjB0cmTQJnbtt347nsTac6VNGLh1vuxV+/4N6BGOPfg/IrLV4+DqVBSnN1YYIH/I008bwnA/bW3Iv8bjEdxZmgFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB9PR10MB7931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:303::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 08:46:56 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5%9]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 08:46:56 +0000
Message-ID: <04f2b720-c588-0431-b80b-2ae407bb6006@prevas.dk>
Date:   Mon, 9 Jan 2023 09:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: commit 3497b9a5 (usb: dwc3: add power down scale setting) breaks
 imx8mp
To:     Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <5ae757aa-5b0e-be81-e87c-134e2ba5205d@prevas.dk>
 <PA4PR04MB9640E88C1F4EF722682608D689FB9@PA4PR04MB9640.eurprd04.prod.outlook.com>
Content-Language: en-US, da
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <PA4PR04MB9640E88C1F4EF722682608D689FB9@PA4PR04MB9640.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::35) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|DB9PR10MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: f20ceb01-919b-4532-b713-08daf21e1055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtqSIAfEOC7v/Ea3i/uuyJgEwDuDxT/B4MNh42XgN5eynzPxYKLjG4PsX9ocHC1xHCHw1GJFala4OVs9OmTDvrAVN1KYK8UYmuC5mJc1aqiI3iMvJIYubqW4HUIRBWmUs3vQlIa/LUJ/E5wCFBeLxRC9g2vozpS0FMdtbu2E/kAu3JwPUNsUgjCCnm+66RtP/uN6QPPgJhGe1k1g4tpcqt5zqgGjyoTuPWxAjFNQUxA8+zY69KTtFx4x4Mdj9DClTCNFd+RdZRqnnVbyyJNmCsLHi6Qg/OE0/0ggRDtrlVyHHuYT6gbyHnV4k1q0A/2UvV6KrXpLEU+SAAD/mnBVREGXsdh/TKzAJ7pjkfVhC9bonTXV6uh+bfI05PV9uX7ldOyXSzJNu/Ibx/5Tg3Tmzli4UycqUW+NisXJlhWJBhWDkSJWvE4/IZbnB0+gzhTd5WJwxMdF1VsoIdTw+Q9yrQ5nzWXkjDqHoYOX6ob0CTQTTIQhO7H1+kwTmNJBYacQjQUSMDRoh9RcwFQY2cRmV099RZFZI3+iukuG8jf7OIdauCt3lNxqvUTGDchhA1yBASw8WTFFVfXntNjpbJxUYh2E+t44d89Bfr7u0yHDU3ITzt/BsuHY6d7LLrM+iHdg+lqcu/5xF1z9Szxs1jVlOXHpishhqyMuSHvDWuzlyj4t8d+R/yQ+McMSm9YnorupI/SSCMqSq9NwZIy92IYdJrEJzokR7+MyJt6Qr6579YFpcaNmbMykIXf4NeYWzIkFKpvVqNL+fvj7tfU5hxnn+9gA2/SBAGll5XSBhK0d+lFD4E8HGFNX5L/nCPB8NQvw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(366004)(376002)(396003)(136003)(451199015)(83380400001)(31696002)(38350700002)(86362001)(2906002)(44832011)(41300700001)(8976002)(8936002)(5660300002)(38100700002)(186003)(53546011)(6506007)(2616005)(478600001)(6512007)(26005)(6486002)(966005)(8676002)(66476007)(4326008)(316002)(66946007)(54906003)(110136005)(52116002)(66556008)(31686004)(36756003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnl4R0NkRU9RdzBzaGtJUFduMk9iL2JMR3I2ZzFwNTB6VjVJdm1LUlphV29s?=
 =?utf-8?B?QUdYdlROZ0Mwd3d3U3M1M0Y4NHNGNVNHY0xRckxOaDJKVzZmMGN1aWd5M1d2?=
 =?utf-8?B?M1V2MlVPVUlTMTZYVVFCSnNBNm9pVHZTUC9ZdElmNVFJVjkzeUhlVXdGRkpz?=
 =?utf-8?B?ZUcwY0tEMjlVYktXOG1PN3dScW1nZlBoRGUxQTdSZHZxOEpYYktESjgzNm52?=
 =?utf-8?B?WXJ5K1JjQzNVSWhXNTdFVGo2TDNsNnhPTW9OeXpqKzQ1alN4VzZROGk2blVn?=
 =?utf-8?B?WnVPMVJSMUZwak5yNHJMdGZ0M0RvL3pRQ1B5cGpQWkpzQ3JzUmJnTENaWnVL?=
 =?utf-8?B?cHo4R05YV2hYamFKSDgrUXFuaUhtNU1VWDVtT0VPR3NMenhJZzM2cWRITkVM?=
 =?utf-8?B?NXNURW1SWTIvL3Mvcm9uOWJNNWtQdElVRGxJNm1ScFRVN25WOEhMNytVcEQ1?=
 =?utf-8?B?SHNKZkZmMzlDT0JMWkY3aHIzcUJudFVpNWZackpDK0xwL2lhVitINitFVzM2?=
 =?utf-8?B?NnhjOWpVM2VWNnlhQmtGdks1ZWU4N09sbC9xdkVPQ1BGRm9hUTFnMG85RE5D?=
 =?utf-8?B?OWFRRndFS0RZaTNUckZ1VXBlSEtUTHFLbnk5L2ZsY3NqWTR5eXVCQ3pWbVEr?=
 =?utf-8?B?cHpieHNvNWxGTVF5R1M2aTVmZTFGVTNCbGRLN1p4RUMwL2d1dUhSQlpNSHdh?=
 =?utf-8?B?YnBiNDFmZ0pKd1VSTGFWekxRaFdYL2kzVTFTMUY1U04vZTZidWZQa3NScDJI?=
 =?utf-8?B?SWVBa1pMWHFyNGtwcUcvRW1SWFFWSGxDQUFQZHpWQ0E2L3Nia0V0SHRMdFVM?=
 =?utf-8?B?M2E5M2dzb29xbU9UdFNSdWlnQnU5KzNtck1FNk1QTW5yaGxOT3UzYVVodHlI?=
 =?utf-8?B?NHlTWkhJMlJIcXk1M1lETWVUYStDRzFsMnhmakV3bjBiWlQzeUQ3SGRHSCts?=
 =?utf-8?B?NFhSL0R5RHB5OWJxc1hNd1M3TmFYK3Z6cEsvZHhhdEdndkJBc2djeXI4amxI?=
 =?utf-8?B?dEhVNlBNOSthZWkxUURWKzk0TnJ4WmRGakovNjVuYnZiQWx5OHRRb0hIa1py?=
 =?utf-8?B?SnBVMzByS0hlR0JZTkkwUlZwVHR5NVBWZlk0QllGTllNUklhVmtYdXFGYVlr?=
 =?utf-8?B?Y1NDRmp4ZTdqYXI1K0ptTXpHNmpZNm1WM3Q4UmFWVE16WVZ3eU1XK3lSWlUz?=
 =?utf-8?B?NjNkdUpxSFBRRTdkYU5YWERINzNTUzJwSWJnVU5uM1VmeFUyN3lhUlNubjU2?=
 =?utf-8?B?K3Z3cXB3eE42Uy9QMDV5UGFtS1hCdTM1MEZVMXBiS1JQM0htZlN2emZLU1F5?=
 =?utf-8?B?RExibWdyTjZhU1R1aXhtcnBMWkhOUzIzeG1OZWtHM1lqNFRuV0xiQ252c3Fq?=
 =?utf-8?B?T21OZktIRU1kdkVrNkJJUGM5V3F1ZVdUM3VxamhkN0xiTUYyVUU1RUp1ditR?=
 =?utf-8?B?QmQ5VFBXRXRtZ3RQRHBoVDNQOUdQaUw1VG9HMkgwM1dQSGFFamgyT08rVHdm?=
 =?utf-8?B?N1BBSjdYc3NlWTFiUzNqUENCQUtXRXoyaENvM0pOajBzMExSOFBuMTVOOTN3?=
 =?utf-8?B?aGpNc2MxZHEzMURPU0U4N215aCtrNGZLT1hyakZ5Z0NrZnA0VjNkcU5qenU0?=
 =?utf-8?B?VHh6UnNjMnRkTDJ0VkZJNzlZNkJ4U0dyVERkcHpuNzdCajNmZFYvc3RldkJN?=
 =?utf-8?B?cGNJcTUxaEdvb200OHNnbFQ1MCt5bHFaU2Q2cWRBMktqZ2U1UkU1SzV0OTRY?=
 =?utf-8?B?clZYQWlXZjNyMTl4c2ZFR1RJRW03NG9XQ3c5UmJobTRKc3ZwUmJUbDNiRmR0?=
 =?utf-8?B?bjVNaW1MY1YydXpiUUNkaHdRcWR3bStkcXptOTB5VkFuOEJQTzk5d2VPczZL?=
 =?utf-8?B?RHhiOVZ2Tjk3MFpUbFFEOTF0ZHRvZTFtNlhjR1BlNjBJN0F3UTNJTkMwZkJC?=
 =?utf-8?B?cm9MMDhNUXZtcTNKaFh1d21idlhjU203TE4wYmtubU01cko1K3RxdjNwbDd2?=
 =?utf-8?B?UnNZMUc3VFlOekN3L2hVMjFrYzVwanVBLzJFbE9jQ3QwUENBUEpiZ0tGcStH?=
 =?utf-8?B?TFAzMDVUZnR6ZnR0dlNCc3FVTXMxdDBGS1JCVTUrUkJVMm55eTcwWEFHZWU5?=
 =?utf-8?B?WElLVGcxSnBWcEhlNk9wWGNlQ0VyUkNLM0dPa2x4b0dkNE1HMWg4NnV3OHJk?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f20ceb01-919b-4532-b713-08daf21e1055
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 08:46:56.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHwY0VvIKWrIQerQbEYF9uvdouFLlf8KrJ6h2mStJvgj3BfpWg8W6rHy8vK4GJIDDW4nx8B4DBGM2lCSBlCH4eSttpN5Asd8SLKrxtX+R+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7931
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 14.35, Jun Li wrote:
> 
> 
>> -----Original Message-----
>> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Sent: Friday, January 6, 2023 7:55 PM
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Jun Li
>> <jun.li@nxp.com>

>> Li Jun, please either revert 3497b9a5 or figure out if imx8mp.dtsi is broken
>> and needs a fix similar to 74bd5951dd3.
> 
> iMX8MP suspend clock(with name IMX8MP_CLK_USB_ROOT) was 32K when 3497b9a5
> was merged, a later iMX8MP clock driver patch change the clock to be root
> clock gate(actually this is a shared clock gate for both suspend and root
> clock), so break the iMX8MP USB as you are seeing, a fix patch set already
> addressed this issue, please check and apply below 3 patches:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/clock/imx8mp-clock.h?id=5c1f7f1090947d494c30042123e0ec846f696336
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/clk/imx/clk-imx8mp.c?id=ed1f4ccfe947a3e1018a3bd7325134574c7ff9b3
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/freescale/imx8mp.dtsi?id=8a1ed98fe0f2e7669f0409de0f46f317b275f8be

Thanks, I see that the first two are in 6.2-rc1 and have already been
picked up in 6.0.y and 6.1.y. The last is not yet in mainline and thus
not eligible for -stable, but does seem to be included in Shawn's PR

https://lore.kernel.org/all/20230102132016.GA10699@T480/

so I assume that it will land shortly.

Rasmus

