Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20F60DCEB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiJZISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiJZISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:18:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEA96A3C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666772311; x=1698308311;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e6Ddd3aS1yN3mWyJ06GIa7bslm5DPUtkT4LN7Q7YRYY=;
  b=PkeOB9FCI5P6ffp0km/O0XxN1+6qT3xpUPq0o6dop7gQ4WwjiOSof9FN
   uEb77jes3dNpNpRNH9BHwFFKc396byhV+Sahxdfg4eSqfI0W0UIpbD8Et
   hOTQMAt/zKpI4RwcH3r6Wf+WNtVGmCBDvLa4eGT7O1cZ3qCOh6fk/UZx4
   kLv2UkUfcFSmmS5KGEkHdXro6JxVW6/IOv9WGatgysNak9XoHWhq6WCJY
   R2QV7fg/1NlTOL8KibcgFXTHiT2hogikszNlu+NIhondkQPVj9NKmlZD6
   CgKWo4BYOdhVCqFUZLJf7fyGJDVu5FBpAzo51M7gGIX93DzBjV+CwVYyS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334505567"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="334505567"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="665208735"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="665208735"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2022 01:18:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 01:18:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 01:18:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 01:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcCtQmBQjYXyqmIaNlW0oeTnYRoNkW9Qjx/w1huTXmKmfz2eO3wD/91Toj1ByYtRqe2E1NmzLwfYlpxjNdy82WinKvJSMOzO7N5hFXPOOtY3hHi8GbqPJszt8hBVbLWajiBNqFSIsl8YGDbjTsY4h4v8QXBVWwg/TvM8Dojs+Vtxs8sp48TOrLK/tcHxtO9XYW1N/cAv41tM6dMietx91aEYPWmmQOUKz5sVqh8ZYt2KvSYFZX19eBpN2z48LZMt2w1bWA4KaDkzfQtVwPevXvASt1ptYNn0Ef2Q6V2hvxmznhYJLW8sEmy0y9XgubCv+S4/qF3dbD1hgc5RkDcopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3qnS7b/MZgsLVQ330yTnpjopS6qsd9EXamrUDsDLqA=;
 b=dVzd/wMo+KIfmbxfuxjzENzxk2PDf80Dkh+GtRcB2EwqU21QKXPXY/ZfxSorUITqzpxqHUmtc8uGdvJInsb29BHugy4aEhHVMwVfIzeZh6FiAizvTQpKBoNVSLkjXV0CMKfF8r3sr9kYthjboHK4mPIHL2mvjYEUgrNPovJgxmEhwNYfeuoi6kfu+lPmf90um1yVGboRFqMnw8LKRnWZ16NI0FbQcY9KPOSOml9T5ZBBf1wNDZRTny9rOAZWrokkqtQgMA+MPt5tDQQpZqVx3EDIKXBrOXp1gXgcwXgJ9ftiVmFdudyhiPHkoWPGmJDX/2fkw0IzskvcYWgiY4q9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 08:18:28 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::a397:a46c:3d1b:c35d%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:18:28 +0000
Date:   Wed, 26 Oct 2022 16:17:01 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     kernel test robot <oliver.sang@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        "David Howells" <dhowells@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "SeongJae Park" <sj@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [linus:master] [i915]  f683b9d613:
 igt.gem_userptr_blits.probe.fail
