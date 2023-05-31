Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8003C717633
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 07:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjEaFaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjEaFas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 01:30:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00623198;
        Tue, 30 May 2023 22:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685511041; x=1717047041;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bpEan9cyUjZ9s43AAnRPLJzGnSp9n/vBxRLq9RJxges=;
  b=I3myhV+K0Obx8r9tt2mt1NV99k4dlCBtt5CyJ8zOwXzd93ktlZW+WMNO
   28HWaFGt0J3N5OhXxStuwbUUHzur+3zZp+mDT3PHfQtPqnHF6prh4Y/nl
   4Xu1p7bmv0qJBE372pK/zU5n9TclQ8uSN1bqKr+9ofTel6oMg3P5gWJSe
   egQ+IABq7Y20oP2BSinRe9ludRVuCwBnKk4aLWX3gFm7GC5OMsPnPJ6K1
   pMhen1TNhCp6TG98na6/cpyTMZEjUS64/FNgsimny2Ovkj86mCt85aUfc
   uoMY95nUnku0qhDaFsPLTyDiyF28CKYOyj2r38BKdbw5UnwYt9U+BW4HN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="420906669"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="420906669"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 22:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776631032"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="776631032"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 22:30:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 22:30:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 22:30:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 22:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEtsqlPrS5aOnxppv3yhSB51InF5DcARGEsR9oo240eCnyNAHE38165FJXee6k/T7VayOL5+ojrLPp2CyGMI+j6E+TmuHu09sCP/5jx7PD82QdXi8YzHqjSetv8sI/7Q4gZOg6fK5IJFDqGjN0hy8629xZsdHcoliPxHcmOQIzQeMDm+V9pOpyTYJIUfZGq0ZNPCj4mpIgChPTJBLcdzK+g1VsjwMzvV8Cl1IDxNJQiLST6e6EF54JBmgaHfKs8JioF5XEdguPEDgqakjp4D/W0GE/gajMNZ3NlrlWx9DhYyHUpqu6riS7gF6OZxNQ18vSP1fzyfUEWYx8j50Lrlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSNJTWxSRdK3NO2V1+aC6vQlJQB/aw0W/n4xkx3k5AM=;
 b=Z+msKNQcv1ZIWbw6AW8g3ge2isXKWv1Qd4jcJHi/KwpZWiyUuiha6XmxT6WwOEMdb/W77kRf96QvLYgPw2PxrqOVMXf6YFPiP0eElseFxhhow8+7OplYiuSVPy2cphchEgOJ9IPRrYQz/jr8FEhfhoo8nEYHuroohE0qFqYrBENjImOX35Hez33LQ5m7xVeNscUFG7QxMWJPnmaKHLzjwaYNxdR/o8t6ZTY9iTG+cOTzeFMLbbPTnwtGnyhWShsR9Z0wMyBAKQq52OYNy1G9JM+dQUgTmu6+z5tOvdn1i0jZhIBTMoDHAW84xwe5bbpCG7Z2dMO9h1geuR0z0ZysyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DS7PR11MB6174.namprd11.prod.outlook.com (2603:10b6:8:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 05:30:22 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 05:30:16 +0000
Date:   Tue, 30 May 2023 22:30:11 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <song@kernel.org>,
        <lucas.de.marchi@gmail.com>, <christophe.leroy@csgroup.eu>,
        <peterz@infradead.org>, <rppt@kernel.org>, <dave@stgolabs.net>,
        <willy@infradead.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <dave.hansen@linux.intel.com>, <colin.i.king@gmail.com>,
        <jim.cromie@gmail.com>, <catalin.marinas@arm.com>,
        <jbaron@akamai.com>, <rick.p.edgecombe@intel.com>,
        <yujie.liu@intel.com>, <david@redhat.com>, <tglx@linutronix.de>,
        <hch@lst.de>, <patches@lists.linux.dev>,
        <linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <pmladek@suse.com>,
        <prarit@redhat.com>, <lennart@poettering.net>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <atfuud5a4zcrs5s6rh7t7eauuofhtwczvzd7r5tsg3ramuqrfq@sxbvdnhaaxgr>
X-Patchwork-Hint: comment
References: <CAHk-=whiXzqprmQNRui3LbKQwvM8fg4nyAzWcU5qZs+kxBVzrA@mail.gmail.com>
 <ZHRpH-JXAxA6DnzR@hovoldconsulting.com>
 <CAHk-=wh6sXSO63kka+EWEqq0tGwtOnXYFWMXPQ6T_wZa+Np3MQ@mail.gmail.com>
 <ZHSeOUpKtyc8VKx5@hovoldconsulting.com>
 <ZHTCK2_1pF61yWIr@hovoldconsulting.com>
 <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org>
 <bav73qu5khl2dxkwpvy2hq34lyi56jn6yp7h5qlennka65kre3@zwwmrr55d2by>
 <ZHZRaFWvLEvkoCMA@bombadil.infradead.org>
 <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wicgDftP9ogSagxiRNvVTm7+YfQpEBuEsoRbkWzsw=EZw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::26) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DS7PR11MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ee4cd6-6ea8-4caf-e415-08db61981d56
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJzSsNDX/2+Y5z89AF1fdYhAgX7BMj0ZmLE2RGi98GjVFOgY1sUmNCn8HO29z5e81L1nNcHEOVzlK67nfiKnK29Zr4sRL9i13ciK/voWjM5W5wKXiIUWo8u4QrCZYRMkMRn/A8GVIwM9+fUi1QmU7P3Dn5eR5kcR+1cR1J7/wbutjiMm0U4w2dMU8s7BcZPMNoouLdh9SIRpuXN57RWaVGqfwJzla7GU2pBj9bS8CpnkkJXvR9OTh5DbbZ7D8RwpBSDBZAeNYpkUiIU//B+6gWbutK9/664WXLMr42VC0hNjk0cdUoH776PzKJwI8/QY4iCePpQwmF1CPsHtYqjXWyASnJkMhz1UccUQNwuvTLLMOIzOCvIygtpLwTuDnr5PfVLcSzLmbtXZYgyUY6RHaZdr9dPaL69ujZSwIokBFyKdeIaa73+2KynhhMnwBQkuSzoIKWrERf1NHfuqUNi/PfOWRm64wuRAijJGPH9CQvXI52heiuXNviz75Rx7bDbMGZ7wLtS/0Wnx7D9PVjxWaa1uDzmao7hTc0fEdaCSZRtj7TTbGhq8asnPwggOxM8e1YjbyZ/mmAye9hVrBhuI7v+qyMTrVuZTuTMhjT+Bt/ysXU5oh/+gCMElGH9fHvNN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(82960400001)(54906003)(38100700002)(478600001)(66946007)(66476007)(66556008)(6486002)(41300700001)(5660300002)(8676002)(8936002)(7406005)(7416002)(86362001)(26005)(2906002)(33716001)(186003)(6512007)(9686003)(6506007)(83380400001)(4326008)(6916009)(66899021)(316002)(6666004)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEFkeGUxRkFmYzVDMytWaGFLdmJRdmZOb2ZicVdYTmNFZzg3bTJreDBKOUJE?=
 =?utf-8?B?dXpxNy9zVm5PbENEQTVIalJRZmFXMExkR21LYnNkTFlJd2tMSnBuMEc4L1Ry?=
 =?utf-8?B?V1lMWWdpZUVCSmJZYlBObzY1a0Y2bFpKOU5sd3BENDh4bm5ESTQ1VmE4dlFx?=
 =?utf-8?B?UHZ3czJRY1BqNjZXUzVBVmN6TTJvZjJuL0xYQUlMZmVnUFdSb0RCYWZhbUtK?=
 =?utf-8?B?MTRocG92N2xtYlMvTE9ER01sbm9RTmRSRVZHdE93U1FjZTBrNm42UjN1L0s2?=
 =?utf-8?B?U1lMbzBDcWl6V0kwSHRZbHBJSlFQM3JGd1B6dVZQV0t6dTBLL0VMSlFNN3lZ?=
 =?utf-8?B?MlpWdVNVY2FRN3BmTllyQVlZK05sWWhhRHNtNnpvZHA1TzVIUDdSdlFLeGhN?=
 =?utf-8?B?Y0Fvb0o3RXdRdjB2UmVDbGp0WTllLzYyM1gvUHJFWnRBcjNRWFU4OVFuRWtw?=
 =?utf-8?B?ckFrWjF2cmNmZnI3d1hRZnpZM2pEQW41aW91eHNWVjFlVlY5bGxsQUdVT0dC?=
 =?utf-8?B?Y2tidUxYNlJzZHJMSUVXSHkrb0FxRkk1M242UWxwMVBmU0VxdnVOMEN6MUF4?=
 =?utf-8?B?aFZ0dm9pd0VQNGpCL1VrUkl6cHdmT0NUeWRiQzAzRmpzaVdqTGpZWmY2ekd4?=
 =?utf-8?B?NUFjMjJFTGYzdzh6R1FUdlF2dXdKcUFROHZaZ3NENDI5WEY0RGFmZnY4OVQx?=
 =?utf-8?B?UmRySzJEZTJTVnJ3WUs4UWlEREphYVhwa044K2l6QmtMM0p2M1lFRUxhWGFv?=
 =?utf-8?B?aCtsUFY2Z2dsM1JrWi9LOHBFRTRWRlY5RkNnRVVoYVRSeEMxUGVEK2Y1Uk1S?=
 =?utf-8?B?b3VHbEFyZjZWcTZZMjB5NEMwSlBhRVNVbm5XOWZ6UFJnRFlzKzIxT1BpSGx6?=
 =?utf-8?B?SzArY0NnY1ZkZmlxK2xUeHdRUWNxOGV5V1VNeUhtR01jbVk4UHc1d0NSQUM0?=
 =?utf-8?B?OGJYWUJHc0RkMVpBaU9XVHNtWWNPRVhBYTZYUnl0UVBMMEQ0eUFMc1lCcHRt?=
 =?utf-8?B?RmZMckdkaCtvRFUwVUN1QjZYUVRnV2t4OTdZZWlPLy9mWm5zcU84QzZXdysy?=
 =?utf-8?B?dUtqRyttcFNtUFNtZXZDd3JvWmYvSFQ1NzM4blRwMEV1ZjBXNHVMOStvL25o?=
 =?utf-8?B?YkRnTy9lRXNQc2c3K0ZFbVdwdmlibmpGM2NwdTVrR1FDbVZPVXpsNHM1Qng4?=
 =?utf-8?B?U2JaTjFkVzJsZEMzZFFYMUxBZGtvOHZxdURPdEZhdzhuckdWUEEvaUd5OEdj?=
 =?utf-8?B?aGFJQnRaUmdZNkJJQWwzVEhEVGU0M0Zka3d3YTdlclVYSGIyaTAzdUo4NHo0?=
 =?utf-8?B?U0VJck8wQWMvK29CejVkL2tlSTA2M0E3bXhTWUw1WHNJSGZ5dmZCYTNIZFE2?=
 =?utf-8?B?WUtOZURzQVYzSk0rd1dJZzFGRGo5M2xmdE5iNmJzRHZSNjhDUzZhK0ZSbWVu?=
 =?utf-8?B?OGFjVXkvZzBvbW1sWm5tdjlrMDBzWk1CQTF2eVVNeVM0VmcrZjY4djZvYWRY?=
 =?utf-8?B?RjIvTXJCY25XVEhIVmZQaEZDRnFFT25GNzFTUHhkOXEzOEVSVnZxUUloWU1Q?=
 =?utf-8?B?dk9nWC94ZTBxdk8vYXhqa1hVYnh1ckFvTGo0ejJJV29xQ29MVE14MFkzUmxo?=
 =?utf-8?B?OEdib3hoNWVlZ0MxMEdZbWJ1Q01YTHhjZWhLajBIVWpETU52cnBrekpTeXpy?=
 =?utf-8?B?RUdwSlZxSFEvN2EwVVB3K0QvaFN5dGg0a0RXWHE5VXFzMVBkZDVyQUp5eDly?=
 =?utf-8?B?ZXdQS2dPODVoTnpmMGg5V01FN2xua0lkSlhER2ZYYS9kZ2E2akFLUjYxa1Z0?=
 =?utf-8?B?Q3Y2VjBkQmIvZE9NdFVDQ3J0bTZSYXozVkVmSTU3TzQvaHM4N2RGM05obFZF?=
 =?utf-8?B?cDdQUFJYMmp6bnp1VHRKWVZManBSYXpsd3dYNDlpejNKaFNFVnlVeGxxSHZF?=
 =?utf-8?B?N3pQSEQ2dmU2YzNjbWVqWW1ZVzJzVGlicTBvTmY3cm9KSTE3enE3cyt2VVlp?=
 =?utf-8?B?RG52TzZqazdDaHFDaUVBQVVMdVRJMUY1ZkZkZFpIMDdUR2FjM2k5M0E1WWwx?=
 =?utf-8?B?WldQdmZ0T2FhbDBQZis1VEVnZ1ZXVjhTYk9BT1o5VGJlOFFxZFJxbCsxa3Iz?=
 =?utf-8?B?R2p4S21VS0pES2tvaWxscmhXMEx1TC9jaWJwclAvL1pGTnczOTZkMTd4NnN3?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ee4cd6-6ea8-4caf-e415-08db61981d56
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 05:30:16.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z06qJFqqRJ2bHGmGY2i/EWFxxBiYfSIKGXi+kjnfoGZYkPE2Ffk8ZHeBpx/iAoRyQ/Qnf7yOL8yioFAXE0e6ZVyoJmCChnicUar9jn1oiPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 06:17:11PM -0400, Linus Torvalds wrote:
>On Tue, May 30, 2023 at 3:41 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> OK thanks! So just to confirm, it seems fine to return the same error
>> code if duplicates wait, or do you prefer for some reason for there to
>> be an exception and return -EEXIST if the module did succeed in the
>> duplicate case?
>
>I think either should be fine, since either was possible before.
>
>By definition, these are module loads being done in parallel, and so
>any of them "could" have been the first, and returned success before.
>
>And by extension, any of them could have been not first, and returned
>-EEXIST if somebody else loaded the same module first.
>
>So that "somebody else did a load" code:
>
>        if (idempotent(&idem, file_inode(f))) {
>                wait_for_completion(&idem.complete);
>                return idem.ret;
>        }
>
>could certainly have made the return value be something like
>
>        return idem.ret ? : -EEXIST;

