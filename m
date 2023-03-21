Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAE6C3386
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCUN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCUN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:58:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD3DFF02
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679407121; x=1710943121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eclb9MokytA5J/aBzbHWkfy0h/oiLP+fJReG4bNRl4E=;
  b=kBgQvq+FOCl9TrCVUVgdXleBeBcCLbU9xT855JYHpRKpuflG3MfdpBXJ
   iYvwSouDbQE+1AHCzhGDLkGW+ppWrnDrcjnX6FDkv35sqPkLN1+nqznio
   oJgTrmlsRm0v8DiepFI+sXyWQqYua8XqmMTjTolrw2NyniKZpzsjuM2Ym
   PjDg/7XaCVw441mZu74Wu0iRu0XMiBhUq0YBFLL2oFEdOUln16odXC2fr
   RHYJwnJFrdHrFOaZ40IXcGZbG974IsyHs/4U93RxfuLoF5/sd5KyQNyOn
   siPADDDAUBeJCBNbDC1JUMRx/MtOAKI4OMlgioP9/IRFq/aBIiJNLfo9k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="327320840"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="327320840"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="674845672"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="674845672"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2023 06:58:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 06:58:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 06:58:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 06:58:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EA40/llpNwmHIZvaj+ytkykbBuOVXW5xyQiBahRGLmx6k63YJJV7OMqbg5IBSccdfgxHsXUUi6lNaZDi+o2CPVEKJY6q6bZ33lqKQ/0jfYPWD5qQl0Tt4chrFcXzSB5idjy2B62LaLahLSK+4Mjgs0+uG3Rrs1GkkSfjXFbzAA1arH3PPhW3S1DpCpJQSIVGJUHObzKIrp2X7isw9lBy1LQGMRW69uUsj5LhUf/oomFULg1cNegKMURoJQXbg09jTtPh8llHJnuy6I2uBjrVMFFDwxba17YYcl/EGcuXbPvBWqfHuETnEh+3262NWOmi4mYLxoOoMJddSIakcoE8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7o2DWCQ+8C+7qzdQGmkB/bexINoCDSJn5aEdkSvpFU=;
 b=hXgVk3PZte5pxukI0pNMqErmVVN6ugMxXV9ugcpLuimgopr7utzedjwjoSgzgn0tHICzYpVDry/4fAyqtdNdCjzVSLtV9pBziuR5pXpKEBpX2WW+Q6zITR0OA6+KkzkVySkmoriEM70IhLSH67lNyu+LuSVCKLHHUnI/KR1l0ZxZsSaTBIejb1h4AmMjyCy1J6f+swg+hfPRBuvkBdCCytRcB7D+T2UYlPJd0QvLhEZdlg+UWfO56+dH+pXH/nJTcY+QwOGHY2iCP2lva622mHkRJS1w5R6lHg3Y6hpSHG2GRmL/hra50U5+n0B5/kfU4A9JDZ9ODkaf2BeXIiKAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB7549.namprd11.prod.outlook.com (2603:10b6:510:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:58:36 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:58:36 +0000
Date:   Tue, 21 Mar 2023 21:58:13 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mingo@kernel.org>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <corbet@lwn.net>, <qyousef@layalina.io>, <chris.hyser@oracle.com>,
        <patrick.bellasi@matbug.net>, <pjt@google.com>, <pavel@ucw.cz>,
        <qperret@google.com>, <tim.c.chen@linux.intel.com>,
        <joshdon@google.com>, <timj@gnu.org>, <kprateek.nayak@amd.com>,
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>
Subject: Re: [PATCH 06/10] sched/fair: Add avg_vruntime
Message-ID: <ZBm39VNJCwioq+V4@chenyu5-mobl1>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.569748782@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230306141502.569748782@infradead.org>
X-ClientProxiedBy: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a3a5a3-2abe-42b0-bd48-08db2a145d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTNy+IrsVqS3wNm5M+/txeHx2W3FdFeTsxvkT5kyYIj4cSaJohoAYq0woO9qi9lFgJZj+O3vHH1/0zzlLbWEJ5hELlQbv4XcHamyWumE+EBJZ8cRZOX5nmqguvo3dWhDOK6cXHOGHOWfFQRpj1RE4vbMjN3IRwd5SvwMk+vKdaU35MX+N1N1G5OjRGEq5YLaFdTQVsK/uC6HyiYBYNrYNOFTr+3j7sDYdae/flVz/9BsWH/g1eK1NLTIyg9rd5LiXYBhbZTZgXfkycsAhNVHZRYN/ldkIfOyrphU3Z0HvYcMPaNEt+qU8Mk0wVZRbQzUMHYgse4uoxrlQh1khfZ6D7Wf1eaa4pPb/BiZtBKVj0jHsWxZ/l6HF5iij3woRaAA1Ht+igQztTD46R6kF7m26luI2ePvSzcaM5cNP+AjW6470ZM7YD020EdLIdaFik8TTH3ofQVGqTzt5MzknOVEWotGEkQC9lTVdCcPkIoGiP1xQMcZ1o4fQtShxBL/QpntObTAk3Pr6tX1kO/G9umaPRjL2810XDTX/svbYOyasb/MuZtPs4S+2jbIiW2/AYjQpYpHrowyXRxqA5J1GG8ryIRAh1rCnSEbQreIfdzj3HBxo9bjuCzPxQtkJ/7SLDyPig1FfZeauPpL7dTuJQO5hlYvD//UtAyMxiNr1J2lbwSQblih7E90ydZlvyCq6Z+i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199018)(6506007)(6666004)(82960400001)(6486002)(26005)(6512007)(9686003)(53546011)(33716001)(186003)(86362001)(38100700002)(2906002)(478600001)(316002)(8676002)(4326008)(8936002)(6916009)(41300700001)(66476007)(7416002)(66556008)(5660300002)(66946007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xe7B8M3nDl04BIuj8h5nu3ztmSFORc035J2CLONy0gxAAIumkEJUYu9G9u0S?=
 =?us-ascii?Q?Jzc17L5POMSoQ58jRPI/0mrpfNGvQfZ4EYIrVcKqoO8bSZr+KX48p/1b/fLj?=
 =?us-ascii?Q?/716C/QJh4o1YZjjNR9jAIhhbaylBe4rPF4QI+Ps3khQYDPPe5s6yARAP7oP?=
 =?us-ascii?Q?23Jrvnh6ybirDlUJBFFrJpikWGIN9OnBDGk4MaVRAqbrknVDD+vtKPn9TTNI?=
 =?us-ascii?Q?F5OPM4AILYoxIlSOFlCg6aYX7zj4Wv4LcAN7egfdL5hA1X4QxIQeuY5b42M7?=
 =?us-ascii?Q?hH2nIq5wx3w4fA8pzdaQkfMBtRgwQm/7iCORNDG6FHgH+AnwSl5iYb1PD0Uu?=
 =?us-ascii?Q?SDj6HOQ8SVjlMGXCXJGu1/eJWr9YR9Xhx4wpjbo3tNtyjG3lLEovBxUp5L0i?=
 =?us-ascii?Q?xDJHch3knkgCa14/1e49qeG3GnzwLYuB1P8Y6RZ5aNHwbuL51AJPRCPdpiyO?=
 =?us-ascii?Q?k9oyc0GdMBSizTveTk1s/fNWCCLqIG6dhiqW/TQmHJqfHHBs5yJwxO3ZEfm1?=
 =?us-ascii?Q?kxKncfPgc0rcDoLuitooG7tj2gFTEOrLTgIrqRFLbz6L9k3qWQ/1aRVEVr/F?=
 =?us-ascii?Q?h05+0b/yCwJD9z8gI+kHtQrbQ8EZKsV8X888QMwmc9nLMG70I9WLPfz3Yoi9?=
 =?us-ascii?Q?X0eHxR5aOGueUlqAmPHTmkGJpU/6mBPcJRoJcZ9E3J4iadwPPZTPMK6qeybX?=
 =?us-ascii?Q?ijl3NXsDBJCA3g5DbmVeAktWlTajzoDBGETDSLIOg68Xua35bU0UujvNu8bX?=
 =?us-ascii?Q?NpRm2p+ziowfRzvOG1DeHcfGZFxiWTCdadCRx/760qtgtTIJdmgb5PnCivVN?=
 =?us-ascii?Q?g+Mq7pFCQVBTtmQDjxVJnMys9NfAUcA9pSG7ucLVjHnOnqAHpYzP2YVzC38c?=
 =?us-ascii?Q?xln7Il+rnYiiJQJIJZ4aO0wn24pQM8rP7cTfYVAKoCLmeIUtVkmndaH0aXYd?=
 =?us-ascii?Q?mYJiwxvSqFoQhTebgRM7Q747ZjppgkPiG2qyqKvjz2TtfQuzD5nZxtlCdCh2?=
 =?us-ascii?Q?tSnk2+WX0UdBoVMt518E+gzdzx4h9k9Uvxq86T8BupXf7u7G2XyI1EXEM/gs?=
 =?us-ascii?Q?890HRsuxmNAwpsqnQpxYlBlCOvYzpdlGQkwbzfHvjuPs77K2s5B/fIjEroLy?=
 =?us-ascii?Q?ze1XQC024NKItr/AeoWF3RJ+GIUbqJ6zWVISXsxT6NF0Z8fUHdQb9Cyr7dmB?=
 =?us-ascii?Q?u2bivgSa6F6GdIDR/NfEPNnmdrf+WyWoj4JCciPFGIyHQpOfvoz+mtMtoGWI?=
 =?us-ascii?Q?FPVGnRupMIw912SIEXRRjl/mktuT2BjbswIBEzjmKTUDzwfprnjYgJjEH5J9?=
 =?us-ascii?Q?L/iNLzuDtz82Y/eIf1qKHLidHGjTBnqN6siaEuYKHfA9Xu3dAFEJ7SjV3wwp?=
 =?us-ascii?Q?T4fZbUhzL6NxJxJX3v16AcUrE6ZwuqZSMKhpYXnu7TeFACwiZGRmZIQKim5h?=
 =?us-ascii?Q?kckMziH/I+IA2tbq0WEvDWHwqJ3Rm4j2kw/RCH8fMPUDspBlQ64GXIRnLLPc?=
 =?us-ascii?Q?4EpQ/1tmNyDm3uulAuF7Zu6IEYOb8ktZqiNabvkYxJ4gOm7PojRLS9MxJfmv?=
 =?us-ascii?Q?nasIhp8cRBcmnS0/NLV25eN+/wq2KmnFsEqdXGOu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a3a5a3-2abe-42b0-bd48-08db2a145d5d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:58:36.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIlvSHS+P4fMVMkeLXBRz4VFdejAHZqM9InCg4mDyZUBMRczLEms4XrMzBGTy4TjFoq+nq6/U48uV1nHK1MAIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-06 at 14:25:27 +0100, Peter Zijlstra wrote:
[...]
>  
> +/*
> + * Compute virtual time from the per-task service numbers:
> + *
> + * Fair schedulers conserve lag: \Sum lag_i = 0
> + *
> + * lag_i = S - s_i = w_i * (V - v_i)
> + *
The definination of above lag_i seems to be inconsistent with the defininatin
of se->lag in PATCH 8. Maybe rename lag_i to something other to avoid confusion?
> + * \Sum lag_i = 0 -> \Sum w_i * (V - v_i) = V * \Sum w_i - \Sum w_i * v_i = 0
> + *
> + * From which we solve V:
> + *
> + *     \Sum v_i * w_i
> + * V = --------------
> + *        \Sum w_i
> + *
> + * However, since v_i is u64, and the multiplcation could easily overflow
> + * transform it into a relative form that uses smaller quantities:
> + *
> + * Substitute: v_i == (v_i - v) + v
> + *
> + *     \Sum ((v_i - v) + v) * w_i   \Sum (v_i - v) * w_i
> + * V = -------------------------- = -------------------- + v
> + *              \Sum w_i                   \Sum w_i
> + *
> + *
Not sure if I understand it correctly, does it mean  (v_i - v) * w_i will not
overflow? If the weight of task is 15 (nice 19), then if v_i - v > (S64_MAX / 15)
it gets overflow. Is it possible that v_i is much larger than cfs_rq->min_vruntime
in this case?

thanks,
Chenyu