Message-ID: <Y1js/ZTP+e0UEdWD@yujie-X299>
References: <202210241246.68be2f11-oliver.sang@intel.com>
 <20221024150734.zjo46njdblmykczj@revolver>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221024150734.zjo46njdblmykczj@revolver>
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO6PR11MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2882cf-7050-4a4d-e382-08dab72aa90c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb0lwXwDktEVdHH3p2xF3RGnzg+3wqoLa9U4brFsL26RNmnGp5Vo2al0vcGn3+K4mYtHpR0ycPJaQ1Ueszg7Kqe+cgrqoj5o6StSiCfxWstS/Y5B1hoM03lLnN8KSML0cvYwiB18uYlAwMXK0bhevp6pd2kUV0VYrXg/Fl9CKFOOHjvVWVswcYxzsKPTk5ZMw5qmbDFavRNJUovxcXW6a5bs9/UJXx9XMXK6pjgJk6EEYGLoVXTFyRNBKlwpJFkFlrq/xF9IOnynrCnCKu2gTbuktMjoRGDzRGKoxS+7nQLRG1N1nvEJKY+B4W2JHo4ag7i9qnzBUuqOGnkJ26CyYXQXDlUglsluMOSFAokFDOoWk5VX3Wb+7FWws1Fr3JDDO6cmOZQc8pMIr6QwHCs/FpM7ZJJGcJgSsiPsfxU9/OZGizQ/7TPGTmqzgP8XmXf3o5mdYZAccrHgm8dOPjF/n8YMkMJE2ZN7xB6jFvwaEaCFNY/4IgZcsEw0EyBUplqRBL0UMfsLlPhVXgQZXtf0kbD91Kn6aXPy5lRwGyK5H5OpNlmGv+kTpjoIu8GDBsouGz0N/ioD+mjRiYk1DBTGVRVFnOEDniQivj0AW9F0ZxY8gfyC4IMZVWUZKQk61wmjxI67U2STv9UvzaqcAZbWLBvAMO1b+exKs5sRz/bVvoYxOqimkBUJmRMN8wgBp/AqyfmVVEvA1QpY58+Fl3LWeAjDBOGZy0OtEamR3EFl5rSNhGfzWmsgEzRA8wihrDf42jmqiawgX2iv2+lDVcZQiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199015)(38100700002)(316002)(83380400001)(54906003)(6512007)(6916009)(86362001)(9686003)(66476007)(26005)(41300700001)(186003)(8936002)(44832011)(5660300002)(4001150100001)(7416002)(8676002)(4326008)(66556008)(66946007)(6666004)(2906002)(6506007)(6486002)(966005)(82960400001)(478600001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xINnWs2aLqcV8r6qtRz5LfSM9e1R41xz7Aov7gqEZxIYGJLKvZ+30V3UcNaL?=
 =?us-ascii?Q?vBeWj5wYuA4ujpgx6tDVoi3L8J9UkGjeQQ4XtP1/LORi2eu51M0nIVBH3gem?=
 =?us-ascii?Q?bO1XafPqUtAhBgwF6zKzvQ4n/Tr8hH1NDJBN9ivr/8J5ZE0jzd4GVI20KsEg?=
 =?us-ascii?Q?EIZYl6l5r0P11CxwmnUvkqL9f5s417TZXHQZaygPkuT51Pqh4Pr6eqmR9msL?=
 =?us-ascii?Q?K9MWQve49UXvpJ7e19QI6hlS5CPhJxtQW087x4mgXn1+qzjMgSpbHjxMcrl9?=
 =?us-ascii?Q?AKdl7LzqP8E3hKvmY0LrY2N68M5GrzrDBAmF0S8v+qrZ+VxCLc6re+R1UhN+?=
 =?us-ascii?Q?FJRWIU3hiTv8pH4B2jhqpR8FCDEiokzZQrxnAE+uFqkD5nJ70DdcsojKPwgf?=
 =?us-ascii?Q?sThoYk40KttL2wrmEkbDRZkiMteDjv1jaGV92DnKTDJS7+26G/z2K+FkXDfh?=
 =?us-ascii?Q?wk2b8o0PTbrRNEB5qHL9fmdM3MOIHYK7yTgl2g066Z1jg9Q3I2gHArXM9/BP?=
 =?us-ascii?Q?83/DHZZHHMdIqtKltWT5wZHVMVcuOG/yFoFTzubQBpobVL45bg5lRR0okPCC?=
 =?us-ascii?Q?TicrsM/R5WsHFzkTcr7lYf1HcxyhqIre/Fua+sfFYiLc5GXVYODW77ckyOxH?=
 =?us-ascii?Q?KekcjHeZn3Ige3x/7g/8ppVIpz0ay+fZ8mT3zZsCdiOGllIMljIcb234MIKv?=
 =?us-ascii?Q?7TxfU1ynSkeQQ3wCrcgAd41EhwP6a8PyoUrvjV5re9gPIOhr/dOyOMWzeL8Q?=
 =?us-ascii?Q?9i2I+p+L8ZzBM8xyU+fSpp4a0rHpBmb35OYDJIvsKPbUK+OHhhCDNal1nhNG?=
 =?us-ascii?Q?Oo7EU4VCt0FNIWjKt9Ck538rCN8fu4FXuFhEkcj+FtDfFsQSfXl8x391yxIT?=
 =?us-ascii?Q?dggtX8eQCpkCBUmmtfo9E9UAPTb92A6NhlBeKfI8KvmsAIQde5ew6T3oQphD?=
 =?us-ascii?Q?rQTt2tyFR+3f4jdzG9xjDHnis0p6qVIRoBoKD6XkSqwbZPFv37CV8/ie0hmz?=
 =?us-ascii?Q?bQO0Gx/ETHc8howGGxk5MXmrqNcb0q+1CPMINu2uORNPuqPd/HABff3ZafoJ?=
 =?us-ascii?Q?sgq88S2um99maERWZmV8MfsORSsLqFWwOjuWQ9cZB6TdbQDjS3QycKb14fLm?=
 =?us-ascii?Q?atD21BRtzQKKtyOfxQdc4MRIY1bghH4n7KDqL8Xygk7V1A/8SnSDOlZoPgnf?=
 =?us-ascii?Q?ONLGzljyv4VhdWfjNL2oGtn5PzQr5ir2DWWDs1uLhkSfzfHkUHNfFKJMlwft?=
 =?us-ascii?Q?jhQuOPQobNLCApwF3oF+AJM+8xp5P1chiciCfYM0lrU+CpoBd8FOnQL2nqxh?=
 =?us-ascii?Q?aCPZ5MQ6bkbsKEvz9il4Of5GZwRjHlMMm67c4KEFJCVMrBjQvxhaVkgiLitS?=
 =?us-ascii?Q?2is1eOBUvCZ0JHupR5igg4Ew3N9li4H8SA0FlnECE2XzKzpvFa6uiougRkAS?=
 =?us-ascii?Q?4GnWWnuXiNFEYg+vJgHtnGpgYMW7crh9LYdBYOlpxUYmnuXNXRJIhygD4rvd?=
 =?us-ascii?Q?MX2f2j0ydHp8jeQrNQ8MRiEyIEumEa8Sbhsg2BShMvI15WrFpgroSUIi+rSD?=
 =?us-ascii?Q?wbmYJLks7/NIXRbfyUVuITWQL+ULKEZCdcCBDV7o?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2882cf-7050-4a4d-e382-08dab72aa90c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:18:28.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyFuk7P+HGDpVw092gcg/O+HHgHGFt+4HBgh2jVgC5rojZ9n8WBsUKtz7VJXQEdfM5mWaMzjJGspWr5/hiMuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5602
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Mon, Oct 24, 2022 at 03:07:54PM +0000, Liam Howlett wrote:
> * kernel test robot <oliver.sang@intel.com> [221024 01:06]:
> > 
> > Greeting,
> > 
> > FYI, we noticed igt.gem_userptr_blits.probe.fail due to commit (built with gcc-11):
> > 
> > commit: f683b9d613193362ceb954c216f663a43c027302 ("i915: use the VMA iterator")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: igt
> > version: igt-x86_64-cf55acde-1_20221012
> > with following parameters:
> > 
> > 	group: group-13
> > 
> > 
> > 
> > on test machine: 20 threads 1 sockets (Commet Lake) with 16G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Link: https://lore.kernel.org/r/202210241246.68be2f11-oliver.sang@intel.com
> > 
> > 
> > 
> > 2022-10-24 03:27:39 build/tests/gem_userptr_blits --run-subtest probe
> > IGT-Version: 1.26-gcf55acde (x86_64) (Linux: 6.0.0-rc3-00280-gf683b9d61319 x86_64)
> > Aperture size is 268435456 MiB
> > Total RAM is 13505 MiB
> > Not enough RAM to run test, reducing buffer count.
> > Test requirement not met in function __igt_unique____real_main2320, file ../tests/i915/gem_userptr_blits.c:2401:
> > Test requirement: has_userptr(fd)
> > Starting subtest: probe
> > (gem_userptr_blits:1984) CRITICAL: Test assertion failure function test_probe, file ../tests/i915/gem_userptr_blits.c:2231:
> > (gem_userptr_blits:1984) CRITICAL: Failed assertion: __gem_userptr(fd, ptr + 4096, 3*4096, 0, 0x2, &handle) == expected
> > (gem_userptr_blits:1984) CRITICAL: Last errno: 14, Bad address
> > (gem_userptr_blits:1984) CRITICAL: error: 0 != -14
> > Subtest probe failed.
> > **** DEBUG ****
> > (gem_userptr_blits:1984) DEBUG: Test requirement passed: has_userptr_probe(fd)
> > (gem_userptr_blits:1984) CRITICAL: Test assertion failure function test_probe, file ../tests/i915/gem_userptr_blits.c:2231:
> > (gem_userptr_blits:1984) CRITICAL: Failed assertion: __gem_userptr(fd, ptr + 4096, 3*4096, 0, 0x2, &handle) == expected
> > (gem_userptr_blits:1984) CRITICAL: Last errno: 14, Bad address
> > (gem_userptr_blits:1984) CRITICAL: error: 0 != -14
> > (gem_userptr_blits:1984) igt_core-INFO: Stack trace:
> > (gem_userptr_blits:1984) igt_core-INFO:   #0 [__igt_fail_assert+0x106]
> > (gem_userptr_blits:1984) igt_core-INFO:   #1 ../tests/i915/gem_userptr_blits.c:801 __igt_unique____real_main2320()
> > (gem_userptr_blits:1984) igt_core-INFO:   #2 ../tests/i915/gem_userptr_blits.c:2320 main()
> > (gem_userptr_blits:1984) igt_core-INFO:   #3 ../csu/libc-start.c:308 __libc_start_main()
> > (gem_userptr_blits:1984) igt_core-INFO:   #4 [_start+0x2a]
> > ****  END  ****
> > Stack trace:
> >   #0 [__igt_fail_assert+0x106]
> >   #1 ../tests/i915/gem_userptr_blits.c:801 __igt_unique____real_main2320()
> >   #2 ../tests/i915/gem_userptr_blits.c:2320 main()
> >   #3 ../csu/libc-start.c:308 __libc_start_main()
> >   #4 [_start+0x2a]
> > Subtest probe: FAIL (0.052s)
> > 
> > 
> > 
> > To reproduce:
> > 
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >         sudo bin/lkp run generated-yaml-file
> > 
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> > 
> 
> These steps seem insufficient.  Initially, it failed complaining about a
> missing config so I created the directory manually and copied the
> confing in only to have it fail again:
> 
> lkp-tests/filters/need_kconfig_hw.rb:11:in `load_kernel_context':
> context.yaml doesn't exist:
> /pkg/linux/x86_64-rhel-8.3-func/gcc-11/f683b9d613193362ceb954c216f663a43c027302/context.yaml
> 
> Is there a full set of instructions for recreation?

Sorry for the unclear reproducing steps. Seems it is due to bug in our
split-job code, we will fix it soon. Could you please try below steps
instead to see if the problem can be reproduced? Thanks.


# Build kernel on commit f683b9d61319 with the attached config in
# original report, and boot it on a machine.

$ git clone https://github.com/intel/lkp-tests.git
$ cd lkp-tests
$ bin/lkp split-job --compatible jobs/igt-part2.yaml
jobs/igt-part2.yaml => ./igt-part2-group-10.yaml
jobs/igt-part2.yaml => ./igt-part2-group-11.yaml
jobs/igt-part2.yaml => ./igt-part2-group-12.yaml
jobs/igt-part2.yaml => ./igt-part2-group-13.yaml
jobs/igt-part2.yaml => ./igt-part2-group-14.yaml
jobs/igt-part2.yaml => ./igt-part2-group-15.yaml
jobs/igt-part2.yaml => ./igt-part2-group-16.yaml
jobs/igt-part2.yaml => ./igt-part2-group-17.yaml
jobs/igt-part2.yaml => ./igt-part2-group-18.yaml
jobs/igt-part2.yaml => ./igt-part2-group-19.yaml

$ sudo bin/lkp install igt-part2-group-13.yaml
$ sudo bin/lkp run igt-part2-group-13.yaml


--
Best Regards,
Yujie
