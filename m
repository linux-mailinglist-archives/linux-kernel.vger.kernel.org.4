Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7107611A98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJ1TDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiJ1TDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:03:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB61DCCF4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666983787; x=1698519787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0ZpBr8PZ16gKTHGaF0Pged1U4l807UKQ+VIb3Bk/5f4=;
  b=cDplmOAj2AU86qYCjLMuvAk8xgMelkuvmNxRhXwaGnA8IP9sALWdsErN
   97elZ9WJovlnFkOFwsf0YVVTG7FWmFPmEUARC/xyLhfIUl1z8KDrH/1D+
   zAnu6oUhNMDphUSOirGa1uOMnleHFvzju5xzqqnCNKY2yeuD0NFAklPRD
   CqcmNL7NaR7GVcPGSPkqbUFST69PtOFbAYh0Io+O5MwZ7ENhUCnRvTyHE
   hjO46VXKQzVUGr1mzXoTvW6v0C2ihVtgfdYwm/2T66nVNACXQEEBz5869
   ZAlWxP+bCsfLGk9VBT4qYkNEivffTijoyr1gc/C08AUhBZEDEXxm4ILBG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="310265800"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="310265800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 12:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="696328991"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="696328991"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 28 Oct 2022 12:03:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 12:03:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 28 Oct 2022 12:03:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 28 Oct 2022 12:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko3w8fC2QZZsCmjtfbIujYPhhrhXEamoAcjfh4wMlWjmWPQoNofwXmIg1o911hHL/o7uaQdhR7zTGZdod41dANGhtESVtNaGwTYPnmkpz7Wg3+lr6ncrqH7UXiX/Twuqzh73LztQ2dClhsR0/jjfCc/vV1G9D/LYXhxg42y6Cg6WaaiYBw76+V4oFtRVr8bVqZ6TO4KQ0iVF+aIA3F3AyKzcGycIENDzOBfFaXjnS2iKthXsAhP2b433kc3RhitDYfGSfVOtsjUFu1kkqWptMG3vrGioO/tSFuMUbXMllEOCwLrm+RFk/HEbWL6Mgs1dH5CkxYlwh9025KJIv/JJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWh1VerzQ/qYRqQDyfHbbk2QjSkO0em0tw5B/S+1CrE=;
 b=gSNPkLyXlYzEUt20VpfxTnhmwvMI97Yx6mWqZ6tveC7qounfe0tWnqEXr7BBQ5OkBF45bcripScDyVuxyuy79YOn1TRGUelzyhsa6h2h40DdIacJlivpIlCgGO2E6ZI/ntdN/ixKfVv22q+kYiikolEUSwnLJCMxo3XNivOc/hdb+iRuDwGvB23bvd/XKpKpp8A8RV+R7zQu5319jE47eqIZbbZuh7TBSUO6N/g+54ztRagOhImS0SJwUZcBTVgHrk1qc1ZGunMmNt4pLVo7EaY45WpqDb5N6GPC6MunRLn1bJwRyskemCTR3n0IJlgZMShyQUPy4/glEiUMvP3iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 19:03:03 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::effa:dd0:aa9e:2ae6%3]) with mapi id 15.20.5746.021; Fri, 28 Oct 2022
 19:03:03 +0000
Date:   Fri, 28 Oct 2022 12:03:00 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 5/5] x86/microcode: Drop struct ucode_cpu_info.valid
Message-ID: <Y1wnZJyELDdeIZcZ@a4bf019067fa.jf.intel.com>
References: <20221028142638.28498-1-bp@alien8.de>
 <20221028142638.28498-6-bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221028142638.28498-6-bp@alien8.de>
