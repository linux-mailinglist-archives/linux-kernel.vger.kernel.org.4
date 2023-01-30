Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42A6803DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjA3Ch2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjA3Ch0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:37:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D181E9E8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675046245; x=1706582245;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dqlpPwxUnq3ke3QdAf1UIWlZ4qA1Vhcn8uE2qH4b6gs=;
  b=n4s92zmF3KS69K4M+dR6ZsyvQ6qo4JPWohhuVNkdLssDuif0TUaYOCeL
   NBTycLUJHylmVIhmUYWs+NEQo+/krYq70Uwd3ULKFbHGnCgEU7q3N3n+1
   j+Y35qYDbyUlVnX1AawXOD9meQhl8w8TtoDBUxyPKETfB+/C1AtUYlhZP
   mJRvd1dR2cK+r8jum9YKJ/nsspCWoLvmmLNkbi19Pg3WSoDp+2C18h9cd
   IeH4g8Ng8jNk1ReD4LYvF+QNd+ogqOOuv3eDkLZKTj7ja4afoT4eV9NK/
   OZ1YYYI+AiaInbYSaQVEY2TOud1LvTZXVHp3/cST/3Dxii2de92tR/EzV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="311080130"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="311080130"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 18:37:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="665913420"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="665913420"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jan 2023 18:37:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 29 Jan 2023 18:37:21 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 29 Jan 2023 18:37:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 29 Jan 2023 18:37:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3WR/LBkMrFcx/hxWJuSE/t66ZEDQ/XbP3+Z8cqdAV/tK12cbH924G7ANnSBPlYnOl2wTKN68ZS97+LxOw2sOM3o4UmjpYWxop1KVpa6/+pmR9pP54HHrCzl0VqqGzb9yf++mjta9rulnfyVfMf5Drp7YoH1/NGmbUqZOdCjH+wfw0libhUWUWQCio/Aa4ECETMhYNGrHA3mBQYQWq0px6v5HrxQaVRTML7IDzdOEpisw2HgZYHtyL5pIJVUa5RhgwOQQFMgcPAuSjNt0Xd+JjZYeo0xJZYRew09WqwX5C9PlHvYaErRSEUE3ec4I9YyCJrXQGBaigV9qDpP2Q5iYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T24l1kgw7np9S0+gK08j1g9/a+mF8fDTUa3WWQuY9Rk=;
 b=LH+w4g61ftLvAwIRxPADzac/sBocfIE+3WCkuH3XRwwbGyn7gBkcXzTfYlb+7KyGyY8mp3zE+dNl3GWTliCZHpUTucLA25EavvcivqHhusdIlZObkILYghslqJcvJOkogXOpUijX5By/Hrqcqpa8FopG/kbsFbuAwKarrX2JP8aeAOpN/5jmZj6nUW/p8X6uDBEFT4Ob3RT1OlBeabi/dS2AmebXbWtzpKyJbt1kdAchmShivcl+ugS1LbRvP07fJLIJSKj89CqwwopGOWDYsKER1la3ex1JP+rAN5L+n+6l4gr3dZzWvQRR1QRmffIKXvXBEG63UPF2ZniLa5ylKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 02:37:19 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%7]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 02:37:19 +0000
Date:   Mon, 30 Jan 2023 10:37:07 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linux-next:master] [mm] f1a7941243: unixbench.score -5.1%
 regression
