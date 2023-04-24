Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8936ED125
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjDXPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDXPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:18:37 -0400
X-Greylist: delayed 1585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 08:18:36 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882F2D53;
        Mon, 24 Apr 2023 08:18:36 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ODFoTM012835;
        Mon, 24 Apr 2023 13:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=Ri8oGn1QdXz2LI3uAPVkQWMdwm/bdQ11yNs75tGxAZU=;
 b=p0r+r+t9oLU3VL90NruE3F0PG5dZC+iY20MGKPus2E89JVaR1y3XHC15ij82ezri5vUX
 E2F1jrOfLWqGFmfuqMPmvCOPNUOerxHeZvrd9cHIB7Lu5nzWzUNe/RRWuxdtK1OoNWJn
 AXNvkOq6i9IaVP8RKtz9NtFEyyPe+4OaZVZ3Hwal04pfugnL8qd95OynnDsDfZX7l+SK
 SyJsk7zEoX2XbX8zIEmfVqqwoJgifFxZrWWfjNdbaixkNwJzJI4OC1KSeAqASi/EymuH
 xeQcnowQIPP4E0CqpYfxf1B3l1bTChvey2z1DP9e7B9azvEUo4WLywKCBgt8yLgEdemu 6w== 
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3q44u21tev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 13:17:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3saad/nkNhMbK1IYfTtzo6wXAnB/x2ZcrlrZS6U5y/5hYOlFtsNOoXu072k68PsuLsgHcv0ra8HqkTMH+q/cGjUwKhK9+MOs/yxzFm3EBd6lP259ynr4PXWyEtAmdgcIvRYEOpR/vYzzBAUQPGYFk+OJ7ZzA1p04ibpHNW0ik+3F66BNOoE5is1Q8z3nRLqZYXcKge8dOlrRdKoslnkFzeInudk8gofgpf7kjVUgLzpVEZR/aeoi1nNHZnWnQOsQAixoUBMWw1IbZyx/hHcMFVbbzvRcgOlDibJ4LWzkJhgPAl0I88ERG8QmwUXaLXxxZy0i58Q4YXE9mObobcO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri8oGn1QdXz2LI3uAPVkQWMdwm/bdQ11yNs75tGxAZU=;
 b=FILYKX5h7UqOb090CVV3hVpkDDIUyITHaHMER15mwXT63xcgVpyk30skzJGgpWsbmWolHu0uHe/mNGncYQoUWW94yhHj9ph/3Sgxpze4WBuMIF5+9Jh0qEqp7T6zNEBl3u84ZLo1ZjLLpCHasirM4wdzJeUVDnaZLLhmeBk7OrTM/x34cqVHnDgH3dl4wOOZ4iXWQnmh67dSNzUne1+GUR2eOSjOtYK+8QPkjvDZJKvCJWl7L+kRngkyYkEF4h1wB3iA1ENZrGTZOoCurrcQQQpnJ3iAOSqt73h9MHBuXAOMesAEacxLTbL7cFLNhPja+MwB+OzYAgQu2htOJnofhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fb::21)
 by PR3P193MB0943.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:17:14 +0000
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a]) by AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::957b:7571:77a6:c86a%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 13:17:14 +0000
Message-ID: <3164e897-a423-3948-d50a-f2bdd4ad05e9@sony.com>
Date:   Mon, 24 Apr 2023 15:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Content-Language: en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
From:   Peter Enderborg <Peter.Enderborg@sony.com>
In-Reply-To: <2023042421-landowner-magnitude-a38c@gregkh>
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3fb::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1687:EE_|PR3P193MB0943:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c86e2a-d555-4f9b-f477-08db44c6380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PxbGL4Krm6vRqU6+t3Hjp+5yP1gdjH7hSMvJgUnDutbT3AWQwPS7WiB+Khi6DDsBNoxE++h2/A22/9aXzU9xnoSqK4N3bzsYUBhQNQIcJYldUTh86Oxc2DuKYrr1fY4zhv/axwbQWZL4WfpS7/wnfzRDCZy9WWk883IPncjmsJClanUMiKH1zdHaSYcMZdnfh8XfnnAIj0g8mR0WtHMaArQ6oSPI++xzdYlKuFvkUPiysco7lXHKBeY+CzceJLP3Z1QjKmNapL8a4ssHdOALZnKxgP//jW3gaq523ZQrAOGB+Yq4C9wk6sP8N1ca5Qu1N7vk8BudpuJptGklh3tmQB2bUDmlaZ5k7O29WIWgOA1dm2WhqfOsEpEsVdcF+FLL137dVdm68Ak7SVGOEm/OTL+kPtM5d3ULinYJMdL+6HKErILjdDojSdvRPjEOh2dXc45L+5SEbVcJ+LsVC4LI2OCuZqAeDUsKA6Sm2D8sgYwm/xhhJ/wmK9NtGF9kdgTQPQ0dzlwqGClHVD5ai1IgWpiX4/hvGG5sp7TRZPCUITdXU7osvsNmHsiNSEb8OGpbTBJUx6kCkWW0cVWM/kjXwPbQufgXCwY9BsJRL6XrOo8Hcj8fAEwSP8tDpWWBvBEoDA/IT+jYV4Tk0jFWyqfiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB1687.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(4744005)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(41300700001)(36756003)(31696002)(86362001)(6512007)(186003)(53546011)(38100700002)(478600001)(52116002)(6486002)(6666004)(966005)(83380400001)(31686004)(2616005)(6506007)(110136005)(82960400001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBLa2FOWC8ySFU0UlZWYmNCNktQTUluSzBmQ2dWdmhObS83RlZsNjJKeit6?=
 =?utf-8?B?ZXhvMzZiQ2VySEFtVGgvUHh6ekNQSkNOMm5MK0w0NjdDY3gxR2lsV21hYVBO?=
 =?utf-8?B?MU1Sa3RMYnhSclpld2hiZjJGVEFTVEtUSlh3TVZFVXBZdlV6MS9VclFKU1cv?=
 =?utf-8?B?c0FIYVFHN0lFdFRDYkNnc0g4MnA0cFZoT2V3K3JlNUJrbGVIS2ZNcGJNR0pQ?=
 =?utf-8?B?Q1p1amFNTVJTenJWQlVsRFY4RUdkMEVRUTFHNHlwRlpIbFBLRjlqNkdiMU9G?=
 =?utf-8?B?d3M4cEk1NzFTR1hYNm5VMjlpWm5jc25ENWRnK3duR3Q2TVZrb0psR1BycnBq?=
 =?utf-8?B?bHk1NytHNmIxcEtpY1B3STZOOG0rSTRkZ2tUeFMzaGhFdEhkVVdxdlJPN2NW?=
 =?utf-8?B?dmpnTjZlN2YrNWRKSHRLbXZSR0J1ME96NXA5elNnd2t3MmJESys2b2tIZmRk?=
 =?utf-8?B?UTBtWDBhTmh3UUkxVW5TZGdwclNKWXZadHYrbWIvQndOZm5xZUtGbVdsUUw3?=
 =?utf-8?B?aXFVdU9wQ1dzd21Od1c5MDhRRjBsdS9tUUdzK29QT0RpSXp2eXNDZHc4QlBn?=
 =?utf-8?B?L3pSSW1JQnEycHJyUVRDQngxUGIzSDZKUG9HeFZkMDRxTHI1Y3JSSnJST2dQ?=
 =?utf-8?B?Z2VNVjIwMUpJZk9EL1FQRURnb0pxSUNLdkk4RFJBbEZGOXF4aWtIUzF0aTIr?=
 =?utf-8?B?QzRrS0FpYktwdlFLWklVbThDWmZEbjJGRHA3WUlXaUdkMnUzV21QL2hEQWJi?=
 =?utf-8?B?Tm1GTzdKTVZxbVliWHdrVlhZaUhpY0JvdDlMc2wyWS9xUWlEZzFBc1B3ODR5?=
 =?utf-8?B?a1pSYzFhMStvNzhnaUkrZ2xybnloQ2tJNyt5aWgvbThZQ2E2ZWRBUi9qTFJ5?=
 =?utf-8?B?VkQ2R256S2E3NVh5ZDVvZm9RY1JWR3QwdXBVa09oa28rcHMxVXlVTkg2c2ZV?=
 =?utf-8?B?czd1ZE0zSVQ5dEE5Tm93ekhXTmFqMUVtRkhTbnRrQzJ1ZzZqdXEyOHNPVlVC?=
 =?utf-8?B?aCswTEpheHlzRmFlQ3czb0lzYnFoR2ZsVHVjUTgvY1d5c0p6MFNqeDF3dURE?=
 =?utf-8?B?bzk5Y1hIT0psR0dRYjIrazV4SXp2c3RMcDdQRkI2QmdxS0ZvMHhlNzY5TUdK?=
 =?utf-8?B?UVRTam1hZ3lMY2pQV01BRENWbzJyT3BqSDlrU2dHdDQwZ2JpWERRK1FZaE13?=
 =?utf-8?B?Q1NMR011bWlMWHp6N3hXcnhyVVdVd0ppeUZPOC9tU3hQVUJ1TXpiTWduL3Uy?=
 =?utf-8?B?Nld2endTRHZuYUlzNWcvS0ZYYXdITDdiS0sycGZwbnZqam56bzZZS1Q1dzlB?=
 =?utf-8?B?UjVEd1NBbmJHK0IrVHNaZGNjakhoa3V3L2d4c0tmYzZOdjNGNWkzOVhxeFhI?=
 =?utf-8?B?K05sNzhPZm5ocHFBNWl0aW91cXZVK3JsQ0tDc1lDQ0kwMkhMOVljK2lydXZj?=
 =?utf-8?B?cXBQbk0wSlF0TjdIM3hqN1I5WjNVYTc1ckFOdkNMeU0zMlZEN0F1T3duNjk5?=
 =?utf-8?B?SmFvZTlLZk1oeGlNWC9MU05SRGxKU2RVbUFlL05jT2lVVnV0Y1RtWFVEVlZt?=
 =?utf-8?B?WG9tdmFQVytqZGQ2dno1S0tFM0ZwRTMwK29nWkREZnhpa3hSejVzeTlVbzVS?=
 =?utf-8?B?NG1vM0x6NGVvNkRWZHNuUVRuNDV3R2V3amJUdXo4Z0kyVjI2cjBiT3YxSHdB?=
 =?utf-8?B?WlFpTFl0R3hCODlGdmxGV2R3WmhDcExIRGE0cEZRNk5OQ2QwZTBZNlpWT1V4?=
 =?utf-8?B?clE4ZExLUDV4bEx0d0svSURkRERFOXAzTlVNT2sybEdRTytpWE9oNC90b2li?=
 =?utf-8?B?WG9jT1JFeWs3TmxyY1RMdVpoNSthUy8wYy9EREVwcXlEaEgreTdzd0tzREEx?=
 =?utf-8?B?eUYzdmxyWWRpckdHbFJ4V05hSzBndnFueGg2Q08xWTNzTndNSXltMVMwdms3?=
 =?utf-8?B?YnZvOGJZaXpHUCtNTktlQW1zWUtMY3VBRjNSRmhYZ1VlajhBMUNrR3lPZEhM?=
 =?utf-8?B?eHlzSCtJeWtXN1dMVWdOd2ZlVmNGVFhmbkE3T1Y1cVFwemNLTlFqTGFwcWps?=
 =?utf-8?B?RzRDeGxjYUM0WSt4dzRHeHV5VTV6VU5Deld2K09td3AzbjJJYVFvK0plbGN1?=
 =?utf-8?B?MDd3dXl2dkVEdFNGQkFQcEgwZFlFVnNLWkRqc1RMSVNPekgvd0J6THJoME40?=
 =?utf-8?Q?lk4agE7zgWeuqN5M/9CqYxQywDuLAxRSovHkWvKxoyzm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aK+6OC3nqTCcgCyydLSmLmhxyIR2VQM2AXa4o/inqXheAwsSXZS2XHjabqYfrNmNpXMR7N91IY6FVMs9PzZG41DhoHmGJklknWeMV6hMg0o7nOJzSXDVs+DsFO3nmAM5AOV4gpGrEyV9CoO6rwewgqYkpyd1tobaSL2JolgsJAukfnY8mpAOE2YOYHJHb8WfWtAzXZ4veM5nBOLkANou7BGBaXOCcQrMtlMrEnR5DnNp8YiDPNrgm3i8V/l/y2md+k/tDpDUle++oaLNLD/4kFtI4D6Ki/5MZCxyaJiy3co688jaPmgejbEHcHokHT1caAQgYciDElIClt5UP+00Cp1P/687ciJeO0g7e3ffVkbcI5YnjJUf/3eeb2UwuWN2vElTejkOPGQuVQjEiiPs1HTK1tfWsQ62XOgM2X4Q98tpp3zO7kjR3Q8EL+rTXkGo+zRoOGQUexhrjYAJgOLb182NJYPPXd/W5DsCnrOtV7kNw0n/Kx08PnHylF9ti9mF8vtdwOsT8h7E1P01GawYw2hG4kc6zu45GXBVxBoddwObqwB8siGQchp92U4sEa8T+bOEyanwYXfPRLMm/3VITgXqOi3dEzrJHyZBWdHXfBtXsMHCmcv/9NW7dIT5N4UKMwkm7YNUs31JRWhFtW0aDTek0LM9z8VajZPh+0P1QrWOCMfVmsBaN/xB+jRZiJcLBIg7eYzDDdKQAE3hs6qmfU3xKUauZMPt//WKdlslOMZRlS+wPolL/Mj0vQXfjVpmhKKEFriNNbIB1n+wP9CINQXFIZkzIXdQRJj29+abBk3J++Hq+jIvuZ4U0lcDHYEeKooNlLS0DH1zILI910kKXVoeWTcUbrANatRhjYf155ZAelbAWLqCpSZGFAB+CYmW3+QOXah+Hd8uPCuzMJ5EbFU79sKVi3y4wpJVK5DurOE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c86e2a-d555-4f9b-f477-08db44c6380c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:17:13.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8b48P32zO4pcBXLyXT4SUTIUvrVOftvTdRdM14a5egaYlwXASzd5Oxun4AcW+t9R+ixWP6nsJUput+LBTUJu1gTuTKN+11rMaSR8IiU4w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0943
X-Proofpoint-GUID: Cbx6m-bl10JAcsQEsg5hyqCKCKYqAJAN
X-Proofpoint-ORIG-GUID: Cbx6m-bl10JAcsQEsg5hyqCKCKYqAJAN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Sony-Outbound-GUID: Cbx6m-bl10JAcsQEsg5hyqCKCKYqAJAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 14:53, Greg Kroah-Hartman wrote:
>
>>> We can do things with the debug information without filesystem enabled.
> What exactly do you mean by this?
>
>
We can read out data from kernel with a ramdumper and analyse with crash.

See https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide

If it is useful or not I can not say, but the dws->regset. is lost and can not be read with a post mortem debugger.


> thanks,
>
> greg k-h


