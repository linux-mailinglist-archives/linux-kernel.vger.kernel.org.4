Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A074D75E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGJNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGJNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:21:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5DE48;
        Mon, 10 Jul 2023 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688995250; x=1720531250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KpYOVCAz3zXdl9nid86vkXkoWfGWEIj2AwBprMTGcj4=;
  b=MyvnbuWZEABH7DbhAL4Nq1EoC8eeI+Q4a/BVR9Zy4UTMHt9cThym+OLN
   CdvVeuSeqMZrRiGvPXzcPAE8PgIDvFL9q0n81Bqxc139EmpgbEmUsbucA
   wFlEhernGquC8hFWUgjF1ucfaQVVywgod7K5QYJjPnWs0Zqqg0UX1vm10
   cUTPQWv0L7dcX8CKJJlDz9uLk09qDfZRMVIgB57FbNFjpKnjxntg1qj1/
   JERPFCHymDwftapm8FgNEnguk37wGdApUydSTbUQSItknT3QZ2pOephGg
   YN8hcwOuZad14Pem6IpbHuRIO4ykQMEkYpF1cHyPv4l4RmsQUlfTDdF59
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="366914516"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366914516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 06:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="720696567"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720696567"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2023 06:20:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 06:20:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 06:20:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 06:20:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjAEftWTf4wp02F4GiutCOStPKOxjRcDBVx86EaWsaoKrWtQc7GC3QcCrNWvWI7reo89q4YlOEZDC3IBtYXVHizLUmmo5VAPxA8Zh2TrbSRWbwve1UQlvACuGdahKC4+QtB/bDitnyLN5rdVftORnKO6Zt3MMmbidpel/nxc1BvNxdRwUcVBDNGn4rg9kXc6tohPUpEwuPRmm6PPQvtMEd7vuuklbt2d46RYp+zx9Hp6kHs/Z6+4ByNRR5Vvx9+JJRuVvAv4PguBQOmcycdwHbMTwLJIBZs+8Y4ERCwzbKHM+RZwRHBMZZEgxS8UUgDdZGds3S+imeoqxtdlcYBkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k62L1BIVdFyGjq4+oVykHw/tGRtBdJaiZGNHOh/TrOM=;
 b=dGRLMxN6rDBkxhSMsBLDPz0Y1hvt4aGciS2/2IxmpXjKD7Jjp3XBG3FlDl+6v/aTXqMdCHpn84B94hFAYpjFCMWPNQt+hlb1aUtShTRVVyVeqkW49FEC/fQFAMU8X5NqMH+dsRc8H/tnXWRHzt1A/B3UTlsRl8kLrdCajVfG+eXRqtL73Kdic6b6ZfUlZC5XD0EwCw/scfLlL70QLxeK1g7yOez+y4fDB3o6/9sLiNNJ8QhaRcwTVGg0s7N+N3GKgQW3NTfCWgLQsDHOTaEwKebPk/lU29cHIy95ViP756uomusrk0yh5Ng3sPOwfPmd146xJEJSVzjYJjSqb5OB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 13:20:40 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 13:20:40 +0000
