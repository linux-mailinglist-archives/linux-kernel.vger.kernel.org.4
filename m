Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47596E6EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjDRVxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjDRVxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:53:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF25198B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681854809; x=1713390809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S65SwALDDF+ZdnyK31qnT2ZxzFaVVEKHuWetdI1Sw+U=;
  b=BjXRQPyzbRNfIWgy0nkT27N6SyetHLPLS65IPKWc3qGfPoX68ZSpUY3L
   /4UX6HnCEz/VB6WWgB9pUUXasfb3QB8qhEPsJSbm33qhwdNPrKnsYywfq
   lNudnIzRGmI558/LYPSoDSkPrxtsUK6EW3hYARgQB2KAvCL3xTyAeQ7Pq
   TruiELcPdRghlk/TnXBWmP8clvO1kla1IZEzDtSZqy4IiSGsu4SxC1+qy
   yksp4jJFc29+1sH8ZBtBu8HKdYGyVc9cSg+q2u/7t1Dhk5Ib81cqMpsQe
   jJfxM2/VkZAv6CiPfW7hg7EdNilg9BQX6mB5sZaHGky0ork2rQ1271GK+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="329467747"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="329467747"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 14:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="693792194"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="693792194"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2023 14:53:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 14:53:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 18 Apr 2023 14:53:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 18 Apr 2023 14:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDooATEWva2m8neGzobmdssF7CKUpGF5CeeXeI6eLxQbR3sh/RNWz9EG5GkeQXoam+pepcg7tbkuaPcbPxoa+Rvjb6RQ8PD0AWFH71HDJW4WzFmDxwcuI7xCZZXG/t05HwyCx8JfknyjMPqEjAxdAGSkDVSvRJqZ+lxUI2aPLX2xGsDrSvXDs4aRN57bRfe+/GHIG0ug6VxDoVIke0OfKNEZdBznX6Aw34cMbI8pKu9CkdtWjSmrSO8+giz4i664AzK+N8Qi+lEotR3zqZKtelPfOK1MVOZ4eQ8DLfhHUht1wVro3FCVIPNJTRoixzT8J8z8L0tIvzKwe5iUXhiQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXkz+67tkEGGRO2DqwKqRSVP+1pucmAncP3blFqtwwc=;
 b=JlExxVKKe/Z80BlT5Ib/x+/gpH2ufS7DXn/atQUSBWPo0rM0qbgdvLXbKZdQYjXVbxbbPMxzdmnxGIy9rEcrPIOLolJF79Rog1dyaKeVnlApilen03Zy3R1c2ppC+dtfNjH3a5R8jO6TuMoRE7F83zt8B3KeYOp+2rmgkWxkWHfBpS0sk/uGpQ9ngfKcEdBnmoY9HKpzDd5ifyl447wQ8HKH53eJxwPWofvcD0ncWH9KkPjzjvC9bADD477nRmdFx2QgQP/tCDvJwG+tQuEEsMD/W9mmCvKHhF8qcfb+Sl2KB+yPRkX7T8cOVi/GP/+zo6dYN75rrrvuE/wTcbQpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Tue, 18 Apr
 2023 21:53:26 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6319.020; Tue, 18 Apr 2023
 21:53:26 +0000
Message-ID: <c33a2f01-b439-9533-79ee-76456eabf08d@intel.com>
Date:   Tue, 18 Apr 2023 14:53:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 3/3] Documentation/x86: Documentation for MON group
 move feature
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tglx@linutronix.de>, <tony.luck@intel.com>,
        <x86@kernel.org>