Message-ID: <Y9ctU3HtkAC7G05Q@xsang-OptiPlex-9020>
References: <202212051324.182a6363-yujie.liu@intel.com>
 <CALvZod4CD+O7-ynGAHU-6vxE6CbSmuQei1=SVJsx0zFfQdmV2g@mail.gmail.com>
 <875yepfe4j.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yepfe4j.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SN7PR11MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 383e486e-101d-409e-cc41-08db026ae822
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1G3EVTxg3wPOqs5fCL4gg0arB/wjGS0MwUE9NGlFTzQdC/Sx6aPUG9/kfBmMr170kc0F8JPpDiIUsO0uv/np4Sbbvg4F/hX5QnyzNffckaQwCLKxUnxAGPVhSBy7l/G0MyIZI3Ktp4/R9vsfGpTkUEv8PJKbtDSgFdtipIwnF2xYaIvZ0mVYXfalkiMwnMe9COb8D+BGyuRdrdKs3PIL0799NXBkPqurLhaIhHn1ZHap1NAKT001Xr+Q++IDnPl9ljcJcPO/m60potpnsG/TAqoO87l3n18mp0NSRsGQrF2GqLiRxhEZZynVOFhDCiYnyuDwDJzTxS2XvzDPNbKopNBOfeW04DGoyXGZneZGYflVvutuqLmZiL2+1byZHHQxgt9IPMJ8XSvwo7dJy2gANE1/JChDcrLiyle7rZVC/SqgeTkj400iPgqjqGDCYDOFQ7LdQPBb0t3PxdNT+I0WqUEWcZKKtio8Qxe24Vlgm6IQKAklnsgY9CJXt9vmIt7zX4RaoYEkqjhDSjZp51zorzR64/KdGsSfd3UI38ULxTL1ctL1xzDMQDMxbUrkEO7aJjzWWNd2iISiM41qzX7/MDDpHsi0natCgoNYalxmLr/YszxkIFd9Fc3hBXbNAA5isdYjFQzerP1oMCuw+5VWpTc20lY/h+ISRMiH1EmcAxnfkF6eL4cgHNjItmpq0F4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(41300700001)(86362001)(83380400001)(82960400001)(38100700002)(316002)(54906003)(4326008)(66946007)(6916009)(66476007)(66556008)(53546011)(6506007)(6666004)(33716001)(26005)(966005)(186003)(6512007)(478600001)(6486002)(9686003)(8676002)(44832011)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJray9kYmlLeDNXaWpIM0tsU1lVNTVOQ21NbFp6UEdkY1F6cWZ1aEJaNjBU?=
 =?utf-8?B?cnBxdzNEbjhrZm5Kd1ZCQlk5VmhsUUQ1YUpzQ2VNQmdsaFE0UGQyS0JUUHAz?=
 =?utf-8?B?UHZJeUw0dHZhSFd2SjJhaFU1MEFFUS9xM2QvZEgyRUZXNnkyelp6c3c3MnZI?=
 =?utf-8?B?MUhwMFJIS0ZhWk44Ny9kbFh6TlJPUUVxbjVnTzdJRm1wK0Z0VlNzYjIrZmdr?=
 =?utf-8?B?UlBlZUpJWUhUeEdsaXM0WE92dHBBRUtnK2VmOU1wbUFGOVVReThBV2w3UXo1?=
 =?utf-8?B?M2NpeVVXbDhNM1FtMVN5bkNuVndVR1RoZTdRZXFaTW1yeEt0NHdMaUJjOTQ3?=
 =?utf-8?B?aVRuQzRycVVMZ1IzYlRNcm1lQjlYcG1JbTdUQmZsL1lKWm1FSTRLcG91NVRa?=
 =?utf-8?B?Z1hEbmJJY1ZFL0N0amNpZzF5Y2llbnNWTVprcUFzWjhGUHgxRTFmVmM5MkxU?=
 =?utf-8?B?eDUwOGNxTVZMOERiUEdsQkVQZHVDRlJ1d1N4bGltZ2xtYzJKZ1BkVXN6UGI0?=
 =?utf-8?B?MHBrT0VHM1poZ1ZQdTBXU1BiOEN0UlYvMWVuOWdweEJXRVV3eEJJdE5QNVVk?=
 =?utf-8?B?aURGOExkTkp6RG8zbVRqdUx6Y0R0dHVJSTR0MmtpaXcxL0JJZCtYV21Majho?=
 =?utf-8?B?aHAyNHNXUTBnTHhqRjhKQmgvb01HV2lrOE4vbU9RRkRlU2JQOHRaV04zb2Jj?=
 =?utf-8?B?T2tVTEZSQVdiUmZlRVFPQmhnaDhmbGx3eGdRR3gyMnMwZUVxZERvNnpIUGV0?=
 =?utf-8?B?eWZiRGVNWWlDMkZkcFlKeHhuRnV0ZEhLZXRid2JwQ2llT2hsSFpmdGY4cDlo?=
 =?utf-8?B?amgreHE1dEJuWVRmUFRRTEY4RWZZOHhxbVMxaFQwWTVKb3NmdG1WUEgvMDlV?=
 =?utf-8?B?ck80cGJpNDUySVlac2xabWl3anJPZXJYbmo3Y2pISTUwbjd2VTNkSHpJY2h3?=
 =?utf-8?B?WGJMOU9namVBVkdjMGdMSEMwSXB5R2dBUnRBS2VLMSs5a0MvRXlwSmdVNjBF?=
 =?utf-8?B?dHlsQVFEQmczRFVJbjVkTHhTYmZtQVF3RGM0RzRPZzBIU04yZ2xtTHJ1L0V2?=
 =?utf-8?B?QkVUV2VZYS9RWE5ET1IyS0lFeVM0cjluQnhtNmV0S0VHSGJIWGp5djdoalYr?=
 =?utf-8?B?S2ZLR1pYRDdKcDQ0dkdtUEk0WC9DbXFJOU16czNSS0hEY0MvbzZ3VUgxbWZI?=
 =?utf-8?B?dFVEb001WFZTcTdJWktRbmVYRlFQUjB6MWJObnF2Yk1Qc1pmRjdiandPS2Zk?=
 =?utf-8?B?RXd0UGFuZTY4bTljVHppZHpDOGFxUi9uVTZwWHlKZXR1SEhRblJPMU42cDVL?=
 =?utf-8?B?UHRIbVg3N3BJRDJjSWgxQUp0VDg0REVUTkFkYXlHQkpIRUJrRUdxc2J4YVJh?=
 =?utf-8?B?MTlYM3BJQmhzcXAySlZUZkVJNVhIbWJ5K3NzOG5vT2JHRlpOV0dTd2VRcnly?=
 =?utf-8?B?NVBGREYrVjAxLzhIc1JLZWwvWVFWU3Y2MUxyenZZNkYwMUJwcTlvZlVNQzU5?=
 =?utf-8?B?bzhuR09RQlJlT3ErU1NLaTdNWmkwYnN2Q1BjajVxUW5NZlE0aStkQUFWbi96?=
 =?utf-8?B?cmhVS01SSnZ6SnpIaTlCbjF2a3BBdSt5VURYQVhBVmhzN0VUMWNTUjMxbjNn?=
 =?utf-8?B?VWdSVWhKY1IrWS9PWmFkUlBlY3dzdVpraDZpdGRVOURDVG43NHE0V3NyeHJq?=
 =?utf-8?B?UGRPTklBNVYzb1VmbjZyeU1KSSs5TlpVRWx0OFlFeFpLRHI3WHBlbkl2RG16?=
 =?utf-8?B?YTVBZzhHVUYvSFd2dGZIYXRxcFJiODBZaW1iZktCYnM3c0lvcHVQTXVEb2ZU?=
 =?utf-8?B?ZU4xMW9lNlVCWXdnQlQrYmpYbk4yUmMzU2RrcHlERWQ2aEVyRGtOOGNxenZH?=
 =?utf-8?B?a09XRG1MTnJweG1XckUyQ2VKbE9iMjJRZjJOQ3pVcjhKODRhLzVxODVLbGhH?=
 =?utf-8?B?c1paTFN3R3o4cW5oQ2ZGZWNaZElJNFNoMUoxbERwM1YzdHNPYlhGK2M0QXlM?=
 =?utf-8?B?a3JrditUL2g0d2ZsdGVJR0VocUhwenZ4cTZadWtISWwrK1hySTRvSGJsQy9M?=
 =?utf-8?B?QXI2cERrOHB6OEl6Y2dBVmtpRmFVLzBGQU5UKzcxYlhqbm5nRjJ4NXo5VU96?=
 =?utf-8?B?ZGlkNWNzZWsyTHVNWXhBczlOekxiK3J0TEF5dld6Z3laSmEyaE95TUE2VXJj?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 383e486e-101d-409e-cc41-08db026ae822
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 02:37:18.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iECXHKB9nXyHmeebOJNVcjhn0JwOEbyrw2M1xBG0+x6flHWF8hH6dq3qmZRdjnds/pk9YCeo1s7Y4o+bCdfHWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shakeel Butt,

