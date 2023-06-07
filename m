Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971EB7268C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFGScv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjFGSco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:32:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A871BD5;
        Wed,  7 Jun 2023 11:32:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpm4THo/1v3dRksXFWC7b/04yvuxtaX5KjDWhJUv0DJNPGt0i4b78UKmx+voo0TFraLzTD6YOcZIephsAxp7JBg3e4B2DD8CZykJIM71m8bMobGfQuW0rSdIFUPZBTiTTHpiXi7P+m5coue/aAt0avjuqde7dZbbqiFnQID2gayQzS0WJBV3WFRzUezs8iSkAc8DXt3rc41oK+KN9Q1bkV9qHhxQZMqtB24EbXf5RnFMiuT5owTIngIeL6i63t0WYc7fmT5c3onzaelu6ibkuGxSbf+p4HQQRQT0nicx99LoG3XpzNcX6FyQ6XUcaKHoOXeOuHbVkwVafuHmeURaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alMnBBsTlFoyhBRTux1P1yhcT5ujpOaHWwkqbk74UdY=;
 b=AdnhrwxWjasmZ/3SkdAd3DcMTHsT/7nV4z9Si2eSUtT6OmZTV3T/GUj8Xb04UA2l/s+CcWc5Qo4BVje6x9hKWpDi77NUALgbJKPCkK9JK2dx3BiMtyEl3O/Qgo9gJ2x/8iJSgvpj2CYCmEk7rTCFPkf6S1W2A1F59RS99uZiHvNsLe+TL+bV6SSko32mN6WlmCjp3MzDXvBCnqPbEtTsML5rTE7gf8pg/7xqhRGTaKCIEraOwTn0il2aUizlIkT9+P2IbkUK+VlNUIrMIKBHWse17NpSB7D91Tfxt6JjEgtjoTPcXdIkip1A9qZg+jWQE1JX01tWyCDUEHiw2XaoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alMnBBsTlFoyhBRTux1P1yhcT5ujpOaHWwkqbk74UdY=;
 b=gENZy5Z7h/K33fLFmXYWOVRsyHTrDo7JfqFBjAnxhzlRFhsDT8mqY0uz0omoC+KwoqFFbsMJH8fmZAc5WbmJLJx1Tel1ijyJbVM75p4jX/5Mx5RSNTWs1906soZW3cHp3hrKHJ0tFHKVQoMAbdE3ER/6loN0OqJr4v1hPb8yfp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 18:32:26 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6433.022; Wed, 7 Jun 2023
 18:32:26 +0000
