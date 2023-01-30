Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD56680EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbjA3NQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjA3NQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:16:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDC11E8D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675084561; x=1706620561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cFbbbgkWE3e3ZRkUlNiZIrwM8FnIWYk2e4ebcwuzbBo=;
  b=kilDBvhtykADb6hf0HvNHyY+AjifUR6X7ApB98jqz2wsnkH+iW69qlDL
   pab06emNxfRAhd9Wvqi+wA5vUH4xy8BZeXWQVGQv+e7bWHDqTZjeRUQOU
   l/6LMN6/0YoZsgBCq5SVAzTVHHJbFU+x4nH9Hq89bF7zofuuBluhQ18Nf
   kKXq9OtZvlWI4c2vwbhJ55Z0P1E3N5Cs3mwJZs5x6/BNJcHsDvYmNqU7G
   NUL32Frp9eS5lTXQIlgU1EyDLcMsLbYC4VBd7pYP+0AVVXiTOXVWB46n1
   kAkiumXHUqcl/cf+vzErhtED85CzGJiACLt0AgydtAQds2NDSszXHcIRz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="329666812"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="329666812"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:16:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="752816001"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="752816001"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2023 05:16:00 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 05:16:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 05:16:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 05:15:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LR/8+LAnaYlJtKeHPsbS7Kw8ETxf5cPmlelWmNsnfbc7eb/wNoyDPojuqSy/DmKFcn08PAyOuILp7gGhqwbBz/Dy5Zpf49d63+C+ebpexfyOZ+7rBPIZIBngoyLRRFJn9g+8v9SL/00L2pTH/jPLkWZhWXuiilh5wXeeK4WkNLAdikEq1FcFymk9XgyFsN3T8ayofYPhzwTK8fquAzbNqRcIH/NKje2xvDLmqA8FEVQa7qO12rZWZFVDJjeHD+46p7f8dC/rA9s4vO2vFMdN5MPfnEfS/xQgF4p6XJCubUFlz2VKKH/a6OKUiHjtin/7sQVObw+a1dA7UIyFHsIQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvwataMCrNQpRHWE6Yck7ZIhx3D7xy15xJuHme229fM=;
 b=RwqJAhy/A1izR/NDHYNN4AK/J3HHJ+B4y0nhMqqxKOmKRzqdHEJrJYZQcnbCZqbPCmbdbSq4uSryuCPKTpc3GvHOWQYge6Yhx8Xfc8j01vWI6VK998yWgQD2xMVXiZN5v2Ci2f1pNqkK/Y9o3GDDgcYBY1XhcF4GuiIPcy8btVlagxwu3cnerLGuzTxid+TW5BWyXHpnD5/E0kK90Vh4MdnWe/ou5E0LxhthPDiLYV3U6fO7413xJgrdm9Ov89jdRXVqx5fxLelL81RKWyq3N4d5pyTLkFBzF3Y03dsjwHkg409vQmXrL1kH7X+y783hcAsWEVgHsizkj6PgTJZyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by BN9PR11MB5529.namprd11.prod.outlook.com (2603:10b6:408:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 13:15:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 13:15:55 +0000
Date:   Mon, 30 Jan 2023 21:15:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, Roman Kagan <rkagan@amazon.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mel Gorman" <mgorman@suse.de>, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: sanitize vruntime of entity being placed
Message-ID: <Y9fC+W8eah73WWP8@chenyu5-mobl1>
References: <20230127163230.3339408-1-rkagan@amazon.de>
 <Y9Va5HJgEDteceg3@chenyu5-mobl1>
 <8a2e400f-868c-1d98-3c9b-de2e0d41f55c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a2e400f-868c-1d98-3c9b-de2e0d41f55c@huawei.com>
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|BN9PR11MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: 019abb89-a927-4efc-4998-08db02c41eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MwZyML6W3M+cz+6dbQuQTSc29riaphHL1b7LU5Cah3So1AgFlzxXcxauZRQA+5X57/7rB2pZfIpOUftYh3htfZvlV7TTq54kqMQpeN9Gstqy8gAHzTT5bcpMhjgtN3DksGNHKIvJm/xEB5EnsLOSWyn0qpo0ffiV8pROnML7lHvUl3UA6X6Cu3dBV8tDPdtRJB5a65qi4a9luyjjfXmKQXjsahmGDNY9OrWWClaXFdeI2g7k6HHKB8Diox1zB8l4KGI7xEoKnFkLQQdM6mPpSvbfFOW1wBOml/JjJUo/AbK+MNuHLOLv78oDY1eX9uaS/YBu7sLnVHawXJN2LTxI2SFPcfT453hXoaBT//U2GZKZ9Yo2Hy7G5cg3O2YJly6jSW9H4xEAZ2M5duoOnFru7B9Q4tlc6sdDPDqjqvq3xKCJB0jgs0psIDFvDHgLBNVz/a0T3VjvCfcK4dB5PWl3152Rx3q9P2f21TE1fAJuzmPz3Ki37FZ12vvx/6fYy9D705pSDO469m/4iQtoqg4BfY+TsM6365j3wtlH7Ks6MfVuupxn5bl3vxafnQ1KNZ8lLuOjA8KHME6ld9D6b4StyYRFVauQhWZZvqXfPXsUpI9fo8/5yFud8xIGxQsm4vCoa7LCQSJ8nIMah0aoR+G7Wie1Exep+08MD2ZTQ8C2S2FPoITtry5rBzIuCYDTAJr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(136003)(366004)(39850400004)(396003)(451199018)(86362001)(38100700002)(82960400001)(5660300002)(8936002)(54906003)(66946007)(66476007)(316002)(6916009)(4326008)(8676002)(66556008)(2906002)(4744005)(7416002)(83380400001)(6486002)(478600001)(41300700001)(53546011)(26005)(6506007)(186003)(6512007)(9686003)(6666004)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?giJYGs7E3LFGucErGa8eKrpCo9D4VE53AOdvC+iUgQpoeAQ119xZAM7ZN/nP?=
 =?us-ascii?Q?RyDL85dytA//ogC70/vKi/3sP90bp6qtre0UhbCIViKUutnm8p1RSbCVnVZz?=
 =?us-ascii?Q?t1UcudkWsIAgqiaeW/N1pwOghS/F0OirPCS9HY50I0WhNXy8T+1oYXdsIrKF?=
 =?us-ascii?Q?Uok04pkM5b5IpRYnAe6Bzs1Zfj9F1FW6d7QxhTT33B2EiKYnKVoiTy88HP+k?=
 =?us-ascii?Q?ZmQf2IZ5A2Y2uerROolG01dHayjZe7Bk5Yi2NOK3QXMNt6M2CsSS5B0L9s2o?=
 =?us-ascii?Q?jJMwZxTbXiG+ylyC6+eMD6xI7E4Ae5wIXhNMN0WG37U7hdOk4fOfuksPHhJh?=
 =?us-ascii?Q?ie3DtTmtvnRp6Ltpz4qQJSHgIJfJCvspLsz+cTrE5VSiX12ECkdmGTjHRZn7?=
 =?us-ascii?Q?UEsjC1sgCztru6nq4tA/wMrRpBCm/JtaHmwStK8JW/YUeP6hlsAgvw9g4HSf?=
 =?us-ascii?Q?My5p6SY+wV1Z1H9O7GoK67HruhFze+jdkqEx5nQRq0jfZyfxdvx5GP9JFrEk?=
 =?us-ascii?Q?mYd2fJzekJ+H2ToLdkqe0mfTWOYd3O4d/bGVLXzdtY/XRZwyRt1N9Dr0q7D7?=
 =?us-ascii?Q?6qm3znuX10m+QiCceQH3lrYfUjtP3q1sDapuOHQ9q0AJd0w5hoPFAY0k9KjA?=
 =?us-ascii?Q?j4NJjqnBzAmVSUSt1Vefx/1RKAhShRcHvzrLKkgfoCmr6xmaTYctDn7y067e?=
 =?us-ascii?Q?VxPEaxJFDcfcn4qBGcXQi0G6b6BMOp7xN6r9WiV4kZXGt86MSfeoksXwQBtE?=
 =?us-ascii?Q?B/CshGBhqtYyAjnCW8rbGOIgn47I7HwUaj4q1MLYDn32GVshhUTCnOeG1Py+?=
 =?us-ascii?Q?4dAqtvSGvrW5nAN6CC/1t+hXlSC7YbbR/DRjMvw0KdLETcaa/UTjBXgrPQcs?=
 =?us-ascii?Q?gjaQIpAs88kShdeS44FllOOq1DTg6XkH8q3r2hdfIg/PF35QWaDOhkUg2V+F?=
 =?us-ascii?Q?8b8UKUVZWQQU851fTJNCqFHxkQJD3218TzCE/a5Qy/FSdX0uV738w6tUedWV?=
 =?us-ascii?Q?v6QMsGTy87swo3Vhk64QOEZStvbxib3Uekp9FLqZ3DmS7FxbYq4JqakzyBkt?=
 =?us-ascii?Q?tF+HCLG5uYdFqPC79j49RFPKdR9qxEQXfwwhQemfblTRtZ14tuYlvK3k2gE/?=
 =?us-ascii?Q?uMq6i+/MI1HNaHcibMMNXiuKKVrvQxXDQorGayxrluZHFpPk9w/1NbQ6DUTH?=
 =?us-ascii?Q?IC14UXFryujElYZ9ca+KYHgRncuDQOzl+6iJk5yXwCTM0l0uUSRzV8O0bObT?=
 =?us-ascii?Q?QhnuALjpegRK9RpXQ37508WvoYZtjJv704G9zXYaedYbAqpbkGbb0LCChAvO?=
 =?us-ascii?Q?H+gN9yJVsUx2YKprNjBpvks2BkPKPD7r/rQvI/YiS0a25Z7cgWe5fdYQw539?=
 =?us-ascii?Q?KsbxWWIodhjZlN9j2+IN6x5sck2zuaJAicI5YGXE3WvQ/RUn2GV+EJefh9dK?=
 =?us-ascii?Q?720AkkVZJaHOY+Gs1JtYUjDIEUeiDB0yFGs+d4xrH4dmJorom4SRmEgKXVkQ?=
 =?us-ascii?Q?ntPKPT/Wq/cGCnG7OSE/0EGDlhbVD35ElS6VvasoHGUgvfZ9tr5ANe9rvqPZ?=
 =?us-ascii?Q?f+h5YmcL3R4I8OrNRd5ikOiaCVxJDWmh0PWLdMZU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 019abb89-a927-4efc-4998-08db02c41eb0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:15:55.8690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jJokLRmnU/eCPDPqJCvf5WzE9bcSJmorQw7dBR5LFWYjnCbI2Wpk+EXqcCE+LPjTXCDg3Yl/PhF+qrh8AzEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-29 at 09:27:07 +0800, Zhang Qiao wrote:
> Hi, Chenyu,
> 
> On 2023/1/29 1:27, Chen Yu wrote:
> > Hi Roman, Qiao,
> > On 2023-01-27 at 17:32:30 +0100, Roman Kagan wrote:
> >> From: Zhang Qiao <zhangqiao22@huawei.com>
[snip]
> > If I understand correctly, se->exec_start is just updated by enqueue_entity()->update_curr(cfs_rq),
> 
> When a task go to sleep, se->exec_start will update at dequeue_entity()->update_curr(cfs_rq).
> And enqueue_entity()->update_curr(cfs_rq) just update current se.
>
You are right. update_curr(cfs_rq) only updates the current running one and the se
has not been queued yet.

thanks,
Chenyu 
