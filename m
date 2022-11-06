Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E761E267
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKFNlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiKFNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:41:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1CA10A8
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667742093; x=1699278093;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4ElApx0b1oIxNBn0AKPAIYyzouwRehuY4hAlMvB+3tM=;
  b=bRxoBvJjjMsDg1V1RGfISRfrA8vffUPCAB8jye0Pph+/f+RSD+0jQAYl
   5WvROLqB+kQzoItIHuqt1rBnxVbc6pOlSUMBPklzAHpRkXTPT/1/9WIlW
   Q/XdJ9shfZUYJUIYyAKMamDr7L3Oqdpi6ngVYtznf9pXmsroXT0CLOrkm
   nl0+7gMGDxFI8dl1UAw9PYeApqLdDIj5ktGRQxdwL1bffyZ34CjSYUBRX
   17pBX1tOOkQ77G+O9ak+Vtz/q2kLOQKT2+dtJLn0z8rcrFmJgeCXIeZh+
   SbPuuuQwDBxcbw3MW/v76JX8HAHXLmITh1BCDiymQucH6TTmjxHN5mse2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="308967762"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?scan'208";a="308967762"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 05:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="666894102"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?scan'208";a="666894102"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2022 05:41:32 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 05:41:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 05:41:31 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 05:41:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGIp7ZuDjAZnBYlz5RdxRYgApOAOU983R/lchuXAOp2faCQyg/qM/siA2faB1yOir+F2xi9Znmz0nFfCx1vrzpcIOGFxDw/vrKw2EQg4YzLp1fAYEty/K3NseNOvrS7QgEZdXugDi/1TxOfeqD+cw+R/m1A2coL37dGjJ/hHzmub2PT8sV92JHz1t5lLywL9q1x6vzvcbLhg4H/BDh/npGJ0qdScQyelUFNLyqiD+yodCBangDAmw1hL/+ECR2QZH+AaYhXEXzR61DcZZiOPPa0lQGoePx7BiEKoAko7dggwNWbpgknn9nEDindWHht1EIsluMhgKQdN/p2SsoR6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ8zOHtFRufqRvdfor6/sSt4tBjSNeZx3+qN8O3fN0M=;
 b=lv8/ElTNzweIHNwdLASgAZl4Xt19nfEvKIvUcEP2/Ri2dWvWOqPFDETT3fDJOuY3KPmJyXUD8txGc2Eg36GvEj6M0SR5Db+/1iarzbNovCzriO+A5HELA5RqOh9UY2iHl38EzcimKltrGAsRyVMvvMtx6q8Il9GNbi6tYRJhiVrMz/nRn5WEVGfdUVkiS1dhK/BTlhvtsu4ofZBeG/DwkW8ZlLVgOzc+mEUZW8DWfSjmWQfbXGJTCpzdh45rMnfec7TSnIu5ePSRPXjeA5O/4EVho/TDP0kcFcaC98KoAYkT3u04dEqhqgSPq9khNsmW3tTzGfoefJhm85WbexxHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 13:41:27 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8%7]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 13:41:27 +0000
Date:   Sun, 6 Nov 2022 21:41:17 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [linux-next:master] [mm]  901c96c363:
 BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val
