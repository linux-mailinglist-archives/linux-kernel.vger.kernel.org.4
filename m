Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8C5F639D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiJFJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiJFJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:26:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80111.outbound.protection.outlook.com [40.107.8.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A5E74BBA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5BhJn5kS5GAuYpYUm67f9O8cYYvRZM+Bc9AjDe96rgBWGQz5aMZ9WTivj4K7ihzQnNXyMDcogqzJ99/l0Q5y/t9Qt4t4LeEckSHRD1EOA5mR/cGTMSzou7iNeD17J8QSWvxbb4kkX2ImUiISv1LCYLqr3tCH2oiHV/LIXwNn6RmgiOMYiM7cJNMMj5BtcJr8Q0k5dcnqBHcZhJ7Ne80cpFCGovX95XIr1PoU/zHp134GHnDpkLTVNhpg9gYODAi0v5q0Yo17UMQhlSeHjwNA0OOH8ulspPzq+21Ls1qHgoEZzajYdQViqEhPvf1MEZ6KtHvEBbY2e6+vXtv1vKF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unMySek1M62ErQXzrJ25kEBlf3eeqmzIDN5SdYzLOo4=;
 b=kSj9t/xx/mX6BkYHnfzlpk6HFP8Q5LvKgyvwDE8K8v4Vf6+XF0hzqNbVLcRc9VguNKLWNgWz5kin/tdhbtwzNGXra3LbogTcamPoGSptZe7HrG1eQd37JPR9kDNbTMUe/ZEnGwqrfw3OK1ZVwhRMdR9atsUkd/ExNuvGyV3vhXxs96yayCydGShI8vU8Twau0pGeVvl4OTMBZZJodE+nzLIcjFly//DLjwJZlMgA1Txhc75asNqJdhTIduxem8jsWy2/SUHLWDEH3r4nnzhZInn188aZ68b2Ef0+8xnRPnXiTzHo05w7TdeiiM2dn+veixcjlv5XTD6TMrXV6ElENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unMySek1M62ErQXzrJ25kEBlf3eeqmzIDN5SdYzLOo4=;
 b=js5elzZvzPkgfwy2XjUAB+aTiU5PJk1l4Xp9pUJtW6uPipQNxP2PjhcfaAANNncZNz4b+xA90soRrX1MMl483i/23lwddcm6XvAcXQ1xU8akedR5O/c9fSLJKj+oAVoHICKzdGZQDY9Kk4eN9ZRKDveN7wxQ2gfxCaoMmSAX0iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VE1PR10MB3855.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 09:26:48 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dcb4:4270:c5a6:5732]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dcb4:4270:c5a6:5732%7]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 09:26:48 +0000
Message-ID: <d55465ac-fe0b-130c-31ae-0ce62af3eb5f@kontron.de>
Date:   Thu, 6 Oct 2022 11:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] spi-nand: add Winbond W25N02KV flash support, fix Winbond
 flashes identifications
