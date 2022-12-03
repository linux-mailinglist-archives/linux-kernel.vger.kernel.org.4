Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DB664130E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiLCBtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiLCBtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:49:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90DBC85
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670032144; x=1701568144;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RKEtMg5hCgeDt4zPa1BCokUM99d8aifxekrkFVKk7c4=;
  b=QvMK74JwDLyNu/QRyfsBdHKoAFSD6byxCBb0UfkxPxm7B5w473hiOyq5
   jweLOvxEvxXTpq4XLOqMWalyuU9SnVfun/w2wyL1rop+iCBEWR84A7M/a
   MLVT363FHwdsZeJitnncBZ8U+Ha5IMmHFZVGBCI3p7OedkfIBa04Miq/C
   8Bt34m0QCljB8y+F7zxkCRES414j8oqtN+M3FcJxty7fBIp/WjxF8wVgr
   mOWpe80aulrOfI5zEx3w5Cy7gBuifzJLyZkFTIB3vryNv5+ozH8OlCtA9
   jqxbvK+fJWi72d0hYyyoErbJP6GaQ6snzjQmb+ySQREPOcbPmkYC/FdZm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313720795"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313720795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 17:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="676026538"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="676026538"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2022 17:49:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 17:49:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 17:49:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 17:49:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuQbGlBxJkvWZcJx2H7q5SMR75W5qg65UhrZA57oU7RENzeEp0QvSEuWybePZ6QUvAgg9tAkL65vHiY5oR2qZ7tuT1k33Rn1gapEOI4nMH6daV9XHfNK8vpvMDUcX4qbcj9k560gvhZ7merTY32YpJ8p1sDvt8bQWPQPMCx2M/WqzWqgMLfl8+qOun1i61sPz/tKOMGiN7lGwKKu6ZwEdtyPEhkDrPZ9UAffJTYeGzgTZSPq05msZYV4H4FU8JwFdBRrY526Y7IkZNiK/w91c7Ap1EYaXtlyyX9XvRhmjoCQmHAYKHIGejxbDZNUAL6NTTQ/FO+aFBlrLYKLxYHJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA6shs/obr+2mlMqQ+HSZkqtjuNXtmZCd+QVCMgl+cc=;
 b=JP+7VATdspCOI8S1jceJ3Xj8xV1KydBaKiYEeV/PgcGoC3I5id7CWzRZkZqHrVzg4irDc00B3eVE4hIxXtDaMEHjUKrFVU/co105X2dmOyDZYrpNl1s3UHV74AhNxSLp6bU/8BWnEGuVOszU017XiK2wTAnQByaGhoaLb0JthotNQSdq1iqbnQtRx47d4g+icQB71D1BZMBfPCXBP4n6IJqGe+fVXxUAF05C9RnWsdPRHaLxEZKJB1efxZHXilHZG83WRTdk1ERr+66Il79i4MwmefE314uttjXeItAcWo8AWEJGtuEdKZ8lUu3+suQ3Z371UUuij8z0gI9PtorTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sat, 3 Dec
 2022 01:49:00 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5880.011; Sat, 3 Dec 2022
 01:49:00 +0000
Date:   Fri, 2 Dec 2022 17:48:57 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 2/7] x86/microcode/intel: Remove retries on early
 microcode load
Message-ID: <Y4qrCUm4xjBoe46R@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-3-ashok.raj@intel.com>
 <87a645pr31.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87a645pr31.ffs@tglx>
