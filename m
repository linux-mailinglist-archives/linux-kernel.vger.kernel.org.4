Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70976617712
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKCHCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKCHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:02:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379936400
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667458927; x=1698994927;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H0KX3ib4Ai64sOxoTOiTgv4EsGJowQNMmevkMVnLNc8=;
  b=ZtHNybVPGIpDsOcuOQB0dAUoGuQEYF5kbvOCoz8lLyoqbyzGIS9Wo6z8
   ROD1dzeP6Yx2bG7rzvAfUke3LbzB2B8K03FZ66AL65dYulgZZNRep3eGa
   S68C9UlqD0W9LZUdDBxV7ChjBTfbiYb7r2jZFy/YULNWaSY9lE9IY9Fpz
   ojvlI4cye9UkwbB02ktvWt8zedKn2W9AScUkhHTYs5nQOMajK91SBd/Bh
   frEx7OnDFDdOd1j6jp1PynSVVTI71swVlz57DM0S6w0LWAgcvfpxHxEA8
   rQfZE6Bfj0Ybk1m2nx4msKWUApi4KqgNLjJhfxtDnsgIB0jTIDRXwwEnx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="336293795"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="336293795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:02:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="629237343"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="629237343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2022 00:02:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:02:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 00:02:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 00:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZz6uTuQUqYH+Oyzuih8NSpb+sf4unp4YwX9R/JOe4Y3VLE7KVavwkakKiTB/wqAcQLPlzzE2zCWNNybd2rQUo1a3cTIP6b2FuUndMTr/tB0W+0R4DyIdacyg5Jkm4Ilk9Mk+R6suGHDDrwt3zYdfg3cb4awqGeDvd4AGZBSQWwUj1rtjRnh+9fuQz+BgDgFakeZN2JVD4wRGXm0JahfNOOpNdx4iHgw6bYeUHzyGO1ylGepzW8v3zRo5JjjX6RvRG96IYe96Wo9mNiqeBefRVtTNANzdOLP7HIt560Kv3sCcfNtbcDoOPx3N7gP+4Wr6WRD3XwPNDvPuz25FKAHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S+OYfxHHszYxWSkcIp2jlZ+ocrXikBw+At+Wb4UH2Q=;
 b=fi6OxXj2xaLYH42tvbJ322AaxL5ois+xIDh95YTjy/3sxlVELfazKHFreEDSPSpOU15jb+kU9W5fzYEH9C48FmvA1IcLOk17rBZkN5pU62vSPL9+Xcl/bhyXw6mfzpH4NCyP20gilfY4njFTjAm16KvHuj8gGGIHOGC1mi7aF/pjo5alQICgp9zvLCL5uMNT/v5J5YP8vnzgQ9kNR4XgHvF0oBFd1o0KML/J85BaI96JzoURImKIWuuWPEnD2yE6dTrV5u+AR1J0Vg1lUvhBykstiWu9lmZY/wXOaniT8Na/S+qtyQ4jQRYgIKWtEUOWnlq7cgESVkTB52QdwLtVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Thu, 3 Nov
 2022 07:01:56 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%8]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 07:01:56 +0000
Date:   Thu, 3 Nov 2022 15:00:06 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     zhaogongyi <zhaogongyi@huawei.com>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [linus:master] [selftests/memory] 13023c33c9:
 kernel-selftests.memory-hotplug.mem-on-off-test.sh.fail
