Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7575365C223
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjACOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbjACOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:39:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA611A3B;
        Tue,  3 Jan 2023 06:39:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiCpuCPfm9yn/qefDvTJ2iYBFLQl24njYiAXXXDEZMmuWIEremaB8pkioZ/tMTsnL2IFxQocFOCbBFuLCx3DA//LKHxCpdMLOS7VFJEXnGAPd2NxgjCo+ufgniSJ1DiuRyEpZ66C7CvoXgghDyq2D53tC7/ReeirelkhcT9s3HpmnQJCimIYYW+BUOOo7qc7r1ADP8Ha4b7Qk357p3lTbRzu+8Z9PQ1oXkBMjzk+rqf6feebd9jznamfmZiR/zSSTv8R6rYghtcQXOxYnB6MSokpTBNe2/CBUEi/wyplmT+Y9RqpWHyCRVQyVSUARJjwVO8l5ydwFVaQeTpiTlT1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30sEp4VsfIvn3O2uMjdbreACmrogLI1wNT61WewDRhY=;
 b=Wlqo1lpb9twKf8efX8ufGf8WcIFTJc1Y5gqC2KUg8KqBRho6UkS1y5RKMNxHDVB4PDzSdiT/gccPjwhj3nna4eIDPaZ8Bfapl9cGmwSWOekeqzFCwxjz099u03MK9lB0qvkQMXsOfuLfL9rP9Weglg29pq4SJvSFcXRHrFFJP78889K7vEUU6z/DsYTqU6tBNk19h4zGDyZ2Vv0kYPO8NWAaMeQty1rijm18Lv0r61z/G4ot98aEjlLxOJS9EDkW6r5EyKlRYFUChE4kc3s3YKVcxiQ51x3zhUxpVBbLaTKXOyaoqPzR7ccU8www4QSzKPNMJ3QsGKtS/rQ/XHcyMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30sEp4VsfIvn3O2uMjdbreACmrogLI1wNT61WewDRhY=;
 b=nHtV8s0pChHKJ7jn4waNrWMEUn/bFi0T6j/QP9J46ZpR936Wfn7547/EVkbTdHiB+CJNg0JQhXsuhH2Kh/Fg4x7PKvBRxTROPaB7h+M0vwwmTuIUZ6aHDcISAnMFIWOxX35tFke1rP71CeYXOpFiLH9iz5QE86JcLYZymWKIFXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:39:47 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:39:47 +0000
