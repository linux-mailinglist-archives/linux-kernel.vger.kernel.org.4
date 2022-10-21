Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB26080D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJUVfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJUVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:35:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986FE194E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666388110; x=1697924110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=53OGXKcJC2fgYRNxdwfkFS2XD8WTY61ZlS7pW6yDpYU=;
  b=c25nHPrcG9sJzslX5AwYSytvfxhvIKD6XKW0WNFsC2gSDSOyEOeh59ug
   PFO5a9y6HJ4T4YVgTxaw4ajlVQcIEqOsCSzq0uTNv59l8sqNW3cHpF/7X
   JLNMWU8zARDnh2b/qOHUPfoTpwNxRqT4NAQ5g/ZYd4S4XwNy3afOR9mb+
   n/CsGqIslpNBwL8UBx0WGl0n5ZC+VC5sCJnrLYPGErbU04Musnuy5xdtj
   4f3BUmO5RAFAa4RkXa0r6mCHEBMLuLDIxAbGTXNEhHrG0C/Cb8NxI3aj1
   9A6vBuZ9YbzXFT/herubALWcGFsJCYE69BpFZYoYxXB2uqpAf2u6VEPii
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307100283"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="307100283"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="959798356"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="959798356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2022 14:35:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:35:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 14:35:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 14:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNjISatpqu1yPNAUDWqWJiMSZqmaKEWT+ulhJSQ6RNe2r3MbZUF5JTtrdCfX31peo/4nst0/Fgc3jiWcPRm6Hg8+bdAGg0J/caQVNO6/JAnuqa0JT7uTNi/L8ae01v/eULGiMYXT2feduOjCAcwYYeRhHVK2O3W1iqJQQzMXzScx7kX3B4Zg3K+GVFtnyQJ//8wpyJ6xzZRTXVcTMfmhZp+4ih1jC68CA8NTvxFLxCgmdegakD/3eM1xNQYBKCQFiwyLtRqY6lIbzarbBGZPfd9q5DB0F8VAVZ2xISz1PD2VVP6mFPj0XaeKBMslAAJq3zFKzZHhP0OF9krdUSwC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iy2jmlk0kc4Eib5hI8rjESgQe0L8it4psUfPmwTOF4=;
 b=Mrjy4AeS7DV4ReMRxvmt8zq2YXWvc/4+Yxyu9R3NzvRUNuI3UpJg4M7eYqmBjp8VF/vlIUBgWVqMyGZ4bskrilP1upaVfQSQrBnxR12PNOUdzV603UxqJYgVQGL003XQCvc4xPO+dlU5CQyCroMeEGfvP+MldOMxIs8/cf0G1SM4ANujXXLrMUvlvKmxyiIEAUGozT3Exq1z11OAx3Dve/R7culoi3zJFvo1QNAttHcpcyptEDO76ZZbKQhoG32Avacc6AEk+Mp1OjymraAyLcGTQyTjVxgtOmIu/PzOFWf4avUvbDGYy93bT3gHBSYA/YCaAjg3eZVUXytbbURnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MN2PR11MB4694.namprd11.prod.outlook.com (2603:10b6:208:266::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 21:34:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.035; Fri, 21 Oct
 2022 21:34:57 +0000
Message-ID: <14df28f0-90b1-9c43-add5-08947165596d@intel.com>
Date:   Fri, 21 Oct 2022 14:34:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Peter Newman <peternewman@google.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Babu Moger" <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com>
 <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com>
 <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com>
 <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
 <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <SJ1PR11MB6083F027B7065C6DE873F516FC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083F027B7065C6DE873F516FC2D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MN2PR11MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: f55ccd3e-1db5-4c99-9a73-08dab3ac198d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+agTMo0g0IJQJq+TdN/lJ32ArL7IW8LrCoyKl2BQ9cCmAHX6fTs7pOwvfhFjPs5K+K1tBHIvYZxECu9tXgS1H4mDFYX5aaJ99eE8OBg6xChmMdYycnp/oOW6AylNRSN7OIbwEeYF4UJ9zVKvnbfpHbRWi1dFaBmr5F6zJImgSjRgTcqBntzNKlzbxOPhc0BO4ds7+R4lTEreDoa/kgAXOprx6YjhcUhYg+ElTOl3NSZdk2/0CoprIcKuFweyEuluXC9t1DNsfb5gygN7ZeqAQZpf8JJLgDtN9/sGQ11TkgVEqQCUi+Slarey3tmbr76M4bgQV9lxXMQDPATKL9F0BmW/5MaJrRMwMffSYCeJX9iQth0b73mi70UepG327gRTukhDDpMOgVfGDpmS6tj7OdJMwDYwuTWlBk5lY208h1xY8ObyUpGsk8Quk3vB63WMJI4lz7MbXnp2pXCGtfAnxWr65tTcSNdovOvE43U8wRvWPfTaTJ0SdlrqOGsQrrdqIBAckDQAu/NS/I+OzZ0PC3cq/W2ztwvyvPXe9YxNLTtZRDra5Cc8BctNWP04o0+025dkUJhey5cz60hTJ4HLvD8XpOn5ie5rhtM9ZbwcSomSyzjMsjSNOrWfjzFTv74GEHCCK4v5kcYU2EixAlLq1tbldhgOyt4JUOv+Uql4p2UmH9iX2hBxGMU2y81HFLcR2mNGeCu+uDajwZlTm6D9+HPpTPQn7lFhDnfPyDScPzI+WomoDwY8RFAaUq/RR/3QmdlvquIo6icBFxckcDHfZMyli/s6MCAiFEi4OJHtRI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(4326008)(36756003)(110136005)(54906003)(316002)(6506007)(41300700001)(66556008)(53546011)(6666004)(44832011)(8936002)(5660300002)(38100700002)(82960400001)(2616005)(186003)(8676002)(66946007)(2906002)(66476007)(31686004)(86362001)(83380400001)(478600001)(26005)(6486002)(6512007)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXppS2k3TUpPZDRVN0Y1Q3VPL0ZIWlBudnBWeGlCTlJZTFhKYjVyK1NPQkVi?=
 =?utf-8?B?NG1qZDhjemJnY0IrYTZReU5MR1cveFl6N3h3SjRJczFTM1FVaGFzQkxDbUNi?=
 =?utf-8?B?dThOY0N3cCtPTTZhZkUxRmRJUVFhUUo1UTVwUjRsSU92THlKVStQajFOSndG?=
 =?utf-8?B?TEJoQ1J5YmFRcGg5dFFGZVJYR0ZQMlRSazFDMDB3LzlyZFg4dXVjV1NMaThy?=
 =?utf-8?B?VTNrcWN1cE1OampoZ1hBeVorM1h1TGNLQlpXSkpOOHdReEY2SGVrQnRCbXFs?=
 =?utf-8?B?TjQvS1RPVmtLY1pyTjJsQUxZMlduai9tYVcxNjRBSWM4eDgxUEd6MEptSFJk?=
 =?utf-8?B?RDlOdWZ3a2xwSjcwZHlCcXVpT2hRMHB6NkRlaU5kK0FGUUVtYW04VXR1eExO?=
 =?utf-8?B?MXZhZHF6TkdkcTZKUkFCRTdYTmVxeTgvZHlRL1JkdU9UYzF0clNjdHRxWHNx?=
 =?utf-8?B?dE5tK25jaDBDMWRTeVZsakUzZW9DbHgySWh5cEVRUnhoWWVCaFI5WmV1RTM5?=
 =?utf-8?B?cHd5MlBuVEVJTzZ5c09EZGphMWp4ekd6cm43dkVJQkgvMXhuYVB5MVphUHVw?=
 =?utf-8?B?ZFY4blM1QzY3TXpUbTh1VVJQdk5PYVRLNjlDQmNvb0FnSFdNNTVLb01TdXFh?=
 =?utf-8?B?dFR0V1ZZMkQ3Y202b2x6TXhUK09lWkpGZVRDMTQwNmg3QzZwTU5NWi9JM2FN?=
 =?utf-8?B?WTB5Y2ZZV2tvRUx4SXFRRDQwdjBmZ2p6cm44eHBNczEwVkJsMTFrYSs1Z3Jh?=
 =?utf-8?B?ZGhQaWJPQUh0dnJ0S2tNcEZYdVpUMlNKU1MrNS9KZ2kyT01Ea3E0UkJSdjA4?=
 =?utf-8?B?NW1rMDZVclFBa2Q2cHQ3OHYxR1BZMzVSK1RqaEgvTGJWa0d6eFkyVlFyRm4w?=
 =?utf-8?B?MG0rN1FWL3lFWW9JRzFqVDk4MzV3M2N6VGZMaDlzeCszcWNmcEdIWE5Idlcv?=
 =?utf-8?B?Z1lzUUNLYVRkZks3bHlTaFp0dWg3U1dnSTRBVHBjOXk4YzRFOXI1QlVMdXR0?=
 =?utf-8?B?MkUyUGpTMzhWZ3ZPb2JUNWQ1Q2lxMFB4eXU2b2JpTnVOOWttRUh6bTdxblhu?=
 =?utf-8?B?Y2hFUVUxbE9UUWtvNmlibFdtcEdNNFY2MmMvUFlQcXozaVN0M2toTktkc2dq?=
 =?utf-8?B?dG16M0RoMkZOVGZMTVZvN0FOTWdOdEowVkNyZWJmTS9sVTdNOTBqbnd0dlJ2?=
 =?utf-8?B?R0lNTVEzTDJiY3RkTmhaSkJYSkhrUnpWRFJOaTl0T0hMYmxHVGVvbEhicm8r?=
 =?utf-8?B?SmppR0RXZktnM1BUOEI2RUVIQ3pSUzR2ZFY2UTNMc3JBaGFuVXN0eFY2TEs0?=
 =?utf-8?B?YzB1TDVXbFdJdTZwUGhha0RRbVhlMkhZMVo3NlZCVDVFZzlTNXZRbHRtdGZV?=
 =?utf-8?B?RTVGcTVNdE9zS1dBZWZTU0F4cGlBY2ZITlV0clA1cU9qY1plY3B6Y1BteXZG?=
 =?utf-8?B?SjZhRHV4UDBOckYxRStlWG5oQWFvNmNkZUE4VEZ1UlY1Z2V4WnZTQldkK2kv?=
 =?utf-8?B?Q3Y2UlhqNzBwaWtBOTA4Rm1nbnBYUjArZmxySFBONzhFc3I2T1p6M3liUnVY?=
 =?utf-8?B?OFhFYWNnSHBvbm91T2hoSHFHZ0M1c2dRbXZubXZsdEpqbW5LZDQzdGNZVlkr?=
 =?utf-8?B?WXY4cktsYWdZenJMdi9mTm01eTMwUVlHb3U5K0ZqQ1ZYUmQ5S21HR3JhNW54?=
 =?utf-8?B?eXBvOHVHc3VFQUtjMTlyYjdUbzlzRVhyd3NOWUg1UzUyWjAxN1N1WU5zY0pm?=
 =?utf-8?B?aHdwM3Z2cWUxZU1WakV0TVFJeUpJckwvSm50NmxUbUxzM2Y1WXA4NUJNOWZj?=
 =?utf-8?B?TWloZWRtYkF5SnBCM0J3djM2bGk2TUFZZ0xPSEdWMnRTVHF3WGJ4UlowVUxU?=
 =?utf-8?B?cDh5L2J0bExvc2twUllodFlSR1RNWnhBanNaelNqQXdSTjA3Y0k0cG1CZjd6?=
 =?utf-8?B?cTJrMkwzS3ZmUklKcUY1Y1diWmdqMG54dlk4Qzg1ZzAxVHRKZ3pzUnNrd2Fv?=
 =?utf-8?B?TENMZEZFS09YQWhUU1AxOTZNNWlXcjdZOFQ2cHBuYXpIQm9ra1FiMUVPL2Yx?=
 =?utf-8?B?T1hLcDF1Q20xK1Ryd3dnY2c2YWsrVDNOVGJrcGM5WXBaZGRpTlpIME54b1pa?=
 =?utf-8?B?cUhUUVd6QnY5Yzdxb0FrUGhDc3ZTRmQyT29NckR3cTlxUzNpM09zLzhtOWtn?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55ccd3e-1db5-4c99-9a73-08dab3ac198d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:34:57.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR5CN8VFq8CMK3tGWyVjKbChZi6xuDXp0TFjC2/jKOSpI9dt8GFZMdxStlJHK9qeVdZbT7gHCJOk6TPZeXW46sQd3ZL0aH/5NH11O8gxuTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/21/2022 1:22 PM, Luck, Tony wrote:
>> I am not viewing this as "secretly-two-control-groups" - there would still be
>> only one parent CTRL_MON group that dictates all the allocations. MON groups already
>> have a CLOSID (PARTID) property but at this time it is always identical to the parent
>> CTRL_MON group. The difference introduced is that some of the child MON groups
>> may have a different CLOSID (PARTID) from the parent.
> 
> What would be the resctrl file system operation to change the CLOSID of a child
> CTRL_MON group?

It could be both mv and mkdir

> 
> I followed the "use rename" so the user would:
> 
> 	# mv /sys/fs/resctrl/g1/mon_groups/work1 /sys/fs/resctrl/g2/mon_groups/
> 
> to keep the same RMID, but move from "g1" to "g2" to get a different class of service.

Right. On a (RDT) system where RMIDs are independent from CLOSID then a move
like above would mean that MON group "work1" would keep its RMID and inherit the
CLOSID of CTRL_MON group "g2". On these systems a move like above is smooth
and after the move, CTRL_MON group "g2" and all MON groups within "g2" will
have the same CLOSID. The tasks within "work1" will run with new allocations
associated with CTRL_MON group "g2" while its monitoring counters remain
intact.

What I was responding to was the scenario where a (MPAM) system does
not have many PMGs (similar but different from RMID) and the
PMGs the system does have are dependent on the PARTID (MPAM's CLOSID). 
Think about these systems as having counters in the hardware accessed as
CLOSID.RMID (PARTID.PMG), not "just" RMID, and "not many PMGs" may mean
one bit.

That brings two problems:
a) Monitoring counters are not moved "intact" since hardware will have data
   for old PARTID.PMG pair while task has new PARTID.PMG.
b) Destination CTRL_MON group may not be able to accommodate new MON group
   because of lack of local PMG.

