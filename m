Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464B682624
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjAaIIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjAaIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:08:49 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D01CF6D;
        Tue, 31 Jan 2023 00:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675152518; x=1706688518;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rj+VCfF02H0rvlSi+p0+oCp6Ab5Xrm9yf8GRjvXyGN8=;
  b=dEvob6DqZDohLmH+mSNaOuLvH9tjG4zSmJJjzgQFbPgD+p/pP3ZxTFhU
   UE6b20yfbByxyjYDRoMnpp94+USo0gHlJnz9ixck71A18VCVFqWnbJzJn
   X2g00B/JbJaLAFtL35wCe2a9Qcxx/NOutIFpMEo7/5AXqfAXBOLVzu3mA
   NHNrAAddYvc0HxLpOSTQd3HALDuvz7D5tu30JfsGMpKqbF3FapEzcdAyD
   9RN0YswhFlHq1P00Sg2oe/0UOGWw8BCLguUzr+AKBrVr8EAT7S0PiiJjR
   0sl/28VKeSt+qifWkYNmx0dlJ/iKPT5GEWvShqc/wIVdhSgTHbilrfLIB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392328759"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="392328759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 00:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727840530"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="xz'341?yaml'341?scan'341,208,341";a="727840530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2023 00:08:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 00:08:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 00:08:33 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 00:08:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhIaSfYIQeRFH1Xw/KsbSaIAUmgt6jvVZvOFCghqtV7ylaVh0HmUh3Mw9HA2JD/nbzgm0ScwwOm0/jyK+lWIJNhoEYAoGBBCh5PHqpKQFuhJ9TsYNDfDeefU7/eTf5/Zw+pNrxKHgtonVbKkeaQoQP5LviA6wo/OuN9VbXPUzd6XYjwRsIs8KH9k2H+5eZBS185EmrQV61K3gvEYVO3rCN/WedqSPIfpgrDiNLYfE+5yutpdn56s7ct/XO/sDhfFh9Pvck455hH2xaMLg23J5DEnTSttpZAvp7tTqUSF6hKXv6Mw8eDm7FMl1DZwU63eJjuE+68tdktYE4pYgWmDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaasRilTMKpfc5lFfaa2OL2jMYxqB6eHyEE0nB3/4Bo=;
 b=RGNnqFalFZlVrOR1ufRTdvBHsRsTnmekk70Cd5X/mz4E1yXPWKb92ZgVltnxbU9Ra6WYCq4oJnr5eJS+4vqHytqJ4cw4SH5+i1n3Mo4gkqWNbupcQSX6005ag1JiYauQrlhOCa0yTnIJBNHKQZAjIR5qCEy90saZIUGicckB9j3C+c67NZ/11nlsowDb1jFTDZsZjFeLt+fORyrjwyyUcK7RMT3L6Ufj8Nly1zCoI09oBY/SnjwtGyrs9kiaMF8IThogZIOn5qNzVwxHzEoZe+Ollfeyya5185A3Ty3kByIivkRGa3BQjglby3+wQoj2IPJNB7GsCeC0yjpKPdNC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM6PR11MB4531.namprd11.prod.outlook.com (2603:10b6:5:2a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Tue, 31 Jan
 2023 08:08:24 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::878d:c56c:28fd:e1cd%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 08:08:24 +0000
Date:   Tue, 31 Jan 2023 16:08:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Ajay Kaher <akaher@vmware.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <namit@vmware.com>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <amakhalov@vmware.com>,
        <vsirnapalli@vmware.com>, <tkundu@vmware.com>,
        <er.ajay.kaher@gmail.com>, Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH 8/8] eventfs: moving tracing/events to eventfs
Message-ID: <202301311549.6afc9591-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="WZ9JtNOrUroHJib6"
Content-Disposition: inline
In-Reply-To: <1674407228-49109-8-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM6PR11MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: a16721cd-61b4-4b58-d2b7-08db0362529c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FK8GgwUrx4k2S4VHyTBL5LtpfRyrCkK5aCsMkavPHUC5NByy3dBwAT6jHEHnlKFlv+i8xiw0nMtV2S9P8bMYe5BXxB59bPxNmPQ3hCor3D4l1ui4G9dz3LbrhGJp9KocJGwtQjXmFU9kurM9+GlRtgqbM5BZe8ZQ79W8lYWvRMZCxO5U9IKtvxD6LD+hzxcg6bk9hTrZ9VsoXiPDISrvDWlaKKMzkw3RAdQEzk0gJy39y42w83l69ZUmSFf0QGGvGpRj7j2HD/iI1EYJG/IuJoBrbg5fdCsUPiQVwX+DmeeZRmL7YoYT72HSghi3xM2W6FUOaMGjtANJxVvGZ5nJt6xK//I6KKkOIjWOhnr4tjqZv6FFM5QACrNtacRkC7A7hRkBGtuXYuSfyKiiQi6O+rlz2CdCbb9PH886jUcl0cthMEQTVBlm0OH+vB6AcoTbuOPOW7vdEpWcUz1t/j6y8+fqLxO8eK49zzPz7sUkXrsnFV1AB4GebBfsqajwbqOrfGR1p8wzJ8NUkR9WIiPRtDQD3SqNESsNjkWh/+hPa/f3E3QJRhdNeMuwwtzQVRO7S2WY5scJrx8nDvCt47ufILAl3UVZpUfCP3L1ZZrQ6KY1Yf5VyK/+I+vp45cOeUndPDwpEEHBqOx61Dli7xg6g31PJWKKM0AZrnLhlzeFw0yK1yfJVxp2vMx8UWVTDdwZagr0EpztpS7IZX+eBwcbmiUYMy9GjiucgdzTJQOVuc4D6xP97q23vU9UyyAhUHYKnbA3/aGJSea7FdguubasgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(2616005)(316002)(38100700002)(8936002)(6486002)(186003)(26005)(6512007)(1076003)(7416002)(30864003)(21490400003)(6666004)(2906002)(86362001)(235185007)(478600001)(36756003)(6506007)(44144004)(82960400001)(54906003)(5660300002)(966005)(4326008)(83380400001)(41300700001)(6916009)(66946007)(66476007)(8676002)(66556008)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9lSoEkjt5xp6c94XFyW7GHZnEPavMPGtG9qmwOS3loQ43mNWIjm9UxrxSqm?=
 =?us-ascii?Q?Y7vK2i97vAhyduH4aniX2kkuHq45ZjXm1uziKiTzrOTnDpybZCr4FeuErM5D?=
 =?us-ascii?Q?CQYOtDCbiE2I0SKjtB8G2YOhvdGez8mQBgfgkbLkb9qLzt7yM67uPBTo5LyK?=
 =?us-ascii?Q?sRyTZEwMYhv0NkaQG13LNK3SnPGahSjkJ9kdOppSp9ojNLAPb70p/JWlCyGS?=
 =?us-ascii?Q?y7WSvaClXV1MKujK6wjPzJqtIqzUdyVY+a7wItHVsD2W9fA1Is9IojQnxgh/?=
 =?us-ascii?Q?9L7qAbVMkQjNtQtO2+sh2IHhVF6OgDEWO34+Ljbstd4W00ltrijn9AMruAwK?=
 =?us-ascii?Q?7+HNCkaylRbFfEYFFwe3Eu0r9w4s45G6wdXCGwc5xjOKMw+epdJLHZosJgmc?=
 =?us-ascii?Q?NwIyijffanQJ86Eq9nccBD0FIfLa8+1JOFYKvqdEwuOrzMmecNBTr1ZjEuPs?=
 =?us-ascii?Q?WA61DjrReqewHnufESPrRxKBXp73kQoNDx+xed/EhSM5fFDwaXJujAJlBF+t?=
 =?us-ascii?Q?/D78RVEGqnVn//pAJhDIaR+akraS6yigyhChTn9AGO5Plrme0BLh6d/i+AMe?=
 =?us-ascii?Q?3c9JArcjknfFJEtOHRnpX1NqebhOL5YDSLEfChGdq9RYFbqkOfMnvmlzmpjd?=
 =?us-ascii?Q?TNTyPqrDoUE2LsG7HugDjRVnmcx3WbAKqPAvGa1orq2Y7tKckPCd7gD1rZyM?=
 =?us-ascii?Q?7Rq4G7z9kRLPtiPM6Ui2XkneBMoKF0KSI8nWOtb1zsuBlWTSJc5S1wrCWBSr?=
 =?us-ascii?Q?k0YcR6M1gcOXp4ifH5savQ3eVI6TlKanUjNZD7iCswwuwxPVpGK5PqM8uNi5?=
 =?us-ascii?Q?aestqrnpKIyHm8lVh2F6EwVHRsDNuSYuDYXzMy/LYfUkFCEHAXfWiTdcSz35?=
 =?us-ascii?Q?dy80t0QK0iRfb1J0ZEEYu28DQ/iiQzxftkJfMliwCFzSlf5PKhxqzaodXyZi?=
 =?us-ascii?Q?3W7Cx6LMw48glJbyQJa335Ck3OJBoe8kQfK3vmzd/S4pd3V1Z/iA+ae9DQf1?=
 =?us-ascii?Q?2gyUcsmfAeRABFlYua9D802sY0JtMdF57R4+uj8QJvM6LCF+PHBPXOlJ7HNu?=
 =?us-ascii?Q?vJtpB/Nx7LV8JY8zVa/uvtxQJI2Sa5C+2O9ofyAzDopiQndYS87p6Kqs+KaW?=
 =?us-ascii?Q?+eIbRGuqX1HfrjKDrFTwD0+U4o+B076rqrSYHv+iBCCBdY4X6vOkRqjAShMP?=
 =?us-ascii?Q?lw0EOur68xjpSDHo+GBrzPIElzwJKMD3VOtnY4TxhN0PCCZE21pE6vZWkxJR?=
 =?us-ascii?Q?d0kLWZOx2PLpCm+jKpoKYZkdWjpw5muRdCycvj6bjDcLF1wQO1EtBf947sQI?=
 =?us-ascii?Q?kUCX6ANqiaKz4gVzBlwGqcRg1TYOGl/tCQzgWVpUOt5VvHJoClwwFsgfOtub?=
 =?us-ascii?Q?/iusd4wGPSne+XjH00fWvtmJ8FMLrSnyLzrl5ZxWgxqNQiueES5fwEppqo0X?=
 =?us-ascii?Q?3YQJMHpTdxCmqNnmlY9QDt7Cy4DWZ8Vl9Fva1W8NjCzzj6an2qqF+EAMZkjI?=
 =?us-ascii?Q?Uq6A2Rwmuzq0tGmiRIy4BJLtwBo7y1K3kakccclRyiNideQziyjWSH6is/yv?=
 =?us-ascii?Q?5JY3ds6lh5NRlGyuFlowed+692zSluep+fUi4vk1YnrCHaN9O49v3EId7sgc?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a16721cd-61b4-4b58-d2b7-08db0362529c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 08:08:24.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qc637sxGKFTY36fSXalgX47u02NvFVP3xtiSdzq4eXU01JKvOLVIK/9tjvzFVcarUTrEheAOOuPpCj+acdunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4531
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--WZ9JtNOrUroHJib6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed BUG:KASAN:use-after-free_in_dcache_dir_open_wrapper due to commit (built with gcc-11):

commit: be995c36ba2232edcd4fa64e4581b9a6763c75e6 ("[PATCH 8/8] eventfs: moving tracing/events to eventfs")
url: https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 2241ab53cbb5cdb08a6b2d4688feb13971058f65
patch link: https://lore.kernel.org/all/1674407228-49109-8-git-send-email-akaher@vmware.com/
patch subject: [PATCH 8/8] eventfs: moving tracing/events to eventfs

in testcase: kernel-selftests
version: kernel-selftests-x86_64-d4cf28ee-1_20230110
with following parameters:

	group: ftrace

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (Skylake) with 16G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202301311549.6afc9591-oliver.sang@intel.com


[ 218.042115][ T2485] BUG: KASAN: use-after-free in dcache_dir_open_wrapper (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:304) 
[  218.049977][ T2485] Read of size 8 at addr ffff8881bf289000 by task ftracetest/2485
[  218.057664][ T2485]
[  218.059869][ T2485] CPU: 1 PID: 2485 Comm: ftracetest Not tainted 6.2.0-rc5-00008-gbe995c36ba22 #5
[  218.068863][ T2485] Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
[  218.078463][ T2485] Call Trace:
[  218.081623][ T2485]  <TASK>
[ 218.084431][ T2485] dump_stack_lvl (kbuild/src/x86_64-3/lib/dump_stack.c:107 (discriminator 4)) 
[ 218.088814][ T2485] print_address_description+0x87/0x2a1 
[ 218.095300][ T2485] print_report (kbuild/src/x86_64-3/mm/kasan/report.c:418) 
[ 218.099696][ T2485] ? kasan_addr_to_slab (kbuild/src/x86_64-3/mm/kasan/common.c:35) 
[ 218.104511][ T2485] ? dcache_dir_open_wrapper (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:304) 
[ 218.110027][ T2485] kasan_report (kbuild/src/x86_64-3/mm/kasan/report.c:184 kbuild/src/x86_64-3/mm/kasan/report.c:519) 
[ 218.114322][ T2485] ? dcache_dir_open_wrapper (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:304) 
[ 218.119838][ T2485] dcache_dir_open_wrapper (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:304) 
[ 218.125177][ T2485] ? fsnotify_perm+0x13b/0x4a0 
[ 218.130426][ T2485] do_dentry_open (kbuild/src/x86_64-3/fs/open.c:883) 
[ 218.135077][ T2485] ? eventfs_create_dir (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:292) 
[ 218.140157][ T2485] ? may_open (kbuild/src/x86_64-3/fs/namei.c:3186) 
[ 218.144283][ T2485] do_open (kbuild/src/x86_64-3/fs/namei.c:3558) 
[ 218.148249][ T2485] path_openat (kbuild/src/x86_64-3/fs/namei.c:3714) 
[ 218.152545][ T2485] ? do_open (kbuild/src/x86_64-3/fs/namei.c:3696) 
[ 218.156667][ T2485] ? __lock_acquire (kbuild/src/x86_64-3/kernel/locking/lockdep.c:5055) 
[ 218.161484][ T2485] do_filp_open (kbuild/src/x86_64-3/fs/namei.c:3741) 
[ 218.165865][ T2485] ? may_open_dev (kbuild/src/x86_64-3/fs/namei.c:3735) 
[ 218.170267][ T2485] ? alloc_fd (kbuild/src/x86_64-3/fs/file.c:555 (discriminator 10)) 
[ 218.174478][ T2485] ? do_raw_spin_lock (kbuild/src/x86_64-3/arch/x86/include/asm/atomic.h:202 kbuild/src/x86_64-3/include/linux/atomic/atomic-instrumented.h:543 kbuild/src/x86_64-3/include/asm-generic/qspinlock.h:111 kbuild/src/x86_64-3/kernel/locking/spinlock_debug.c:115) 
[ 218.179379][ T2485] ? lock_is_held_type (kbuild/src/x86_64-3/kernel/locking/lockdep.c:5409 kbuild/src/x86_64-3/kernel/locking/lockdep.c:5711) 
[ 218.184298][ T2485] ? alloc_fd (kbuild/src/x86_64-3/fs/file.c:555 (discriminator 10)) 
[ 218.188517][ T2485] ? _raw_spin_unlock (kbuild/src/x86_64-3/arch/x86/include/asm/preempt.h:85 kbuild/src/x86_64-3/include/linux/spinlock_api_smp.h:143 kbuild/src/x86_64-3/kernel/locking/spinlock.c:186) 
[ 218.193265][ T2485] ? alloc_fd (kbuild/src/x86_64-3/fs/file.c:555 (discriminator 10)) 
[ 218.197478][ T2485] ? getname_flags (kbuild/src/x86_64-3/fs/namei.c:205) 
[ 218.202642][ T2485] do_sys_openat2 (kbuild/src/x86_64-3/fs/open.c:1310) 
[ 218.207197][ T2485] ? lock_is_held_type (kbuild/src/x86_64-3/kernel/locking/lockdep.c:5409 kbuild/src/x86_64-3/kernel/locking/lockdep.c:5711) 
[ 218.212093][ T2485] ? build_open_flags (kbuild/src/x86_64-3/fs/open.c:1296) 
[ 218.216995][ T2485] ? __might_fault (kbuild/src/x86_64-3/mm/memory.c:5647 kbuild/src/x86_64-3/mm/memory.c:5640) 
[ 218.221550][ T2485] ? lock_release (kbuild/src/x86_64-3/kernel/locking/lockdep.c:466 kbuild/src/x86_64-3/kernel/locking/lockdep.c:5690) 
[ 218.226011][ T2485] ? rseq_ip_fixup (kbuild/src/x86_64-3/kernel/rseq.c:228 kbuild/src/x86_64-3/kernel/rseq.c:262) 
[ 218.230651][ T2485] __x64_sys_openat (kbuild/src/x86_64-3/fs/open.c:1337) 
[ 218.235382][ T2485] ? __x64_sys_open (kbuild/src/x86_64-3/fs/open.c:1337) 
[ 218.240110][ T2485] ? lockdep_hardirqs_on_prepare (kbuild/src/x86_64-3/kernel/locking/lockdep.c:4528) 
[ 218.246579][ T2485] ? syscall_enter_from_user_mode (kbuild/src/x86_64-3/arch/x86/include/asm/irqflags.h:45 kbuild/src/x86_64-3/arch/x86/include/asm/irqflags.h:80 kbuild/src/x86_64-3/kernel/entry/common.c:111) 
[ 218.252351][ T2485] ? trace_hardirqs_on (kbuild/src/x86_64-3/kernel/trace/trace_preemptirq.c:50 (discriminator 22)) 
[ 218.257273][ T2485] do_syscall_64 (kbuild/src/x86_64-3/arch/x86/entry/common.c:50 kbuild/src/x86_64-3/arch/x86/entry/common.c:80) 
[ 218.261566][ T2485] ? syscall_exit_to_user_mode (kbuild/src/x86_64-3/kernel/entry/common.c:131 kbuild/src/x86_64-3/kernel/entry/common.c:298) 
[ 218.267072][ T2485] ? lockdep_hardirqs_on_prepare (kbuild/src/x86_64-3/kernel/locking/lockdep.c:4528) 
[ 218.273544][ T2485] ? do_syscall_64 (kbuild/src/x86_64-3/arch/x86/entry/common.c:87) 
[ 218.278012][ T2485] ? do_syscall_64 (kbuild/src/x86_64-3/arch/x86/entry/common.c:87) 
[ 218.282475][ T2485] ? do_user_addr_fault (kbuild/src/x86_64-3/arch/x86/mm/fault.c:1457) 
[ 218.287556][ T2485] ? irqentry_exit_to_user_mode (kbuild/src/x86_64-3/kernel/entry/common.c:131 kbuild/src/x86_64-3/kernel/entry/common.c:311) 
[ 218.293069][ T2485] ? lockdep_hardirqs_on_prepare (kbuild/src/x86_64-3/kernel/locking/lockdep.c:4528) 
[ 218.299541][ T2485] entry_SYSCALL_64_after_hwframe (kbuild/src/x86_64-3/arch/x86/entry/entry_64.S:120) 
[  218.305327][ T2485] RIP: 0033:0x7f25686e8e41
[ 218.309637][ T2485] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
All code
========
   0:	44 24 18             	rex.R and $0x18,%al
   3:	31 c0                	xor    %eax,%eax
   5:	41 83 e2 40          	and    $0x40,%r10d
   9:	75 3e                	jne    0x49
   b:	89 f0                	mov    %esi,%eax
   d:	25 00 00 41 00       	and    $0x410000,%eax
  12:	3d 00 00 41 00       	cmp    $0x410000,%eax
  17:	74 30                	je     0x49
  19:	89 f2                	mov    %esi,%edx
  1b:	b8 01 01 00 00       	mov    $0x101,%eax
  20:	48 89 fe             	mov    %rdi,%rsi
  23:	bf 9c ff ff ff       	mov    $0xffffff9c,%edi
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 3f                	ja     0x71
  32:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  37:	64 48 2b 14 25 28 00 	sub    %fs:0x28,%rdx
  3e:	00 00 

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 3f                	ja     0x47
   8:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
   d:	64 48 2b 14 25 28 00 	sub    %fs:0x28,%rdx
  14:	00 00 
[  218.329163][ T2485] RSP: 002b:00007ffe4be3f710 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[  218.337457][ T2485] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25686e8e41
[  218.345319][ T2485] RDX: 0000000000090800 RSI: 0000558c50eafef0 RDI: 00000000ffffff9c
[  218.353183][ T2485] RBP: 00007ffe4be3f8a0 R08: 0000000000000000 R09: 0000000000000000
[  218.361045][ T2485] R10: 0000000000000000 R11: 0000000000000287 R12: 0000558c50eae789
[  218.368906][ T2485] R13: 0000558c50eae788 R14: 0000558c50eca760 R15: 0000000000000800
[  218.376772][ T2485]  </TASK>
[  218.379669][ T2485]
[  218.381867][ T2485] Allocated by task 2337:
[ 218.386070][ T2485] kasan_save_stack (kbuild/src/x86_64-3/mm/kasan/common.c:46) 
[ 218.390626][ T2485] kasan_set_track (kbuild/src/x86_64-3/mm/kasan/common.c:52) 
[ 218.395089][ T2485] __kasan_kmalloc (kbuild/src/x86_64-3/mm/kasan/common.c:381) 
[ 218.399557][ T2485] eventfs_add_subsystem_dir (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:417) 
[ 218.404985][ T2485] event_subsystem_dir (kbuild/src/x86_64-3/kernel/trace/trace_events.c:2320) 
[ 218.409970][ T2485] event_create_dir (kbuild/src/x86_64-3/kernel/trace/trace_events.c:2414) 
[ 218.414608][ T2485] trace_add_event_call (kbuild/src/x86_64-3/kernel/trace/trace_events.c:3597 kbuild/src/x86_64-3/kernel/trace/trace_events.c:2910) 
[ 218.419593][ T2485] trace_probe_register_event_call (kbuild/src/x86_64-3/kernel/trace/trace_probe.c:1128) 
[ 218.425628][ T2485] register_trace_kprobe (kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:1736 kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:646) 
[ 218.430793][ T2485] __trace_kprobe_create (kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:882) 
[ 218.435950][ T2485] trace_probe_create (kbuild/src/x86_64-3/kernel/trace/trace_probe.c:1234) 
[ 218.440680][ T2485] create_or_delete_trace_kprobe (kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:918) 
[ 218.446368][ T2485] trace_parse_run_command (kbuild/src/x86_64-3/kernel/trace/trace.c:10133) 
[ 218.451707][ T2485] vfs_write (kbuild/src/x86_64-3/fs/read_write.c:582) 
[ 218.455831][ T2485] ksys_write (kbuild/src/x86_64-3/fs/read_write.c:637) 
[ 218.459952][ T2485] do_syscall_64 (kbuild/src/x86_64-3/arch/x86/entry/common.c:50 kbuild/src/x86_64-3/arch/x86/entry/common.c:80) 
[ 218.464260][ T2485] entry_SYSCALL_64_after_hwframe (kbuild/src/x86_64-3/arch/x86/entry/entry_64.S:120) 
[  218.470040][ T2485]
[  218.472258][ T2485] Freed by task 2337:
[ 218.476112][ T2485] kasan_save_stack (kbuild/src/x86_64-3/mm/kasan/common.c:46) 
[ 218.480663][ T2485] kasan_set_track (kbuild/src/x86_64-3/mm/kasan/common.c:52) 
[ 218.485133][ T2485] kasan_save_free_info (kbuild/src/x86_64-3/mm/kasan/generic.c:520) 
[ 218.490040][ T2485] __kasan_slab_free (kbuild/src/x86_64-3/mm/kasan/common.c:238 kbuild/src/x86_64-3/mm/kasan/common.c:200 kbuild/src/x86_64-3/mm/kasan/common.c:244) 
[ 218.494857][ T2485] slab_free_freelist_hook (kbuild/src/x86_64-3/mm/slub.c:1807) 
[ 218.500110][ T2485] __kmem_cache_free (kbuild/src/x86_64-3/mm/slub.c:3787 kbuild/src/x86_64-3/mm/slub.c:3800) 
[ 218.504928][ T2485] eventfs_remove (kbuild/src/x86_64-3/fs/tracefs/event_inode.c:618) 
[ 218.509396][ T2485] remove_event_file_dir (kbuild/src/x86_64-3/include/linux/list.h:134 kbuild/src/x86_64-3/include/linux/list.h:148 kbuild/src/x86_64-3/kernel/trace/trace_events.c:978 kbuild/src/x86_64-3/kernel/trace/trace_events.c:1001) 
[ 218.514553][ T2485] event_remove (kbuild/src/x86_64-3/kernel/trace/trace_events.c:2481 kbuild/src/x86_64-3/kernel/trace/trace_events.c:2520) 
[ 218.518928][ T2485] trace_remove_event_call (kbuild/src/x86_64-3/kernel/trace/trace_events.c:2924 kbuild/src/x86_64-3/kernel/trace/trace_events.c:2960 kbuild/src/x86_64-3/kernel/trace/trace_events.c:2980) 
[ 218.524270][ T2485] trace_kprobe_release (kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:547 kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:1091) 
[ 218.529347][ T2485] dyn_events_release_all (kbuild/src/x86_64-3/kernel/trace/trace_dynevent.c:213) 
[ 218.534596][ T2485] probes_open (kbuild/src/x86_64-3/kernel/trace/trace_kprobe.c:1151) 
[ 218.538717][ T2485] do_dentry_open (kbuild/src/x86_64-3/fs/open.c:883) 
[ 218.543349][ T2485] do_open (kbuild/src/x86_64-3/fs/namei.c:3558) 
[ 218.547309][ T2485] path_openat (kbuild/src/x86_64-3/fs/namei.c:3714) 
[ 218.551612][ T2485] do_filp_open (kbuild/src/x86_64-3/fs/namei.c:3741) 
[ 218.555993][ T2485] do_sys_openat2 (kbuild/src/x86_64-3/fs/open.c:1310) 
[ 218.560548][ T2485] __x64_sys_openat (kbuild/src/x86_64-3/fs/open.c:1337) 
[ 218.565284][ T2485] do_syscall_64 (kbuild/src/x86_64-3/arch/x86/entry/common.c:50 kbuild/src/x86_64-3/arch/x86/entry/common.c:80) 
[ 218.569573][ T2485] entry_SYSCALL_64_after_hwframe (kbuild/src/x86_64-3/arch/x86/entry/entry_64.S:120) 
[  218.575340][ T2485]
[  218.577545][ T2485] The buggy address belongs to the object at ffff8881bf289000
[  218.577545][ T2485]  which belongs to the cache kmalloc-16 of size 16
[  218.591321][ T2485] The buggy address is located 0 bytes inside of
[  218.591321][ T2485]  16-byte region [ffff8881bf289000, ffff8881bf289010)
[  218.604229][ T2485]
[  218.606431][ T2485] The buggy address belongs to the physical page:
[  218.612722][ T2485] page:0000000007538459 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bf289
[  218.622847][ T2485] flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
[  218.630534][ T2485] raw: 0017ffffc0000200 ffff8881000423c0 dead000000000122 0000000000000000
[  218.639008][ T2485] raw: 0000000000000000 0000000000800080 00000001ffffffff 0000000000000000
[  218.647478][ T2485] page dumped because: kasan: bad access detected
[  218.653773][ T2485]
[  218.655978][ T2485] Memory state around the buggy address:
[  218.661485][ T2485]  ffff8881bf288f00: 00 00 00 fc fc 00 00 00 fc fc 00 00 00 fc fc 00
[  218.669446][ T2485]  ffff8881bf288f80: 00 00 fc fc 00 00 00 fc fc 00 00 00 fc fc fc fc
[  218.677389][ T2485] >ffff8881bf289000: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
[  218.685333][ T2485]                    ^
[  218.689278][ T2485]  ffff8881bf289080: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
[  218.697237][ T2485]  ffff8881bf289100: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests



--WZ9JtNOrUroHJib6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.2.0-rc5-00008-gbe995c36ba22"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.2.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-8) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23990
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23990
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
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
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
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
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
# CONFIG_RCU_LAZY is not set
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
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC11_NO_ARRAY_BOUNDS=y
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_SELFTEST is not set
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
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
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
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
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
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
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_HANDOVER_PROTOCOL=y
CONFIG_EFI_MIXED=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
# CONFIG_SLS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
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
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
# CONFIG_ACPI_FFH is not set
CONFIG_PMIC_OPREGION=y
CONFIG_ACPI_PRMT=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
CONFIG_X86_ACPI_CPUFREQ=m
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
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
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_DIRTY_RING_TSO=y
CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=m
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
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
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
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
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
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
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
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
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_ZPOOL=y
CONFIG_SWAP=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_DEFAULT_ON is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
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
# CONFIG_SLOB_DEPRECATED is not set
# CONFIG_SLUB_TINY is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
CONFIG_USERFAULTFD=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_PTE_MARKER_UFFD_WP=y
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
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
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
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
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_DXE_MEM_ATTRIBUTES=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
# CONFIG_EFI_DISABLE_RUNTIME is not set
# CONFIG_EFI_COCO_SECRET is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
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
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_AHCI_DWC is not set
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
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
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
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
# CONFIG_IXGBE_IPSEC is not set
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
# CONFIG_VCAP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_MSE102X is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

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
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_PURELIFI=y
# CONFIG_PLFXLC is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_SILABS=y
# CONFIG_WFX is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
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
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LEGACY_TIOCSTI=y
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

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
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_CY8C95X0 is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
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
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_LATCH is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775_CORE=m
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
# CONFIG_SENSORS_OCC_P8_I2C is not set
# CONFIG_SENSORS_OXP is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
# CONFIG_SENSORS_LT7182S is not set
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
# CONFIG_SENSORS_TPS546D24 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE152 is not set
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ADVANTECH_EC_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_SMPRO is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_SY7636A is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
# CONFIG_BPF_LIRC_MODE2 is not set
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DISPLAY_HDCP_HELPER=y
CONFIG_DRM_DISPLAY_HDMI_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_PRIVACY_SCREEN=y

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
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
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
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_DRM_ACCEL is not set
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_MEGAWORLD_FF is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
# CONFIG_HID_TOPRE is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
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
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
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
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set

#
# USB dual-mode controller drivers
#
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_UCSI_STM32G0 is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_FSA4480 is not set
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_CONTAINER=y
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_VME_BUS is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
# CONFIG_NVSW_SN2201 is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_IFS is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# CONFIG_CACHEFILES_ONDEMAND is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFS_V4_2_READ_PLUS=y
CONFIG_NFSD=m
# CONFIG_NFSD_V2 is not set
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
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
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_ANUBIS=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_SM4_GENERIC=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=m
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
# CONFIG_CRYPTO_POLY1305 is not set
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3_GENERIC is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_XXHASH=m
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
# end of Accelerated Cryptographic Algorithms for CPU (x86)

CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
# CONFIG_FIPS_SIGNATURE_SELFTEST is not set

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
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
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
# CONFIG_FORCE_NR_CPUS is not set
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_LEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
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
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
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
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
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
# CONFIG_LOCK_STAT is not set
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
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_TEST_DYNAMIC_DEBUG is not set
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--WZ9JtNOrUroHJib6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='2G'
	export need_cpu=2
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='vip'
	export testbox='lkp-skl-d06'
	export tbox_group='lkp-skl-d06'
	export submit_id='63d8820a5c68a71ab4b00fd9'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml'
	export id='3d5dd32faced669dadd54a7201febe3df02d8165'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=4
	export memory='16G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1'
	export brand='Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz'
	export commit='be995c36ba2232edcd4fa64e4581b9a6763c75e6'
	export need_kconfig_hw='{"PTP_1588_CLOCK"=>"y"}
{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xf0'
	export bisect_dmesg=true
	export need_kconfig=\{\"FTRACE\"\=\>\"y\"\}'
'\{\"KPROBES\"\=\>\"y\"\}'
'\{\"FUNCTION_PROFILER\"\=\>\"y\"\}'
'\{\"TRACER_SNAPSHOT\"\=\>\"y\"\}'
'\{\"STACK_TRACER\"\=\>\"y\"\}'
'\{\"HIST_TRIGGERS\"\=\>\"y\"\}'
'\{\"SCHED_TRACER\"\=\>\"y\"\}'
'\{\"IRQSOFF_TRACER\"\=\>\"y\"\}'
'\{\"PREEMPTIRQ_DELAY_TEST\"\=\>\"m\"\}'
'\{\"MODULES\"\=\>\"y\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"SAMPLES\"\=\>\"y\"\}'
'\{\"SAMPLE_FTRACE_DIRECT\"\=\>\"m\"\}'
'\{\"SAMPLE_TRACE_PRINTK\"\=\>\"m\"\}'
'\{\"KALLSYMS_ALL\"\=\>\"y\"\}
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export enqueue_time='2023-01-31 10:50:50 +0800'
	export _id='63d882205c68a71ab4b00fdb'
	export _rt='/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='f52288aef9267161e6b4a3da559f1211ddceb673'
	export base_commit='2241ab53cbb5cdb08a6b2d4688feb13971058f65'
	export branch='linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956'
	export result_root='/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22
branch=linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6
kvm-intel.unrestricted_guest=0
initcall_debug
nmi_watchdog=0
max_uptime=1200
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220804.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=6
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.BUG:KASAN:use-after-free_in_dcache_dir_open_wrapper'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22'
	export dequeue_time='2023-01-31 11:09:11 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.cgz'

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

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='ftrace' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='ftrace' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--WZ9JtNOrUroHJib6
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
/AK28BI3vjhvscRn+wIAAAAABFla

--WZ9JtNOrUroHJib6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

Decompressing Linux... Parsing ELF... done.
Booting the kernel.
Linux version 6.2.0-rc5-00008-gbe995c36ba22 (kbuild@3c9be8a7f913) (gcc-11 (Debian 11.3.0-8) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39.90.20221231) #5 SMP Mon Jan 23 03:06:03 CST 2023
Command line: ip=::::lkp-skl-d06::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22 branch=linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956 job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6 kvm-intel.unrestricted_guest=0 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdo
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000400-0x0000000000091bff] usable
BIOS-e820: [mem 0x0000000000091c00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000b30fafff] usable
BIOS-e820: [mem 0x00000000b30fb000-0x00000000b3c7efff] reserved
BIOS-e820: [mem 0x00000000b3c7f000-0x00000000b3e7efff] ACPI NVS
BIOS-e820: [mem 0x00000000b3e7f000-0x00000000b3efefff] ACPI data
BIOS-e820: [mem 0x00000000b3eff000-0x00000000b3efffff] usable
BIOS-e820: [mem 0x00000000b3f00000-0x00000000be7fffff] reserved
BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
BIOS-e820: [mem 0x00000000fed10000-0x00000000fed19fff] reserved
BIOS-e820: [mem 0x00000000fed84000-0x00000000fed84fff] reserved
BIOS-e820: [mem 0x00000000fedb0000-0x00000000fedbffff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043f7fffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.7 present.
DMI: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
tsc: Detected 3300.000 MHz processor
tsc: Detected 3299.994 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x43f800 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xb3f00 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
Scan for SMP in [mem 0x00091c00-0x00091fff]
Using GB pages for direct mapping
RAMDISK: [mem 0x549d4000-0x7fff7fff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000FBE30 000024 (v02 HPQOEM)
ACPI: XSDT 0x00000000B3EFD0E8 0000AC (v01 HPQOEM SLIC-WKS 00000000      01000013)
ACPI: FACP 0x00000000B3EF1000 0000F4 (v05 HPQOEM SLIC-WKS 00000000 HP   00000001)
ACPI: DSDT 0x00000000B3ECD000 0209E1 (v02 HPQOEM 8183     00000000 INTL 20121018)
ACPI: FACS 0x00000000B3E5A000 000040
ACPI: SSDT 0x00000000B3EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
ACPI: TCPA 0x00000000B3EFB000 000032 (v02 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EFA000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
ACPI: UEFI 0x00000000B3E6A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: SSDT 0x00000000B3EF4000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
ACPI: SSDT 0x00000000B3EF3000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
ACPI: WSMT 0x00000000B3EF2000 000028 (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: HPET 0x00000000B3EF0000 000038 (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: APIC 0x00000000B3EEF000 0000BC (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: MCFG 0x00000000B3EEE000 00003C (v01 HPQOEM 8183     00000001 HP   00000001)
ACPI: SSDT 0x00000000B3ECC000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECB000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
ACPI: SSDT 0x00000000B3ECA000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
ACPI: ASF! 0x00000000B3EC9000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
ACPI: FPDT 0x00000000B3EC8000 000044 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: BGRT 0x00000000B3EC7000 000038 (v01 HPQOEM EDK2     00000002      01000013)
ACPI: Reserving FACP table memory at [mem 0xb3ef1000-0xb3ef10f3]
ACPI: Reserving DSDT table memory at [mem 0xb3ecd000-0xb3eed9e0]
ACPI: Reserving FACS table memory at [mem 0xb3e5a000-0xb3e5a03f]
ACPI: Reserving SSDT table memory at [mem 0xb3efc000-0xb3efc107]
ACPI: Reserving TCPA table memory at [mem 0xb3efb000-0xb3efb031]
ACPI: Reserving SSDT table memory at [mem 0xb3efa000-0xb3efa3b7]
ACPI: Reserving UEFI table memory at [mem 0xb3e6a000-0xb3e6a041]
ACPI: Reserving SSDT table memory at [mem 0xb3ef4000-0xb3ef91f9]
ACPI: Reserving SSDT table memory at [mem 0xb3ef3000-0xb3ef35b0]
ACPI: Reserving WSMT table memory at [mem 0xb3ef2000-0xb3ef2027]
ACPI: Reserving HPET table memory at [mem 0xb3ef0000-0xb3ef0037]
ACPI: Reserving APIC table memory at [mem 0xb3eef000-0xb3eef0bb]
ACPI: Reserving MCFG table memory at [mem 0xb3eee000-0xb3eee03b]
ACPI: Reserving SSDT table memory at [mem 0xb3ecc000-0xb3ecc199]
ACPI: Reserving SSDT table memory at [mem 0xb3ecb000-0xb3ecb728]
ACPI: Reserving SSDT table memory at [mem 0xb3eca000-0xb3ecae72]
ACPI: Reserving ASF! table memory at [mem 0xb3ec9000-0xb3ec90a4]
ACPI: Reserving FPDT table memory at [mem 0xb3ec8000-0xb3ec8043]
ACPI: Reserving BGRT table memory at [mem 0xb3ec7000-0xb3ec7037]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x000000043f7fffff]
NODE_DATA(0) allocated [mem 0x43f7d3000-0x43f7fdfff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043f7fffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x0000000000090fff]
node   0: [mem 0x0000000000100000-0x00000000b30fafff]
node   0: [mem 0x00000000b3eff000-0x00000000b3efffff]
node   0: [mem 0x0000000100000000-0x000000043f7fffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043f7fffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 111 pages in unavailable ranges
On node 0, zone DMA32: 3588 pages in unavailable ranges
On node 0, zone Normal: 16640 pages in unavailable ranges
On node 0, zone Normal: 2048 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xb6800000-0xbe7fffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 4 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x00091000-0x00091fff]
PM: hibernation: Registered nosave memory: [mem 0x00092000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0xb30fb000-0xb3c7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3c7f000-0xb3e7efff]
PM: hibernation: Registered nosave memory: [mem 0xb3e7f000-0xb3efefff]
PM: hibernation: Registered nosave memory: [mem 0xb3f00000-0xbe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xbe800000-0xdfffffff]
PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xefffffff]
PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xfcffffff]
PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xfe7fffff]
PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed0ffff]
PM: hibernation: Registered nosave memory: [mem 0xfed10000-0xfed19fff]
PM: hibernation: Registered nosave memory: [mem 0xfed1a000-0xfed83fff]
PM: hibernation: Registered nosave memory: [mem 0xfed84000-0xfed84fff]
PM: hibernation: Registered nosave memory: [mem 0xfed85000-0xfedaffff]
PM: hibernation: Registered nosave memory: [mem 0xfedb0000-0xfedbffff]
PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xff6fffff]
PM: hibernation: Registered nosave memory: [mem 0xff700000-0xffffffff]
[mem 0xbe800000-0xdfffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
percpu: Embedded 70 pages/cpu s247584 r8192 d30944 u524288
pcpu-alloc: s247584 r8192 d30944 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 4074328
Policy zone: Normal
Kernel command line: ip=::::lkp-skl-d06::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22 branch=linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956 job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6 kvm-intel.unrestricted_guest=0 initcall_debug nmi_watchdog=0 max_uptime=1200 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22 branch=linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956 job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6 max_uptime=1200 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
random: crng init done
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:off
stackdepot hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
software IO TLB: area num 4.
Memory: 2192956K/16556592K available (43008K kernel code, 14941K rwdata, 9432K rodata, 3080K init, 15112K bss, 3247892K reserved, 0K cma-reserved)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 48503 entries in 190 pages
ftrace: allocated 190 pages with 6 groups
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
calling  con_init+0x0/0x5a2 @ 0
Console: colour VGA+ 80x25
printk: console [tty0] enabled
initcall con_init+0x0/0x5a2 returned 0 after 0 usecs
calling  hvc_console_init+0x0/0x18 @ 0
initcall hvc_console_init+0x0/0x18 returned 0 after 0 usecs
calling  univ8250_console_init+0x0/0x2b @ 0
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
initcall univ8250_console_init+0x0/0x2b returned 0 after 0 usecs
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6365 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20221020
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
[t connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2f9146cb80a, max_idle_ns: 440795296911 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6599.98 BogoMIPS (lpj=3299994)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability,landlock,yama,integrity
landlock: Up and running.
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: IBRS
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
RETBleed: Mitigation: IBRS
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
MDS: Mitigation: Clear CPU buffers
MMIO Stale Data: Mitigation: Clear CPU buffers
SRBDS: Mitigation: Microcode
Freeing SMP alternatives memory: 40K
smpboot: CPU0: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 2 and lim to 1.
cblist_init_generic: Setting shift to 2 and lim to 1.
Running RCU-tasks wait API self tests
calling  init_hw_perf_events+0x0/0x595 @ 1
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      8
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             00000007000000ff
Callback from call_rcu_tasks_trace() invoked.
initcall init_hw_perf_events+0x0/0x595 returned 0 after 9000 usecs
calling  do_init_real_mode+0x0/0x12 @ 1
initcall do_init_real_mode+0x0/0x12 returned 0 after 0 usecs
calling  trace_init_perf_perm_irq_work_exit+0x0/0x17 @ 1
initcall trace_init_perf_perm_irq_work_exit+0x0/0x17 returned 0 after 0 usecs
calling  bp_init_aperfmperf+0x0/0x5e @ 1
Estimated ratio of average max frequency by base frequency (times 1024): 1055
initcall bp_init_aperfmperf+0x0/0x5e returned 0 after 1000 usecs
calling  register_nmi_cpu_backtrace_handler+0x0/0x1a @ 1
initcall register_nmi_cpu_backtrace_handler+0x0/0x1a returned 0 after 0 usecs
calling  kvm_setup_vsyscall_timeinfo+0x0/0xe1 @ 1
initcall kvm_setup_vsyscall_timeinfo+0x0/0xe1 returned 0 after 0 usecs
calling  spawn_ksoftirqd+0x0/0x3d @ 1
initcall spawn_ksoftirqd+0x0/0x3d returned 0 after 0 usecs
calling  migration_init+0x0/0xd5 @ 1
initcall migration_init+0x0/0xd5 returned 0 after 0 usecs
calling  srcu_bootup_announce+0x0/0x7c @ 1
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
initcall srcu_bootup_announce+0x0/0x7c returned 0 after 2000 usecs
calling  rcu_spawn_gp_kthread+0x0/0x36e @ 1
initcall rcu_spawn_gp_kthread+0x0/0x36e returned 0 after 0 usecs
calling  check_cpu_stall_init+0x0/0x1f @ 1
initcall check_cpu_stall_init+0x0/0x1f returned 0 after 0 usecs
calling  rcu_sysrq_init+0x0/0x26 @ 1
initcall rcu_sysrq_init+0x0/0x26 returned 0 after 0 usecs
calling  trace_init_flags_sys_enter+0x0/0x13 @ 1
initcall trace_init_flags_sys_enter+0x0/0x13 returned 0 after 0 usecs
calling  trace_init_flags_sys_exit+0x0/0x13 @ 1
initcall trace_init_flags_sys_exit+0x0/0x13 returned 0 after 0 usecs
calling  cpu_stop_init+0x0/0x166 @ 1
initcall cpu_stop_init+0x0/0x166 returned 0 after 0 usecs
calling  init_kprobes+0x0/0x25d @ 1
initcall init_kprobes+0x0/0x25d returned 0 after 0 usecs
calling  init_events+0x0/0xc6 @ 1
initcall init_events+0x0/0xc6 returned 0 after 0 usecs
calling  init_trace_printk+0x0/0x10 @ 1
initcall init_trace_printk+0x0/0x10 returned 0 after 0 usecs
calling  event_trace_enable_again+0x0/0x23 @ 1
initcall event_trace_enable_again+0x0/0x23 returned 0 after 0 usecs
calling  irq_work_init_threads+0x0/0x7 @ 1
initcall irq_work_init_threads+0x0/0x7 returned 0 after 0 usecs
calling  static_call_init+0x0/0x93 @ 1
initcall static_call_init+0x0/0x93 returned 0 after 0 usecs
calling  jump_label_init_module+0x0/0x15 @ 1
initcall jump_label_init_module+0x0/0x15 returned 0 after 0 usecs
calling  init_zero_pfn+0x0/0xbf @ 1
initcall init_zero_pfn+0x0/0xbf returned 0 after 0 usecs
calling  init_fs_inode_sysctls+0x0/0x26 @ 1
initcall init_fs_inode_sysctls+0x0/0x26 returned 0 after 0 usecs
calling  init_fs_locks_sysctls+0x0/0x26 @ 1
initcall init_fs_locks_sysctls+0x0/0x26 returned 0 after 0 usecs
calling  dynamic_debug_init+0x0/0x3bf @ 1
initcall dynamic_debug_init+0x0/0x3bf returned 0 after 1000 usecs
calling  efi_memreserve_root_init+0x0/0x2a @ 1
initcall efi_memreserve_root_init+0x0/0x2a returned 0 after 0 usecs
calling  efi_earlycon_remap_fb+0x0/0xf8 @ 1
initcall efi_earlycon_remap_fb+0x0/0xf8 returned 0 after 0 usecs
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
smp: Brought up 1 node, 4 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 4 processors activated (26399.95 BogoMIPS)
Callback from call_rcu_tasks_rude() invoked.
node 0 deferred pages initialised in 60ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
calling  bpf_jit_charge_init+0x0/0x40 @ 1
initcall bpf_jit_charge_init+0x0/0x40 returned 0 after 0 usecs
calling  ipc_ns_init+0x0/0x11e @ 1
initcall ipc_ns_init+0x0/0x11e returned 0 after 0 usecs
calling  init_mmap_min_addr+0x0/0x1a @ 1
initcall init_mmap_min_addr+0x0/0x1a returned 0 after 0 usecs
calling  pci_realloc_setup_params+0x0/0x49 @ 1
initcall pci_realloc_setup_params+0x0/0x49 returned 0 after 0 usecs
calling  inet_frag_wq_init+0x0/0x46 @ 1
initcall inet_frag_wq_init+0x0/0x46 returned 0 after 0 usecs
calling  e820__register_nvs_regions+0x0/0x150 @ 1
ACPI: PM: Registering ACPI NVS region [mem 0xb3c7f000-0xb3e7efff] (2097152 bytes)
initcall e820__register_nvs_regions+0x0/0x150 returned 0 after 2000 usecs
calling  cpufreq_register_tsc_scaling+0x0/0x7a @ 1
initcall cpufreq_register_tsc_scaling+0x0/0x7a returned 0 after 0 usecs
calling  cache_ap_register+0x0/0x2c @ 1
initcall cache_ap_register+0x0/0x2c returned 0 after 0 usecs
calling  reboot_init+0x0/0xa9 @ 1
initcall reboot_init+0x0/0xa9 returned 0 after 0 usecs
calling  init_lapic_sysfs+0x0/0x4b @ 1
initcall init_lapic_sysfs+0x0/0x4b returned 0 after 0 usecs
calling  alloc_frozen_cpus+0x0/0x25 @ 1
initcall alloc_frozen_cpus+0x0/0x25 returned 0 after 0 usecs
calling  cpu_hotplug_pm_sync_init+0x0/0x18 @ 1
initcall cpu_hotplug_pm_sync_init+0x0/0x18 returned 0 after 0 usecs
calling  wq_sysfs_init+0x0/0x2f @ 1
initcall wq_sysfs_init+0x0/0x2f returned 0 after 0 usecs
calling  ksysfs_init+0x0/0x9d @ 1
initcall ksysfs_init+0x0/0x9d returned 0 after 0 usecs
calling  schedutil_gov_init+0x0/0x15 @ 1
initcall schedutil_gov_init+0x0/0x15 returned 0 after 0 usecs
calling  pm_init+0x0/0xb4 @ 1
initcall pm_init+0x0/0xb4 returned 0 after 0 usecs
calling  pm_disk_init+0x0/0x42 @ 1
initcall pm_disk_init+0x0/0x42 returned 0 after 0 usecs
calling  swsusp_header_init+0x0/0x35 @ 1
initcall swsusp_header_init+0x0/0x35 returned 0 after 0 usecs
calling  rcu_set_runtime_mode+0x0/0x63 @ 1
initcall rcu_set_runtime_mode+0x0/0x63 returned 0 after 0 usecs
calling  init_jiffies_clocksource+0x0/0x1c @ 1
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
initcall init_jiffies_clocksource+0x0/0x1c returned 0 after 1000 usecs
calling  futex_init+0x0/0x1f9 @ 1
futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
initcall futex_init+0x0/0x1f9 returned 0 after 1000 usecs
calling  cgroup_wq_init+0x0/0x2d @ 1
initcall cgroup_wq_init+0x0/0x2d returned 0 after 0 usecs
calling  cgroup1_wq_init+0x0/0x2d @ 1
initcall cgroup1_wq_init+0x0/0x2d returned 0 after 0 usecs
calling  ftrace_mod_cmd_init+0x0/0x10 @ 1
initcall ftrace_mod_cmd_init+0x0/0x10 returned 0 after 0 usecs
calling  init_irqsoff_tracer+0x0/0x13 @ 1
initcall init_irqsoff_tracer+0x0/0x13 returned 0 after 0 usecs
calling  init_wakeup_tracer+0x0/0x31 @ 1
initcall init_wakeup_tracer+0x0/0x31 returned 0 after 0 usecs
calling  init_graph_trace+0x0/0x95 @ 1
initcall init_graph_trace+0x0/0x95 returned 0 after 0 usecs
calling  trace_events_eprobe_init_early+0x0/0x2b @ 1
initcall trace_events_eprobe_init_early+0x0/0x2b returned 0 after 0 usecs
calling  trace_events_synth_init_early+0x0/0x2b @ 1
initcall trace_events_synth_init_early+0x0/0x2b returned 0 after 0 usecs
calling  init_kprobe_trace_early+0x0/0x2a @ 1
initcall init_kprobe_trace_early+0x0/0x2a returned 0 after 0 usecs
calling  kasan_memhotplug_init+0x0/0x13 @ 1
initcall kasan_memhotplug_init+0x0/0x13 returned 0 after 0 usecs
calling  memory_failure_init+0x0/0x273 @ 1
initcall memory_failure_init+0x0/0x273 returned 0 after 0 usecs
calling  fsnotify_init+0x0/0x8b @ 1
initcall fsnotify_init+0x0/0x8b returned 0 after 0 usecs
calling  filelock_init+0x0/0x174 @ 1
initcall filelock_init+0x0/0x174 returned 0 after 0 usecs
calling  init_script_binfmt+0x0/0x1a @ 1
initcall init_script_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  init_elf_binfmt+0x0/0x1a @ 1
initcall init_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  init_compat_elf_binfmt+0x0/0x1a @ 1
initcall init_compat_elf_binfmt+0x0/0x1a returned 0 after 0 usecs
calling  configfs_init+0x0/0xee @ 1
initcall configfs_init+0x0/0xee returned 0 after 0 usecs
calling  debugfs_init+0x0/0xb7 @ 1
initcall debugfs_init+0x0/0xb7 returned 0 after 0 usecs
calling  tracefs_init+0x0/0x9a @ 1
initcall tracefs_init+0x0/0x9a returned 0 after 0 usecs
calling  securityfs_init+0x0/0xbe @ 1
initcall securityfs_init+0x0/0xbe returned 0 after 0 usecs
calling  pinctrl_init+0x0/0xb2 @ 1
pinctrl core: initialized pinctrl subsystem
initcall pinctrl_init+0x0/0xb2 returned 0 after 1000 usecs
calling  gpiolib_dev_init+0x0/0x124 @ 1
initcall gpiolib_dev_init+0x0/0x124 returned 0 after 0 usecs
calling  virtio_init+0x0/0x20 @ 1
initcall virtio_init+0x0/0x20 returned 0 after 0 usecs
calling  iommu_init+0x0/0x55 @ 1
initcall iommu_init+0x0/0x55 returned 0 after 0 usecs
calling  component_debug_init+0x0/0x21 @ 1
initcall component_debug_init+0x0/0x21 returned 0 after 0 usecs
calling  cpufreq_core_init+0x0/0xce @ 1
initcall cpufreq_core_init+0x0/0xce returned 0 after 0 usecs
calling  cpufreq_gov_performance_init+0x0/0x15 @ 1
initcall cpufreq_gov_performance_init+0x0/0x15 returned 0 after 0 usecs
calling  cpufreq_gov_powersave_init+0x0/0x15 @ 1
initcall cpufreq_gov_powersave_init+0x0/0x15 returned 0 after 0 usecs
calling  cpufreq_gov_userspace_init+0x0/0x15 @ 1
initcall cpufreq_gov_userspace_init+0x0/0x15 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 @ 1
initcall CPU_FREQ_GOV_ONDEMAND_init+0x0/0x15 returned 0 after 0 usecs
calling  CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 @ 1
initcall CPU_FREQ_GOV_CONSERVATIVE_init+0x0/0x15 returned 0 after 0 usecs
calling  cpuidle_init+0x0/0x4a @ 1
initcall cpuidle_init+0x0/0x4a returned 0 after 0 usecs
calling  sock_init+0x0/0xa3 @ 1
initcall sock_init+0x0/0xa3 returned 0 after 1000 usecs
calling  net_inuse_init+0x0/0x2d @ 1
initcall net_inuse_init+0x0/0x2d returned 0 after 0 usecs
calling  net_defaults_init+0x0/0x2d @ 1
initcall net_defaults_init+0x0/0x2d returned 0 after 0 usecs
calling  init_default_flow_dissectors+0x0/0x54 @ 1
initcall init_default_flow_dissectors+0x0/0x54 returned 0 after 0 usecs
calling  netpoll_init+0x0/0x18 @ 1
initcall netpoll_init+0x0/0x18 returned 0 after 0 usecs
calling  netlink_proto_init+0x0/0x269 @ 1
NET: Registered PF_NETLINK/PF_ROUTE protocol family
initcall netlink_proto_init+0x0/0x269 returned 0 after 1000 usecs
calling  genl_init+0x0/0x47 @ 1
initcall genl_init+0x0/0x47 returned 0 after 0 usecs
calling  bsp_pm_check_init+0x0/0x18 @ 1
initcall bsp_pm_check_init+0x0/0x18 returned 0 after 0 usecs
calling  irq_sysfs_init+0x0/0xbe @ 1
initcall irq_sysfs_init+0x0/0xbe returned 0 after 1000 usecs
calling  audit_init+0x0/0x18e @ 1
audit: initializing netlink subsys (disabled)
initcall audit_init+0x0/0x18e returned 0 after 1000 usecs
audit: type=2000 audit(1675134523.378:1): state=initialized audit_enabled=0 res=1
calling  release_early_probes+0x0/0x5d @ 1
initcall release_early_probes+0x0/0x5d returned 0 after 0 usecs
calling  bdi_class_init+0x0/0x71 @ 1
initcall bdi_class_init+0x0/0x71 returned 0 after 0 usecs
calling  mm_sysfs_init+0x0/0x53 @ 1
initcall mm_sysfs_init+0x0/0x53 returned 0 after 0 usecs
calling  init_per_zone_wmark_min+0x0/0x2a @ 1
initcall init_per_zone_wmark_min+0x0/0x2a returned 0 after 0 usecs
calling  mpi_init+0x0/0xea @ 1
initcall mpi_init+0x0/0xea returned 0 after 0 usecs
calling  gpiolib_sysfs_init+0x0/0x11d @ 1
initcall gpiolib_sysfs_init+0x0/0x11d returned 0 after 0 usecs
calling  acpi_gpio_setup_params+0x0/0x11a @ 1
initcall acpi_gpio_setup_params+0x0/0x11a returned 0 after 0 usecs
calling  pcibus_class_init+0x0/0x1c @ 1
initcall pcibus_class_init+0x0/0x1c returned 0 after 0 usecs
calling  pci_driver_init+0x0/0x26 @ 1
initcall pci_driver_init+0x0/0x26 returned 0 after 0 usecs
calling  backlight_class_init+0x0/0xf2 @ 1
initcall backlight_class_init+0x0/0xf2 returned 0 after 0 usecs
calling  tty_class_init+0x0/0x5c @ 1
initcall tty_class_init+0x0/0x5c returned 0 after 0 usecs
calling  vtconsole_class_init+0x0/0x1a4 @ 1
initcall vtconsole_class_init+0x0/0x1a4 returned 0 after 0 usecs
calling  iommu_dev_init+0x0/0x1c @ 1
initcall iommu_dev_init+0x0/0x1c returned 0 after 0 usecs
calling  mipi_dsi_bus_init+0x0/0x15 @ 1
initcall mipi_dsi_bus_init+0x0/0x15 returned 0 after 0 usecs
calling  devlink_class_init+0x0/0x4a @ 1
initcall devlink_class_init+0x0/0x4a returned 0 after 0 usecs
calling  software_node_init+0x0/0x55 @ 1
initcall software_node_init+0x0/0x55 returned 0 after 0 usecs
calling  wakeup_sources_debugfs_init+0x0/0x28 @ 1
initcall wakeup_sources_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  wakeup_sources_sysfs_init+0x0/0x31 @ 1
initcall wakeup_sources_sysfs_init+0x0/0x31 returned 0 after 0 usecs
calling  regmap_initcall+0x0/0x11 @ 1
initcall regmap_initcall+0x0/0x11 returned 0 after 0 usecs
calling  spi_init+0x0/0xcb @ 1
initcall spi_init+0x0/0xcb returned 0 after 0 usecs
calling  i2c_init+0x0/0xec @ 1
initcall i2c_init+0x0/0xec returned 0 after 0 usecs
calling  thermal_init+0x0/0x1ae @ 1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
initcall thermal_init+0x0/0x1ae returned 0 after 3000 usecs
calling  init_menu+0x0/0x15 @ 1
cpuidle: using governor menu
initcall init_menu+0x0/0x15 returned 0 after 1000 usecs
calling  pcc_init+0x0/0xcb @ 1
initcall pcc_init+0x0/0xcb returned -19 after 0 usecs
calling  kobject_uevent_init+0x0/0x10 @ 1
initcall kobject_uevent_init+0x0/0x10 returned 0 after 0 usecs
calling  bts_init+0x0/0x134 @ 1
initcall bts_init+0x0/0x134 returned -19 after 0 usecs
calling  pt_init+0x0/0x2c1 @ 1
initcall pt_init+0x0/0x2c1 returned 0 after 0 usecs
calling  boot_params_ksysfs_init+0x0/0x96 @ 1
initcall boot_params_ksysfs_init+0x0/0x96 returned 0 after 0 usecs
calling  sbf_init+0x0/0xd3 @ 1
initcall sbf_init+0x0/0xd3 returned 0 after 0 usecs
calling  arch_kdebugfs_init+0x0/0x4d9 @ 1
initcall arch_kdebugfs_init+0x0/0x4d9 returned 0 after 0 usecs
calling  xfd_update_static_branch+0x0/0x48 @ 1
initcall xfd_update_static_branch+0x0/0x48 returned 0 after 0 usecs
calling  intel_pconfig_init+0x0/0xa9 @ 1
initcall intel_pconfig_init+0x0/0xa9 returned 0 after 0 usecs
calling  mtrr_if_init+0x0/0xaf @ 1
initcall mtrr_if_init+0x0/0xaf returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x36 @ 1
initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
calling  init_s4_sigcheck+0x0/0x90 @ 1
initcall init_s4_sigcheck+0x0/0x90 returned 0 after 0 usecs
calling  ffh_cstate_init+0x0/0x66 @ 1
initcall ffh_cstate_init+0x0/0x66 returned 0 after 0 usecs
calling  kvm_alloc_cpumask+0x0/0x1ca @ 1
initcall kvm_alloc_cpumask+0x0/0x1ca returned 0 after 0 usecs
calling  activate_jump_labels+0x0/0x36 @ 1
initcall activate_jump_labels+0x0/0x36 returned 0 after 0 usecs
calling  gigantic_pages_init+0x0/0x4a @ 1
initcall gigantic_pages_init+0x0/0x4a returned 0 after 0 usecs
calling  uv_rtc_setup_clock+0x0/0x27a @ 1
initcall uv_rtc_setup_clock+0x0/0x27a returned -19 after 0 usecs
calling  kcmp_cookies_init+0x0/0xa6 @ 1
initcall kcmp_cookies_init+0x0/0xa6 returned 0 after 0 usecs
calling  cryptomgr_init+0x0/0x15 @ 1
initcall cryptomgr_init+0x0/0x15 returned 0 after 0 usecs
calling  acpi_pci_init+0x0/0x14d @ 1
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
initcall acpi_pci_init+0x0/0x14d returned 0 after 2000 usecs
calling  dma_channel_table_init+0x0/0x17c @ 1
initcall dma_channel_table_init+0x0/0x17c returned 0 after 0 usecs
calling  dma_bus_init+0x0/0x20f @ 1
initcall dma_bus_init+0x0/0x20f returned 0 after 0 usecs
calling  iommu_dma_init+0x0/0x50 @ 1
initcall iommu_dma_init+0x0/0x50 returned 0 after 0 usecs
calling  dmi_id_init+0x0/0x16c @ 1
initcall dmi_id_init+0x0/0x16c returned 0 after 0 usecs
calling  pci_arch_init+0x0/0x11c @ 1
PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as E820 entry
PCI: Using configuration type 1 for base access
initcall pci_arch_init+0x0/0x11c returned 0 after 20000 usecs
calling  init_vdso+0x0/0x18 @ 1
initcall init_vdso+0x0/0x18 returned 0 after 0 usecs
calling  sysenter_setup+0x0/0x18 @ 1
initcall sysenter_setup+0x0/0x18 returned 0 after 0 usecs
calling  fixup_ht_bug+0x0/0x257 @ 1
initcall fixup_ht_bug+0x0/0x257 returned 0 after 0 usecs
calling  topology_init+0x0/0x9e @ 1
initcall topology_init+0x0/0x9e returned 0 after 0 usecs
calling  intel_epb_init+0x0/0xd8 @ 1
initcall intel_epb_init+0x0/0xd8 returned 0 after 0 usecs
calling  mtrr_init_finialize+0x0/0x6f @ 1
initcall mtrr_init_finialize+0x0/0x6f returned 0 after 0 usecs
calling  uid_cache_init+0x0/0x102 @ 1
initcall uid_cache_init+0x0/0x102 returned 0 after 0 usecs
calling  param_sysfs_init+0x0/0x4f @ 1
initcall param_sysfs_init+0x0/0x4f returned 0 after 0 usecs
calling  user_namespace_sysctl_init+0x0/0x11e @ 1
initcall user_namespace_sysctl_init+0x0/0x11e returned 0 after 0 usecs
calling  proc_schedstat_init+0x0/0x29 @ 1
initcall proc_schedstat_init+0x0/0x29 returned 0 after 0 usecs
calling  pm_sysrq_init+0x0/0x1d @ 1
initcall pm_sysrq_init+0x0/0x1d returned 0 after 0 usecs
calling  create_proc_profile+0x0/0xe0 @ 1
initcall create_proc_profile+0x0/0xe0 returned 0 after 0 usecs
calling  crash_save_vmcoreinfo_init+0x0/0x742 @ 1
initcall crash_save_vmcoreinfo_init+0x0/0x742 returned 0 after 0 usecs
calling  crash_notes_memory_init+0x0/0x3d @ 1
initcall crash_notes_memory_init+0x0/0x3d returned 0 after 0 usecs
calling  cgroup_sysfs_init+0x0/0x42 @ 1
initcall cgroup_sysfs_init+0x0/0x42 returned 0 after 0 usecs
calling  cgroup_namespaces_init+0x0/0xc @ 1
initcall cgroup_namespaces_init+0x0/0xc returned 0 after 0 usecs
calling  user_namespaces_init+0x0/0x31 @ 1
initcall user_namespaces_init+0x0/0x31 returned 0 after 0 usecs
calling  init_optprobes+0x0/0x1d @ 1
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
initcall init_optprobes+0x0/0x1d returned 0 after 1000 usecs
calling  hung_task_init+0x0/0x79 @ 1
initcall hung_task_init+0x0/0x79 returned 0 after 0 usecs
calling  ftrace_check_for_weak_functions+0x0/0x8b @ 1
initcall ftrace_check_for_weak_functions+0x0/0x8b returned 0 after 0 usecs
calling  trace_eval_init+0x0/0xae @ 1
initcall trace_eval_init+0x0/0xae returned 0 after 0 usecs
calling  send_signal_irq_work_init+0x0/0x154 @ 1
initcall send_signal_irq_work_init+0x0/0x154 returned 0 after 0 usecs
calling  dev_map_init+0x0/0x123 @ 1
initcall dev_map_init+0x0/0x123 returned 0 after 0 usecs
calling  cpu_map_init+0x0/0x117 @ 1
initcall cpu_map_init+0x0/0x117 returned 0 after 0 usecs
calling  netns_bpf_init+0x0/0x15 @ 1
initcall netns_bpf_init+0x0/0x15 returned 0 after 0 usecs
calling  oom_init+0x0/0x4e @ 1
initcall oom_init+0x0/0x4e returned 0 after 0 usecs
calling  default_bdi_init+0x0/0x2d @ 1
initcall default_bdi_init+0x0/0x2d returned 0 after 0 usecs
calling  cgwb_init+0x0/0x2d @ 1
initcall cgwb_init+0x0/0x2d returned 0 after 0 usecs
calling  percpu_enable_async+0x0/0x13 @ 1
initcall percpu_enable_async+0x0/0x13 returned 0 after 0 usecs
calling  kcompactd_init+0x0/0x9c @ 1
initcall kcompactd_init+0x0/0x9c returned 0 after 0 usecs
calling  init_user_reserve+0x0/0xa0 @ 1
initcall init_user_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_admin_reserve+0x0/0xa0 @ 1
initcall init_admin_reserve+0x0/0xa0 returned 0 after 0 usecs
calling  init_reserve_notifier+0x0/0x23 @ 1
initcall init_reserve_notifier+0x0/0x23 returned 0 after 0 usecs
calling  swap_init_sysfs+0x0/0x92 @ 1
initcall swap_init_sysfs+0x0/0x92 returned 0 after 0 usecs
calling  swapfile_init+0x0/0x14b @ 1
initcall swapfile_init+0x0/0x14b returned 0 after 0 usecs
calling  hugetlb_init+0x0/0xb07 @ 1
HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
initcall hugetlb_init+0x0/0xb07 returned 0 after 4000 usecs
calling  ksm_init+0x0/0x246 @ 1
initcall ksm_init+0x0/0x246 returned 0 after 0 usecs
calling  memory_tier_init+0x0/0x143 @ 1
initcall memory_tier_init+0x0/0x143 returned 0 after 0 usecs
calling  numa_init_sysfs+0x0/0x92 @ 1
initcall numa_init_sysfs+0x0/0x92 returned 0 after 0 usecs
calling  hugepage_init+0x0/0x1b4 @ 1
initcall hugepage_init+0x0/0x1b4 returned 0 after 0 usecs
calling  mem_cgroup_init+0x0/0x3d0 @ 1
initcall mem_cgroup_init+0x0/0x3d0 returned 0 after 0 usecs
calling  mem_cgroup_swap_init+0x0/0x60 @ 1
initcall mem_cgroup_swap_init+0x0/0x60 returned 0 after 0 usecs
calling  page_idle_init+0x0/0x5d @ 1
initcall page_idle_init+0x0/0x5d returned 0 after 0 usecs
calling  damon_init+0x0/0x49 @ 1
initcall damon_init+0x0/0x49 returned 0 after 0 usecs
calling  damon_va_initcall+0x0/0x15c @ 1
initcall damon_va_initcall+0x0/0x15c returned 0 after 0 usecs
calling  damon_pa_initcall+0x0/0xf7 @ 1
initcall damon_pa_initcall+0x0/0xf7 returned 0 after 0 usecs
calling  seqiv_module_init+0x0/0x15 @ 1
initcall seqiv_module_init+0x0/0x15 returned 0 after 0 usecs
calling  rsa_init+0x0/0x43 @ 1
initcall rsa_init+0x0/0x43 returned 0 after 0 usecs
calling  hmac_module_init+0x0/0x15 @ 1
initcall hmac_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_null_mod_init+0x0/0x71 @ 1
initcall crypto_null_mod_init+0x0/0x71 returned 0 after 0 usecs
calling  md5_mod_init+0x0/0x15 @ 1
initcall md5_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha1_generic_mod_init+0x0/0x15 @ 1
initcall sha1_generic_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  sha256_generic_mod_init+0x0/0x1a @ 1
initcall sha256_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  sha512_generic_mod_init+0x0/0x1a @ 1
initcall sha512_generic_mod_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_ecb_module_init+0x0/0x15 @ 1
initcall crypto_ecb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cbc_module_init+0x0/0x15 @ 1
initcall crypto_cbc_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_cfb_module_init+0x0/0x15 @ 1
initcall crypto_cfb_module_init+0x0/0x15 returned 0 after 0 usecs
calling  crypto_ctr_module_init+0x0/0x1a @ 1
initcall crypto_ctr_module_init+0x0/0x1a returned 0 after 0 usecs
calling  crypto_gcm_module_init+0x0/0x67 @ 1
initcall crypto_gcm_module_init+0x0/0x67 returned 0 after 0 usecs
calling  cryptd_init+0x0/0x21d @ 1
cryptd: max_cpu_qlen set to 1000
initcall cryptd_init+0x0/0x21d returned 0 after 1000 usecs
calling  aes_init+0x0/0x15 @ 1
initcall aes_init+0x0/0x15 returned 0 after 0 usecs
calling  sm4_init+0x0/0x15 @ 1
initcall sm4_init+0x0/0x15 returned 0 after 0 usecs
calling  deflate_mod_init+0x0/0x48 @ 1
initcall deflate_mod_init+0x0/0x48 returned 0 after 0 usecs
calling  crc32c_mod_init+0x0/0x15 @ 1
initcall crc32c_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  crct10dif_mod_init+0x0/0x15 @ 1
initcall crct10dif_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  lzo_mod_init+0x0/0x43 @ 1
initcall lzo_mod_init+0x0/0x43 returned 0 after 0 usecs
calling  lzorle_mod_init+0x0/0x43 @ 1
initcall lzorle_mod_init+0x0/0x43 returned 0 after 0 usecs
calling  drbg_init+0x0/0xe8 @ 1
initcall drbg_init+0x0/0xe8 returned 0 after 0 usecs
calling  ghash_mod_init+0x0/0x15 @ 1
initcall ghash_mod_init+0x0/0x15 returned 0 after 0 usecs
calling  init_bio+0x0/0x115 @ 1
initcall init_bio+0x0/0x115 returned 0 after 0 usecs
calling  blk_ioc_init+0x0/0x2e @ 1
initcall blk_ioc_init+0x0/0x2e returned 0 after 0 usecs
calling  blk_mq_init+0x0/0x17b @ 1
initcall blk_mq_init+0x0/0x17b returned 0 after 0 usecs
calling  genhd_device_init+0x0/0x8c @ 1
initcall genhd_device_init+0x0/0x8c returned 0 after 0 usecs
calling  blkcg_init+0x0/0x2d @ 1
initcall blkcg_init+0x0/0x2d returned 0 after 0 usecs
calling  io_wq_init+0x0/0x3d @ 1
initcall io_wq_init+0x0/0x3d returned 0 after 0 usecs
calling  sg_pool_init+0x0/0x1a9 @ 1
initcall sg_pool_init+0x0/0x1a9 returned 0 after 0 usecs
calling  irq_poll_setup+0x0/0x149 @ 1
initcall irq_poll_setup+0x0/0x149 returned 0 after 0 usecs
calling  gpiolib_debugfs_init+0x0/0x28 @ 1
initcall gpiolib_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  pwm_debugfs_init+0x0/0x28 @ 1
initcall pwm_debugfs_init+0x0/0x28 returned 0 after 0 usecs
calling  pwm_sysfs_init+0x0/0x1c @ 1
initcall pwm_sysfs_init+0x0/0x1c returned 0 after 0 usecs
calling  pci_slot_init+0x0/0x40 @ 1
initcall pci_slot_init+0x0/0x40 returned 0 after 0 usecs
calling  fbmem_init+0x0/0xe5 @ 1
initcall fbmem_init+0x0/0xe5 returned 0 after 0 usecs
calling  scan_for_dmi_ipmi+0x0/0x56 @ 1
initcall scan_for_dmi_ipmi+0x0/0x56 returned 0 after 0 usecs
calling  acpi_init+0x0/0x271 @ 1
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103CC7000 0006C3 (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881032A1800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103CEB000 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888100F66400 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 5 GPEs in block 00 to 7F
ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
ACPI: \_SB_.PCI0.PEG0.PEGP.WRST: New power resource
ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME LTR]
acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: root bus resource [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-fe]
pci 0000:00:00.0: calling  quirk_mmio_always_on+0x0/0x80 @ 1
pci 0000:00:00.0: quirk_mmio_always_on+0x0/0x80 took 0 usecs
pci 0000:00:00.0: [8086:1918] type 00 class 0x060000
pci 0000:00:00.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:00.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:02.0: [8086:191d] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xd0000000-0xd0ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
pci 0000:00:02.0: calling  efifb_fixup_resources+0x0/0x490 @ 1
pci 0000:00:02.0: efifb_fixup_resources+0x0/0x490 took 0 usecs
pci 0000:00:02.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:02.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:02.0: calling  pci_fixup_video+0x0/0x200 @ 1
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:02.0: pci_fixup_video+0x0/0x200 took 976 usecs
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xd1020000-0xd102ffff 64bit]
pci 0000:00:14.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:14.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xd104a000-0xd104afff 64bit]
pci 0000:00:14.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:14.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xd104b000-0xd104bfff 64bit]
pci 0000:00:16.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:16.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:16.3: [8086:a13d] type 00 class 0x070002
pci 0000:00:16.3: reg 0x10: [io  0x3080-0x3087]
pci 0000:00:16.3: reg 0x14: [mem 0xd104f000-0xd104ffff]
pci 0000:00:16.3: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:16.3: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
pci 0000:00:17.0: reg 0x10: [mem 0xd1048000-0xd1049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xd104e000-0xd104e0ff]
pci 0000:00:17.0: reg 0x18: [io  0x3088-0x308f]
pci 0000:00:17.0: reg 0x1c: [io  0x3090-0x3093]
pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]
pci 0000:00:17.0: reg 0x24: [mem 0xd104c000-0xd104c7ff]
pci 0000:00:17.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:17.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1f.0: [8086:a149] type 00 class 0x060100
pci 0000:00:1f.0: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.0: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xd1044000-0xd1047fff]
pci 0000:00:1f.2: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.2: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xd1040000-0xd1043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xd1030000-0xd103ffff 64bit]
pci 0000:00:1f.3: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.3: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xd104d000-0xd104d0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
pci 0000:00:1f.4: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.4: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.6: calling  quirk_f0_vpd_link+0x0/0x220 @ 1
pci 0000:00:1f.6: quirk_f0_vpd_link+0x0/0x220 took 0 usecs
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xd1000000-0xd101ffff]
pci 0000:00:1f.6: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 1
pci 0000:00:1f.6: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
ACPI: PCI: Interrupt link LNKA configured for IRQ 11
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 11
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 11
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
ACPI: EC: GPE=0x6e
ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
initcall acpi_init+0x0/0x271 returned 0 after 1351000 usecs
calling  adxl_init+0x0/0x250 @ 1
initcall adxl_init+0x0/0x250 returned -19 after 0 usecs
calling  pnp_init+0x0/0x15 @ 1
initcall pnp_init+0x0/0x15 returned 0 after 0 usecs
calling  misc_init+0x0/0xe8 @ 1
initcall misc_init+0x0/0xe8 returned 0 after 0 usecs
calling  tpm_init+0x0/0x21c @ 1
initcall tpm_init+0x0/0x21c returned 0 after 0 usecs
calling  iommu_subsys_init+0x0/0x1a9 @ 1
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
initcall iommu_subsys_init+0x0/0x1a9 returned 0 after 2000 usecs
calling  cn_init+0x0/0x180 @ 1
initcall cn_init+0x0/0x180 returned 0 after 0 usecs
calling  dax_core_init+0x0/0xe7 @ 1
initcall dax_core_init+0x0/0xe7 returned 0 after 0 usecs
calling  dma_buf_init+0x0/0xcb @ 1
initcall dma_buf_init+0x0/0xcb returned 0 after 0 usecs
calling  dma_resv_lockdep+0x0/0x45a @ 1
initcall dma_resv_lockdep+0x0/0x45a returned 0 after 0 usecs
calling  dma_heap_init+0x0/0xc0 @ 1
initcall dma_heap_init+0x0/0xc0 returned 0 after 0 usecs
calling  init_scsi+0x0/0x8c @ 1
SCSI subsystem initialized
initcall init_scsi+0x0/0x8c returned 0 after 1000 usecs
calling  phy_init+0x0/0x69 @ 1
initcall phy_init+0x0/0x69 returned 0 after 0 usecs
calling  usb_common_init+0x0/0x21 @ 1
initcall usb_common_init+0x0/0x21 returned 0 after 0 usecs
calling  usb_init+0x0/0x154 @ 1
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
initcall usb_init+0x0/0x154 returned 0 after 4000 usecs
calling  xdbc_init+0x0/0x155 @ 1
initcall xdbc_init+0x0/0x155 returned 0 after 0 usecs
calling  typec_init+0x0/0xb2 @ 1
initcall typec_init+0x0/0xb2 returned 0 after 0 usecs
calling  serio_init+0x0/0x32 @ 1
initcall serio_init+0x0/0x32 returned 0 after 0 usecs
calling  input_init+0x0/0x108 @ 1
initcall input_init+0x0/0x108 returned 0 after 0 usecs
calling  rtc_init+0x0/0x75 @ 1
initcall rtc_init+0x0/0x75 returned 0 after 0 usecs
calling  rc_core_init+0x0/0x7e @ 1
initcall rc_core_init+0x0/0x7e returned 0 after 0 usecs
calling  pps_init+0x0/0xda @ 1
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
initcall pps_init+0x0/0xda returned 0 after 2000 usecs
calling  ptp_init+0x0/0xc4 @ 1
PTP clock support registered
initcall ptp_init+0x0/0xc4 returned 0 after 1000 usecs
calling  power_supply_class_init+0x0/0x68 @ 1
initcall power_supply_class_init+0x0/0x68 returned 0 after 0 usecs
calling  hwmon_init+0x0/0x17c @ 1
initcall hwmon_init+0x0/0x17c returned 0 after 0 usecs
calling  md_init+0x0/0x160 @ 1
initcall md_init+0x0/0x160 returned 0 after 0 usecs
calling  edac_init+0x0/0x7a @ 1
EDAC MC: Ver: 3.0.0
initcall edac_init+0x0/0x7a returned 0 after 1000 usecs
calling  leds_init+0x0/0x83 @ 1
initcall leds_init+0x0/0x83 returned 0 after 0 usecs
calling  dmi_init+0x0/0x146 @ 1
initcall dmi_init+0x0/0x146 returned 0 after 0 usecs
calling  efisubsys_init+0x0/0x278 @ 1
initcall efisubsys_init+0x0/0x278 returned 0 after 0 usecs
calling  ras_init+0x0/0x13 @ 1
initcall ras_init+0x0/0x13 returned 0 after 0 usecs
calling  nvmem_init+0x0/0x15 @ 1
initcall nvmem_init+0x0/0x15 returned 0 after 0 usecs
calling  proto_init+0x0/0x15 @ 1
initcall proto_init+0x0/0x15 returned 0 after 0 usecs
calling  net_dev_init+0x0/0x620 @ 1
initcall net_dev_init+0x0/0x620 returned 0 after 1000 usecs
calling  neigh_init+0x0/0x89 @ 1
initcall neigh_init+0x0/0x89 returned 0 after 0 usecs
calling  fib_notifier_init+0x0/0x15 @ 1
initcall fib_notifier_init+0x0/0x15 returned 0 after 0 usecs
calling  fib_rules_init+0x0/0xb6 @ 1
initcall fib_rules_init+0x0/0xb6 returned 0 after 0 usecs
calling  init_cgroup_netprio+0x0/0x18 @ 1
initcall init_cgroup_netprio+0x0/0x18 returned 0 after 0 usecs
calling  bpf_lwt_init+0x0/0x1a @ 1
initcall bpf_lwt_init+0x0/0x1a returned 0 after 0 usecs
calling  pktsched_init+0x0/0x117 @ 1
initcall pktsched_init+0x0/0x117 returned 0 after 0 usecs
calling  tc_filter_init+0x0/0x104 @ 1
initcall tc_filter_init+0x0/0x104 returned 0 after 0 usecs
calling  tc_action_init+0x0/0x59 @ 1
initcall tc_action_init+0x0/0x59 returned 0 after 0 usecs
calling  ethnl_init+0x0/0x5c @ 1
initcall ethnl_init+0x0/0x5c returned 0 after 0 usecs
calling  nexthop_init+0x0/0xfa @ 1
initcall nexthop_init+0x0/0xfa returned 0 after 0 usecs
calling  cipso_v4_init+0x0/0xee @ 1
initcall cipso_v4_init+0x0/0xee returned 0 after 0 usecs
calling  netlbl_init+0x0/0x8c @ 1
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
initcall netlbl_init+0x0/0x8c returned 0 after 4000 usecs
calling  pci_subsys_init+0x0/0x122 @ 1
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x00091c00-0x0009ffff]
e820: reserve RAM buffer [mem 0xb30fb000-0xb3ffffff]
e820: reserve RAM buffer [mem 0xb3f00000-0xb3ffffff]
e820: reserve RAM buffer [mem 0x43f800000-0x43fffffff]
initcall pci_subsys_init+0x0/0x122 returned 0 after 34000 usecs
calling  vsprintf_init_hashval+0x0/0x13 @ 1
initcall vsprintf_init_hashval+0x0/0x13 returned 0 after 0 usecs
calling  efi_runtime_map_init+0x0/0x1dc @ 1
initcall efi_runtime_map_init+0x0/0x1dc returned 0 after 0 usecs
calling  vga_arb_device_init+0x0/0x7b @ 1
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
initcall vga_arb_device_init+0x0/0x7b returned 0 after 2000 usecs
calling  watchdog_init+0x0/0x13d @ 1
initcall watchdog_init+0x0/0x13d returned 0 after 0 usecs
calling  nmi_warning_debugfs+0x0/0x51 @ 1
initcall nmi_warning_debugfs+0x0/0x51 returned 0 after 0 usecs
calling  save_microcode_in_initrd+0x0/0xc7 @ 1
initcall save_microcode_in_initrd+0x0/0xc7 returned 0 after 0 usecs
calling  hpet_late_init+0x0/0x173 @ 1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
initcall hpet_late_init+0x0/0x173 returned 0 after 4000 usecs
calling  iomem_init_inode+0x0/0xab @ 1
initcall iomem_init_inode+0x0/0xab returned 0 after 0 usecs
calling  clocksource_done_booting+0x0/0x48 @ 1
clocksource: Switched to clocksource tsc-early
initcall clocksource_done_booting+0x0/0x48 returned 0 after 6368 usecs
calling  tracer_init_tracefs+0x0/0x183 @ 1
initcall tracer_init_tracefs+0x0/0x183 returned 0 after 29 usecs
calling  init_trace_printk_function_export+0x0/0x2c @ 1
initcall init_trace_printk_function_export+0x0/0x2c returned 0 after 64 usecs
calling  init_graph_tracefs+0x0/0x2c @ 1
initcall init_graph_tracefs+0x0/0x2c returned 0 after 21 usecs
calling  trace_events_synth_init+0x0/0x4b @ 1
initcall trace_events_synth_init+0x0/0x4b returned 0 after 20 usecs
calling  bpf_event_init+0x0/0x13 @ 1
initcall bpf_event_init+0x0/0x13 returned 0 after 1 usecs
calling  init_kprobe_trace+0x0/0x312 @ 1
initcall init_kprobe_trace+0x0/0x312 returned 0 after 14272 usecs
calling  init_dynamic_event+0x0/0x2c @ 1
initcall init_dynamic_event+0x0/0x2c returned 0 after 20 usecs
calling  init_uprobe_trace+0x0/0x60 @ 1
initcall init_uprobe_trace+0x0/0x60 returned 0 after 39 usecs
calling  bpf_init+0x0/0x9d @ 1
initcall bpf_init+0x0/0x9d returned 0 after 10 usecs
calling  secretmem_init+0x0/0x60 @ 1
initcall secretmem_init+0x0/0x60 returned 0 after 0 usecs
calling  init_fs_stat_sysctls+0x0/0x32 @ 1
initcall init_fs_stat_sysctls+0x0/0x32 returned 0 after 27 usecs
calling  init_fs_exec_sysctls+0x0/0x26 @ 1
initcall init_fs_exec_sysctls+0x0/0x26 returned 0 after 6 usecs
calling  init_pipe_fs+0x0/0x68 @ 1
initcall init_pipe_fs+0x0/0x68 returned 0 after 187 usecs
calling  init_fs_namei_sysctls+0x0/0x26 @ 1
initcall init_fs_namei_sysctls+0x0/0x26 returned 0 after 7 usecs
calling  init_fs_dcache_sysctls+0x0/0x26 @ 1
initcall init_fs_dcache_sysctls+0x0/0x26 returned 0 after 5 usecs
calling  init_fs_namespace_sysctls+0x0/0x26 @ 1
initcall init_fs_namespace_sysctls+0x0/0x26 returned 0 after 6 usecs
calling  cgroup_writeback_init+0x0/0x2a @ 1
initcall cgroup_writeback_init+0x0/0x2a returned 0 after 19 usecs
calling  inotify_user_setup+0x0/0x18e @ 1
initcall inotify_user_setup+0x0/0x18e returned 0 after 39 usecs
calling  eventpoll_init+0x0/0x145 @ 1
initcall eventpoll_init+0x0/0x145 returned 0 after 61 usecs
calling  anon_inode_init+0x0/0x8e @ 1
initcall anon_inode_init+0x0/0x8e returned 0 after 183 usecs
calling  init_dax_wait_table+0x0/0x38 @ 1
initcall init_dax_wait_table+0x0/0x38 returned 0 after 270 usecs
calling  proc_locks_init+0x0/0x2c @ 1
initcall proc_locks_init+0x0/0x2c returned 0 after 7 usecs
calling  init_fs_coredump_sysctls+0x0/0x26 @ 1
initcall init_fs_coredump_sysctls+0x0/0x26 returned 0 after 9 usecs
calling  iomap_init+0x0/0x24 @ 1
initcall iomap_init+0x0/0x24 returned 0 after 238 usecs
calling  dquot_init+0x0/0x167 @ 1
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
initcall dquot_init+0x0/0x167 returned 0 after 12576 usecs
calling  quota_init+0x0/0x28 @ 1
initcall quota_init+0x0/0x28 returned 0 after 82 usecs
calling  proc_cmdline_init+0x0/0x93 @ 1
initcall proc_cmdline_init+0x0/0x93 returned 0 after 16 usecs
calling  proc_consoles_init+0x0/0x29 @ 1
initcall proc_consoles_init+0x0/0x29 returned 0 after 6 usecs
calling  proc_cpuinfo_init+0x0/0x23 @ 1
initcall proc_cpuinfo_init+0x0/0x23 returned 0 after 6 usecs
calling  proc_devices_init+0x0/0x62 @ 1
initcall proc_devices_init+0x0/0x62 returned 0 after 5 usecs
calling  proc_interrupts_init+0x0/0x29 @ 1
initcall proc_interrupts_init+0x0/0x29 returned 0 after 6 usecs
calling  proc_loadavg_init+0x0/0x5f @ 1
initcall proc_loadavg_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_meminfo_init+0x0/0x5f @ 1
initcall proc_meminfo_init+0x0/0x5f returned 0 after 5 usecs
calling  proc_stat_init+0x0/0x23 @ 1
initcall proc_stat_init+0x0/0x23 returned 0 after 6 usecs
calling  proc_uptime_init+0x0/0x5f @ 1
initcall proc_uptime_init+0x0/0x5f returned 0 after 6 usecs
calling  proc_version_init+0x0/0x5f @ 1
initcall proc_version_init+0x0/0x5f returned 0 after 5 usecs
calling  proc_softirqs_init+0x0/0x5f @ 1
initcall proc_softirqs_init+0x0/0x5f returned 0 after 17 usecs
calling  proc_kcore_init+0x0/0x146 @ 1
initcall proc_kcore_init+0x0/0x146 returned 0 after 82 usecs
calling  vmcore_init+0x0/0x2f5 @ 1
initcall vmcore_init+0x0/0x2f5 returned 0 after 0 usecs
calling  proc_kmsg_init+0x0/0x26 @ 1
initcall proc_kmsg_init+0x0/0x26 returned 0 after 26 usecs
calling  proc_page_init+0x0/0x5a @ 1
initcall proc_page_init+0x0/0x5a returned 0 after 16 usecs
calling  init_ramfs_fs+0x0/0x15 @ 1
initcall init_ramfs_fs+0x0/0x15 returned 0 after 1 usecs
calling  init_hugetlbfs_fs+0x0/0x2a4 @ 1
initcall init_hugetlbfs_fs+0x0/0x2a4 returned 0 after 297 usecs
calling  dynamic_debug_init_control+0x0/0x80 @ 1
initcall dynamic_debug_init_control+0x0/0x80 returned 0 after 52 usecs
calling  acpi_event_init+0x0/0x65 @ 1
initcall acpi_event_init+0x0/0x65 returned 0 after 59 usecs
calling  pnp_system_init+0x0/0x15 @ 1
initcall pnp_system_init+0x0/0x15 returned 0 after 53 usecs
calling  pnpacpi_init+0x0/0xd6 @ 1
pnp: PnP ACPI init
system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:00: [mem 0xfe000000-0xfe01ffff] has been reserved
system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:01: [io  0x0680-0x069f] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0xffff] has been reserved
system 00:01: [io  0x1800-0x18fe] has been reserved
system 00:01: [io  0x164e-0x164f] has been reserved
system 00:02: [io  0x0800-0x087f] has been reserved
system 00:04: [io  0x1854-0x1857] has been reserved
system 00:08: [io  0x0200-0x023f] has been reserved
system 00:08: [mem 0xfedb0000-0xfedbffff] has been reserved
system 00:09: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:09: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:09: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
system 00:09: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:09: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:09: [mem 0xfed45000-0xfed8ffff] could not be reserved
system 00:09: [mem 0xff000000-0xffffffff] could not be reserved
system 00:09: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:09: [mem 0xfedc0000-0xfeddffff] has been reserved
pnp: PnP ACPI: found 11 devices
initcall pnpacpi_init+0x0/0xd6 returned 0 after 224022 usecs
calling  chr_dev_init+0x0/0x135 @ 1
initcall chr_dev_init+0x0/0x135 returned 0 after 14345 usecs
calling  hwrng_modinit+0x0/0xea @ 1
initcall hwrng_modinit+0x0/0xea returned 0 after 258 usecs
calling  firmware_class_init+0x0/0x15f @ 1
initcall firmware_class_init+0x0/0x15f returned 0 after 53 usecs
calling  init_acpi_pm_clocksource+0x0/0xd6 @ 1
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
initcall init_acpi_pm_clocksource+0x0/0xd6 returned 0 after 14306 usecs
calling  powercap_init+0x0/0x26 @ 1
initcall powercap_init+0x0/0x26 returned 0 after 272 usecs
calling  sysctl_core_init+0x0/0x2f @ 1
initcall sysctl_core_init+0x0/0x2f returned 0 after 43 usecs
calling  eth_offload_init+0x0/0x18 @ 1
initcall eth_offload_init+0x0/0x18 returned 0 after 24 usecs
calling  ipv4_offload_init+0x0/0x78 @ 1
initcall ipv4_offload_init+0x0/0x78 returned 0 after 1 usecs
calling  inet_init+0x0/0x32f @ 1
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
TCP: Hash tables configured (established 131072 bind 65536)
MPTCP token hash table entries: 16384 (order: 8, 1441792 bytes, linear)
UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
initcall inet_init+0x0/0x32f returned 0 after 98469 usecs
calling  af_unix_init+0x0/0x19e @ 1
NET: Registered PF_UNIX/PF_LOCAL protocol family
initcall af_unix_init+0x0/0x19e returned 0 after 6624 usecs
calling  ipv6_offload_init+0x0/0x83 @ 1
initcall ipv6_offload_init+0x0/0x83 returned 0 after 1 usecs
calling  init_sunrpc+0x0/0x8c @ 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
initcall init_sunrpc+0x0/0x8c returned 0 after 26222 usecs
calling  vlan_offload_init+0x0/0x24 @ 1
initcall vlan_offload_init+0x0/0x24 returned 0 after 1 usecs
calling  xsk_init+0x0/0x1bc @ 1
NET: Registered PF_XDP protocol family
initcall xsk_init+0x0/0x1bc returned 0 after 5643 usecs
calling  pcibios_assign_resources+0x0/0x23a @ 1
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xbe800000-0xdfffffff window]
pci_bus 0000:00: resource 8 [mem 0x1c00000000-0x1fffffffff window]
pci_bus 0000:00: resource 9 [mem 0xfd000000-0xfe7fffff window]
initcall pcibios_assign_resources+0x0/0x23a returned 0 after 46877 usecs
calling  pci_apply_final_quirks+0x0/0x330 @ 1
pci 0000:00:14.0: calling  quirk_usb_early_handoff+0x0/0x2d0 @ 1
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x2d0 took 13825 usecs
pci 0000:00:1f.6: calling  quirk_e100_interrupt+0x0/0x290 @ 1
pci 0000:00:1f.6: quirk_e100_interrupt+0x0/0x290 took 0 usecs
PCI: CLS 0 bytes, default 64
initcall pci_apply_final_quirks+0x0/0x330 returned 0 after 50549 usecs
calling  acpi_reserve_resources+0x0/0x277 @ 1
initcall acpi_reserve_resources+0x0/0x277 returned 0 after 38 usecs
calling  populate_rootfs+0x0/0x40 @ 1
initcall populate_rootfs+0x0/0x40 returned 0 after 66 usecs
Trying to unpack rootfs image as initramfs...
calling  pci_iommu_init+0x0/0x59 @ 1
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000af0fb000-0x00000000b30fb000] (64MB)
initcall pci_iommu_init+0x0/0x59 returned 0 after 27912 usecs
calling  ir_dev_scope_init+0x0/0x71 @ 1
initcall ir_dev_scope_init+0x0/0x71 returned 0 after 0 usecs
calling  ia32_binfmt_init+0x0/0x18 @ 1
initcall ia32_binfmt_init+0x0/0x18 returned 0 after 93 usecs
calling  amd_ibs_init+0x0/0xfa @ 1
initcall amd_ibs_init+0x0/0xfa returned -19 after 0 usecs
calling  msr_init+0x0/0x80 @ 1
initcall msr_init+0x0/0x80 returned 0 after 14 usecs
calling  register_kernel_offset_dumper+0x0/0x1f @ 1
initcall register_kernel_offset_dumper+0x0/0x1f returned 0 after 1 usecs
calling  i8259A_init_ops+0x0/0x25 @ 1
initcall i8259A_init_ops+0x0/0x25 returned 0 after 1 usecs
calling  init_tsc_clocksource+0x0/0xe6 @ 1
initcall init_tsc_clocksource+0x0/0xe6 returned 0 after 6 usecs
calling  add_rtc_cmos+0x0/0x1f4 @ 1
initcall add_rtc_cmos+0x0/0x1f4 returned 0 after 2 usecs
calling  i8237A_init_ops+0x0/0x3b @ 1
initcall i8237A_init_ops+0x0/0x3b returned -19 after 2 usecs
calling  umwait_init+0x0/0xe1 @ 1
initcall umwait_init+0x0/0xe1 returned -19 after 0 usecs
calling  sgx_init+0x0/0x15d @ 1
initcall sgx_init+0x0/0x15d returned -19 after 0 usecs
calling  msr_init+0x0/0x101 @ 1
initcall msr_init+0x0/0x101 returned 0 after 1586 usecs
calling  cpuid_init+0x0/0x101 @ 1
initcall cpuid_init+0x0/0x101 returned 0 after 1103 usecs
calling  ioapic_init_ops+0x0/0x18 @ 1
initcall ioapic_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  register_e820_pmem+0x0/0x62 @ 1
initcall register_e820_pmem+0x0/0x62 returned 0 after 4 usecs
calling  add_pcspkr+0x0/0xd3 @ 1
initcall add_pcspkr+0x0/0xd3 returned 0 after 136 usecs
calling  start_periodic_check_for_corruption+0x0/0x40 @ 1
initcall start_periodic_check_for_corruption+0x0/0x40 returned 0 after 0 usecs
calling  audit_classes_init+0x0/0xb3 @ 1
initcall audit_classes_init+0x0/0xb3 returned 0 after 47 usecs
calling  sha1_ssse3_mod_init+0x0/0xeb @ 1
initcall sha1_ssse3_mod_init+0x0/0xeb returned 0 after 14 usecs
calling  sha256_ssse3_mod_init+0x0/0xff @ 1
initcall sha256_ssse3_mod_init+0x0/0xff returned 0 after 18 usecs
calling  iosf_mbi_init+0x0/0x2d @ 1
initcall iosf_mbi_init+0x0/0x2d returned 0 after 122 usecs
calling  proc_execdomains_init+0x0/0x26 @ 1
initcall proc_execdomains_init+0x0/0x26 returned 0 after 13 usecs
calling  register_warn_debugfs+0x0/0x28 @ 1
initcall register_warn_debugfs+0x0/0x28 returned 0 after 41 usecs
calling  cpuhp_sysfs_init+0x0/0x144 @ 1
initcall cpuhp_sysfs_init+0x0/0x144 returned 0 after 140 usecs
calling  ioresources_init+0x0/0x4e @ 1
initcall ioresources_init+0x0/0x4e returned 0 after 19 usecs
calling  lockdep_proc_init+0x0/0x64 @ 1
initcall lockdep_proc_init+0x0/0x64 returned 0 after 17 usecs
calling  snapshot_device_init+0x0/0x15 @ 1
initcall snapshot_device_init+0x0/0x15 returned 0 after 238 usecs
calling  irq_pm_init_ops+0x0/0x18 @ 1
initcall irq_pm_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  klp_init+0x0/0x53 @ 1
initcall klp_init+0x0/0x53 returned 0 after 28 usecs
calling  map_benchmark_init+0x0/0x4e @ 1
initcall map_benchmark_init+0x0/0x4e returned 0 after 140 usecs
calling  proc_modules_init+0x0/0x23 @ 1
initcall proc_modules_init+0x0/0x23 returned 0 after 9 usecs
calling  timer_sysctl_init+0x0/0x1f @ 1
initcall timer_sysctl_init+0x0/0x1f returned 0 after 9 usecs
calling  timekeeping_init_ops+0x0/0x18 @ 1
initcall timekeeping_init_ops+0x0/0x18 returned 0 after 1 usecs
calling  init_clocksource_sysfs+0x0/0x28 @ 1
initcall init_clocksource_sysfs+0x0/0x28 returned 0 after 322 usecs
calling  init_timer_list_procfs+0x0/0x36 @ 1
initcall init_timer_list_procfs+0x0/0x36 returned 0 after 22 usecs
calling  alarmtimer_init+0x0/0x133 @ 1
initcall alarmtimer_init+0x0/0x133 returned 0 after 102 usecs
calling  init_posix_timers+0x0/0x2e @ 1
initcall init_posix_timers+0x0/0x2e returned 0 after 36 usecs
calling  clockevents_init_sysfs+0x0/0x19e @ 1
initcall clockevents_init_sysfs+0x0/0x19e returned 0 after 705 usecs
calling  proc_dma_init+0x0/0x26 @ 1
initcall proc_dma_init+0x0/0x26 returned 0 after 8 usecs
calling  kallsyms_init+0x0/0x26 @ 1
initcall kallsyms_init+0x0/0x26 returned 0 after 6 usecs
calling  pid_namespaces_init+0x0/0x44 @ 1
initcall pid_namespaces_init+0x0/0x44 returned 0 after 74 usecs
calling  ikconfig_init+0x0/0x46 @ 1
initcall ikconfig_init+0x0/0x46 returned 0 after 7 usecs
calling  audit_watch_init+0x0/0x40 @ 1
initcall audit_watch_init+0x0/0x40 returned 0 after 4 usecs
calling  audit_fsnotify_init+0x0/0x43 @ 1
initcall audit_fsnotify_init+0x0/0x43 returned 0 after 4 usecs
calling  audit_tree_init+0x0/0xcf @ 1
initcall audit_tree_init+0x0/0xcf returned 0 after 36 usecs
calling  seccomp_sysctl_init+0x0/0x30 @ 1
initcall seccomp_sysctl_init+0x0/0x30 returned 0 after 29 usecs
calling  utsname_sysctl_init+0x0/0x18 @ 1
initcall utsname_sysctl_init+0x0/0x18 returned 0 after 34 usecs
calling  init_tracepoints+0x0/0x30 @ 1
initcall init_tracepoints+0x0/0x30 returned 0 after 2 usecs
calling  init_lstats_procfs+0x0/0x40 @ 1
initcall init_lstats_procfs+0x0/0x40 returned 0 after 23 usecs
calling  stack_trace_init+0x0/0xa8 @ 1
initcall stack_trace_init+0x0/0xa8 returned 0 after 65 usecs
calling  perf_event_sysfs_init+0x0/0x10c @ 1
initcall perf_event_sysfs_init+0x0/0x10c returned 0 after 1683 usecs
calling  system_trusted_keyring_init+0x0/0x8e @ 1
Initialise system trusted keyrings
initcall system_trusted_keyring_init+0x0/0x8e returned 0 after 5363 usecs
calling  blacklist_init+0x0/0x166 @ 1
Key type blacklist registered
initcall blacklist_init+0x0/0x166 returned 0 after 4893 usecs
calling  kswapd_init+0x0/0x64 @ 1
initcall kswapd_init+0x0/0x64 returned 0 after 200 usecs
calling  extfrag_debug_init+0x0/0x5b @ 1
initcall extfrag_debug_init+0x0/0x5b returned 0 after 93 usecs
calling  mm_compute_batch_init+0x0/0x57 @ 1
initcall mm_compute_batch_init+0x0/0x57 returned 0 after 1 usecs
calling  slab_proc_init+0x0/0x26 @ 1
initcall slab_proc_init+0x0/0x26 returned 0 after 9 usecs
calling  workingset_init+0x0/0xd4 @ 1
workingset: timestamp_bits=36 max_order=22 bucket_order=0
initcall workingset_init+0x0/0xd4 returned 0 after 7310 usecs
calling  proc_vmalloc_init+0x0/0x68 @ 1
initcall proc_vmalloc_init+0x0/0x68 returned 0 after 22 usecs
calling  procswaps_init+0x0/0x23 @ 1
initcall procswaps_init+0x0/0x23 returned 0 after 8 usecs
calling  init_frontswap+0x0/0x97 @ 1
initcall init_frontswap+0x0/0x97 returned 0 after 114 usecs
calling  slab_debugfs_init+0x0/0x52 @ 1
initcall slab_debugfs_init+0x0/0x52 returned 0 after 28 usecs
calling  init_zbud+0x0/0x24 @ 1
zbud: loaded
initcall init_zbud+0x0/0x24 returned 0 after 3372 usecs
calling  zs_init+0x0/0x77 @ 1
initcall zs_init+0x0/0x77 returned 0 after 79 usecs
calling  damon_dbgfs_init+0x0/0x389 @ 1
initcall damon_dbgfs_init+0x0/0x389 returned 0 after 273 usecs
calling  fcntl_init+0x0/0x2e @ 1
initcall fcntl_init+0x0/0x2e returned 0 after 32 usecs
calling  proc_filesystems_init+0x0/0x26 @ 1
initcall proc_filesystems_init+0x0/0x26 returned 0 after 12 usecs
calling  start_dirtytime_writeback+0x0/0x1b @ 1
initcall start_dirtytime_writeback+0x0/0x1b returned 0 after 2 usecs
calling  dio_init+0x0/0x31 @ 1
initcall dio_init+0x0/0x31 returned 0 after 47 usecs
calling  dnotify_init+0x0/0xa1 @ 1
initcall dnotify_init+0x0/0xa1 returned 0 after 54 usecs
calling  fanotify_user_setup+0x0/0x1fb @ 1
initcall fanotify_user_setup+0x0/0x1fb returned 0 after 84 usecs
calling  userfaultfd_init+0x0/0x4a @ 1
initcall userfaultfd_init+0x0/0x4a returned 0 after 252 usecs
calling  aio_setup+0x0/0x9c @ 1
initcall aio_setup+0x0/0x9c returned 0 after 277 usecs
calling  mbcache_init+0x0/0x35 @ 1
initcall mbcache_init+0x0/0x35 returned 0 after 19 usecs
calling  init_grace+0x0/0x15 @ 1
initcall init_grace+0x0/0x15 returned 0 after 7 usecs
calling  init_v2_quota_format+0x0/0x26 @ 1
initcall init_v2_quota_format+0x0/0x26 returned 0 after 25 usecs
calling  init_devpts_fs+0x0/0x30 @ 1
initcall init_devpts_fs+0x0/0x30 returned 0 after 26 usecs
calling  ext4_init_fs+0x0/0x1a3 @ 1
initcall ext4_init_fs+0x0/0x1a3 returned 0 after 697 usecs
calling  journal_init+0x0/0x132 @ 1
initcall journal_init+0x0/0x132 returned 0 after 140 usecs
calling  init_nfs_fs+0x0/0x195 @ 1
initcall init_nfs_fs+0x0/0x195 returned 0 after 723 usecs
calling  init_nfs_v3+0x0/0x18 @ 1
initcall init_nfs_v3+0x0/0x18 returned 0 after 29 usecs
calling  init_nlm+0x0/0x66 @ 1
initcall init_nlm+0x0/0x66 returned 0 after 39 usecs
calling  init_nls_cp437+0x0/0x17 @ 1
initcall init_nls_cp437+0x0/0x17 returned 0 after 26 usecs
calling  init_nls_ascii+0x0/0x17 @ 1
initcall init_nls_ascii+0x0/0x17 returned 0 after 0 usecs
calling  init_autofs_fs+0x0/0x2e @ 1
initcall init_autofs_fs+0x0/0x2e returned 0 after 240 usecs
calling  efivarfs_init+0x0/0x25 @ 1
initcall efivarfs_init+0x0/0x25 returned -19 after 0 usecs
calling  ipc_init+0x0/0x29 @ 1
initcall ipc_init+0x0/0x29 returned 0 after 70 usecs
calling  ipc_sysctl_init+0x0/0x31 @ 1
initcall ipc_sysctl_init+0x0/0x31 returned 0 after 36 usecs
calling  init_mqueue_fs+0x0/0xcd @ 1
tsc: Refined TSC clocksource calibration: 3312.000 MHz
initcall init_mqueue_fs+0x0/0xcd returned 0 after 296 usecs
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2fbd93f9e57, max_idle_ns: 440795263784 ns
calling  key_proc_init+0x0/0x72 @ 1
clocksource: Switched to clocksource tsc
initcall key_proc_init+0x0/0x72 returned 0 after 24 usecs
calling  jent_mod_init+0x0/0x32 @ 1
initcall jent_mod_init+0x0/0x32 returned 0 after 6561 usecs
calling  af_alg_init+0x0/0x45 @ 1
NET: Registered PF_ALG protocol family
initcall af_alg_init+0x0/0x45 returned 0 after 5612 usecs
calling  algif_hash_init+0x0/0x15 @ 1
initcall algif_hash_init+0x0/0x15 returned 0 after 58 usecs
calling  algif_skcipher_init+0x0/0x15 @ 1
initcall algif_skcipher_init+0x0/0x15 returned 0 after 4 usecs
calling  rng_init+0x0/0x15 @ 1
initcall rng_init+0x0/0x15 returned 0 after 4 usecs
calling  algif_aead_init+0x0/0x15 @ 1
initcall algif_aead_init+0x0/0x15 returned 0 after 16 usecs
calling  asymmetric_key_init+0x0/0x15 @ 1
Key type asymmetric registered
initcall asymmetric_key_init+0x0/0x15 returned 0 after 4906 usecs
calling  x509_key_init+0x0/0x1d @ 1
Asymmetric key parser 'x509' registered
initcall x509_key_init+0x0/0x1d returned 0 after 5751 usecs
calling  blkdev_init+0x0/0x24 @ 1
initcall blkdev_init+0x0/0x24 returned 0 after 49 usecs
calling  proc_genhd_init+0x0/0x46 @ 1
initcall proc_genhd_init+0x0/0x46 returned 0 after 16 usecs
calling  bsg_init+0x0/0x11b @ 1
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
initcall bsg_init+0x0/0x11b returned 0 after 8334 usecs
calling  throtl_init+0x0/0x45 @ 1
[   usecs
calling  digsig_init+0x0/0x3d @ 1
initcall digsig_init+0x0/0x3d returned 0 after 23 usecs
calling  pcie_portdrv_init+0x0/0x4d @ 1
initcall pcie_portdrv_init+0x0/0x4d returned 0 after 278 usecs
calling  pci_proc_init+0x0/0x70 @ 1
initcall pci_proc_init+0x0/0x70 returned 0 after 90 usecs
calling  pci_hotplug_init+0x0/0xc @ 1
initcall pci_hotplug_init+0x0/0xc returned 0 after 0 usecs
calling  shpcd_init+0x0/0x61 @ 1
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
initcall shpcd_init+0x0/0x61 returned 0 after 7626 usecs
calling  pci_stub_init+0x0/0x1ff @ 1
initcall pci_stub_init+0x0/0x1ff returned 0 after 83 usecs
calling  vmd_drv_init+0x0/0x1e @ 1
initcall vmd_drv_init+0x0/0x1e returned 0 after 86 usecs
calling  vesafb_driver_init+0x0/0x17 @ 1
initcall vesafb_driver_init+0x0/0x17 returned 0 after 59 usecs
calling  efifb_driver_init+0x0/0x17 @ 1
initcall efifb_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  intel_idle_init+0x0/0x507 @ 1
initcall intel_idle_init+0x0/0x507 returned 0 after 3761 usecs
calling  ged_driver_init+0x0/0x17 @ 1
initcall ged_driver_init+0x0/0x17 returned 0 after 128 usecs
calling  acpi_ac_init+0x0/0x7c @ 1
initcall acpi_ac_init+0x0/0x7c returned 0 after 510 usecs
calling  acpi_button_driver_init+0x0/0xb3 @ 1
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
initcall acpi_button_driver_init+0x0/0xb3 returned 0 after 45204 usecs
calling  acpi_fan_driver_init+0x0/0x17 @ 1
initcall acpi_fan_driver_init+0x0/0x17 returned 0 after 61 usecs
calling  acpi_processor_driver_init+0x0/0xef @ 1
initcall acpi_processor_driver_init+0x0/0xef returned 0 after 1989 usecs
calling  acpi_thermal_init+0x0/0x86 @ 1
initcall acpi_thermal_init+0x0/0x86 returned 0 after 687 usecs
calling  acpi_battery_init+0x0/0x71 @ 1
initcall acpi_battery_init+0x0/0x71 returned 0 after 12 usecs
calling  acpi_hed_driver_init+0x0/0x15 @ 1
initcall acpi_hed_driver_init+0x0/0x15 returned 0 after 138 usecs
calling  bgrt_init+0x0/0x19f @ 1
initcall bgrt_init+0x0/0x19f returned -19 after 0 usecs
calling  erst_init+0x0/0x4c7 @ 1
initcall erst_init+0x0/0x4c7 returned 0 after 2 usecs
calling  gpio_clk_driver_init+0x0/0x17 @ 1
initcall gpio_clk_driver_init+0x0/0x17 returned 0 after 151 usecs
calling  plt_clk_driver_init+0x0/0x17 @ 1
initcall plt_clk_driver_init+0x0/0x17 returned 0 after 47 usecs
calling  dw_pci_driver_init+0x0/0x1e @ 1
initcall dw_pci_driver_init+0x0/0x1e returned 0 after 73 usecs
calling  virtio_pci_driver_init+0x0/0x1e @ 1
initcall virtio_pci_driver_init+0x0/0x1e returned 0 after 72 usecs
calling  n_null_init+0x0/0x1e @ 1
initcall n_null_init+0x0/0x1e returned 0 after 1 usecs
calling  pty_init+0x0/0x11 @ 1
initcall pty_init+0x0/0x11 returned 0 after 396 usecs
calling  sysrq_init+0x0/0x4e @ 1
initcall sysrq_init+0x0/0x4e returned 0 after 12 usecs
calling  serial8250_init+0x0/0x320 @ 1
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
initcall serial8250_init+0x0/0x320 returned 0 after 18480 usecs
calling  serial_pci_driver_init+0x0/0x1e @ 1
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
0000:00:16.3: ttyS1 at I/O 0x3080 (irq = 19, base_baud = 115200) is a 16550A
initcall serial_pci_driver_init+0x0/0x1e returned 0 after 23234 usecs
calling  exar_pci_driver_init+0x0/0x1e @ 1
initcall exar_pci_driver_init+0x0/0x1e returned 0 after 78 usecs
calling  dw8250_platform_driver_init+0x0/0x17 @ 1
initcall dw8250_platform_driver_init+0x0/0x17 returned 0 after 133 usecs
calling  lpss8250_pci_driver_init+0x0/0x1e @ 1
initcall lpss8250_pci_driver_init+0x0/0x1e returned 0 after 131 usecs
calling  mid8250_pci_driver_init+0x0/0x1e @ 1
initcall mid8250_pci_driver_init+0x0/0x1e returned 0 after 78 usecs
calling  pericom8250_pci_driver_init+0x0/0x1e @ 1
initcall pericom8250_pci_driver_init+0x0/0x1e returned 0 after 66 usecs
calling  random_sysctls_init+0x0/0x26 @ 1
initcall random_sysctls_init+0x0/0x26 returned 0 after 31 usecs
calling  hpet_init+0x0/0x76 @ 1
initcall hpet_init+0x0/0x76 returned 0 after 1402 usecs
calling  nvram_module_init+0x0/0x8d @ 1
Non-volatile memory driver v1.3
initcall nvram_module_init+0x0/0x8d returned 0 after 5324 usecs
calling  virtio_rng_driver_init+0x0/0x15 @ 1
initcall virtio_rng_driver_init+0x0/0x15 returned 0 after 44 usecs
calling  init_tis+0x0/0x14e @ 1
tpm_tis 00:0a: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0: TPM is disabled/deactivated (0x7)
initcall init_tis+0x0/0x14e returned 0 after 36930 usecs
calling  crb_acpi_driver_init+0x0/0x15 @ 1
initcall crb_acpi_driver_init+0x0/0x15 returned 0 after 269 usecs
calling  cn_proc_init+0x0/0x3e @ 1
initcall cn_proc_init+0x0/0x3e returned 0 after 25 usecs
calling  topology_sysfs_init+0x0/0x30 @ 1
initcall topology_sysfs_init+0x0/0x30 returned 0 after 481 usecs
calling  cacheinfo_sysfs_init+0x0/0x30 @ 1
initcall cacheinfo_sysfs_init+0x0/0x30 returned 0 after 2058 usecs
calling  lkdtm_module_init+0x0/0x2a8 @ 1
lkdtm: No crash points registered, enable through debugfs
initcall lkdtm_module_init+0x0/0x2a8 returned 0 after 7589 usecs
calling  intel_lpss_init+0x0/0x21 @ 1
initcall intel_lpss_init+0x0/0x21 returned 0 after 22 usecs
calling  intel_lpss_pci_driver_init+0x0/0x1e @ 1
initcall intel_lpss_pci_driver_init+0x0/0x1e returned 0 after 95 usecs
calling  intel_lpss_acpi_driver_init+0x0/0x17 @ 1
initcall intel_lpss_acpi_driver_init+0x0/0x17 returned 0 after 65 usecs
calling  system_heap_create+0x0/0xc0 @ 1
initcall system_heap_create+0x0/0xc0 returned 0 after 544 usecs
calling  udmabuf_dev_init+0x0/0xab @ 1
initcall udmabuf_dev_init+0x0/0xab returned 0 after 303 usecs
calling  mac_hid_init+0x0/0x2d @ 1
initcall mac_hid_init+0x0/0x2d returned 0 after 18 usecs
calling  rdac_init+0x0/0x79 @ 1
rdac: device handler registered
initcall rdac_init+0x0/0x79 returned 0 after 5410 usecs
calling  hp_sw_init+0x0/0x15 @ 1
hp_sw: device handler registered
initcall hp_sw_init+0x0/0x15 returned 0 after 5109 usecs
calling  clariion_init+0x0/0x37 @ 1
emc: device handler registered
initcall clariion_init+0x0/0x37 returned 0 after 4909 usecs
calling  alua_init+0x0/0x68 @ 1
alua: device handler registered
initcall alua_init+0x0/0x68 returned 0 after 5426 usecs
calling  macsec_init+0x0/0x6e @ 1
MACsec IEEE 802.1AE
initcall macsec_init+0x0/0x6e returned 0 after 4005 usecs
calling  blackhole_netdev_init+0x0/0xcf @ 1
initcall blackhole_netdev_init+0x0/0xcf returned 0 after 36 usecs
calling  phylink_init+0x0/0xaf @ 1
initcall phylink_init+0x0/0xaf returned 0 after 0 usecs
calling  phy_module_init+0x0/0x1c @ 1
initcall phy_module_init+0x0/0x1c returned 0 after 143 usecs
calling  fixed_mdio_bus_init+0x0/0x245 @ 1
initcall fixed_mdio_bus_init+0x0/0x245 returned 0 after 1297 usecs
calling  phy_module_init+0x0/0x1c @ 1
initcall phy_module_init+0x0/0x1c returned 0 after 853 usecs
calling  vrf_init_module+0x0/0x8b @ 1
initcall vrf_init_module+0x0/0x8b returned 0 after 157 usecs
calling  cavium_ptp_driver_init+0x0/0x1e @ 1
initcall cavium_ptp_driver_init+0x0/0x1e returned 0 after 167 usecs
calling  e1000_init_module+0x0/0x7b @ 1
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
initcall e1000_init_module+0x0/0x7b returned 0 after 14156 usecs
calling  e1000_init_module+0x0/0x36 @ 1
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 3c:52:82:5d:1e:ba
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
initcall e1000_init_module+0x0/0x36 returned 0 after 204887 usecs
calling  igb_init_module+0x0/0x44 @ 1
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
initcall igb_init_module+0x0/0x44 returned 0 after 12739 usecs
calling  igc_init_module+0x0/0x44 @ 1
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
initcall igc_init_module+0x0/0x44 returned 0 after 10849 usecs
calling  ixgbe_init_module+0x0/0xad @ 1
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
initcall ixgbe_init_module+0x0/0xad returned 0 after 14078 usecs
calling  i40e_init_module+0x0/0xb8 @ 1
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
initcall i40e_init_module+0x0/0xb8 returned 0 after 14382 usecs
calling  rtl8169_pci_driver_init+0x0/0x1e @ 1
initcall rtl8169_pci_driver_init+0x0/0x1e returned 0 after 73 usecs
calling  rtl8152_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver r8152
initcall rtl8152_driver_init+0x0/0x1e returned 0 after 6385 usecs
calling  asix_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver asix
initcall asix_driver_init+0x0/0x1e returned 0 after 6297 usecs
calling  ax88179_178a_driver_init+0x0/0x1e @ 1
usbcore: registered new interface driver ax88179_178a
initcall ax88179_178a_driver_init+0x0/0x1e returned 0 after 7213 usecs
calling  usbnet_init+0x0/0x2f @ 1
initcall usbnet_init+0x0/0x2f returned 0 after 1 usecs
calling  usbport_trig_init+0x0/0x15 @ 1
initcall usbport_trig_init+0x0/0x15 returned 0 after 3 usecs
calling  mon_init+0x0/0x1af @ 1
initcall mon_init+0x0/0x1af returned 0 after 502 usecs
calling  ehci_hcd_init+0x0/0x1a0 @ 1
initcall ehci_hcd_init+0x0/0x1a0 returned 0 after 23 usecs
calling  ehci_pci_init+0x0/0x56 @ 1
initcall ehci_pci_init+0x0/0x56 returned 0 after 192 usecs
calling  ohci_hcd_mod_init+0x0/0xa9 @ 1
initcall ohci_hcd_mod_init+0x0/0xa9 returned 0 after 24 usecs
calling  ohci_pci_init+0x0/0x56 @ 1
initcall ohci_pci_init+0x0/0x56 returned 0 after 77 usecs
calling  uhci_hcd_init+0x0/0x12f @ 1
initcall uhci_hcd_init+0x0/0x12f returned 0 after 176 usecs
calling  xhci_hcd_init+0x0/0x28 @ 1
initcall xhci_hcd_init+0x0/0x28 returned 0 after 51 usecs
calling  xhci_pci_init+0x0/0x5d @ 1
initcall xhci_pci_init+0x0/0x5d returned 0 after 175 usecs
xhci_hcd 0000:00:14.0: xHCI Host Controller
calling  ucsi_acpi_platform_driver_init+0x0/0x17 @ 1
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
initcall ucsi_acpi_platform_driver_init+0x0/0x17 returned 0 after 95 usecs
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
calling  i8042_init+0x0/0x139 @ 1
xhci_hcd 0000:00:14.0: xHCI Host Controller
i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
serio: i8042 KBD port at 0x60,0x64 irq 1
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
serio: i8042 AUX port at 0x60,0x64 irq 12
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.02
initcall i8042_init+0x0/0x139 returned 0 after 41783 usecs
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 6.2.0-rc5-00008-gbe995c36ba22 xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
calling  serport_init+0x0/0x30 @ 1
hub 1-0:1.0: 16 ports detected
initcall serport_init+0x0/0x30 returned 0 after 1 usecs
calling  input_leds_init+0x0/0x15 @ 1
initcall input_leds_init+0x0/0x15 returned 0 after 3 usecs
calling  mousedev_init+0x0/0x63 @ 1
mousedev: PS/2 mouse device common for all mice
initcall mousedev_init+0x0/0x63 returned 0 after 6982 usecs
calling  evdev_init+0x0/0x15 @ 1
initcall evdev_init+0x0/0x15 returned 0 after 1166 usecs
calling  atkbd_init+0x0/0x2a @ 1
initcall atkbd_init+0x0/0x2a returned 0 after 110 usecs
calling  psmouse_init+0x0/0x8a @ 1
initcall psmouse_init+0x0/0x8a returned 0 after 267 usecs
calling  cmos_init+0x0/0x74 @ 1
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: registered as rtc0
rtc_cmos 00:03: setting system clock to 2023-01-31T03:08:56 UTC (1675134536)
rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
initcall cmos_init+0x0/0x74 returned 0 after 30226 usecs
calling  thermal_throttle_init_device+0x0/0x53 @ 1
initcall thermal_throttle_init_device+0x0/0x53 returned 0 after 676 usecs
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.02
calling  esb_driver_init+0x0/0x1e @ 1
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
initcall esb_driver_init+0x0/0x1e returned 0 after 208 usecs
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 6.2.0-rc5-00008-gbe995c36ba22 xhci-hcd
calling  iTCO_wdt_driver_init+0x0/0x17 @ 1
usb usb2: SerialNumber: 0000:00:14.0
initcall iTCO_wdt_driver_init+0x0/0x17 returned 0 after 174 usecs
hub 2-0:1.0: USB hub found
calling  iTCO_vendor_init_module+0x0/0x35 @ 1
iTCO_vendor_support: vendor-support=0
hub 2-0:1.0: 10 ports detected
initcall iTCO_vendor_init_module+0x0/0x35 returned 0 after 12332 usecs
calling  ghes_edac_init+0x0/0xf4 @ 1
initcall ghes_edac_init+0x0/0xf4 returned -19 after 1 usecs
calling  intel_pstate_init+0x0/0x4bc @ 1
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
initcall intel_pstate_init+0x0/0x4bc returned 0 after 62728 usecs
calling  haltpoll_init+0x0/0xf3 @ 1
initcall haltpoll_init+0x0/0xf3 returned -19 after 0 usecs
calling  dmi_sysfs_init+0x0/0x14c @ 1
initcall dmi_sysfs_init+0x0/0x14c returned 0 after 5449 usecs
calling  fw_cfg_sysfs_init+0x0/0x8a @ 1
initcall fw_cfg_sysfs_init+0x0/0x8a returned 0 after 143 usecs
calling  sysfb_init+0x0/0x124 @ 1
initcall sysfb_init+0x0/0x124 returned 0 after 269 usecs
calling  esrt_sysfs_init+0x0/0x446 @ 1
initcall esrt_sysfs_init+0x0/0x446 returned -38 after 0 usecs
calling  efivars_pstore_init+0x0/0x9d @ 1
initcall efivars_pstore_init+0x0/0x9d returned 0 after 0 usecs
calling  hid_init+0x0/0x66 @ 1
hid: raw HID events driver (C) Jiri Kosina
initcall hid_init+0x0/0x66 returned 0 after 6083 usecs
calling  hid_generic_init+0x0/0x1e @ 1
initcall hid_generic_init+0x0/0x1e returned 0 after 161 usecs
calling  magicmouse_driver_init+0x0/0x1e @ 1
initcall magicmouse_driver_init+0x0/0x1e returned 0 after 844 usecs
calling  sensor_hub_driver_init+0x0/0x1e @ 1
initcall sensor_hub_driver_init+0x0/0x1e returned 0 after 855 usecs
calling  hid_init+0x0/0x62 @ 1
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
initcall hid_init+0x0/0x62 returned 0 after 11989 usecs
calling  pmc_atom_init+0x0/0x73 @ 1
initcall pmc_atom_init+0x0/0x73 returned -19 after 14 usecs
calling  sock_diag_init+0x0/0x33 @ 1
initcall sock_diag_init+0x0/0x33 returned 0 after 149 usecs
calling  init_net_drop_monitor+0x0/0x1cd @ 1
drop_monitor: Initializing network drop monitor service
initcall init_net_drop_monitor+0x0/0x1cd returned 0 after 7193 usecs
calling  llc_init+0x0/0x24 @ 1
initcall llc_init+0x0/0x24 returned 0 after 1 usecs
calling  snap_init+0x0/0x3f @ 1
initcall snap_init+0x0/0x3f returned 0 after 62 usecs
calling  blackhole_init+0x0/0x15 @ 1
initcall blackhole_init+0x0/0x15 returned 0 after 1 usecs
calling  ingress_module_init+0x0/0x43 @ 1
initcall ingress_module_init+0x0/0x43 returned 0 after 1 usecs
calling  netem_module_init+0x0/0x21 @ 1
netem: version 1.3
initcall netem_module_init+0x0/0x21 returned 0 after 3890 usecs
calling  fq_codel_module_init+0x0/0x15 @ 1
initcall fq_codel_module_init+0x0/0x15 returned 0 after 1 usecs
calling  init_cgroup_cls+0x0/0x15 @ 1
initcall init_cgroup_cls+0x0/0x15 returned 0 after 73 usecs
calling  xt_init+0x0/0x2df @ 1
initcall xt_init+0x0/0x2df returned 0 after 110 usecs
calling  tcpudp_mt_init+0x0/0x1a @ 1
initcall tcpudp_mt_init+0x0/0x1a returned 0 after 71 usecs
calling  gre_offload_init+0x0/0x52 @ 1
initcall gre_offload_init+0x0/0x52 returned 0 after 0 usecs
calling  sysctl_ipv4_init+0x0/0x50 @ 1
initcall sysctl_ipv4_init+0x0/0x50 returned 0 after 127 usecs
calling  cubictcp_register+0x0/0x72 @ 1
initcall cubictcp_register+0x0/0x72 returned 0 after 1 usecs
calling  xfrm_user_init+0x0/0x34 @ 1
Initializing XFRM netlink socket
initcall xfrm_user_init+0x0/0x34 returned 0 after 5158 usecs
calling  inet6_init+0x0/0x4a8 @ 1
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
initcall inet6_init+0x0/0x4a8 returned 0 after 17603 usecs
calling  packet_init+0x0/0x83 @ 1
NET: Registered PF_PACKET protocol family
initcall packet_init+0x0/0x83 returned 0 after 5888 usecs
calling  strp_dev_init+0x0/0x37 @ 1
initcall strp_dev_init+0x0/0x37 returned 0 after 343 usecs
calling  vlan_proto_init+0x0/0xaa @ 1
8021q: 802.1Q VLAN Support v1.8
initcall vlan_proto_init+0x0/0xaa returned 0 after 5228 usecs
calling  init_p9+0x0/0x2e @ 1
9pnet: Installing 9P2000 support
initcall init_p9+0x0/0x2e returned 0 after 5225 usecs
calling  p9_trans_fd_init+0x0/0x30 @ 1
initcall p9_trans_fd_init+0x0/0x30 returned 0 after 29 usecs
calling  p9_virtio_init+0x0/0x52 @ 1
initcall p9_virtio_init+0x0/0x52 returned 0 after 77 usecs
calling  dcbnl_init+0x0/0x54 @ 1
initcall dcbnl_init+0x0/0x54 returned 0 after 28 usecs
calling  mpls_gso_init+0x0/0x30 @ 1
mpls_gso: MPLS GSO support
initcall mpls_gso_init+0x0/0x30 returned 0 after 4546 usecs
calling  nsh_init_module+0x0/0x18 @ 1
initcall nsh_init_module+0x0/0x18 returned 0 after 0 usecs
calling  pm_check_save_msr+0x0/0x70 @ 1
initcall pm_check_save_msr+0x0/0x70 returned 0 after 102 usecs
calling  plist_test+0x0/0x34b @ 1
start plist test
end plist test
initcall plist_test+0x0/0x34b returned 0 after 8412 usecs
calling  mcheck_init_device+0x0/0x20c @ 1
initcall mcheck_init_device+0x0/0x20c returned 0 after 1865 usecs
calling  dev_mcelog_init_device+0x0/0x171 @ 1
initcall dev_mcelog_init_device+0x0/0x171 returned 0 after 402 usecs
calling  kernel_do_mounts_initrd_sysctls_init+0x0/0x26 @ 1
initcall kernel_do_mounts_initrd_sysctls_init+0x0/0x26 returned 0 after 9 usecs
calling  tboot_late_init+0x0/0x22f @ 1
initcall tboot_late_init+0x0/0x22f returned 0 after 0 usecs
calling  sld_mitigate_sysctl_init+0x0/0x26 @ 1
initcall sld_mitigate_sysctl_init+0x0/0x26 returned 0 after 19 usecs
calling  mcheck_late_init+0x0/0x41 @ 1
initcall mcheck_late_init+0x0/0x41 returned 0 after 44 usecs
calling  severities_debugfs_init+0x0/0x2e @ 1
initcall severities_debugfs_init+0x0/0x2e returned 0 after 90 usecs
calling  microcode_init+0x0/0x246 @ 1
microcode: Microcode Update Driver: v2.2.
initcall microcode_init+0x0/0x246 returned 0 after 542 usecs
calling  resctrl_late_init+0x0/0x6e0 @ 1
initcall resctrl_late_init+0x0/0x6e0 returned -19 after 1 usecs
calling  hpet_insert_resource+0x0/0x27 @ 1
initcall hpet_insert_resource+0x0/0x27 returned 0 after 2 usecs
calling  start_sync_check_timer+0x0/0xb7 @ 1
initcall start_sync_check_timer+0x0/0xb7 returned 0 after 1 usecs
calling  update_mp_table+0x0/0x575 @ 1
initcall update_mp_table+0x0/0x575 returned 0 after 0 usecs
calling  lapic_insert_resource+0x0/0x47 @ 1
initcall lapic_insert_resource+0x0/0x47 returned 0 after 2 usecs
calling  print_ipi_mode+0x0/0x31 @ 1
IPI shorthand broadcast: enabled
initcall print_ipi_mode+0x0/0x31 returned 0 after 5129 usecs
calling  print_ICs+0x0/0x1d7 @ 1
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
000000000000000c000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0002), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(E0), IRR(0), S(0), physical, D(0201), M(2)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin08, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0004), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(2B), IRR(0), S(0), physical, D(0052), M(2)
pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(84), IRR(0), S(0), remapped, I(2140),  Z(2)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0020), M(2)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(02), IRR(0), S(0), physical, D(2103), M(2)
pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2e, disabled, edge , high, V(08), IRR(0), S(0), physical, D(0040), M(2)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(08), IRR(0), S(0), logical , D(0001), M(2)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(08), IRR(0), S(0), physical, D(0800), M(2)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5f, disabled, edge , high, V(40), IRR(0), S(0), physical, D(1508), M(2)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(0011),  Z(2)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0083), M(2)
pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(0100),  Z(2)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
initcall print_ICs+0x0/0x1d7 returned 0 after 1249356 usecs
calling  setup_efi_kvm_sev_migration+0x0/0x28c @ 1
initcall setup_efi_kvm_sev_migration+0x0/0x28c returned 0 after 0 usecs
calling  create_tlb_single_page_flush_ceiling+0x0/0x53 @ 1
initcall create_tlb_single_page_flush_ceiling+0x0/0x53 returned 0 after 63 usecs
calling  pat_memtype_list_init+0x0/0x5c @ 1
initcall pat_memtype_list_init+0x0/0x5c returned 0 after 83 usecs
calling  create_init_pkru_value+0x0/0x58 @ 1
initcall create_init_pkru_value+0x0/0x58 returned 0 after 0 usecs
calling  aesni_init+0x0/0x223 @ 1
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
initcall aesni_init+0x0/0x223 returned 0 after 14650 usecs
calling  kernel_panic_sysctls_init+0x0/0x26 @ 1
initcall kernel_panic_sysctls_init+0x0/0x26 returned 0 after 39 usecs
calling  kernel_panic_sysfs_init+0x0/0x47 @ 1
initcall kernel_panic_sysfs_init+0x0/0x47 returned 0 after 11 usecs
calling  kernel_exit_sysctls_init+0x0/0x26 @ 1
initcall kernel_exit_sysctls_init+0x0/0x26 returned 0 after 9 usecs
calling  kernel_exit_sysfs_init+0x0/0x47 @ 1
initcall kernel_exit_sysfs_init+0x0/0x47 returned 0 after 75 usecs
calling  param_sysfs_builtin_init+0x0/0x96 @ 1
initcall param_sysfs_builtin_init+0x0/0x96 returned 0 after 25549 usecs
calling  reboot_ksysfs_init+0x0/0x94 @ 1
initcall reboot_ksysfs_init+0x0/0x94 returned 0 after 65 usecs
calling  sched_core_sysctl_init+0x0/0x2b @ 1
initcall sched_core_sysctl_init+0x0/0x2b returned 0 after 71 usecs
calling  sched_fair_sysctl_init+0x0/0x26 @ 1
initcall sched_fair_sysctl_init+0x0/0x26 returned 0 after 71 usecs
calling  sched_rt_sysctl_init+0x0/0x26 @ 1
initcall sched_rt_sysctl_init+0x0/0x26 returned 0 after 9 usecs
calling  sched_dl_sysctl_init+0x0/0x26 @ 1
initcall sched_dl_sysctl_init+0x0/0x26 returned 0 after 8 usecs
calling  sched_clock_init_late+0x0/0x138 @ 1
sched_clock: Marking stable (11843352129, 848620974)->(17337722775, -4645749672)
initcall sched_clock_init_late+0x0/0x138 returned 0 after 9551 usecs
calling  sched_init_debug+0x0/0x257 @ 1
initcall sched_init_debug+0x0/0x257 returned 0 after 1325 usecs
calling  kernel_lockdep_sysctls_init+0x0/0x21 @ 1
initcall kernel_lockdep_sysctls_init+0x0/0x21 returned 0 after 73 usecs
calling  cpu_latency_qos_init+0x0/0x3e @ 1
initcall cpu_latency_qos_init+0x0/0x3e returned 0 after 340 usecs
calling  pm_debugfs_init+0x0/0x28 @ 1
initcall pm_debugfs_init+0x0/0x28 returned 0 after 38 usecs
calling  printk_late_init+0x0/0x226 @ 1
initcall printk_late_init+0x0/0x226 returned 0 after 67 usecs
calling  rcu_verify_early_boot_tests+0x0/0x70 @ 1
initcall rcu_verify_early_boot_tests+0x0/0x70 returned 0 after 0 usecs
calling  rcu_tasks_verify_schedule_work+0x0/0x90 @ 1
initcall rcu_tasks_verify_schedule_work+0x0/0x90 returned 0 after 0 usecs
calling  init_srcu_module_notifier+0x0/0x30 @ 1
initcall init_srcu_module_notifier+0x0/0x30 returned 0 after 2 usecs
calling  swiotlb_create_default_debugfs+0x0/0x6c @ 1
initcall swiotlb_create_default_debugfs+0x0/0x6c returned 0 after 113 usecs
calling  tk_debug_sleep_time_init+0x0/0x28 @ 1
initcall tk_debug_sleep_time_init+0x0/0x28 returned 0 after 30 usecs
calling  bpf_ksym_iter_register+0x0/0x1f @ 1
initcall bpf_ksym_iter_register+0x0/0x1f returned 0 after 7 usecs
calling  kernel_acct_sysctls_init+0x0/0x26 @ 1
initcall kernel_acct_sysctls_init+0x0/0x26 returned 0 after 11 usecs
calling  kexec_core_sysctl_init+0x0/0x26 @ 1
initcall kexec_core_sysctl_init+0x0/0x26 returned 0 after 34 usecs
calling  bpf_rstat_kfunc_init+0x0/0x1a @ 1
initcall bpf_rstat_kfunc_init+0x0/0x1a returned 0 after 0 usecs
calling  debugfs_kprobe_init+0x0/0x78 @ 1
initcall debugfs_kprobe_init+0x0/0x78 returned 0 after 94 usecs
calling  kernel_delayacct_sysctls_init+0x0/0x26 @ 1
initcall kernel_delayacct_sysctls_init+0x0/0x26 returned 0 after 9 usecs
calling  taskstats_init+0x0/0x3f @ 1
registered taskstats version 1
initcall taskstats_init+0x0/0x3f returned 0 after 4950 usecs
calling  ftrace_sysctl_init+0x0/0x21 @ 1
initcall ftrace_sysctl_init+0x0/0x21 returned 0 after 8 usecs
calling  init_hwlat_tracer+0x0/0x116 @ 1
initcall init_hwlat_tracer+0x0/0x116 returned 0 after 574 usecs
calling  bpf_key_sig_kfuncs_init+0x0/0x15 @ 1
initcall bpf_key_sig_kfuncs_init+0x0/0x15 returned 0 after 0 usecs
calling  bpf_global_ma_init+0x0/0x23 @ 1
initcall bpf_global_ma_init+0x0/0x23 returned 0 after 282 usecs
calling  bpf_syscall_sysctl_init+0x0/0x26 @ 1
initcall bpf_syscall_sysctl_init+0x0/0x26 returned 0 after 47 usecs
calling  kfunc_init+0x0/0xf8 @ 1
initcall kfunc_init+0x0/0xf8 returned 0 after 0 usecs
calling  bpf_map_iter_init+0x0/0x30 @ 1
initcall bpf_map_iter_init+0x0/0x30 returned 0 after 8 usecs
calling  task_iter_init+0x0/0x2d5 @ 1
initcall task_iter_init+0x0/0x2d5 returned 0 after 11 usecs
calling  bpf_prog_iter_init+0x0/0x1f @ 1
initcall bpf_prog_iter_init+0x0/0x1f returned 0 after 3 usecs
calling  bpf_link_iter_init+0x0/0x1f @ 1
initcall bpf_link_iter_init+0x0/0x1f returned 0 after 4 usecs
calling  init_trampolines+0x0/0x6a @ 1
initcall init_trampolines+0x0/0x6a returned 0 after 1 usecs
calling  bpf_cgroup_iter_init+0x0/0x21 @ 1
initcall bpf_cgroup_iter_init+0x0/0x21 returned 0 after 4 usecs
calling  load_system_certificate_list+0x0/0x55 @ 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 2da4967bb46d1ffcca248f6b516f172950fb85ec'
initcall load_system_certificate_list+0x0/0x55 returned 0 after 17914 usecs
calling  fault_around_debugfs+0x0/0x28 @ 1
initcall fault_around_debugfs+0x0/0x28 returned 0 after 25 usecs
calling  max_swapfiles_check+0x0/0xc @ 1
initcall max_swapfiles_check+0x0/0xc returned 0 after 0 usecs
calling  init_zswap+0x0/0x3ad @ 1
zswap: loaded using pool lzo/zbud
initcall init_zswap+0x0/0x3ad returned 0 after 6508 usecs
calling  hugetlb_vmemmap_init+0x0/0x130 @ 1
initcall hcs
calling  kasan_cpu_quarantine_init+0x0/0x48 @ 1
initcall kasan_cpu_quarantine_init+0x0/0x48 returned 219 after 385 usecs
calling  split_huge_pages_debugfs+0x0/0x28 @ 1
initcall split_huge_pages_debugfs+0x0/0x28 returned 0 after 26 usecs
calling  gup_test_init+0x0/0x28 @ 1
initcall gup_test_init+0x0/0x28 returned 0 after 20 usecs
calling  pageowner_init+0x0/0x38 @ 1
page_owner is disabled
initcall pageowner_init+0x0/0x38 returned 0 after 4244 usecs
calling  check_early_ioremap_leak+0x0/0x89 @ 1
initcall check_early_ioremap_leak+0x0/0x89 returned 0 after 0 usecs
calling  set_hardened_usercopy+0x0/0x24 @ 1
initcall set_hardened_usercopy+0x0/0x24 returned 1 after 0 usecs
calling  fscrypt_init+0x0/0xcd @ 1
Key type .fscrypt registered
Key type fscrypt-provisioning registered
initcall fscrypt_init+0x0/0xcd returned 0 after 11284 usecs
calling  pstore_init+0x0/0x81 @ 1
initcall pstore_init+0x0/0x81 returned 0 after 16 usecs
calling  init_root_keyring+0x0/0x12 @ 1
initcall init_root_keyring+0x0/0x12 returned 0 after 278 usecs
calling  init_trusted+0x0/0x256 @ 1
Freeing initrd memory: 710800K
Key type trusted registered
initcall init_trusted+0x0/0x256 returned 0 after 18505858 usecs
calling  init_encrypted+0x0/0x151 @ 1
Key type encrypted registered
initcall init_encrypted+0x0/0x151 returned 0 after 31348 usecs
calling  integrity_fs_init+0x0/0x52 @ 1
initcall integrity_fs_init+0x0/0x52 returned 0 after 25 usecs
calling  crypto_algapi_init+0x0/0x11 @ 1
initcall crypto_algapi_init+0x0/0x11 returned 0 after 9 usecs
calling  blk_timeout_init+0x0/0x17 @ 1
initcall blk_timeout_init+0x0/0x17 returned 0 after 0 usecs
calling  init_error_injection+0x0/0x6e @ 1
initcall init_error_injection+0x0/0x6e returned 0 after 2747 usecs
calling  pci_resource_alignment_sysfs_init+0x0/0x1c @ 1
initcall pci_resource_alignment_sysfs_init+0x0/0x1c returned 0 after 10 usecs
calling  pci_sysfs_init+0x0/0x72 @ 1
initcall pci_sysfs_init+0x0/0x72 returned 0 after 251 usecs
calling  bert_init+0x0/0x653 @ 1
initcall bert_init+0x0/0x653 returned 0 after 2 usecs
calling  clk_debug_init+0x0/0x13b @ 1
initcall clk_debug_init+0x0/0x13b returned 0 after 124 usecs
calling  dmar_free_unused_resources+0x0/0x194 @ 1
initcall dmar_free_unused_resources+0x0/0x194 returned 0 after 17 usecs
calling  sync_state_resume_initcall+0x0/0x20 @ 1
initcall sync_state_resume_initcall+0x0/0x20 returned 0 after 2 usecs
calling  deferred_probe_initcall+0x0/0xd0 @ 1
initcall deferred_probe_initcall+0x0/0xd0 returned 0 after 303 usecs
calling  sync_debugfs_init+0x0/0x5f @ 1
initcall sync_debugfs_init+0x0/0x5f returned 0 after 61 usecs
calling  firmware_memmap_init+0x0/0x5e @ 1
initcall firmware_memmap_init+0x0/0x5e returned 0 after 549 usecs
calling  register_update_efi_random_seed+0x0/0x22 @ 1
initcall register_update_efi_random_seed+0x0/0x22 returned 0 after 0 usecs
calling  efi_shutdown_init+0x0/0x78 @ 1
initcall efi_shutdown_init+0x0/0x78 returned -19 after 0 usecs
calling  efi_earlycon_unmap_fb+0x0/0x65 @ 1
initcall efi_earlycon_unmap_fb+0x0/0x65 returned 0 after 12 usecs
calling  itmt_legacy_init+0x0/0x4d @ 1
initcall itmt_legacy_init+0x0/0x4d returned -19 after 0 usecs
calling  bpf_sockmap_iter_init+0x0/0x55 @ 1
initcall bpf_sockmap_iter_init+0x0/0x55 returned 0 after 4 usecs
calling  bpf_sk_storage_map_iter_init+0x0/0x55 @ 1
initcall bpf_sk_storage_map_iter_init+0x0/0x55 returned 0 after 5 usecs
calling  sch_default_qdisc+0x0/0x15 @ 1
initcall sch_default_qdisc+0x0/0x15 returned 0 after 2 usecs
calling  bpf_prog_test_run_init+0x0/0xf6 @ 1
initcall bpf_prog_test_run_init+0x0/0xf6 returned 0 after 0 usecs
calling  tcp_congestion_default+0x0/0x1c @ 1
initcall tcp_congestion_default+0x0/0x1c returned 0 after 1 usecs
calling  ip_auto_config+0x0/0x816 @ 1
e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
e1000e 0000:00:1f.6 eth0: 10/100 speed: disabling TSO
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.101
IP-Config: Complete:
device=eth0, hwaddr=3c:52:82:5d:1e:ba, ipaddr=192.168.3.101, mask=255.255.255.0, gw=192.168.3.200
host=lkp-skl-d06, domain=lkp.intel.com, nis-domain=(none)
bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
nameserver0=192.168.3.200
initcall ip_auto_config+0x0/0x816 returned 0 after 1856908 usecs
calling  tcp_bpf_v4_build_proto+0x0/0xef @ 1
initcall tcp_bpf_v4_build_proto+0x0/0xef returned 0 after 0 usecs
calling  udp_bpf_v4_build_proto+0x0/0x9d @ 1
initcall udp_bpf_v4_build_proto+0x0/0x9d returned 0 after 0 usecs
calling  bpf_tcp_ca_kfunc_init+0x0/0x1a @ 1
initcall bpf_tcp_ca_kfunc_init+0x0/0x1a returned 0 after 0 usecs
calling  pci_mmcfg_late_insert_resources+0x0/0xb9 @ 1
initcall pci_mmcfg_late_insert_resources+0x0/0xb9 returned 0 after 2 usecs
calling  software_resume+0x0/0x40 @ 1
initcall software_resume+0x0/0x40 returned -2 after 21 usecs
calling  ftrace_check_sync+0x0/0x18 @ 1
initcall ftrace_check_sync+0x0/0x18 returned 0 after 83 usecs
calling  latency_fsnotify_init+0x0/0x3c @ 1
initcall latency_fsnotify_init+0x0/0x3c returned 0 after 538 usecs
calling  trace_eval_sync+0x0/0x18 @ 1
initcall trace_eval_sync+0x0/0x18 returned 0 after 168 usecs
calling  late_trace_init+0x0/0xa0 @ 1
initcall late_trace_init+0x0/0xa0 returned 0 after 0 usecs
calling  acpi_gpio_handle_deferred_request_irqs+0x0/0xb9 @ 1
initcall acpi_gpio_handle_deferred_request_irqs+0x0/0xb9 returned 0 after 340 usecs
calling  fb_logo_late_init+0x0/0x13 @ 1
initcall fb_logo_late_init+0x0/0x13 returned 0 after 0 usecs
calling  clk_disable_unused+0x0/0x190 @ 1
initcall clk_disable_unused+0x0/0x190 returned 0 after 29 usecs
Freeing unused kernel image (initmem) memory: 3080K
Write protecting the kernel read-only data: 53248k
Freeing unused kernel image (rodata/data gap) memory: 808K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22
branch=linux-review/Ajay-Kaher/eventfs-adding-eventfs-dir-add-functions/20230123-010956
job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6
max_uptime=1200
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
calling  ip_tables_init+0x0/0x1000 [ip_tables] @ 1
initcall ip_tables_init+0x0/0x1000 [ip_tables] returned 0 after 51 usecs


