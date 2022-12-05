Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A2642A81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiLEOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiLEOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:39:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26EC753
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670251148; x=1701787148;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=X/OaUUccJ6aVbt1i5kPK5CWBlyIw2MVLh2grme16+8o=;
  b=dl4U8y4IW51LliWKIwEH1ktsgEH3BNSfoADOtwdQDO9iW76gCZorW+mu
   +iinmbZ/8qZIjb+6Nhe2AWJFjrcLEz/pSASMXFVGfpD6LGNuSJI5gjStq
   i3+oTOax+SZULpDt1sHLVIZEgciO8tMRsZwCS0xs/SUfrnxPtAzLrmCih
   rUT8wg8DjUy+cchIsWLwsOfJn/O1rWlSDclssz4NcpYRwhMxMrKduteF+
   Isw+74FJMTx4j8TXtQbzRKo1k0UkFC0P/81+FRFXYBXpY1DekvWettoNC
   i0+N2t6h04oF8nhovRqPppW/dFewY6HNmaCvU1Sq1sGS8iavQisvDvrGN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="378521392"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="378521392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 06:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="788093358"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="788093358"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2022 06:39:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 06:39:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 06:39:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 06:39:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG5M2EY106nkw8f3XNdQecbd/1m3tD7rls74XbfJiol/tgMnRexrLxcgR3U95tfZ38dl1TTiYibQlHQHcrUJ26kapM4a31XxJyw8g62AUDdLf3iMiOU3t2ytj9o2INYA3s7daMOpMQTwZNODfxumvO76ltg/xBNtvaaRxnMONEpGZZ2aTweajthuvswas3aqpo+b5QFmozBxOhM7YWRJjGK4TiymwwwseznIpiRx9YoEvt0tJoV+Bi9oKnGQ4TpcHLWMTxHBOH5p4i0rmYt68kPOMjcnxcZAhF2gub/xBj5Uu2zzt3gt1ZF9Y4WmK9Ba9vWNPJYf1h1raPbH1+pPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojCMnVu01QngXbmrChPcynta55E9I9FYt8NKXbvl20A=;
 b=co5L7RGExU6/Wv9tpw0BGvZtykLdklPZdtYDMQP19O6VcXnEaEsogbsybCSii83E3Of8z8DeZVg4/GzN2/Ly1FCIzP1nWyTPHwxU0YgkCcUpYGmS5dSK6G6dOmFbIL+q19yDe9SI1Bgytt4kfs+6iU98pJjsbln8hnuyu1zn/QqoJsZbqZfWZ98UGIbKksJgbAtXi8h7AXwwKtMhEcWV3oM9EolfFXTvUIEj6ZnJ+QJi3dRRXseRFD/+gNwkQoARQTqOkYcxxNEZSmBRO7i+/MERtfQjTWrEbOm1Z9/VVDBDrNla9E9ngix4SCuCKMu94HqR10aJMCGHitP///eknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 14:39:03 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 14:39:03 +0000