Message-ID: <bd083d8d-023a-698e-701b-725f1b15766e@amd.com>
Date:   Thu, 8 Jun 2023 00:02:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601144706.GA559454@hirez.programming.kicks-ass.net>
 <7bee9860-2d2a-067b-adea-04012516095c@amd.com>
 <20230602065438.GB620383@hirez.programming.kicks-ass.net>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230602065438.GB620383@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: acd8f622-66be-4573-9686-08db67858af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqzKXzxw1QN7q31aRdMLQCbmO8ucmlTorZagWs2vjASwqkPciHxwoNmIb3XOmjlkLK8HtBDWitfKIT9cK396bzH446sk4AbkK6Zh7z3SF/RzSoCZEl00Gaopuh7Z3PqnizDAa6JiBG1LL1Eyg9MnxNXiZGivbcq/bA677mII641G91JJJZhQ/J5/t4Rd8J5a/b7wXXCJcRHIt7VcL+FsbRrw6VicclGd55RzyXelCvp56M6SJXJdGW4NrkbCs8uf8DjnmJprRKSJWwg1gpR5HSL00lZLxToJgvYQup+5JAGsooVjIXYg3v8NNMQHenVz1/zJCrPVqYi0sfznDC2u515vs3g/e5o16pJ+hsp4t4x0sR77RQl7xLklQhhM40hnisLNZ3XDEO3gFOQffO9dBwGHRKZjYdmYuF+KShZ9wwXWJDQO8bpbTSW16fnwHhfgwAMj24qqmWfm5GMoXiT5Ggllvmxw2QxJhNsEZFZbK/3YLKXo49jxIMFv/W3YEPTnpFUBYzZa71oKMdf0BOB1JYgseJL9YkEDWLtT7VhAdzE7AgUwMabgxH5lDrb0Y2c8ysKww79pDyymyJhGbRsJssZW+SLi95A/HrAFLIOkmborTU8CKVOHMd6byu2bnOMmbMIugZ+StqbVGTE4wgrOrrFSxHUD1tSKz+BwBkRSWN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(6486002)(6666004)(53546011)(26005)(6506007)(6512007)(2616005)(83380400001)(186003)(36756003)(316002)(86362001)(54906003)(31696002)(66946007)(66556008)(66476007)(4326008)(6916009)(5660300002)(8676002)(31686004)(8936002)(66899021)(30864003)(2906002)(41300700001)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk91YlpnTDMyaCtWYVVTeURPY2RvTHBxZi9GQzFuUnFmQTlaWExHSHV4Qmdq?=
 =?utf-8?B?Z1hoemtGNS9zUUl6b3lSMVVWME5YNjMyaUtBc1FkSStiMi9XOU1uTGhXMHhs?=
 =?utf-8?B?M1IzOHRIVGFWcmFZVHZ1RjhUek1Zam5ISHY4eC9BK3hOdFEyWUR5aDJMZ1V3?=
 =?utf-8?B?bm5Wc2ZPaFNmOGVOMXpKRU44NTAyRFk5cklDYTB5QjVBaks4TUVDdklCeDdr?=
 =?utf-8?B?aDFzOXZSMHVOUlh0UUg4SkVUck53SGNKeUMxNDhMd3ozM3NIbDZIdm1Jckdz?=
 =?utf-8?B?T0FmMFhSWE9aSFpEaHpMaUtvYlJxN3pabmYvL1pXWWFYUmZ3ZkJNZFhhSE1H?=
 =?utf-8?B?SWN0Wmxwb1BTZmx5QTROdzR1T3g5VUp6MXlqdmtJbTYrZnhUb2JMUFlqcUNJ?=
 =?utf-8?B?WTMvS3paNEd1bWlzZ3ZZaEk4TUZKRTRuemtCUnRBSlNIYkptemhJd25iTE9C?=
 =?utf-8?B?cFpZY0lBcUJhT0lkSWxDNjdBOEVtdGxoR0NYRWNEYjZobC9wK2hUQlAvM01T?=
 =?utf-8?B?clZwblBjOXFwdUtIOUxqZU8wRDgwZVZ1Z2pucVVMTU5NckdaT1pEZ0tEOFgv?=
 =?utf-8?B?RVB4NzVFNkh5T3YwVHRJdmZ2YzZDZlppMktLcjVWK0o2Y0w2TE9uaHhobXhP?=
 =?utf-8?B?ZHl2VU9ZbnRFa3B4S2V3R2ZaNE03WU8xVFl2NzdrMW0rT1FVM3BDSVJiNXdK?=
 =?utf-8?B?eG9OakFnM2RJZVlyTld2NHlyU0grNVE3VXlUMFU4ZWJoa0VkUGZQQ1ZXd3JR?=
 =?utf-8?B?UlJOWWg0THRFMTRJSjVFcHlzNVRDVmlJT1FHQW1zckZVL1VseU5oSkZTZm00?=
 =?utf-8?B?VGI5SkY0VmFUZ3phaDVHVXpFVVhtU085d200czBPMzI3YkZhR1BzSFJKQUxY?=
 =?utf-8?B?dUx3T1hMQWZGRG1wb2NET1BkVXhsdFZOT0k2ejBiODVRVnQ0UlBXVnZUcnJ5?=
 =?utf-8?B?VE04ZnNNMTVkMFE3VHJ6RjdNOFlGTnVBUGJFSTlyck5lNStiRG9mN2xET1JM?=
 =?utf-8?B?N29lQVFUYWVnWTVCMlU4MWx4eStIOUNyd0VMMW5mK3NwNm5rekNwWUh0ZDlZ?=
 =?utf-8?B?ODlNdW5iNVlrZm56NnBBQTdCS3VwZnpGeHBIUmNqeWQ4aXFjNmVTeXRkY2xx?=
 =?utf-8?B?b0xPcVpKdXRURXZtSTlHS042K0l0bS9XS2ZLL1pNQnVmU2NTejl4OGR1Uk4x?=
 =?utf-8?B?NjNsUnVEaXBhZzJxYjVoZnozcm5JQUNZRHBXYi9YU2NpR2E1YWU0ek5YV3Bv?=
 =?utf-8?B?Uk53aU1BNHRsOEVTTGN5b2QzRDc0WFBJL01WZXZ3QnZoV21rNFg2NXBkTjJL?=
 =?utf-8?B?aVJyM3JkNzBlMU1IQW9IQ2MraDZLNXMwdFpiQWFLMjYwcm1KTnJGQjBDRExH?=
 =?utf-8?B?RjR2L3FoWnF3Z01nMHkwbmtNVG9nY3BidkJ0aFdvRUxSelVnSlBVMlcvMnNq?=
 =?utf-8?B?VnRmTnlvQUZOanBkODdmWTNlY3F6VGMvTTh4Q0hVS2lYenJ6eWU5KytGR0R3?=
 =?utf-8?B?RWs1YkpkQXFzMy9wOUx5V0t2cWFwTWNPd0VoSVZlTGxxb0J4cmRKaEVWTjZ1?=
 =?utf-8?B?UHBSQjdSM21yREM0UnhCNzFOZisrTXJnTFdSSlF3cnJTc3dQMk1GWFpHcVd0?=
 =?utf-8?B?OVpIMXNHcGZYdkRSWVhjd2xqOHB3NXREbFRJZVBSU0FDdHIrSlpUazJNN0dW?=
 =?utf-8?B?N3FDMjZpQUVPcWhLOHphdW1WVUJKQWdnZEVwRXlZT3ZnTHVHYkhaRUR5REp0?=
 =?utf-8?B?Q2N0SHpkbEdkWElEMyswTkRiRXVtSm1sci90d3kzYnU3VkdoRXB2UnpTbjJV?=
 =?utf-8?B?Z05FZEJPMzNwU05CUG5LTjlNc0c4eWRpRDVZMFh1Z0g2dHFVcWxOWUYxdTJN?=
 =?utf-8?B?RWhsZ2QrMTlJeDJGTmFXN2hVMWRmVmJpT0pYajBVdVVnaFlJRGcvVzA0RWMy?=
 =?utf-8?B?a2VDQUZSMnV5eWpOVVI1dElPREkza0lCMmJva3JNN0VJc3djYXVQdWNvSnBK?=
 =?utf-8?B?RGZNcTUwNlQrdDF3Z1p0b0w5MlE1dGhQcTV1V2F5bEpJa2lFV2h3SXRscnl1?=
 =?utf-8?B?RlBjM20vbWlsWUYvUzdRUG5OY2VSbjZBY0dTWHlpZm5vdEdUVGZSNFg4akdu?=
 =?utf-8?Q?2hvXjuuHYVCzXjFPH2/Fgm1IW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd8f622-66be-4573-9686-08db67858af4
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 18:32:26.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4a7XzltU3lkehPn09gaSkWxoRb6UQCsVAd4XqEVdmvpWO72VSNypAvbQNkiewjEKJDfQjWeqx8lHiIvHw2uZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Below are the benchmark results on different NPS modes for SIS_NODE
and SIS_NODE + additional suggested changes. None of them give a
total win. Limit helps but there are cases where it still leads to
regression. I'll leave full details below.