References: <20230330135558.1019658-1-peternewman@google.com>
 <20230330135558.1019658-4-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230330135558.1019658-4-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 4849e34b-897f-4fc5-4274-08db40575651
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/YBPAX39tjnvfH4hfwRHGdxj4TMOA4UNmzZ4YD2wuF0PSkfko+qXYB9XkucJOZmnFIPbzpZJhiBGJz6lBAsqEDN9s98O/oGi15NTwr6Y4VKQVjzt4DZbXkrXzBxPlnAcubB25+uDkXLp0SspH8ejwW9ksAGtn/zO/Ru5rnQKRGNnTTd2bNepZpq/Y6vvg/+T7u9mlu2Buk9e4dC05mTgBaKXUblMS/j63OFvcPlMPnfTtJVV9C8IobpHkKVeWgm01lRVvq5BRnnNmg5bTKUjztLoiwYdQizD0Hy0/pZNBTeaViNqaax7rMxFq9Fh2Lf/g2SK/uEL1HcISZkwD6Qr07wvoxoE+C92ws8aH3RiY1EOiaiUc7tnlAknWfmP15BvR3QtAFsWUG72famk/3GCbPjWmFRTUiK4J54ra9V0k5hVr0OjJMfyJo0lz6LwmzQa0kUdj3Pdoa6KTitTb1gl29U5NV4llhI5s4noFHTQLO/scAaOEXaMpP0ACyaue54Vvdvhz6e/DX5oVfRZopni+xKqphtALNU1E6POlzFXcxo/eSmGZDWURvt8v9X4chRWqlMuzxy5opz24+LQVENkv88aR6oiob5Iku5K9L6k9R85JPfEEvJG04hScTJW8uOmKZw3LxGPqTRl4OEiLc4Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(36756003)(86362001)(31696002)(2906002)(31686004)(6486002)(2616005)(6666004)(53546011)(186003)(6512007)(26005)(6506007)(316002)(4326008)(66946007)(478600001)(66556008)(66476007)(41300700001)(82960400001)(7416002)(38100700002)(6636002)(44832011)(5660300002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBOZnpRdDJUYjNUMEFYVnBvMWFFOEhHSWpuMkd0WC9xZ1VHUFAzMURyeEha?=
 =?utf-8?B?NHp6T1hDYzZKMS92TzdoSjFGSjhTSDJMSHlUUmRubFZYTkZXZENTUG9MOCtV?=
 =?utf-8?B?RHNaZjdxOXJ2Y0Z1YVAwVmxpOTM4WWI0ZUI0U0gzZmRZK0VqZlZvbGZLMHk3?=
 =?utf-8?B?cjdNTHc1NFRhSXFYOWltTmhydVVWeWpCUFl2T0xYQjZuL1ZwallDNHlXVEZG?=
 =?utf-8?B?ajhsZjRud09OVDFIMlAyMEhnNTVLVUpNSm5vSkFlanlONWZOZGp1Z0MwQmxl?=
 =?utf-8?B?S1FWcDMwOUdiUzQrd2FwKytTMEoxVW1BMml0elI2Q09Gbi9jZHBHOWpObzkv?=
 =?utf-8?B?aitONXd2ZDBLMTJ2WHdaajc3VWlNNkd3Q3Vodk5ROWJtU0Z6OUgrejBYdWlI?=
 =?utf-8?B?YWlZZFdqKzlSM0VhV2pvNVZFR0h3blRCd2dGTmJpUm1LNEp4ckhDQzBOU3RU?=
 =?utf-8?B?V2VSMVV2ZXAxUytJZ3Y2c2VtaTJCWWNyaEN6a3pQSW1VV1lhRWZhb1E4U09U?=
 =?utf-8?B?ekZOWUhZbUoxZjlDdDZzRjMzY2pOTHYwQnRqU2dDSmhVWFhIRHBiak4vdUg0?=
 =?utf-8?B?Y3lORmJLUml6bHFVMVZBS1BxZTIzRi8xa3JNc3cyNHVKUWZEL2ZVQ01FNTd1?=
 =?utf-8?B?Qm9UcTRraWpNUG5KWjFpcUpZN0V6QzhMdmllLzZaU0xjMjBpb1RCWHI4dTRU?=
 =?utf-8?B?RnJNTDhIdW9lYXN6R3JtVzliRk1FU2FGM3V1aGxzSTZtbU16UmlOVkZtUmtz?=
 =?utf-8?B?dXRBNzVCcWZrZmJMNlgrdVF1cjJLWGhqTms2VGNJWGJYRWU5OWJzR05PRWdC?=
 =?utf-8?B?d2lkay9GUUwzRWJCblhnVHFqOWZyRldFV3JtTit4WmF4MkwzaUlTVFhIQWN4?=
 =?utf-8?B?emFPSFRpL0pTY0I1MkszTVR0OGNPK0sybThGbTd3MmhvNzRtSVhiYkRJejhQ?=
 =?utf-8?B?MFlWelErQlJXNkNiQ1p0T2I4anRpVmVSV1REbllVTXl0RHhIdG9SNzR0N3RW?=
 =?utf-8?B?bVB0c0RIcVoxSHpjOERyazdQWFgyY204Y0pVUHlWUDc5M0pxTm1KeTUxNGt5?=
 =?utf-8?B?MEtvRUlpYmVNNkNGdTlpVkluWXBoZENSd0Z2b3BPTWFzUEpvM3dMSXR6Y1J5?=
 =?utf-8?B?STFFZ1R2WUdPUkgwUGR0S3NRVEljTkJDdjBwbWRnWXJWSlUzMHBJV3RUZ05k?=
 =?utf-8?B?KzZ4b3BpL2ZYMlhYOFB2dmlzWEJTMlNEa3dmRzRzNFYrUDlzSllBZXhYMEhi?=
 =?utf-8?B?YU9HajFSR3V2SWUwazNJa1UxZnlhMzVIbkpLb1ZEeCtWQU5SMVhTSWhrbHUy?=
 =?utf-8?B?a29UR1ROK2dwVDcyOWpUZG5xZHhMTEVybzR3NTJhRTVyYlNLUGVqYWdxRXpJ?=
 =?utf-8?B?UmZwbjc0RnVOTmZZeUtTaWZ1UFdMeGg4UG0wUGtFVnpoaHk0MVhXQzc5aUFi?=
 =?utf-8?B?dzg1YW9BL1RlYVBFM1RZaDl3a1BTS014MkJGay9xZXlDWEpxTm16alpGY3NJ?=
 =?utf-8?B?SElqeERYUVNpTm81TFZNZW1jY1JuaWJSdk0rOW1ZTkIxL2FmUjJ0ZmVNWW9U?=
 =?utf-8?B?OUlSM0JCUHNzN3kzNjBWVzg1OHdZMWRzT2tvQXVyTkFldEloOHJuaGNBdmtO?=
 =?utf-8?B?dHhZMDNZSGU2L2dDdmsvTG9BcmZWbkN1bTRiYm12WDZ0K2hCUVlOQnRBVGYx?=
 =?utf-8?B?Z2p1akRtNWVDYTgyS0p5MVhQSUJiRzEyT0Fob0d1dWZLMTNNNlc3cm43WFJi?=
 =?utf-8?B?QWp3a282aFZzZzRyOUdIbm9tcjJDN0QrNjF1WFBTOXpQQVRNOENsMFdtdFFu?=
 =?utf-8?B?WjNrZlV1WW5YMks2MEZheGg4UklKalZFWTZpOEZPVmNxU2s4VlBQa29vNlBQ?=
 =?utf-8?B?UjFDWGRSWEo3RkdZSDJXK0k2bmg1emhqazNHMFVyRlZGWEpLbTN2UUxxQlRO?=
 =?utf-8?B?M3hiNDdyUXJaQkxPazhTc2ZmRzlFTlJMWFQ2UXF5czlobWZiUjlsZFExNXBJ?=
 =?utf-8?B?aVpFV1lTbjZVTGdYVXdrU3lJd2JwbDlRYzV5WEYrTVFsaDcrWVlMbUY2Nldn?=
 =?utf-8?B?TXBLUWw5dXFld3lrM1pwS2x1MktsV21oS3k5YUdQellxVXlGcFUvZWhzY1d3?=
 =?utf-8?B?bXFLV1psakw3OXlCWmtDWXBsSGRlWmd5TjFpUWg2cUJMVnA1cjN3YUJUTlZC?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4849e34b-897f-4fc5-4274-08db40575651
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:53:26.0540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VcgPIHfElKWt3+tOXDkM/Om4kFJBt1a/iI2hEVblpLmGEzIHntoFIaPoM/nC+VyBKPdTs+14gnqgtSg+YDoVgrTN7E8FDnHd5vXoI81EYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/30/2023 6:55 AM, Peter Newman wrote:
> Describe new support for moving MON groups to a new parent CTRL_MON
> group and its restrictions.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  Documentation/x86/resctrl.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 387ccbcb558f..cb05d90111b4 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -287,6 +287,13 @@ Removing a directory will move all tasks and cpus owned by the group it
>  represents to the parent. Removing one of the created CTRL_MON groups
>  will automatically remove all MON groups below it.
>  
> +Moving MON group directories to a new parent CTRL_MON group is supported
> +for the purpose of changing the resource allocations of a MON group
> +without impacting its monitoring data or assigned tasks. This operation
> +is not allowed for MON groups which monitor CPUs. No other move
> +operation is currently allowed other than simply renaming a CTRL_MON or
> +MON group.
> +
>  All groups contain the following files:
>  
>  "tasks":

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