Date:   Mon, 5 Dec 2022 22:38:44 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Josh Don <joshdon@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
Message-ID: <Y44CdKrQoFKGH+1j@chenyu5-mobl1>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
 <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e3d84b9-d65d-4602-d53b-08dad6ce7481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzW0uVXa4TFMAQyITU0oana+xs6gAnp4JWHJOOYxh2xSnXzQrUpx7SslEh42H/cJSx5OVs3I0FcdKPrUyIdEzlipBu1n/9Q/z0PEPOeJigo5AlLr9QLoiVzVWQV302hlq4cBhx/m/a6HLjfpWiB+0LwTVQ9CDqpug4vRF2MzrXKDTRGsSPK9Ag9HNo7u0AA+7CDeZhdeV+LoUslCgAb5p0QRz8cw+r20fXAhkpi8Ohkyjz0N2HkCSzDTS4GQ+NKGQ3IDlKFAI3H1Z8LQb6OwgdQVkciyQrcnQ1csX30JBZ0TIqT5is68KrznZtV17x8gscyeys0wgbSBz1AGK+m3ulEVP8yacTJU7/fb1SyCLHsr+BurhY7uaDLdpGvPD5ai5SqfhCbYfS2ep9cqECDT24ChzbUsn7jhqWHGMPJbKFi24+lR0ks79XdT5ZMS9V0hXJsiFufqWichKJyq6BHtdp07/7981NGPj4KBoo4A+eftU8YAD1yDee4FOQ5FaYWVyGC2hl6cYYHulm1osrF+Bw4X/xkocm9c5T6ly19fmpVWcfi3/4YTrtONazOicYBfcwmiwLijQvJ80V6i+AFKDfXtJzOvc6Ulnt2Xbox5/bbC1KEfZHuKTH7wBuTZkZH03U7ABOY7G6HD/nndEYPIZMwj5DnSxElTmU/j0KP54GB3nS6xnSU/Nc6fK4zoLdBz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(38100700002)(83380400001)(86362001)(7416002)(66946007)(8936002)(2906002)(4326008)(66476007)(41300700001)(8676002)(66556008)(33716001)(5660300002)(6512007)(6506007)(9686003)(26005)(53546011)(186003)(6666004)(6916009)(316002)(54906003)(478600001)(6486002)(82960400001)(66899015)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hrekFwd3NGVmFpY2FLancvRzc3STJkSTNSamc2SjNqOWUrUTZYdk5RL213?=
 =?utf-8?B?VU1lTnlNNHBqMEgxaERZNk9aYkQ3dWt2cFBPMUtsSllhS1EzVzJWWWVJTGtG?=
 =?utf-8?B?QmRkM3ZNL3YxQXQyS0ZIdHpRWStKR29nQTVnRXZoSzhSdzUxQlNxNlg0ZkRX?=
 =?utf-8?B?VVhWcjVwMjRqMXQ4QkgvRXg5WjVDRmtSaWl4Y29FVWdNRjVIbDZuSTJyRmNk?=
 =?utf-8?B?bTEyenphbmZ5UElYaFhyNlJGUm9Rc1FpTG5PRm96b283dlZjd0liR04raGRk?=
 =?utf-8?B?cHlJMllUb29zMlhvZWhqdUZwSVlxTlJJSzYvdTh6MmxEYi9xVlp1MVB1VFVz?=
 =?utf-8?B?ZXRGcWtEWjhPelVxbCtYQ3VVaXFrM3hPUllpNUhNbXJuZ3VtM0ZRblNxeVhw?=
 =?utf-8?B?K1VwbzB5eTVLSkYxdG9abDVPK01GWHRFVDlIYjUxTlAvRGNxUWp0NVRQTi9Z?=
 =?utf-8?B?dVZFYkJmTC95b3hoYmp5RmI5L0pqMTVoUzFuQ2VYZkgwV3JBTU5oMy9CdEpS?=
 =?utf-8?B?cWZFY2ZQdzJUdnBMNm1IbUVNYkVzQjkvZnVZeWFuS3I1QXZRRkJkMG5ZUE85?=
 =?utf-8?B?NjZwK1FWMDFodFNDTGpUWEEyU0VQVktGR1dJTEpkYVJoVXA4bW1YMmZJRUxw?=
 =?utf-8?B?YzVyR0IyN3VrS1U0Uy9oNnJOdjlzTWphVDZnVytjeG9pbjhKZGpkV0VsdFFD?=
 =?utf-8?B?aldYa3hFRDFvaFA2L0xZekwwY2kxaTZpYTBJRmVINE5GYzYxNFJmRnZteEQ4?=
 =?utf-8?B?WHF3aWhlUitkeC9ROE1EbGJGa2htNUtoOGg2WGRkOFpKNnlDdDVOS1Z0SU9w?=
 =?utf-8?B?SFpzNFJkcFRlcm9JYjJjTHoycktkalVudmVtSDBwemhtNFhiYm0xMEVxQ09x?=
 =?utf-8?B?NjBmSXZTQWU1TncrVnl5eE1oeC9RVzBYN0NodWJaYy9helVYWlQza3FpS0ho?=
 =?utf-8?B?Ny83MnpPMjN0TlhKaTcxODlWNWRORWxWazhJQzh6K2lSSW5nczBwV09saDgr?=
 =?utf-8?B?Tjl0cXNVdytHeVE3WHduMWJocXJFMXQwTmhucVRJMGJzV1ZvdmtSZ0YrQ1dF?=
 =?utf-8?B?dlBpc1NpNU9yd1FYdGpJTHpOY1c1cVZxb3lDY2FuTXpXSm01MjZOdVF6U2xH?=
 =?utf-8?B?VGVDNFZ2eVpyN2NVbnhVRldKUlRNdGxYZE5wcGxZUWdBTUlwQkQ0azdZSDhH?=
 =?utf-8?B?cmxhSlQ3aUNhZndqZVZSY3dTNVNkWFVTWk9BbWVTaVJvQjBNSkV2T2hlcXlB?=
 =?utf-8?B?NE1vK0RBRXU0M0VYYXdPVnNJbUZrWHJHcEh0N0Y5elVLSmVsUTQzek1DUE5m?=
 =?utf-8?B?eGtGb3Q3NkIxNU1jTjJDaEFQWVVYejhHeGtweVpqWUxNMGxEQkdkaUZaU2k2?=
 =?utf-8?B?WC8zVHh0UGRFa1ZTNFpSY0owakdxY2N1YngzR1BhVUwzNk1JSHZybURZOFRZ?=
 =?utf-8?B?SEFJOXc1MnUyV21sMkE3ZXROUHpwMEdkQVRwTE9LOERYdXVrcytpZnRjTmZN?=
 =?utf-8?B?WEUrT09CM0cxOTA0a3lKd1RtbW4xeHE1SU5PTGRHZjVDT1NXWmJGa1l4bEVQ?=
 =?utf-8?B?MFUveFJlZEx3RFNhZkZuL3VydC9raGJzVUhPQ202U2F4VWtMSnVKL0Vxd3ZW?=
 =?utf-8?B?WVM2dU5OcGx5ZFpTMldURGRQa3d6cStnamN1OUJLQk5vRXRlWWJBa1NqOVda?=
 =?utf-8?B?OHVHK0dqUTByYithcXR4OEZpMXZmMlB2Ymh4d0ZCTmJaWmlvaGRhTE9qUzhD?=
 =?utf-8?B?c0IyR1FNMlZpMjAxaEttYzFaK0ZIOTFEUWhCc3lIaForYk5TUEM3RTcyTFpo?=
 =?utf-8?B?ZEdFM1pQcmxZZC9zUjFONlMvbWkxQnc0MWQ3T0N5bS9GQW9kR0V6bTByK2Zj?=
 =?utf-8?B?YWJ3NFZabndlVkd2UjBvM0xTbFlJWEp0UTJ4eFcxS3hLdjZsMUFwaTliNHI5?=
 =?utf-8?B?Y1RLc3c5TWhnc1dDa2dabVRMRmZ5aUhvTGJrQm4rbVJSZ1hMdFdYZkpJZnlL?=
 =?utf-8?B?SWVUd0Myc3lNNmNZVGtTYU1XR3psSERuckwxcmZPUXpML2cyVlBYWU5CS0sw?=
 =?utf-8?B?N2lRSSthT29JbDlzNUFTbUE3U0FwWUthdUxyMnNlSEQ4UFJUVy9oTWZacEFS?=
 =?utf-8?Q?xPeEcNKHLNpaDCf+3f0A08J3e?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3d84b9-d65d-4602-d53b-08dad6ce7481
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 14:39:03.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cP0fX49ZAsw6M2Exmo3k0OtkfMnUL+d0tzeneuYK6R3fQjkyw3qiKckFtc94BE96fq7+JxaCBQKBlw9xIsy2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5611
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-05 at 10:59:06 +0100, Vincent Guittot wrote:
> On Mon, 5 Dec 2022 at 09:39, Chen Yu <yu.c.chen@intel.com> wrote:
> >
> > Hi Joel,
> > On 2022-12-03 at 10:35:46 -0500, Joel Fernandes wrote:
> > >
> > >
> > > > On Dec 3, 2022, at 2:50 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > ﻿Hi Honglei,
> > > >> On 2022-12-02 at 15:44:18 +0800, Honglei Wang wrote:
> > > >>
> > > >>
> > > >>> On 2022/12/1 16:44, Chen Yu wrote:
> > > >>> Introduce short-duration task checks, as there is requirement
> > > >>> to leverage this attribute for better task placement.
> > > >>>
> > > >>> There are several choices of metrics that could be used to
> > > >>> indicate if a task is a short-duration task.
> > > >>>
> > > >>> At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> > > >>> could be used to measure the task duration. However, the
> > > >>> history long past was factored too heavily in such a formula.
> > > >>> Ideally, the old activity should decay and not affect
> > > >>> the current status too much.
> > > >>>
> > > >>> Although something based on PELT could be used, se.util_avg might
> > > >>> not be appropriate to describe the task duration:
> > > >>> 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
> > > >>>    one CPU, both p1 and p2 have a short duration, but the util_avg
> > > >>>    can be up to 50%.
> > > >>> 2. Suppose a task lasting less than 4ms is regarded as a short task.
> > > >>>    If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
> > > >>>    short-duration task. However, PELT would decay p3's accumulated
> > > >>>    running time from 6ms to 3ms, because 32ms is the half-life in PELT.
> > > >>>    As a result, p3 would be incorrectly treated as a short task.
> > > >>>
> > > >>> It was found that there was once a similar feature to track the
> > > >>> duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> > > >>> new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> > > >>> was reverted because it was an experiment. So pick the patch up
> > > >>> again, by recording the average duration when a task voluntarily
> > > >>> switches out. Introduce SIS_SHORT to control this strategy.
> > > >>>
> > > >>> The threshold of short duration reuses sysctl_sched_min_granularity,
> > > >>> so it can be tuned by the user. Ideally there should be a dedicated
> > > >>> parameter for the threshold, but that might introduce complexity.
> > > >>>
> > > >>> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > > >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > >>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > >>> ---
> > > >>>  include/linux/sched.h   |  4 ++++
> > > >>>  kernel/sched/core.c     |  2 ++
> > > >>>  kernel/sched/fair.c     | 17 +++++++++++++++++
> > > >>>  kernel/sched/features.h |  1 +
> > > >>>  4 files changed, 24 insertions(+)
> > > >>>
> > > >>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > >>> index ffb6eb55cd13..64b7acb77a11 100644
> > > >>> --- a/include/linux/sched.h
> > > >>> +++ b/include/linux/sched.h
> > > >>> @@ -558,6 +558,10 @@ struct sched_entity {
> > > >>>      u64                nr_migrations;
> > > >>> +    u64                prev_sum_exec_runtime_vol;
> > > >>> +    /* average duration of a task */
> > > >>> +    u64                dur_avg;
> > > >>> +
> > > >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> > > >>>      int                depth;
> > > >>>      struct sched_entity        *parent;
> > > >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > >>> index daff72f00385..c5202f1be3f7 100644
> > > >>> --- a/kernel/sched/core.c
> > > >>> +++ b/kernel/sched/core.c
> > > >>> @@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> > > >>>      p->se.prev_sum_exec_runtime    = 0;
> > > >>>      p->se.nr_migrations        = 0;
> > > >>>      p->se.vruntime            = 0;
> > > >>> +    p->se.dur_avg            = 0;
> > > >>> +    p->se.prev_sum_exec_runtime_vol    = 0;
> > > >>>      INIT_LIST_HEAD(&p->se.group_node);
> > > >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> > > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > >>> index e4a0b8bd941c..a4b314b664f8 100644
> > > >>> --- a/kernel/sched/fair.c
> > > >>> +++ b/kernel/sched/fair.c
> > > >>> @@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
> > > >>>      return 1;
> > > >>>  }
> > > >>> +/*
> > > >>> + * If a task switches in and then voluntarily relinquishes the
> > > >>> + * CPU quickly, it is regarded as a short duration task.
> > > >>> + */
> > > >>> +static inline int is_short_task(struct task_struct *p)
> > > >>> +{
> > > >>> +    return sched_feat(SIS_SHORT) &&
> > > >>> +        (p->se.dur_avg <= sysctl_sched_min_granularity);
> > > >>> +}
> > > >>> +
> > > >>
> > > >> Hi Yu,
> > > >>
> > > >> I still have a bit concern about the sysctl_sched_min_granularity stuff..
> > > >> This grab can be set to different value which will impact the action of this
> > > >> patch and make things not totally under control.
> > >
> > > There are already ways to misconfigure sched sysctl to make bad/weird things happen.
> > >
> > > >> Not sure if we can add a new grab for this.. The test result shows good
> > > >> improvement for short task, and with this grab, admins will be able to
> > > >> custom the system base on their own 'short task' view.
> > > >>
> > > > It would be ideal to have a dedicated parameter to tweak this. For example,
> > > > something under /sys/kernel/debug/sched/, and initilized to sysctl_sched_min_granularity
> > > > by default.
> > >
> > > It would be nice to not have to introduce a new knob for this. IMO, min_granularity is reasonable.
> > >
> > OK, got it, thanks for the suggestion.
> 
> Sorry for the late answer.
> We don't want to add more dedicated knobs. So using
> sysctl_sched_min_granularity as you are doing in this patch looks ok
>
I see, thanks Vincent.

thanks,
Chenyu 
> >
> > thanks,
> > Chenyu
