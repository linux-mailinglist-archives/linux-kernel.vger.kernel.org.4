Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE66B85CF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMXEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCMXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:04:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D0E8E3FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748594; x=1710284594;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qa8BAElZJYdCSZjKyIB8Oyz7rYrDXRhy3UKd6qIa74o=;
  b=Uq5HatR7EuyvffGBtd35sdgYd256XaLiideGtmbG7hE4rMvSpPVRHrMU
   8lNj5bx7Xc0ECH+K/Qgfypr+gLWkjHZny5ge8DLSWjVAQzpXyX8Hxsa1T
   lFl7YCB2yHMjkW+u+ukpmalr2y6SkAjVfU1LZOjBrJaAcxvP/n1Sk4LxL
   C+QeKBWaC1jBdTKOh4r5xtLSOB6wZoCNGmqSV1qHBno06FcNQEoUO9bxl
   AtQ6IvuedPVLusoEmcUzikmKti1Uh1dHtUV6KhSKCYeJqxv4DUKKrkKWk
   /bXrbDQvfX8IVpPhflfhxIJb6YethW39Jg+wjMXnXMUnvuIFHT0pqWuBh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="321132988"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="321132988"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 16:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672088534"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="672088534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2023 16:02:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 16:02:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 16:02:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 16:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgYbEaUt9Fxj3Y0A+torED63u/WPjHTeke8rMzgD2AzwUjHVooqhF1B0zLqrB/465jVGkaukDuajfwMHj5LCJVnrW/ySIm/tQk7it5RkdPyTwozOls3gUrj0eIs5C53AVeL4A+PG1LPD3IZ5OHPFXQkRrO/drafQiH1qMKaUyflxZMeGnALQl48C+rogwNosffq9mwF33xIJ/wVgVHoWQTKOIhVXC3vbuGXACTcxc3hfpW9omqilAAgBDJ/H5hQauJZnb7ICyNeaBSpFab7z8Gqeakd6xC/593vpP+ZEvmJ/UJHOQuaVkugyK22Dr3Bbt3Y4oVmWAAlIzwp74qlwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3GXGtOdSy5Ve2mt8Dbz5py4rGy0+rvmzIvWpBy2a0U=;
 b=eW0lcBiRE3tS1DLRPGZfP3B1xajUZDquH5DPPEKdDEpnJpbuz7T2Poh02YX/A+5s1luortYcFxJWG3JdF30Zp+VklsfZhqOzkMt6pEVyW+X599L+1DltVENd1fOudaASrL9uNKueInP7JAGwqZw6bK2pfopXF5KzqRoDjjVge0xKi2vmIoEYda6FuQti9nbywWXJyj0MGAurvycu37fnOOEvYrqM9ukxCoJ4LopnZc9AHT41S3SQoFOjOVEQZYVp+H8ThwgUywgxViPWqVos+Z8UatWGRrMRSScgHTvk4JST6ruKAbHtulN4B3l7KuK8/HkycyWt/FkU8xxm1Kbujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 23:02:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 23:02:00 +0000
