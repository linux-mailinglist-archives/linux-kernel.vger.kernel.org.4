Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F66424D2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiLEIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLEIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:39:24 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62159DFCA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229563; x=1701765563;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wG2mRVQ4VaRV8blKuzkRDZPKizNZzzr8+UMYEnZmWcI=;
  b=nOIPJBeCWhUB6Dfs2zjxyDjfX4wZopmqFedJuaQsS2k8ESio6wRNVgIL
   D2CDFMannGBucrQJFfjwqdXshKAbIss1AwaPDZv5AVBsfKMvM7B7VRpVc
   ZIjb6yLZmZMqxzCbossNkpMdmT7EU06Nh8CzXh/HQq0pRdmnXT6yHgaXC
   aw0JgwcljAmL9Gpge9adr8w8LSR/AyFZM3XHpC/B2ZFB6j17ZEKiFPzIj
   xOsmwJ6VULtC1uEfw6iVrwuSisCaxL9EmgTXU/8boCb50rfdWyQhOb0zX
   ScLfoAWXD/2aDbNUeihC72L5VPvovurMm8EnGMv+bCIZNadSJoOCfHXFg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="295995758"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="295995758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:39:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="787995930"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="787995930"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2022 00:39:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 00:39:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 00:39:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 00:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ/KbcNrZZC0jCgnIhZagYITuZIaH/UAD7Tkzzl660tnLT2uHbo3KfqESZLA2clXfNITbX+5d20edivPSFp0Qn/ceCI/GIZs2dnGpNuqB5ganX5EbgOh7vFAlZkPtoJmPDzHctwXaFaV/ef+4DFZeaE7oMl0r9SZa3pgbZ7CHbWGaOJzZ+Mey9m/v5eIb96SWXaS9nYWJIOr36s5Namyk3VuKc9R3SQPLbv7a7Fpav5G461sgX5uYt3Rw1l8H2yaZJOZtnY1XQ8CnW9bs88SS77Ow05XvBCZvX4mr/HY1rlSXDodjnukra0gE+WccIg3ry3Ctqs3snFb2EBluPsRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irsoSH9Dc07EthIsx+JhyZZ2meJl9+GTwhiF4W3cToA=;
 b=YlkvEobNGK8kCAuuHgjQYuJE/K4U0hce4U9fpbvFM5sSX/oc6/jIjadg9nSDiIOlEbYNvBlC7jZkxHQ+doddYg778TF+BhFiYoM1ovKazhn99HpTN1czBIQkEz/cw12hHGscK491d1dVO+pA3jidyi+cY2KfhNpWpq6nqrkx/xhHnYtntQnXkxAl2y6eUwol9qLUhXjxByXA+ieNiGFpN8yqtKHvfFo3DwtlVoGaRksjOeFPvbdWoWgJn+PBLpzVk6zRfGh6/3YxYqtAA3/8MfaB/vVZDbVb0usgOdTSsHojmoJySZMYb9pAJwy8gdFXL/TUQJ9w95FXeGRurQh1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 08:39:18 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::828c:e5f0:6f82:63b7%8]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 08:39:18 +0000
