Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CCF732274
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbjFOWI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjFOWIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:08:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374692D55
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866895; x=1718402895;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NempVK+NyiPjXlsX+MkwzfVtEU+fdJD79z6OSWatuSE=;
  b=fINPN1n6f2IzUdz5/JbQxZ1dfSw2mlydIFVKfecuqLK/r3oKwJcem0uS
   NvUb6UH+kTtai0COIdD1wK3aFvR/lo4T+YUDXieOH+Y9XHnGqDy1M6InK
   NUbTQZ42qxJd2ygbvrVSExRh97TmiCKYZhkJ+7LUEy3GqPKUMGFcvAX41
   /3N3jFamD2cABH0uV96mTEyY0R4FMdVr5hS3zFug4/pXD5AhcNmamgmRT
   8vKmHKU4SzBHdW8Y37fG1dBI/9y4jH8kNCVBMzqlA2Gf8UlOAa2DXBCqZ
   tm0v32B3fuSz+oV8fxoKXcQaCoi5DUDHZFrIi+zT0airbBo1gHTFcVzV2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339392715"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339392715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689972736"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689972736"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 15:08:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 15:08:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 15:08:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 15:08:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwHn4cilkb1FYUyfDJh+Iw9GO5VJyif9Zt63TBv1+r85NjHOvohqUoS6wRWpPoqfHRUFxaHA6B4eL/M1O8tECtVL9jWCvD6rjZQUl6v/HWzj1w6Uj0RbJ6Fu0QjeLXKScEaRhE1eynl7t622LWdEFGfol+48+QB6Z/ApaezROLwT3xOsdvQzLymwtHPXT41XZVrgIJLgjcwJ12ts2OD40IjJi8FYIFMVtjUJQhZ9rLMNmtJt/1/rsqr71say86mstT0xo1x/+VVokCAp7bDLNXrY9+/oop22KRWQXBfohmyhTdSC/fHFnNp18j0eUh0iBZaM11e+N5a48r8T50ygjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb1hAb4exuGXH29xK5AtCLcksn2TxiY/hfcsZBcmD8Q=;
 b=LOGhT6Cxv/3kwA7AHasaelhVwiC44AX2vRGYdMrcVXTqXN49ouUEivwMUBYlJ1GYizC5lSiOhWoVdqCYIAXRJ26rs8tFp4JY5FOuXZu2JZFZcEWOE+pi3sh+8wOPhH8sfcOJ1isC9mgt3NbHFtk5Pg+9MBMPCkvezXB6/r6iSGRpKLANhmSgAhETUBwm/F+Ao2k+7em+wFV7ita16OS1YKRqOCKZHzRkia1rFsI8QpUDKVgusZX7kJ6XFE/w1aFaaGV2Xxz+jYjmu0fchuJ/zhJPGtVfbHFemWRLzo4jFCYpxIB/64w2w2aCGhmC4B/buoF3Ky7tmplsw3G15eEquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 22:08:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6455.045; Thu, 15 Jun 2023
 22:08:09 +0000
