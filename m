Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C416B894C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCNEK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNEKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:10:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD91B60D77
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678767023; x=1710303023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+Y2tnRuD/t/LyDLntzXLeijf6iqqzxdbqmcAefByhG8=;
  b=mxnLhaeBAjiDNelt6ulse/+pSOt7WrIoua2CmxoNCEkDwK9MIS3hYE8U
   H3SpjG6YhFIs71RwBxNKhoW/j1vnqVon2fkTjmA/xNrSwZiStEJTrcAUk
   6UqW6XuFz4dA2KO0+EK1akbcraRx+yK7W+hpbtzbY4+EtiQJeNl/O2pVz
   aUOYBPSByYaiiI0BSVSXgIttiJg0pwJU/EtWJgtv4UB3F5jRS9F8itozk
   p86g2KGLQMk/IsV6+wEsPJnqA3m7fww4fYVlGi2P1CZo3Az0SBSVhlx5R
   LGjuYfGZ7BipI9dB/yuf0DR8T8S/mPYO9EqEmtl30SdrryTa9WJJekIzl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="423595990"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="423595990"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 21:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="709125037"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="709125037"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 21:10:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 21:10:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 21:10:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 21:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvhpQlD8zrsQyzP+wnzYVQXBGmYBGUzPC03nkHY1HwCpOYCGo2YyTP0rEONQWaHiLfjZT+RbWnm37ZByTH94AOnBqnDGr2/rnk2EoI0R5u9iT/+xGJ2yCIwZoVOYiZuq90lsKb/Pl6wai1qf1Cbzh//2mzzRi+xyGPXa6kDZ3/VTCv6IDRqZz4VHFE1oi47T5PsNNE8r8wOivgoeaGQhLHh+T9QZlJ5wiKGpADqV6NCx3wv7UgvWWSNeF7pKSD8ePLrOhpZu2/Jm/yVzWuHgTpWM/XNYk72yUsPMxtHoiWyb8aeWGAuAB8krKpFQOpZNv8n7fFHPwhSzBbe5wA7yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAiFptyxT7kxXyu8MQn9McqLGdGxvb0OA5TRGV11rM8=;
 b=C/gT5P5LPux+c+ZNDrWEX1neqDU+Etq8DhMyxXBgDUuLuQ9zW6t8lWfzwamX6e22/ji4nUQ/ZjLoChVWCcN+D57qrydID6lPd5Mk1LRJECYfraDNvA1g3XmR3ypd74lHq8rgbXkvvBGckaOZfoKpo85s/QrmfpdALm/krdRP/s2vgqUejQWPYnj8h4Amfku/M1pDBcvgVc6X8kyKcs3u+DoT1dSnk5Wjn8pJ99epaL9S5oMoFI0T3LEoWu+RMmyqGnnSz7zcjmodx3UAxVh0HhvNK8Y7RAFic7AsfDNQZIbIuMqDOEDf5ZOCDFIclByu9P6joOfkdadkySGmCBzT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA1PR11MB6218.namprd11.prod.outlook.com (2603:10b6:208:3ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 04:09:57 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9bf2:9ab9:c6e0:1b2f%3]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 04:09:57 +0000