Message-ID: <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com>
Date:   Tue, 3 Jan 2023 08:39:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
To:     David Rientjes <rientjes@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Peter Gonda <pgonda@google.com>, Andy Nguyen <theflow@google.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        John Allen <john.allen@amd.com>
References: <20221214202046.719598-1-pgonda@google.com>
 <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
 <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com>
 <Y6wDJd3hfztLoCp1@gondor.apana.org.au>
 <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:610:59::20) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: f05d3f17-db5f-4bf0-b272-08daed985c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFY7pfL5AzGP2hmeQ8jKzeOwgObXVzdEtfaOPA76eIzi9dVAfxxsfPAHV0rfTw4ywnvE8c11mK+UPAa70WJIaF9c+FxdqRal14Nnxnlf9CLMw6DnyemNsbTp6gL7qbNnzHUJGcwqAK8d8l+u3uDPgP8lSF766033/W1K7B6VIp20KkBU1MnkRW1VS8dDh8VD/b2K8SLGWMxLDYoF3+3pFJrPZLvTr0/qyuIXjrhAzk/TnPQqptw3fDWSHmVCJMEOd6pSveFYtQrFPcuB2L9j2OkogKgvV3Wdln5DkppnW+U2y1K6e+p+/iAXGFOxObmQ79yVYij18fcLf4ghA6YKMKOwThardU6J14ye0MtlopaTKVDrkp+afFjIX1ynRI4HKoza0ZfaedN2Gr+oXaZKaKYuMX/DXH8wBodRiJeKQ32YX/TWmZb+S2rbST8th4SEvsOxOwZTkuNSPMZGHWNjjsWrFdf3UfAa5Ai0kwv27r1P/Ieyf++4K4YL5kAckGzBmp2/XSk6Nl8ZVI8IKOQlcsGwB4LufUrkVBUHHYeIYIG/SU/cvTofyyQb1i4BbP4h+alxDvYbBER3wTErnZTIZO9hsoqKxDkaZ9NCAppJvCb2Lh6Yk8Y3Ex2fcxG6TBfI/izO9rjFAn2IzyAxNR2CcxOofW2DQ+6xcrml5LLzSPbGVkiRKggPTuV4cn2Gedqau42GS/lilXnl5EsiFnEUWs2xPj8UqCUGDa32/BNngocEusdFGuJxeyWtstCvQWmG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199015)(4326008)(8676002)(66946007)(66556008)(66476007)(5660300002)(8936002)(316002)(31686004)(110136005)(2906002)(6506007)(6486002)(478600001)(54906003)(41300700001)(53546011)(186003)(6512007)(26005)(2616005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2FHUlcySnV6aEFrSkp1aytRRzcySXcvN0QxSFlxcWV2eFFibk5ZNENhSTNn?=
 =?utf-8?B?dWpyNFhEVkpCaytsbURUWGlnM2lQTGJWb2NuU2FYRnJCMC9hNlFUa2hZSDVO?=
 =?utf-8?B?ZXZ1S0xTejVUdUlWbGdNZnpCdXhBSjczZGdpOXdNZlNldjhUYkFnOVZqRDN1?=
 =?utf-8?B?ckFRdW42T1loQzA4YU1aOHArdVB0Q3N5Q0twU0kwSkFZbFNRS081MUEzY2Qw?=
 =?utf-8?B?cGpoRkN4Q2pCL0tSMytMN3ZWbkxoTzQxWjVFanhuMzhscDFCaGF6SjFHOTdQ?=
 =?utf-8?B?eko1b000Z1htdXg1OHZIMlpGQ2dvYnlsVS9wY2p3VndFWm9wdmxmd25HMFJo?=
 =?utf-8?B?RGRKaU5IWHNNY0hwNzBDNDZObDhnRkdzQ0dWWU5tc3lrbm5EZ01hT1QrZHBp?=
 =?utf-8?B?R0NaOEViQXNXbSs4SUx5cXkwbkRLVk55SWJBc09ZQ3I4NnhvWUF2UThlYy9U?=
 =?utf-8?B?b2U3K1VHK29UdGx6VzJOcXF0VXEwS29uOFlTUUpya3ZBaDlHbk92ZlZWVXB1?=
 =?utf-8?B?aG9rT3F0aUlnME9OWUZZMVNmZTl4enlWODBtSEZzaEV0WWRlWU5PK1Zpa1k1?=
 =?utf-8?B?bStoSTBzdDRsN1F3bllReE5OYUJlNlV1VVFaUmRqSThSeFc2dzlGSk84STJn?=
 =?utf-8?B?ZkcyZXhQSW1JTkxoeGFoa2JXQTdLVTdTQndJMmhBNGJXOE11MDRhWEFKcFlC?=
 =?utf-8?B?T1FRWWlOUjJiYWZNYmw5V3paVGFXV1lGVWduMktwSVZEZEErT2V5SUdjcllJ?=
 =?utf-8?B?NlllOGJIcUMxdDFBOCszdnErSzRmZEh6emRHUXM2Si9YZVFHd1JYdm9mc2Jo?=
 =?utf-8?B?aC9CV1JlV21pR0V1Y3pLWFkvclM2L2VKTlZMVXhrOU1ORExjbmgrV2VUVjBY?=
 =?utf-8?B?Y2J3V0dKalFqbTRoY01EckQ1cEppUG4rdmVFVFM0S1BySDg4OWFzWnp3Vmkw?=
 =?utf-8?B?aDRnbVhYbzdlRENZa2FlNTVoV01qNlpKeXE0R3RieEhielNYcG40MEg1czlo?=
 =?utf-8?B?cndDbjJKMG11MVBCYVNjNHg0bks5SEJGc3g2bkFLUXB6SXVSTGRmSW4wY3ow?=
 =?utf-8?B?MXdLaHhMZ2dab01XRTFzUUZONEs0aUV2M203Tzc2dkkveGE5R1F4NlErV0E5?=
 =?utf-8?B?NXkvcUJUeGU2T091UWdvd01lVFJIYmVBYWdUTHkrcEtDaXBnNmhiRlBCdjJ5?=
 =?utf-8?B?M1Y2WUtLNjBaQURQeXljNnBKM3UzYVZzcW5qN09PVGZvWGJPRUZ5Y2dXY3Vx?=
 =?utf-8?B?U3owMVBMS0JRWExGSXA0bVV0czNRVkljc1NTWDR2NEg0VVJtRTNHTEJ3Tzhr?=
 =?utf-8?B?ajY2Q3M0aVdEL1hSRUozODBqWjdQQU4wbkE3bUh0UmZIbGdiSENtQXdYeDkw?=
 =?utf-8?B?S3VLbU0vU1pySXN4Zk5XR3FGVWdlelFKdUxJdE5WbjdQS2tCN1E0WWc0WEdo?=
 =?utf-8?B?QWMvYXFKSUpVOHRDV0VqWTNNZkdyQ0FSOWc1bDBBSmRSblBZZDN1Vzd3SVRP?=
 =?utf-8?B?UG1qQWJ4Y2MxUVFJUDFBMGxTdmFpckt6RFVBUGEwSTRVVzR1ZWE5TFVKWU9l?=
 =?utf-8?B?WjFKaEtVVXhEdWgrclFPM2lzb3VaZFkra0p0Q0NYTWZYbDc3NzFZQUYyMmN3?=
 =?utf-8?B?NWF1NWRicm9ZWDV3cFBDNFN6YXpSRWNXZnNhdFYvNm95ejlMS2lIR281TUt4?=
 =?utf-8?B?cGx1ZXhlRTdpMTNlS0lMVXdYOGt6R0JwY0FYMmR4d3pPL0J0azRUUVFaaWQy?=
 =?utf-8?B?TW5pQmZ6VlM3WHoyRjlVOTl5dDZkcE96MzZzU1lTZUh1Q0svN1l1UHk0S2Ra?=
 =?utf-8?B?VlRrSFFvK1dqQ2ZFRndJUGJwdERYMUdWOUtyclJOaW5NazB3Yi9VbzJvNzQ1?=
 =?utf-8?B?RzRZdE54bGw0UFpHVHpncHU5cEdXR0s2TEVTa1UxNGMvU2VoR1JkM2xBWjZV?=
 =?utf-8?B?RlZwUzRUVHA0WjJ1ek8rMXkvVUlmV2NoYjlJSlUxS1BJdi81VTk5eVlPeE9l?=
 =?utf-8?B?ZGFPNHNTZnlmeXV1WW53S3QyN1YwbmJLOWhsM0dKcGRDWlNPVUZHR0VBNXEw?=
 =?utf-8?B?enVjRmZmdm5nTmZDWE1oM1E5RU04TjNDckVscCs4SFZYSWhNNStrV3pWRURa?=
 =?utf-8?Q?Ow0gr7K2QkTnSeFW+cibo2Fcq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05d3f17-db5f-4bf0-b272-08daed985c83
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 14:39:47.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0qzF8UhP1WR/2DwiAv8ySaEzYAPAj5tTavRj5jnA5UQUXm21j7pNzDTf053oQisFNOoJbViEzRe8biTtEZa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 16:18, David Rientjes wrote:
> For SEV_GET_ID2, the user provided length does not have a specified
> limitation because the length of the ID may change in the future.  The
> kernel memory allocation, however, is implicitly limited to 4MB on x86 by
> the page allocator, otherwise the kzalloc() will fail.
> 
> When this happens, it is best not to spam the kernel log with the warning.
> Simply fail the allocation and return ENOMEM to the user.
> 
> Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
> Reported-by: Andy Nguyen <theflow@google.com>
> Reported-by: Peter Gonda <pgonda@google.com>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>   drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
>   	input_address = (void __user *)input.address;
>   
>   	if (input.address && input.length) {
> -		id_blob = kzalloc(input.length, GFP_KERNEL);
> +		/*
> +		 * The length of the ID shouldn't be assumed by software since
> +		 * it may change in the future.  The allocation size is limited
> +		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
> +		 * If the allocation fails, simply return ENOMEM rather than
> +		 * warning in the kernel log.
> +		 */
> +		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);

We could do this or we could have the driver invoke the API with a zero 
length to get the minimum buffer size needed for the call. The driver 
could then perform some validation checks comparing the supplied 
input.length to the returned length. If the driver can proceed, then if 
input.length is exactly 2x the minimum length, then kzalloc the 2 * 
minimum length, otherwise kzalloc the minimum length. This is a bit more 
complicated, though, compared to this fix.

Either way, is fine with me. Thoughts?

Thanks,
Tom

>   		if (!id_blob)
>   			return -ENOMEM;
>   