The last few messages in this thread focuses on (b).

What Peter and I was wondering was whether resctrl could assign an available
PARTID to a new MON group with the new PARTID automatically inheriting the
allocation associated with the CTRL_MON group. The CTRL_MON group still dictates
the allocations but multiple PARTID (CLOSID) are used to enforce it. As a
reminder, the use case is that the user has two CTRL_MON groups and want
to have a large number of MON groups within each (one MON group per
container) with option to move a MON group  from one CTRL_MON group
to another.

What we are considering is thus something like this (consider a system with
only two PMG bits but many PARTID):

# mkdir /sys/fs/resctrl/g1
/* CTRL_MON group "g1" gets CLOSID/PARTID = A and RMID/PMG = 0 */ 
# mkdir /sys/fs/resctrl/g1/mon_groups/m1 
/* MON group "m1" gets CLOSID/PARTID = A and RMID/PMG = 1 */ 

At this point, due to lack of available PMG, it is not possible to create
a new MON group nor move any MON group to this CTRL_MON group.

The new idea is to support:
# mkdir /sys/fs/resctrl/g1/mon_groups/m2 
or
# mv <source MON group> /sys/fs/resctrl/g1/mon_groups/m2 
/* MON group "m2" gets PARTID = B (duplicate allocations of PARTID A) and PMG = 0 */ 

This is expected to be MPAM specific.

Reinette