[   35.176417][  T110] calling  fuse_init+0x0/0x16c [fuse] @ 110
Start[   35.192301][  T108] calling  drm_core_init+0x0/0xe3 [drm] @ 108
[   35.209012][  T108] ACPI: bus type drm_connector registered
calling  init_misc_binfmt+0x0/0x1000 [binfmt_misc] @ 133
initcall init_misc_binfmt+0x0/0x1000 [binfmt_misc] returned 0 after 5 usecs
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
calling  acpi_pad_init+0x0/0x1000 [acpi_pad] @ 152
initcall tpm_inf_pnp_driver_init+0x0/0x1000 [tpm_infineon] returned 0 after 8786 usecs
calling  acpi_wmi_init+0x0/0x1000 [wmi] @ 155
up of Temporary [   36.473747][  T147] calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 147

initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
initcall pmc_core_driver_init+0x0/0x1000 [intel_pmc_core] returned 0 after 27773 usecs
acpi PNP0C14:02: duplicate WMI GUID 41227C2D-80E1-423F-8B8E-87E32755A0EB (first instance was on PNP0C14:00)
0m] Listening on[   36.550033][  T155] initcall acpi_wmi_init+0x0/0x1000 [wmi] returned 0 after 68815 usecs
calling  acpi_video_init+0x0/0x1000 [video] @ 155
initcall acpi_video_init+0x0/0x1000 [video] returned 0 after 16 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 156
calling  intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] @ 157
calling  ie31200_init+0x0/0x1000 [ie31200_edac] @ 132
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
calling  mei_init+0x0/0xb7 [mei] @ 150
Startin[   36.645912][  T150] initcall mei_init+0x0/0xb7 [mei] returned 0 after 5411 usecs
EDAC MC0: Giving out device to module ie31200_edac controller IE31200: DEV 0000:00:00.0 (POLLED)
initcall intel_pch_thermal_driver_init+0x0/0x1000 [intel_pch_thermal] returned 0 after 31416 usecs
calling  smbalert_driver_init+0x0/0x1000 [i2c_smbus] @ 147
initcall smbalert_driver_init+0x0/0x1000 [i2c_smbus] returned 0 after 167 usecs
calling  serio_raw_drv_init+0x0/0x1000 [serio_raw] @ 144
calling  mei_me_driver_init+0x0/0x1000 [mei_me] @ 150
calling  i2c_i801_init+0x0/0x1000 [i2c_i801] @ 147
initcall serio_raw_drv_init+0x0/0x1000 [serio_raw] returned 0 after 1594 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 146
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 0 usecs
initcall i2c_i801_init+0x0/0x1000 [i2c_i801] returned 0 after 27212 usecs
calling  ata_init+0x0/0x8a [libata] @ 167
initcall mei_me_driver_init+0x0/0x1000 [mei_me] returned 0 after 35762 usecs
i801_smbus 0000:00:1f.4: SPD Write Disable is set
initcall ie31200_init+0x0/0x1000 [ie31200_edac] returned 0 after 10447 usecs
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
libata version 3.00 loaded.
pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000
initcall ata_init+0x0/0x8a [libata] returned 0 after 36575 usecs
pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
calling  intel_uncore_init+0x0/0x39e [intel_uncore] @ 156
pci 0000:00:1f.1: calling  quirk_igfx_skip_te_disable+0x0/0x120 @ 9
calling  drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] @ 148
pci 0000:00:1f.1: quirk_igfx_skip_te_disable+0x0/0x120 took 0 usecs
initcall drm_display_helper_module_init+0x0/0x1000 [drm_display_helper] returned 0 after 129 usecs
calling  cstate_pmu_init+0x0/0x1000 [intel_cstate] @ 157
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 151
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
Startin[   36.950551][  T157] initcall cstate_pmu_init+0x0/0x1000 [intel_cstate] returned 0 after 20205 usecs
i2c i2c-0: 3/4 memory slots populated (from DMI)
i2c i2c-0: Successfully instantiated SPD at 0x51
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 165
4 Metadata Check[   37.018916][  T131] calling  rapl_pmu_init+0x0/0xf0a [rapl] @ 131
.
i2c i2c-0: Successfully instantiated SPD at 0x53
calling  wmi_bmof_driver_init+0x0/0x1000 [wmi_bmof] @ 155
calling  drm_buddy_module_init+0x0/0x1000 [drm_buddy] @ 148
Startin[   37.084490][  T131] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
OpenIPMI Driver [   37.093459][  T131] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
..
RAPL PMU: hw unit of domain dram 2^-14 Joules
initcall drm_buddy_module_init+0x0/0x1000 [drm_buddy] returned 0 after 45329 usecs
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
initcall rapl_pmu_init+0x0/0xf0a [rapl] returned 0 after 49478 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 163
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
m.
initcall sha512_ssse3_mod_init+0x0/0x1000 [sha512_ssse3] returned 0 after 26 usecs
calling  ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] @ 131
calling  ahci_pci_driver_init+0x0/0x1000 [ahci] @ 167
initcall mei_wdt_driver_init+0x0/0x1000 [mei_wdt] returned 0 after 1485 usecs
initcall ghash_pclmulqdqni_mod_init+0x0/0x1000 [ghash_clmulni_intel] returned 0 after 1933 usecs
ahci 0000:00:17.0: version 3.0
up for ifupdown[   37.264128][  T167] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl RAID mode
ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part ems deso sadm sds apst 
scsi host0: ahci
scsi host1: ahci
scsi host3: ahci
1;39mUser Login [   37.367353][  T167] ata2: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c180 irq 123