Date:   Mon, 5 Dec 2022 16:38:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <Y42uH5fglluWYOm7@chenyu5-mobl1>
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1>
 <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0dde48-9259-4ad4-a0e8-08dad69c3248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jX1P9jys4M86ipuBs/J1opP8Lz7Ak+W5QXHmGJDYjT3sn9+NkAVdcTy7m+7Qowi5JnoI7LoxCxKJzhWYWIJmZGm7Grc3TyFsBNVHQhdoJghFwbc+4Dvxq4QRm+cGTUa+Jh0KSMq4iRcetPPes1Su8gNhAjZ11Qq1xHikRAMinIPwTG0uBWhdZ/a3jzIpIBAnjIdST0W2YZdgPEOyh32pwykUOXvjQ8s9A9Q7o8z9u6A+8Lol6YFSa+uhaQNaMFoQDcC6ebuCMZty3C1vrEVg0N0uT/PPzfxgJPjld9PgclBZEBBesCxnhgI2e46bMCR+f6YlqBYqCJtKe/hjMjBjZKYVXjmcoMFlbSLzo+MHKIq1a/3ybfEYrb9MaFkg+Grku0kVGMg8RyMKdnMgBKwXtyPAAvM60xui1QDuOyYOQs5wUyToLxTgCOkxZQe7ZoBB2OG/vVPVm9Oz/MVejJUvg2krODGyMHPpODx+N1uI4AQQnbhqFtMhOYUeYOp8bHaiJY2cAhMe0AdIPLFrMy55M19ETrBCtAqOU1xBu7LZIxOHwnBM9SCBZJo4NsCoORbKzigZjdOe5PWK29RLWBlrUsLdV4/CeRzO5dqfwcSswaQ6wTeSgg1MDgULdprMMPohgH6R2qQKVn1Nffr8Fm2O8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(186003)(82960400001)(5660300002)(41300700001)(8676002)(4326008)(66476007)(66556008)(66946007)(83380400001)(86362001)(478600001)(6486002)(33716001)(6666004)(6512007)(6506007)(9686003)(54906003)(26005)(6916009)(316002)(53546011)(2906002)(66899015)(38100700002)(7416002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlBNlk4OXVuYnF0dDdra3JTa3ZOeEJHenRHZFp2RzY1UHE3RWVRcXFXY2pT?=
 =?utf-8?B?aTcwdmdBTC93YS9nZzdLc0UwQ0o5dEwxaEswTGp4OElGOEhVVzhuN3NyUWEx?=
 =?utf-8?B?OEphWjBrVWU5TUxYd2lsSnpsNnhuTkdsY1JvMjkwRlJDYkRJa1dyWE8zQlZT?=
 =?utf-8?B?SlhOR3ZNV2dkK3R2Tjd1RHBPdS94NUZHSk56SnFoSUZ1bU5jQlp0elVSaTBF?=
 =?utf-8?B?SmVIZUxHT1Z5K3JjcEptN3ZTODdLRXVmM1JCa3pDand6QnhJMmtUdGp6K2VT?=
 =?utf-8?B?OWtLL09Vcitsbzk0RFdLSFpaUVh5VWNqbkZBanNiVStmVEh2RlBjTEowUTRQ?=
 =?utf-8?B?cW1TckFkZm9BeUlVRGhmUzZQKzdvM3VDdWFtYUVCS2VpR3k4NFZrUXpnSkl1?=
 =?utf-8?B?SWdtSFFHZkp3VkFxVFNPZ1BJYW5Ea2E2RC9HTnhyUzBsYytNT0V5dU5YZ2gz?=
 =?utf-8?B?ajFJdjdKUHN6WTQ5YmlUUGxBcTIrYjJMaGg4RG1HQkZ4QU55Rnl6bkhnZGhG?=
 =?utf-8?B?bU5ybTE4SCsxWnJMMlNsekEySWVWaHNVTGdYYUJ4UXJSYWpTcUwyT2Rpa0Yw?=
 =?utf-8?B?U3dmSkdPQVFlN0s2eDJIc0lTYzd0OVBTNngzM091MnJXUUJyZFF4Qzc5eU1C?=
 =?utf-8?B?QTdZVnc5ck53WjJ2am0yL2pidlYrOTFCYWFvOGFKMFdlOW5FNjVvVjMxSWVD?=
 =?utf-8?B?Ym9CSS9xNTlaRC9ESHFNajl6emhtVTRvbzBDR2llMksvNDhJRXA3OWVqQ1l6?=
 =?utf-8?B?dEdNeUpjWXlDMytOenk4VExDWlpyTzZmT3MyVTRNeCtNTktibW1pdjVieklJ?=
 =?utf-8?B?aFNwamx1SjcrMWpveFdZdEMvTEpiR2llZitmNVk2eGFvNHREYzFTTERXWDVV?=
 =?utf-8?B?K3FDelh2WnZlYWl4YW1RMkVrS09sTjR1dHFGQ2dOeGdCNU0wUGVrTEtrQTlN?=
 =?utf-8?B?OXVOeXhubW01c25MeFdkaDdQZE5TVjRiRDlkZk1Ed2JWaWFGN29SNGtVK2dX?=
 =?utf-8?B?d2tPd0gvOUFuMkJXbjBuRzU4TDlBUHhTZ0Y2SUwrNGJ3UXR5MnN3UlFXbG1l?=
 =?utf-8?B?MkZXMjMzT0pwU3RPaS94VFo5WndqR1pjbzNBTHBSOXBHZWtWU2NzUTlDL2lp?=
 =?utf-8?B?K3oyZmFVQ3IrUjNSNEw1emtaM2thVjd2aFhieHdyS2R1MnJmN1NtZDVJdjdD?=
 =?utf-8?B?OHlXTGl1WmNWTTlnRUp3MnRtWWRuSytxUlNUYVB5bVNwUXE4YlJXUU5BK3d1?=
 =?utf-8?B?eXRmWDVTYkZkQnJiWnVVS3lFalRBNkk1UzRRL0ZTeUtNTURxTllFUlhud0RO?=
 =?utf-8?B?VzYwaXk5UzJIYmU1SFZOY3JqS09wWStYV2xVWG1jenJLVC9vN0dZaDVlZzNq?=
 =?utf-8?B?ZUVyK0IxUGpyZFpva2svbWVxSDVjcytLY2N0NkJMdy9SaXhZNVNQRmp5MUpk?=
 =?utf-8?B?M0tWdE1LVklzNE9nbDlVam85NTNxam16akdOSE4vMDJuUDlHUXhlVFpTRzkr?=
 =?utf-8?B?U1M5cnI2NmpNZ1ZiRllpc3NBN3A2RWlEeWhzL05sYnNZVWF6UEtKUVNSaEE2?=
 =?utf-8?B?Nnp4WFRNbXhRSTRRZTlqckJDNnREVG5VQTEwcy9qT1RKTzRDM3l6WWxCUDRu?=
 =?utf-8?B?QzlBT2QzekxZNHlHY2MvZFNNQU5mYTAwTlRNckVxekJkTVZZUWFORlpKMkc1?=
 =?utf-8?B?cEp4SnFGR0tzcXUxY2FCbTl2ZmJIU0VhSTBBNEthTXZKdVZ1V3B5Y2VmZGt1?=
 =?utf-8?B?V3FNN1BDUTEraGVXS0pVSk1NM25aTEJrc3dvdjQyQ3FHbGlxWFUwTS9GUmlH?=
 =?utf-8?B?K05VT2FMTVJ4U3VaM3BMS2dOOFA5aldzTFh5ajR0ZmZxNnZKbWVZSThqYlNY?=
 =?utf-8?B?a0xKeWxsODdMWnNESUh3T2kwYjVYSFQ2cThScWo4VGVQQzUrK2hWbkJRODhL?=
 =?utf-8?B?dVBXeDZMRlFRd2wrb3NCM2pnOXZyOHUxR0JTMGFMTEhlcEREeDhlWThPdkF3?=
 =?utf-8?B?ZU5hTzRNY3FYVHNud3B0UWxVS2Z3QzJaT3N5UFZ2REZ0MTk2T2UyajYwMWow?=
 =?utf-8?B?YkdaY1cwcUtocFM0blpJbjh2NTNDQVRCTm9vLzQxUTdaYjhpSUpNUEt4WDVX?=
 =?utf-8?Q?oGgTieTtwVKyJYQs8hCbGcQmU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0dde48-9259-4ad4-a0e8-08dad69c3248
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 08:39:18.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVHebHrZLYNClvaTOna9NsiPjBCBmo3UHLrpwwkP5Z80uyUq+eQlk7CH2srPTbVgCVzKOPC7+ZtmTDjMZEXjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,
On 2022-12-03 at 10:35:46 -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 3, 2022, at 2:50 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> > 
> > ﻿Hi Honglei,
> >> On 2022-12-02 at 15:44:18 +0800, Honglei Wang wrote:
> >> 
> >> 
> >>> On 2022/12/1 16:44, Chen Yu wrote:
> >>> Introduce short-duration task checks, as there is requirement
> >>> to leverage this attribute for better task placement.
> >>> 
> >>> There are several choices of metrics that could be used to
> >>> indicate if a task is a short-duration task.
> >>> 
> >>> At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> >>> could be used to measure the task duration. However, the
> >>> history long past was factored too heavily in such a formula.
> >>> Ideally, the old activity should decay and not affect
> >>> the current status too much.
> >>> 
> >>> Although something based on PELT could be used, se.util_avg might
> >>> not be appropriate to describe the task duration:
> >>> 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
> >>>    one CPU, both p1 and p2 have a short duration, but the util_avg
> >>>    can be up to 50%.
> >>> 2. Suppose a task lasting less than 4ms is regarded as a short task.
> >>>    If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
> >>>    short-duration task. However, PELT would decay p3's accumulated
> >>>    running time from 6ms to 3ms, because 32ms is the half-life in PELT.
> >>>    As a result, p3 would be incorrectly treated as a short task.
> >>> 
> >>> It was found that there was once a similar feature to track the
> >>> duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> >>> new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> >>> was reverted because it was an experiment. So pick the patch up
> >>> again, by recording the average duration when a task voluntarily
> >>> switches out. Introduce SIS_SHORT to control this strategy.
> >>> 
> >>> The threshold of short duration reuses sysctl_sched_min_granularity,
> >>> so it can be tuned by the user. Ideally there should be a dedicated
> >>> parameter for the threshold, but that might introduce complexity.
> >>> 
> >>> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> >>> ---
> >>>  include/linux/sched.h   |  4 ++++
> >>>  kernel/sched/core.c     |  2 ++
> >>>  kernel/sched/fair.c     | 17 +++++++++++++++++
> >>>  kernel/sched/features.h |  1 +
> >>>  4 files changed, 24 insertions(+)
> >>> 
> >>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>> index ffb6eb55cd13..64b7acb77a11 100644
> >>> --- a/include/linux/sched.h
> >>> +++ b/include/linux/sched.h
> >>> @@ -558,6 +558,10 @@ struct sched_entity {
> >>>      u64                nr_migrations;
> >>> +    u64                prev_sum_exec_runtime_vol;
> >>> +    /* average duration of a task */
> >>> +    u64                dur_avg;
> >>> +
> >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> >>>      int                depth;
> >>>      struct sched_entity        *parent;
> >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >>> index daff72f00385..c5202f1be3f7 100644
> >>> --- a/kernel/sched/core.c
> >>> +++ b/kernel/sched/core.c
> >>> @@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
> >>>      p->se.prev_sum_exec_runtime    = 0;
> >>>      p->se.nr_migrations        = 0;
> >>>      p->se.vruntime            = 0;
> >>> +    p->se.dur_avg            = 0;
> >>> +    p->se.prev_sum_exec_runtime_vol    = 0;
> >>>      INIT_LIST_HEAD(&p->se.group_node);
> >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index e4a0b8bd941c..a4b314b664f8 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
> >>>      return 1;
> >>>  }
> >>> +/*
> >>> + * If a task switches in and then voluntarily relinquishes the
> >>> + * CPU quickly, it is regarded as a short duration task.
> >>> + */
> >>> +static inline int is_short_task(struct task_struct *p)
> >>> +{
> >>> +    return sched_feat(SIS_SHORT) &&
> >>> +        (p->se.dur_avg <= sysctl_sched_min_granularity);
> >>> +}
> >>> +
> >> 
> >> Hi Yu,
> >> 
> >> I still have a bit concern about the sysctl_sched_min_granularity stuff..
> >> This grab can be set to different value which will impact the action of this
> >> patch and make things not totally under control.
> 
> There are already ways to misconfigure sched sysctl to make bad/weird things happen.
> 
> >> Not sure if we can add a new grab for this.. The test result shows good
> >> improvement for short task, and with this grab, admins will be able to
> >> custom the system base on their own 'short task' view.
> >> 
> > It would be ideal to have a dedicated parameter to tweak this. For example,
> > something under /sys/kernel/debug/sched/, and initilized to sysctl_sched_min_granularity
> > by default. 
> 
> It would be nice to not have to introduce a new knob for this. IMO, min_granularity is reasonable.
>
OK, got it, thanks for the suggestion.

thanks,
Chenyu 
