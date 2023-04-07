Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02B6DA715
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjDGBrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjDGBro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:47:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6C06E82;
        Thu,  6 Apr 2023 18:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680832063; x=1712368063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vKnVtNXTlMpcCVb8eRixYQE1SVjmFtMiXE2A8fz82Ak=;
  b=hexbc0IjqircIv/5UvJzBLvvUqRSun/UnYPRRqWAoEOo85/0H57lRV28
   0lYIaWTHQbZ9ZH2oihtKAG5jNCTV+ZFdNXT4z8Sm46ewFeOC0lXsB9JX5
   yjFGcDa7AgsalFhRUgRwMZVaCj+JRwfSjkh+U4eHFSq2xf6NBWrr+cU4u
   Wv5EkJpH31h+U0Lwr+81nFlvFkSK4z9amgyxxSi7sXUCs8tuhCxf6tFjo
   qOYxxUK4UQ0Fvr7guM8Re+5FAOqPjkkhBDHpU1ro+e0aPJATbU85o41//
   l+z9f+4eQl2Y8Mcxi8z1ybL8f+w0HhSyViSsGqzTWTL8r7jwyMzUhJmyv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341640590"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="341640590"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="776687731"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="776687731"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2023 18:47:33 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 18:47:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 18:47:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 18:47:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2Xt1Djsd8QnKpjbdXWghZXFIH2SNpbwfkF1JPRV3/n1HvA/NiNnZcABj3IyXGbRuxLfl4NTcP3avrboF7rwP74AkuLeQbAqhMuxwyRUfZ64kjMbWnccHJbu1lLqpFUvMPwfHvHL8yn6jTmu33or5PK6F1uDgo7PGpgZ5KCMMJLficuOuJztx25P69rGuxu/HjRzGr2pt1BRE/Dt+lE27RfmGDC6A/Qa2VQ+cU+fBHolTCqdIMzCJUXdcgVLxoF3es7SSd3dC3dHs2QRF3rMxMDydnIVSEp8CKhZbBE+EIxf+uIoFNsekcBLJlIZN84Gx+VKpprk0Z2sKwfL7OA29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czpTWxFwHj7Zm7JcWqeqhx4PO7Me6SWNPMM3OFhLleg=;
 b=bpNlWtu+0LvOtPWhw9Iz3rOTDG9sjwFjwEcxRijKVrQZty53wRUiENAaAdkvWBDUd21WIaU7FefNUz8huxbjQ+sHLpb1LPtBGX8FQ1x4H7SoSIV+jLbiiy42GOdO3WhatjCmFU0arAlZxkkjEOWjjxIvGkhJ+P49IV5t5I8of5+bDKKCoMeol9viVSc1IRVVieMvI10RVU4ktVFyJyoOWu3UIjSmqB24b9RWrxFRfDiaP8Qtd8UFhNrZkcEUBzXRRdTPJhbtxdPTNRyu0YKs1QIXkxXN37klUho8ZLHZDM4KqT6eHd/Jehiin5lGPmoQa33KKUrAK6j5FS20nL17bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.34; Fri, 7 Apr 2023 01:47:30 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%8]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 01:47:30 +0000