ata4: SATA max UDMA/133 abar m2048@0xd104c000 port 0xd104c280 irq 123
initcall crc32c_intel_mod_init+0x0/0x1000 [crc32c_intel] returned 0 after 27657 usecs
calling  ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] @ 202
initcall ahci_pci_driver_init+0x0/0x1000 [ahci] returned 0 after 35235 usecs
IPMI message handler: version 39.2
initcall ipmi_init_msghandler_mod+0x0/0x1000 [ipmi_msghandler] returned 0 after 5838 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 162
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
m.
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: ATA-8: WDC WD10EARS-00Y5B1, 80.00A80, max UDMA/133
Startin[   37.761627][  T190] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 32), AA
ata1.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata1.00: ACPI cmd b1/c1:00:00:00:00:e0(DEVICE CONFIGURATION OVERLAY) filtered out
ata1.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 0A80 PQ: 0 ANSI: 5
1;39mNotify NFS [   37.936785][  T148] calling  i915_init+0x0/0x161 [i915] @ 148
LKP: ttyS0: 249: current_version: f0, target_version: f0
i915 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
LKP: ttyS0: 249: skip deploy intel ucode as ucode is same
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
calling  crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] @ 131
initcall crct10dif_intel_mod_init+0x0/0x1000 [crct10dif_pclmul] returned 0 after 1279 usecs
ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata2.00: ATA-9: INTEL SSDSC2BB012T4, G2010036, max UDMA/133
ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
ata2.00: ACPI cmd f5/00:00:00:00:00:e0(SECURITY FREEZE LOCK) filtered out
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 0036 PQ: 0 ANSI: 5
LKP: ttyS0: 249: Kernel tests: Boot OK!
LKP: ttyS0: 249: HOSTNAME lkp-skl-d06, MAC 3c:52:82:5d:1e:ba, kernel 6.2.0-rc5-00008-gbe995c36ba22 5
ata3: SATA link down (SStatus 4 SControl 300)
i915 0000:00:02.0: [drm] [ENCODER:94:DDI A/PHY A] failed to retrieve link info, disabling eDP
[drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
initcall i915_init+0x0/0x161 [i915] returned 0 after 601673 usecs
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
ata4: SATA link down (SStatus 4 SControl 300)
calling  init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] @ 202
ipmi device interface
initcall init_ipmi_devintf+0x0/0x1000 [ipmi_devintf] returned 0 after 13439 usecs
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
calling  init_ipmi_si+0x0/0x296 [ipmi_si] @ 351
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
initcall init_ipmi_si+0x0/0x296 [ipmi_si] returned -19 after 12845 usecs
calling  init_sg+0x0/0x1000 [sg] @ 132
See 'systemctl status openipmi.s[   39.070002][  T132] scsi 0:0:0:0: Attached scsi generic sg0 type 0
ervice' for details.
scsi 1:0:0:0: Attached scsi generic sg1 type 0
initcall init_sg+0x0/0x1000 [sg] returned 0 after 35087 usecs
calling  kvm_x86_init+0x0/0x11 [kvm] @ 145
initcall kvm_x86_init+0x0/0x11 [kvm] returned 0 after 1 usecs
calling  crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] @ 146
calling  vmx_init+0x0/0x26f [kvm_intel] @ 156
calling  crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] @ 361
initcall crc64_rocksoft_init+0x0/0x1000 [crc64_rocksoft_generic] returned 0 after 28 usecs
initcall vmx_init+0x0/0x26f [kvm_intel] returned 0 after 22839 usecs
calling  coretemp_init+0x0/0x1000 [coretemp] @ 156
initcall crc64_rocksoft_mod_init+0x0/0x1000 [crc64_rocksoft] returned 0 after 42225 usecs
calling  init_sd+0x0/0x1000 [sd_mod] @ 146
initcall coretemp_init+0x0/0x1000 [coretemp] returned 0 after 423 usecs
sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
ata2.00: Enabling discard_zeroes_data
sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 TB/1.09 TiB)
sd 1:0:0:0: [sdb] 4096-byte physical blocks
calling  powerclamp_init+0x0/0x1000 [intel_powerclamp] @ 131
sd 0:0:0:0: [sda] Write Protect is off
initcall powerclamp_init+0x0/0x1000 [intel_powerclamp] returned 0 after 4475 usecs
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
initcall init_sd+0x0/0x1000 [sd_mod] returned 0 after 17988 usecs
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
ata2.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
sdb: sdb1 sdb2
sd 1:0:0:0: [sdb] Attached SCSI disk
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
calling  pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] @ 131
initcall pkg_temp_thermal_init+0x0/0x1000 [x86_pkg_temp_thermal] returned 0 after 32037 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 131
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 1 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 145
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 2 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 131
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 128 usecs
calling  libcrc32c_mod_init+0x0/0x1000 [libcrc32c] @ 388
initcall libcrc32c_mod_init+0x0/0x1000 [libcrc32c] returned 0 after 17 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 145
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 124 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 156
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 2 usecs
calling  rapl_init+0x0/0x1000 [intel_rapl_common] @ 131
initcall rapl_init+0x0/0x1000 [intel_rapl_common] returned 0 after 3794 usecs
calling  init_module+0x0/0x1000 [raid6_pq] @ 388
raid6: avx2x4   gen() 29749 MB/s
raid6: avx2x2   gen() 28122 MB/s
raid6: avx2x1   gen() 22845 MB/s
raid6: using algorithm avx2x4 gen() 29749 MB/s
raid6: .... xor() 10251 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
initcall init_module+0x0/0x1000 [raid6_pq] returned 0 after 99578 usecs
calling  acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] @ 157
calling  calibrate_xor_blocks+0x0/0xeae [xor] @ 388
xor: automatically using best checksumming function   avx       
initcall calibrate_xor_blocks+0x0/0xeae [xor] returned 0 after 3 usecs
initcall acpi_cpufreq_init+0x0/0x1000 [acpi_cpufreq] returned -17 after 2 usecs
calling  blake2b_mod_init+0x0/0x1000 [blake2b_generic] @ 388
initcall blake2b_mod_init+0x0/0x1000 [blake2b_generic] returned 0 after 26 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 156
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 129 usecs
calling  intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] @ 146
intel_rapl_common: Found RAPL domain package
intel_rapl_common: Found RAPL domain core
intel_rapl_common: Found RAPL domain uncore
intel_rapl_common: Found RAPL domain dram
initcall intel_rapl_msr_driver_init+0x0/0x1000 [intel_rapl_msr] returned 0 after 110725 usecs
calling  pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] @ 157
initcall pmc_core_platform_init+0x0/0x1000 [intel_pmc_core_pltdrv] returned -19 after 129 usecs
calling  init_btrfs_fs+0x0/0x1e2 [btrfs] @ 388
Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
initcall init_btrfs_fs+0x0/0x1e2 [btrfs] returned 0 after 13718 usecs
BTRFS: device fsid 620c5088-9233-44b5-b8f3-c0b6df2acb29 devid 1 transid 91 /dev/sdb2 scanned by systemd-udevd (148)
BTRFS: device fsid d55d7a8b-1de5-425d-a4f4-c20d78b40a6b devid 1 transid 19756 /dev/sdb1 scanned by systemd-udevd (132)
BTRFS: device fsid 5386c76c-c4d1-423d-84f3-6165e2069a30 devid 1 transid 83 /dev/sda1 scanned by systemd-udevd (162)
BTRFS: device fsid 4feffc13-1a32-4f06-9d95-cce44c499ac2 devid 1 transid 8 /dev/sda2 scanned by systemd-udevd (169)
lkp: kernel tainted state: 0