Date:   Mon, 13 Mar 2023 16:01:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Eric Dumazet" <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>, Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Message-ID: <640fab62cdd53_239fd62942@iweiny-mobl.notmuch>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-23-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 848e29bc-9a7f-4035-f282-08db2416f3c9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sfX6edW6m8PhC5S2JLjki7WbqUYuL+yJuTtdTsztyPyGgCNM+3g6+u4A05n6lqfNENRwDgwfdJkjRym42mNMuK3SQeoez7N3reILKiQD3AVxheBvEyPD9yqqjUUGkECj7xISTV8CVzBbpTVHPiz35+ZL2q++tDrOASVkwxiPnCNm6ww1RXZb4Gw609ONpT/Az70x7EsPLmexxLmJWAin8Lv65kTdS7jSjdEVrhfUMpDLmgk0qRq0gRh4fQhzrx5bLUo38JNc1Y60Hcrlt6ME6+Yur+MLerCDfY7qnrL53GV0xCYKJNdn7LWkk7sThhg7EId2NEiVPHqEQ9tPZPrr/z7WkBfGwPpSbD0aPozRtg77Pa/Bl2i73bSV9fY5+a2izjZofDKN85MPm1Wz2QDctozi4yjp1BbiAjKTv/gVAY2+rMqTZzzff0cT6hkrePjroykEO24s27952gTuG5nSukY+aeM0+wm6C+tdJv8ndtsZ5ZjVtKQWsQJd69FFFfcNmvM1bg597mDO2C7DM+ynGK02TmbKLPcxJCKzdVrfwn/xp9kaBZSULY4Kh2/2hQHh6+2H/GefKbjGRZfj5WetFPAUQowCmsUG8YSWwSwzyOzOx82hqSPF63p5FRwc/xEBlSfg2Xsztevk5Or0gTjB1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(7406005)(7416002)(186003)(9686003)(6512007)(26005)(44832011)(6506007)(83380400001)(8936002)(6666004)(45080400002)(82960400001)(38100700002)(5660300002)(6486002)(66556008)(66476007)(2906002)(4326008)(8676002)(66946007)(41300700001)(54906003)(478600001)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6R2RPn8BtgYFlbgj+ZzbOPHwWckUnS9sLSI4UUxgVhGSGHwW/YTDc7mcGjEn?=
 =?us-ascii?Q?s+YasqZuEp5tii+In/SU3QMkDStOc4byJX9tFpz2sXPZic2RqDADetutFfJY?=
 =?us-ascii?Q?3shu3mJxNHcLFhOjVS9W554Pkfw/H5LRn1+/wgRZAHvY7OcHHCAHZFnrSOqE?=
 =?us-ascii?Q?2UMB/kijf1EWxxzElS368uIZuOjUvL2vkrP4KLYnoTXNgPZCnt+YUD4Pz/py?=
 =?us-ascii?Q?G1mLLllD+cTrmKJLazXN6YTf7TcONTIdUpRXCs2/bI6k0qPhHTiiPxHbuqKe?=
 =?us-ascii?Q?+DixkCUrelDUuNVIKSj5kvZQ8NrXFjaOuCPT804Q41BoiLwAWzCWcmi4cJfY?=
 =?us-ascii?Q?5oe+SbuDlMLT4EHGLIurqtmcqQb9a/COWNLh0gKbTGnpTVjuOd+VJO2Rhc8m?=
 =?us-ascii?Q?WoppFG8WYJwZUcskwNfvbVSgJHhLELuaFPmBaFSPbTvPGRTg+4Wie+ZTRo19?=
 =?us-ascii?Q?MkkR/oZILMstajUh7zZmxDSR+xak2emwApkxXNFwZWL5Y8jUbwlcTdoxFQGT?=
 =?us-ascii?Q?2XCvyH/1YpBoPQxRPmAzAeuN21CKZeO6sFGdLAQ0hCIoBxwSgaon5aTDobcl?=
 =?us-ascii?Q?suWsD6VhAP0psKdNqJ/SOuZsVX1QuOZ8+7e/SIHJi/YRiJFszUzby0seJkB2?=
 =?us-ascii?Q?O3nprKPPV9Gp4Yzh3SF+aoStOcwSNjDEaPzzWvEDGKVDeVXjgaHx4OXXVx/3?=
 =?us-ascii?Q?a6fTSFBiFdrUdE8DZAJDeMqEkyRxuM5XeBXZZ3Mi+UoPMFUQ1EFb3ovYRYLt?=
 =?us-ascii?Q?YKAYqsKjtzYH9kADb8BuW9PiaH7URw7X8OECOtJMYvVW2bgHdc8PWF1x0v9h?=
 =?us-ascii?Q?kHMYFd/bTtpUyVmGHQdgzBmMddSxMrX0Tj2NBeXTWz5ZxezgFg9gs4uiFh0N?=
 =?us-ascii?Q?lKKHLrzB9ZXtGQyndyl4rbraIJQ/XxlFcX/sXR2tJKp65DWh1//fxkQYopTB?=
 =?us-ascii?Q?+GepQRqz1hQOfEWfCNPazv7jBjTnKnyNGsq3EPfAh3Pu4uzC2MBMAt8qf4G8?=
 =?us-ascii?Q?q6d8aTJZ6LUGfVwjMka2/dI3hJsLuRRruDLuFhp6vUDKNANizb+7VFf+72xw?=
 =?us-ascii?Q?TFVf2KpKU+M6dZoQ1vBzAppQ1TYAberp7hVu2fQIHAjE15OcYuq/vQhyykO3?=
 =?us-ascii?Q?2TcxDRiOrIM82FMIb7Nk3DSZBembQUB2tCSsUKsYrQ8WKzgq8f6QPO7iOJK5?=
 =?us-ascii?Q?C10ucen5/rwULRoJHiPBj7vNwPxXOGa8fOHd5fhf4kYPYgtvIDB202MFTPcF?=
 =?us-ascii?Q?+VZ/QICgYpbBqrW1vOVchxyjRLDDrfmd29G7XnzAt56jC+s4NYhR7HLAHu0p?=
 =?us-ascii?Q?zkSYn5wUJwC2gfLVQRvny81HqB+a7WFINC3dVmnX7P405jmu5y0J3gzS8dYt?=
 =?us-ascii?Q?8IA38Ad0PBfRa+duBUiONrgs+N5bwju0+9lB2c7ieH4WMwVxIUoKE8wpWdfB?=
 =?us-ascii?Q?m+zEuqY5CZXKFZUhESUjMjWLu7+YJ9ZkFeHDBu2RRMPMQpgkO1WyqpRdAJz5?=
 =?us-ascii?Q?+MIpVYce+J1i3ipvflRDRTHfCmIznt5PQbne88ku5lDo/ombNDgt0klaT3Fy?=
 =?us-ascii?Q?gDfAj1DMt2WxzdeAXe8WLRlENMe5rAxo9jhJM8GPTS33lbbcs6Zl5CmanhgL?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e29bc-9a7f-4035-f282-08db2416f3c9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 23:02:00.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HauF3W909L9v6by0DNoUyey9EqxYvdglCTxXm/Yn/k/AY5fJ7Q1knXNR5Dzqw+Tz9DfTuPrNw/wSualD1gccDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> struct bus_type should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> bus_type to be moved to read-only memory.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Alexandre Bounine <alex.bou9@gmail.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Harald Freudenberger <freude@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Hu Haowen <src.res@email.cn>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Iwona Winiarska <iwona.winiarska@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Ira Weiny <ira.weiny@intel.com> # cxl

> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
> 
>  Documentation/driver-api/driver-model/bus.rst |  4 +-
>  Documentation/filesystems/sysfs.rst           |  4 +-
>  .../translations/zh_CN/filesystems/sysfs.txt  |  4 +-
>  .../translations/zh_TW/filesystems/sysfs.txt  |  4 +-
>  arch/powerpc/platforms/pseries/ibmebus.c      |  4 +-
>  arch/powerpc/platforms/pseries/vio.c          |  8 ++--
>  drivers/ata/pata_parport/pata_parport.c       |  6 +--
>  drivers/base/bus.c                            |  8 ++--
>  drivers/block/rbd.c                           | 34 +++++++--------
>  drivers/bus/fsl-mc/fsl-mc-bus.c               |  6 +--
>  drivers/cxl/core/port.c                       |  2 +-
>  drivers/hv/vmbus_drv.c                        |  2 +-
>  drivers/net/netdevsim/bus.c                   |  4 +-
>  drivers/pci/pci-sysfs.c                       |  2 +-
>  drivers/pci/pci.c                             |  4 +-
>  drivers/peci/sysfs.c                          |  2 +-
>  drivers/rapidio/rio-sysfs.c                   |  2 +-
>  drivers/s390/crypto/ap_bus.c                  | 42 +++++++++----------
>  drivers/scsi/fcoe/fcoe_sysfs.c                |  8 ++--
>  drivers/scsi/fcoe/fcoe_transport.c            |  6 +--
>  include/linux/device/bus.h                    |  4 +-
>  include/scsi/libfcoe.h                        |  6 +--
>  22 files changed, 78 insertions(+), 88 deletions(-)
> 

[...]

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8ee6b6e2e2a4..66333cd6248e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1927,7 +1927,7 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
>  /* for user tooling to ensure port disable work has completed */
> -static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
> +static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
>  	if (sysfs_streq(buf, "1")) {
>  		flush_workqueue(cxl_bus_wq);
