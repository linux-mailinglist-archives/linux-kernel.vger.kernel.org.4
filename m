Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFA66B54C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjAPBoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAPBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:44:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FC4493
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673833440; x=1705369440;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x4kruhGAg3+7dVCV0PoGDHYgvc4H1J4E0ZOPXGLWNIs=;
  b=ixouXeuHOW/oasgALh6tBlXJyRmGABAGPl2Txq70Y7+JzURlT3ZyB/Q2
   f0PQxupBpCAi1My2z5aP1XaktTZV4PLqO0QCdegn+2U456D1KcO00pav7
   R86UNOBLdY16JefpwCY2gzjT4GhRkrt8wzv2W2XiLfIgwu7H2Reaet9xw
   uRW2Ha/j0tEkq5xZSbBTmQ69xQky9oVWVPu9nEyjAmL8+pFoqkM6AGSQO
   yZZuT60adUk1+Q/P43J5pwAc1s6jjIAG6pIy/jOfi8kE/asfmeQq98Q5f
   4gHOinPXj+vpxyxBQrhqWJXasi7GAeuzEzO/Xx6XGCdld3i0wSi7RyanA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326423728"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="326423728"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 17:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="801225807"
X-IronPort-AV: E=Sophos;i="5.97,219,1669104000"; 
   d="scan'208";a="801225807"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2023 17:43:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 15 Jan 2023 17:43:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 15 Jan 2023 17:43:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 15 Jan 2023 17:43:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1zF+L3ylB8wqEU9+atOCdpyFXSlQRJgSiCvpR0VRHkMXMeRMgQilmsZAfvIPWwiqWThNPfKGbVZcGa9os94M/K0Ty0Glqc+G6DPV0ZMPcVu9CtWkWuyNYcAldoOrdMcdq7f8KHVKFtIoB5xwCOzNXIrZHhdc04qw1JkbAWHh/syrZuBcmojUzABi54TDyaZOrOV/p0CA+pLXor1EZtpcP/V7jNuZ/yfhAckmhh8rGYPLMfNEqR84qy54/BgZt9zFSwQyCteNf3kaqfaIapSuu6hTyoFsNlalhSHEERtFlC0xOqImvHbFtse3TuN4xeKcWijfod/L++4Jy5DTiU9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXfM4J8RYTLV+Gwqicrw4QPc9rD+2CIXeLl6SV0UIWs=;
 b=CJDnJuGpEZDZccXXt6Ef4pBAh5R//TSdhWWfTVjRzQ7bPL0svJXmIHKXpOV6ZnPg7/HNnBVfNR9rX1Bqrgpr8pkioVgWLXUBabhKTr1SC1NEdnDxEmm43MQx29+ui9RbSapAuSvCpRW6F0SiXp2CDal9eh5kKB7ciRaHgtiuhkEzhmNIT/Ci1Yh/jj2bK7NpFsD8ylorWK0UyvlfBEpC6gH+tj2xUu+YDWG5QX6G5cForBf9O3AMzppaP7UvO3vXjvSi+f7iL7jC92Ef9Fh3Pi7fAs9idbc8gdtV7dBnACRALzfkyq/QKa+OudNF+tnPM+4yMzO4estOevrhsv96Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5053.namprd11.prod.outlook.com (2603:10b6:a03:2af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 01:43:56 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5986.021; Mon, 16 Jan 2023
 01:43:56 +0000