LKP: stdout: 249: Kernel tests: Boot OK!

LKP: stdout: 249: HOSTNAME lkp-skl-d06, MAC 3c:52:82:5d:1e:ba, kernel 6.2.0-rc5-00008-gbe995c36ba22 5

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/gcc-12-base_12.2.0-13_amd64.deb

/opt/deb/libgcc-s1_12.2.0-13_amd64.deb

/opt/deb/python3-minimal_3.10.6-3+b1_amd64.deb

/opt/deb/python3_3.10.6-3+b1_amd64.deb

/opt/deb/python3.10_3.10.9-1_amd64.deb

/opt/deb/libpython3.10-stdlib_3.10.9-1_amd64.deb

/opt/deb/python3.10-minimal_3.10.9-1_amd64.deb

/opt/deb/libpython3.10-minimal_3.10.9-1_amd64.deb

/opt/deb/libpython3-stdlib_3.10.6-3+b1_amd64.deb

/opt/deb/openvswitch-common_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/python3-netifaces_0.11.0-2_amd64.deb

/opt/deb/python3-sortedcontainers_2.4.0-2_all.deb

/opt/deb/python3-openvswitch_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/uuid-runtime_2.38.1-4_amd64.deb

/opt/deb/openvswitch-switch_3.1.0~git20221212.739bcf2-3_amd64.deb

