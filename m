Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E736688FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbjAMBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjAMBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:18:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D441015
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673572681; x=1705108681;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8by/bebV3OO9mONt/TAK/Mh5ojmjZSFGKSCr6y3nyRs=;
  b=DYtmIEVnb6A21iktdLLL0BLg9xv8otkPoaIeJ+7xRWHy0oR2mYu9evQH
   rscdonHmhupII68+w4li6B8d4TL5dMEF2j/IXrmYT+sW8WPzrL3X0mJCS
   EpVhJPXcpNPD97H2aLnkBU7hxbM52iZdUDeQeHcE7XVwfXCbfHL1BqJXD
   CvFd6LoD/+4+7N2AWI3LpPyqM8eMLUm/UyXpLgWeMJt/RklMWg8cCpNPJ
   pXQJGxiOAQ4VJLMmS/X3ezTDGeBokjuKcCJ7cVTfyQayGm9q9IZtWr/Yr
   xAxDXaaPH512JeCVMydcNmbcHj462+KdI7lqNogasn/X0Yg+owd4ManPI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321581704"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="321581704"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="765833073"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="765833073"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2023 17:18:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 17:18:00 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 17:18:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 12 Jan 2023 17:17:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHKRiL9pf38XiTmQFBHTh6ZbNqQpOmAsnsQ6dYqGlG/UeKT6XCIi3JU8NUTYZCbz892BDFt5eaUre9YcFSZ9Qyt2G2eIJvOZkxs90vUGnaobiXcH3LzcdJmtZBLHyHk4jhk/E04MpWtWXhU4fIUztRPe0Yk3PkixvIk2iNMUsA81j8vXeCowTClQvbGDLCMC9hh9i7TVQ+eOl53ox3nfbLZ56DsDkTyokjchyN0I20EKQmwGEhmfvS2xNELDjG2WOEjUlGjVfKu6SPIU0qztGr9rr8FdyN/0kn33oJd++nTlULjZ7wN1d/ggj337oX/XOnD4Xvpvbh0llJSW8WUZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkdiVdprx1nnKRG7pahiGLdxbkjQMWmLRnGuOle24co=;
 b=DyP4q/LtjGwVr+zdaD2iLSOgtOopTktO3+77ASs8sgep3lod+/WLcEWBq+KFCaNYGJexNSDfIKeBDcQU8qb0NKY2AsmhAaRoqIX4a0I2Qs5d41X7UMP2RcVyOpYyL3zOyiXMf1H6APeFFuiV+kDyxM3eu7I2S2xPFgcUX+e8/tp4zrzSLRFgtxxJdUBud02Lx4h3LXQhPXJmrYkjZScL8y8yR+tHvH46VRwqAFmQXxRmbqAIvGlQMBEbdGn0at7Bi10jOE7+igId5JgfKvKhgVN1YH+WwBR1OB+tXx3U1gnIqJ9rIXeSBR7Dhu1hhaTi4CNtAvMI8sUI1QDXEYV8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS7PR11MB6149.namprd11.prod.outlook.com (2603:10b6:8:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 01:17:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 01:17:55 +0000
Message-ID: <f6d16f82-9cbe-993d-88aa-1644e89c4fe7@intel.com>
Date:   Thu, 12 Jan 2023 17:17:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space
 Separation)
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Yian Chen <yian.chen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-6-yian.chen@intel.com>
 <7e859e72-4624-73c7-8195-c252ace0a49d@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <7e859e72-4624-73c7-8195-c252ace0a49d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:a03:100::43) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS7PR11MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d108fe1-3231-4ce1-b448-08daf503ff98
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOMtnaWT9Eu2y7/bY4dzc/yjvo712OdQDInM4H1BnZUhK0RQ8oOeSHLeSNMLeZrnAEjchzZn3P/8C8dMaLMnB88qOnevis4tWk71iVUNFlAFvrPBYAFE5V6wd+UdWyYkzVPC0D1u2YjV5uUJztq3t7W5tJQjHaSC0p43MFFK2DgEColHlbp+exjttAT9iHoV1XrVKq+ekEczBVa/fNbNOPk5CH+68QJIui3zZvYbFWFYYkymiWaKs8P35+NR20E6d6k60GuWxsEoVm5/Lm9lNB8GBnwVICvLbh2AU8V470sa0ZiKdtGD1AXXjb9g56GaXOHmFQlMO0R85h+qYkMuAAPAtjBXKY4D+Crz2PSjLBGHb+znqXVB6VZiBD+o9j/5wGKlU6/fXdIq9szK9Xzap+lG6j0U/A7O7uCRPlkkdBzf2yScqf2ITUD+dm0UB355OAjqktqFpkrOxgiXwxbc14W30yEPDUSgvhggkw014ZTAcXH4z16BC/Ch/Ho4zcIv+jeFJUe52SxFLVHC1zuH+aQQ/ZAcNwQ0NbRo3ZxkAEb/VCLcjdVEQcKD0B7YAIpXP+bdlBIRuDU8RkwpJoSdYs5QtgQmwD8FcCgiOk7d+urnv9tF5aN4d28udfH7GCRYOmcdKdh7qUUrhU89zMbrNOi8gS/9yIy416bvMAySoVSfB0woAIoice/sW2S8U1lRlosubqDq5MG1aXKBDoPlQSM3pPb2DnBVkGftymx6la8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(82960400001)(86362001)(31696002)(6636002)(110136005)(316002)(31686004)(2616005)(8676002)(66476007)(66556008)(66946007)(478600001)(6486002)(186003)(26005)(6512007)(53546011)(6506007)(38100700002)(36756003)(83380400001)(41300700001)(44832011)(4744005)(8936002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlBVHdWTWViZEFRVkN6MzRIYi9RMVh5RGF4NEY0RlErdld0YXB6OUFEYk9t?=
 =?utf-8?B?R1VYZHpRU0w1Mm4wQ2ppTE41UGM4RWhRRFFaUmp4VlJHUjJBaUZwOW5zSWo1?=
 =?utf-8?B?cFFWNGV4SVo4TU05SHVaTStBVDFYNERpS2ZUWXhGWkxpQlhVdkQzMEZZdzhI?=
 =?utf-8?B?UVdTei93MHhzR1VyWVZOSTUzRDloWXRTQmZKRHBGQnljRDgzK3UyUVhMWklB?=
 =?utf-8?B?WHhNeVpkSDExK241ak5uNHdNZGZzQ1R4eS9ZeW42L0dGQWVha1lzNkRHYzNN?=
 =?utf-8?B?cHBuOHExSEdyaGxCODVMKytMN080Q3JSVk9LeDFqKzFsNGtNVHgzcUNicnFq?=
 =?utf-8?B?cHkrek5YL25TNDZJN2I0bDQ0cFliazFWLzZoUDZTU3ZyY2h3K1ZpREp2YnVh?=
 =?utf-8?B?bUEwUUR3cEJGSW4wNEhqNjFpWlo0cDdOUkk4dTRYNXd5NnREYU45Rmc4U2d6?=
 =?utf-8?B?YVlGYkFrK0FYZlYvNHQxVENwQ1paTUJ6OFpja1U3cGowUThxK0E1bkkxRitm?=
 =?utf-8?B?RGN2Qnc4OCtIa3I0M3p4eFRraE1ieCtZWmd5bk1GYzNmc1l6MER1ODFsek9l?=
 =?utf-8?B?SW9oRG1OZm9HcSswRjkwbGJZZlUzWXZDNzZhNFNScWpNdmNJQ1lqVmY0MFlT?=
 =?utf-8?B?OElsVzNsQW5qanNwazRNMkZMR1ZrSlQweU9YOEk3UkZNdFkrMHFjQjNTSzR3?=
 =?utf-8?B?Vm95TDlrZ2UyMm8wc3BXVkIrb1E4Q0pDZzlOZW1kR0dFeFZUeWFVbm1iK0Nj?=
 =?utf-8?B?RWVhclNyWVh3eXFtRXZOM1NybFVjZm9lTWIvTmlxRGJPQk5SRytrT2dNTmhC?=
 =?utf-8?B?YUJ5TU9JYVpMU2dRN0cxUXpnK2hjU1pGdFliZkc0dTZVSlhwZFRMZHRLV3V4?=
 =?utf-8?B?QjRjM25sUUs1czc1VVYrRFdCU1RBR3hkSEVLRUFWVDFicWk3WC9PMmZjYWY3?=
 =?utf-8?B?dUZXQnVTRmY5VlRvbmlwOUVQZnEwbDFRT3Z1YTlTSmtKV21pVFFIc3AzbXpW?=
 =?utf-8?B?d2JLZnYwRXZ0WklvTG1rUk0rZnBoUmxvelkxY2ZJbkFPamM5SkZXWkN4UGhC?=
 =?utf-8?B?ZkRkenkzb3A1a2xFTms3NVlsRDh6b3pXUEIrZWJlRmJnQWxPcmx1WjVOSGo1?=
 =?utf-8?B?NzBIbk9iZ3I0MGhZbTVxeGZIcHFsTW8yNi9QdndRRi9VMmpNeEFQVU5ETTA5?=
 =?utf-8?B?by9PNWtJaWlmMWVsNE5ldU1yemt4U0VGUFJ5UCt1ZnJ2by81cDFTMmhkZVNR?=
 =?utf-8?B?VEVMdVRZanUxY3hVa29mLzhLcS81SGNCdEJDMmc0dTJGR2V6RW5CZHdlbUZj?=
 =?utf-8?B?NUNTRGtTSVkyK0ZmaGswcU5XWS9HTE0wU1ZTV1Z2cW9yUDE1NDZYTzBLVUhY?=
 =?utf-8?B?L2JSellyVzBLRnBRVnZvVkMxVUx2enFjSXhLZnFTRitqRWxkVEQraUZIUVlN?=
 =?utf-8?B?WFVjNWVYTFJyeERTNHB1Q3BsdTZpNVhRZkxlT29LUGF4NHNRRTNJdVVhZUQ3?=
 =?utf-8?B?K0x1NFhHdm5JM1RZZXVqQjErMnlwUXJsOFRIcmFrNGxSNFA3cW92VFZLeEcz?=
 =?utf-8?B?V3hwU2h3bXlaN3Z4OWV4SXJMQjZFTHpCdWlTRVpZMFZ3cWYxUjhYSFhIVjI4?=
 =?utf-8?B?QWUrRE5xK2RjaU9rZWlSQ1VlR0ZtV00zMGV4V0llRU9xcEN4aDl2UjFqWXpo?=
 =?utf-8?B?V0RBU05mNmdRZk1LcGx4cm02ajFNRisxejNtUFk0aUxVQzJxQU5LZXhMUEx4?=
 =?utf-8?B?N0E5MEFTY3AxWmtCNWVhekdnSEVXZTh5eHdVOWpocGpiYkJUSFRnZjBKTWdY?=
 =?utf-8?B?WWt6N2wzUVk3SHZFMENvM3loOElxYmVML3ZnL3lHcEtvKzJFbEVBcWNTWFlC?=
 =?utf-8?B?YzlpekhMMzhOL0o0NnZabGkweXRnd2o4eTIrWi9GUDRhZHZIVG9PS05rQTRl?=
 =?utf-8?B?M09uTXQyY2w2eTZNcmtxQkhEQ1oycmFld0pBa1ExZmhWdnVHeXVYcVNYMUJE?=
 =?utf-8?B?NGQwQnNwcEFYKyswUEc3S0hTcWNOZU9iUXcveW5BQ041VWdnOVZrb3RKTENY?=
 =?utf-8?B?Yk1tb1FkRHdBTStXSlp4NEJGSXYxekRrUXRuTVZFYmJyZXQxbXQ1bjhxWVJh?=
 =?utf-8?Q?uhFxvl8eElxeBRL6XfsUttQfk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d108fe1-3231-4ce1-b448-08daf503ff98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 01:17:54.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ag/OYeR7SKRkhSiPE7SDzuYFfHaOAQNQ3gzi+9vaOaDHPn9qk59NZT5oADRZt5APEGMHjDckthEc6x1FG9jO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6149
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/2023 10:17 AM, Dave Hansen wrote:

> In the end, want X86_CR4_LASS set when the kernel wants LASS and clear
> in *ALL* other cases.  That would be simply:
> 
> 	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> 		cr4_set_bits(X86_CR4_LASS);
> 	} else {
> 		cr4_clear_bits(X86_CR4_LASS);
> 	}
> 

Thanks for the explanation. This is very helpful.

> I'm also wondering if we even want a Kconfig option.  Is anyone
> realistically going to be compiling this support out?

I was initially thinking we should leave the Kconfig option for users
that really *need* vsyscall support. But, thinking about it more, we
don't need an LASS Kconfig option for that.

We can make CONFIG_LEGACY_VSYSCALL_NONE as the default instead of the
current CONFIG_LEGACY_VSYSCALL_XONLY. The kernel can disable LASS at
boot time if a user/admin has shown explicit preference by selecting
CONFIG_LEGACY_VSYSCALL_XONLY or by providing command line parameter
vsyscall=xonly/emulate.

Thoughts?