On 6/2/2023 12:24 PM, Peter Zijlstra wrote:
> On Fri, Jun 02, 2023 at 10:43:37AM +0530, K Prateek Nayak wrote:
>> Grouping near-CCX for the offerings that do not have 2CCX per CCD will
>> prevent degenration and limit the search scope yes. Here is what I'll
>> do, let me check if limiting search scope helps first, and then start
>> fiddling with the topology. How does that sound?
> 
> So my preference would be the topology based solution, since the search
> limit is random magic numbers that happen to work for 'your' machine but
> who knows what it'll do for some other poor architecture that happens to
> trip this.
> 
> That said; verifying the limit helps at all is of course a good start,
> because if it doesn't then the topology thing will likely also not help
> much.

o NPS Modes

NPS Modes are used to logically divide single socket into
multiple NUMA region.
Following is the NUMA configuration for each NPS mode on the system:

NPS1: Each socket is a NUMA node.
    Total 2 NUMA nodes in the dual socket machine.

    Node 0: 0-63,   128-191
    Node 1: 64-127, 192-255

    - 8CCX per node

NPS2: Each socket is further logically divided into 2 NUMA regions.
    Total 4 NUMA nodes exist over 2 socket.
   
    Node 0: 0-31,   128-159
    Node 1: 32-63,  160-191
    Node 2: 64-95,  192-223
    Node 3: 96-127, 223-255

    - 4 CCX per node

NPS4: Each socket is logically divided into 4 NUMA regions.
    Total 8 NUMA nodes exist over 2 socket.
   
    Node 0: 0-15,    128-143
    Node 1: 16-31,   144-159
    Node 2: 32-47,   160-175
    Node 3: 48-63,   176-191
    Node 4: 64-79,   192-207
    Node 5: 80-95,   208-223
    Node 6: 96-111,  223-231
    Node 7: 112-127, 232-255

    - 2 CCX per node

  Note:

  - Ideally in NPS2 and NPS4 modes SIS_NODE and SIS_NODE_LIMIT should
    behave similarly.

  - Ideally in NPS4 mode SIS_NODE and SIS_NODE_TOPOEXT should behave
    similarly.

o Kernel Versions

- tip              - tip:sched/core at commit e2a1f85bf9f5 "sched/psi:
                     Avoid resetting the min update period when it is
                     unnecessary")

- SIS_NODE         - tip:sched/core + this patch

