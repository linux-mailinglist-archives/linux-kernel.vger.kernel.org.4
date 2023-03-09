Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD2D6B1DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCIIQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCIIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:15:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE10E1FDF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:12:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXZ00oXtnOaom8GWikDu+m+L7MWDehgYnlQayEMcynwyRScmzoPGav2CTDHdwUZg3fkKOopNwrnfgCIBPfi82th+ovjlxex6+FgyBsZcCuU9oHIGggpp+IvF3m7vxAF1krIvIhkBkOVEz14C8SVU25/NC8C3+lZUJ5ZFA4j+rjtxdWMjt9HESCdGi0ZX5a676Y5HRy6DsWOTPCev8ikqyZbeno27WxluPJId0CO03G7K8yyQAhAzs+L+ticw+kYbnSPA6XOxppwa7qcOY+REXSLsGVKm37Wz7Izq0WXeCz+KIJ2nkVVk9mrNVoraeb6hu2LflWuDp3bYbnfwYjdFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVo9rV+Xg85fusE6R8HILvMjGzRqPY7BbF5kv8926UY=;
 b=QJ0igUGlbIAxDF+xjrh0U7/r5o7rH5zfOrHOJEa75u2/fsheNXVNzpQUnPGlo/u2IS2Y+QrmINlvuy71hUMtCuhFsJQ1ybr7YKghsh2VzuMEZTmad/2p/eXNWsZdpnZNygNSgoJ7u533iVbTfGjYlb0qqx+Nu01M0zzN7h/0UG9qj7SVxtBgCIIzaxaKjXsevlB7aoyretKIW0OrjaFRQ/oBSLzhOAAweWnPPPawG2GHPhV761znbJDFyDk7/jGU0lJunnT0WDKoOe7+3YN1cq422U6b+rh5PUq8dWg9+Ol7NmVl49hWIbrXFRUdKplbgcLMLLN7yb6BfYNeI8KfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVo9rV+Xg85fusE6R8HILvMjGzRqPY7BbF5kv8926UY=;
 b=vUd0KCFbyoOsH97tIr8JKQqpLvZekxm++DW4HHcri/tyVrOd/ndmD2SDjqbPTMVlr+IIRos5olYBx0OIocbzeaJvFROkkMXTHzd2rE5lj65FJVI9q7dZS19uSAD3hotdpTE4JF1FJDSSOzYUovTePwAk04HAa0XQmISXxLL/KeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 08:12:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 08:12:01 +0000
Message-ID: <d527005e-5f55-a6f7-21ce-817076860e99@amd.com>
Date:   Thu, 9 Mar 2023 09:11:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, Kirill Tkhai <tkhai@ya.ru>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
 <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
 <07078623-b7ef-ceb4-eccc-8872a4067273@bytedance.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <07078623-b7ef-ceb4-eccc-8872a4067273@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB5328:EE_