Message-ID: <202211062020.27d654d5-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="rkcXqpSbv+OL2W7K"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b7c1d6-c30b-424f-692e-08dabffc9a0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcSDOCu5KSVRtxrci2YXErVMbZtgod3Iw8txEgH5aBEKHBwSfTsa6zeGnxXuJWkZZPR57YbvQTVub4RmwqvCiv33TMRFoZDN47Oj0IpDAURAeqcQaPiuWQM0odqzdm+Uqw3szxvLYb56PN2TvJfpU8MN9ZUGkJBdjRsK9NsJUu7Nc2bILaGkcgu792aSagsUjo6ZBdcOPXzRteYPzolhlkwDgD+KAvAakKBvdDASYXYhwi+p8SLXehh3nRwvdP+MzTXaWBWcdHuAJrO0c6Ykz3ChQuAaHaRWD4F7h3sZL931H3pknZE1bAg5lPZdm4wAqS9yzdkMlN6wTKFRPD+QQvq/saUQYY+QkqdfNd2aiLzoxWXic5wXq1EK4Br90mEkt9TDmo1S8nR1Ew23cGpf+yI9QVAMMRzE7r+nZ0l6+S38MJO2+F7J6OyBswyZkFEmfcaqkh34It8ycoo+4nqaP+IDxjpcBU2gxE/+YEUN1OyiiuZNYPMziXjSnbn649L1wBtla9pw8jUBgAy1rs1xKdJnDd4G/jZfYkZXPGuefuUB/MI11SGvvpcio3kH1YOlb77qREMJj12r0ELBBOkioFXsOi7T3ZhCqeIrar7OC/FBb8+GoShHbnju2cn98+ApAF+RpK6lgfi3zzgIafYS+yDjmpXJY1rMkemQfpv52DjTA3xWZfjG0jUgDVFikMhtwXhL1U44suzOaBHBk4N0zpryK0BgK5EIkwmuKtjxkwqBtZu9kvfXE1dAudbrNTQcwJ/15NXQ5Q+Vawo2UGDI54+g+JFs3WQiGbuPraHhANSSwvHqQrmRSj4aAR5gxCkx6nA3h40Q4OftdzctYwhffA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199015)(66899015)(36756003)(316002)(5660300002)(6916009)(6486002)(966005)(54906003)(235185007)(83380400001)(478600001)(2906002)(4326008)(41300700001)(8936002)(66946007)(66556008)(66476007)(8676002)(26005)(6512007)(2616005)(186003)(1076003)(44144004)(82960400001)(38100700002)(86362001)(6666004)(6506007)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1+trDlW8IsIjs9Zgt3nY50aGsVJdDAzgZ0c5MN5dwwIQzNP5sft+l1QkOBxE?=
 =?us-ascii?Q?8k+CVA02/1EzRbX7u/sSIgVNTRhm6iyLsRBQDUZ+llBlz6k7ssPmIFREa3a/?=
 =?us-ascii?Q?FkZyJhgzOs5ZHh7BOwlP7z9Xf+KR/lEMmvrz7rn8fM7p+hgWtl/2ribiqeJ1?=
 =?us-ascii?Q?bJUguEkqBw0IQqalZlm7mXkLvNvPwioHMXfhaq10WIwEqEwnX6l7I3xvfY7y?=
 =?us-ascii?Q?n1IsPXAoZ2sHuiN4zm9fXpGljBSqu4g7pvyuvdyoPTbynEKao0AsmShedXPt?=
 =?us-ascii?Q?cloWl/nTE+i8hdD+CLdEU1nWsi1fe1QEsKCbf3ABSrmm7fjCM8PKJp7WJXKf?=
 =?us-ascii?Q?UAGGr+hfwDe5S06e5PjMVLikgazUH6mHVArZGsCiCkgwXzuxXVpsDsnN0jzO?=
 =?us-ascii?Q?Hc5LOiabj06MCDOt3sU0sLTFOJyRAOoe0rb4FqulEJGXz5ljAg2yHYqEGL5W?=
 =?us-ascii?Q?2SnCHXb+GCIY4WUZICZ9l14LlxCxp7vib8TOTOGQWK9pWwHrYeBt+KZtIqHK?=
 =?us-ascii?Q?BJ4Fau8yaeDCFXgkiRvdrYSkN90a9Jy8ck/lNtloPZHWh6bi/3D0tGWell2o?=
 =?us-ascii?Q?E65JuRU9DbENzxhgndiD+gmY9Zka2QxL49QHfo+MK/qIQtfFeDWRlrt3zGr4?=
 =?us-ascii?Q?rA7GBNx34OP1RDH9KJV0YdRY1hV2ZYH6qwkdCAgBclYTb2aSGtkNE/32+in+?=
 =?us-ascii?Q?19hO2dJC4JYBKSiXnaiTOhiSGhqlv8uJ5UEIeQGFYwAFaHHUrqYsiZVakNal?=
 =?us-ascii?Q?fAtBkK49NLRpeL6ddCKw5zEsfk5MmPAS0YRNribKBs7Q5xLlZLNrrYhkqQ1Y?=
 =?us-ascii?Q?GqI0hUOPnvHONMO2lKIQB057GkWOS0Bmba3f+QJdlJVwFFmZFSNG7FmKLO8n?=
 =?us-ascii?Q?Cl72E9ALh2SO61ZHopsnAIoVhTllRSY9FA3hfpe/8TtqqPzciYJGcG9vk3TT?=
 =?us-ascii?Q?6g4TZ50dzNIGSxkhN1nuwvqCJry3FDCPza4qQz+89nczneREpNnwIEs1H3ix?=
 =?us-ascii?Q?Wgtx9Eh/BLi+uFZ1svurBaDe94osOLyoX8KKjo7K2Sio4p6GZRPvaqBWaw1H?=
 =?us-ascii?Q?hUzsTSke6fmuhWrto3fiS/HyN1k3lUFknv9+r037GBY6MghafHxPKgzrcxcg?=
 =?us-ascii?Q?d89LlSeseu7+z3dRaIk9Fx0sPG06OQPAqH6Ny86X31iJ51wjuBS3UwGA3DIF?=
 =?us-ascii?Q?MBvi/nxpD2vHUKTUebnrXTnnEFf3HdDF8iQNmfbEDDtZR5ygGoV69kZ27OyX?=
 =?us-ascii?Q?kKO84ifKM3oj+GZTJ4cAwjXmNQcdNXbET/hfrT/waPdd1rbsbKOb0ldHcjbu?=
 =?us-ascii?Q?Wb5A4xdzW08O7Dh3xCcJ03mIlKwivQoCNoXx90dVDoWp3+gU4QWEetLgu2mT?=
 =?us-ascii?Q?LM3gfen9Aex0t00gaYB4d9uuqlKk1al2WZFJCHdFIHNUUaJckrx+Vb9kLfRV?=
 =?us-ascii?Q?N+K/t3eejDKvI+x7bGNFz867lQDcaAMNiiMVvfvmcKmpPe1dOZxf+UCk3l+z?=
 =?us-ascii?Q?+vC+ufWSYgAk85kHlwZDsRzYhnGKBztyOTOTyzY0VVE/vqCvUGP1eHYPZDKl?=
 =?us-ascii?Q?EebcZlzMZm93oMePZVIhPmnSORjW0wjMYxoZXJnWcyC82eeW2XAzBg00wuwq?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b7c1d6-c30b-424f-692e-08dabffc9a0f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 13:41:27.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC4kXpy/d4yZ7jIFS/2Pyl0pUlULNmJC9H5ub7HdrGivfUeSCZKeGikqDwGqG/GJPKftSDuOHv8YmkdWMJQCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--rkcXqpSbv+OL2W7K
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val due to commit (built with gcc-11):