Message-ID: <caa21966-967c-77c0-c2ca-8747677e186a@intel.com>
Date:   Thu, 15 Jun 2023 15:08:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v4 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230525180209.19497-1-james.morse@arm.com>
 <20230525180209.19497-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230525180209.19497-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a2f2f2-d4e3-406c-5d50-08db6ded0115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ9J6QRWZC9b3Lk7L3ZH7gklLrzuAA0/IXxbZwVeRoQtS8oLm4fZg5lvsuR9ghUG83ayXT3f+BW2hAJDU2CIHj8VRUvszl6jycM8DL097Pgs+rsl/Zcpwboy+4JhrEzeeTmD4MEOCQzLGBPMpNDspd+YYa9BdHiApE0h35rnzR5kjb4hbH/nMfg7ztM3GfEWwR2WR8WHDjlG1rN1wTqsPf7fjX4uUfzZdaWey1zoEU6mPmqtRUQqvrnV6x4evXSgNEYWNTObho7g7rCxmceZ+XtExIDOKmhYWVqlBXMvrDILf1lsYNrFBuHZUXlWQo2Gj9EVCK4PwXZWK8T9zCMvSJVXUGte4Jbad5JJOPutsbQmXlWQrkOyq1NdRv4k8rNH+50AeHwF5btXbIO2OP6Bv6ONpCiQ4optkCW5Gg+I7cDVrlv+uViAFh0bTk25FGEnXPhsFbiZwhjM4k/HgZXSROm1swquKhMJBK+3OT46SHw3qhlZCWOkQ2U4WaaJq+ryS54fLHGM3Kytb3KxOBRdALkokXs9jS7E3DSCV1xiGBwabOyMBvskxEHyROvos0lgSzDOTeoz0KKScd4rJ1i6t8V/IsxHPahhNJEoa9shJXl6DN6dn8f3bv3g2tJjbzW0JOfaat9WR9te8VdtPM9CjFY9RTTcNFs7nPopZY0tnYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(36756003)(86362001)(38100700002)(478600001)(41300700001)(8676002)(6486002)(8936002)(4326008)(31686004)(82960400001)(31696002)(54906003)(316002)(5660300002)(44832011)(7416002)(53546011)(6506007)(4744005)(6512007)(186003)(26005)(2906002)(2616005)(66476007)(66556008)(66946007)(83380400001)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1NUHBPekFVZDh5c1NjRW9LdUJJK0RSMWNWSitvOEV6ajd1RzI4bUJCcWIy?=
 =?utf-8?B?Um8wcm9CMnU4TTA4SytvenFWempTdzRucytYa3lXK09iREh2VTdZQlhMVE8y?=
 =?utf-8?B?NUFWdDVtdW1EaXdDUEt1K0xudFRNdTd6TFBRMmF5alBZdDlmaW52UktRQ1NJ?=
 =?utf-8?B?N25pa1NPbVcvR3hQSVhRRlNNL3ZHOWs0SU51V0xRK2pqZmVaVEZucU5MbmpN?=
 =?utf-8?B?ZmdnbmRuNGpJcTRxYUJvY1BqUVNjT0gzdXFNZ0xWZmQvQjlUa2d4Q0g0a0NM?=
 =?utf-8?B?Y0pkRHI3eGpNaVZCSGdYUVBsTzVEdUV3WCt4bzJrYzRrQ1B0NncrWnFNcEho?=
 =?utf-8?B?UVg5ZDB6TmJVQU1GMXU5Y1NHcHpsbEgvdE4wbG1vSzhYNmQ1Rk43c2hzZ003?=
 =?utf-8?B?R2cvWmZqVmUyVG1DNkxiUEhDOTRqVC9WM3pzSFlXQUtaWjZGMWR5U1V5TGV3?=
 =?utf-8?B?UTBEQ3ZsY3M2WnllOHJrbVNYUlp0TEhLS3FNNjIwQkhrQWo4N1dBMjBQUklh?=
 =?utf-8?B?T3BUQ3hFeFVabWx3aHVVNW1CWWpVQkRPbmV5VUNvOVpUZlVZcmR2aFpaVFpL?=
 =?utf-8?B?MFRoeFpWSkNsNVY1Nzc3SGMxUDVHWDJBb2VmZFhLN2orYW5xOVZFUitEY25s?=
 =?utf-8?B?SFJULzlpc2tTNHVVQlRqdDFvQm9tM2l0Sk50Sm9XdzNlYVNnRVJGdnBUUG1J?=
 =?utf-8?B?WjBVSkR5QWlhYUdVK08rWGYyYUF5U1NXK0lGcTMyQ1lyajZwT1RuRm1CbWY3?=
 =?utf-8?B?enAzcHJSbTlBd3B6MndWM1pRT3BrSG15TFlTTnVxSUlhSmRKTHlkemNDT2VB?=
 =?utf-8?B?RzNna2d4a28zV3Y1aW4yZVQrUmxPUU1keFNDK0xqU2hKR3MweHVDdG9FT0py?=
 =?utf-8?B?U0laSmQ4bU9tWnJ0YVRTSGhOMEZTekppYjgxR3Uwa3JCSmM4QlYzTmFrcEtv?=
 =?utf-8?B?YkE0cmlTWWtEd1FrdGlwTFNtUDhsaVBXNWowbWt0Um52d1hzc1VTVlIzS0Vw?=
 =?utf-8?B?S2NLbU9ZWGdETWhHbTBlZVdtUjlnZktYNEFTTnd1b2thMDJjSGh4ZFN0NS9F?=
 =?utf-8?B?S2JBWjMzTWxIMWhqYys4ZmlBUmFpL09BZGdkdVpVLytKaXdNOXhUc2lLMGxC?=
 =?utf-8?B?VHh3RVBaQkxPRVZLdmwvK0k3d0JWcUs3cDVFVTlaWmtrenJ0WEdJMTRZWnJ6?=
 =?utf-8?B?ZlNxY2pTUXdiNCtxZ0FCYXZicnU1NVB0R2NwOHM4R1g5WGJkaFM3dEkzeXEz?=
 =?utf-8?B?dWwvaHYrRVFnVjhNNWllMXhBcnJPWUM2MFNkNSs4ZTFuWTdMdi8wQXVXeG13?=
 =?utf-8?B?TkRvYWxPUE1nK2dxWDJTSjRydGh5RHdOTks2dWR6OGF0UUI0STdPbjJyeUI5?=
 =?utf-8?B?dnZ1ZE9ZMDdTYXRqSU9zcisvQmt6cmNqcnMvOHMrZjhUZitFbTlONGdQU2l1?=
 =?utf-8?B?bXlsYkk1RGFpVTZpN0txaWljeTlCdDR0MmZSTzJpMnRxd0YrWXh0bzhZSW1M?=
 =?utf-8?B?T1JuRDJXNkFWV0xidTh6WGdrb0NIRG5LR3lzN0E1NXRvWlp5eTFVSjFpOVdM?=
 =?utf-8?B?cGp0QmpORFppN1d2czRyVUJHVWhmKzZIMjhxUFluK1diWmh6c0JLdmVkVDd1?=
 =?utf-8?B?Rys5anpGWUdsZDZ3blRsc0ptY2VndkNOUmdYVXMrWTBKNDBnMmhRME0wRFV5?=
 =?utf-8?B?TE1yTW4zMEUvakNMekVkQU5ycVVMU1NwU2Zqd0ErSkZ2eXUrQ0hBRVBvMm5V?=
 =?utf-8?B?WFBUUUY5ZzNHa3BVQTM0bnJlZWZCU2FCcDcycGdYY25rSXBiS1dzcHA4RjVB?=
 =?utf-8?B?dFp4Tkg0YWZrbVNkbzFpaEZCMzJ4UWJRUHZVM0ppSzIxUlpDVjljZ2toNDk4?=
 =?utf-8?B?U1JQL255RGFzV2M4MjFxKzlYVzIrZ3A4TUJPd1FvUS83MzVDN0lqVXNpNjBl?=
 =?utf-8?B?cU5yZDUwTEp0c1hpeWl6ZHowanl5RnY5U1BkdW5GcE44V1lCOHBpYmhlQjhX?=
 =?utf-8?B?QmJFRTVGK0pVWTRVL0tuTFAvVm5QOUl6YStQTEJHMng2TGxJR04yWGR2VG1t?=
 =?utf-8?B?SjU3ODMvTDlkUU1xbUo3STltRExEdVpLSnQvQUE0eHhLNkVsZ2Fyemp2Y0F2?=
 =?utf-8?B?bTh4YXJSNlZFb0plWXphZTBYY3RZeUgvdllFZkNXUzRkK202b0NBWGRPNlp3?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a2f2f2-d4e3-406c-5d50-08db6ded0115
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 22:08:09.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzXURPr0fbInfYbfQDnAVoBFKmenIn+nlF4aeti1NGbHqcS8h+yAdvC5BsJzY2oiC9/gCj1cyvMAUDUmPEr7LJMfa/3+n1pvr1i+QH4HEJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/25/2023 11:01 AM, James Morse wrote:

...

> @@ -391,6 +407,8 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  	u64 val = 0;
>  	u32 idx;
>  
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
>  	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
>  
>  	entry->busy = 0;
> @@ -420,6 +438,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		rmid_limbo_count++;
>  	else
>  		list_add_tail(&entry->list, &rmid_free_lru);
> +
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		closid_num_dirty_rmid[entry->closid]++;

Wouldn't this always increment the counter, whether the entry is
dirty or not? (Although ... the later change where entries are
always dirty may make this correct ... although I would still
expect the if statement that precedes it to change).

Reinette
