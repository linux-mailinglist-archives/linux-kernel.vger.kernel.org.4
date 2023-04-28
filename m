Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D36F1E72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbjD1TAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346521AbjD1TAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:00:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC625FD3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682708376; x=1714244376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qe4HOdF+ptXwX3Qo4poATeeYyH+2WcUjxHPbAjgk7Z0=;
  b=PF+h/sg5tv3F0BLzfP3yYUSrbuN9uBKb6GlYdCK94meN0Mz14dfMqseb
   cK3IYpWK0QiBTQzTk9r32gGASyqgrmmAU+7cXFQkQgYdoGI/FVTpVkWV4
   WMc7Efj8Byz8OttLwkCNXocEqp0WiVH1DWzZA/eDSz4qrqB8n4yyZ8cw5
   pa5DSshKSz366KZeE1JjDJbvSLS1mAjlnw5VIQYrxDn1sf3dldqewCv11
   Axv6/IfAR8O05869FO4fiKGoZdECTX4gA20Rx2DvEalAMKjn8xPXXmeip
   EHD8tTlg40xlpe3EpYeT72rt2Q7CLdBo580Ai3JUht+X4Cr/xCE4IlCAh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="328167510"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="328167510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 11:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="784340818"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="784340818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Apr 2023 11:59:21 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 11:59:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 11:59:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 11:59:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQJZOw6zo3O+XlUF41OdNbgQPoE7nh3rVPk0Wd1UWIF1V+uU/3DbOjxdgnp3WhBVtTpvuO2+bY5dZdeHJQR/dqwAxv6BkLx3yAqhVm/kTRTYTLGc/8kBkHKiavcRQKJlrIxi5a+bTC1GNp2RF82eQsQI6fkaNFJFADtcDN+m+NSBaS0c45uIGdVhlq8CsenaZt5DLkYhXSm4y5wSSVoRi3dVJPac5GRy9OKr+ceBRJXjy1XcSUTGNwMlkcQ+jvjJUQxmE6DyHi4l1DOQlrFZUY/g76E+nww6kmTihfIeI2Xo85bO2l7T0LU5i5HzmI27fJEyAq65yRt3juBJ1mGDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsDhoIRR1uusgGPNcCq+IKrBlmypDjc9pwr0IUPfgV0=;
 b=JU5rXDt/w9iArZBUx7RsmU0LhW6qO2SCdeBVWHiDHRYV3yQzVO+DHzonuQ75/eBaRmZS5DRGbnALWHRrJWjl8QyWu5eQuVMRMgQ0sZA4TluD552KNUs7v1PBHRFPNBJC5rm/eXBSkvzsH69gfNa4N5SHRcMRhexSwtm6hVO4rprJY4hrBo8F2gs0ZMgEPhvvEG/+0QpfYGUciOY19n7MTk9F6UiXEZSJRNm+Z5gUcUxrIVBYyicmX9oYy5GyzPJJ2A/mgNa70X4oHShLYcGEljcM28cK2P5FPZXf5TJLRpnlpcKAEmJSIQMDFjNCAg0CZin1OlYY54X3KHf15Db6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Fri, 28 Apr
 2023 18:59:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Fri, 28 Apr 2023
 18:59:17 +0000
Date:   Fri, 28 Apr 2023 11:59:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, <x86@kernel.org>,
        <nvdimm@lists.linux.dev>, <kexec@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <y-goto@fujitsu.com>,
        <yangx.jy@fujitsu.com>, <ruansy.fnst@fujitsu.com>