commit: 901c96c363e951f43ed8eea79363ce1ad383c28d ("mm: convert mm's rss stats into percpu_counter")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8]

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+-----------------------------------------------------+------------+------------+
|                                                     | 67bea3cc72 | 901c96c363 |
+-----------------------------------------------------+------------+------------+
| BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val | 0          | 69         |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val | 0          | 67         |
+-----------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211062020.27d654d5-oliver.sang@intel.com


[   18.896734][    T1] BUG: Bad rss-counter state mm:(____ptrval____) type:MM_FILEPAGES val:9
[   18.898986][    T1] BUG: Bad rss-counter state mm:(____ptrval____) type:MM_ANONPAGES val:16
[   18.904991][    T1] DEBUG_HOTPLUG_CPU0: CPU 0 is now offline
[ 18.906428][ T1] initcall debug_hotplug_cpu+0x0/0x15 returned 0 after 23439 usecs 
[ 18.907924][ T1] calling trace_eval_sync+0x0/0x24 @ 1 
[ 18.909184][ T1] initcall trace_eval_sync+0x0/0x24 returned 0 after 369 usecs 
[ 18.910306][ T1] calling late_trace_init+0x0/0x9e @ 1 
[ 18.911129][ T1] initcall late_trace_init+0x0/0x9e returned 0 after 1 usecs 
[ 18.912228][ T1] calling acpi_gpio_handle_deferred_request_irqs+0x0/0xbc @ 1 
[ 18.915731][ T1] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xbc returned 0 after 2364 usecs 
[ 18.917131][ T1] calling fb_logo_late_init+0x0/0xe @ 1 
[ 18.917691][ T1] initcall fb_logo_late_init+0x0/0xe returned 0 after 0 usecs 
[ 18.918468][ T1] calling regulator_init_complete+0x0/0x86 @ 1 
[ 18.919098][ T1] initcall regulator_init_complete+0x0/0x86 returned 0 after 8 usecs 
[ 18.919900][ T1] calling of_platform_sync_state_init+0x0/0x11 @ 1 
[ 18.920982][ T1] initcall of_platform_sync_state_init+0x0/0x11 returned 0 after 420 usecs 
[   18.928850][    T1] Freeing unused kernel image (initmem) memory: 5152K
[   18.948277][    T1] Write protecting the kernel read-only data: 88064k
[   18.957113][    T1] Freeing unused kernel image (text/rodata gap) memory: 2028K
[   18.961277][    T1] Freeing unused kernel image (rodata/data gap) memory: 1704K
[   19.073388][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   19.074100][    T1] x86/mm: Checking user space page tables
[   19.177593][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[   19.218321][    T1] Run /init as init process
[   19.219043][    T1]   with arguments:
[   19.219607][    T1]     /init
[   19.220112][    T1]   with environment:
[   19.220732][    T1]     HOME=/
[   19.221259][    T1]     TERM=linux
[   19.221838][    T1]     RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/21
[   19.224285][    T1]     BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/vmlinuz-6.1.0-rc3-00174-g901c96c363e9
[   19.226598][    T1]     branch=linux-next/master
[   19.227368][    T1]     job=/lkp/jobs/scheduled/vm-meta-310/boot-1-debian-11.1-x86_64-20220510.cgz-901c96c363e951f43ed8eea79363ce1ad383c28d-20221106-17348-drwvxa-11.yaml
[   19.229799][    T1]     user=lkp
[   19.230351][    T1]     ARCH=x86_64
[   19.230777][    T1]     kconfig=x86_64-randconfig-r003-20220516
[   19.231381][    T1]     commit=901c96c363e951f43ed8eea79363ce1ad383c28d
[   19.232057][    T1]     vmalloc=256M
[   19.232435][    T1]     max_uptime=600
[   19.232829][    T1]     LKP_SERVER=internal-lkp-server
[   19.233356][    T1]     selinux=0
[   19.233710][    T1]     softlockup_panic=1
[   19.234136][    T1]     prompt_ramdisk=0
[   19.234547][    T1]     vga=normal
[   19.274954][    T1] systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.

Welcome to Debian GNU/Linux 11 (bullseye)!

[   22.478273][    C1] random: crng init done
[  OK  ] Created slice system-getty.slice.
[  OK  ] Created slice system-modprobe.slice.
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Local Encrypted Volumes.
[  OK  ] Reached target Paths.
[  OK  ] Reached target Slices.
[  OK  ] Reached target Swap.
[  OK  ] Listening on RPCbind Server Activation Socket.
[  OK  ] Listening on Syslog Socket.
[  OK  ] Listening on initctl Compatibility Named Pipe.
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
Mounting RPC Pipe File System...
Mounting Kernel Debug File System...
Mounting Kernel Trace File System...
Starting Load Kernel Module configfs...
Starting Load Kernel Module drm...
Starting Load Kernel Module fuse...
Starting Journal Service...
Starting Load Kernel Modules...
Starting Remount Root and Kernel File Systems...
Starting Coldplug All udev Devices...
[  OK  ] Mounted RPC Pipe File System.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Mounted Kernel Trace File System.
[  OK  ] Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Modules.
[  OK  ] Finished Remount Root and Kernel File Systems.
Mounting FUSE Control File System...
Mounting Kernel Configuration File System...
Starting Load/Save Random Seed...
Starting Apply Kernel Variables...
Starting Create System Users...
[  OK  ] Mounted FUSE Control File System.
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Finished Load/Save Random Seed.
[FAILED] Failed to start Apply Kernel Variables.
See 'systemctl status systemd-sysctl.service' for details.
[  OK  ] Finished Create System Users.
Starting Create Static Device Nodes in /dev...
[  OK  ] Finished Create Static Device Nodes in /dev.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
Starting Preprocess NFS configuration...
[  OK  ] Finished Preprocess NFS configuration.
[  OK  ] Reached target NFS client services.
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Started Journal Service.
Starting Flush Journal to Persistent Storage...


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc3-00174-g901c96c363e9 .config
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--rkcXqpSbv+OL2W7K
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc3-00174-g901c96c363e9"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.1.0-rc3 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23900
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23900
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_WATCH_QUEUE=y
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_IDLE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING_USER=y
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
CONFIG_INTEL_TDX_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
# CONFIG_SCHED_CLUSTER is not set
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_LATE_LOADING is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_RETPOLINE=y
CONFIG_RETHUNK=y
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
# CONFIG_HALTPOLL_CPUIDLE is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32_ABI is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
# CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
CONFIG_ZSWAP_DEFAULT_ON=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lz4"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SLUB_STATS=y
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
# CONFIG_DAMON_PADDR is not set
# CONFIG_DAMON_SYSFS is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#
# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_PLAT_HOST is not set
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_LOADER_COMPRESS_XZ is not set
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
# CONFIG_FW_CACHE is not set
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_I3C=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=y
CONFIG_GNSS_USB=y
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_OF_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=y
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=y
CONFIG_MTD_MTDRAM=y
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
CONFIG_MTD_NAND_PLATFORM=y
# CONFIG_MTD_NAND_CADENCE is not set
CONFIG_MTD_NAND_ARASAN=y
CONFIG_MTD_NAND_INTEL_LGM=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
# CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
CONFIG_ZRAM_DEF_COMP_842=y
CONFIG_ZRAM_DEF_COMP="842"
CONFIG_ZRAM_WRITEBACK=y
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
# CONFIG_VCPU_STALL_DETECTOR is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_VIRTIO is not set
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_PATA_TIMINGS=y
# CONFIG_ATA_VERBOSE_ERROR is not set
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_DWC is not set
# CONFIG_AHCI_CEVA is not set
# CONFIG_AHCI_QORIQ is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=y
# CONFIG_PATA_OF_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_PSE_CONTROLLER is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_ALPS is not set
# CONFIG_MOUSE_PS2_BYD is not set
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
# CONFIG_MOUSE_PS2_LIFEBOOK is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
# CONFIG_MOUSE_PS2_ELANTECH_SMBUS is not set
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_MMA8450=y
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=y
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_VIBRA is not set
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IBM_PANEL is not set
CONFIG_INPUT_IMS_PCU=y
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_IQS626A is not set
CONFIG_INPUT_IQS7222=y
CONFIG_INPUT_CMA3000=y
# CONFIG_INPUT_CMA3000_I2C is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=y
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
CONFIG_INPUT_STPMIC1_ONKEY=y
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F3A=y
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SIFIVE is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_LITEUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_CCTRNG is not set
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=y
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=y
CONFIG_MIPI_I3C_HCI=y
# CONFIG_SPI is not set
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
# CONFIG_GPIO_CDEV is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
# CONFIG_GPIO_LOGICVC is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_SIFIVE is not set
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_LP87565=y
CONFIG_GPIO_MAX77620=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TWL4030=y
# CONFIG_GPIO_WM831X is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=y
# CONFIG_IP5XXX_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
CONFIG_BATTERY_BQ27XXX_HDQ=y
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=y
# CONFIG_CHARGER_88PM860X is not set
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=y
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=y
CONFIG_CHARGER_LP8727=y
# CONFIG_CHARGER_LP8788 is not set
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
# CONFIG_CHARGER_MP2629 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_BQ256XX=y
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_CROS_USBPD is not set
CONFIG_CHARGER_CROS_PCHG=y
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_MAX77620_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_ACT8945A is not set
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_ATMEL_FLEXCOM=y
# CONFIG_MFD_ATMEL_HLCDC is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC_DEV=y
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_GATEWORKS_GSC=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_MFD_HI6421_PMIC=y
CONFIG_MFD_HI6421_SPMI=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77650 is not set
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
# CONFIG_MFD_WM8998 is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
# CONFIG_MFD_ROHM_BD71828 is not set
# CONFIG_MFD_ROHM_BD957XMUF is not set
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
# CONFIG_MFD_WCD934X is not set
# CONFIG_MFD_ATC260X_I2C is not set
CONFIG_MFD_QCOM_PM8008=y
CONFIG_MFD_RSMU_I2C=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_AAT2870=y
CONFIG_REGULATOR_AS3722=y
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_BD718XX=y
# CONFIG_REGULATOR_CROS_EC is not set
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9121=y
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_FAN53880=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
# CONFIG_REGULATOR_HI6421V530 is not set
# CONFIG_REGULATOR_HI6421V600 is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LP8788=y
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX8973 is not set
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MP5416 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MP886X=y
CONFIG_REGULATOR_MPQ7920=y
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
# CONFIG_REGULATOR_MT6360 is not set
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_ROHM=y
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
# CONFIG_REGULATOR_RTMV20 is not set
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_S2MPA01 is not set
CONFIG_REGULATOR_S2MPS11=y
# CONFIG_REGULATOR_S5M8767 is not set
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS6286X is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65090 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_TWL4030 is not set
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=y
CONFIG_IR_FINTEK=y
CONFIG_IR_GPIO_CIR=y
CONFIG_IR_GPIO_TX=y
# CONFIG_IR_HIX5HD2 is not set
CONFIG_IR_IGORPLUGUSB=y
# CONFIG_IR_IGUANA is not set
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
CONFIG_IR_ITE_CIR=y
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=y
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_STREAMZAP=y
CONFIG_IR_TOY=y
CONFIG_IR_TTUSBIR=y
CONFIG_IR_WINBOND_CIR=y
CONFIG_RC_ATI_REMOTE=y
CONFIG_RC_LOOPBACK=y
CONFIG_RC_XBOX_DVD=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
CONFIG_CEC_CROS_EC=y
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DISPLAY_HELPER=y
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
# CONFIG_DRM_I915 is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
# CONFIG_DRM_AST is not set
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_USE_LVDS=y
CONFIG_DRM_RCAR_MIPI_DSI=y
# CONFIG_DRM_QXL is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
# CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
# CONFIG_DRM_PANEL_DSI_CM is not set
# CONFIG_DRM_PANEL_LVDS is not set
# CONFIG_DRM_PANEL_SIMPLE is not set
# CONFIG_DRM_PANEL_EDP is not set
# CONFIG_DRM_PANEL_EBBG_FT8719 is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
# CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=y
# CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W=y
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
# CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
CONFIG_DRM_PANEL_NOVATEK_NT35950=y
CONFIG_DRM_PANEL_NOVATEK_NT36672A=y
# CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_RONBO_RB070D30=y
CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
# CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
# CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=y
CONFIG_DRM_PANEL_VISIONOX_RM69299=y
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_CHIPONE_ICN6211 is not set
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_CROS_EC_ANX7688=y
# CONFIG_DRM_DISPLAY_CONNECTOR is not set
CONFIG_DRM_ITE_IT6505=y
# CONFIG_DRM_LONTIUM_LT8912B is not set
# CONFIG_DRM_LONTIUM_LT9211 is not set
CONFIG_DRM_LONTIUM_LT9611=y
CONFIG_DRM_LONTIUM_LT9611UXC=y
CONFIG_DRM_ITE_IT66121=y
# CONFIG_DRM_LVDS_CODEC is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_PARADE_PS8640 is not set
# CONFIG_DRM_SIL_SII8620 is not set
# CONFIG_DRM_SII902X is not set
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_THINE_THC63LVD1024=y
# CONFIG_DRM_TOSHIBA_TC358762 is not set
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TOSHIBA_TC358768=y
CONFIG_DRM_TOSHIBA_TC358775=y
# CONFIG_DRM_TI_DLPC3433 is not set
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI83 is not set
CONFIG_DRM_TI_SN65DSI86=y
CONFIG_DRM_TI_TPD12S015=y
# CONFIG_DRM_ANALOGIX_ANX6345 is not set
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_LOGICVC is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_BOCHS is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_GM12U320 is not set
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_GUD=y
CONFIG_DRM_SSD130X=y
# CONFIG_DRM_SSD130X_I2C is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_88PM860X=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_AAT2870=y
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CREATIVE_SB0540=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_FT260=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_GOOGLE_HAMMER=y
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_GT683R=y
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_VRC2 is not set
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_MEGAWORLD_FF is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NINTENDO=y
CONFIG_NINTENDO_FF=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
# CONFIG_HID_PICOLCD_FB is not set
# CONFIG_HID_PICOLCD_BACKLIGHT is not set
# CONFIG_HID_PICOLCD_LCD is not set
# CONFIG_HID_PICOLCD_LEDS is not set
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=y
CONFIG_HID_U2FZERO=y
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=y
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
CONFIG_I2C_HID_OF=y
# CONFIG_I2C_HID_OF_ELAN is not set
CONFIG_I2C_HID_OF_GOODIX=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=y
# CONFIG_USB_R8A66597_HCD is not set
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_GADGET is not set
# CONFIG_USB_CDNS3_HOST is not set
CONFIG_USB_CDNS3_PCI_WRAP=y
# CONFIG_USB_CDNSP_PCI is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
# CONFIG_USB_DWC2_PCI is not set
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y
# CONFIG_USB_ONBOARD_HUB is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_GPIO_VBUS=y
CONFIG_TAHVO_USB=y
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=y
CONFIG_USB_FUNCTIONFS=y
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
CONFIG_USB_G_PRINTER=y
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=y
# CONFIG_USB_G_DBGP is not set
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
# CONFIG_TYPEC_RT1711H is not set
# CONFIG_TYPEC_MT6360 is not set
# CONFIG_TYPEC_TCPCI_MAXIM is not set
CONFIG_TYPEC_FUSB302=y
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
# CONFIG_UCSI_STM32G0 is not set
CONFIG_TYPEC_TPS6598X=y
# CONFIG_TYPEC_ANX7411 is not set
CONFIG_TYPEC_RT1719=y
CONFIG_TYPEC_HD3SS3220=y
# CONFIG_TYPEC_STUSB160X is not set
CONFIG_TYPEC_WUSB3801=y

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_FSA4480=y
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
CONFIG_TYPEC_NVIDIA_ALTMODE=y
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_UFS_CRYPTO=y
CONFIG_SCSI_UFS_HPB=y
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=y
CONFIG_SCSI_UFS_CDNS_PLATFORM=y
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=y
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_AW2013=y
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_MT6323 is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_LP55XX_COMMON is not set
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
CONFIG_LEDS_PCA955X_GPIO=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=y
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_I10NM is not set
# CONFIG_EDAC_PND2 is not set
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX77686=y
# CONFIG_RTC_DRV_NCT3018Y is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TWL4030 is not set
# CONFIG_RTC_DRV_TPS6586X is not set
# CONFIG_RTC_DRV_RC5T619 is not set
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
CONFIG_RTC_DRV_RV3032=y
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=y
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MT6397 is not set
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_ZYNQMP_DPDMA=y
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_NITRO_ENCLAVES is not set
CONFIG_ACRN_HSM=y
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_MENU=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=y
CONFIG_COMEDI_PCL724=y
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=y
CONFIG_COMEDI_PCL812=y
CONFIG_COMEDI_PCL816=y
CONFIG_COMEDI_PCL818=y
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=y
CONFIG_COMEDI_AMPLC_PC236_ISA=y
CONFIG_COMEDI_AMPLC_PC263_ISA=y
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=y
CONFIG_COMEDI_DAC02=y
CONFIG_COMEDI_DAS16M1=y
CONFIG_COMEDI_DAS08_ISA=y
CONFIG_COMEDI_DAS16=y
CONFIG_COMEDI_DAS800=y
CONFIG_COMEDI_DAS1800=y
CONFIG_COMEDI_DAS6402=y
CONFIG_COMEDI_DT2801=y
# CONFIG_COMEDI_DT2811 is not set
CONFIG_COMEDI_DT2814=y
CONFIG_COMEDI_DT2815=y
CONFIG_COMEDI_DT2817=y
# CONFIG_COMEDI_DT282X is not set
CONFIG_COMEDI_DMM32AT=y
CONFIG_COMEDI_FL512=y
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=y
CONFIG_COMEDI_ADQ12B=y
CONFIG_COMEDI_NI_AT_A2150=y
CONFIG_COMEDI_NI_AT_AO=y
CONFIG_COMEDI_NI_ATMIO=y
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=y
CONFIG_COMEDI_PCMAD=y
CONFIG_COMEDI_PCMDA12=y
CONFIG_COMEDI_PCMMIO=y
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=y
CONFIG_COMEDI_S526=y
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=y
CONFIG_COMEDI_CB_DAS16_CS=y
CONFIG_COMEDI_DAS08_CS=y
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
# CONFIG_COMEDI_NI_DAQ_DIO24_CS is not set
# CONFIG_COMEDI_NI_LABPC_CS is not set
# CONFIG_COMEDI_NI_MIO_CS is not set
CONFIG_COMEDI_QUATECH_DAQP_CS=y
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_AMPLC_PC236=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_ISADMA=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_LABPC_ISADMA=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC=y
# CONFIG_CROS_EC_I2C is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_LIGHTBAR=y
CONFIG_CROS_EC_VBC=y
# CONFIG_CROS_EC_DEBUGFS is not set
CONFIG_CROS_EC_SENSORHUB=y
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_CROS_EC_TYPEC=y
CONFIG_CROS_USBPD_NOTIFY=y
# CONFIG_CHROMEOS_PRIVACY_SCREEN is not set
CONFIG_CROS_TYPEC_SWITCH=y
CONFIG_MELLANOX_PLATFORM=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_MLX_PLATFORM=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=y
# CONFIG_P2SB is not set
# CONFIG_COMMON_CLK is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=y
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
CONFIG_LITEX=y
CONFIG_LITEX_SOC_CONTROLLER=y
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADXL313_I2C is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL355_I2C is not set
CONFIG_ADXL367=y
CONFIG_ADXL367_I2C=y
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA400=y
CONFIG_BMA400_I2C=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_DA280=y
CONFIG_DA311=y
CONFIG_DMARD06=y
CONFIG_DMARD09=y
CONFIG_DMARD10=y
# CONFIG_FXLS8962AF_I2C is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
# CONFIG_KXSD9_I2C is not set
# CONFIG_KXCJK1013 is not set
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MSA311 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7091R5=y
CONFIG_AD7291=y
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD799X=y
CONFIG_ADI_AXI_ADC=y
CONFIG_DA9150_GPADC=y
CONFIG_DLN2_ADC=y
# CONFIG_ENVELOPE_DETECTOR is not set
# CONFIG_HX711 is not set
CONFIG_INA2XX_ADC=y
CONFIG_LP8788_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1363=y
# CONFIG_MAX9611 is not set
# CONFIG_MCP3422 is not set
CONFIG_MEDIATEK_MT6360_ADC=y
CONFIG_MP2629_ADC=y
CONFIG_NAU7802=y
# CONFIG_QCOM_SPMI_IADC is not set
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_RN5T618_ADC is not set
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADS1015 is not set
CONFIG_TWL4030_MADC=y
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=y
CONFIG_SCD30_CORE=y
# CONFIG_SCD30_I2C is not set
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
CONFIG_SENSEAIR_SUNRISE_CO2=y
# CONFIG_VZ89X is not set
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y
# CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE is not set

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
# CONFIG_AD5446 is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5696_I2C is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
CONFIG_MCP4725=y
# CONFIG_TI_DAC5571 is not set
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Filters
#
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_FXAS21002C=y
CONFIG_FXAS21002C_I2C=y
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
CONFIG_AL3010=y
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
CONFIG_CM32181=y
CONFIG_CM3232=y
CONFIG_CM3323=y
CONFIG_CM3605=y
# CONFIG_CM36651 is not set
CONFIG_IIO_CROS_EC_LIGHT_PROX=y
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
# CONFIG_LTR501 is not set
CONFIG_LTRF216A=y
CONFIG_LV0104CS=y
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
# CONFIG_SI1145 is not set
CONFIG_STK3310=y
# CONFIG_ST_UVIS25 is not set
CONFIG_TCS3414=y
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_MAG3110=y
CONFIG_MMC35240=y
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_YAMAHA_YAS530=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=y
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5110 is not set
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MAX5432=y
CONFIG_MCP4018=y
CONFIG_MCP4531=y
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=y
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_DLHL60D=y
# CONFIG_DPS310 is not set
CONFIG_HP03=y
CONFIG_ICP10100=y
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
# CONFIG_IIO_ST_PRESS_I2C is not set
CONFIG_T5403=y
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_CROS_EC_MKBP_PROXIMITY is not set
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
# CONFIG_PING is not set
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX_COMMON=y
CONFIG_SX9310=y
CONFIG_SX9324=y
CONFIG_SX9360=y
CONFIG_SX9500=y
CONFIG_SRF08=y
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
CONFIG_TMP117=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# CONFIG_XILINX_INTC is not set
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_SIMPLE=y
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=y
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_TUSB1210 is not set
CONFIG_PHY_INTEL_LGM_COMBO=y
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_IDLE_INJECT is not set
CONFIG_DTPM=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
# CONFIG_BTT is not set
# CONFIG_OF_PMEM is not set
CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_RMEM=y
# CONFIG_NVMEM_SPMI_SDAM is not set
# CONFIG_NVMEM_U_BOOT_ENV is not set

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_INTERRUPT_CNT=y
# CONFIG_FTM_QUADDEC is not set
CONFIG_MICROCHIP_TCB_CAPTURE=y
# CONFIG_INTEL_QEP is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=y
# CONFIG_PECI is not set
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
# CONFIG_F2FS_FS_LZORLE is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
CONFIG_CACHEFILES_ONDEMAND=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_64BIT_CLUSTER=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
CONFIG_BEFS_DEBUG=y
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
# CONFIG_UBIFS_FS_XATTR is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=y
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
# CONFIG_EROFS_FS_ONDEMAND is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_DES is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
# CONFIG_CRYPTO_ECHAINIV is not set
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_POLYVAL=y
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_VMAC is not set
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
# CONFIG_CRYPTO_XXHASH is not set
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
# end of Random number generation

#
# Userspace interface
#
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=y
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=y
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_FRAME_POINTER=y
CONFIG_OBJTOOL=y
# CONFIG_STACK_VALIDATION is not set
CONFIG_NOINSTR_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
# CONFIG_PAGE_TABLE_CHECK_ENFORCED is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
CONFIG_DEBUG_OBJECTS_WORK=y
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
CONFIG_DEBUG_MAPLE_TREE=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
CONFIG_IO_DELAY_UDELAY=y
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_PM_NOTIFIER_ERROR_INJECT is not set
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
CONFIG_FAIL_FUTEX=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--rkcXqpSbv+OL2W7K
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='901c96c363e951f43ed8eea79363ce1ad383c28d'
	export kconfig='x86_64-randconfig-r003-20220516'
	export nr_vm=300
	export submit_id='636775060b9a9343c4b4a422'
	export job_file='/lkp/jobs/scheduled/vm-meta-310/boot-1-debian-11.1-x86_64-20220510.cgz-901c96c363e951f43ed8eea79363ce1ad383c28d-20221106-17348-drwvxa-11.yaml'
	export id='d01c2cbf19449414b8c93c7266057220d5fd492a'
	export queuer_version='/lkp/xsang/.src-20221104-064711'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-11-06 16:49:10 +0800'
	export _id='636775070b9a9343c4b4a42d'
	export _rt='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/21'
	export scheduler_version='/lkp/lkp/.src-20221104-135305'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/debian-11.1-x86_64-20220510.cgz/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/21
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/vmlinuz-6.1.0-rc3-00174-g901c96c363e9
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-310/boot-1-debian-11.1-x86_64-20220510.cgz-901c96c363e951f43ed8eea79363ce1ad383c28d-20221106-17348-drwvxa-11.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-r003-20220516
commit=901c96c363e951f43ed8eea79363ce1ad383c28d
vmalloc=256M initramfs_async=0 page_owner=on
initcall_debug
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/modules.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-310'
	export kernel='/pkg/linux/x86_64-randconfig-r003-20220516/gcc-11/901c96c363e951f43ed8eea79363ce1ad383c28d/vmlinuz-6.1.0-rc3-00174-g901c96c363e9'
	export dequeue_time='2022-11-06 16:49:32 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-310/boot-1-debian-11.1-x86_64-20220510.cgz-901c96c363e951f43ed8eea79363ce1ad383c28d-20221106-17348-drwvxa-11.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--rkcXqpSbv+OL2W7K
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--rkcXqpSbv+OL2W7K--