X-ClientProxiedBy: SJ0PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::28) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY8PR11MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 576447cf-eed9-46d7-48de-08dad4d08ca6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoj2lYMjZ0+oTDgjooIjBHwDoscJgGReNIXJ2auCLx3LeCXLxpuJrtQOIYi4sSveoTAMcg7YZU1ROcD27LkGAjpzvLWKgzC3QKLG6C9HeykSTlDOSydqI2m3SfMgQviQeUT4UlINp9BnfLjIi/6AMLUkE8fzbdHYxuAHOUx/IvdvCFZCzo+/7alcwOH2CpqUCgqYVcbZR3bV14v65ONhVFAnTuyBEIj/EYjjT9KvxFn+5XuYIQO0RYMS8w+I/w14Elnwgr5xAupykx/RTp0JQVfNFTpnnP0sPi3vhRa3tPywW9KPVMQxCcd12Rfoe1lVUAUmIYdUk91F51b7OQvyvh5cBn4gu3E8j9yRrhQwcG9aCrUuPCO3VMGhTjrEK3If0hRN/zg69tvQD1CGtPfw1HL+Fnw6l+eL+UCUto4V4qX3NpwUudj2VpXt7JW+ygAeTkFzM0t0+x1gYFUXF/yVBxW2C9jo0g+kiBZEYLechkcdk16Q8uTX2SEbiOiQVdu8mDzfnW0wKxysH75QhY7Sf5HgyNU43wZsGee0TwbCXJmi+/5zUd/9v4gPGp0YNT9km4fgYYHT2pDfOFd1TuBg3h2wDSlW1w0YK5XrDl3ET9MTLRJz/hY8Zs7gcmG6vpiwiRF73dqfjAAFZqZO90qgGcjgyiZ4ugD1JVfG6q0EZK2gg52cbrNvfTolmw2eoG6/zDDviwFHFKOTxBMsp/9mlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(6506007)(2906002)(6486002)(478600001)(966005)(26005)(6666004)(6512007)(107886003)(54906003)(6916009)(4326008)(66476007)(8676002)(66946007)(66556008)(41300700001)(186003)(8936002)(316002)(16799955002)(83380400001)(44832011)(5660300002)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A06eyR4CcgExGnksCXpvxz7L1ZrRUTp9YH3DwnDXHuhwu/jdhMjSPzAxzcLj?=
 =?us-ascii?Q?8JyHHaf4o9gh3Vsmz0BSfAkNZEAgE7UGwljty8kUFR/N9pXuStLiLxMXE9Ij?=
 =?us-ascii?Q?JicSaNiKwamC3I+3MgeWLtlSNQ3ZC1+qRK4ADPmv/rKcUoTS7NzpTED2Ds/L?=
 =?us-ascii?Q?NYCuFiiqv2fB0mjMjoyBuLfjl9+A+57RkoFJrj1JRT23ai0SUeyXPORoF2Ya?=
 =?us-ascii?Q?mxv1NdGguxXQ0v6FBVUs3ZhED2Caf0z1Cf5Dn3IKBOMbOmGygIfFdGNAz8wu?=
 =?us-ascii?Q?SIowQybwzWV7JxQj8kZJOZcaO6cHtd4d/EN7LMqdVT8+/iXqcWsMQ+QUyi+r?=
 =?us-ascii?Q?qyqwhYLKdGkNOwlK2/Gm27cOlED3a4k9VlWpN/HgEFBkozl2mxpP2CpD5O3q?=
 =?us-ascii?Q?6XjDcgsN++SqVJm7e9G1OkabjFwUSp3lW3E4Kz2tToQfKChevwGdkjsXppmB?=
 =?us-ascii?Q?QCSTu4Q5awCP781NzYxobOQsyuDkp6Eh0txkDVugSfUv9i+TZ/jVb7aBszx7?=
 =?us-ascii?Q?MZVcJ8j0nPHTZIaydnFlqpbWKK+0FAVGy/v0rbyaBtI1rLNEcYE8DAq0cZFv?=
 =?us-ascii?Q?aCNvZkx46ndtj54SCsHWREWeD8iMDScrg+0FVcpF/edlZbvJwDDTJtkHfwme?=
 =?us-ascii?Q?b5Y3mvt4tmHhuurB970TX6i7/yPKsdzQZlwNvuQcFGu3x9MMw9DXA4rOk1R/?=
 =?us-ascii?Q?+OSbv1mYJTfYPIh0MWFP+aJ8psfv3Atwcuj+uHHC/nKDr1OzwRyvtyl7i567?=
 =?us-ascii?Q?LpxAg7EDqGnOXtop2KuTz5nvbI7Zu2xPnrSs6kNRwJqmbj025EgPJNuYC3ak?=
 =?us-ascii?Q?qhl6INsP6osR+eSVxhyBE1R/Au7VkHZ6Z93/QwRvrgOlPQiefchbab7IKZ0t?=
 =?us-ascii?Q?ZLkdbUeEajgeiDaa3ATVYTmV0rJYjgkZsPuquY/D659BVtVQ2nCLbkkMVu2g?=
 =?us-ascii?Q?pHqowSs+vqpheQFJadeKBOroO55R8lzPcg6HGhORVqMaCnMFRdI1V593XYIp?=
 =?us-ascii?Q?PmYhcDuVZBFxTRwv8BkHUgoRy00Vf5Cp94GueXC9Gs2wdHmGjWlPPWf2m9Uo?=
 =?us-ascii?Q?EFRtcAOw2FS1Ik18qEOF+DUeChYxCPSVkW6Cs0D+1SjLstJxZfDC5C+3MR7+?=
 =?us-ascii?Q?3WFda59ohcdPyMaqsvFo2PqwcazYi+ihq4IReqxUCoKAFIlvux2YpEoQ7bMb?=
 =?us-ascii?Q?mBko2ke6wkg9Q6o2aVcULBIQq66PKJbQ6/yEVoU68x6MdtuSzHaS7WrQqGtI?=
 =?us-ascii?Q?osfmcTiMFsMnpr8KXKo4kztc6pm+nDWGOkIqFPCVE63iJ/QBb41UpmPaCnKw?=
 =?us-ascii?Q?DLToEwfv3F/m8HxXHFadUEkMoFzZpi32t0W9XzZ8IzRj/eTyyNBEfFDnCGCq?=
 =?us-ascii?Q?N4EPQMTASUtS9IVy7eA0zwpT/9ZT5QFzC865arUcbNe0FxKsFBzZlCqz8qHq?=
 =?us-ascii?Q?k2Nzr0aLWLDb/BYnX/WVb6uE3i/1nZVUSfwymOnXRAh1+kEOjjR7hRAa/XEB?=
 =?us-ascii?Q?bhedKeULUzvs7hF9/emC5FeiKEBz3qeMJ4+Ik6/nG2y95qZN1mSDv8S71jGT?=
 =?us-ascii?Q?BQLp20DqFw0T987JmnrZekTrZ+O6l89rthmLoAg8ywJVXCRgsjoXeGrHZPvc?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 576447cf-eed9-46d7-48de-08dad4d08ca6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 01:49:00.5121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5GkCHSl5l/KhWuTWg5HBW4o8huLOkndR5y80CjbaRThJaM8TNbvaF5WuMsaf4tyqXT897yR/y4mkEWMeJjI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 08:01:54PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> > Microcode loading can fail. This happens today when handling mixed