Content-Language: en-US
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221006033256.111664-1-mikhail.kshevetskiy@iopsys.eu>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221006033256.111664-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::18) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VE1PR10MB3855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc86ae7-fb5d-4514-6e9b-08daa77ce4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbX/2IfsaS7tvwZnGmoTYdOBYUsVXJbZkUwaCAOsxzxmlunRuWgNcrNGYuZow9F5PRZcT11PYOBnuVBau2frjO+jWYPaiyf0qSWYbrHJWNkr+eNS609FnGuIsIJbubHME52VfyhkONlAz9Br7xqdslJ48+bd6ii9VpBPf0ikGicaC5yyJOeU8kJ9IJOPMAeDF7nEO2xhNMvipvRtYTp8z8RA4SwS2qC6mPgmMtRxwLLg3wR1Iy6Y9HkzQ+EvVwMiHuSUra/GpGHTLMBjDU5Vpee7mo8IcOiMBxUPgZol1PWfHgDLyeccTs9mJqRjf5Sa5L8BM/ABN2z/IgFJy+UN8YmKS/RAeLpQtB+wYZAuknVgAb9/qXBRI91G1acpJggr5TEd+E0IjLn3Ax+Rb12FsXd90/lYvGa8X4+ohNrEJwYjmVKqq5lkq7/WCNvJvho+RK0VHNCpPI7tIuvMX4Z0t6mknIn3XlV2bGD66i84DEnukkCHC898rHlQCwiwofpVdt1/rbv+DEvMxyBgegFZXVuZZsbeMYtZkE5Y5VGgqE32Iyq78lFhiN5WTo4og43As84k66tAnqgg32Ve9K3vA/P1ERbauJLXMGIC1sMMZE2V0U3SEtxN/z6GYqsaqEQRILhKWKMiYog8t52Nn2hodTO9JDwd55MIB63MwcJGXOz94LWxKnwNGRZK+p6fMepgg2H/Z4IacevnhNq0gE5WBLyg0NkPVfCHT6KprRoMGGiedMo3do8EIFtIpqbbXMV8NiXgEVii/XjFSuBvwe4SLEh/GEPjyWDqN5PGdMnApqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(44832011)(2906002)(2616005)(186003)(6506007)(41300700001)(5660300002)(8936002)(6512007)(31696002)(38100700002)(36756003)(86362001)(54906003)(316002)(6486002)(31686004)(66556008)(8676002)(4326008)(66476007)(66946007)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWxWVnU5WmhpT0kxSWZnV0NjWCs5eDZZdWdIaUVrem91QzN6MldjeVAwSHZt?=
 =?utf-8?B?c2lxWi80MHdYT0NwOHQyb3YwcU9KeVhpcXhIaU9lSldrbHVPWmRpS1Axb2Vn?=
 =?utf-8?B?VkVNd3dvVDZVbmxLUzVtK1BDN1p3YmY2eXVOcXdZS1NNRy94RVdnNnR6VjR3?=
 =?utf-8?B?OTl4eHI3SDdFZkNYMzZkRGxZdHBvN1YxTzROTWhsZWMxdmdiek84RjNNNkFE?=
 =?utf-8?B?TkdIekxPQXp0MTJsWFJNN0NzMDhSYlFyeWkxdVBXamVJOHI0Z0NYZ0d2YTZ5?=
 =?utf-8?B?SUpnSVU0TXpWVkU2WEdZdGZqdCsvUW1wVmRFQzJmSGkwVnVhb0w4NHRQZE84?=
 =?utf-8?B?cGhQK284UXF5MXFxRUIxZmgwWUkzNWVZUVhQUThDMWJRMW5ZMnNUcnpsK2JH?=
 =?utf-8?B?dmVPWittSldVMnhLUE9BbW9SQ0NjellvNTJyTDZtL1BERTJTVCtJTEhOQm9Q?=
 =?utf-8?B?L2xjS1g3RXhHM3VGOFZwZk9WaU54Wm9sK3kxYVgzcmk5bG1RZVFWUWhyMUFr?=
 =?utf-8?B?OERrM3N3NFlXSW13anZEcDB5ak91YWtjTzh0dk9pOW5VWGEreHI0TXV1V0Fy?=
 =?utf-8?B?VG0zVlgrLzFMMjZ6K2tXeXpOcjRYalRBUkdNSUMydWFZY01SYk56NGZEdGFD?=
 =?utf-8?B?TnBNQXNQbkdTclZLc3RybzlBZVQzMFNvdkZEQ1h1YzBlcEhySSsxL0JGbG9W?=
 =?utf-8?B?NXJzUGlKK0VhQm5HU3FJZHhvbjVEcnduYTd4NXpGSWIrd1ZlMjYvUDI2blBM?=
 =?utf-8?B?Tldudlg4RGFBUnJwYlFhYjZ4SEVvTThtQXJCTEU4NjNaaUVzSnRDMUdNVGdH?=
 =?utf-8?B?VU93azFsZ2srTXAxY0pnRUdBeklyRGpsVUcxdWM3SHVxMG5BQ09QVFF4ZGlt?=
 =?utf-8?B?RU15V1NUaS9wdm1KY3BrSXBRTFRSbUVnK0dBU2RCRTVMK0lNc3lzbnc5VzdT?=
 =?utf-8?B?N0dyZzVpV25zNzV2Rnkzc21SblJZU1ZOK2FtWUNRWXFqTldmSnl0N0N0c2lt?=
 =?utf-8?B?NElybWlHWkFBWTFqSWxlZ2ZTd2ZWYTJJVTlEcFozbTJzVGFGMkViVGJVQ2pZ?=
 =?utf-8?B?VURFWG9DZ3dWcTdHRW94M1JSV3JFcXdSSElLaElKYkxZK1FoRGFPTjZhZUwz?=
 =?utf-8?B?Uis2SGthUG1lbjB6REpVazNvWTArVmdvbjlkbW5MYkdEenRCdEpLWGFoSE5q?=
 =?utf-8?B?YlZYS3ptWmFzaHlRK2FnR1I3bWZDODUvaWRhLy9hWUJXSkxnU3UxUUxUSk1H?=
 =?utf-8?B?dzYrVTY0eWtRMTVOM2hLdHBmTHRQTWR6SERKMGY2R0JYVWl1SGpBYUZOOGtk?=
 =?utf-8?B?Zk9yOVR0eUNiR0J0OC9iREt0SmFDd0VBcnpvWms0Vk0vQkNReVY4S2dLU3pO?=
 =?utf-8?B?cERJdzhHVmwybmxpQXFzODZYdmtPU2I1bUxaSVFrNWJOVm5obXJtV2VUelBw?=
 =?utf-8?B?K1ZKTk1haGhDS2tCVFRGN2ZTYnJCbkQ1ZlptVGw1MVRyaVdIbm9ybW9zcUtm?=
 =?utf-8?B?VTZzMHd5L2FSd3AzOGdlR1YrYjAvSEpSMDFlSWNsVXFadXFPOGdiMjBKOXkz?=
 =?utf-8?B?Q1FTMlNtdUJsU1IxNlZwY3RMV21RdnNQYWlPQXR6anZnWEhqMys4TElsRmc1?=
 =?utf-8?B?cmJFQlpjd0lCVlVPQnF1aSt1RE1nbVc1VGxXMXYxRUdHeUNlNFM3cEdvOU14?=
 =?utf-8?B?bkpicWZSeDlhSm5QOEFDRGJJN0lITjJWK0tIV3pPUVdJUk44ajRnd25SRU8v?=
 =?utf-8?B?UThiRlA5S1pvdkRuTGdwdlNwclVuVlpjTFdEQWV0cmZqdW4xajJnWHRQUitW?=
 =?utf-8?B?T2hIRlI3T0JXcTAwNFF3RE1tWVk5T0dETnVIOStLazRoK1B6MEU3SXpOWkpP?=
 =?utf-8?B?dEk2UkVCU2UwcUJIb09mWVl5dzZaMzZSdFBodVE4VWo0aGVmR1RFWUllcE54?=
 =?utf-8?B?R1YyWWhyVm45TEFyVGxGd2FXMzB2Q2NIdFc4bFV6Qjl2Smc4RUNLb1o2aEZ3?=
 =?utf-8?B?R2V5azZTd3YzczRaQkZnQmhwNlhERUs0eFhEMUlPbzc4cnZGSGN4UFlONExq?=
 =?utf-8?B?ODRyUGtDYS9nTjU4WVZWdXF3cUJYYkRsd09XMlpPTjkrUUduMWpQNmRiRHJk?=
 =?utf-8?B?NkdVemp1bzdRQ0JKczBTVGNhcnAyY0lFTGNpWFdZcklHMDVzT2Y2YThEK1JB?=
 =?utf-8?Q?VLgwjTL2q6QmOyZzNafOyYw2ZM3qnBW1rBjSoD2tf1kr?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc86ae7-fb5d-4514-6e9b-08daa77ce4ab
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 09:26:48.1663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43wUqYfLlGSBpkD3mxsfbCcLDqkbP7kUNY0C8Lwc0Q3tVVbzUPFxBrjKgDmEM/NDG6lk1emYrrkjZVRzPUKXaMfQnkaq9ni7yusHn2vbuZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3855
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.10.22 um 05:32 schrieb mikhail.kshevetskiy@iopsys.eu:
> 
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
> but current driver uses only first 2 bytes of it for devices
> idenfification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
> is identified as W25N01GV (id_bytes: EF, AA, 21).
> 
> Fix this and add W25N02KV flash support.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Thanks for the patch. We have a similar change in our downstream kernel,
that I failed to push upstream so far. But your version looks even better.

Can you change the subject prefix to "mtd: spinand: winbond:", please?

And I also would like to ask you to split this into two patches. The
first one to add the third byte in the ids of the existing devices and
the second one to add support for the new device.

With these two changes you can add:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