yes, this is what I had in mind.

>
>instead of that "return idem.ret".
>
>But it does seem simpler - and more in line with the conceptual
>"loading the same module is an idempotent operation" of the patch -
>to just always return the success value to all of them.
>
>After all, they all did in some sense succeed to get that module
>loaded, even if it was a communal effort, and some threads did more
>than others...
>
>As mentioned, I don't think it can matter either way, since any of the
>callers might as well have been the successful one, and they would
>basically have to act the same way regardless (ie "somebody else
>succeeded" and "you succeeded" are basically equivalent return

agreed, it will just be a slightly different behavior if finit_module()
is called twice and the first call is already in the process of
initializing the module, i.e. complete_formation() was already called,
putting the module in the MODULE_STATE_COMING state, as per
kernel/module/main.c:add_unformed_module():

	/*
	 * We are here only when the same module was being loaded. Do
	 * not try to load it again right now. It prevents long delays
	 * caused by serialized module load failures. It might happen
	 * when more devices of the same type trigger load of
	 * a particular module.
	 */
	if (old && old->state == MODULE_STATE_LIVE)
		err = -EEXIST;
	else
		err = -EBUSY;
	goto out;

in userspace we already deal with that in a special way and should be
compatible with returning 0 for all practical purposes.

thanks
Lucas De Marchi

>values). If the module was a prerequisite for another module being
>loaded, either -EEXIST or 0 _is_ a success case.
>
>             Linus