> > steppings. But it can also happen for other reasons such as corrupted
> > image, Security Version Number (SVN) preventing anti-rollback,
> > dependencies on BIOS loaded microcode image for some capabilities.
> >
> > When the microcode loading fails, the kernel will quietly hang at boot.
> > This has been observed by end users (Links below) who had to revert their
> > microcode packages in order to boot again.
> >
> > The hang is due to an infinite retry loop. The retries were in place to
> > support systems with mixed steppings. Now that mixed steppings are no
> > longer supported, there is only one microcode image at a time. Any retries
> > will simply reattempt to apply the same image over and over without making
> > progress.
> >
> > Some possible past bugs that could be due to this bug are below.
> >
> > There is no direct evidence that these end user issues were caused by this
> > retry loop. However, the early boot hangs along with reverting the
> > microcode update workaround provide strong circumstantial evidence to
> > support the theory that they are linked.
> >
> > Remove the retry loop and only attempt to apply microcode once.
> 
> Very concise and informative changelog. See, you can do it :)
> 
> > Link: https://bugs.launchpad.net/ubuntu/+source/intel-microcode/+bug/1911959
> > Link: https://forums.linuxmint.com/viewtopic.php?p=1827032#1827032
> > Link: https://askubuntu.com/questions/1291486/boot-crash-after-latest-update-of-intel-microcode-nov-11-2020
> > Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> 
> Nit: Can you order the tags according to the tip documentation next time
>      please?
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!. Dave Hansen gave me script to order them correctly :-).. I'll fix
when i repost them.
