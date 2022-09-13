Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69445B6596
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIMC2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIMC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:28:12 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7652DFB;
        Mon, 12 Sep 2022 19:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfDR1mJCfqEg7mzSyqBF/apJ3J+HOBwsBxo8JgL4ZYIWJFHJZrWoHI5RcG28Cf9Uhpq6HwL15shK5shIXjO0ithFtVHPaJrsmNiX8k8PcRbcJVmbTr0NoEZDyJv3vLRoBLZeYP51GDIHkgMhFboJWwJanFUoqhhVCbuNJoeVltGEKq6lZOgMIYTYTLDq/MkpG1ICZP1ekURbqe/s0pmAhMFOEzqMzNr/L6aIWPiZHRvNX4Ya5YE8XTQAX3HeHiu3UoPNV7o91LVGOMISW4ZA0E5Gp6QmGe703WwoXyDTHKIwPeF+xAlbbNJ97Mf585gt6SBpA9BSGUMGuFdrizaYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D6w9eJLXDaQv57DxEZB5/JOLQYow85Mw+jHNJwxLXA=;
 b=LdmggixPmaT8/NzApqSV9pTNwA+hySYBLdUZxoHZamDYQyOue2bbkJdU9VYL01uSC58ec5pivKKaAe1NtztvHzdw/LH9GpiuonqAONl9Uguwqpeh1W3QXAGM+w0+ls+p46jGQsYxT2VY5YSJIA65QijLh4TpxF6976C2KuunHLeD6yjjzkyX77FxTB1sNR88Wrbl4QUC9gsI8J5iFCtazhxxoTSkG73WttmXvxbJ2xQmWUdm/QnL58NBQIT6TfBvfGMRLmStoCyb9Cu3Wd6YYmENzwgu22jA53ADk00GbH6TXOlrMW9k0j393qC0eT4ortbWJIY8GTGvpgWf6N/7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D6w9eJLXDaQv57DxEZB5/JOLQYow85Mw+jHNJwxLXA=;
 b=ertzwus1sfIoDHrC0Wm9PeWX+AvdNJPxGfQo7AWoS50UZWP9pVRsGZjgfOp+HOb39W7gL3BAQiKSA2h6CtZ0mlb8mraC4vB3uQ8XmiC2DLh0vKoqc/xBB4KYhGSiLoly63stUZs378KBllVNa/I/PjvPM094IcakH9CtHWttWZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7781.eurprd04.prod.outlook.com (2603:10a6:20b:2a6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 02:28:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 02:28:08 +0000
Message-ID: <57b89f2e-dc70-9890-143c-f6da5aaba015@oss.nxp.com>
Date:   Tue, 13 Sep 2022 10:27:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Tim Harvey <tharvey@gateworks.com>
Cc:     Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
 <8736ba4e-1c61-995a-f090-ef322d84e5f6@gmail.com>
 <0c924574-d2b4-2a23-0cc2-63f32d521854@oss.nxp.com>
 <CAJ+vNU1NW9cDDB4sa+uLK3G1Z782pPe=E=GtYLTswR2Xa1YnoQ@mail.gmail.com>
 <e8279305-6bad-4029-4436-b48a4a8d43e9@gmail.com>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <e8279305-6bad-4029-4436-b48a4a8d43e9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce50e66-055a-4945-23d0-08da952f982b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFa1lBUPAxbxLAR+5lT0gTFlZug+qw0B8879KYKEgDHoEfCxszalt+h5SJ6e3R9L2S2aL1aA2otxs9ErQzIj/XvY461dYwWILuXOcWMvXrMpuZ8mYdj1jCSwUAbS3FATA47Ziro0MK+CB77cJg/0lT2FtlawMCEP0upKxJ1K1W43xXusNQC4iERQ01EOQYrKORr3PD7YV5G4ARQ8woNhi9j6CpVAWVvHvU18UaMjKBvtFuXeBey8Nmm+ihtdyb8iVp53PkZRxPHi5MU7YjerIxcPAvX1qCGiDtwA2faDSJ8Eaxv+4HjIrZmELpyRhLm/LZ1A2k0rp7nbd0FZdnmOWdtukZmp9lkH1pcb/psmOacJyIeNjfSXkBeL1MrED8pK3UJux00F4jjyGmva7gW1xVjX300QAIVafhfvfunxCKbx7/7G9m+YBbTQ8u1EEKe2bp9h849g221iU8GvxCHtJmCd/dGjQ2CUkKWf2J9xMKXgMcspy4P6KkVEZzz5H2XmNttpx1jcz2yiiC+3rn9ugfZ52xzT6cXTdyZOdfFu7xA6HUFLVy02F56ffjj3PqEQiGBGhOtgzXMFCbzH3nA0Xygo9NH6sli78fGObJ+hUnNuOcSxaDoF6oqWtlHZ+s+0S6vIb8O6EeryYXAPcekFfCtX+mXm7kHWqWAAEKlRzONrAKMpYN+rEBb+OUR6/2D9I0w5F4BX2rWfQzqURYumT7IHI+QwAA+JdpfCryf05XN9UjhR7Wfx92Qgp4LiP8Bs5CkRZtUiI+5D7SG40STlHinrpckQqUn1oprOYNxWY3I2TQ32T7shg1hkr4eqAL2/tOECREiC3UgikgF6FuIGfm+mRPpqA7xcKMLf4GTJEss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199015)(4326008)(66476007)(66556008)(38100700002)(86362001)(8676002)(31696002)(2616005)(53546011)(6512007)(316002)(110136005)(2906002)(478600001)(6506007)(6666004)(54906003)(41300700001)(8936002)(66946007)(5660300002)(44832011)(83380400001)(52116002)(31686004)(6486002)(186003)(26005)(38350700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDRrMnM0NE4vU0trMWkyVlRCTUJyQlA2VUdLcFRFMVpGa1RpSU52cUpDTGEx?=
 =?utf-8?B?WHFIV2orektDWEdrVnN3QnQ4MEZuRVVBVE9ZYzJwYjcwRktzYjh1V2lZenJv?=
 =?utf-8?B?REFleXAwSEwxd01EWElNa1hzaHkzUXp2aVI5eU1LNVNObFNmR0QvaUJhaEdE?=
 =?utf-8?B?VXdQSTZxSnJVcnVjOERoTTRxYmNiUTRYeE92eWQ1aVRQUk9QWGoyS1BsY0FE?=
 =?utf-8?B?bGdVekk2NFdEVzl3ZDFuVGRpZzZISlpJWVl5MHMvam02MVFzdGo2WVNlUGIv?=
 =?utf-8?B?TEZidk5lWWphUzJJejNjaXhJR2pIRWdEMld1SXVoUzZka0U0TmdoQk1lLzY4?=
 =?utf-8?B?ZDlveUd0WXhZdEVrRlZnNWh1OEZOWXFZMHRuTElZREw5RHJ0eGJYOFdZeXhU?=
 =?utf-8?B?V1dNa0owc2s2SHBBWGdtSlEvQWRwWlRtWkdUaCtGZlRuYjhGSE1JWEgzTk9E?=
 =?utf-8?B?N2Y0bjI2RFhrTS9CS1N2NHQzTXVWL2tPS1hsVmFuMnFMaTdiYTJnV013QzFD?=
 =?utf-8?B?bG84ZkhxcFdLYkt3SWJldmdoVnpsQ3R5UElLVnFRSWNaSm14bUsrcXA2Y2Fk?=
 =?utf-8?B?c0hRcEovNkNEV3lLeTJ0RDRiL21mdmQwRmpqTjJSUXUxSTYzdTcwMVlKT1NN?=
 =?utf-8?B?V1JDY2h6NlVtMjFkN1pqb3RNUmkyaFFOdVoyRFdSZnZLcnJrNmhGVWw4ZXp1?=
 =?utf-8?B?TXVKd2NwcXFoZ2ttN1VqZURpUmswSXkxWGtBd2ZxYXpabkNJZklQTkRBVEp4?=
 =?utf-8?B?ZnZubk13NEZLRHRYSENscE1nWlZaOEFWNnR6K2liVUNPQWpJR2prekZkTjBT?=
 =?utf-8?B?S0pJODhpdnNEblRIYkorWDEzejNoaGlFYjFCQ1FnMmZPaU9qeThrcUgvbDBi?=
 =?utf-8?B?VnFPM2g1K09wVkoydXVnVFlPdjVFVmY1SXRRMnBsRnZPekIveDRMYnJtS1lJ?=
 =?utf-8?B?R3E1RUJyUG9LQStYQ3JIaHYwdGZlVWtNdnlFQ1ljOTlPOG9qMXd1OFdtVTJW?=
 =?utf-8?B?MW5CKzErTk80WlF5YUpNeDJhK1IvTW5DRTJCZkZCcGdFa2xRWHNvNWVYemsy?=
 =?utf-8?B?Sk1Neml2YW1kTFg1L1p4a1BCcnRQd0lhaCtpNnNyeis4M2V4STllTE9tUGRI?=
 =?utf-8?B?M0xIUGdrWWpNdURYZElPaC95d2JkdGtZZXc2bkx6ZzRNZkRQZnFidTVBMERL?=
 =?utf-8?B?c3hpYXhlSXN1YjZ6TTRJbUV3eS9CVFRtb1JPQnZ4bUs4WE1JbWFTSnoxVndE?=
 =?utf-8?B?d3hTTzdTcmVmYUVPU0h4b0M4Ylo0YkJlWG4vdmdtbnIra1NmMHYvRFFRTEs0?=
 =?utf-8?B?ZDI2OENWVWh0VzFXaG1iaW5nMmRxMjVyZW5yTVBmL1B0eXdhR0w4dUNzVCtC?=
 =?utf-8?B?a1JqdDVxMkFvSnduVzNtdUdJRmozZzFIM1pCNndQNEdwL3ZrZytCT0lkdFJU?=
 =?utf-8?B?SjlvQ24yaGhBWXZWL1FLdmZGd0syTzJEZXZGZTVpb3hkV2o2c1IvZDA0T0ZE?=
 =?utf-8?B?aEJETEpCcEdsZFE0UlhwUlRkdTR6TXhoZkZFcWhCaW5wQnhIWEJJaDlGVW5r?=
 =?utf-8?B?d0N6aXVwWUovNXlmTU9ONnppKy95R2lIVVVhdFpFclRadHpYa04wZDNqanJV?=
 =?utf-8?B?OEYzMHBCWElLRGN1Slp0Q2RNemowaG1mRzltd0h4eS82M0ZRTzBIK0NrbWdH?=
 =?utf-8?B?cmVyNXlETU1wa2ZXb09PbDk4UlJnZnYvVTMrSzNOdjB1MGR4dGVMRllVdTNv?=
 =?utf-8?B?aVlDeUNrKzg3M1hxemhHOC9EbmtQOUJhUHJzbnZxdmttU3g0bDZzSENoVFJK?=
 =?utf-8?B?dG82YkdEZm0yNU1hN0VvYnV4a09xVmV3WlFGUDVnME53aUJZdjNoSmUwK25t?=
 =?utf-8?B?alArVHFYb0NGbG92TTZLckNKUWZEdFZ3ZEIwc1JGNDd2WjhtNk51eDNkck5o?=
 =?utf-8?B?ZFNlVlkvckUwRjJNSnhWdzZPTVpKb0JzUFFRWGlNa1lMeG9QdUoybjczQ25E?=
 =?utf-8?B?WTJnRHY0azhTLyt0VkFqNmFtY1FEclZxY1prYzVtaWVvdnhYaUtjbkI5N3d0?=
 =?utf-8?B?MXhJRTVrRyttK3RTWWhwOUw2OUgzY3VCaTVrU3h1YWN5U3JHZmhuQlcxNmVV?=
 =?utf-8?Q?ftwXMcs0l2yFbaxqCMr/E1xgC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce50e66-055a-4945-23d0-08da952f982b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 02:28:07.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ds2EpM8yAP0rcZPtDSwc7wKtTZfi/20NiSh7C9ueSJK15VtAoMGldkma55UZ34NkwnCER6zotu56j2bnc459cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7781
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/2022 4:40 AM, Matti Vaittinen wrote:
> On 9/12/22 20:15, Tim Harvey wrote:
>> On Mon, Sep 12, 2022 at 12:40 AM Peng Fan <peng.fan@oss.nxp.com> wrote:
> 
> //snip
> 
>>>
>>> After a thought, maybe an easier way is to add a optional property
>>> xxx,32k-always-on to the pmic node/driver.
>>>
> 
> Yes, that would be easy. Yet, creating a driver specific DT-property 
> feels a tad wrong. I don't think the BD718xx is in any way special so it 
> should not need such a vendor specific property. It might be better to 
> find more generic solution.

I am not sure, even if saying always-on-clocks are accepted, the 
property still needs to wrote into the BD718xx node, because BD718xx
itself serves as a clock provider.

Regards,
Peng.

> 
>> Is there simply a way to add the clk to the snvs_rtc and the wdog dt
>> nodes so they have a use count and don't get disabled?
> 
> To me that does sound like the right thing to do. If we have a consumer 
> which requires the clock, then describing this dependency in DT sounds 
> like a correct approach - assuming this keeps the clock enabled without 
> a race between instantiating the PMIC and finding the clock consumers.
> 
> Finally, if adding the consumers does not help, and if there will be no 
> consensus regarding the generic property - then I think it's better to 
> have a vendor specific property (as Peng suggested) than it is having 
> the boards broken. Eg, if all else fails and if there is a buy-in for 
> the vendor specific propety from Rob and Stephen - then I can also live 
> with it (even if it sure significantly decreases my happiness level :p)



> 
> Yours,
>      -- Matti
> 