/opt/deb/libattr1_1%3a2.5.1-3_amd64.deb

/opt/deb/traceroute_1%3a2.1.1-1_amd64.deb

/opt/deb/attr_1%3a2.5.1-3_amd64.deb

/opt/deb/ebtables_2.0.11-5_amd64.deb

/opt/deb/libatomic1_12.2.0-13_amd64.deb

/opt/deb/libquadmath0_12.2.0-13_amd64.deb

/opt/deb/libgcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/gcc-12_12.2.0-13_amd64.deb

/opt/deb/gcc_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/g++-12_12.2.0-13_amd64.deb

/opt/deb/g++_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/gcc-11-base_11.3.0-8_amd64.deb

/opt/deb/lib32gcc-s1_12.2.0-13_amd64.deb

/opt/deb/libx32gcc-s1_12.2.0-13_amd64.deb

/opt/deb/lib32atomic1_12.2.0-13_amd64.deb

/opt/deb/libx32atomic1_12.2.0-13_amd64.deb

/opt/deb/lib32quadmath0_12.2.0-13_amd64.deb

/opt/deb/libx32quadmath0_12.2.0-13_amd64.deb

/opt/deb/lib32gcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/libx32gcc-12-dev_12.2.0-13_amd64.deb

/opt/deb/gcc-12-multilib_12.2.0-13_amd64.deb

/opt/deb/gcc-multilib_4%3a12.2.0-2+b1_amd64.deb

/opt/deb/libasound2-data_1.2.8-1_all.deb

/opt/deb/libdeflate0_1.14-1_amd64.deb

/opt/deb/libpython3.10_3.10.9-1_amd64.deb

/opt/deb/libwireshark-data_4.0.2-1_all.deb

/opt/deb/python3-pkg-resources_65.5.0-1.1_all.deb

/opt/deb/python3-pygments_2.13.0+dfsg-1_all.deb

/opt/deb/python3-yaml_6.0-3+b1_amd64.deb

/opt/deb/netcat-openbsd_1.219-1_amd64.deb

/opt/deb/python3-roman_3.3-3_all.deb

/opt/deb/python3-docutils_0.17.1+dfsg-3_all.deb

/opt/deb/python3-scapy_2.4.5+g9420c22-2_all.deb

/opt/deb/socat_1.7.4.4-2_amd64.deb

/opt/deb/tcpdump_4.99.2-1_amd64.deb

(Reading database ... 16792 files and directories currently installed.)

Preparing to unpack .../gcc-12-base_12.2.0-13_amd64.deb ...

Unpacking gcc-12-base:amd64 (12.2.0-13) over (12.2.0-9) ...

Preparing to unpack .../libgcc-s1_12.2.0-13_amd64.deb ...

Unpacking libgcc-s1:amd64 (12.2.0-13) over (12.2.0-9) ...

Preparing to unpack .../python3-minimal_3.10.6-3+b1_amd64.deb ...

Unpacking python3-minimal (3.10.6-3+b1) over (3.10.6-1) ...

Preparing to unpack .../python3_3.10.6-3+b1_amd64.deb ...

running python pre-rtupdate hooks for python3.10...

Unpacking python3 (3.10.6-3+b1) over (3.10.6-1) ...

0m] Listening on[   58.202305][  T280] 
aemon activation[   58.214585][  T280] 
Preparing to unpack .../libpython3.10-stdlib_3.10.9-1_amd64.deb ...

Unpacking libpython3.10-stdlib:amd64 (3.10.9-1) over (3.10.8-3) ...

Preparing to unpack .../python3.10-minimal_3.10.9-1_amd64.deb ...

