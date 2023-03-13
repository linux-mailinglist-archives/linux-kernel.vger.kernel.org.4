Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7271D6B7A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCMOjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCMOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:38:58 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2129.outbound.protection.outlook.com [40.107.20.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504E4AFD0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ax8l4Ef9ucTlnVyzkCXFpsCb47tKwlLud9hzWfkTvg47HFbUF4LZZ42D4ETnuOYLtqkujuc/FXY2CnbiaTiYUPbCBP/wPDGyzJdCorNVpRuHzlISmnJPIpVLfbsYke4GDYfHbH/Xu4auFSdAX4xhPPGUg1HUpsOTKiCcur1zYlEdps27DWdAKSN8Xa2lM0Ilut7OteNYADBNkg7zJuMFJJ3gTKtH8y/mVkRIwIioQA5pH60DDcqiA6GKLoO9jDVpg19o02cbyfQTiTS4ChfwZrjopxBxaOer/8m7g272Lkw1uyERr1/ncwUzzprgNKeB44dclqNcy4kuTrd19y0LPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDBzF1BcYLFlXGPlRaUB6s6o6JJqSjXg5Px1SkuN1gU=;
 b=VoEzkxXPZ1drGcTCko4QaS0P2Yuh9mxKw19AVD9ngvsJMJnFyQaboTk38uKlAIn8lm4NhzpLkLnlBHNo9NMHSkPDPTsj6ARuDe156oKvqU9UUqs8eNFJzqrUxtko43AR4TPXzYM54gzocjjS2OX6ukTdcjhR0VX4+9Gd9keeraRByvWL/CVJFlg29dU1SDNpDE7zJimjn9e1UfNudwbKV6cjquw/If4pT1Zc6K2PHcPE31A3UdvO8FF024eic+AUrKabkYfjLeHsWrVN/+M/9+ZYw5UHd/qC/yfjvjQ5B59I6QPw69m1xulTrN9BieSdxdcP6UB75y8vM8ITNKkcdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDBzF1BcYLFlXGPlRaUB6s6o6JJqSjXg5Px1SkuN1gU=;
 b=jSFyYOcZAkIfsno2Re1b3z2ReoOhEH97ZLwHxMPbiwgXE4Hvq2z1q+tzFcGo4lFapfdx7MJ68zufOvZckPEL9ZeKW8Vbb5Q57aRl6qUBW8yGE37Ue3huwcyJV9vLweJWRICLFNSqQJlG68M47rTaJM6sgt2kCRDPLNHnK77WK4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB5233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 14:38:54 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 14:38:54 +0000
Message-ID: <7e44e0e2-b67c-96b4-3e8d-036650180201@kontron.de>
Date:   Mon, 13 Mar 2023 15:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] regulator: pca9450: Fix BUCK2 enable_mask
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230310092857.3555187-1-alexander.stein@ew.tq-group.com>
 <b7e39919-a94f-3929-8814-ada801365dfe@kontron.de>
 <1848012.tdWV9SEqCh@steina-w>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <1848012.tdWV9SEqCh@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5211a3f5-6470-4054-30ca-08db23d0ab7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1sbg2l5P2I3OvkGotd/lgQQxLmswyiKF5UrakH1J4iqa1wxiZiTnOYAfdIjlGeT1QjISNHNUWb46ePF/h453G8+QNEhB7wQYkKwmTzYMcKLsX8T9aziid0HG8YB5jHNMppJEz3+7EWqy2ETV+zayh5zxQuQ8uORj5JxRwhqaXDbnlMwa/VTKzmykd8XblNZgH2KyQE7o9DmQGhnN0aruLewsydfeHUkhlSGNks7cDwSrE2pTH5fbTYUstSEBVdNASB2jJ3KuqZiJRZ3MJwv/I0PRTq8tmt02n5CDfa0d3whFtnjJDXDbwgDrDn7lK3zxs/crIy9ASeweP05NSWDJF8nRfrVJ8sJtBpcarRJoBu/5DyREL8l8YN08HN+sBzE09MyPGQt/0R8I+iF4IZtBFu/z5HUZ+w7ztzKOubsHBKNxGYdQpqF6pFegAV4hWADlzHpU9hfon0Ltnr5I+WlcE2rB4ok+OjlmJkDenxzS0DHeMw++Y4q34FsBGmtgRzxWpqwokryscJ4aIG2pbwQNmcT651ciK985OxPY7iQUDZbcEuRb2lFUjP+f1ZEskKi0F1c56R0cGVQHjR55vr0NVkUKNE/DjaGTYrFnT7tP0CK9uTz8tQj1wIuoB//t4CP482VSxvysOuBolhKGfRB5eZsvtZmX8Ac1oholJDh6EHuKmn8wT07Vtde5dgw4HDanOkE0ehfkUJI5Y06030hz/ADqB0rQu7kpOA34RZiKMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199018)(5660300002)(44832011)(36756003)(478600001)(6512007)(53546011)(6506007)(6486002)(26005)(2616005)(66476007)(8676002)(66946007)(66556008)(186003)(4326008)(41300700001)(8936002)(86362001)(31696002)(110136005)(316002)(38100700002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhNeUJZZ3oxLzBsd25PcWkrM2p5bW0vNHVLQ1BmU0JOREtvR2RhMzUvT2g4?=
 =?utf-8?B?Q041RVZZd2tVRE5taXVTbjI4aVVOSnNmWXlIbENFK1dBZVJvSlR0UHRGcHI3?=
 =?utf-8?B?bjFlSFRtSzQ5K2FvdE45bURHMiszd1IzdlZCM0sxZ0loZFh2MHF2RHZjeHlO?=
 =?utf-8?B?OCt2WGlOQU1BM2NmMUduUHFYTm5icXpVZ1UzYUFvQkdUKzA2cVkwL3pSYmth?=
 =?utf-8?B?RU50TlYxMEsza0FEeFdpSkpkdUV3R1F1ZmJzcnR2YkV5MXZ3WG5WcmEvbTJs?=
 =?utf-8?B?c1pxalk0cFhwa3hBK0VPWGxUUG5FdXByeUsvN1QxSmlmWWs5ck43UkN5bkVX?=
 =?utf-8?B?UUh5dGxVc3ZKU3VVc1ZkcS9JUVpJbzliVnoxTHJiOGs0Z3RXQTJKTUJLSndQ?=
 =?utf-8?B?ZDBIOTkzOEk4Y0ZIZWM5TVhMTmJNVHMwNTB3V0dTTk54MDVYMklsVmczZUEw?=
 =?utf-8?B?b1RQc3Bjdy9jMDlqRktUU1VwRVRYZWRqNXBNNHhTYVFhYkRQOVRsWldaQVNu?=
 =?utf-8?B?YW9LeHErWmlSRW9xTGcxdGxBd05CNDA3aTBCOHhMT244MENJY2xsanl1WWFZ?=
 =?utf-8?B?Z3RzTVNxVUhueWlTN2R2LzhWUEd6RFZCbVlQWmRuZmtoWGhLZUVidW9LaUd2?=
 =?utf-8?B?T3NNYU8vbzR0ejVuVk5HS0lzUUJxZkhPMXJwVHJ2cC9TQ21DL0FGTStpQ1FR?=
 =?utf-8?B?cEhGRjhsWHVjbnQxa2N3TXp4SVZiVkFLUEVYcE5wYkNidWVZSFRYUm51QnAz?=
 =?utf-8?B?L2hTeURVUTExb0FkbkxqcVRSYlp2anF2SjZvT0p6UHpQb3F4UTUrWU5PTnNW?=
 =?utf-8?B?VThLZEhUYTRVUkR3LzRxd2FSRnJxUjJpNFBXamkzckw0Wk93V1piSnhhRXNI?=
 =?utf-8?B?bGYzcGVWT2o0a0lSVnpPRXdrRjAxYzNyMHEwbjVEODNMd21URUw0UHJucWFp?=
 =?utf-8?B?ZkQ4OTdTbk8xSi9wSjBEbFBRSFFPU2JUaG5NcHUvVkRNaWx1NXNJbWNqY1g2?=
 =?utf-8?B?RTd5WjBBaUdleTBJMzlhQ1ErNTkzRjJOOWhHK1AzZnZIaUNLZUU5c2d1MXox?=
 =?utf-8?B?VDhLTHpvakFlaUExVERveTU2S0V2ZllLZnRGd3FzWHU3ZHZkaTF3VzhHSnI2?=
 =?utf-8?B?RkNNc1l0djgydWQrL1A2SWFWNVMxbFY0RlQrNFcvb3J4bE1ZcEk3ZU9BcExQ?=
 =?utf-8?B?elVuUkJyZGtQV2F6dGVQT0hTdTVPd1lTckxISHVIcm8rVXRsK3p5REpkbHZT?=
 =?utf-8?B?cXRIRTVoY3JCeHVLa1dqYVpHTGZxaFdmcjVYRmlRUkRtRG10Q1VTdEcvR0ph?=
 =?utf-8?B?SGJYWkNUVmcydkF2dEFsNEhjUHc2TUl5SWpHZmRsaG5OREUwVStvK2E1aXNH?=
 =?utf-8?B?VjNsSUYvbUhGWERlYWtoN0xFMGFQUlhiQVdWOVVPVlJaRlVlTFpjRE4yTnEx?=
 =?utf-8?B?L3V2cTR2VTlLMnRkS1dEa3grZmo4M0N1aG5yVy9uWnpWTHBrbDJQOW1RNmdT?=
 =?utf-8?B?ZGludklnRDF4bWwzT1RtN1htdi9IMmFBdlhSV0pobXdBaW1qOUlMSzIzNE5Z?=
 =?utf-8?B?SzViNEoySXZ1WkxCRXpFR21NQmF2MzRqMHZ0TFpLRTlnWVloVU43YkdkdWp4?=
 =?utf-8?B?dnRrQWVsc0t0VjZtZ2x3dFZFMTMreVNpUzdxUkRCOU9mVVNOU1VLRktuM1BT?=
 =?utf-8?B?a3dTU3BneGtBbVErZGJUUS82TlJ5clBuMjVhaFI4NkYxTWxCbE1VNkU4dlRv?=
 =?utf-8?B?OERvRENnaHM2ZkdDQUQ1WHJkMXREK2lUSjRERUdISjB5cUNZbFlORkdvTEJ2?=
 =?utf-8?B?MUJySGVLS25JdmVlalZWYXhXUVZFVFpHbEt5TEYyemFBYzRxNHdkaWF1SEls?=
 =?utf-8?B?bTFlNnloVlg5T1JoK2x4aXU2MkJ1Z3ZRek9JRFlvMzNoUGg3ZndYVzdRL2xL?=
 =?utf-8?B?S1BuK3NKNVhvNzZnM2cwSzJvMEVQVllkNG5YbkY0L1BTeGg0b1Y3WDlLWGFT?=
 =?utf-8?B?REt5K3UzbWlYUlF1WlQ3QzVaVEpKSThGNzBMMjBnaHFaeVMreXdhMGcwcnR2?=
 =?utf-8?B?Qi9BYXUwUTJZQVJVM2JqT1VZbmpnV1k0M25XTDhoMEZZL2hjcnk3L0I2bWtz?=
 =?utf-8?B?Y0NJeFFjV3JyRFRWd1g1ZHpBUW5Ia2p2WGxLbjdFQ2paZnJ6YU02dEVOanl1?=
 =?utf-8?B?bXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211a3f5-6470-4054-30ca-08db23d0ab7b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 14:38:54.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcBJLshYA7pMS4RHDeF0nOC3+yrmuYgBjZQSqAqpHxfA6aaaO7g8n/LcqkWcxnPTrVtn8MrwoG/vpQUUIgA7n8Lskj4AFp7avhzqsCgguzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.23 15:21, Alexander Stein wrote:
> Hi Frieder,
> 
> thanks for your comments.
> 
> Am Montag, 13. März 2023, 14:46:08 CET schrieb Frieder Schrempf:
>> On 10.03.23 10:28, Alexander Stein wrote:
>>> This fixes a copy & paste error.
>>
>> I would mention here, that this doesn't contain any functional changes
>> as BUCK1_ENMODE_MASK is equal to BUCK2_ENMODE_MASK.
> 
> That's a good idea.
> 
>>> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
>>> Originally-from: Robin Gong <yibin.gong@nxp.com>
>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>>> ---
>>> This diff is extracted from a downstream commit authored by Robin Gong.
>>> I'm not sure if adding Originally-from: is enough here or I do have to
>>> change From: as well.
>>
>> I never heard of "Originally-from:". Does this tag exist? Is it
>> documented somewhere?
> 
> Well, it's not documented, but it pops up occasionally in some commits, e.g.
> 3fb906e7fabbb ("cgroup/cpuset: Don't filter offline CPUs in 
> cpuset_cpus_allowed() for top cpuset tasks")
> I might be something only some maintainers accept though.
> 
>> I think that your tooling (git format-patch) should add a From: tag
>> automatically if you correctly pick up a patch from someone else.
> 
> Well, it's not exactly cherry-picked, but extracted from an existing commit 
> [1], so that's maybe why my name has been put into From: while extracting.
> As the diff in this patch is not exactly the same as from the origin, I did 
> not want to put Robin Gong into Signed-off-by. And I think having an author in 
> From: but not in Signed-off-by: tag should not happen.
> Searching how I can still give credit I found Originally-from. If there is a 
> better way to handle this, I'm ready to adapt to that.

Ok, good question. I currently have a similar case somewhere else and
I'm also not really sure how to handle it properly. I don't think we are
ever allowed to add a Signed-off-by tag for someone else.
Maybe "Originally-from" is correct for this case but I never really like
to use tags that aren't generally accepted or documented somewhere.