Message-ID: <f4884344-98f9-9ad3-62c0-9ade0bbadbb2@intel.com>
Date:   Mon, 10 Jul 2023 15:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 6/9] iavf: switch to
 Page Pool
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        "David Christensen" <drc@linux.vnet.ibm.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <CAKgT0Ud4h32UFwiUhcpLxSrPRMhbKYSDncL2YiursWgS7Qg7Ug@mail.gmail.com>
 <52963031-76be-b215-052e-a200f01d7130@intel.com>
 <CAKgT0Ufqno2z=6w6XmJ+rVeqzOnHudgsRs8Fgs+eke_cyc0hjQ@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0Ufqno2z=6w6XmJ+rVeqzOnHudgsRs8Fgs+eke_cyc0hjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0311.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BL1PR11MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: d58ba63f-f59d-433e-10b0-08db81487497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmHwxswjm+3rFfj/OuPIsGbucZw9qMVUQyprH7djYQbTRCPk+W24olSaJjz7qABJcxrX0mnth5Bp4VF8wpmhERKbrxZt0YRw0V456XROA3wZf1IqlKcOLDM5K2gZlU+z9ZH5O9oBg9PbsckbGWjEyT7aM5EgbPOTmCUKu68Myb5T3sqkrbFes4TNAdkAdM8K4530gudKREDhG3G0MoNxPwrdl0cW2RCyGACs0tGYcT15cY9ciEiP2LefGi3t2KW2EkU6HmlopZoMNMax9QPlHN4IhJyFZERrXMiTqPgKUig7Mq8VAGJYfoMjmWT3qRFSPOKDlrPdpb8BMKhpuh4INt4xjV751vTYvXE17WrXcL6T8w+pT5W9p2NJgal8Na5doRqBcnpxtgF6xbfP1nRvzL0ieZzJfnQOuFEuHsqsmv3XV0GVPjxN0OXvYBHY8hmPbpOgdVJSFnAeCId35S2KluTnOM63jt5qyJjvpE9CaLLa40kWxyQ3+xvX8KEGRJtHOlrmGVm3pAy1Wfe1msNvoekd2CPk4wu4t1k4wXP/rCOh08sjeu9lJUSueQI7ar8eUxVs5CmA9Gq3tlkepONrWjLfrXVgmDqNKILBF9QQPcPgWSGUv0nWvFWkt2w5H/aEM5x8xWbwbS21A6zTFyRCdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(39850400004)(346002)(376002)(451199021)(36756003)(86362001)(31696002)(38100700002)(82960400001)(478600001)(6666004)(54906003)(6486002)(6512007)(8676002)(8936002)(5660300002)(7416002)(2906002)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(31686004)(41300700001)(2616005)(26005)(6506007)(53546011)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qjl3eE5ocFdGZS9YUGpWaHBuNWhOKzBZeXM1WTk5VHRXSkNXeEVCRmJKUTV5?=
 =?utf-8?B?YTF1dFRyaVJ6anRCVGorRCtZT2JXQ0hTVENDeHh2M3ZwUXdXOXpHdXZTajhi?=
 =?utf-8?B?bVNCVHRjK3FDVTJSSXlQcXZHZHh3VDB3RHVUWXpNUzZuZHJSUXQwdjRJVk5r?=
 =?utf-8?B?cmFGalZzNXh4cVVwYURNeXJzZWRWRmZ2enJ6NDM1YjcveTYrRlM2cEEzaTE5?=
 =?utf-8?B?NERnY3puLzZ2aWlSL1dLUjZVa3djZDZHQkRKYXJlWVFKbzZnaUVhSDJZRXh0?=
 =?utf-8?B?M2dvM2VIc1ExWXRXRnJtSHhpbVVKK2FwTGhvS2pLSllqU2tWSStnUUNpUEQx?=
 =?utf-8?B?TVdMRFc5bXIwdklLQXNIRW9kVDAybVB1SThhR0VtbU5GNE9CQk14emhkS2ZH?=
 =?utf-8?B?QWIxQXNJbkllR3FvSFhVQ0NHUmxIa0g5UlZFVTJNbjZjS3J2VW9aQkFuQVlr?=
 =?utf-8?B?TEFxdXZsSUlPMmRwbGlxb3NoWEtpV1NBd0lYQU1CSmdrek5VNFd6ZjNpWGZ2?=
 =?utf-8?B?TkRvM1JvUWZXc3dNYWFqdHlLd1pjOHcrTXZTb0RQNXp6SVAveEh4VHlEU3hV?=
 =?utf-8?B?SEVZcVd5MWRsSFg5bENkMmp5WkRRcDFJV1h4SzBLL1BKb3NhOFQrRzlMUEJ3?=
 =?utf-8?B?bW9tWDJTQkdJNGhqenpHRjBlaU1uWTdhNVZ6MkxGV0x5TjdGTTArcUFrYys5?=
 =?utf-8?B?ZEp0ZlBvaXhFR0Y4NzBYMFgzY0U0WFNlbWJ5S081SXpHTFdRWDdZelBENFZy?=
 =?utf-8?B?aXZvSG10dHV2YlNCbFoveUczT0NtUnFYZHpucDlQeVMrazk3enBucitFaUR3?=
 =?utf-8?B?QWJScVBRTkV6TzZVRGw4d2F2MkJJR2FuZVhjY1pud3NXNTNYb1R2OGUwQkl2?=
 =?utf-8?B?U3RWemFjemFpUXpoMnBaSm45RzZlYm5VeXp2VHNHNURaQ2QyY1lrV1Z1b2lT?=
 =?utf-8?B?QXhLamNFaFFSNXlTLzZFSVJNZm9pbGdDTTFSZFpoc1ZDcWhwVHBXbVRWK0Jn?=
 =?utf-8?B?WGVKQUNJVXJOckRGNG1oK09KLzBQZHJLZ3R2eEw0V0YzcThvVUZrRWZpUTZX?=
 =?utf-8?B?YzFpbDBpRDFGaUZ4ZEI4WGd6bE9XRmZKNG0wR1ZmbEJXWWF4TFo2TzJNWHZh?=
 =?utf-8?B?ZTNmMXpiZURDUGE5TURzNHR3VmxkUHp4N1AxbHptWnl2ZENlclQ5d0lkOWdh?=
 =?utf-8?B?OElIbHQxV0tEaWVPeHU5SWEreEYzNmREb2FMVGpobDhrNDIvMktoRDVlTDdW?=
 =?utf-8?B?VmpIQjEyT2xoVjlpSXZvbSs1T1VQZHZRak9BNmQ2dTdBaXkrbkg1dmRUVDA3?=
 =?utf-8?B?enhrMW80WkYxb01OSXZ1cG1SS09YcjdKMEZQNTFEbVdTWHNsbXlPM3dlMkx6?=
 =?utf-8?B?SGlUOTArZ3JvWkk0MTFhbzM4OXNZZnNWditkMlB1RVFDV2ZuWTJYaEtEam44?=
 =?utf-8?B?SktBRVNZUVRqdmVBQzE5SStsaXRhWnJ2czhuck53eUZzOXAvdkdMNjNBT3VG?=
 =?utf-8?B?SkJxQndOeEMvNUp0MVc1RVhvdW4vWTZaTXZMbktIb1pkUUNZWkpwZ3pvSkNZ?=
 =?utf-8?B?eXUvQUxvbnBENWFiaGpqYXIwZVh2MDIwMlN1WWxQeitUbit1dXpUdUw2S2o5?=
 =?utf-8?B?ZUQvblVpZkE1bElLcERBMWg1Q1hSSmp0U1lFd0tEK3UzcVJlclN1MDZkWXg2?=
 =?utf-8?B?TCszQlNJdGZQbTBNWnh4RmJrRGNUa3RrUU5NVEdCcHRYUFNKeUY0cWsxRCtY?=
 =?utf-8?B?UzRNdVNLcWFvd1pQNkxwMEJKMjhnaEZZc2pCZ0NIdU1vZVRFL2xybVc1dXND?=
 =?utf-8?B?dWZjSHV5dW1yL2tzRzlJZ0JYQ1FhOWRhMkVhcHZxRkh3bVVpUHJjQy91azBm?=
 =?utf-8?B?dlRnV0pMUGwvS0Uvb0I0akdWZGFPNnkxdUd3Q0crSmo1VE9XdGN5VE56R3A2?=
 =?utf-8?B?UXJTNVhoUlR6d1FNUjFXVDI5UG5hQWdJTmFWRkdDeVhadi9WQjNjU1Qwdnoz?=
 =?utf-8?B?NHFYUytidVF1eTRUd0sybDQwMmNRdTVIdDQyam5HakJ6RVpVMGlqb2pvVDBP?=
 =?utf-8?B?RFlrQUZ3L0dkRW5rU3BET2tQWWlNWDF1SU9WU0RTVFhrcFhpTVV4SHI3Rk5R?=
 =?utf-8?B?NlVxdnlVVHNoSWplZkZrTXJyM2xrRGwvdWtUL3RyREFNNCswRkV1UCt0Tytj?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d58ba63f-f59d-433e-10b0-08db81487497
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 13:20:40.0475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XwB75XRZxWoyKg+fuRt7OYNRNodLezJ0pazLAypaJWvCQm2gD1arsD2c4ESPudSut+5nM40N5O1svxsQJVPRYoaFUn9IC3JguY0A/lA+jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 6 Jul 2023 10:28:06 -0700