please be noted we noticed the regression is still existing after this commit
merged to mainline, we reported as
https://lore.kernel.org/all/202301301057.e55dad5b-oliver.sang@intel.com/

On Tue, Dec 06, 2022 at 10:41:00AM +0800, Huang, Ying wrote:
> Shakeel Butt <shakeelb@google.com> writes:
> 
> > On Sun, Dec 4, 2022 at 9:56 PM kernel test robot <yujie.liu@intel.com> wrote:
> >>
> >> Greeting,
> >>
> >> FYI, we noticed a -5.1% regression of unixbench.score due to commit:
> >>
> > [...]
> >> 9cd6ffa60256e931 f1a7941243c102a44e8847e3b94
> >> ---------------- ---------------------------
> >>          %stddev     %change         %stddev
> >>              \          |                \
> >>       7917            -5.1%       7509        unixbench.score
> >
> > What is unixbench.score?
> 
> Should be benchmark throughput.
> 
> >>      10485           -12.1%       9216        unixbench.time.maximum_resident_set_size
> 
> This should reflect accuracy change of per_cpu_counter.
> 
> >>   37236706            -5.1%   35324104        unixbench.time.minor_page_faults
> 
> The reduction is same as benchmark score.  So I think this reflect the
> nature of time-bound testing (instead of workload-bound).
> 
> > For above two, is negative change good or bad?
> >
> >>       0.98 ą 20%      +0.7        1.64 ą 38%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
> >>       2.12 ą 19%      +0.8        2.96 ą 13%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
> >>       2.35 ą 13%      +0.9        3.28 ą 13%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
> >>       0.14 ą 74%      +0.4        0.55 ą 32%  perf-profile.children.cycles-pp.do_task_dead
> >>       0.04 ą223%      +0.4        0.47 ą 49%  perf-profile.children.cycles-pp.__mmdrop
> >
> > Also how should I interpret the above perf-profiles?
> 
> It appears that the changes of handle_mm_fault() and __mmdrop() are
> related to the code of the commit?  That is, for this specific workloads
> (not so unpractical), the operations become slower?
> 
> Best Regards,
> Huang, Ying
> 
