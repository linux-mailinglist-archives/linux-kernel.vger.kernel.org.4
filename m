Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417D56D3E76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjDCHyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjDCHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:54:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FC4C1B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680508464; x=1712044464;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wi+ekCdG8L5w7J41Wz6+pnRjrrNihTiKDRkYXIxBC2E=;
  b=hDkVbyB0E8nTmjk70+3NZbxTnDSfsAJqVRHQiXFzKEuMWN1SC3oJjBWz
   8vrAGFwqfTqvp5KuogZh02MDw3AsGEs+zVUgkKyFIX1/KWiw55jLWF+3I
   BpFL9WlcBKYWKZGSowfAV2cYUxe0cZzxntWktmzUKU8Stmzuw8HTKNFcS
   UbaCcJ3UOm/qMoZsA3kEsmhyXyjpCc9ej4jVc2m//t5XilJIWJPCe+Jfa
   xkHhiUF8/zFwzyP8eaIE40p7KFVtLKUUf/hiwCYdXagGBjKL2ovooCIk3
   Xt/Zy/ex6Kx2m1GG4rnExkIfQWprEmyCclFE/N/wj3E3liOolJzdb7prg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="343529595"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="343529595"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 00:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="775087705"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="775087705"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 00:54:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 00:54:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 00:54:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 00:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp1HBgsXW8tuig5H9hAJA3ULWJ7i+rjzKbs0ujL0MvDfvsvvpkAiPuI4XpjKAn3I3JYSfgb+dAjee8tGjhk7NO+RAtIRMiV4qjhUYSa1pcwnCti9MHOkfz1CQVGLzPDU3GDmIzHI7w189LJ3g0KsjTROwwFbOPq1uAMEL/dpKf6rzkJPwh7INims+S88QuEGbKYsBtYl8PhmeOvUV4TR52X7p2NKtubwhz5Sk4wXzghBUCBceOlZneT3g188laoxoZCG0pdQlztRu99B/TQiWBv7u8k5qQBO8addXoYoNUuzzcGC48YUX5qZkcSbF2suIQxYxlibtiWWIj7WkOxoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz+oER+PuGB8J2b/ZBl+WHuNS9U0qX4MwYts0Y/gg8A=;
 b=Qma6+W5c7g1/umLtMcHZTcwAoLAjLgCIz1Rxmbzm/fjTNcWNqPNGZdzQoIsGgUEB3JqK+ET7DYvWQW8DS2KirvCrDwdPjNfLiVp9IqQyk6zW/3VpOB2EhBOKtjoxCyCp2SgvaOe4+y9rFp5tVjlJDTRCe8IfeaDwwv/Epkhl6tUfSKLQxTdQGi39rgcp7Y4jV/w2vMrIbM0QNb9zQOwdzgKmT6ys28Nn1lj6aJo45PkbjTo1hHvsETtTzXcl5tQbkp+yhV1XWBS3DnqPtVlFS6WAYuzwmjP74eLGeq+CPnUOCEXHq4hgLtUDjkSq8pqCo6gd8NER1I1Dmc/CgkzLcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB4998.namprd11.prod.outlook.com (2603:10b6:510:32::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:53:58 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::78d1:41fe:eae2:1f6d%7]) with mapi id 15.20.6254.028; Mon, 3 Apr 2023
 07:53:58 +0000