> On Thu, Jul 6, 2023 at 9:57 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander Duyck <alexander.duyck@gmail.com>
>> Date: Thu, 6 Jul 2023 08:26:00 -0700
>>
>>> On Wed, Jul 5, 2023 at 8:58 AM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:
>>>>
>>>> Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
>>>> no custom recycling logics, it can easily be switched to using Page
>>>> Pool / libie API instead.
>>>> This allows to removing the whole dancing around headroom, HW buffer
>>>> size, and page order. All DMA-for-device is now done in the PP core,
>>>> for-CPU -- in the libie helper.
>>>> Use skb_mark_for_recycle() to bring back the recycling and restore the
>>>> performance. Speaking of performance: on par with the baseline and
>>>> faster with the PP optimization series applied. But the memory usage for
>>>> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
>>>> every second descriptor.
>>>>
>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>
>>> One thing I am noticing is that there seems to be a bunch of cleanup
>>> changes in here as well. Things like moving around values within
>>> structures which I am assuming are to fill holes. You may want to look
>>> at breaking some of those out as it makes it a bit harder to review
>>> this since they seem like unrelated changes.
>>
>> min_mtu and watchdog are unrelated, I'll drop those.
>> Moving tail pointer around was supposed to land in a different commit,
>> not this one, as I wrote 10 minutes ago already :s
>>
>> [...]
>>
>>>> -       bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
>>>> -       memset(rx_ring->rx_bi, 0, bi_size);
>>>> -
>>>> -       /* Zero out the descriptor ring */
>>>> -       memset(rx_ring->desc, 0, rx_ring->size);
>>>> -
>>>
>>> I have some misgivings about not clearing these. We may want to double
>>> check to verify the code paths are resilient enough that it won't
>>> cause any issues w/ repeated up/down testing on the interface. The
>>> general idea is to keep things consistent w/ the state after
>>> setup_rx_descriptors. If we don't need this when we don't need to be
>>> calling the zalloc or calloc version of things in
>>> setup_rx_descriptors.
>>
>> Both arrays will be freed couple instructions below, why zero them?
> 
> Ugh. You are right, but not for a good reason. So the other Intel
> drivers in the past would be doing the clean_rx_ring calls on the
> _down() with the freeing of resources on _close(). Specifically it
> allowed reducing the overhead for things like resets or setting
> changes since it didn't require reallocating the descriptor rings and
> buffer info structures.
> 
> I guess you are good to remove these since this code doesn't do that.