Date:   Mon, 16 Jan 2023 09:43:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Joe Mario" <jmario@redhat.com>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Message-ID: <Y8Sryq96epb17Dkj@chenyu5-mobl1>
References: <20230112162426.217522-1-bristot@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230112162426.217522-1-bristot@kernel.org>
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c2b141-0124-4c4d-563b-08daf7632187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaO58OJFtDogLPUqfC1GokfoLxQxtnvIXeoZ+joylTZKk4dfi303DZb+VtQ78cIJPOwyr46xq7/qQGcnLJzuomQ5PGHC0m2ymKr63eNyacodEtoRyAf/ukjlyohwO4CdOAR/n4jMVsBo6U9k5j/srwIWvW9QGA16IyI5y2mu+TeW9DXVI1nS2t3e5rKZpkVtxGvU/LVF8gFBq9eyTsLVfAcyZ/dL3Cym5xwFN/+FZNnYqKVF2hBmeloZ8Jswwr5xhAUGoGr7MPKs1nwkETCkGwroK1jDLUTj99qKlNLDj6uUpBNYhU3JZbSPq4QidbgxLrZlNPFFwW90r2CR4UB8dAsC4kUuRgtp00thn1i5U0Y4tmMtqKZM3WUbdTKYeIDsZ/O3rfp0zG3reQxmKXYET4mIEtzs+uS7pcM/JaUQ3eJ12w75HkeyBL1jWRDiWkSfhFUfkHet++eP36WoTB4b4rbken8xxIG9bTExJyf/EjSkdK2uGyaWgWD87y4jFORoaWur4TfCD77rTZxfj7+0xs9lRBuxCE6ztdAt3WGUD8zNpgUQYCkUWphbLCTSWtjtX0/p9FRC5xAxnqEzHO1leN3uDqgmON5X7HpDv47CXEXGKJcUT60yYhNPzIbjGWqaxNEiMGoKhKcXo6/7f2HgYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(33716001)(53546011)(66556008)(66946007)(41300700001)(66476007)(6512007)(9686003)(26005)(186003)(8676002)(6916009)(4326008)(86362001)(83380400001)(5660300002)(82960400001)(8936002)(54906003)(6486002)(478600001)(6506007)(316002)(6666004)(7416002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aR+jFr4rLJ9/HQDJ5x3kXyNn15Oc3FL8OuwuZPzTkxfg8J/kLuzQGGiW4F4v?=
 =?us-ascii?Q?hAOcygtdUaQ4dNk/QXVJ4UuengITcqdvcGa0hC1JOO7HsEDxDJZjfwRJoV6I?=
 =?us-ascii?Q?rKMqdwGDCpKNP7jmKSud4H6Gyit56JTdsfmgqUg3Ktuxhu/38/e/ndwM0YYt?=
 =?us-ascii?Q?Ro4BdnodYjbaw86PtgPybjy9t/ctg84aMLch4sloFpJh9cfbC+KlLN4Q57uR?=
 =?us-ascii?Q?Bcww8Pz3UeynANq0Hb1vaX2B6wd5z11zBPwzzR0DvtUyukdfrbVwk8gsvZEN?=
 =?us-ascii?Q?Pwhdzbq8ZNxJ1eGNhcKDv1cpbW51HpI90DAoArdYlLob5BZ0ULEPxIs18GAo?=
 =?us-ascii?Q?IX5Lvk4Rk5UkoUatzRtUOZDIZ57+9vAraWav7rwOScIlqiiWg0nYqLgTt3Vf?=
 =?us-ascii?Q?rUNLYoIUPd2vIYZBWR6/S0QJTzN7s/A7C0DkiPA9OGLHrunmRby6dAy7bF85?=
 =?us-ascii?Q?UQwiWppVPImkS2QoXgP9d/WSvd7XL+wnAqU+mwcMURJZgzpzmkl2WlCvRqep?=
 =?us-ascii?Q?yY+fH9ygFVved8srSFp2zcOH497bGUPjjYIfoj8Qq8pVxVbxOdq96M4hpzf1?=
 =?us-ascii?Q?lneJSD9A8Qy9HBSMepsjrEPtwMKwsBohLFQN9SFu/n1egwpJK0OV6TGG7kMa?=
 =?us-ascii?Q?MzBbSfN1GprJ4N4F+4QsyzhdVW0XOEIihbrC7Dq5n40dWHm9vYeGbzXo/jmU?=
 =?us-ascii?Q?kSZOlL+OGVzHk/maT+7c9ltLGqPS79FGa2YkpgJ9kWHZd9ehvYSE12rgh+nl?=
 =?us-ascii?Q?QOmHgzXST7Tbjlj8A9prkuwtx8cmdPvnlMQIAYqP0stg4+XMey71blaB1g47?=
 =?us-ascii?Q?9+1GDwJ02xDAMt02wpvDTi1aQB/7cBLPzRFtxYulDwGdojxxszOyJ/tosUVc?=
 =?us-ascii?Q?zZ3JEbh7ZMXqWRznD4Rn/Egxuhx3G2qiMJalynvc4stsF2L/I5rrXfI4mVcl?=
 =?us-ascii?Q?WQXSehD5aDeNmQat/K4DFsizyi+8FElnC01ikIjiPqF12Tu2S17YVOQHjoGy?=
 =?us-ascii?Q?10azFd7rBOMTR0hg08zThlNiAnhXQk9CXEtJsTVae/Lm0BkIyR6h24pZtG23?=
 =?us-ascii?Q?YcXnDwIVGnCcEVrhY67HKK2Yt0TbZsKbo2w81sey6pFfmkQXPWYcGiQu43FA?=
 =?us-ascii?Q?qpU13w80CYJ8EX2ja5ec/92m9gF6vccBg3yQG0AV0jGSfzJeQefWypQrVjny?=
 =?us-ascii?Q?UySJS7IEdcZb2UXPOj/4jb5/M/50YLBUWxnsWPnrm4qgqN7tOXfnD1H8Bv7x?=
 =?us-ascii?Q?U+R2f2wxtHkdhKYKaC5UjChmOutviQdqW5OmeUfPBY2usty17TINSBLbhsuD?=
 =?us-ascii?Q?5VTKZYetjwr5zTVara3ailDqYVDZPN0UEHn3ejJA2jY5mSGjtZRbEZtfZ8Ey?=
 =?us-ascii?Q?2Szr5rlxunM6ekUEMscS95aOlgkVKN3juGQ/I3ahA8Rw25fem7JckJh7UNia?=
 =?us-ascii?Q?C/2uH/uXxjCECK6RNiekYpk5E8UIoB3OwdyDXABj0QhK1OOctGSJQ7CjgSrb?=
 =?us-ascii?Q?WypvoZiRULGULouUEw41ui2R8NpULGoOwUSGMU2TYLkhxhcXuVSYuMrbTgSH?=
 =?us-ascii?Q?br7KBDs1DMEfwgNNlhkzi0jlhVVd+zpVZXcbNpl5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c2b141-0124-4c4d-563b-08daf7632187
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 01:43:56.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MADrAFPzAzjd7LVJ0qE0L5YmGxttXGu0wBY997pIAvo94W/AGynkNUzX1vshwobJKG35WblsUoHrAlol9M/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On 2023-01-12 at 17:24:26 +0100, Daniel Bristot de Oliveira wrote:
> idle=poll is frequently used on ultra-low-latency systems. Examples of
> such systems are high-performance trading and 5G NVRAM. The performance
> gain is given by avoiding the idle driver machinery and by keeping the
> CPU is always in an active state - avoiding (odd) hardware heuristics that
> are out of the control of the OS.
> 
> Currently, idle=poll is an all-or-nothing static option defined at
> boot time. The motivation for creating this option dynamic and per-cpu
> are two:
> 
>   1) Reduce the power usage/heat by allowing only selected CPUs to
>      do idle polling;
>   2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
>      polling only when ultra-low-latency applications are present
>      on specific CPUs.
> 
> Joe Mario did some experiments with this option enabled, and the results
> were significant. For example, by using dynamic idle polling on
> selected CPUs, cyclictest performance is optimal (like when using
> idle=poll), but cpu power consumption drops from 381 to 233 watts.
> 
> Also, limiting idle=poll to the set of CPUs that benefits from
> it allows other CPUs to benefit from frequency boosts. Joe also
> shows that the results can be in the order of 80nsec round trip
> improvement when system-wide idle=poll was not used.
> 
> The user can enable idle polling with this command:
>   # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
> 
> And disable it via:
>   # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll
>
Maybe I understood it incorrectly, is above command intended to
put specific CPU only in poll mode? Can the c-state sysfs
do this?

grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name 
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C1E
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C6

grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/disable
/sys/devices/system/cpu/cpu0/cpuidle/state0/disable:0
/sys/devices/system/cpu/cpu0/cpuidle/state1/disable:1
/sys/devices/system/cpu/cpu0/cpuidle/state2/disable:1
/sys/devices/system/cpu/cpu0/cpuidle/state3/disable:1
 
thanks,
Chenyu
