Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BC6E1183
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDMP4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDMP4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:56:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D3B45C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681401387; x=1712937387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qHMJombTuoDqyPWEYCTSFxFfETWwSmWafHGVB71ti34=;
  b=Xqq9gxjQ0z+lh5cOcrGABiqwtfLG3NasAqHLON7Ls2otFYTVkPqqhBfn
   iNyDq0wl66vb964y2dh7oyaTY24hcVZ/6VcB8lqmbpEFOuNd4Uaqi3LoP
   ZPwmaaLJo/7oldBFSQfrkXVPevx8sHoVTEm0a3o/qTrOQPolwWnTcsQL+
   ZUmC5C3B6QeGo+kcuL2HH4GkGxGL1ijn581OL/S0E/pUxRPRIHwSZwxAJ
   S4MZk7wSzv/4+2CUrEl1P4xadRT2feTbe3gSUq8q25i/45rADH1BnaO2C
   cWQdfSLHYplAhwzhoIKZ58vAtu+PUHeiVT0aJWfwn+i4pAqqC9c+MLEbk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346927980"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="346927980"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 08:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="1019233599"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="1019233599"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2023 08:55:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 08:55:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 08:55:53 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 08:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahUmjdyeId4DHQUzbG7TV3/Y6Yl8jwiHkdVKkgx/rGXl46dXvlByDOiesPY2Ez/MXsLI9L8BgljOxGbRGyF+0nf8sZxbFbZm/WN71uG2saW74tONeWll7iKgz46UEA/3dqBXqyPmDtsmLZZtcNi1lg3HUf6bDUGF4L2pw77BLQGNw7CyPqMaCNs/DJQr4r5NXCavLQX2cUeGidFYUEj8y05zKSSPLjRPGAYsgmm4l8VE84niOzCAmIICV/WIS4QZRf9IG8FkR6VhME4cC2U3B/5zOtplPfEOyy5F2fGVEopwT4RE9a26+VgA7RuvKY/HVX7ncOwL/Kavjzk/J6NdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX82raGvCEuYL7V3z6y0TA8l4nmJiBrlCVtotY3j1Kk=;
 b=Vuaz0MeGub2nmwtBSPICuWJG/3YXAOR7S9HW2eezLzBMYTTCw/7KmmiJx1seCyDsxq8tcORIScNtM0k78ER/IQxzVW3wXQTgInSkkwits6m7ze/41ofd9yzfuI+06KUVbW2WMnfZWHRMF3Zw+WhXSyBsTx2cYtws5UoRMaONM1TwTuHiFcdYSaFMMRBgGjJ5WMTBEaoIzIYsyLHD0p+o7CH9E388T5HOswp3IoEpRC8nt0SRNxIbL8xnjzwkZ9EI3DFUO1Zz37YFEDPBCl6ianZk709mWSRWXG5lqLhjOZ19mB0wYDqSP/RcT6t/BVZRLKQ76QtwjzVcED/whkxWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB8037.namprd11.prod.outlook.com (2603:10b6:510:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 15:55:51 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 15:55:51 +0000
Date:   Thu, 13 Apr 2023 23:55:31 +0800
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
        <youssefesmat@chromium.org>, <joel@joelfernandes.org>,
        <efault@gmx.de>
Subject: Re: [PATCH 06/17] sched/fair: Add lag based placement
Message-ID: <ZDgl8ytUD1IE8OKU@chenyu5-mobl1>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.988000317@infradead.org>
 <ZCqZzp98q806qfip@chenyu5-mobl1>
 <20230405094720.GA4253@hirez.programming.kicks-ass.net>
 <ZDgi6g4hRYCfbxcu@chenyu5-mobl1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDgi6g4hRYCfbxcu@chenyu5-mobl1>
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH8PR11MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2a555d-0e52-4484-7f6d-08db3c378dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA4+i8Bd1LxzHkNV+57nmiZnMSHMY1XiMHrSt2ign19i+r7h7mYLKpQOti1mxD6sv/oVc12AXzzs3HBN92Di1/192QcdhB8lssXha/uENqQLw1dkhOk6opRJqw/9fJQgUOoU0fH4Vy3afii9euG7PYY3owZ54BT5e7DmH007oDO2bGQMYNnPWQ2tzTp2sCVMt0jJgdC0j7/gOXXFCsD8yVChDrhwHF3NpYzoq4yEizP1CJndu+TKYXXjHe+yf7T944VDWJE8jOoABRwzKOHugYc8HJpWcY4KzijjcHFuQt9HLMNQ3wPjEwuWgLGb+JTkxa14B5R96TTOm/2JHDk9xppKBv1Ez9Xhv6u4baJt5F2mSxcYVAjx9kJH7NbhigIktHviyOwwFYFF/AlnLZPDGh7Gq5qTO/irfyZtKPxONuKVXJprCUK6phtK/xFnTJth1spIPiS/CzqvphJSEM2o+bS/KVHlLNaFcpzjm4JeQSKbtiehfpj+JZaIfuXhGpatUvDoJAKjEdoVxA5nv+gbo65Jen2xpzCJUggrExBLReyyVHt706R1mbOhL7rUVxU8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(8676002)(66476007)(66946007)(478600001)(66556008)(6916009)(4326008)(6486002)(41300700001)(316002)(38100700002)(86362001)(53546011)(83380400001)(9686003)(26005)(6506007)(6512007)(6666004)(2906002)(7416002)(4744005)(33716001)(5660300002)(82960400001)(186003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9c4YgviB1RTBVsPvBrCR1NXABnmlYgJcVoBEHGpQku5z88BYjFfYBeW/L6f?=
 =?us-ascii?Q?ypf9hAkDSxSfi/YwR2H/JQsfBntuBjFFX/nhRZxyiEccqGF3PEOtSSr6A+Q8?=
 =?us-ascii?Q?5wZvTgDZo7aySVPypwkaKjLumEdjOnJm1r6qMO+HjpmjRvRA9osyebfQxu1X?=
 =?us-ascii?Q?sMafURTyzHxt0LACk+W3FNoOp19enyWbo/wXqaA+iogFikwfd9/gRj2WOlOE?=
 =?us-ascii?Q?z6MWLLOCFc8a4rZQ1YOZzkdW8zItEYMsAQfoDky7nyubpG8gW9fU3pTGMGo6?=
 =?us-ascii?Q?czCVxLZNAdBrxY+0QwZv8r+fwkb/mCojvMUKTjaZTXDupXPn34QTowEnlUWO?=
 =?us-ascii?Q?Ft/xWrjFF0CAtZLwQC0QrOHFWYcbpaurayBxbN/r+0PYyQJCzz2Xv1yrjDXK?=
 =?us-ascii?Q?uETK7qI1Fbb+FPB+y0nrz2cMU93lZlHzG2DsHxGQiuOwr6fwiJx9QiaZX47/?=
 =?us-ascii?Q?YGSbovnvrfVy7d1bLfZ0aouBaTLkIRvY/cNRffflk3+E0k38pjJ8blVPejFC?=
 =?us-ascii?Q?Ixzr8FiBx61btcOv51MjU/8CyZQPbWK8O4GYfrpJY+rMuM5OIoWFYnAUyW+4?=
 =?us-ascii?Q?P/tMbqbv/azeeMwouIj1GG70POtLJ23Yrl7iISAx7Kombn6/UaUGsqfm3LlT?=
 =?us-ascii?Q?cvjyvGs4mFviL5yxLirpXDRItPeB5psO7tmEMaDZuppoV0GqnBvqAGUxQIMv?=
 =?us-ascii?Q?U5l0qU4eNCs/qittn8o9Ks/9zLi20CzSMNdpAcunqOwhRCfonFpZ851vbXgq?=
 =?us-ascii?Q?aSBXc9SEb9mTw0esjZwr2wXI/XPvqW/QWFwWX1xZLEYP/ke7GFsRy+w0MaDX?=
 =?us-ascii?Q?cJojtMamB/iUF61qj+fwfVxp/xx3vp/yElrmYzFAuMvjMPwbgPtg2YiVPfOX?=
 =?us-ascii?Q?5vFgCoZXyLFfqe3qnkT4gNU9M6WKIDdxNDFolNiOjrnUiiv5cxS2Gsd+1sej?=
 =?us-ascii?Q?/BscH/sm0KvYhHXEKW3fq32mntJF4numl/MmCylEnQq3YLhXhL/MgbgU4Wc/?=
 =?us-ascii?Q?nIX0EZbhTX8UuHOOTXYuledSQKsmGNau5ZWf1m4JILWOhU3qxtRxV4c5Sa+i?=
 =?us-ascii?Q?blGeKciYHxUUUMrn+Mbrd6zFvHpIb4S3h7ReMjVh21xpBvIddRTUzsg9BMy5?=
 =?us-ascii?Q?h04aE6XxESQk19ptVgdQMPNB8Ln9fzdVhbLsfH6DBnOlTxxN7/i521Xw2rw0?=
 =?us-ascii?Q?e4gY7SWYwu43VJ2Yx2Ncq/O41cpT4UX6NHbi55QfA5MLSu4tvtdN0fZinAWr?=
 =?us-ascii?Q?8Ajy4HwnP+QEpTRlfY0cz5XqXtJhayxONCjjawQzwsD1miwL1PXvDlsPI1of?=
 =?us-ascii?Q?MBYIOOmxsxOYIu5ttac+oSd8LASlEMBxAfSQXPSGw2wKtBcf0NClVTM3lAWw?=
 =?us-ascii?Q?Zy3BlYquwjA/pKv5ZA5F0llR7o5cK0qLNbsVE8qFaVSjucB1DZD3HnbZQk3B?=
 =?us-ascii?Q?mcFWmUN+qXeTriVwYf9KbBHnn6fOx6hqt3dPUhC4RqKWJAOUrcwnkxZI0xYq?=
 =?us-ascii?Q?EpZDUGgu5WC9VVjwqx8fhItrlt/p/mifpfiw8mkxqz6RWx2WCp9Z3LBK+LjB?=
 =?us-ascii?Q?f+BPU9j27291jUvCMT4yIReF6HbIhbnhDwe8AdKx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2a555d-0e52-4484-7f6d-08db3c378dfb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:55:50.8274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVkRlh3KqLQVzHkpWn2JCaN989m9U4rRok0NA+g5VUot2+/23xPAij0VcF7m5WeQLdZVPlma6FYpKS11bCPTOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8037
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-13 at 23:42:34 +0800, Chen Yu wrote:
> On 2023-04-05 at 11:47:20 +0200, Peter Zijlstra wrote:
> > On Mon, Apr 03, 2023 at 05:18:06PM +0800, Chen Yu wrote:
> > > On 2023-03-28 at 11:26:28 +0200, Peter Zijlstra wrote:
> So I launched the test on another platform with more CPUs,
> 
> baseline: 6.3-rc6
> 
> compare:  sched/eevdf branch on top of commit 8c59a975d5ee ("sched/eevdf: Debug / validation crud")
> Chenyu
I realized that you have pushed some changes to eevdf branch yesterday, so the test was
actually tested on top of this commit I pulled 1 week ago:
commit 4f58ee3ba245ff97a075b17b454256f9c4d769c4 ("sched/eevdf: Debug / validation crud")

thanks,
Chenyu