We might go back to this to not always do a full circle when not needed,
but currently this is redundant.

> 
>>>
>>>
>>>>         rx_ring->next_to_clean = 0;
>>>>         rx_ring->next_to_use = 0;
>>>>  }
>>
>> [...]
>>
>>>>         struct net_device *netdev;      /* netdev ring maps to */
>>>>         union {
>>>> +               struct libie_rx_buffer *rx_bi;
>>>>                 struct iavf_tx_buffer *tx_bi;
>>>> -               struct iavf_rx_buffer *rx_bi;
>>>>         };
>>>>         DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
>>>> +       u8 __iomem *tail;
>>>>         u16 queue_index;                /* Queue number of ring */
>>>>         u8 dcb_tc;                      /* Traffic class of ring */
>>>> -       u8 __iomem *tail;
>>>>
>>>>         /* high bit set means dynamic, use accessors routines to read/write.
>>>>          * hardware only supports 2us resolution for the ITR registers.
>>>
>>> I'm assuming "tail" was moved here since it is a pointer and fills a hole?
>>
>> (see above)
>>
>>>
>>>> @@ -329,9 +264,8 @@ struct iavf_ring {
>>>>          */
>>>>         u16 itr_setting;
>>>>
>>>> -       u16 count;                      /* Number of descriptors */
>>>>         u16 reg_idx;                    /* HW register index of the ring */
>>>> -       u16 rx_buf_len;
>>>> +       u16 count;                      /* Number of descriptors */
>>>
>>> Why move count down here? It is moving the constant value that is
>>> read-mostly into an area that will be updated more often.
>>
>> With the ::tail put in a different slot, ::count was landing in a
>> different cacheline. I wanted to avoid this. But now I feel like I was
>> just lazy and must've tested both variants to see if this move affects
>> performance. I'll play with this one in the next rev.
> 
> The performance impact should be minimal. Odds are the placement was
> the way it was since it was probably just copying the original code
> that has been there since igb/ixgbe. The general idea is just keep the
> read-mostly items grouped at the top and try to order them somewhat by
> frequency of being read so that wherever the cache line ends up you
> won't take much of a penalty as hopefully you will just have the
> infrequently read items end up getting pulled into the active cache
> line.

+

> 
>>>
>>>>         /* used in interrupt processing */
>>>>         u16 next_to_use;
>>>> @@ -398,17 +332,6 @@ struct iavf_ring_container {
>>>>  #define iavf_for_each_ring(pos, head) \
>>>>         for (pos = (head).ring; pos != NULL; pos = pos->next)
>>>>
>>>> -static inline unsigned int iavf_rx_pg_order(struct iavf_ring *ring)
>>>> -{
>>>> -#if (PAGE_SIZE < 8192)
>>>> -       if (ring->rx_buf_len > (PAGE_SIZE / 2))
>>>> -               return 1;
>>>> -#endif
>>>> -       return 0;
>>>> -}
>>>> -
>>>> -#define iavf_rx_pg_size(_ring) (PAGE_SIZE << iavf_rx_pg_order(_ring))
>>>> -
>>>
>>> All this code probably could have been removed in an earlier patch
>>> since I don't think we need the higher order pages once we did away
>>> with the recycling. Odds are we can probably move this into the
>>> recycling code removal.
>>
>> This went here as I merged "always use order 0" commit with "switch to
>> Page Pool". In general, IIRC having removals of all the stuff at once in
>> one commit (#2) was less readable than the current version, but I'll
>> double-check.
> 
> It all depends on how much is having to be added to accommodate this.
> In my mind when we did away with the page splitting/recycling we also
> did away with the need for the higher order pages. That is why I was
> thinking it might make more sense there as it would just be more
> removals with very few if any additions needed to support it.
Yeah, I'll try and see whether any pieces can be grouped differently for
better reading/logics.

[...]

Thanks!
Olek