Date:   Fri, 7 Apr 2023 09:49:03 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     "Joseph, Jithu" <jithu.joseph@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>, <heng.su@intel.com>
Subject: Re: [PATCH v4 0/9] Add Array BIST test support to IFS
Message-ID: <ZC92jyJUhtzO6KmT@xpf.sh.intel.com>
References: <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230322003359.213046-1-jithu.joseph@intel.com>
 <49a3b712-bb17-0ec8-4598-fc40ae2ba15d@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49a3b712-bb17-0ec8-4598-fc40ae2ba15d@redhat.com>
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a2a064-2772-45a6-6519-08db370a0c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa0nhLh3l4ohJ2WPzAGsGWZLNF6xDl+J0cTGxrOAvsNHFGzC6BehoK8OxlVUOTVHOA4eC3AqXOGPIsz3+wOkt1jcrI4aSZfN6fg7zOhBF8WWs9NMGPNyTMDWjZVmoqfMUm8YmtiPDAHUFOcDr8ZWrQqPWKvGnzFGKNJi1WMS1cmOcOp4mjuPnsg/qU7QdM9ZF9C8T2gS6is38epcwbBIIg5GKPr2dl4OcGb0nLrGjGaaDj0bijUjaotTPzM+Tev6g2ZKhkN77ylw82Y61dY6icHkES9hELbkcXSks8E/5kH5OJNb1KRQilHrl5eCr+EGAIBc/MwVmzue7vHFqGJIgYRs368O0wYovU+YTxtB8a0BVqM+OYF+PFYrxjhxCqPeWXEc9iwyoIbZgZsmiIjNBqod25+ebzFiGP3rndKYHtRV6FLpvuJlsZTtgJvpVzmgLSJg1floQiTtyo/HvCd87r7THaAmtlaxGouOAbKoSDmhD2WOxOON3UssEgF1kZ+/ixFzd372hwV0PK0SUDszzdvhMMODGJ/h1zkcOLIp6Fz5aabqa2yTtIbr/LPxuIkdrrTXzGkhNqpp3Q7CwWOvFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(66476007)(66556008)(4326008)(6916009)(6486002)(53546011)(966005)(54906003)(6666004)(66946007)(8676002)(316002)(83380400001)(6506007)(6512007)(38100700002)(26005)(186003)(41300700001)(478600001)(8936002)(44832011)(7416002)(86362001)(2906002)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BL1cakIRH8HRumm5i7pZ63kYInEP26EKQgEbIYDFpACOC7jELOo8xbwzTJJu?=
 =?us-ascii?Q?zQ5GlQpA9pC9Pp5kuu+57wdfsZFho30LXNeyLQFpGXTVh5Ed5Dt2/9jOFBM2?=
 =?us-ascii?Q?Uolet015OSpLz/0fAC8ZgZMDa/RbMqoLqVcYryD6gutCDztNhvz30Ojmpnk4?=
 =?us-ascii?Q?roAE+Pb7CWJEiWoSJQwYm7iqZskmhCG7indrtQqKn6OQBpEsdj5vPVOkpQ7d?=
 =?us-ascii?Q?17Ok/ya6EgePQD/UgXzUtKSDXjb6eFSohk3Kihf4WJw+iC1sX3tYO1nfJPlx?=
 =?us-ascii?Q?OeZh879e4AW9zU3AnieTReD4lDRjYgGFDR/TPh/fRQyiJ0QmvsjhIROjfqOp?=
 =?us-ascii?Q?/uhVJVAt25LEZHj776BVXdK11R8djEMN5M2ulJzx964Ya7moJYBpRsxFFlmo?=
 =?us-ascii?Q?MrxuEurF0NiM/QGfh9FhojUSurRGPnFnPqZuBDluiiEA6Kybm1Z3ivGnh2ku?=
 =?us-ascii?Q?v3B1qw5uhF4OFWmyvgg4zFvUPMkiXPOOKqQmTOWB5Adcn8Kycgz0d4Sxuyu9?=
 =?us-ascii?Q?BdjWim6tvaUu4thkliirK8xSMBQhRERLUMben16UP3xgpmxf40LD0MB+d6L+?=
 =?us-ascii?Q?czuZ0DRB7aHxQ3A97hkEvykDzc8Lq42vjbHO0eodFrGrosH2y1sXlYcBGJxD?=
 =?us-ascii?Q?XrYsyvKOJmrAFc958IoXSwry0iqZKAWvIPLKx8+YffApylpYPwsIO7BTjsca?=
 =?us-ascii?Q?wx4VvZROqImhoKTaoOzpr/sVK6b+/J/PJS7m7nBVZ0gmdX9dGsI+BGQJDpJ1?=
 =?us-ascii?Q?mhSO/qMJLocKLaR8zld44+HtdoCottscRpNYm7OE218vJsSxKgFpOn1vjA79?=
 =?us-ascii?Q?dl7gZJKf8362ME/CfK2OH2rtz7M/y/KfZH+iQLpHKVOg/nVY6EByyPhq9ZZX?=
 =?us-ascii?Q?2NidOTNOEyf9KyAcXpZrS0Otewbec8L7oWjMYJqklJ9KVS6UYHgKFEWo5N4P?=
 =?us-ascii?Q?/UIQKN70BW3XdTeVETVAzJTKIJc5J7eax55igiHdF5+pbECu4HNtSsTkTdXf?=
 =?us-ascii?Q?h8uk4aPqfwP30HNyO70fj4G4vyXHKmxchcjHvKnUbGiw1AiVvsriAHLjQQQu?=
 =?us-ascii?Q?Y5OvoQhRC+wjODZm1x7bbfrTAf/KrsQNQOD3IejOuPoCgarqgMLspvCrCbf1?=
 =?us-ascii?Q?fk2BFqA14Je3w35fegKmmIMZJ93AUS/VMR3kJuvM/5/hlHJdnfczSWpwtMPM?=
 =?us-ascii?Q?E/K9kQ5PT7RzXJabnLP0QhfHMbpiRfWTmqO8Zdt98gkh5MHI843pAz2xUnUx?=
 =?us-ascii?Q?ow1XdrSaiA1TamYLOcyo0mtq4eXNO2pJtfEFazCKK6BlGeEC0TLhMsAI5za0?=
 =?us-ascii?Q?d8xpNgd4s/27lVLpaWVlJwTfE8ymNeF656WczrD4CXjnGmRk9yIv+67kvNhI?=
 =?us-ascii?Q?mEMEa4wfJREi52e/XSBROvaZCKHfzINpKHNp0nnjpJhP10a5afeBPIHyblfB?=
 =?us-ascii?Q?IZGhcuFs6VGV2eBoaJYq3dDSfviuR3oVuphP6l6dEsCg3LL7Ih2HOvttxbEk?=
 =?us-ascii?Q?2WUQN0xeXIASWaRX0YQj1P8fu0Hn0B7LXKdMWB0Nco0dxgsA28OO4tgLOh1z?=
 =?us-ascii?Q?rRJqm7QzbjmCEVal9Mq0lNrkwpXzyFvlyzbvjwkf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a2a064-2772-45a6-6519-08db370a0c89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 01:47:30.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7GYPTfnF24FTCJm2bsDDZ4UdukzvuEpBKK/aAFtJt8pScivLKWlA2QbZIedPxj8X9vJwv9xTzHCNDxDz7e4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jithu and Hans,