- SIS_NODE_LIMIT   - tip:sched/core + this patch + nr=4 limit for SIS_NODE
		     (https://lore.kernel.org/all/20230601111326.GV4253@hirez.programming.kicks-ass.net/)

- SIS_NODE_TOPOEXT - tip:sched/core + this patch
                     + new sched domain (Multi-Multi-Core or MMC)
		     (https://lore.kernel.org/all/20230601153522.GB559993@hirez.programming.kicks-ass.net/)
		     MMC domain groups 2 nearby CCX.

o Benchmark Results

Note: All benchmarks were run with boost enabled and C2 disabled.

~~~~~~~~~~~~~
~ hackbench ~
~~~~~~~~~~~~~

o NPS1

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 1-groups:         3.92 (0.00 pct)         4.05 (-3.31 pct)        3.78 (3.57 pct)         3.77 (3.82 pct)
 2-groups:         4.58 (0.00 pct)         3.84 (16.15 pct)        4.50 (1.74 pct)         4.34 (5.24 pct)
 4-groups:         4.99 (0.00 pct)         3.98 (20.24 pct)        4.93 (1.20 pct)         5.01 (-0.40 pct)
 8-groups:         5.67 (0.00 pct)         6.05 (-6.70 pct)        5.73 (-1.05 pct)        5.95 (-4.93 pct)
16-groups:         7.88 (0.00 pct)        10.56 (-34.01 pct)       7.83 (0.63 pct)         8.04 (-2.03 pct)

o NPS2

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 1-groups:         3.82 (0.00 pct)         3.68 (3.66 pct)         3.87 (-1.30 pct)        3.74 (2.09 pct)
 2-groups:         4.40 (0.00 pct)         3.61 (17.95 pct)        4.45 (-1.13 pct)        4.30 (2.27 pct)
 4-groups:         4.84 (0.00 pct)         3.62 (25.20 pct)        4.84 (0.00 pct)         4.97 (-2.68 pct)
 8-groups:         5.45 (0.00 pct)         6.14 (-12.66 pct)       5.40 (0.91 pct)         5.68 (-4.22 pct)
16-groups:         6.94 (0.00 pct)         8.77 (-26.36 pct)       6.57 (5.33 pct)         7.87 (-13.40 pct)

o NPS4

Test:                   tip                     SIS_NODE           SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 1-groups:         3.82 (0.00 pct)         3.84 (-0.52 pct)        3.83 (-0.26 pct)        3.85 (-0.78 pct)
 2-groups:         4.44 (0.00 pct)         4.15 (6.53 pct)         4.43 (0.22 pct)         4.18 (5.85 pct)
 4-groups:         4.86 (0.00 pct)         4.95 (-1.85 pct)        4.88 (-0.41 pct)        4.79 (1.44 pct)
 8-groups:         5.42 (0.00 pct)         5.80 (-7.01 pct)        5.41 (0.18 pct)         5.75 (-6.08 pct)
16-groups:         6.68 (0.00 pct)         9.07 (-35.77 pct)       6.72 (-0.59 pct)        8.66 (-29.64 pct)


~~~~~~~~~~~~~~~~~~
~ schbench (Old) ~
~~~~~~~~~~~~~~~~~~

o NPS1

#workers:   tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:      26.00 (0.00 pct)        24.00 (7.69 pct)        26.00 (0.00 pct)        20.00 (23.07 pct)
2:      27.00 (0.00 pct)        24.00 (11.11 pct)       25.00 (7.40 pct)        26.00 (3.70 pct)
4:      31.00 (0.00 pct)        28.00 (9.67 pct)        30.00 (3.22 pct)        28.00 (9.67 pct)
8:      36.00 (0.00 pct)        33.00 (8.33 pct)        34.00 (5.55 pct)        34.00 (5.55 pct)
16:      49.00 (0.00 pct)        47.00 (4.08 pct)        50.00 (-2.04 pct)       50.00 (-2.04 pct)
32:      80.00 (0.00 pct)        81.00 (-1.25 pct)       80.00 (0.00 pct)        81.00 (-1.25 pct)
64:     169.00 (0.00 pct)       169.00 (0.00 pct)       177.00 (-4.73 pct)      177.00 (-4.73 pct)
128:     343.00 (0.00 pct)       365.00 (-6.41 pct)      341.00 (0.58 pct)       336.00 (2.04 pct)
256:     42048.00 (0.00 pct)     35392.00 (15.82 pct)    45888.00 (-9.13 pct)    48576.00 (-15.52 pct)
512:     95104.00 (0.00 pct)     88704.00 (6.72 pct)     92032.00 (3.23 pct)     89984.00 (5.38 pct)

o NPS2

#workers:   tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:      23.00 (0.00 pct)        24.00 (-4.34 pct)       25.00 (-8.69 pct)       21.00 (8.69 pct)
2:      24.00 (0.00 pct)        24.00 (0.00 pct)        27.00 (-12.50 pct)      28.00 (-16.66 pct)
4:      31.00 (0.00 pct)        26.00 (16.12 pct)       26.00 (16.12 pct)       29.00 (6.45 pct)
8:      41.00 (0.00 pct)        38.00 (7.31 pct)        40.00 (2.43 pct)        38.00 (7.31 pct)
16:      48.00 (0.00 pct)        49.00 (-2.08 pct)       51.00 (-6.25 pct)       53.00 (-10.41 pct)
32:      81.00 (0.00 pct)        84.00 (-3.70 pct)       81.00 (0.00 pct)        86.00 (-6.17 pct)
64:     157.00 (0.00 pct)       169.00 (-7.64 pct)      171.00 (-8.91 pct)      172.00 (-9.55 pct)
128:     386.00 (0.00 pct)       400.00 (-3.62 pct)      436.00 (-12.95 pct)     384.00 (0.51 pct)
256:     48832.00 (0.00 pct)     44480.00 (8.91 pct)     48704.00 (0.26 pct)     48576.00 (0.52 pct)
512:     92032.00 (0.00 pct)     89472.00 (2.78 pct)     91776.00 (0.27 pct)     91008.00 (1.11 pct)

o NPS4

#workers:   tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1:      21.00 (0.00 pct)        24.00 (-14.28 pct)      17.00 (19.04 pct)       22.00 (-4.76 pct)
2:      28.00 (0.00 pct)        24.00 (14.28 pct)       28.00 (0.00 pct)        28.00 (0.00 pct)
4:      32.00 (0.00 pct)        29.00 (9.37 pct)        28.00 (12.50 pct)       30.00 (6.25 pct)
8:      46.00 (0.00 pct)        43.00 (6.52 pct)        43.00 (6.52 pct)        42.00 (8.69 pct)
16:     51.00 (0.00 pct)        53.00 (-3.92 pct)       53.00 (-3.92 pct)       56.00 (-9.80 pct)
32:     82.00 (0.00 pct)        81.00 (1.21 pct)        83.00 (-1.21 pct)       83.00 (-1.21 pct)
64:     173.00 (0.00 pct)       172.00 (0.57 pct)       177.00 (-2.31 pct)      155.00 (10.40 pct)
128:    396.00 (0.00 pct)       384.00 (3.03 pct)       360.00 (9.09 pct)       386.00 (2.52 pct)
256:    48832.00 (0.00 pct)     46656.00 (4.45 pct)     49728.00 (-1.83 pct)    49472.00 (-1.31 pct)
512:    95104.00 (0.00 pct)     90752.00 (4.57 pct)     92544.00 (2.69 pct)     90496.00 (4.84 pct)


~~~~~~~~~~
~ tbench ~
~~~~~~~~~~

o NPS1

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
    1    452.49 (0.00 pct)       457.94 (1.20 pct)       458.13 (1.24 pct)       447.69 (-1.06 pct)
    2    862.44 (0.00 pct)       879.99 (2.03 pct)       881.19 (2.17 pct)       855.91 (-0.75 pct)
    4    1604.27 (0.00 pct)      1618.87 (0.91 pct)      1628.00 (1.47 pct)      1627.14 (1.42 pct)
    8    2966.77 (0.00 pct)      3040.90 (2.49 pct)      3037.70 (2.39 pct)      2957.91 (-0.29 pct)
   16    5176.70 (0.00 pct)      5292.29 (2.23 pct)      5445.15 (5.18 pct)      5241.61 (1.25 pct)
   32    8205.24 (0.00 pct)      8949.12 (9.06 pct)      8716.02 (6.22 pct)      8494.17 (3.52 pct)
   64    13956.71 (0.00 pct)     14461.42 (3.61 pct)     13620.04 (-2.41 pct)    15045.43 (7.80 pct)
  128    24005.50 (0.00 pct)     26052.75 (8.52 pct)     24975.03 (4.03 pct)     24008.73 (0.01 pct)
  256    32457.61 (0.00 pct)     21999.41 (-32.22 pct)   30810.93 (-5.07 pct)    31060.12 (-4.30 pct)
  512    34345.24 (0.00 pct)     41166.39 (19.86 pct)    30982.94 (-9.78 pct)    31864.14 (-7.22 pct)
 1024    33432.92 (0.00 pct)     40900.84 (22.33 pct)    30953.61 (-7.41 pct)    32006.81 (-4.26 pct)

o NPS2

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
    1    453.73 (0.00 pct)       451.63 (-0.46 pct)      455.97 (0.49 pct)       453.79 (0.01 pct)
    2    861.71 (0.00 pct)       857.85 (-0.44 pct)      868.30 (0.76 pct)       850.14 (-1.34 pct)
    4    1599.14 (0.00 pct)      1609.30 (0.63 pct)      1656.08 (3.56 pct)      1619.10 (1.24 pct)
    8    2951.03 (0.00 pct)      2944.71 (-0.21 pct)     3034.38 (2.82 pct)      2973.52 (0.76 pct)
   16    5080.32 (0.00 pct)      5160.39 (1.57 pct)      5173.32 (1.83 pct)      5150.99 (1.39 pct)
   32    7900.41 (0.00 pct)      8039.13 (1.75 pct)      8105.69 (2.59 pct)      7956.45 (0.70 pct)
   64    14629.65 (0.00 pct)     15391.08 (5.20 pct)     14546.09 (-0.57 pct)    15410.41 (5.33 pct)
  128    23155.88 (0.00 pct)     24015.45 (3.71 pct)     24263.82 (4.78 pct)     23351.35 (0.84 pct)
  256    33449.57 (0.00 pct)     33571.08 (0.36 pct)     32048.20 (-4.18 pct)    32869.85 (-1.73 pct)
  512    33757.47 (0.00 pct)     39872.69 (18.11 pct)    32945.66 (-2.40 pct)    34526.17 (2.27 pct)
 1024    34823.14 (0.00 pct)     41090.15 (17.99 pct)    32404.40 (-6.94 pct)    34522.97 (-0.86 pct)

o NPS4

Clients:      tip                     SIS_NODE             SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
    1    450.14 (0.00 pct)       454.46 (0.95 pct)       454.53 (0.97 pct)       451.43 (0.28 pct)
    2    863.26 (0.00 pct)       868.94 (0.65 pct)       891.89 (3.31 pct)       866.74 (0.40 pct)
    4    1618.71 (0.00 pct)      1599.13 (-1.20 pct)     1630.29 (0.71 pct)      1610.08 (-0.53 pct)
    8    2929.35 (0.00 pct)      3065.12 (4.63 pct)      3064.15 (4.60 pct)      3004.74 (2.57 pct)
   16    5114.04 (0.00 pct)      5261.40 (2.88 pct)      5238.04 (2.42 pct)      5108.53 (-0.10 pct)
   32    7912.18 (0.00 pct)      8926.77 (12.82 pct)     8382.51 (5.94 pct)      8214.73 (3.82 pct)
   64    14424.72 (0.00 pct)     14853.61 (2.97 pct)     14273.54 (-1.04 pct)    14430.17 (0.03 pct)
  128    23614.97 (0.00 pct)     24506.73 (3.77 pct)     24517.76 (3.82 pct)     23296.38 (-1.34 pct)
  256    34365.13 (0.00 pct)     35538.42 (3.41 pct)     31909.66 (-7.14 pct)    31009.12 (-9.76 pct)
  512    34215.50 (0.00 pct)     36017.49 (5.26 pct)     32696.70 (-4.43 pct)    33262.55 (-2.78 pct)
 1024    35421.90 (0.00 pct)     35193.81 (-0.64 pct)    32611.10 (-7.93 pct)    32795.86 (-7.41 pct)


~~~~~~~~~~
~ stream ~
~~~~~~~~~~

- 10 Runs

o NPS1

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   271317.35 (0.00 pct)    292440.22 (7.78 pct)    302540.26 (11.50 pct)   287277.25 (5.88 pct)
Scale:   205533.77 (0.00 pct)    203362.60 (-1.05 pct)   207750.30 (1.07 pct)    205206.26 (-0.15 pct)
  Add:   221624.62 (0.00 pct)    225850.83 (1.90 pct)    233782.14 (5.48 pct)    229774.48 (3.67 pct)
Triad:   228500.68 (0.00 pct)    225885.25 (-1.14 pct)   238331.69 (4.30 pct)    240041.53 (5.05 pct)

o NPS2

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   277761.29 (0.00 pct)    301816.34 (8.66 pct)    293563.58 (5.68 pct)    308218.80 (10.96 pct)
Scale:   215193.83 (0.00 pct)    212522.72 (-1.24 pct)   215758.66 (0.26 pct)    205678.94 (-4.42 pct)
  Add:   242725.75 (0.00 pct)    242695.13 (-0.01 pct)   246472.20 (1.54 pct)    238089.46 (-1.91 pct)
Triad:   237253.44 (0.00 pct)    250618.57 (5.63 pct)    239405.55 (0.90 pct)    249652.73 (5.22 pct)

o NPS4

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   273307.14 (0.00 pct)    255091.78 (-6.66 pct)   301926.68 (10.47 pct)   262007.26 (-4.13 pct)
Scale:   235715.23 (0.00 pct)    222018.36 (-5.81 pct)   224881.52 (-4.59 pct)   222282.64 (-5.69 pct)
  Add:   244500.40 (0.00 pct)    230468.21 (-5.73 pct)   242625.18 (-0.76 pct)   227146.80 (-7.09 pct)
Triad:   250600.04 (0.00 pct)    236229.50 (-5.73 pct)   258064.49 (2.97 pct)    231772.02 (-7.51 pct)

- 100 Runs

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   317381.65 (0.00 pct)    318827.08 (0.45 pct)    320898.32 (1.10 pct)    318922.96 (0.48 pct)
Scale:   214145.00 (0.00 pct)    206213.69 (-3.70 pct)   211019.12 (-1.45 pct)   210384.47 (-1.75 pct)
  Add:   239243.29 (0.00 pct)    229791.67 (-3.95 pct)   233827.11 (-2.26 pct)   236659.48 (-1.07 pct)
Triad:   249477.76 (0.00 pct)    236843.06 (-5.06 pct)   244688.91 (-1.91 pct)   235990.67 (-5.40 pct)

o NPS2

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   318082.10 (0.00 pct)    322844.91 (1.49 pct)    310350.21 (-2.43 pct)   322495.84 (1.38 pct)
Scale:   219338.56 (0.00 pct)    218139.90 (-0.54 pct)   212288.47 (-3.21 pct)   221040.27 (0.77 pct)
  Add:   248118.20 (0.00 pct)    249826.98 (0.68 pct)    239682.55 (-3.39 pct)   253006.79 (1.97 pct)
Triad:   247088.55 (0.00 pct)    260488.38 (5.42 pct)    247892.42 (0.32 pct)    249081.33 (0.80 pct)

o NPS4

Test:         tip                     SIS_NODE             SIS_NODE_LIMIT          SIS_NODE_TOPOEXT
 Copy:   345396.19 (0.00 pct)    343675.74 (-0.49 pct)   346990.96 (0.46 pct)    334677.55 (-3.10 pct)
Scale:   241521.63 (0.00 pct)    231494.70 (-4.15 pct)   236233.18 (-2.18 pct)   229159.01 (-5.11 pct)
  Add:   261157.86 (0.00 pct)    249663.86 (-4.40 pct)   253402.85 (-2.96 pct)   242257.98 (-7.23 pct)
Triad:   267804.99 (0.00 pct)    263071.00 (-1.76 pct)   264208.15 (-1.34 pct)   256978.50 (-4.04 pct)

~~~~~~~~~~~
~ netperf ~
~~~~~~~~~~~

o NPS1

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1-clients:       102839.97 (0.00 pct)    103540.33 (0.68 pct)    103769.74 (0.90 pct)    103271.77 (0.41 pct)
2-clients:       98428.08 (0.00 pct)     100431.67 (2.03 pct)    100555.62 (2.16 pct)    100417.11 (2.02 pct)
4-clients:       92298.45 (0.00 pct)     94800.51 (2.71 pct)     93706.09 (1.52 pct)     94981.10 (2.90 pct)
8-clients:       85618.41 (0.00 pct)     89130.14 (4.10 pct)     87677.84 (2.40 pct)     88284.61 (3.11 pct)
16-clients:      78722.18 (0.00 pct)     79715.38 (1.26 pct)     80488.76 (2.24 pct)     78980.88 (0.32 pct)
32-clients:      73610.75 (0.00 pct)     72801.41 (-1.09 pct)    72167.43 (-1.96 pct)    75077.55 (1.99 pct)
64-clients:      55285.07 (0.00 pct)     56184.38 (1.62 pct)     56443.79 (2.09 pct)     60689.05 (9.77 pct)
128-clients:     31176.92 (0.00 pct)     32830.06 (5.30 pct)     35511.93 (13.90 pct)    35638.50 (14.31 pct)
256-clients:     20011.44 (0.00 pct)     15135.39 (-24.36 pct)   17599.21 (-12.05 pct)   18219.29 (-8.95 pct)

o NPS2

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1-clients:       103105.55 (0.00 pct)    101582.75 (-1.47 pct)   103077.22 (-0.02 pct)   102233.63 (-0.84 pct)
2-clients:       98720.29 (0.00 pct)     98537.46 (-0.18 pct)    100761.54 (2.06 pct)    99211.39 (0.49 pct)
4-clients:       92289.39 (0.00 pct)     94332.45 (2.21 pct)     93622.46 (1.44 pct)     93321.77 (1.11 pct)
8-clients:       84998.63 (0.00 pct)     87180.90 (2.56 pct)     86970.84 (2.32 pct)     86076.75 (1.26 pct)
16-clients:      76395.81 (0.00 pct)     80017.06 (4.74 pct)     77937.29 (2.01 pct)     75090.85 (-1.70 pct)
32-clients:      71110.89 (0.00 pct)     69445.86 (-2.34 pct)    69273.81 (-2.58 pct)    66885.99 (-5.94 pct)
64-clients:      49526.21 (0.00 pct)     50004.13 (0.96 pct)     51649.09 (4.28 pct)     51100.52 (3.17 pct)
128-clients:     27917.51 (0.00 pct)     30581.70 (9.54 pct)     31587.40 (13.14 pct)    33477.65 (19.91 pct)
256-clients:     20067.17 (0.00 pct)     26002.42 (29.57 pct)    18681.28 (-6.90 pct)    18144.96 (-9.57 pct)

o NPS4

                        tip                  SIS_NODE              SIS_NODE_LIMIT         SIS_NODE_TOPOEXT
1-clients:       102139.49 (0.00 pct)    103578.02 (1.40 pct)    103633.90 (1.46 pct)    101656.07 (-0.47 pct)
2-clients:       98259.53 (0.00 pct)     99336.70 (1.09 pct)     99720.37 (1.48 pct)     98812.86 (0.56 pct)
4-clients:       91576.79 (0.00 pct)     95278.30 (4.04 pct)     93688.37 (2.30 pct)     93848.94 (2.48 pct)
8-clients:       84742.30 (0.00 pct)     89005.65 (5.03 pct)     87703.04 (3.49 pct)     86709.29 (2.32 pct)
16-clients:      79540.75 (0.00 pct)     85478.97 (7.46 pct)     83195.92 (4.59 pct)     81016.24 (1.85 pct)
32-clients:      71166.14 (0.00 pct)     74254.01 (4.33 pct)     72422.76 (1.76 pct)     71391.62 (0.31 pct)
64-clients:      51763.24 (0.00 pct)     52565.56 (1.54 pct)     55159.65 (6.56 pct)     52472.91 (1.37 pct)
128-clients:     27829.29 (0.00 pct)     35774.61 (28.55 pct)    33738.97 (21.23 pct)    34564.10 (24.20 pct)
256-clients:     24185.37 (0.00 pct)     27215.35 (12.52 pct)    17675.87 (-26.91 pct)   24937.66 (3.11 pct)


~~~~~~~~~~~~~~~~
~ ycsb-mongodb ~
~~~~~~~~~~~~~~~~

o NPS1

tip:			131070.33 (var: 2.84%)
SIS_NODE:		131070.33 (var: 2.84%) (0.00%)
SIS_NODE_LIMIT:		137227.00 (var: 4.97%) (4.69%)
SIS_NODE_TOPOEXT:	133529.67 (var: 0.98%) (1.87%)

o NPS2

tip:			133693.67 (var: 1.69%)
SIS_NODE:		134173.00 (var: 4.07%) (0.35%)
SIS_NODE_LIMIT:		134124.67 (var: 2.20%) (0.32%)
SIS_NODE_TOPOEXT:	133747.33 (var: 2.49%) (0.04%)

o NPS4

tip:			132913.67 (var: 1.97%)
SIS_NODE:		133697.33 (var: 1.69%) (0.58%)
SIS_NODE_LIMIT:		133307.33 (var: 1.03%) (0.29%)
SIS_NODE_TOPOEXT:	133426.67 (var: 3.60%) (0.38%)

~~~~~~~~~~~~~
~ unixbench ~
~~~~~~~~~~~~~

o NPS1

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1   	  41322625.19 (   0.00%)    41224388.33 (  -0.24%)    41142898.66 (  -0.43%)    41222168.97 (  -0.24%)
Hmean     unixbench-dhry2reg-512	6252491108.60 (   0.00%)  6240160851.68 (  -0.20%)  6262714194.10 (   0.16%)  6259553403.67 (   0.11%)
Amean     unixbench-syscall-1    	   2501398.27 (   0.00%)    2577323.43 *  -3.04%*      2498697.20 (   0.11%)     2541279.77 *  -1.59%*
Amean     unixbench-syscall-512  	   8120524.00 (   0.00%)    7512955.87 *   7.48%*      7447849.67 *   8.28%*     7477129.17 *   7.92%*
Hmean     unixbench-pipe-1    		   2359346.02 (   0.00%)    2392308.62 *   1.40%*      2407625.04 *   2.05%*     2334146.94 *  -1.07%*
Hmean     unixbench-pipe-512		 338790322.61 (   0.00%)  337711432.92 (  -0.32%)    340399941.24 (   0.48%)   339008490.26 (   0.06%)
Hmean     unixbench-spawn-1       	      4261.52 (   0.00%)       4164.90 (  -2.27%)         4929.26 *  15.67%*        5111.16 *  19.94%*
Hmean     unixbench-spawn-512    	     64328.93 (   0.00%)      62257.64 *  -3.22%*        63740.04 *  -0.92%*       63291.18 *  -1.61%*
Hmean     unixbench-execl-1       	      3677.73 (   0.00%)       3652.08 (  -0.70%)         3642.56 *  -0.96%*        3671.98 (  -0.16%)
Hmean     unixbench-execl-512    	     11984.83 (   0.00%)      13585.65 *  13.36%*        12496.80 (   4.27%)       12306.01 (   2.68%)

o NPS2

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1   	  41311787.29 (   0.00%)    41412946.27 (   0.24%)    41035150.98 (  -0.67%)    41371003.93 (   0.14%)
Hmean     unixbench-dhry2reg-512	6243873272.76 (   0.00%)  6256893083.32 (   0.21%)  6236751880.89 (  -0.11%)  6235047089.83 (  -0.14%)
Amean     unixbench-syscall-1    	   2503190.70 (   0.00%)     2576854.30 *  -2.94%*     2496464.80 *   0.27%*     2540298.77 *  -1.48%*
Amean     unixbench-syscall-512  	   8012388.13 (   0.00%)     7503196.87 *   6.36%*     7493284.60 *   6.48%*     7495117.73 *   6.46%*
Hmean     unixbench-pipe-1    		   2340486.25 (   0.00%)     2388946.63 (   2.07%)     2412344.33 *   3.07%*     2360277.30 (   0.85%)
Hmean     unixbench-pipe-512		 338965319.79 (   0.00%)   337225630.07 (  -0.51%)   339053027.04 (   0.03%)   336939353.18 *  -0.60%*
Hmean     unixbench-spawn-1      	      5241.83 (   0.00%)        5246.00 (   0.08%)        4718.45 *  -9.98%*        4967.96 *  -5.22%*
Hmean     unixbench-spawn-512    	     65799.86 (   0.00%)       64817.15 *  -1.49%*       66418.37 (   0.94%)       66820.63 *   1.55%*
Hmean     unixbench-execl-1       	      3670.65 (   0.00%)        3622.36 *  -1.32%*        3661.04 (  -0.26%)        3660.08 (  -0.29%)
Hmean     unixbench-execl-512    	     13682.00 (   0.00%)       13699.90 (   0.13%)       14103.91 (   3.08%)       12960.11 (  -5.28%)

o NPS4

kernel                        			tip                  SIS_NODE               SIS_NODE_LIMIT            SIS_NODE_TOPOEXT
Hmean     unixbench-dhry2reg-1   	  41025577.99 (   0.00%)    40879469.78 (  -0.36%)    41082700.61 (   0.14%)    41260407.54 (   0.57%)
Hmean     unixbench-dhry2reg-512	6255568261.91 (   0.00%)  6258326086.80 (   0.04%)  6252223940.32 (  -0.05%)  6259088809.43 (   0.06%)
Amean     unixbench-syscall-1    	   2507165.37 (   0.00%)    2579108.77 *  -2.87%*      2488617.40 *   0.74%*     2517574.40 (  -0.42%)
Amean     unixbench-syscall-512  	   7458476.50 (   0.00%)    7502528.67 *  -0.59%*      7978379.53 *  -6.97%*     7580369.27 *  -1.63%*
Hmean     unixbench-pipe-1    		   2369301.21 (   0.00%)    2392905.29 *   1.00%*      2410432.93 *   1.74%*     2347814.20 (  -0.91%)
Hmean     unixbench-pipe-512		 340299405.72 (   0.00%)  339139980.01 *  -0.34%*    340403992.95 (   0.03%)   338708678.82 *  -0.47%*
Hmean     unixbench-spawn-1      	      5571.78 (   0.00%)       5423.03 (  -2.67%)         5462.82 (  -1.96%)        5543.08 (  -0.52%)
Hmean     unixbench-spawn-512   	     63999.96 (   0.00%)      63485.41 (  -0.80%)        64730.98 *   1.14%*       67486.34 *   5.45%*
Hmean     unixbench-execl-1       	      3587.15 (   0.00%)       3624.44 *   1.04%*         3638.74 *   1.44%*        3639.57 *   1.46%*
Hmean     unixbench-execl-512    	     14184.17 (   0.00%)      13784.17 (  -2.82%)        13104.71 *  -7.61%*       13598.22 (  -4.13%)

~~~~~~~~~~~~~~~~~~
~ DeathStarBench ~
~~~~~~~~~~~~~~~~~~

o NPS1
CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%      0.30%  		 	0.83%  		 	0.79%
1	1		0%      0.17%  		 	2.53%  		 	0.91%
1	1		0%      -0.40% 		 	2.90%  		 	1.61%
1	1		0%      -7.95% 		 	1.19%  		 	-1.56%

o NPS2

CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%      0.34%  		 	-0.73% 		 	-0.62%
1	1		0%      -0.02% 		 	0.14%  		 	-1.15%
1	1		0%      -12.34%		 	-9.64% 		 	-7.80%
1	1		0%      -12.41%		 	-1.03% 		 	-9.85%

Note: In NPS2, 8 CCD case shows 10% run to run variation.

o NPS4

CCD	Scaling	       tip    SIS_NODE 		SIS_NODE_LIMIT 		SIS_NODE_TOPOEXT
1	1		0%      -1.32% 		 	-0.71% 		 	-1.09%
1	1		0%      -1.53% 		 	-1.11% 		 	-1.73%
1	1		0%      7.19%  		 	-3.47% 		 	5.75%
1	1		0%      -4.66% 		 	-1.91% 		 	-7.52%

--
If you would like me to collect any more information during any of the
above benchmark runs, please let me know.

--
Thanks and Regards,
Prateek