Date:   Tue, 14 Mar 2023 12:09:37 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "Hillf Danton" <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] sched/fair: Wake short task on current CPU
Message-ID: <ZA/zgYzmFxht0Kbz@chenyu5-mobl1>
References: <cover.1677069490.git.yu.c.chen@intel.com>
 <28659855-c1a4-ab61-433e-a5bccb96fcbd@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28659855-c1a4-ab61-433e-a5bccb96fcbd@amd.com>
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA1PR11MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 3736c4fb-57ee-4117-5b7f-08db2441f8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +N4h759tRcezO62zGOsMnjMR/QfRAmUOEwAATh/v9Mau9+c8M0XcewTwYiz5DDeChKeuxlXhlj7a/NzMLWRkMNIkVzfMxOnn6U2aMBJ156xmUdwnYppPlPWp3iAL9qD7zjuq/gyhdBYN+c1FVHZROPXQ3AKF7pTolIcpu8NeomZHosbZ56nGxDv3w58IWW/Cj5Ye4YwqXomhQDkx76K5D5SyqbHzL90Fa6r2haIv1yvZgZA01SRUAX+Q9nziEJrtsEIHJthuN0Kxa/KjPt+fLcKBVdHrW3ts8+wP7CtdnG08YTYrKpzaWZVwoOPKnDcPicuRqfJVAGWv8RYcQqeJB0d1D7kzVzkY6E40Ho/+XzD1/AsoPV/4RYQyRcNNR+qVk5pDu+sFds3GfKiKS0GqznFbfp/KkRGg3jr1hwGJJzBKJyra+jarE3cTH5JLoNeTsW8nwEERCDZiTFwc7BMIxn9NvZ391ecw7aKsyvNEIiyXsdnUQk/nH06rYV7IEIESzf5fMGYaHkmOmGqWEOq4c+mauAJJeNlMIGKWKLCGUXApEXEAoHlf9AeukJ/hCPXh2MUfwk5ZkkAjmE7eOMWEB44/GDgdgZ1scrBUhBzSlnxsNm6WX5nRmJsmAbQIM4vl3vSyYmk5plLccTQ1uTvkFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199018)(54906003)(41300700001)(478600001)(66946007)(8676002)(66556008)(4326008)(66476007)(8936002)(6916009)(33716001)(86362001)(38100700002)(82960400001)(26005)(53546011)(6512007)(6666004)(186003)(9686003)(6486002)(7416002)(5660300002)(4744005)(2906002)(316002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEx5YTRKqlOvP6Qr8U4GXCtl5JeNdP7s7ArRYEn0atbSLW2ZKI2CxktkNX4m?=
 =?us-ascii?Q?G+qaZZ5LnqL1nlV5QG5i3FlzsEBQt3GMqVhTAZrc+nN3uUBj9Fi9FNy/TB+9?=
 =?us-ascii?Q?HXOlH0GrDHE0N3Ug6z6oJX/Mjw2isX/oBmvOiByKxaPi3I+1Prv4NLjO7DTF?=
 =?us-ascii?Q?WVGslEfoNaN6Y+5+Ztp8xDmhdJrZtnQuy/owmXlKFzfph/V4KcmhiXUkDkqx?=
 =?us-ascii?Q?wK43VmoeqtL4Zv+VK8GGar5vFhLYTBBlwZPF/F1Om/hpLFhRcIOpdCCSs+7+?=
 =?us-ascii?Q?MqB0ezrmH18b4+tiCjdVRXw2R7TMzphGm/AwI+3u+zUwBXaJerA2GJyX4mF2?=
 =?us-ascii?Q?JAQTfi+m+9oIMjkJSV/mmVeSNmclUmBMoUD8jurKoERW55OHr6F1qH5KbC/a?=
 =?us-ascii?Q?jLyZlsgcoVxFPXSsJSIv5GOrN8SDd/LkFX6HpKmgH2CSPjFtxaysnSQjnEWd?=
 =?us-ascii?Q?K/6i0d8fDHPC3uqa3x5UDhGFGfZT5/c+cPisezWuvKpaayKZc/jGlOccmveH?=
 =?us-ascii?Q?oQ9wpPG6St5QOAd+eTjQSED5gZ3bp+OQ08UFog8a+Knpaz7c7OLxhf+OBBnp?=
 =?us-ascii?Q?RvwxyrOYznujNGKFTjSLsF0KHfVMsVLB6p+mTiVUIbYzBinwUXUiwleaM3an?=
 =?us-ascii?Q?1r8AHfpMbCShB3B6YTN47ukp2owaGaZf8rZlmjzxl57C/bgUnLWNgQQBQ1v3?=
 =?us-ascii?Q?c2sSODXc3o+weDYfN2ptRt17eHLLonFeqp9bd7cRdwqH33lshV264l6tXqMK?=
 =?us-ascii?Q?d9jVJ8eXEsCCbn64VYxe1ScNBdW5Jt8/nrI9CfyLsKIA6gVe4ZZDy0cdX1dm?=
 =?us-ascii?Q?lDUm7oWz6iLcd9h2qNHt1ii41Qn4uaytQqs1ECk1yx1M8Hi1S8aZoECrdUun?=
 =?us-ascii?Q?hOTzjldIwYH7TEtGVYQmLLa/UZq6TLkdpSd6fD9Igx1jrtU9ztAN+fjnEJgO?=
 =?us-ascii?Q?yOqLhsTRxxz5FGW+EkR9yWEg5pYASlS3FSe4/Qe+JSTXC7OHjeCmJGVs09M8?=
 =?us-ascii?Q?z+udA3Dbh2Nr1hqGFQzDr5KbW4enxm/PY64y7ek4p0u+1qgZGBmCpCVX4lMu?=
 =?us-ascii?Q?JbIXckMFCg72EE7zB4hWNBtSFEwUMCHoiNhiM7sSJhvQ4EV44eAnT4Xzb0h3?=
 =?us-ascii?Q?wmMbqRj2jfiMf7TOcCU2th+FXazilQHu7/zNjkTdjQKydgX++0dhzvdT0t1g?=
 =?us-ascii?Q?hUX+zQhbsvIWnfA/rAei7OIuVay6uDWmYmT5RxKUtoEjQVjMLVIvViiOVOYj?=
 =?us-ascii?Q?UNNVgG0Rp3aBNTC7OjCqFO0c1FzxW2Mop8qapSJUtzxvFjjjAwuNwUjO43gU?=
 =?us-ascii?Q?zju6BmfStDhfd5vEZHJtCkjxXCsbikO4gvLzOq7Y4fiIwyRVRfzWkanNHXT7?=
 =?us-ascii?Q?Pj4RXXezrzNOwiRGG7LwRSOjeWFhjbiwqQIuDacVurUL7KR1Df8DQ9tqcjks?=
 =?us-ascii?Q?M74cS9rUaM/qGokYnHL6+OJF20QsTT/OiLXGVszP6xmfAF8afU0UApmTRZbJ?=
 =?us-ascii?Q?I1knB+zb8KcvUCZKO1OU+c15CroxjfMZWYoRka5QsQADIMXSJssqkDMNdgTL?=
 =?us-ascii?Q?pMsjqR3x3dEvAOjc+UbKf5IjMO9OA2CI5HxIgJKn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3736c4fb-57ee-4117-5b7f-08db2441f8d9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 04:09:57.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvEt3VUkXSEWhgWkTtCsvXx8/AfHTtEpD8+z0ZdLO1EgTF2Kgo8MGvWOLF3dSgzbd6N/duQoFkAV0qjBmiJBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-14 at 08:43:17 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> I did not observe any regression when testing v6 :)
> Most of the benchmark results are comparable to the tip with minor
> gains in some benchmarks with single sender and single receiver.
> 
> With the introduction of wakee_flips condition in is_short_task(),
> most benchmarks that have multiple tasks interacting are now
> comparable to tip. There may be other avenues for optimization
> using SIS_SHORT as Abel pointed but this series is a good start in
> that direction. 
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Thanks Prateek!

thanks,
Chenyu