Unpacking python3.10-minimal (3.10.9-1) over (3.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking openvswitch-common (3.1.0~git20221212.739bcf2-3) ...

Selecting previously unselected package python3-netifaces:amd64.

Preparing to unpack .../python3-netifaces_0.11.0-2_amd64.deb ...

Unpacking python3-netifaces:amd64 (0.11.0-2) ...

Selecting previously unselected package python3-sortedcontainers.

Preparing to unpack .../python3-sortedcontainers_2.4.0-2_all.deb ...

Unpacking python3-sortedcontainers (2.4.0-2) ...

Selecting previously unselected package python3-openvswitch.

Preparing to unpack .../python3-openvswitch_3.1.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking python3-openvswitch (3.1.0~git20221212.739bcf2-3) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.38.1-4_amd64.deb ...

Unpacking uuid-runtime (2.38.1-4) ...

Selecting previously unselected package openvswitch-switch.

Preparing to unpack .../openvswitch-switch_3.1.0~git20221212.739bcf2-3_amd64.deb ...

Unpacking openvswitch-switch (3.1.0~git20221212.739bcf2-3) ...

Preparing to unpack .../libattr1_1%3a2.5.1-3_amd64.deb ...

Unpacking libattr1:amd64 (1:2.5.1-3) over (1:2.5.1-1) ...

Selecting previously unselected package traceroute.

Preparing to unpack .../traceroute_1%3a2.1.1-1_amd64.deb ...

Unpacking traceroute (1:2.1.1-1) ...

Selecting previously unselected package attr.

Preparing to unpack .../deb/attr_1%3a2.5.1-3_amd64.deb ...

Unpacking attr (1:2.5.1-3) ...

Selecting previously unselected package ebtables.

Preparing to unpack .../ebtables_2.0.11-5_amd64.deb ...

Unpacking ebtables (2.0.11-5) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_12.2.0-13_amd64.deb ...

Unpacking libatomic1:amd64 (12.2.0-13) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_12.2.0-13_amd64.deb ...

Unpacking libquadmath0:amd64 (12.2.0-13) ...

Selecting previously unselected package libgcc-12-dev:amd64.

Preparing to unpack .../libgcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking libgcc-12-dev:amd64 (12.2.0-13) ...

Selecting previously unselected package gcc-12.

Preparing to unpack .../deb/gcc-12_12.2.0-13_amd64.deb ...

Unpacking gcc-12 (12.2.0-13) ...

Selecting previously unselected package gcc.

Preparing to unpack .../gcc_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking gcc (4:12.2.0-2+b1) ...

Selecting previously unselected package g++-12.

Preparing to unpack .../deb/g++-12_12.2.0-13_amd64.deb ...

Unpacking g++-12 (12.2.0-13) ...

Selecting previously unselected package g++.

Preparing to unpack .../g++_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking g++ (4:12.2.0-2+b1) ...

Selecting previously unselected package gcc-11-base:amd64.

Preparing to unpack .../gcc-11-base_11.3.0-8_amd64.deb ...

Unpacking gcc-11-base:amd64 (11.3.0-8) ...

Selecting previously unselected package lib32gcc-s1.

Preparing to unpack .../lib32gcc-s1_12.2.0-13_amd64.deb ...

Unpacking lib32gcc-s1 (12.2.0-13) ...

Selecting previously unselected package libx32gcc-s1.

Preparing to unpack .../libx32gcc-s1_12.2.0-13_amd64.deb ...

Unpacking libx32gcc-s1 (12.2.0-13) ...

Selecting previously unselected package lib32atomic1.

Preparing to unpack .../lib32atomic1_12.2.0-13_amd64.deb ...

Unpacking lib32atomic1 (12.2.0-13) ...

Selecting previously unselected package libx32atomic1.

Preparing to unpack .../libx32atomic1_12.2.0-13_amd64.deb ...

Unpacking libx32atomic1 (12.2.0-13) ...

Selecting previously unselected package lib32quadmath0.

Preparing to unpack .../lib32quadmath0_12.2.0-13_amd64.deb ...

Unpacking lib32quadmath0 (12.2.0-13) ...

Selecting previously unselected package libx32quadmath0.

Preparing to unpack .../libx32quadmath0_12.2.0-13_amd64.deb ...

Unpacking libx32quadmath0 (12.2.0-13) ...

Selecting previously unselected package lib32gcc-12-dev.

Preparing to unpack .../lib32gcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking lib32gcc-12-dev (12.2.0-13) ...

Selecting previously unselected package libx32gcc-12-dev.

Preparing to unpack .../libx32gcc-12-dev_12.2.0-13_amd64.deb ...

Unpacking libx32gcc-12-dev (12.2.0-13) ...

Selecting previously unselected package gcc-12-multilib.

Preparing to unpack .../gcc-12-multilib_12.2.0-13_amd64.deb ...

Unpacking gcc-12-multilib (12.2.0-13) ...

Selecting previously unselected package gcc-multilib.

Preparing to unpack .../gcc-multilib_4%3a12.2.0-2+b1_amd64.deb ...

Unpacking gcc-multilib (4:12.2.0-2+b1) ...

Selecting previously unselected package libasound2-data.

Preparing to unpack .../libasound2-data_1.2.8-1_all.deb ...

Unpacking libasound2-data (1.2.8-1) ...

Selecting previously unselected package libdeflate0:amd64.

Preparing to unpack .../libdeflate0_1.14-1_amd64.deb ...

Unpacking libdeflate0:amd64 (1.14-1) ...

Selecting previously unselected package libpython3.10:amd64.

Preparing to unpack .../libpython3.10_3.10.9-1_amd64.deb ...

Unpacking libpython3.10:amd64 (3.10.9-1) ...

Selecting previously unselected package libwireshark-data.

Preparing to unpack .../libwireshark-data_4.0.2-1_all.deb ...

Unpacking libwireshark-data (4.0.2-1) ...

Selecting previously unselected package python3-pkg-resources.

Preparing to unpack .../python3-pkg-resources_65.5.0-1.1_all.deb ...

Unpacking python3-pkg-resources (65.5.0-1.1) ...

Selecting previously unselected package python3-pygments.

Preparing to unpack .../python3-pygments_2.13.0+dfsg-1_all.deb ...

Unpacking python3-pygments (2.13.0+dfsg-1) ...

Selecting previously unselected package python3-yaml.

Preparing to unpack .../python3-yaml_6.0-3+b1_amd64.deb ...

Unpacking python3-yaml (6.0-3+b1) ...

Selecting previously unselected package netcat-openbsd.

Preparing to unpack .../netcat-openbsd_1.219-1_amd64.deb ...

Unpacking netcat-openbsd (1.219-1) ...

Selecting previously unselected package python3-roman.

Preparing to unpack .../python3-roman_3.3-3_all.deb ...

Unpacking python3-roman (3.3-3) ...

Selecting previously unselected package python3-docutils.

Preparing to unpack .../python3-docutils_0.17.1+dfsg-3_all.deb ...

Unpacking python3-docutils (0.17.1+dfsg-3) ...

Selecting previously unselected package python3-scapy.

Preparing to unpack .../python3-scapy_2.4.5+g9420c22-2_all.deb ...

Unpacking python3-scapy (2.4.5+g9420c22-2) ...

Selecting previously unselected package socat.

Preparing to unpack .../deb/socat_1.7.4.4-2_amd64.deb ...

Unpacking socat (1.7.4.4-2) ...

Selecting previously unselected package tcpdump.

Preparing to unpack .../deb/tcpdump_4.99.2-1_amd64.deb ...

Unpacking tcpdump (4.99.2-1) ...

Setting up gcc-12-base:amd64 (12.2.0-13) ...

Setting up libgcc-s1:amd64 (12.2.0-13) ...

Setting up libpython3.10-minimal:amd64 (3.10.9-1) ...

Setting up libattr1:amd64 (1:2.5.1-3) ...

Setting up traceroute (1:2.1.1-1) ...

update-alternatives: using /usr/bin/traceroute.db to provide /usr/bin/traceroute (traceroute) in auto mode

update-alternatives: using /usr/bin/traceroute6.db to provide /usr/bin/traceroute6 (traceroute6) in auto mode

update-alternatives: using /usr/bin/lft.db to provide /usr/bin/lft (lft) in auto mode

update-alternatives: using /usr/bin/traceproto.db to provide /usr/bin/traceproto (traceproto) in auto mode

update-alternatives: using /usr/sbin/tcptraceroute.db to provide /usr/sbin/tcptraceroute (tcptraceroute) in auto mode

Setting up attr (1:2.5.1-3) ...

Setting up ebtables (2.0.11-5) ...

update-alternatives: using /usr/sbin/ebtables-legacy to provide /usr/sbin/ebtables (ebtables) in auto mode

Setting up libatomic1:amd64 (12.2.0-13) ...

Setting up libquadmath0:amd64 (12.2.0-13) ...

Setting up gcc-11-base:amd64 (11.3.0-8) ...

Setting up libasound2-data (1.2.8-1) ...

Setting up libdeflate0:amd64 (1.14-1) ...

Setting up libwireshark-data (4.0.2-1) ...

Setting up netcat-openbsd (1.219-1) ...

update-alternatives: using /bin/nc.openbsd to provide /bin/nc (nc) in auto mode

Setting up socat (1.7.4.4-2) ...

Setting up libpython3.10-stdlib:amd64 (3.10.9-1) ...

Setting up python3.10-minimal (3.10.9-1) ...

Setting up libpython3-stdlib:amd64 (3.10.6-3+b1) ...

Setting up libpython3.10:amd64 (3.10.9-1) ...

Setting up python3-minimal (3.10.6-3+b1) ...

Setting up python3.10 (3.10.9-1) ...

Setting up python3 (3.10.6-3+b1) ...

running python rtupdate hooks for python3.10...

Setting up uuid-runtime (2.38.1-4) ...

Adding group `uuidd' (GID 109) ...

Done.

Setting up openvswitch-switch (3.1.0~git20221212.739bcf2-3) ...

calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] @ 1150
initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv4] returned 0 after 1 usecs
calling  nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] @ 1150
initcall nf_defrag_init+0x0/0x1000 [nf_defrag_ipv6] returned 0 after 544 usecs
calling  nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] @ 1150
initcall nf_conntrack_standalone_init+0x0/0x1000 [nf_conntrack] returned 0 after 1406 usecs
calling  nf_nat_init+0x0/0x1000 [nf_nat] @ 1150
initcall nf_nat_init+0x0/0x1000 [nf_nat] returned 0 after 327 usecs
calling  nf_conncount_modinit+0x0/0x1000 [nf_conncount] @ 1150
initcall nf_conncount_modinit+0x0/0x1000 [nf_conncount] returned 0 after 638 usecs
calling  dp_init+0x0/0x192 [openvswitch] @ 1150
openvswitch: Open vSwitch switching datapath
initcall dp_init+0x0/0x192 [openvswitch] returned 0 after 8611 usecs
update-alternatives: using /usr/lib/openvswitch-switch/ovs-vswitchd to provide /usr/sbin/ovs-vswitchd (ovs-vswitchd) in auto mode

Setting up libgcc-12-dev:amd64 (12.2.0-13) ...

Setting up gcc-12 (12.2.0-13) ...

Setting up gcc (4:12.2.0-2+b1) ...

Setting up g++-12 (12.2.0-13) ...

Setting up g++ (4:12.2.0-2+b1) ...

update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in auto mode

Setting up lib32gcc-s1 (12.2.0-13) ...

Setting up libx32gcc-s1 (12.2.0-13) ...

Setting up lib32atomic1 (12.2.0-13) ...

Setting up libx32atomic1 (12.2.0-13) ...

Setting up lib32quadmath0 (12.2.0-13) ...

Setting up libx32quadmath0 (12.2.0-13) ...

Setting up lib32gcc-12-dev (12.2.0-13) ...

Setting up libx32gcc-12-dev (12.2.0-13) ...

Setting up gcc-12-multilib (12.2.0-13) ...

Setting up gcc-multilib (4:12.2.0-2+b1) ...

Setting up python3-pkg-resources (65.5.0-1.1) ...

Setting up python3-pygments (2.13.0+dfsg-1) ...

Setting up python3-yaml (6.0-3+b1) ...

Setting up python3-roman (3.3-3) ...

Setting up python3-docutils (0.17.1+dfsg-3) ...

Setting up python3-scapy (2.4.5+g9420c22-2) ...

Setting up tcpdump (4.99.2-1) ...

Setting up openvswitch-common (3.1.0~git20221212.739bcf2-3) ...

Setting up python3-netifaces:amd64 (0.11.0-2) ...

Setting up python3-sortedcontainers (2.4.0-2) ...

Setting up python3-openvswitch (3.1.0~git20221212.739bcf2-3) ...

Processing triggers for libc-bin (2.36-5) ...

Processing triggers for systemd (252.1-1) ...

dpkg: regarding .../python3_3.10.6-3+b1_amd64.deb containing python3, pre-dependency problem:

python3 pre-depends on python3-minimal (= 3.10.6-3+b1)

python3-minimal latest configured version is 3.10.6-1.



dpkg: warning: ignoring pre-dependency problem!

dpkg-query: package 'linux-perf' is not installed

Use dpkg --contents (= dpkg-deb --contents) to list archive files contents.

Traceback (most recent call last):

File "/usr/bin/py3clean", line 210, in <module>

main()

File "/usr/bin/py3clean", line 196, in main

pfiles = set(dpf.from_package(options.package))

File "/usr/share/python3/debpython/files.py", line 53, in from_package

raise Exception("cannot get content of %s" % package_name)

Exception: cannot get content of linux-perf

error running python rtupdate hook linux-perf

dpkg: error processing package python3 (--install):

installed python3 package post-installation script subprocess returned error exit status 4

dpkg: uuid-runtime: dependency problems, but configuring anyway as you requested:

uuid-runtime depends on libuuid1 (>= 2.38.1-2~); however:

Version of libuuid1:amd64 on system is 2.38.1-1.1+b1.




uuidd.service is a disabled or a static unit, not starting it.

dpkg: openvswitch-switch: dependency problems, but configuring anyway as you requested:

openvswitch-switch depends on openvswitch-common (= 3.1.0~git20221212.739bcf2-3).

openvswitch-switch depends on python3-netifaces.

openvswitch-switch depends on python3-openvswitch (>= 3.1.0~git20221212.739bcf2-3).

openvswitch-switch depends on python3:any; however:

Package python3 is not configured yet.

openvswitch-switch depends on libnuma1 (>= 2.0.11); however:

Package libnuma1 is not installed.

openvswitch-switch depends on libunbound8 (>= 1.8.0); however:

Package libunbound8 is not installed.

openvswitch-switch depends on libxdp1 (>= 1.2.9~); however:

Package libxdp1 is not installed.



BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
BTRFS info (device sdb1): using free space tree
BTRFS info (device sdb1): enabling ssd optimizations
BTRFS info (device sdb1): auto enabling async discard
LKP: ttyS0: 249:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml


dpkg: libgcc-12-dev:amd64: dependency problems, but configuring anyway as you requested:

libgcc-12-dev:amd64 depends on libgomp1 (>= 12.2.0-13); however:

Package libgomp1 is not installed.

libgcc-12-dev:amd64 depends on libitm1 (>= 12.2.0-13); however:

Package libitm1 is not installed.

libgcc-12-dev:amd64 depends on libasan8 (>= 12.2.0-13); however:

Package libasan8 is not installed.

libgcc-12-dev:amd64 depends on liblsan0 (>= 12.2.0-13); however:

Package liblsan0 is not installed.

libgcc-12-dev:amd64 depends on libtsan2 (>= 12.2.0-13); however:

Package libtsan2 is not installed.

libgcc-12-dev:amd64 depends on libubsan1 (>= 12.2.0-13); however:

Package libubsan1 is not installed.



dpkg: gcc-12: dependency problems, but configuring anyway as you requested:

gcc-12 depends on cpp-12 (= 12.2.0-13); however:

Package cpp-12 is not installed.

gcc-12 depends on libcc1-0 (>= 12.2.0-13); however:

Package libcc1-0 is not installed.

gcc-12 depends on binutils (>= 2.39.90.20221231); however:

Package binutils is not installed.

gcc-12 depends on libisl23 (>= 0.15); however:

Package libisl23 is not installed.

gcc-12 depends on libmpc3 (>= 1.1.0); however:

Package libmpc3 is not installed.

gcc-12 depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.



dpkg: gcc: dependency problems, but configuring anyway as you requested:

gcc depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.



dpkg: g++-12: dependency problems, but configuring anyway as you requested:

g++-12 depends on libstdc++-12-dev (= 12.2.0-13); however:

Package libstdc++-12-dev is not installed.

g++-12 depends on libisl23 (>= 0.15); however:

Package libisl23 is not installed.

g++-12 depends on libmpc3 (>= 1.1.0); however:

Package libmpc3 is not installed.

g++-12 depends on libmpfr6 (>= 3.1.3); however:

Package libmpfr6 is not installed.



dpkg: g++: dependency problems, but configuring anyway as you requested:

g++ depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.



dpkg: lib32gcc-s1: dependency problems, but configuring anyway as you requested:

lib32gcc-s1 depends on libc6-i386 (>= 2.35); however:

Package libc6-i386 is not installed.



dpkg: libx32gcc-s1: dependency problems, but configuring anyway as you requested:

libx32gcc-s1 depends on libc6-x32 (>= 2.35); however:

Package libc6-x32 is not installed.



dpkg: lib32atomic1: dependency problems, but configuring anyway as you requested:

lib32atomic1 depends on libc6-i386 (>= 2.1.3); however:

Package libc6-i386 is not installed.



dpkg: libx32atomic1: dependency problems, but configuring anyway as you requested:

libx32atomic1 depends on libc6-x32 (>= 2.16); however:

Package libc6-x32 is not installed.



dpkg: lib32quadmath0: dependency problems, but configuring anyway as you requested:

lib32quadmath0 depends on libc6-i386 (>= 2.23); however:

Package libc6-i386 is not installed.



dpkg: libx32quadmath0: dependency problems, but configuring anyway as you requested:

libx32quadmath0 depends on libc6-x32 (>= 2.23); however:

Package libc6-x32 is not installed.



dpkg: lib32gcc-12-dev: dependency problems, but configuring anyway as you requested:

lib32gcc-12-dev depends on lib32gomp1 (>= 12.2.0-13); however:

Package lib32gomp1 is not installed.

lib32gcc-12-dev depends on libx32gomp1 (>= 12.2.0-13); however:

Package libx32gomp1 is not installed.

lib32gcc-12-dev depends on lib32itm1 (>= 12.2.0-13); however:

Package lib32itm1 is not installed.

lib32gcc-12-dev depends on libx32itm1 (>= 12.2.0-13); however:

Package libx32itm1 is not installed.

lib32gcc-12-dev depends on lib32asan8 (>= 12.2.0-13); however:

Package lib32asan8 is not installed.

lib32gcc-12-dev depends on libx32asan8 (>= 12.2.0-13); however:

Package libx32asan8 is not installed.

lib32gcc-12-dev depends on lib32ubsan1 (>= 12.2.0-13); however:

Package lib32ubsan1 is not installed.

lib32gcc-12-dev depends on libx32ubsan1 (>= 12.2.0-13); however:

Package libx32ubsan1 is not installed.



dpkg: libx32gcc-12-dev: dependency problems, but configuring anyway as you requested:

libx32gcc-12-dev depends on lib32gomp1 (>= 12.2.0-13); however:

Package lib32gomp1 is not installed.

libx32gcc-12-dev depends on libx32gomp1 (>= 12.2.0-13); however:

Package libx32gomp1 is not installed.

libx32gcc-12-dev depends on lib32itm1 (>= 12.2.0-13); however:

Package lib32itm1 is not installed.

libx32gcc-12-dev depends on libx32itm1 (>= 12.2.0-13); however:

Package libx32itm1 is not installed.

libx32gcc-12-dev depends on lib32asan8 (>= 12.2.0-13); however:

Package lib32asan8 is not installed.

libx32gcc-12-dev depends on libx32asan8 (>= 12.2.0-13); however:

Package libx32asan8 is not installed.

libx32gcc-12-dev depends on lib32ubsan1 (>= 12.2.0-13); however:

Package lib32ubsan1 is not installed.

libx32gcc-12-dev depends on libx32ubsan1 (>= 12.2.0-13); however:

Package libx32ubsan1 is not installed.



dpkg: gcc-12-multilib: dependency problems, but configuring anyway as you requested:

gcc-12-multilib depends on libc6-dev-i386 (>= 2.23-1~); however:

Package libc6-dev-i386 is not installed.

LKP: ttyS0: 1397: current_versio[   71.751707][  T280]  gcc-12-multilib depends on libc6-dev-x32 (>= 2.23-1~); however:
n: f0, target_ve[   71.751732][  T280] 
rsion: f0
Package libc6-dev-x32 is not installed.



dpkg: gcc-multilib: dependency problems, but configuring anyway as you requested:

gcc-multilib depends on cpp (= 4:12.2.0-2+b1); however:

Package cpp is not installed.

gcc-multilib depends on linux-libc-dev (>= 3.0.0-2); however:

Package linux-libc-dev is not installed.



dpkg: python3-pkg-resources: dependency problems, but configuring anyway as you requested:

python3-pkg-resources depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-pygments: dependency problems, but configuring anyway as you requested:

python3-pygments depends on python3:any; however:

Package python3 is not configured yet.



dpkg: python3-yaml: dependency problems, but configuring anyway as you requested:

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back
python3-yaml depends on python3 (<< 3.12); however:

Package python3 is not configured yet.

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
python3-yaml depends on python3 (>= 3.10~); however:

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
python3-yaml depends on python3:any; however:

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

python3-yaml depends on libyaml-0-2 (>= 0.2.2~); however:

Package libyaml-0-2 is not installed.

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
dpkg: python3-roman: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
python3-roman depends on python3:any; however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
dpkg: python3-docutils: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
python3-docutils depends on docutils-common (= 0.17.1+dfsg-3); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
Package docutils-common is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
python3-docutils depends on python3:any; however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back


x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
dpkg: python3-scapy: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
python3-scapy depends on python3:any; however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back


x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

dpkg: tcpdump: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
tcpdump depends on libpcap0.8 (>= 1.9.0); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Package libpcap0.8 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
dpkg: openvswitch-common: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
openvswitch-common depends on python3:any; however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
openvswitch-common depends on libnuma1 (>= 2.0.11); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

Package libnuma1 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
openvswitch-common depends on libunbound8 (>= 1.8.0); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
Package libunbound8 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
openvswitch-common depends on libxdp1 (>= 1.2.9~); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
Package libxdp1 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
dpkg: python3-netifaces:amd64: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
python3-netifaces:amd64 depends on python3 (<< 3.12); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
python3-netifaces:amd64 depends on python3 (>= 3.10~); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000ncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
dpkg: python3-openvswitch: dependency problems, but configuring anyway as you requested:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
python3-openvswitch depends on python3 (<< 3.12); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
python3-openvswitch depends on python3 (>= 3.10~); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
python3-openvswitch depends on python3:any; however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
Package python3 is not configured yet.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
python3-openvswitch depends on libnuma1 (>= 2.0.11); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3a22000-0xb3a22fff], got write-back

Package libnuma1 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
python3-openvswitch depends on libunbound8 (>= 1.8.0); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
Package libunbound8 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
python3-openvswitch depends on libxdp1 (>= 1.2.9~); however:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
Package libxdp1 is not installed.
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
Errors were encountered while processing:
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
python3
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
handle /opt/deb/keep-deb.kernel-selftests...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/gcc-12-base_12.2.0-13_amd64.deb
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back
Preparing to unpack .../gcc-12-base_12.2.0-13_amd64.deb ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back
Unpacking gcc-12-base:amd64 (12.2.0-13) over (12.2.0-13) ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
Setting up gcc-12-base:amd64 (12.2.0-13) ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/libgcc-s1_12.2.0-13_amd64.deb
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
Preparing to unpack .../libgcc-s1_12.2.0-13_amd64.deb ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

Unpacking libgcc-s1:amd64 (12.2.0-13) over (12.2.0-13) ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back
Setting up libgcc-s1:amd64 (12.2.0-13) ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef1000-0xb3ef1fff], got write-back
Processing triggers for libc-bin (2.36-5) ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efc000-0xb3efcfff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efb000-0xb3efbfff], got write-back
install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3-minimal_3.10.6-3+b1_amd64.deb
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3efa000-0xb3efafff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3e6a000-0xb3e6afff], got write-back
(Reading database ... 18838 files and directories currently installed.)
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef4000-0xb3ef4fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef3000-0xb3ef3fff], got write-back
Preparing to unpack .../python3-minimal_3.10.6-3+b1_amd64.deb ...
x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef2000-0xb3ef2fff], got write-back

x86/PAT: bmc-watchdog:1462 map pfn expected mapping type uncached-minus for [mem 0xb3ef0000-0xb3ef0fff], got write-back
Unpacking python3-minimal (3.10.6-3+b1) over (3.10.6-3+b1) ...

Setting up python3-minimal (3.10.6-3+b1) ...

install debs round two: dpkg -i --force-confdef --force-depends /opt/deb/python3_3.10.6-3+b1_amd64.deb

(Reading database ... 18838 files and directories currently installed.)

Preparing to unpack .../python3_3.10.6-3+b1_amd64.deb ...

running python pre-rtupdate hooks for python3.10...

Unpacking python3 (3.10.6-3+b1) over (3.10.6-3+b1) ...

Setting up python3 (3.10.6-3+b1) ...

running python rtupdate hooks for python3.10...

dpkg-query: package 'linux-perf' is not installed

Use dpkg --contents (= dpkg-deb --contents) to list archive files contents.

Traceback (most recent call last):

File "/usr/bin/py3clean", line 210, in <module>

main()

File "/usr/bin/py3clean", line 196, in main

pfiles = set(dpf.from_package(options.package))

File "/usr/share/python3/debpython/files.py", line 53, in from_package

raise Exception("cannot get content of %s" % package_name)

Exception: cannot get content of linux-perf

error running python rtupdate hook linux-perf

dpkg: error processing package python3 (--install):

installed python3 package post-installation script subprocess returned error exit status 4

Errors were encountered while processing:

python3

error: dpkg -i /opt/deb/python3_3.10.6-3+b1_amd64.deb failed.

LKP: stdout: 249:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml

RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2

job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/2, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-6836-ryqkte-4.yaml&job_state=running -O /dev/null

target ucode: 0xf0

LKP: stdout: 1397: current_version: f0, target_version: f0

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-be995c36ba2232edcd4fa64e4581b9a6763c75e6

2023-01-31 03:09:59 ln -sf /usr/bin/clang

2023-01-31 03:09:59 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables

2023-01-31 03:09:59 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables

2023-01-31 03:09:59 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh

LKP WARN miss config CONFIG_PREEMPT_TRACER= of ftrace/config

2023-01-31 03:10:00 make -C ftrace

make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-be995c36ba2232edcd4fa64e4581b9a6763c75e6/tools/testing/selftests/ftrace'

make: Nothing to be done for 'all'.

make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-be995c36ba2232edcd4fa64e4581b9a6763c75e6/tools/testing/selftests/ftrace'

2023-01-31 03:10:00 make quicktest=1 run_tests -C ftrace

make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-be995c36ba2232edcd4fa64e4581b9a6763c75e6/tools/testing/selftests/ftrace'

TAP version 13

1..1

# selftests: ftrace: ftracetest

# === Ftrace unit tests ===

# [1] Basic trace file check	[PASS]

# [2] Basic test for tracersIPMI BMC is not supported on this machine, skip bmc-watchdog setup!

	[PASS]

# [3] Basic trace clock test	[PASS]

# [4] Basic event tracing check	[PASS]

# [5] Change the ringbuffer size	[PASS]

# [6] Snapshot and tracing setting	[PASS]

# [7] trace_pipe and trace_marker	[PASS]


**********************************************************
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**                                                      **
** trace_printk() being used. Allocating extra memory.  **
**                                                      **
** This means that this is a DEBUG kernel and it is     **
** unsafe for production use.                           **
**                                                      **
** If you see this message and you are not debugging    **
** the kernel, report this immediately to your vendor!  **
**                                                      **
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**********************************************************
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1937
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10292 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1947
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 7943 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1956
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9819 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1958
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10218 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1964
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9984 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1976
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 119423 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 1994
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 143189 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2000
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10832 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2015
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11111 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2030
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10042 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2035
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10762 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2040
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11156 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2045
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11279 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2053
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9644 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2058
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10897 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2060
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9228 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2065
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9886 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2073
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10141 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2078
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11047 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2080
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10123 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2085
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9937 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2090
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11485 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2095
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10954 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2100
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11564 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2108
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10377 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2113
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 16275 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2118
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 16669 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2123
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10338 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2128
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11046 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct_too] @ 2135
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct_too] returned 0 after 14803 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2138
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4312 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2144
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4316 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2146
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4344 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2152
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4314 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2167
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9658 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2182
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9346 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2191
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4336 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2203
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4179 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2221
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4534 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2226
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4738 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2231
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4188 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2236
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4295 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2241
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4703 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2246
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4574 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2248
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4264 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2253
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4441 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2261
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 5482 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2266
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4625 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2268
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4290 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2276
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4212 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2283
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 5359 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2286
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 5304 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2291
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4301 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2296
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4356 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2301
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 5986 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2306
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 7875 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2311
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4320 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2316
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4269 usecs
# [8] Test ftrace direct functions against tracers	[PASS]

calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2360
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10757 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2372
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10378 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2384
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 9451 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2391
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 10498 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2403
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 11114 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct_too] @ 2415
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct_too] returned 0 after 9935 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2427
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4262 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2439
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4266 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2446
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4246 usecs
calling  ftrace_direct_init+0x0/0x1000 [ftrace_direct] @ 2458
initcall ftrace_direct_init+0x0/0x1000 [ftrace_direct] returned 0 after 4352 usecs
# [9] Test ftrace direct functions against kprobes	[PASS]

==================================================================
BUG: KASAN: use-after-free in dcache_dir_open_wrapper+0x68f/0x770
Read of size 8 at addr ffff8881bf289000 by task ftracetest/2485

CPU: 1 PID: 2485 Comm: ftracetest Not tainted 6.2.0-rc5-00008-gbe995c36ba22 #5
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
Call Trace:
<TASK>
dump_stack_lvl+0x49/0x5d
print_address_description+0x87/0x2a1
print_report+0x103/0x1e9
? kasan_addr_to_slab+0xd/0xa0
? dcache_dir_open_wrapper+0x68f/0x770
kasan_report+0xbf/0x1a0
? dcache_dir_open_wrapper+0x68f/0x770
dcache_dir_open_wrapper+0x68f/0x770
? fsnotify_perm+0x13b/0x4a0
do_dentry_open+0x449/0x1020
? eventfs_create_dir+0x400/0x400
? may_open+0xde/0x300
do_open+0x748/0xf60
path_openat+0x255/0x620
? do_open+0xf60/0xf60
? __lock_acquire+0xafe/0x17f0
do_filp_open+0x1b5/0x3e0
? may_open_dev+0xd0/0xd0
? alloc_fd+0x1e2/0x5c0
? do_raw_spin_lock+0x132/0x270
? lock_is_held_type+0x9c/0x110
? alloc_fd+0x1e2/0x5c0
? _raw_spin_unlock+0x23/0x30
? alloc_fd+0x1e2/0x5c0
? getname_flags+0x8e/0x450
do_sys_openat2+0x122/0x400
? lock_is_held_type+0x9c/0x110
? build_open_flags+0x450/0x450
? __might_fault+0xc0/0x160
? lock_release+0xe3/0x250
? rseq_ip_fixup+0x2d7/0x490
__x64_sys_openat+0x123/0x1e0
? __x64_sys_open+0x1a0/0x1a0
? lockdep_hardirqs_on_prepare+0x19a/0x350
? syscall_enter_from_user_mode+0x25/0x90
? trace_hardirqs_on+0x40/0x140
do_syscall_64+0x5a/0x80
? syscall_exit_to_user_mode+0x22/0x50
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? do_user_addr_fault+0x35c/0xc70
? irqentry_exit_to_user_mode+0xe/0x40
? lockdep_hardirqs_on_prepare+0x19a/0x350
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f25686e8e41
Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffe4be3f710 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25686e8e41
RDX: 0000000000090800 RSI: 0000558c50eafef0 RDI: 00000000ffffff9c
RBP: 00007ffe4be3f8a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000287 R12: 0000558c50eae789
R13: 0000558c50eae788 R14: 0000558c50eca760 R15: 0000000000000800
</TASK>

Allocated by task 2337:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
__kasan_kmalloc+0x7e/0x90
eventfs_add_subsystem_dir+0xee/0x4d0
event_subsystem_dir+0x67e/0x9b0
event_create_dir+0xc6/0x600
trace_add_event_call+0xe6/0x190
trace_probe_register_event_call+0x23f/0x400
register_trace_kprobe+0x2d2/0x870
__trace_kprobe_create+0x671/0x970
trace_probe_create+0xc9/0xe0
create_or_delete_trace_kprobe+0x3c/0x70
trace_parse_run_command+0x148/0x220
vfs_write+0x211/0xc00
ksys_write+0xf7/0x1d0
do_syscall_64+0x5a/0x80
entry_SYSCALL_64_after_hwframe+0x5e/0xc8

Freed by task 2337:
kasan_save_stack+0x22/0x40
kasan_set_track+0x25/0x30
kasan_save_free_info+0x2e/0x40
__kasan_slab_free+0x10a/0x190
slab_free_freelist_hook+0xb0/0x160
__kmem_cache_free+0x1d5/0x390
eventfs_remove+0xf8/0x2e0
remove_event_file_dir+0x2c0/0x520
event_remove+0x1b2/0x460
trace_remove_event_call+0x170/0x3a0
trace_kprobe_release+0x2ac/0x390
dyn_events_release_all+0x159/0x1c0
probes_open+0x63/0x70
do_dentry_open+0x449/0x1020
do_open+0x748/0xf60
path_openat+0x255/0x620
do_filp_open+0x1b5/0x3e0
do_sys_openat2+0x122/0x400
__x64_sys_openat+0x123/0x1e0
do_syscall_64+0x5a/0x80
entry_SYSCALL_64_after_hwframe+0x5e/0xc8

The buggy address belongs to the object at ffff8881bf289000
which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
16-byte region [ffff8881bf289000, ffff8881bf289010)

The buggy address belongs to the physical page:
page:0000000007538459 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bf289
flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0000200 ffff8881000423c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff8881bf288f00: 00 00 00 fc fc 00 00 00 fc fc 00 00 00 fc fc 00
ffff8881bf288f80: 00 00 fc fc 00 00 00 fc fc 00 00 00 fc fc fc fc
>ffff8881bf289000: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
^
ffff8881bf289080: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
ffff8881bf289100: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
==================================================================
Disabling lock debugging due to kernel taint
------------[ cut here ]------------
WARNING: CPU: 1 PID: 2485 at fs/tracefs/event_inode.c:130 eventfs_create_dir+0x33a/0x400
Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs intel_rapl_msr blake2b_generic xor raid6_pq zstd_compress intel_rapl_common libcrc32c x86_pkg_temp_thermal intel_powerclamp sd_mod t10_pi coretemp crc64_rocksoft_generic kvm_intel crc64_rocksoft crc64 sg kvm ipmi_devintf irqbypass crct10dif_pclmul crc32_pclmul ipmi_msghandler i915 crc32c_intel ghash_clmulni_intel sha512_ssse3 mei_wdt ahci libahci drm_buddy intel_gtt wmi_bmof rapl intel_cstate drm_display_helper i2c_i801 mei_me ttm intel_uncore libata serio_raw drm_kms_helper i2c_smbus syscopyarea sysfillrect intel_pch_thermal mei video ie31200_edac sysimgblt wmi intel_pmc_core tpm_infineon acpi_pad binfmt_misc fuse drm ip_tables [last unloaded: ftrace_direct_too]
CPU: 1 PID: 2485 Comm: ftracetest Tainted: G    B              6.2.0-rc5-00008-gbe995c36ba22 #5
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:eventfs_create_dir+0x33a/0x400
Code: 41 5d 41 5e 41 5f e9 a5 f1 ff ff e8 b0 65 b7 ff e9 5d fe ff ff 45 31 ed 48 83 c4 08 4c 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9 0f fd ff ff 48 83 c4 08 4c 89 ef 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc90001407898 EFLAGS: 00010287
RAX: 0000000000000000 RBX: 0000000000000921 RCX: ffff888219488f00
RDX: ffff8881e58e82f0 RSI: 0000000000000921 RDI: 000000000000001a
RBP: 007365626f72706b R08: 04af015400000921 R09: 0000000000000000
R10: ffffed1039757c25 R11: 0000000000000001 R12: ffff888219488f00
R13: ffff8881e58e82f0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f25685e9740(0000) GS:ffff8883f0680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558c50edd3a8 CR3: 0000000119aa6005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
dcache_dir_open_wrapper+0x28b/0x770
do_dentry_open+0x449/0x1020
? eventfs_create_dir+0x400/0x400
? may_open+0xde/0x300
do_open+0x748/0xf60
path_openat+0x255/0x620
? do_open+0xf60/0xf60
? __lock_acquire+0xafe/0x17f0
do_filp_open+0x1b5/0x3e0
? may_open_dev+0xd0/0xd0
? alloc_fd+0x1e2/0x5c0
? do_raw_spin_lock+0x132/0x270
? lock_is_held_type+0x9c/0x110
? alloc_fd+0x1e2/0x5c0
? _raw_spin_unlock+0x23/0x30
? alloc_fd+0x1e2/0x5c0
? getname_flags+0x8e/0x450
do_sys_openat2+0x122/0x400
? lock_is_held_type+0x9c/0x110
? build_open_flags+0x450/0x450
? __might_fault+0xc0/0x160
? lock_release+0xe3/0x250
? rseq_ip_fixup+0x2d7/0x490
__x64_sys_openat+0x123/0x1e0
? __x64_sys_open+0x1a0/0x1a0
? lockdep_hardirqs_on_prepare+0x19a/0x350
? syscall_enter_from_user_mode+0x25/0x90
? trace_hardirqs_on+0x40/0x140
do_syscall_64+0x5a/0x80
? syscall_exit_to_user_mode+0x22/0x50
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? do_user_addr_fault+0x35c/0xc70
? irqentry_exit_to_user_mode+0xe/0x40
? lockdep_hardirqs_on_prepare+0x19a/0x350
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f25686e8e41
Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffe4be3f710 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25686e8e41
RDX: 0000000000090800 RSI: 0000558c50eafef0 RDI: 00000000ffffff9c
RBP: 00007ffe4be3f8a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000287 R12: 0000558c50eae789
R13: 0000558c50eae788 R14: 0000558c50eca760 R15: 0000000000000800
</TASK>
irq event stamp: 14031
hardirqs last  enabled at (14031): [<ffffffff8380148a>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
hardirqs last disabled at (14030): [<ffffffff837b2525>] __do_softirq+0x6d5/0x862
softirqs last  enabled at (8072): [<ffffffff837b2377>] __do_softirq+0x527/0x862
softirqs last disabled at (8065): [<ffffffff811c8beb>] __irq_exit_rcu+0x18b/0x1f0
---[ end trace 0000000000000000 ]---
general protection fault, probably for non-canonical address 0xe00e68ac4dee4e0d: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x007365626f727068-0x007365626f72706f]
CPU: 1 PID: 2485 Comm: ftracetest Tainted: G    B   W          6.2.0-rc5-00008-gbe995c36ba22 #5
Hardware name: HP HP Z238 Microtower Workstation/8183, BIOS N51 Ver. 01.63 10/05/2017
RIP: 0010:strlen+0x1e/0xa0
Code: 24 eb ba 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0018:ffffc90001407850 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff8881cbabe040 RCX: ffffffff8132c4d9
RDX: 000e6cac4dee4e0d RSI: 0000000000000004 RDI: 007365626f72706b
RBP: 007365626f72706b R08: 0000000000000000 R09: ffffffff84bafa83
R10: fffffbfff0975f50 R11: 0000000000000001 R12: 007365626f72706b
R13: ffff8881e58e82f0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f25685e9740(0000) GS:ffff8883f0680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558c50edd3a8 CR3: 0000000119aa6005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
eventfs_start_creating+0xa5/0x180
eventfs_create_dir+0x5b/0x400
dcache_dir_open_wrapper+0x28b/0x770
do_dentry_open+0x449/0x1020
? eventfs_create_dir+0x400/0x400
? may_open+0xde/0x300
do_open+0x748/0xf60
path_openat+0x255/0x620
? do_open+0xf60/0xf60
? __lock_acquire+0xafe/0x17f0
do_filp_open+0x1b5/0x3e0
? may_open_dev+0xd0/0xd0
? alloc_fd+0x1e2/0x5c0
? do_raw_spin_lock+0x132/0x270
? lock_is_held_type+0x9c/0x110
? alloc_fd+0x1e2/0x5c0
? _raw_spin_unlock+0x23/0x30
? alloc_fd+0x1e2/0x5c0
? getname_flags+0x8e/0x450
do_sys_openat2+0x122/0x400
? lock_is_held_type+0x9c/0x110
? build_open_flags+0x450/0x450
? __might_fault+0xc0/0x160
? lock_release+0xe3/0x250
? rseq_ip_fixup+0x2d7/0x490
__x64_sys_openat+0x123/0x1e0
? __x64_sys_open+0x1a0/0x1a0
? lockdep_hardirqs_on_prepare+0x19a/0x350
? syscall_enter_from_user_mode+0x25/0x90
? trace_hardirqs_on+0x40/0x140
do_syscall_64+0x5a/0x80
? syscall_exit_to_user_mode+0x22/0x50
? lockdep_hardirqs_on_prepare+0x19a/0x350
? do_syscall_64+0x67/0x80
? do_syscall_64+0x67/0x80
? do_user_addr_fault+0x35c/0xc70
? irqentry_exit_to_user_mode+0xe/0x40
? lockdep_hardirqs_on_prepare+0x19a/0x350
entry_SYSCALL_64_after_hwframe+0x5e/0xc8
RIP: 0033:0x7f25686e8e41
Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41 00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00 00
RSP: 002b:00007ffe4be3f710 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f25686e8e41
RDX: 0000000000090800 RSI: 0000558c50eafef0 RDI: 00000000ffffff9c
RBP: 00007ffe4be3f8a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000287 R12: 0000558c50eae789
R13: 0000558c50eae788 R14: 0000558c50eca760 R15: 0000000000000800
</TASK>
Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs intel_rapl_msr blake2b_generic xor raid6_pq zstd_compress intel_rapl_common libcrc32c x86_pkg_temp_thermal intel_powerclamp sd_mod t10_pi coretemp crc64_rocksoft_generic kvm_intel crc64_rocksoft crc64 sg kvm ipmi_devintf irqbypass crct10dif_pclmul crc32_pclmul ipmi_msghandler i915 crc32c_intel ghash_clmulni_intel sha512_ssse3 mei_wdt ahci libahci drm_buddy intel_gtt wmi_bmof rapl intel_cstate drm_display_helper i2c_i801 mei_me ttm intel_uncore libata serio_raw drm_kms_helper i2c_smbus syscopyarea sysfillrect intel_pch_thermal mei video ie31200_edac sysimgblt wmi intel_pmc_core tpm_infineon acpi_pad binfmt_misc fuse drm ip_tables [last unloaded: ftrace_direct_too]
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x1e/0xa0
Code: 24 eb ba 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 55 48 89 fa 48 89 fd 53 48 c1 ea 03 48 83 ec 08 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 48 80 7d 00 00
RSP: 0018:ffffc90001407850 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff8881cbabe040 RCX: ffffffff8132c4d9
RDX: 000e6cac4dee4e0d RSI: 0000000000000004 RDI: 007365626f72706b
RBP: 007365626f72706b R08: 0000000000000000 R09: ffffffff84bafa83
R10: fffffbfff0975f50 R11: 0000000000000001 R12: 007365626f72706b
R13: ffff8881e58e82f0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f25685e9740(0000) GS:ffff8883f0680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558c50edd3a8 CR3: 0000000119aa6005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

--WZ9JtNOrUroHJib6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 2G
need_cpu: 2
kernel-selftests:
  group: ftrace
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d06
tbox_group: lkp-skl-d06
submit_id: 63d8068e5c68a709afd173f6
job_file: "/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-2479-rzwid5-0.yaml"
id: 1bf3bc8792d2d148e6bd474e093f333aad6bee9d
queuer_version: "/zday/lkp"

#! hosts/lkp-skl-d06
model: Skylake
nr_cpu: 4
memory: 16G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EARS-00Y5B1_WD-WCAV5F059074-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BB012T4_BTWD422402M81P2GGN-part1"
brand: Intel(R) Xeon(R) CPU E3-1225 v5 @ 3.30GHz

#! include/category/functional
kmsg:
heartbeat:
meminfo:

#! include/queue/cyclic
commit: be995c36ba2232edcd4fa64e4581b9a6763c75e6

#! include/testbox/lkp-skl-d06
need_kconfig_hw:
- PTP_1588_CLOCK: y
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xf0'
bisect_dmesg: true

#! include/kernel-selftests
need_kconfig:
- FTRACE: y
- KPROBES: y
- FUNCTION_PROFILER: y
- TRACER_SNAPSHOT: y
- STACK_TRACER: y
- HIST_TRIGGERS: y
- SCHED_TRACER: y
- IRQSOFF_TRACER: y
- PREEMPTIRQ_DELAY_TEST: m
- MODULES: y
- MODULE_UNLOAD: y
- SAMPLES: y
- SAMPLE_FTRACE_DIRECT: m
- SAMPLE_TRACE_PRINTK: m
- KALLSYMS_ALL: y
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kselftests
enqueue_time: 2023-01-31 02:03:58.862834428 +08:00
_id: 63d8068e5c68a709afd173f6
_rt: "/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: f52288aef9267161e6b4a3da559f1211ddceb673
base_commit: 2241ab53cbb5cdb08a6b2d4688feb13971058f65
branch: linux-devel/devel-hourly-20230129-114149
result_root: "/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/0"
scheduler_version: "/lkp/lkp/.src-20230120-005037"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/ftrace/lkp-skl-d06/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22
- branch=linux-devel/devel-hourly-20230129-114149
- job=/lkp/jobs/scheduled/lkp-skl-d06/kernel-selftests-ftrace-debian-12-x86_64-20220629.cgz-be995c36ba2232edcd4fa64e4581b9a6763c75e6-20230131-2479-rzwid5-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=be995c36ba2232edcd4fa64e4581b9a6763c75e6
- kvm-intel.unrestricted_guest=0
- initcall_debug
- nmi_watchdog=0
- max_uptime=1200
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw

#! runtime status
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230110.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-d4cf28ee-1_20230110.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20221125.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220804.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /cephfs/db/releases/20230129224351/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 4.20.0
schedule_notify_address:

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/be995c36ba2232edcd4fa64e4581b9a6763c75e6/vmlinuz-6.2.0-rc5-00008-gbe995c36ba22"
dequeue_time: 2023-01-31 02:26:32.621538256 +08:00

#! /cephfs/db/releases/20230130194127/lkp-src/include/site/inn
job_state: running

--WZ9JtNOrUroHJib6--