Message-ID: <Y2Nm9sZPDuSZRfYf@yujie-X299>
References: <983aef2332ee47e3abb3efae1290a4b5@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <983aef2332ee47e3abb3efae1290a4b5@huawei.com>
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO1PR11MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ed716a5-bcba-4fdf-b5cd-08dabd694b3e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +vLHjGqvL9cyVFOPgEWYPmZDk9In+JtfPp/Ky1NSpPbnOWfTyEjd6Ty3LJTb1dkBcYZ5T6D1QiOnightMBfdS/VV9N6S3BoW186EDdOOym9ccE5Sue6PXgr9Lx5oLv08mR7+NVnz0+Mz+ShuPRJnCIXA5mgNOs9vh+t5bTQYeh5zWddXvJ9GDlDdtQWW4De4sfHZ/vlJaQs2ca+aLXM2vplkeSsPUyPHHerINDJWznwyjnpu7KbWDRN1jathLI1Kj01qaERdzWtDhEbNqLykum7umktG+TqmLRTJBXcF0a1SdFx7nXx9njgarXxkwBDZ6tBmXRJWJ9aDJsmeIhIrgJDSbMXRL1MDaSZVXxGyhmJiswX6voW2fyvFiisUjz8NcTOYBgdmPbu6SLf9t3uVuWgk6qFG7MOhkj7ybECS+0PstBUJMYvEbAeqbbBmdwhp1T92hxPJDEAtv4lU9pnGKA40fCrOq28EC0StFIMwWWxQwaTuETnAFTg0N5dwJDRiYVi2vfTsSZNf3/90AfFb6NgT4Mvw4w8UmTCsGtN0CHWqj+q8ra8MzSzm5KU/MW1vMWCSh25SeMWE68RYK9cjYFEI3tRi0brFyle+Q5hP/t9qcZoOJqVxaoaSILLuYKq4Lu/38kmx1zxOMCK2WjI0cAOwMaI7weJbeHhT2Ys7ciT/kihEepdaKUmupUPeNTRZ7qZLZTVbj1ybICb6UXZ7DqqA7W22MdZ1vY8EvTb8PvLjC3D+tYNWSHMHt+LBv7xAhz+gYdrr72Ls8ymsLo1aGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(6486002)(966005)(6506007)(478600001)(54906003)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(8676002)(4326008)(6512007)(44832011)(38100700002)(83380400001)(26005)(41300700001)(5660300002)(9686003)(8936002)(33716001)(4001150100001)(86362001)(2906002)(186003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k9tQ1h0Xkxm8Mjh3UlM8j+alFZ3yV45S4pA6J4ntZTDR7CFyoYLnUtN5IWEr?=
 =?us-ascii?Q?YzosHY2P8kuVBT3WHD7w3+YFIlg4uRpjy0FD9Co7wkKTQg7ebjlZA9zHMpIf?=
 =?us-ascii?Q?JbUpBKwjR0X6KRfFkEkRRUkf0++/gAQUKNVYahtTa3ei9UrXNFR1H9bYlRJO?=
 =?us-ascii?Q?yBejSF4Nmhm2XVO/+NXxghX4RMYLOYGFpjhIoZ7/z+DvxyAMVFcBqtU/uyhE?=
 =?us-ascii?Q?5fQ8pbAvEjHePHD+HaqUtcBhmj6uuR+wz+oevGAMK4yAK6pOHQ2iUMZqKaAO?=
 =?us-ascii?Q?PYQr2tW2swK0FEjIgi2BR20T7zpttdxeB/UEWt6ir9yvDhwb+CzdcA/621NC?=
 =?us-ascii?Q?7/XYtkheV2JMatMF5NYRmqCtT2QUY531n01XhISv0mBlWEqx/463cJMadvJM?=
 =?us-ascii?Q?CXR+qf+UIZw2hFic69NvZMWpyPbDn/edWJMftuiVqRmkTiJfkdS5TXgHv4g5?=
 =?us-ascii?Q?DlQu3Xxj8Hd0wNo3r49CbLPYr15Y8rmMqsw9FTPMdzuX4QmN2cTWZ2eZio/1?=
 =?us-ascii?Q?jeBJA21DmgCLBie3aI54WQCVm9UHpwEoudTe2nR5i2Y+8L48aB4O2qWva5An?=
 =?us-ascii?Q?Lb3EbZKSozxpPMXF1p+GzBHxzRw9wNqrdr8LGiTA8V61wq6VQGxyiJuzwMTk?=
 =?us-ascii?Q?Cjo+waTmcWK4ip7eGNGGj6BOVgwJ8Tz8uW/u6IveF5BI1lzwgR7eQtkxjBxL?=
 =?us-ascii?Q?bi8A2rjdNHH/p9L6ZCrgrB5Qb29kqK76vKm1/TVsqO5A9bASMUzzsrOOaBV/?=
 =?us-ascii?Q?E9zPYtimQ1i3QDQcXkwPmJy6ijD5XULL05IVMcBbrDfg6pxUgi65stZQpk+t?=
 =?us-ascii?Q?ggFO7NuF1LqGWw/zSiM/7DN7VruXr8WgXNs5PjbjwJXBJwWiEGmiaflc8pvT?=
 =?us-ascii?Q?MUWHy96JkrS47NOivr9wC/rZUk95Dqhe5UnxkOB0m9fxNL5SgahWMnZ0A6hQ?=
 =?us-ascii?Q?4toLxaXawtm3Sxl3qmymLI2izoJ51QU9FQT2yoI8MbQSZSYFOw/rW5ml/ics?=
 =?us-ascii?Q?cVxafBDTUYT/gs6yD8NJBGjGmQtIhT1AU5ZM1H++jr3fxBSNQ3wpfeJ3MYHN?=
 =?us-ascii?Q?q2+wvs2qE3eejIhVx2QPDFt/2OGbDZvBJ1yeRoo0pVBE4OGHApAduQ2yJf3Z?=
 =?us-ascii?Q?omAkGjTub8Veh9Yc0l0aepCTdVXETPxyC1RHP1RQtsL/11e3p3vYvhdYPkhE?=
 =?us-ascii?Q?x+qdZ9tlnWuM6aE2Fit9I/49uaFM8mjY9uFCX/2il7dbLhwvSoCmAVTIdimj?=
 =?us-ascii?Q?h+fsYcwCsuWup+Ta2PER5sF0DrqYVI/FH0YN/oFCOXutQ8TG3RWPAe0+WDbu?=
 =?us-ascii?Q?p9AGlLnbhgtnpVHQ07yQovEzNcGy1jv3K5CST6B5eSCUekH0SVUnLA3EZssH?=
 =?us-ascii?Q?ICTEQaPjidbO07c9MQ2Dac2NtWYuRzpWwcGnciIgojLmMhmPUrpTsYADjuvg?=
 =?us-ascii?Q?eLx8zgMEXOY8dXZ+vvqp0g8ytgYEa5w7xcOO1VhBMYOnSqkiXBc9CAjGO5HY?=
 =?us-ascii?Q?/lBnADN7xfEEV+WrtQb/NPpckT3vmyxGOiPBeB4ofQpQ9Hn2Q4dGVu+5Wtul?=
 =?us-ascii?Q?lLE6bnUSERD5LEHIvyw4bU31x0w6IDc12PAJtqP2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed716a5-bcba-4fdf-b5cd-08dabd694b3e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 07:01:56.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEv1oxzGDWYP2RLxUHO4l0cQgGElXH8Opmet9tddxgtgDpl8WEOiIRoXzIisqjj7GSEcU7NLvL+AV5x6nk7xaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gongyi,

On Tue, Nov 01, 2022 at 11:56:40AM +0000, zhaogongyi wrote:
> Hi!
> 
> 
> > 
> > Hi!
> > 
> > >
> > > Hi Gongyi,
> > >
> > > We noticed that below commit may change the exit status of
> > > memory-hotplug selftest, please check if the test result is expected.
> > >
> > > We got same test log before this commit but with a good exit, though
> > > there were also some "Invalid argument" and "unexpected success" log.
> > > Please help give some guidance if there are any problems in our test
> > flow.
> > > Thanks.
> > >
> > >
> > > Greeting,
> > >
> > > FYI, we noticed
> > > kernel-selftests.memory-hotplug.mem-on-off-test.sh.fail
> > > due to commit (built with gcc-11):
> > >
> > > commit: 13023c33c962730a38d6b43995910c8805637a9a
> > > ("selftests/memory-hotplug: Add checking after online or offline")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > in testcase: kernel-selftests
> > > version: kernel-selftests-x86_64-9313ba54-1_20221017
> > > with following parameters:
> > >
> > > 	group: memory-hotplug
> > >
> > > test-description: The kernel contains a set of "self tests" under the
> > > tools/testing/selftests/ directory. These are intended to be small
> > > unit tests to exercise individual code paths in the kernel.
> > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > >
> > >
> > > on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> > > (Skylake) with 28G memory
> > >
> > > caused below changes (please refer to attached dmesg/kmsg for entire
> > > log/backtrace):
> > >
> > >
> > > 2022-10-28 01:04:44 make quicktest=1 run_tests -C memory-hotplug
> > > make: Entering directory
> > >
> > '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-13023c33c962730a38
> > > d6b43995910c8805637a9a/tools/testing/selftests/memory-hotplug'
> > > TAP version 13
> > > 1..1
> > > # selftests: memory-hotplug: mem-on-off-test.sh # Test scope: 2%
> > > hotplug memory
> > > # 	 online all hot-pluggable memory in offline state:
> > > # 		 SKIPPED - no hot-pluggable memory in offline state
> > > # 	 offline 2% hot-pluggable memory in online state
> > > # 	 trying to offline 5 out of 224 memory block(s):
> > > # online->offline memory0
> > > # ./mem-on-off-test.sh: line 78: echo: write error: Invalid argument #
> > > offline_memory_expect_success 0: unexpected fail # online->offline
> > > memory1 # online->offline memory10 # online->offline memory100 #
> > > online->offline memory101 # online->offline memory102
> > > # 	 online all hot-pluggable memory in offline state:
> > > # offline->online memory1
> > > # offline->online memory10
> > > # offline->online memory100
> > > # offline->online memory101
> > > # offline->online memory102
> > > # 	 Test with memory notifier error injection
> > > # ./mem-on-off-test.sh: line 267: echo: write error: Invalid argument
> > > #
> > 
> > I can not reproduce the error according to the file 'reproduce'.
> > 
> > Line 267 is not runnable on my system. Is there something wrong here?
> > 
> > The code on my system like:
> > 
> > 266 #
> > 267 # Offline $ratio percent of hot-pluggable memory
> > 268 #
> > 269 echo 0 >
> > $NOTIFIER_ERR_INJECT_DIR/actions/MEM_GOING_OFFLINE/error
> > 270 for memory in `hotpluggable_online_memory`; do
> > 271         if [ $((RANDOM % 100)) -lt $ratio ]; then
> > 272                 offline_memory_expect_success $memory
> > &>/dev/null
> > 273         fi
> > 274 done
> > 
> > 
> > > online_memory_expect_fail 142: unexpected success #
> > > online_memory_expect_fail 190: unexpected success #
> > > ./mem-on-off-test.sh: line 287: echo: write error: Invalid argument #
> > 
> > The problem is similar with line 267.
> > 
> > > offline_memory_expect_fail 107: unexpected success #
> > 
> > It seems the error-inject not work.
> 
> 
> Oh, I see that the version you run the test is based on commit 13023c33c962730a38d6b43995910c8805637a9a, and there is a bug on lib/notifier-error-inject.c.
> 
> The commit of the fix patch is c597d9054b13. 
> 
> Your test version has no the fix patch, So the test failed as expected

Thanks for the info. We tested on the fix patch and found that the issue
is gone.

  lib/notifier-error-inject: fix error when writing -errno to debugfs file

But seems this fix patch has not been merged to mainline yet. We run
various selftests on mainline regularly, so we caught this issue and it
is still there. Hope the fix will make it to mainline soon. Thanks.

--
Best Regards,
Yujie