Date:   Mon, 3 Apr 2023 15:53:48 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230403075348.GA4021@ziqianlu-desk2>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230330195157.afbqtusnnbnvtlyz@parnassus.localdomain>
 <20230331040609.GA184843@ziqianlu-desk2>
 <7360f190-784c-8e49-7b3c-bea28e0456d9@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7360f190-784c-8e49-7b3c-bea28e0456d9@arm.com>
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH0PR11MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: 2197eaa1-a24d-4925-610d-08db34189490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ox4Oo0X2osaWRrmFtCDhHzhqXyIptaK6z7Uuoxeupp1hS/E3036uYCvFj/mNFp6vFr3zLd1YUpC6tsNcT+VEgyJ+UBdJ0uzprA3xTXKk1AYiJOw2D7bpiP15ent7d1hX/BiDcz/UwtHl/5pslMOUE7GzlALNbQWTY7Idb15h64mAC7MlsHQIrdmVdyqUA/0kFmnh/sBIj0hl1FNeIWT8QWNd1fm0eeSFJSgY3C+JugLqUflo/9Sz+k3Dd4mU7x1cZtx1QhvDItHvIRibDTqu1p2weCyp9HPMIoasig/G0srahkEk4icn7xLBiUDnkKBGGoMp8SIQcFoEuEmx+nByydm7xxILPptnY/LzLfGdlnwxG4Pv651MnX9N2mAmjivZn9KGbtoAq0VQsQeI3F+xO8z1fsu13LNMX2hJUekIYK75H0WrIHRfaDw/DfXLFSprCL5oMW9Yk2XctakvZFz4C4x0T0vk+EH0A3WqPzJ95B6yvrybWKAhnEUFZul0H/0TBB/JGoNDigY4XRcBjMrPODG/dAJfsBYp6pFcWuT2EhrDzj68lPuYeSJvNrnYG8bPr07kCQ1fzZrRN8jITBbE8tOJ5HzI2HhIxKBb1gGwqdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(86362001)(33656002)(33716001)(2906002)(53546011)(186003)(6512007)(6506007)(1076003)(26005)(6486002)(6666004)(9686003)(6916009)(4326008)(8676002)(478600001)(66556008)(66946007)(66476007)(41300700001)(82960400001)(7416002)(38100700002)(5660300002)(54906003)(316002)(44832011)(8936002)(383094006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rfUuTjzn6EZfbuEvLoyEpT4+pPxtaG6HJ9oSwieIQIlDpiMa5G1G0R7d9PRp?=
 =?us-ascii?Q?1oLWLhZpiQmBzsaGRwrj01oAljoRo/ouFwyUSnyNTT8oh4sRs4e99gYXPv0x?=
 =?us-ascii?Q?xanbt0FXj1TGvA3stJfc+FShANDxSZbum23yn8d5Y96TsFvGvvJrxf4P+I0d?=
 =?us-ascii?Q?ZEbm6OBvh5aOpj0BQc7V1ytZRhoPZaAnEG7e7xmhpAgyUmQC6XFnivBwVdxy?=
 =?us-ascii?Q?liHSS+XsDQo0TNmxU+nOz2nphn5ewc6EZaz812vKkNbjMK2CkMMQkwv6b3df?=
 =?us-ascii?Q?RQmDt5D7umGlJhLOQqnCkAyqFdp/ga+S3Gu6jfpEGq+SN4w6HrZBm7onq+US?=
 =?us-ascii?Q?vjd+OKfW9Co9Dm3y5EZDmuShHPQbaR5dBuEe1IFGsifQjh1GMlpoxfk8sheO?=
 =?us-ascii?Q?gTvvn8AOD7zVXsF/MNlc4dEuURlEe6Bjnz8UjJLR2ROtIHaObHOPwaBNS/ST?=
 =?us-ascii?Q?3nDXkd2yO6pnV8fsTb1r86UeiblR5COqGFgTnFdmcxsxZxCF4ijij6XqYIiP?=
 =?us-ascii?Q?MJThhID0tXRDdohEnpMO6F8MWtBNV6FC5q20XqIPkYHzO2w4rMAqKqk4oupB?=
 =?us-ascii?Q?EWPkGEaKfxzIKCrKv8Yk+zbqixSNZ4JZ7/zNao5JiCRUJFvk3yr4cO8V/Pod?=
 =?us-ascii?Q?pKjtzi2QJ0gY+kDjCzIL24S6GTfwkMEfejjTEOz0y7kWMzKDRUPBEQbSCL7r?=
 =?us-ascii?Q?5RxjdbEYXxwdv3MliFmtC54VX2CRYCOC6/vvlroJWmCNRK57gh8JVEB6Di2v?=
 =?us-ascii?Q?o6lue1OecG6aXxf4O3R9MNfzb59+p/N2VkgpaMPaMmP/0+JFLqUVm/qy9zlq?=
 =?us-ascii?Q?HKYDiBF0eW6EpELqVEjMHrfhKClsVgSV/UGz9jbLT3ZR1e7jhf5McWrlHB91?=
 =?us-ascii?Q?lD5eBqI7joocT783v8Qn7d9yzzX0l8voqfntFHCxlKUjlJjy44LBRuY1bdTI?=
 =?us-ascii?Q?N0TmnQ5NIqSVbXu/OYwKVdr+GTkcl6b3O0h/frWEtIEV+3EoCNdf+Go10hBX?=
 =?us-ascii?Q?pxU4lMz6LIuBaOoy3wh0LmWSh2/gpVKQlaajjCdQqyBwhvou2Uvl9c2LXtaP?=
 =?us-ascii?Q?aElCoqFygAss7vlhb18qnUByfyTLFurVZlOU6UWbV7vzmWzxtZv9edkU2UPn?=
 =?us-ascii?Q?wUdQ6ISIvqzxre673fIZJESi/RqsFqXGACR2mXO/Uz92Qgvsrrfc3jRRSHQb?=
 =?us-ascii?Q?1+b7z5gzSDCKSMNDdJFKERmiv7FaCuBRGbffe8LZ1ZPT2HFztfgkPC2DacuV?=
 =?us-ascii?Q?pOoWjQbO1nriNgYnSH4+07Fz+m7ttcCnRTErDSh2SJ417gbF5mNoyQuoe0iq?=
 =?us-ascii?Q?dTIVHg2hPa6KlhgvTcsjZ+Cv4ucZ1VFtZ405aZddxomQK9hODWnSCjf/5pBP?=
 =?us-ascii?Q?XuUjL6Edmt3ilGEx/QFas+zw5tJHqkXGDJN5UEx0cjZ2SUxB12RMLLJJpn86?=
 =?us-ascii?Q?GR7wNceO60klezhplfirtKlISMoGhcwnXmzQQ7oinZPnzWVAGbdL1uy7FywP?=
 =?us-ascii?Q?m786pyr7yZOpSU7xrli6TcaKU0NfrlguVekUOpqgC1BOF1Vm1R9Zqh8Qzgv+?=
 =?us-ascii?Q?WQGRP4mdn6O0JWvbLt/JFvPZ7QHI8FptkVNMNFqc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2197eaa1-a24d-4925-610d-08db34189490
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:53:58.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36oXHgG8i/xVFVSbQF2rXdklPoNxY9X5jgZYaXiF7R46XWATQ4Aoj76VHZyJB4T3XjDNJj6Kxva7LCw0GEjLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4998
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 05:48:12PM +0200, Dietmar Eggemann wrote:
> On 31/03/2023 06:06, Aaron Lu wrote:
> > Hi Daniel,
> > 
> > Thanks for taking a look.
> > 
> > On Thu, Mar 30, 2023 at 03:51:57PM -0400, Daniel Jordan wrote:
> >> On Thu, Mar 30, 2023 at 01:46:02PM -0400, Daniel Jordan wrote:
> >>> Hi Aaron,
> >>>
> >>> On Wed, Mar 29, 2023 at 09:54:55PM +0800, Aaron Lu wrote:
> >>>> On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
> >>>>> On 28/03/2023 14:56, Aaron Lu wrote:
> >>>>>> On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> >>>>>>> On 27/03/2023 07:39, Aaron Lu wrote:
> 
> [...]
> 
> >>> AMD EPYC 7J13 64-Core Processor
> >>>     2 sockets * 64 cores * 2 threads = 256 CPUs
> > 
> > I have a vague memory AMD machine has a smaller LLC and cpus belonging
> > to the same LLC is also not many, 8-16?
> > 
> > I tend to think cpu number of LLC play a role here since that's the
> > domain where idle cpu is searched on task wake up time.
> > 
> >>>
> >>> sysbench: nr_threads=256
> >>>
> >>> All observability data was taken at one minute in and using one tool at
> >>> a time.
> >>>
> >>>     @migrations[1]: 1113
> >>>     @migrations[0]: 6152
> >>>     @wakeups[1]: 8871744
> >>>     @wakeups[0]: 9773321
> 
> Just a thought: Could the different behaviour come from different
> CPU numbering schemes (consecutive/alternate)?

Yeah they are indeed different, I also attached mine below. But I didn't
see a relationship between migration frequency and CPU numbering schemes,
maybe I missed something?

> 
> (1) My Arm server:
> 
> numactl -H
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
> node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> 
> 
> (2) Intel(R) Xeon(R) Silver 4314
> 
> $ numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62
> node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63
> 
> [...]

Machine I'm testing on:
Intel (R) Xeon (R) CPU Max 9480

$ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167
node 0 size: 257686 MB
node 0 free: 251453 MB
node 1 cpus: 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
node 1 size: 258009 MB
node 1 free: 247905 MB
node distances:
node   0   1
  0:  10  26
  1:  26  10