X-MS-Office365-Filtering-Correlation-Id: c474cd29-69ab-4e28-d490-08db2075f62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kgdlvysvnHSUSrCBt3URcOvDMZ5XlZSEpVmcnc+nIB4WWEr1JaubrDHApPMyTHn8Us52PfGaEKBZl8a697zU+d1QUp7f+3Q8WFfEKRXn0EH5nuXrGFujmICvcXSPTCdrj1uc34RTPKerAvxfrorEJeB7yavo4+Jr2mEqE8/6Uo3EG4TCz/2+jxEnnRWy+XIJo4pBCug1ZZ9Lirsw6P3pCem+RS6d7qI9T56ZwfEmERC5MixhqkgZBW75yKhmrSD3fL1nGcFj6bE5ca4xKiL6oKtmce1oNsTavGwkDU0adbEicJKgUk2qh7s94vppYzyvnQlAK9jD9sgqd799hFrFIIP5p+i+8y2larA+LQp3wcCqDVLN34KOt9ydNfVT8hJ+DjdBRFlYsGrnwk94zhhQpRIGo1Pwn4G95TJ11/W0wsQjeFuQCjAJTajEVxnftEhjEOyqVCU1zhy0B071pptwGJVW/4ZCwvM97tft7T++eB3DOkZa2Wv52SYG0Kn20WcE/ZAXadWAGH6GG/G+mLvUGzqorvm8hiMmayNss1mt8GabTw22yX9A1IiJccAk3xh6uVdE/gxzj0HdxcHE8YdkZB3yFYUYDTVAvZDG+BLQgAzTjxEi7zy4SbJr6hbT8Ftmq70qqdb7sF5PhoZFLTLa+Fx/AHDiJsZw6hiCg5lpKDioRlq0BFHVS7k+MUGYSzun0iM5nB+5Tn9RCWAo3yGQV/iLTqxOz/11OURZhQ1VuBRVjkhQ6MN1pGLSbQR16Pt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(66476007)(66946007)(66556008)(316002)(66574015)(41300700001)(83380400001)(8676002)(4326008)(31686004)(36756003)(110136005)(7416002)(8936002)(38100700002)(2906002)(2616005)(921005)(5660300002)(186003)(478600001)(86362001)(6666004)(31696002)(6486002)(53546011)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N20ycitxMEozZVQvKzNPQUQyM0J6MDRNc2xlVy9mOXZETXZKYVZ4ejlkK0hU?=
 =?utf-8?B?ZDRpcFhRYVZPZjIzenNNWkhEQ1drZ3JCWDVjR2V5STVSNnlKenF6c1VpS0xZ?=
 =?utf-8?B?My9Vb1FUR2FQS1RUVTdkNi9vZUN1S1ZIWlBrSit4Zm95a3RITnZZNncvK3ZJ?=
 =?utf-8?B?WGphdlpTT3J6VWlhOUlBdWhxOWNreFRCWUorVGkrQ3Q5TmhqM3hXS2VEYVNo?=
 =?utf-8?B?YXR3eHJsV1ZIZ1R5RmRyNVg2TkFONUpCM3IycmgrQzF1andKNnZva0VLVXoy?=
 =?utf-8?B?NFBNQTRhN2o0MXBWT3BTSWg2THg1ZHNTSXR5WFk1akxJZFFrdlU1Y0UzZS9a?=
 =?utf-8?B?RndrTDVtQXVFeGJMYTc5YmpLSCtsRk0wYit5M0l6a2lKZWc0cGJFV0ZtdS83?=
 =?utf-8?B?bms2SmMzV29zWm12dW0vOHMrSjFnd0w1YVZ4WkZXOW1iQnpCMzJGd2FRWEFK?=
 =?utf-8?B?dmIrVWZXK3I5NWFHMUd5ZmYydU1aZUYvZ2tFb0ZKcmozeHFCOEYxbks4cFpl?=
 =?utf-8?B?enlQUGdvZ2NVbjg2YjkvNHE1MnZWMGE0K29MZEwyN0N1ODJFWFJzTXYvbkVk?=
 =?utf-8?B?UmlHNWMxWG0yK2YzbUgwMGVyNGQrbkQxRXZzRDlUTElUTFMyZnBESWo5bjky?=
 =?utf-8?B?YzB2aGQybGJ0UlU5WXFZSVhlR0pBM2tpNGdGNWZrTEEra0NSNnhVQnNKRFJV?=
 =?utf-8?B?aHozZWlCaXNnOWNhVDJmMUhYbEJZckFJMStxWGdBRXc3cnI1TDJuTHJES3BN?=
 =?utf-8?B?ajE4M3Fqd09CdjRXcURveE16YzUxVTlRTFZNLzNqTXNmOThGMC9SakFaTHBo?=
 =?utf-8?B?RU1VOWRvQ2QvbEhHQnBLbzcyQzJhWXArTFlsRmNNZnR2b2V2VVFpeVBLZlFO?=
 =?utf-8?B?QnpSVG0rVjJETUpqZkdFQUV0VFh4Tk9STU9jTzdxQ21PM0VOU00vdVFwZGd4?=
 =?utf-8?B?QmhsVmRadWdodjJVRDBkSGRYdHI2eDRwdXZ3dE9DQkRjdTZsSUI5Z3VWaXZa?=
 =?utf-8?B?TEpKeGQ4bkhnRkFpaTIvdTdRYjc3NmF6Q0FaK25sVnRvZEtneW1IQTFLWHNt?=
 =?utf-8?B?VnpnbUU3K0FTazk0Z2JNZjA3eU5jaGxpVEhPVkw4VEZBQTBFcDVPZWNrb0V3?=
 =?utf-8?B?SUZ5UUgxWENQMlNIbXBINS9udlZuZTVrdzRncEJoY1lyZ0U0U1JIME5UMCtX?=
 =?utf-8?B?V2EvQnRob0dZZEZKSCs3dkFEU3dqTXdndWdjNmJJL1ZYdXE5OUMxTFc1RVVK?=
 =?utf-8?B?YUhFOW9HWnhJOWVkMHpIZHJjaHFrSmxmL3hOV2hEeHdqc3ZRUXlNbjBCWnhV?=
 =?utf-8?B?bXZIVHpGNkYwdng0OERJWWVSRFg5ZUJhSTFSN0kwK2h3ZWpRZW9hVmVya1N2?=
 =?utf-8?B?eVdsK1pWanczN2hvcTdwMVJhakJvMjBEWVNRc2FOL0o4STl1bEFoRjZaMmRQ?=
 =?utf-8?B?RGZGQ2NYUFA2QVVxSVM0bUhhZlBRY3VYaFdGV1hzQ2I4TXg0T244YmI1eXgz?=
 =?utf-8?B?MGUwbmpoTE43aTUweUhBYkdXamYvcXJzdExjV2g2bXdxSXdSS3BKMVdQdk9Q?=
 =?utf-8?B?SVBSdW11Qk1QRUJ3bTgrTlVtdEw3VEFua2ovZDVGcU9zNUR3ZVBydVlkbjdt?=
 =?utf-8?B?N2RpY0tKeVhDZnpvV0RIZ2xHVVZIRlZSUlJ5MGtwQWdGTHpDVVV1RHRzeVJw?=
 =?utf-8?B?Z3FjSnJoS1Aza21Lb3p6WlAyQTB4ay9NeHgxM3o2U2hhQ1ZVTWJlMkdDMldT?=
 =?utf-8?B?VU1oZEdGUEZCSi96MmdYV1lHNGNlSHBURkNWcEY1UlkyWjhYaDgreXRFczlR?=
 =?utf-8?B?cDZqamdVWStEZmxNZk1rWjNYS1VJeFdmNXNzUWhKemREcGF2eXdyaUw4Y3BC?=
 =?utf-8?B?NytmbGZBR3hHWlN0TytwMGhOczBWbVU5R1N2SUlKYnlJK2crOU9sOVM4c25o?=
 =?utf-8?B?NXlzM3g1VXRkUHVHUEFJQURSVW5oSTM4SDFOcS81VWhJczBoWjJyYkx6ci9l?=
 =?utf-8?B?Q09XbFdLTjVQbDBKSGVMT29TSEJ4TWFZdW1BMjU2N3dSMlpIS2swREpXU3NW?=
 =?utf-8?B?SFBGbzF1OGxNZHBWOXl2NENqa2pUMVVEOVJQdlBEeVFIcWdFNDIwOXEvaXpv?=
 =?utf-8?Q?+hloBONxFkUu+aj2P+mZJhwTe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c474cd29-69ab-4e28-d490-08db2075f62d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 08:12:01.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kePNtyc1zKpoIUvk0cl61Gb625DhDEJCZc22RaC+/loy2LEWyvXquizParg0X54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.03.23 um 08:06 schrieb Qi Zheng:
> Hi Kirill,
>
> On 2023/3/9 06:39, Kirill Tkhai wrote:
>> On 07.03.2023 09:56, Qi Zheng wrote:
>>> Now there are no readers of shrinker_rwsem, so
>>> synchronize_shrinkers() does not need to hold the
>>> writer of shrinker_rwsem to wait for all running
>>> shinkers to complete, synchronize_srcu() is enough.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   mm/vmscan.c | 8 ++------
>>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 7aaf6f94ac1b..ac7ab4aa344f 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>   /**
>>>    * synchronize_shrinkers - Wait for all running shrinkers to 
>>> complete.
>>>    *
>>> - * This is equivalent to calling unregister_shrink() and 
>>> register_shrinker(),
>>> - * but atomically and with less overhead. This is useful to 
>>> guarantee that all
>>> - * shrinker invocations have seen an update, before freeing memory, 
>>> similar to
>>> - * rcu.
>>> + * This is useful to guarantee that all shrinker invocations have 
>>> seen an
>>> + * update, before freeing memory.
>>>    */
>>>   void synchronize_shrinkers(void)
>>>   {
>>> -    down_write(&shrinker_rwsem);
>>> -    up_write(&shrinker_rwsem);
>>>       atomic_inc(&shrinker_srcu_generation);
>>>       synchronize_srcu(&shrinker_srcu);
>>>   }
>>
>> Just curious, callers of synchronize_shrinkers() don't want to have 
>> parallel register_shrinker() and unregister_shrink() are completed?
>> Here we only should wait for parallel shrink_slab(), correct?
>
> I think yes.
>
> The synchronize_shrinkers() is currently only used by TTM pool.
>
> In TTM pool, a shrinker named "drm-ttm_pool" is registered, and
> the scan_objects callback will pick an entry from its own shrinker_list:
>
> ttm_pool_shrink
> --> spin_lock(&shrinker_lock);
>     pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>     list_move_tail(&pt->shrinker_list, &shrinker_list);
>     spin_unlock(&shrinker_lock);
>
> These entries have been removed from shrinker_list before calling
> synchronize_shrinkers():
>
> ttm_pool_fini
> --> ttm_pool_type_fini
>     --> spin_lock(&shrinker_lock);
>     list_del(&pt->shrinker_list);
>     spin_unlock(&shrinker_lock);
>     synchronize_shrinkers
>
> So IIUC, we only need to wait for the parallel shrink_slab() here. Like
> its comment says:
>
> /* We removed the pool types from the LRU, but we need to also make sure
>  * that no shrinker is concurrently freeing pages from the pool.
>  */

Yes your analyses is completely correct.

I just didn't wanted to add another SRCU into the critical code paths of 
the TTM pool just for device hot plug when I have that functionality 
already.

We just make sure that no shrinker is running in parallel with 
destruction of the pool. Registering and unregistering is harmless.

Regards,
Christian.

>
> + CC: Christian König :)
>
> Thanks,
> Qi