X-ClientProxiedBy: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH8PR11MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ba04a9-869f-452a-5de1-08dab9170a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7OdxYUW5xQoanirRMrfl9ZAOYZPX1iveJdq77gxKPm4hf0LVjShMajOv1cKCUpuI3VRq8O9pjgR3mF4IhHapx+ujsY1HZsgs0oouJwdExS/Zs/L13L6znIyrE9GtG1dp8DCQthmCSA40DmFkwNIxs52lN7wgNGUBjgZYkHckjTIK31IxpSDA4y/R9e6cpT2CC6fODPlQXSnt9ya38sqibCpvmX0Y8fC2xYj8bMWm3yoqCQKanM6TM/rgwA/TtcvOVHl0+OsKkZZHQvpCxVADHWfeAc/NC9rDt4JxCvP7i81Ce4jxRinXBNDfRbogHwyXAFglnmW/YdIiD5haSpFFnRxjEZJ+qTywCxDJ+Jn+WMIDP5jotSoBvW688xX6inK8q/j1lvcU0k+Q4BNyRLg8Z1XIVjBSPCO1R61Fl2V1tgsj7gZTsJ1FU4pyT+BzwN9P4yC+EbW9zwtoHaTZ4iuJl2S/SJFEjLdan+YOUK5+QfP3j9W6NMNFiBJ5WwoNSUwFuxEgwZD2o9aMuLNeoi9pkaehZ1pq+nB1URpy3Zv2R62EcKBRndq8QdmanPtCBEjei+fei74jqYJ5oPp8npgGclcJvWcu6h7bLkpdO6bP5Cr90Gm3amAO2QDvJVgr+45AejAb1J2DOzxYvH5CfL4TC/YSTf04eUlGic4i3SZnBr+Mn2ZqvY0QK0xPxxJ/RdmrZPYOyb8DgM1vy+awrCshQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199015)(5660300002)(41300700001)(4326008)(8676002)(66556008)(316002)(54906003)(6512007)(26005)(44832011)(6916009)(6506007)(478600001)(6486002)(107886003)(558084003)(38100700002)(186003)(86362001)(66476007)(66946007)(8936002)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qBlLWtuY8cIl7rzX3TRbfhWMF7at7Pu+FaijuxKsnagnG0nthmckzEUycQN8?=
 =?us-ascii?Q?fQdxOfxDkJrHho+gS0+eBmcZyyKy+l7UDpoie9hnFQx7cT1zTchWcTqdrEO3?=
 =?us-ascii?Q?i9vBedON3GVMB4tl5Dm5YcJYjg037gWdST7Hzn/4YsOOYB7dCuEpBvDN0UAC?=
 =?us-ascii?Q?+TMR5WPif25HJhX8F64p6m+QwyAKFteQEDN8U7e2bmJDEoGcBIffyLaTrkCC?=
 =?us-ascii?Q?MgFM2v/144kLzVe/AfveJmM65ayGr0E5WpibgtBVBepHg8/yMI/uIjDMMc5P?=
 =?us-ascii?Q?uGjmDGIldyTKfekzg4EgYTfTcDmDdzLjT1oAjI1gjp3YreumHCrjJ1x5orrO?=
 =?us-ascii?Q?qHU1jzHzTCL0cJIJ/YkFUXJxMv4wAxJbhMYSMZhLcty/2mHyYY44bHkds1RG?=
 =?us-ascii?Q?2HbkM7T5hkVtGgOYll+Wt0m2E/ltNRlBQoWMhjEs2j+m9xpb90f2h0lBUOdL?=
 =?us-ascii?Q?OhF77hqXXJqQWNZHBnyAetH2lIl57jq+wdd8hHlg4hO4+qGGoQdfOCdRJ76p?=
 =?us-ascii?Q?fiaaCXevQPjVtxRSxmCP2PdFC+jwsx9qaM8uCiq1mO3QhmrsmDvdmigbdowx?=
 =?us-ascii?Q?5FioBwhCJtD6bfO+NydK6F/+VhcG+lCTxSqvg+UA6cjjNOPyi7y1Zwwhnjel?=
 =?us-ascii?Q?Ux5NCLtrEJs4/YSfqRfnQkzcC4XVDGLUEfcCuSG418EejHHkdTdFNATaegDR?=
 =?us-ascii?Q?SzLW2zTOGhA2qq26Hr3mpHVsmdonvLUu0SDhKqaEw8GmlPs6vTzOC25vqq3N?=
 =?us-ascii?Q?smRxduKUAUlAJfivSEbMKH4LLuR8ev/TT+8PpfRGSsqXyGnh7YbsAcjgQ2SR?=
 =?us-ascii?Q?Ntr40alKHrZZqUT1xTP+EXJCWRCsaFgU79vm91MMubUINqv7LdYfK5wF1ClN?=
 =?us-ascii?Q?N9fi1pX/FiJghUrCXyhQ4RcRyJlXqpGyN+v4ZC+aZF51crZWdT5T9c9o6XPf?=
 =?us-ascii?Q?qkKlUTR7Cvd8ty1pq4frQTFYW72jDYLE+mViaG/FE74w8FSjkc2WIGkqmt4L?=
 =?us-ascii?Q?kZABN8CGrvlOsBj/Aa42/OiMzjjnUrLTqX2VvT9+SaR2WuvUmVfQJNDjHcxo?=
 =?us-ascii?Q?mXhZoxU4vD36edXW0ESQ9o1ddrzmCS6xkkWUqZckf18hrlxyKM794kEAceah?=
 =?us-ascii?Q?perH2dQSoBqlXAIKiAHnCnWMyGpDW1hqxK7W8yNIrZkMQ6fxtr/Aqxc4k/CQ?=
 =?us-ascii?Q?O1UOYyMftqwySMs8tiNinMT5T8mpg34wWFXM0wzaZE9N5bSw1OuvtQrLc7bC?=
 =?us-ascii?Q?DF5pMH4uz8HtlYyrDCQMvwzRg4eFli3J/tMMRMz+V7xGbsF69rmgcqAUkkZA?=
 =?us-ascii?Q?DfUGkmQOnBwaak2WzlAsn9RxOQHah7AFZ9OJ+U9o4Ha14FPot5oSt+NQnch8?=
 =?us-ascii?Q?kr7VL/SwU/SG+XnK5wFkgiiZAzgRFzLnN88KmOt6Fntx2du8H9v/EvaW17oq?=
 =?us-ascii?Q?LiTAZs8GOiFT2TPjU93XHl496i+Fbw78QP8q//7WSfCln6vtqrUra3NE2M8w?=
 =?us-ascii?Q?mBGb5eWhdD2Ag5C2K2C3z/Yyei2QlEVnQ20ioxsSjiGZ7xO/wUdkQqyIN2Bh?=
 =?us-ascii?Q?qxUWTV4oUSfj+fZs9OmvDIDlpQ0LKSiIBjT95Hsb5DO4mEt6IvRdBkB9uIX1?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ba04a9-869f-452a-5de1-08dab9170a2c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 19:03:03.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkZBnM2EfYpcHbf5GSa5Rufwk+3AU2J6HzAbIFxVjr4x6glnQmTwZ4YXwD+S3/hRWTdkdbyJ/8hh4zvFuh9nzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

On Fri, Oct 28, 2022 at 04:26:38PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> It is not needed anymore.

Reviewed and Tested this series. Everything looks good.

> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Ashok Raj <ashok.raj@intel.com>