On 2023-03-27 at 21:10:45 +0800, Hans de Goede wrote:
> Hi,
> 
> On 3/22/23 01:33, Jithu Joseph wrote:
> > Changes in v4
> >  - Hans de Goede
> >      - Separate patch 1/9 (Separate ifs_pkg_auth) from reorganize
> >         driver data patch
> >      - Rework patch 2/9 (Reorganize driver data) to define const
> >        ifs_test_caps struct and associate its pointer to miscdevice
> >        and to remove dynamic allocation for ifs_data as was done in v3
> >      - Move load check from run_test_store to do_core_test()
> >      - Expand ABI doc to qualify which devices support which attribrutes
> >        and the device instance to test mapping
> > 
> > V3 submission:
> > Link: https://lore.kernel.org/lkml/20230301015942.462799-1-jithu.joseph@intel.com/
> > 
> > Changes in v3
> >  - GregKH 
> >     -  Separating read-only fields from rw fields in
> >        struct ifs_device (patch 1/8)
> >     -  Remove the subdirectory intel_ifs/<n> for devicenode (patch 2/8)
> >     -  Replaced an enum with #define (patch 4/8)
> >  - Dave Hansen
> >     - Remove tracing patch
> >     - ifs_array_test_core() (patch 6/8)
> >         - fix an initialization bug
> >         - other suggested changes
> >     - Use basic types in ifs_array for first two fields. (kept
> >       the union to avoid type castings)
> > 
> > v2 submission:
> > Link: https://lore.kernel.org/lkml/20230214234426.344960-1-jithu.joseph@intel.com/
> > 
> > Changes in v2
> >  - remove duplicate initializations from ifs_array_test_core()
> >    (Dave Hansen, patch 4/7)
> >  - remove bit parsing from tracing fast path to tracing 
> >    output (Steven Rostedt, patch 5/7)
> >  - move "ATTRIBUTE_GROUPS(plat_ifs_array)" to core.c and remove
> >    exporting function ifs_get_array_groups() (Greg KH, patch 3/7)
> >  - Generalized doc and ABI doc (Greg KH, patches 6/7 and 7/7)
> > 
> > v1 submission:
> > Link: https://lore.kernel.org/lkml/20230131234302.3997223-1-jithu.joseph@intel.com/
> > 
> > Array BIST is a new type of core test introduced under the Intel Infield
> > Scan (IFS) suite of tests.
> > 
> > Emerald Rapids (EMR) is the first CPU to support Array BIST.
> > Array BIST performs tests on some portions of the core logic such as
> > caches and register files. These are different portions of the silicon
> > compared to the parts tested by Scan at Field (SAF).
> > 
> > Unlike SAF, Array BIST doesn't require any test content to be loaded.
> 
> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
> Regards,
> 
> Hans
> 
  I have tested the IFS Array BIST function on EMR and Array BIST function
  was passed.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks!
BR.
-Pengfei

> 
> 
> 
> > 
> > Jithu Joseph (9):
> >   platform/x86/intel/ifs: Separate ifs_pkg_auth from ifs_data
> >   platform/x86/intel/ifs: Reorganize driver data
> >   platform/x86/intel/ifs: IFS cleanup
> >   x86/include/asm/msr-index.h: Add IFS Array test bits
> >   platform/x86/intel/ifs: Introduce Array Scan test to IFS
> >   platform/x86/intel/ifs: Sysfs interface for Array BIST
> >   platform/x86/intel/ifs: Implement Array BIST test
> >   platform/x86/intel/ifs: Update IFS doc
> >   Documentation/ABI: Update IFS ABI doc
> > 
> >  arch/x86/include/asm/msr-index.h              |  2 +
> >  drivers/platform/x86/intel/ifs/ifs.h          | 68 ++++++++++----
> >  drivers/platform/x86/intel/ifs/core.c         | 81 +++++++++++-----
> >  drivers/platform/x86/intel/ifs/load.c         |  9 +-
> >  drivers/platform/x86/intel/ifs/runtest.c      | 94 ++++++++++++++++++-
> >  drivers/platform/x86/intel/ifs/sysfs.c        | 21 ++---
> >  .../ABI/testing/sysfs-platform-intel-ifs      | 17 +++-
> >  7 files changed, 229 insertions(+), 63 deletions(-)
> > 
> > 
> > base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
> 