Subject: RE: [RFC PATCH v2 0/3] pmem memmap dump support
Message-ID: <644c17823cf83_13303129460@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:a03:338::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df34b94-1445-45d4-742b-08db481aaa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtplahSq/ayTrcnfeywFxU2HLTUH9xeHY3pFSXwqTHouZ4uAi6D21N3fGZmepNfyptihIAjBRxcJaY902+AYDO5vhW7Sw6GJ4j+eLEkP/iXHsT+8BwcOqI/qkOufuQgOKaWZhf2+0AEfv0442FWm38UlbyPNTgtd92PMmdwt5LXZk4jZXe5HHEh5/uYaXAQ2HTGpBM20cWrxQFwSgRgNxOe+pW1a1cH4Y6OkamUrF4pJc54VQFtbNBalDebVkQ2ckaOtK6wPnebET/Y1alvSYC3NOyfKHPz+RjSyW81bcUH3klFnC4+0jPid47uj67JYI4OZX0uL+su8lckmO3ZQISMp1EkrVWaKDDcRWVF+yeDu8mdRr6vcVxYpBsDpfr6CjJh0vE56Cgp9+Pd6BVMUP4CjkrFpHTLtzLHNB3reaWN5EyrtVIJnxOfnH1KrG5oKvdt62X6uay8WbHDBdpIrLJYtARjDzCFwC7HmxdzjzLPFMwux/k0Z+EccvlkfzFbEFmx/ZZM0sNIe1cABhwBqJrHzqo0xrwctEA9JsPNnrVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(66556008)(478600001)(4744005)(8936002)(86362001)(4326008)(5660300002)(38100700002)(8676002)(2906002)(66946007)(316002)(82960400001)(66476007)(41300700001)(966005)(186003)(26005)(9686003)(6512007)(6506007)(6486002)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wX1OQpSk0IjRU49rQYwnOtqWKxwanoHKby6istuJ0BR4bqqfy/5ZQPCj3bz5?=
 =?us-ascii?Q?V+yP4OIw/o6F9gpmFfeuMkz7ZSux86jx7hHlkCx7rKlodZjLXOiM9fd8T2bu?=
 =?us-ascii?Q?RjXXbwp1g08Crnp5GU9XvalKISaasZA1JYDCcQe3ikC+4aueTCiFjXSZ0VVV?=
 =?us-ascii?Q?NhN37fIZmTds7hUS+CE7YuWycJCGke2TdQDXqP7OK4PFoqQm63YU8mHXS+Q3?=
 =?us-ascii?Q?DruTNXBgsvdR0ttNEFSk1MI4c7INe6n7x7DhZmInL90kzybFogFr0/29NU6Q?=
 =?us-ascii?Q?g/S/HiEayoo5wHXXQFfdgitjpXlNosOTOKa5U6PdEbKbFVyzcdwZwIbC56la?=
 =?us-ascii?Q?3A481Za5CMhZX09UzC2T5UJZYVemf9a9mysahFeuqXJlhoLvX8kkn80URJRC?=
 =?us-ascii?Q?5qq1BMTwbwt0Ujs1wArIwH/Jlnek4cuWI+1n8qKafoCExOBD/oRnuo01i1ZV?=
 =?us-ascii?Q?apExSssfuJYMxwhEEwe6qg0fjjGWhNKNxl3SWYrqTaf0nqHvEp7p6Bx8dWcY?=
 =?us-ascii?Q?60vcXJ3ocv4hOSZ5oNv+1dl0hRHDWzR9Pcc2r8aqnK0/89AD/aMcMQPhNv5a?=
 =?us-ascii?Q?cQgnDHc3+pBU5cxvbE693eauns3Aau7u84ob1PkHtCx/u32VwUEwGt3spH3w?=
 =?us-ascii?Q?VJusZ8UR91EWx5Lre6QmibPD9M6k+HEjpH0hptrDM/fJPQBtc7+MXuPVjp2G?=
 =?us-ascii?Q?IajgubmDmYD3t6lFsCAzPvlkckC6Mx4VznlfwqdK3+OSwe9kaRAjKYuodOyi?=
 =?us-ascii?Q?Ls4nd0wCdQBfSYcT8t/Mws664tGCR4uIk5dKJf6spGvK6RNTnl/Tlatp1MTi?=
 =?us-ascii?Q?0RcXF9r1GurkFpyARFFhFdw0+QOTF1zRG16CR9wC3AhjedKncWNGBXTlXUgH?=
 =?us-ascii?Q?XdKhspR+v4ydF83igugbyMGQbQu4ImfAefqfg3BSrYfxrqcD1czjQH3/hg+R?=
 =?us-ascii?Q?2fYE9bWeDBxD5PjAbvwdsmbtGDQCuPiDCPoOE9TWtkuhwLvBimc3g3uUT3hv?=
 =?us-ascii?Q?EZCwDOKt5ZWJNk66+N8PsFIPNaxl8q5gcVSdUKmW57AL6ycv7lTUib/flHEm?=
 =?us-ascii?Q?+P4nmU0khKXnl2uc5l7egtWktB/p1CFWiRSL0GmIiSGEC0WzENEfMim633az?=
 =?us-ascii?Q?N/MTrVyRmiyemTOCxDJMY5AVb82d24wkzf5CPM/0es5T8j4fUty7VBPus32V?=
 =?us-ascii?Q?TNxdPRYDyltZnWMIDAT5hUbmdIH7TopO7oHJqcYusnADLcHI6Zy4u/7T8ddx?=
 =?us-ascii?Q?1ErGOwyTkB3H0SHZ76FvNr56RAbqYqh5Xbl/WoDUu8vqkuXwzms+c4Qg3Yyy?=
 =?us-ascii?Q?dsgXlf3q+uPsPIQfHpGCTUk5dEjBzMZ8kossxitQ9KeIwij5Y99QpwhNNiYe?=
 =?us-ascii?Q?gVOoW/UrJ8KaUmetzWmCGDIR+1tE8P+VfOT6OCOrOg7d06HZgM41WSoGUNK9?=
 =?us-ascii?Q?31J+ok6wMw89J8VtP86Sv+klI8Dl6OiGOxlXDmXYr/3GoOVNGBn9enhH99Aa?=
 =?us-ascii?Q?Wfz5qkOYTKT+/HRsicVo9SydsJZXgujQjoz9VJpsS5xiKpKFJRhAw2Rs2/zL?=
 =?us-ascii?Q?9u83gJ4+EFfjlnMduk25/mSBdYYW0TtKQcsmlOIj8SicGts3/KZXRIAuY6on?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df34b94-1445-45d4-742b-08db481aaa96
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:59:17.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fxv9X+8V9o404hDptYotnhOcna2Ng30F4XBIfJPz2eqHa8cbvY17Kh0XeS54vyMYRq6J7ndIspQXMF2UtrSiE5M83bOir9o19TXgphh+858=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
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

Li Zhijian wrote:
> Hello folks,
> 
> About 2 months ago, we posted our first RFC[3] and received your kindly feedback. Thank you :)
> Now, I'm back with the code.
> 
> Currently, this RFC has already implemented to supported case D*. And the case A&B is disabled
> deliberately in makedumpfile. It includes changes in 3 source code as below:

I think the reason this patchkit is difficult to follow is that it
spends a lot of time describing a chosen solution, but not enough time
describing the problem and the tradeoffs.

For example why is updating /proc/vmcore with pmem metadata the chosen
solution? Why not leave the kernel out of it and have makedumpfile
tooling aware of how to parse persistent memory namespace info-blocks
and retrieve that dump itself? This is what I proposed here:

http://lore.kernel.org/r/641484f7ef780_a52e2940@dwillia2-mobl3.amr.corp.intel.com.notmuch

...but never got an answer, or I missed the answer.
