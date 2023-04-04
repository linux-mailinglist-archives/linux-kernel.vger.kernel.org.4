Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114206D5766
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjDDEDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjDDEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:03:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E61723;
        Mon,  3 Apr 2023 21:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680581014; x=1712117014;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IojySSJugiiivza16PrcNJK5D7rmZBCpEUngMzJkL10=;
  b=AJ1mHUUTJw/awtphg+i3LY6FoTVQ0fVTGTXKtXWATY6M2Zf87CxUtENc
   hgevRxTVZZPKXj8JyCXVJ7KcQAgVQ19PkerlbqQsEspTRMWOT6dJYHfRg
   iv1vTMVa7m0BD/xq4xNcBIDaf+g1co1pwH/ji+T5XMoQmWYInfMwdZdKz
   Ss8Gi1mpoTUHQAAXygJ9W010TOb/+OzwFyoX4wAGr8MVvcb5qhahb2hh9
   6oSpEIFrjWJyWNAQnak77va0p8NIq1sZPXV4Dj5KAl9aKOAasdwdlEUUM
   hYBwtNlbVMPKAhkxxEwdq0Hbyp9npvzCHc+2FzGrdCdRdfTs2K+2DGNoE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404843341"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="404843341"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 21:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755505885"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="755505885"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 21:03:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 21:03:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 21:03:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 21:03:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggc+Ns0HWW57cHBwpFR057VqUtHdiio++H59KrTgu+NU1jEHTYZJ2Y2+QEyAOjQkpYp2a8WmMcb5Krqotpc0s4Dj1aFItUNXx0XrJTGh1JNB37yGNjZadYOZmg5STz5/SDxwX9Ny/qWzRsA/hMsDiRejyvTVMj9ITQ49CEcaPQLuQ54tf/XID2zjZ1nGlhiS624F0AA7MPP8DjzRFQrkfulilIMIAiclaTzlK1VNnM3nkBChUNQ6gHh+0kKXR5TfL3WIGdpm5k8I5+oVas8NTmkwj5Yl8lp9eiFsEfiKUZ7JsjevdsQ6h5tKwDKcnrKTQQIjhVhj6w/LSr2oB710pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSkP4W9BD6ZJf2PElNCoXJgJgfPl8oHgixCUofkphEk=;
 b=ZfpEAFmut1+XT/LVJbPJWQeBDf+o1knbZtGxNrWleg1qqmtXEXUT20d2KoTCdlovOHqDyeLixAneuDORosBtTEQKQCFcRc7Iswo4TUXoeLV4t7MCczPirQtjxi37HqkYDyZ863WobKpTkcNkEvoiTqcwo/wIQHx6ohiAApEvdici7MmhYELvj1KNtQaal21h/JNiGobSAq2TlZ+0Ypyz9rrJg2BIrqr8L2oxndY74GXCjFuYSFKehUdCYCy7cJB4+aEJUuwGX1vSw5yiI+j0e6YeI0VeUC2Sj9epn5XHkHgIM7Uj5Q7dyAn01TRehAJq6K8TiJPmOzCJX1h+qncWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5439.namprd11.prod.outlook.com (2603:10b6:5:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 04:03:30 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 04:03:30 +0000
Date:   Mon, 3 Apr 2023 21:03:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: RE: [PATCH v4 2/5] perf: Allow a PMU to have a parent
Message-ID: <642ba19065e_29cc294f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330164556.31533-3-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: edecb71e-0730-4adc-7421-08db34c18d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uB2yA3hr80JtO3LCWO5BoinISl8yeAw42/3UW+MXBkg0c7ys/GayxPMKqmKBUpbuCn5Ar+jV7whAaAZoO6TENzg+BhkkUzVRDf/+bHv2NkIXloRMu7MqPSwGczGkMNPnwPF+DoK/rbpLUcGkXB8DBeG3ZzDpxcT0l4VfG2uhvaEeaO2LXcN6kNioLLO8kVO8EjVNlGiECTShmwhGd6NjSU4B6stSCGPG9JNNLXXM4BaNcYLDyfgiA0PXlcNSfrLw/wgI338qXXwbb2BKGKBk8IIw3/+5KrXFdBdIBDvvaOBGy/pNEIyhMz0oBGu1hfmQ2J/ibPM+Zg5kuLI6NN1kBAVr9+zPi/FQAo9VZ2dMskgL+F8mjzD1UG7RIZe5788RpUPjNUkxRVg8GXSbvD3OrkQH+PqfB7EvZ9yaipxRII9y3PlOJ8eVOFjs9rDr11awhkuLsFzXNdPYPZWeIybU1qHBAWGTVePssr/AEgiCDRUhEkFga+0O70H3VvEuKcO+XbBw2uEs59HOYoIwtYyC8Vp1BoxzOreHwqYNu8JUjMkCUNo/x6Qax8TN/dxLg7E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199021)(4744005)(38100700002)(5660300002)(7416002)(54906003)(110136005)(6506007)(316002)(6486002)(186003)(478600001)(86362001)(26005)(6512007)(82960400001)(9686003)(4326008)(8676002)(41300700001)(66946007)(8936002)(66476007)(66556008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lJNul4NT+wiNYB9jGVV/fPR3DDudmkNTmHe6liUymBm7K7ShRJuWsuPb28X?=
 =?us-ascii?Q?uDbGiVSOdUIuwtBFZ0wTLVZkK5DQNAZ90PwXqV7IXCfv2jC/TpCtQbmkdGZF?=
 =?us-ascii?Q?9lKdvkapB4JbKpDuCfepdWw3qlurspj9JTZa+ovb5oWPxNm4HHTGXPeMBTva?=
 =?us-ascii?Q?DDAT0Pj2h/yjImQG2+RxEeRQTXAcE4fbjDMp8Vi6ZLLd69xEeb8ZLJ8N2T9W?=
 =?us-ascii?Q?ZCtHy2Iq380EYHZasyAiDF+ronQkxpS5qD5bUNUKt15/IKiGcV5NrCxPsyBt?=
 =?us-ascii?Q?17aM7Gy2ZRoaKCh1brTBBymD+uLzMCYsY07YBEQJLPqFKs1MBbzbOlLxmMxN?=
 =?us-ascii?Q?B07ko3PRd1eDdzv3yzLVbsze5nEK5jBFBnhD5S5FjX+hlhxp4U6ES47v4Fzd?=
 =?us-ascii?Q?9D7YLkzrcxYS9tbYUrxyUwG30+YkSTjCW7dpkDMOuF8j91ujs5UeqKaQbwd2?=
 =?us-ascii?Q?v5wIcbN1rghvQ//ZYxXRHO9pHnA9rmwwurr/uyzjc2Zdk3zM7Ko0SAZbl3U2?=
 =?us-ascii?Q?aqGQa8V9ctrxuYeaihB/LlNmyPz0liW+NOzBX5Xvp7SA5pYUYGN6Xe4aM+A5?=
 =?us-ascii?Q?xF/qXyMun/AlXnan5v8iak/EGKG1grEF9eiqIJB94YPyJbgVxokMR1WGVwH7?=
 =?us-ascii?Q?/Mhe3soXlQaJ7DX+kPmGxqe3yhgqrqv+su5/xa11kTwz172ynYfL5NqnpPuR?=
 =?us-ascii?Q?OPhFIa1To4KFc39QqcUe1cXzCAWsw5D3Bgl4Jh8JDBZx83k3uM2iOcMXLVIp?=
 =?us-ascii?Q?j+HjzMJu1VGXoRUDkMFEu/hekzI4M30EE9o5b7pRv9XRCSbTB3TbHUiA7cxh?=
 =?us-ascii?Q?EOsPnf7H58D0/a+AF/2Gzn5yGXhWZZ5x9L2tLh3Noh83JabbVw2D9ukDc5/H?=
 =?us-ascii?Q?rDkNhUOfWwqbgQvnUwmEdW6nYH1l3SXpKIV1Zf6ZZNjKHpDOOAKkuqI1jDmm?=
 =?us-ascii?Q?Po3spF3xxPOKUSZfTnwNUISAM7k3TLc/yCexBSOOCKP0V2tT2bG/CKi/jH2E?=
 =?us-ascii?Q?V0KSHjGbTgvjLvvkpyMei/UliezrGpBlDh1bmwpPef2VdW/0KCLyX/dY1a+d?=
 =?us-ascii?Q?u3pQvUnnu2XKLOFPZQs/NkGhdv4T9R+LXOWv9Sl5MiHK3+XdOfWOYDk+jxYd?=
 =?us-ascii?Q?h2FUP1fPq5Pq8edPMnb4WQP4f36cjGgITZWZPIoiGbOArxHXef4svOoZ37OJ?=
 =?us-ascii?Q?wEcswwvVmT9V3ZuZuLB5E+v9GdVUH5Rl7JY30UHkzU2Zu0+srARlnzZ0+R40?=
 =?us-ascii?Q?mZifqM8WY7L9duLC8fiw76u3j+vAm6K26Vw85J4zy+QcsAUpPhzvnVxgB3Xr?=
 =?us-ascii?Q?uAvfytNquSq+wsMhE/jlT4ocPPenrZjTYlD0m9oK9OIgJiuPbj4xiksS9pR/?=
 =?us-ascii?Q?P7gOGsMTf7tTyzgF/+y/lgQiEj5kY+FUdamyG7R16+jMagg3asvJDOhPv6ae?=
 =?us-ascii?Q?E2l6iz4tJKa6zpwhQ8bYDM6oiRLq2uf/p5jlkhd4+Is7E3Ia+L5i720beEAc?=
 =?us-ascii?Q?BcRczivy+IzE0zC2iHzEOeMIUnFP4WBcjjTkEUauKmlY5ZAT5pO4nILLC+3M?=
 =?us-ascii?Q?FCIp0666Ot+7ThmMfhfOQROsWTa0j8e7SILeJaVYB+PoBdZNOcqgZwvtm8Ex?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edecb71e-0730-4adc-7421-08db34c18d13
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 04:03:30.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2T094kk6s5ggJh7YDjjGXz2atJ+wVeIXwzDlupqwFJVXP4gwLmH/yuJfYZFw8h4Ofo8th4PCYUXdQk/xH6tVM5P0Y2+YNmrLQ6wVJzJTbkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> Some PMUs have well defined parents such as PCI devices.
> As the device_initialize() and device_add() are all within
> pmu_dev_alloc() which is called from perf_pmu_register()
> there is no opportunity to set the parent from within a driver.
> 
> Add a struct device *parent field to struct pmu and use that
> to set the parent.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: No change
> Note that this may first merge as part of a larger series I
> plan to post next week that adds parents for many of the of the
> other struct pmu instances.  If so please drop this patch whilst
> applying.

Feel free to add my:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...whereever this gets applied, and yes it makes sense especially as
more device attached PMUs are showing up.
