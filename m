Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9146761E21E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiKFMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiKFMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:38:49 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F055F80
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 04:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667738324; x=1699274324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ID7T02IRhLmZQe1t5FLIqO3242xqsc2YBo7PWZyLVjU=;
  b=h+IyyDg2lDhEoUtbzJ5A95Qc99Uf6QkfrSw71fEWnX/UjY0PoAyl5JRJ
   Y1UjPd3p25dYSz0dieKWlKXn2q7G48hnvMRcPB0515y9RTxsdFwFBekcc
   iB/4iW0PuhdiHTE2w/1IupYNI2mxKPfBDndDL8TNqGD1eBKtUu51OZSUU
   E3zS1enO6fhCbLvNJdRRcGP09N8uMPgQgE7Xiar9igctllmDxR9KbGFvA
   zWiW+ujttKVAsPasLhXibob8RdsyCLUqxIq7PM+ZdqANRNtNB7lqf03Rz
   +e5ImRAeBCzUEmAz5BqSKpxJcex/c+dvgxmzpa6KvT0PErI7tugPWddFq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="310253943"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?scan'208";a="310253943"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2022 04:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="638085452"
X-IronPort-AV: E=Sophos;i="5.96,142,1665471600"; 
   d="xz'?scan'208";a="638085452"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 06 Nov 2022 04:38:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 6 Nov 2022 04:38:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 6 Nov 2022 04:38:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 6 Nov 2022 04:38:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEvMbHrWHOjiUHj3fUFf3ziCbJAIZsXtv+dMZdmeuUcuRBvGX8pDscGA2Vnm1xaKlYkYql2TDo/AMePJxzX9IMAJ0LRUwTP3b9Rz68DeTzpxmQih3QlmxJoX1fOr8n5t40UaujHmflD36Qr7+FcrlXyY3D7j6LhiHsGr52H4RYpycJTKHzuqct6gKpmNLbuxS0rBxpNbt0VjPWV1inC6XMzn3EtUnVEsr4YWeaYN6CYenJ8XtfOjcdM2Ok1QstCDEeAPhdAU+tm6+DA5z6NlFGdyP5IV11o4DjUf15J78i4aEfB6sFsh9RgUCBfSqKGwzirYgkHWumrbT+RvpMe6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HanHi3uyDvmZ0WQAdlDCXDb2FmpaYiWzahVGXk/C8uc=;
 b=nK0zqdYwPGxCXxLoSoRcTko6sUgfuErKaJ7dEoETKaDuYZQ0yKUkiyAhLuoSA3iVTozZXjcDjhOrdDVxYIVNS3qDGGPAivp0Df1lmerANxZuFagSLfEX/zsUfdoxZYlPUg0b1Bz4SpO1qFkgjRVjCZNqOwr78pU3fj3oxfa2SdXtWAuUUyin+8L47wMMbRpL7vHkPoET5a8oJnwoq4VljNZ3TC/pKjB5gX+kxWHbtI2oax3Pb0umCbL8/N3mcw1zspcF9XdpCdGthxKdLZzeyCA8Rlb+c/ZXzlS0n0M7uMGTmdGTcZGYtTTVzsq5B/6xY03bnhAekmGqeqWeLTyEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sun, 6 Nov
 2022 12:38:37 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::15c8:6dea:24bb:b4c8%7]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 12:38:37 +0000
Date:   Sun, 6 Nov 2022 20:38:27 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [tip:x86/mm] [x86/mm]  b389949485:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr
Message-ID: <202211061748.eb591682-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="laD6gYvoCVUaTODo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5030:EE_
X-MS-Office365-Filtering-Correlation-Id: 31280025-462d-4d27-c6a1-08dabff3d34d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nNH5CHsgs/aSWnd7Js3g1NQZTuS04Dqd13Vvohad9HZu1TYVfAs4XU/rh3eWw8asOFvhYaSiiEA9jkxwU3lNpV4qRo/I29ojX/0Tjr0oA3zB87QEGxK9pj84U2Z21GvNJG80ZG/aiLH0LknziqZX3yhvKzu7eCPSNWLymAgHtuh1oeW7Jj6bYzMjTUy9dfCaPr03CF5yUjP2/nXF8U8O0skvfZkXi2xZBQc2GVTstZVIOuXXi4CNtMgl6TuvDBNg2EiYfxYGoKH6gULs9n3kzBEhp7UK9aTB8oVkNcfkVO1tlnKWukVGxtKbgE1mTV5SmlJOkanrd9cg+TNsTLghtFrrsM2yTzvsz21vuek2pZCt6tPM9ucEPn64XvEJcAsv7PD52MOR5SwtfZJ8mGVwyUSaKS4EKuBcVxsiFYrl1nCFUJVGpejnuLMb9VGapDxZbQeDa8uASXpv4ZaY/NaLbE0DiLHazo1z8xr+mSdiytjG4o/BMwb+x9OwMwTH1XeSM0phVNa0OPSoviRhvq52YYt+Dv1KBiuKJ0nNMn3c5ptuMAuQh1SpwOgYstzLOsANijayNEFk75aNFNZeVUtVV2VtbHhXNOS8R3yDA0w6MuFIvOzFWxHJLp0yOqTBvUlctmDiEfb2sUSMaZs7cr3gUHHnqcmchqDGToXqzEv46B9xxhqb1a3nElbj75xHkaghp5Y+7jE8NH8iD8QQxL9v0MW+wkm8I7+zLbfwrSnv/tRuOL9tfTUoKaGLKbSVrSEwhlv77JDjgKz1G8c/8PzH/IKGvGJgnSVzQJwV2uFL9g7KBcGMer+xKRkfDLCOKjgAZaxAmNLHOGkHTTaNeRg4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(45080400002)(36756003)(86362001)(44144004)(26005)(6666004)(6512007)(316002)(2616005)(6506007)(1076003)(186003)(6916009)(2906002)(82960400001)(235185007)(8936002)(5660300002)(38100700002)(30864003)(66556008)(66476007)(66946007)(4326008)(41300700001)(8676002)(83380400001)(478600001)(6486002)(966005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMnd8tIpe3vC4sulBHwrtBix6fAfrRR1q2RUjUneQoQBkBJz8IX60v6owXv7?=
 =?us-ascii?Q?IozBMLPnwiuHXMwOs5LB6Q8FKJM1Dc8d3VbUX6apd7aC6eGzi04cYyxUnwdk?=
 =?us-ascii?Q?qLjQX7BOQJyZ5LvmXJNyYakaYHpWx9H5j8mqQkZ1yhB4mAhfbLHejCB4imPv?=
 =?us-ascii?Q?BcATe/93qJJ3bYRlqNBnROpz6Y3jWR29NF8gDF883KNaUStyvjUKNt3N/1Nv?=
 =?us-ascii?Q?iA1Tue0WHchiZiwuV7PeRKPnkUhu4ge0TbRojbi9c7qi6wCpHgA1fvQgNek1?=
 =?us-ascii?Q?WeFrFv9MFz6xP0Lu1jZHQuRY+1+ZWfXUwLWMQ8i+MhuFAU8gW6JU09HPrfG7?=
 =?us-ascii?Q?/9Fubf+ZEnV1WHAMOdb/AacSq+IzLuqIvyDjMxvZ9TzxmyaD2E3dIHMht+7A?=
 =?us-ascii?Q?X3C3a+kNCjEJ0BQYc8IDL8YHjAY3vpSowW4TZMDEtsDVi+0TFje8b03BawLu?=
 =?us-ascii?Q?HF6lT9vYb9u9KPQtJNJMA3ozTohxSg68rlOrv3PGa3ai+eLhfa1N3XeLxioj?=
 =?us-ascii?Q?4roQk8Qo9ORPPitbmIRVZr7LlY+x3jylZHHresa4zdT/G2Ectn/yopk+1sva?=
 =?us-ascii?Q?sJTAqgiWUyobvFFNBHZFzNqvNxbAxVj4hTKwpkmU34fCFGR+PyDTLiJWqz4j?=
 =?us-ascii?Q?hmZ0pSWAAwPm83Eg4AhODCw2BbZW7fyUE3NEluvFJNvy+RWczZXgo+bOJL5H?=
 =?us-ascii?Q?nJ6FVDlneyHxIi21S2TxB5ykmENOgWtH8uJ2F54c/YCrH7ZYAYCWhhKGIXou?=
 =?us-ascii?Q?2Oju8QrP7CBAv/Glg91G0TmSeeD5DJhb9QsGDMjXzNaFSc+07fZAZoNV0nW3?=
 =?us-ascii?Q?BaSG/z0B6cjspQ3FeERwlUikR7JCyC1eMwkCubHspnOhxxvuv7qs8HKzxox3?=
 =?us-ascii?Q?2K1NOn5bDKKLdjcDb/4EoNe1xi7uDvpqUi/vHA6VfOVVJygc10W6GD6b7VLd?=
 =?us-ascii?Q?U7nfeY1X+igelEt37v7VA1Hcmq7ygGD0AXoYyb+Fqyft515qO+vW3kNxd1ZN?=
 =?us-ascii?Q?Zk5cSOTkZTnAyAQV0J94Xpdik0aEAiuEX8n+jn1/lxIDRrcNGYo0Oeps1Nnu?=
 =?us-ascii?Q?8Rpq3S25ODEbsNWCcyQNWEsj0+3POA798ctC5ence8Zs6AIcnp7V+3HHNDRP?=
 =?us-ascii?Q?FIpr4C5EBrbY+wwJgpIgaeQ5csXnB7ujlNs/dTVIuuI5N/RMacl2QRyvGv5d?=
 =?us-ascii?Q?tv7J8Ad79H1kchRbUGI8JxYUnOEgaDC3vTafbJP1XH5pj3xMZwEGD5vkAelz?=
 =?us-ascii?Q?DsM0LEoa5quBYZ0YWA6HV9ZM2L8rYqrRmLwvg3DOLShPzIQF+qAh2lm6MbEX?=
 =?us-ascii?Q?JfNZwmOobUgLh2F1Cw9RoVmtnQdDiiIsz/3yYczDfQQ9emJqJCNHy3l644/S?=
 =?us-ascii?Q?9m6BMgJx36Wr3L6k1M90PD+KiztINIe8WXDFNxALxUPLfYKx8YdrC5RYbzaZ?=
 =?us-ascii?Q?/IVREiDAJOb1aJZRNRmXe/TBOtoQHii7Szh4IzGZt7gexZ3nVYRwrfCdBtWN?=
 =?us-ascii?Q?pHGC/7jAv28/yexlIpHAmnuHpFau6t9n5JpM4Zxt0fsm6IUiMoaZGrgYIdg/?=
 =?us-ascii?Q?oa/hIiK/hZAairbtrsx/1AUsxXIvURYVSc0fyf3Qy+Kw3zae0a1+m7YuYyg8?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31280025-462d-4d27-c6a1-08dabff3d34d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2022 12:38:37.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VBG3p8XU7TomOW9Eolt9/S38W7GiD5Jt8ENhinMo8jbrdbHgnfeLF6Q2vUmrrW4S4CBmOYO7dzdI8fxOn2vnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--laD6gYvoCVUaTODo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Greeting,

FYI, we noticed WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr due to commit (built with gcc-11):

commit: b38994948567e6d6b62947401c57f4ab2efe070c ("x86/mm: Implement native set_memory_rox()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm

[test failed on linux-next/master 0cdb3579f1ee4c1e55acf8dfb0697b660067b1f8]

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211061748.eb591682-oliver.sang@intel.com


[   44.943065][   T11] ------------[ cut here ]------------
[   44.943725][   T11] CPA detected W^X violation: 0000000000000060 -> 0000000000000063 range: 0xffff8881beca5000 - 0xffff8881beca5fff PFN 1beca5
[ 44.944929][ T11] WARNING: CPU: 0 PID: 11 at arch/x86/mm/pat/set_memory.c:609 __change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 
[   44.945824][   T11] Modules linked in:
[   44.946229][   T11] CPU: 0 PID: 11 Comm: kworker/0:1 Tainted: G        W          6.1.0-rc3-00010-gb38994948567 #1 f37474c2082f37dd433f70907b94c2b0df8d70b8
[   44.947518][   T11] Workqueue: events bpf_prog_free_deferred
[ 44.948074][ T11] RIP: 0010:__change_page_attr (arch/x86/mm/pat/set_memory.c:609 arch/x86/mm/pat/set_memory.c:1582) 
[ 44.948593][ T11] Code: f0 f6 83 06 01 90 48 c7 c7 c0 69 e7 84 4d 89 f9 4c 89 e9 4c 89 da 4d 8d 85 ff 0f 00 00 4c 89 f6 4c 89 1c 24 e8 7d 2d 4c 03 90 <0f> 0b 90 90 4c 8b 54 24 08 4c 8b 1c 24 4c 89 d8 4c 89 ff 4c 89 14
All code
========
   0:	f0 f6 83 06 01 90 48 	lock testb $0xc7,0x48900106(%rbx)
   7:	c7 
   8:	c7 c0 69 e7 84 4d    	mov    $0x4d84e769,%eax
   e:	89 f9                	mov    %edi,%ecx
  10:	4c 89 e9             	mov    %r13,%rcx
  13:	4c 89 da             	mov    %r11,%rdx
  16:	4d 8d 85 ff 0f 00 00 	lea    0xfff(%r13),%r8
  1d:	4c 89 f6             	mov    %r14,%rsi
  20:	4c 89 1c 24          	mov    %r11,(%rsp)
  24:	e8 7d 2d 4c 03       	callq  0x34c2da6
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
  33:	4c 8b 1c 24          	mov    (%rsp),%r11
  37:	4c 89 d8             	mov    %r11,%rax
  3a:	4c 89 ff             	mov    %r15,%rdi
  3d:	4c                   	rex.WR
  3e:	89                   	.byte 0x89
  3f:	14                   	.byte 0x14

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	90                   	nop
   4:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
   9:	4c 8b 1c 24          	mov    (%rsp),%r11
   d:	4c 89 d8             	mov    %r11,%rax
  10:	4c 89 ff             	mov    %r15,%rdi
  13:	4c                   	rex.WR
  14:	89                   	.byte 0x89
  15:	14                   	.byte 0x14
[   44.950258][   T11] RSP: 0018:ffffc900000bfa70 EFLAGS: 00010246
[   44.950884][   T11] RAX: 0000000000000000 RBX: ffffffff86777910 RCX: 0000000000000000
[   44.951640][   T11] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   44.952326][   T11] RBP: ffff888173dfc528 R08: 0000000000000000 R09: 0000000000000000
[   44.953009][   T11] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900000bfba8
[   44.953698][   T11] R13: ffff8881beca5000 R14: 0000000000000060 R15: 00000000001beca5
[   44.954458][   T11] FS:  0000000000000000(0000) GS:ffffffff86732000(0000) knlGS:0000000000000000
[   44.955274][   T11] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.955881][   T11] CR2: 00007f13ac3cd320 CR3: 000000000668a000 CR4: 00000000000406f0
[   44.956577][   T11] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   44.957276][   T11] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   44.958018][   T11] Call Trace:
[   44.958336][   T11]  <TASK>
[ 44.958624][ T11] ? __should_split_large_page (arch/x86/mm/pat/set_memory.c:1552) 
[ 44.959205][ T11] __change_page_attr_set_clr (include/linux/spinlock.h:390 arch/x86/mm/pat/set_memory.c:1706) 
[ 44.959756][ T11] set_direct_map_default_noflush (arch/x86/mm/pat/set_memory.c:2307) 
[ 44.960293][ T11] ? set_direct_map_invalid_noflush (arch/x86/mm/pat/set_memory.c:2307) 
[ 44.960895][ T11] ? __mutex_unlock_slowpath (arch/x86/include/asm/atomic64_64.h:190 include/linux/atomic/atomic-long.h:449 include/linux/atomic/atomic-instrumented.h:1790 kernel/locking/mutex.c:924) 
[ 44.961425][ T11] ? _vm_unmap_aliases (mm/vmalloc.c:2173 (discriminator 2)) 
[ 44.961896][ T11] __vunmap (mm/vmalloc.c:2620 mm/vmalloc.c:2673 mm/vmalloc.c:2699) 
[ 44.962307][ T11] bpf_prog_pack_free (kernel/bpf/core.c:944) 
[ 44.962764][ T11] bpf_jit_binary_pack_free (kernel/bpf/core.c:1137) 
[ 44.963316][ T11] bpf_jit_free (include/linux/filter.h:1044 arch/x86/net/bpf_jit_comp.c:2579) 
[ 44.963754][ T11] process_one_work (arch/x86/include/asm/atomic.h:29 include/linux/jump_label.h:259 include/linux/jump_label.h:269 include/trace/events/workqueue.h:108 kernel/workqueue.c:2294) 
[ 44.964275][ T11] ? lock_release (kernel/locking/lockdep.c:5636) 
[ 44.964742][ T11] ? cancel_delayed_work_sync (kernel/workqueue.c:2184) 
[ 44.965238][ T11] ? io_schedule_timeout (kernel/sched/core.c:6385) 
[ 44.965754][ T11] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2437) 
[ 44.966200][ T11] ? __kthread_parkme (arch/x86/include/asm/bitops.h:207 (discriminator 4) arch/x86/include/asm/bitops.h:239 (discriminator 4) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[ 44.966630][ T11] ? schedule (arch/x86/include/asm/bitops.h:207 (discriminator 1) arch/x86/include/asm/bitops.h:239 (discriminator 1) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 1) include/linux/thread_info.h:118 (discriminator 1) include/linux/sched.h:2229 (discriminator 1) kernel/sched/core.c:6581 (discriminator 1)) 
[ 44.967065][ T11] ? rescuer_thread (kernel/workqueue.c:2379) 
[ 44.967543][ T11] ? rescuer_thread (kernel/workqueue.c:2379) 
[ 44.968008][ T11] kthread (kernel/kthread.c:376) 
[ 44.968392][ T11] ? kthread_complete_and_exit (kernel/kthread.c:331) 
[ 44.968931][ T11] ret_from_fork (arch/x86/entry/entry_64.S:312) 
[   44.969374][   T11]  </TASK>
[   44.969653][   T11] irq event stamp: 38969
[ 44.970025][ T11] hardirqs last enabled at (38977): __up_console_sem (kernel/printk/printk.c:261 (discriminator 1)) 
[ 44.970883][ T11] hardirqs last disabled at (38986): __up_console_sem (kernel/printk/printk.c:259 (discriminator 1)) 
[ 44.971760][ T11] softirqs last enabled at (38298): rhashtable_rehash_chain (include/linux/instrumented.h:87 include/asm-generic/bitops/instrumented-lock.h:26 include/linux/bit_spinlock.h:63 include/linux/rhashtable.h:347 lib/rhashtable.c:290) 
[ 44.972677][ T11] softirqs last disabled at (38296): rhashtable_rehash_chain (include/linux/bottom_half.h:20 include/linux/rhashtable.h:329 lib/rhashtable.c:283) 
[   44.973603][   T11] ---[ end trace 0000000000000000 ]---
[   45.079703][  T194] LKP: stdout: 177:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml
[   45.079745][  T194]
[   45.472417][  T280] udevd[280]: starting version 175
[   45.863895][  T194] RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/8
[   45.863939][  T194]
[   45.898263][  T194] job=/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml
[   45.898304][  T194]
[   46.250201][  T194] result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/8, TMP_RESULT_ROOT: /tmp/lkp/result
[   46.250247][  T194]
[   46.288136][  T194] run-job /lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml
[   46.288179][  T194]
[   47.618739][  T194] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml&job_state=running -O /dev/null
[   47.618784][  T194]
[ 49.292432][ T381] calling parport_default_proc_register+0x0/0x1000 [parport] @ 381 
[ 49.327753][ T381] initcall parport_default_proc_register+0x0/0x1000 [parport] returned 0 after 34505 usecs 
[ 49.440207][ T381] calling parport_pc_init+0x0/0xac3 [parport_pc] @ 381 
[   49.487815][  T381] parport_pc 00:03: reported by Plug and Play ACPI
[   49.502288][  T381] parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
[ 49.634328][ T381] initcall parport_pc_init+0x0/0xac3 [parport_pc] returned 0 after 193370 usecs 
[   49.660424][  T381] modprobe (381) used greatest stack depth: 27184 bytes left
[   54.131749][    T1] init: failsafe main process (411) killed by TERM signal
[ 55.645580][ T442] calling ppdev_init+0x0/0x1000 [ppdev] @ 442 
[   55.671570][  T442] ppdev: user-space parallel port driver
[ 55.672172][ T442] initcall ppdev_init+0x0/0x1000 [ppdev] returned 0 after 25950 usecs 
[   56.978205][    T1] init: udev-fallback-graphics main process (456) terminated with status 1
[   57.553215][    T1] init: networking main process (466) terminated with status 1
[   59.730271][  T194] target ucode:
[   59.730321][  T194]
[   66.544620][    T1] init: tty4 main process (450) terminated with status 1
[   66.546184][    T1] init: tty4 main process ended, respawning
[   66.558350][  T194] sleep started
[   66.558394][  T194]
[   66.610521][    T1] init: tty5 main process (451) terminated with status 1
[   66.612127][    T1] init: tty5 main process ended, respawning
[   66.670353][    T1] init: tty2 main process (452) terminated with status 1
[   66.671980][    T1] init: tty2 main process ended, respawning
[   66.728761][    T1] init: tty3 main process (453) terminated with status 1
[   66.730293][    T1] init: tty3 main process ended, respawning
[   66.804600][    T1] init: tty6 main process (454) terminated with status 1
[   66.806176][    T1] init: tty6 main process ended, respawning
[   67.833563][  T194] /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml&job_state=post_run -O /dev/null
[   67.833607][  T194]
[   76.667606][    T1] init: tty4 main process (583) terminated with status 1
[   76.669116][    T1] init: tty4 main process ended, respawning
[   76.725449][    T1] init: tty5 main process (584) terminated with status 1
[   76.726898][    T1] init: tty5 main process ended, respawning
[   76.777663][    T1] init: tty2 main process (585) terminated with status 1
[   76.779234][    T1] init: tty2 main process ended, respawning
[   76.821151][    T1] init: tty3 main process (586) terminated with status 1
[   76.822692][    T1] init: tty3 main process ended, respawning
[   76.891180][    T1] init: tty6 main process (587) terminated with status 1
[   76.892742][    T1] init: tty6 main process ended, respawning
[   80.967918][  T194] kill 506 vmstat -n 10
[   80.967963][  T194]
[   81.112072][  T194] kill 504 cat /proc/kmsg
[   81.112113][  T194]
[   81.260272][  T194] wait for background processes: 517 513 oom-killer meminfo
[   81.260319][  T194]
[   86.754428][    T1] init: tty4 main process (596) terminated with status 1
[   86.755998][    T1] init: tty4 main process ended, respawning
[   86.788212][    T1] init: tty5 main process (597) terminated with status 1
[   86.789794][    T1] init: tty5 main process ended, respawning
[   86.874442][    T1] init: tty2 main process (598) terminated with status 1
[   86.876058][    T1] init: tty2 main process ended, respawning
[   86.921154][    T1] init: tty3 main process (599) terminated with status 1
[   86.922776][    T1] init: tty3 main process ended, respawning
[   86.975117][    T1] init: tty6 main process (600) terminated with status 1
[   86.988314][    T1] init: tty6 main process ended, respawning


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc3-00010-gb38994948567 .config
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



--laD6gYvoCVUaTODo
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.1.0-rc3-00010-gb38994948567"

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
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
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
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
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

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
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
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
# CONFIG_BPF_PRELOAD_UMD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
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
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
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
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
CONFIG_INITRAMFS_PRESERVE_MTIME=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
# CONFIG_POSIX_TIMERS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_ELF_CORE is not set
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
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
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
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
CONFIG_X86_INTEL_MID=y
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
# CONFIG_XEN_PVHVM_GUEST is not set
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
# CONFIG_XEN_PVH is not set
CONFIG_XEN_DOM0=y
CONFIG_XEN_PV_MSR_SAFE=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
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
# CONFIG_DMI is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
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
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_X86_MEM_ENCRYPT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
# CONFIG_KEXEC_FILE is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_COMPAT_VDSO=y
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_SPECULATION_MITIGATIONS=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_RETPOLINE is not set
CONFIG_CPU_IBRS_ENTRY=y
CONFIG_SLS=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_USERSPACE_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
# CONFIG_PM_WAKELOCKS_GC is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
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
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
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

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
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
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_SECCOMP_CACHE_DEBUG=y
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
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
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
# CONFIG_GCC_PLUGINS is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
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
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
# CONFIG_BLK_CGROUP_IOPRIO is not set
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
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
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
CONFIG_BFQ_CGROUP_DEBUG=y
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
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
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SLUB_STATS=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
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
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
# CONFIG_DAMON_SYSFS is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_WANT_COMPAT_NETLINK_MESSAGES=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
CONFIG_XFRM_USER_COMPAT=m
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=m
# CONFIG_NET_KEY is not set
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_ESPINTCP=y
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
# CONFIG_TCP_CONG_CUBIC is not set
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=m
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_TCP_CONG_LP is not set
# CONFIG_TCP_CONG_VENO is not set
CONFIG_TCP_CONG_YEAH=m
# CONFIG_TCP_CONG_ILLINOIS is not set
# CONFIG_TCP_CONG_DCTCP is not set
CONFIG_TCP_CONG_CDG=y
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_BIC=y
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="bic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
# CONFIG_NETLABEL is not set
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
CONFIG_BPFILTER=y
# CONFIG_BPFILTER_UMH is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
# CONFIG_SCTP_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
CONFIG_ATM_BR2684_IPFILTER=y
CONFIG_L2TP=m
# CONFIG_L2TP_DEBUGFS is not set
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_GARP=m
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_AR9331=m
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_HELLCREEK=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
# CONFIG_NET_DSA_TAG_MTK is not set
CONFIG_NET_DSA_TAG_KSZ=m
# CONFIG_NET_DSA_TAG_OCELOT is not set
# CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
CONFIG_NET_DSA_TAG_QCA=m
# CONFIG_NET_DSA_TAG_RTL4_A is not set
CONFIG_NET_DSA_TAG_RTL8_4=m
# CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_NET_DSA_TAG_XRS700X=m
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=y
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
# CONFIG_6LOWPAN_NHC_DEST is not set
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
# CONFIG_6LOWPAN_NHC_IPV6 is not set
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
# CONFIG_6LOWPAN_NHC_UDP is not set
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=m
CONFIG_6LOWPAN_GHC_UDP=m
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
# CONFIG_BATMAN_ADV_BLA is not set
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
# CONFIG_BATMAN_ADV_MCAST is not set
CONFIG_BATMAN_ADV_DEBUG=y
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=y
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=y
# CONFIG_VIRTIO_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=m
CONFIG_BT=y
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
# CONFIG_BT_BNEP_PROTO_FILTER is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_FEATURE_DEBUG=y

#
# Bluetooth device drivers
#
CONFIG_BT_MTK=y
CONFIG_BT_HCIBTSDIO=m
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=y
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
CONFIG_BT_MTKSDIO=y
CONFIG_BT_MTKUART=m
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=m
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_RDMA=m
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=m
CONFIG_CAIF_DEBUG=y
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
# CONFIG_EISA_PCI_EISA is not set
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
CONFIG_PCIE_BUS_SAFE=y
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
# CONFIG_VGA_ARB is not set
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

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
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
# CONFIG_PCI_EPF_NTB is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_DEVTMPFS_SAFE=y
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
# CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=m
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

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_CS_DSP=m
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
# CONFIG_FTL is not set
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=y
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
# CONFIG_MTD_SCB2_FLASH is not set
CONFIG_MTD_NETtel=m
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
CONFIG_MTD_PMC551_DEBUG=y
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=m
CONFIG_MTD_MCHP48L640=m
CONFIG_MTD_SST25L=y
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
CONFIG_MTD_ONENAND=m
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
# CONFIG_MTD_ONENAND_GENERIC is not set
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_RAW_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
CONFIG_MTD_SPI_NOR_SWP_DISABLE=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE is not set
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=m
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set
# CONFIG_BLK_DEV_RNBD_CLIENT is not set
# CONFIG_BLK_DEV_RNBD_SERVER is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_VERBOSE_ERRORS=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=m
CONFIG_LATTICE_ECP3_CONFIG=m
# CONFIG_SRAM is not set
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
CONFIG_CB710_DEBUG=y
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
CONFIG_MISC_ALCOR_PCI=y
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
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
CONFIG_CHR_DEV_ST=m
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=y
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=y
CONFIG_BE2ISCSI=y
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_ADVANSYS=m
# CONFIG_SCSI_ARCMSR is not set
CONFIG_SCSI_ESAS2R=m
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
CONFIG_SCSI_MPI3MR=m
CONFIG_SCSI_SMARTPQI=m
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=y
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=m
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_SCSI_SIM710=m
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
# CONFIG_PCMCIA_AHA152X is not set
CONFIG_PCMCIA_FDOMAIN=m
# CONFIG_PCMCIA_QLOGIC is not set
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_AHCI_DWC is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
# CONFIG_SATA_QSTOR is not set
CONFIG_SATA_SX4=m
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_MD_CLUSTER=m
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
# CONFIG_DM_ERA is not set
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
# CONFIG_DM_MULTIPATH is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
# CONFIG_DM_LOG_WRITES is not set
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=y
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
CONFIG_ATM_SOLOS=y
CONFIG_CAIF_DRIVERS=y
# CONFIG_CAIF_TTY is not set
# CONFIG_CAIF_VIRTIO is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
# CONFIG_B53_SPI_DRIVER is not set
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
# CONFIG_B53_SRAB_DRIVER is not set
# CONFIG_B53_SERDES is not set
CONFIG_NET_DSA_BCM_SF2=m
CONFIG_NET_DSA_LOOP=m
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
# CONFIG_NET_DSA_MT7530 is not set
CONFIG_NET_DSA_MV88E6060=m
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=m
# CONFIG_NET_DSA_MICROCHIP_KSZ_SPI is not set
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=m
# CONFIG_NET_DSA_MV88E6XXX is not set
CONFIG_NET_DSA_AR9331=m
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_NET_DSA_SJA1105=m
CONFIG_NET_DSA_XRS700X=m
CONFIG_NET_DSA_XRS700X_I2C=m
CONFIG_NET_DSA_XRS700X_MDIO=m
CONFIG_NET_DSA_REALTEK=m
# CONFIG_NET_DSA_REALTEK_MDIO is not set
# CONFIG_NET_DSA_REALTEK_SMI is not set
CONFIG_NET_DSA_REALTEK_RTL8365MB=m
# CONFIG_NET_DSA_REALTEK_RTL8366RB is not set
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_NET_DSA_VITESSE_VSC73XX=m
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=m
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=m
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y
CONFIG_PCMCIA_3C574=m
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=m
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=y
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ASIX is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_CX_ECAT=y
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BCMGENET=y
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=m
# CONFIG_TIGON3_HWMON is not set
CONFIG_BNX2X=m
CONFIG_SYSTEMPORT=m
CONFIG_BNXT=m
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
# CONFIG_BNXT_HWMON is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_PCI=y
# CONFIG_NET_VENDOR_CAVIUM is not set
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
CONFIG_CHELSIO_T1_1G=y
# CONFIG_CHELSIO_T3 is not set
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4_DCB=y
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_LIB=m
# CONFIG_CHELSIO_INLINE_CRYPTO is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_NET_VENDOR_CISCO is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
CONFIG_DM9051=m
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
# CONFIG_BE2NET_BE2 is not set
# CONFIG_BE2NET_BE3 is not set
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_ENGLEDER=y
CONFIG_TSNEP=m
# CONFIG_TSNEP_SELFTESTS is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=y
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
CONFIG_JME=y
CONFIG_NET_VENDOR_ADI=y
# CONFIG_ADIN1110 is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
# CONFIG_SKGE_GENESIS is not set
# CONFIG_SKY2 is not set
CONFIG_OCTEON_EP=y
CONFIG_PRESTERA=m
CONFIG_PRESTERA_PCI=m
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
# CONFIG_MLX4_EN_DCB is not set
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
# CONFIG_MLX5_FPGA is not set
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
# CONFIG_MLX5_ESWITCH is not set
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
# CONFIG_MLX5_SF is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8851=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=y
# CONFIG_ENC28J60_WRITEVERIFY is not set
# CONFIG_ENCX24J600 is not set
CONFIG_LAN743X=y
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=m
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_IONIC=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
# CONFIG_QLCNIC is not set
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=y
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
CONFIG_EPIC100=y
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
# CONFIG_STMMAC_PLATFORM is not set
# CONFIG_DWMAC_INTEL is not set
# CONFIG_DWMAC_LOONGSON is not set
CONFIG_STMMAC_PCI=m
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
CONFIG_VIA_VELOCITY=y
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
CONFIG_FDDI=m
CONFIG_DEFXX=m
# CONFIG_SKFP is not set
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
CONFIG_ADIN_PHY=m
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
CONFIG_MICREL_PHY=y
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=y
CONFIG_NATIONAL_PHY=y
CONFIG_NXP_C45_TJA11XX_PHY=y
CONFIG_NXP_TJA11XX_PHY=m
# CONFIG_AT803X_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=m
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=m
# CONFIG_DP83TC811_PHY is not set
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=m
# CONFIG_DP83869_PHY is not set
# CONFIG_DP83TD510_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=m
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_NETLINK=y
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_RX_OFFLOAD=y
# CONFIG_CAN_CAN327 is not set
# CONFIG_CAN_JANZ_ICAN3 is not set
CONFIG_CAN_KVASER_PCIEFD=m
# CONFIG_CAN_SLCAN is not set
CONFIG_CAN_C_CAN=m
# CONFIG_CAN_C_CAN_PLATFORM is not set
CONFIG_CAN_C_CAN_PCI=m
# CONFIG_CAN_CC770 is not set
# CONFIG_CAN_CTUCANFD_PCI is not set
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_EMS_PCMCIA is not set
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
CONFIG_CAN_MCP251X=m
CONFIG_CAN_MCP251XFD=m
CONFIG_CAN_MCP251XFD_SANITY=y
# end of CAN SPI interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_GPIO=m
# CONFIG_MDIO_MSCC_MIIM is not set
CONFIG_MDIO_THUNDER=y

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=y
CONFIG_PPPOL2TP=m
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
CONFIG_WAN=y
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=m
# CONFIG_HDLC_PPP is not set
CONFIG_HDLC_X25=m
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
CONFIG_PC300TOO=m
# CONFIG_FARSYNC is not set
CONFIG_LAPBETHER=m
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
CONFIG_IEEE802154_AT86RF230=m
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
# CONFIG_IEEE802154_CA8210_DEBUGFS is not set
CONFIG_IEEE802154_MCR20A=m
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
# CONFIG_WWAN_DEBUGFS is not set
# CONFIG_WWAN_HWSIM is not set
CONFIG_MHI_WWAN_CTRL=m
CONFIG_MHI_WWAN_MBIM=m
CONFIG_RPMSG_WWAN_CTRL=m
# CONFIG_MTK_T7XX is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=m
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_USB4_NET=y
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
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
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
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

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_RPMSG_TTY is not set
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=m
# CONFIG_IPMI_POWEROFF is not set
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_HW_RANDOM_XIPHERA=y
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
# CONFIG_NVRAM is not set
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
# CONFIG_TCG_TIS_I2C is not set
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_XEN=m
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_LTC4306=m
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
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
CONFIG_I2C_CCGX_UCSI=y
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
# CONFIG_I2C_ISCH is not set
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_PCI1XXXX is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
# CONFIG_CDNS_I3C_MASTER is not set
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=m
# CONFIG_SPI_DESIGNWARE is not set
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_INTEL=m
CONFIG_SPI_INTEL_PCI=m
# CONFIG_SPI_INTEL_PLATFORM is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
CONFIG_SPI_MXIC=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
# CONFIG_SPI_SLAVE_SYSTEM_CONTROL is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_ICH=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_VX855=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_IT87=y
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_JANZ_TTL is not set
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_TWL6040=y
# CONFIG_GPIO_UCB1400 is not set
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_MERRIFIELD=y
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=m
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=m
# CONFIG_POWER_RESET_MT6323 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_IP5XXX_POWER=y
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
# CONFIG_CHARGER_DA9150 is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_BATTERY_TWL4030_MADC=m
# CONFIG_CHARGER_PCF50633 is not set
CONFIG_BATTERY_RX51=m
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=m
# CONFIG_CHARGER_LP8788 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_MP2629 is not set
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=y
CONFIG_SENSORS_ADM9240=y
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=m
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_AHT10=y
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_K8TEMP=y
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
CONFIG_SENSORS_DRIVETEMP=y
CONFIG_SENSORS_DS620=y
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=m
CONFIG_I8K=y
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
CONFIG_SENSORS_LTC2947_SPI=y
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=m
# CONFIG_SENSORS_LTC4245 is not set
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=m
# CONFIG_SENSORS_MAX127 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
# CONFIG_SENSORS_MAX31760 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6650=m
# CONFIG_SENSORS_MAX6697 is not set
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=y
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=y
CONFIG_SENSORS_LM73=y
CONFIG_SENSORS_LM75=m
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=y
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT6775_I2C is not set
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_PECI_CPUTEMP=m
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
CONFIG_SENSORS_DELTA_AHE50DC_FAN=y
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=y
CONFIG_SENSORS_INSPUR_IPSPS=y
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
CONFIG_SENSORS_IR38064=y
# CONFIG_SENSORS_IR38064_REGULATOR is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
# CONFIG_SENSORS_LM25066 is not set
# CONFIG_SENSORS_LT7182S is not set
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
CONFIG_SENSORS_MAX20730=m
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=m
# CONFIG_SENSORS_MAX34440 is not set
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=y
CONFIG_SENSORS_MP2975=m
# CONFIG_SENSORS_MP5023 is not set
CONFIG_SENSORS_PIM4328=y
CONFIG_SENSORS_PLI1209BC=m
CONFIG_SENSORS_PLI1209BC_REGULATOR=y
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=m
# CONFIG_SENSORS_TPS546D24 is not set
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_XDPE152 is not set
CONFIG_SENSORS_XDPE122=y
CONFIG_SENSORS_XDPE122_REGULATOR=y
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SBTSI=y
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=m
# CONFIG_SENSORS_EMC2305 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_STTS751 is not set
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA238=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
CONFIG_SENSORS_TMP513=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=y
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_WM831X is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
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
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

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
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=y
CONFIG_DA9062_WATCHDOG=y
# CONFIG_MENF21BMC_WATCHDOG is not set
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=m
# CONFIG_TWL4030_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=y
CONFIG_EBC_C384_WDT=y
# CONFIG_EXAR_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
CONFIG_INTEL_MID_WATCHDOG=m
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
CONFIG_HP_WATCHDOG=m
# CONFIG_HPWDT_NMI_DECODING is not set
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
CONFIG_MEN_A21_WDT=m
# CONFIG_XEN_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_SFLASH is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=m
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=y
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_OCELOT is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
# CONFIG_PCF50633_GPIO is not set
CONFIG_UCB1400_CORE=m
# CONFIG_MFD_SY7636A is not set
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RT5120 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM831X_SPI=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_RAVE_SP_CORE=m
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ARIZONA_LDO1=m
# CONFIG_REGULATOR_ARIZONA_MICSUPP is not set
CONFIG_REGULATOR_ATC260X=m
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_DA903X=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MT6311 is not set
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
# CONFIG_REGULATOR_MT6358 is not set
# CONFIG_REGULATOR_MT6359 is not set
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=m
# CONFIG_REGULATOR_PV88060 is not set
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5190A=y
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SKY81452=m
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6524X=m
# CONFIG_REGULATOR_TWL4030 is not set
# CONFIG_REGULATOR_WM831X is not set
# CONFIG_REGULATOR_WM8994 is not set
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
# CONFIG_DVB_NET is not set
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m
# CONFIG_VIDEO_ZORAN is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=m
# CONFIG_VIDEO_CX25821_ALSA is not set
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
CONFIG_DVB_DDBRIDGE=m
CONFIG_DVB_NETUP_UNIDVB=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_PLUTO2=m
# CONFIG_DVB_PT1 is not set
# CONFIG_DVB_PT3 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
CONFIG_RADIO_ADAPTERS=m
CONFIG_RADIO_MAXIRADIO=m
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_RADIO_SI476X is not set
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_TEF6862=m
# CONFIG_RADIO_WL1273 is not set
CONFIG_RADIO_SI470X=m
# CONFIG_I2C_SI470X is not set
# CONFIG_MEDIA_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_TVEEPROM=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_SMS_SIANO_MDTV=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_CCS_PLL=m
# CONFIG_VIDEO_AR0521 is not set
# CONFIG_VIDEO_HI556 is not set
CONFIG_VIDEO_HI846=m
CONFIG_VIDEO_HI847=m
CONFIG_VIDEO_IMX208=m
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX219=m
CONFIG_VIDEO_IMX258=m
CONFIG_VIDEO_IMX274=m
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_MAX9271_LIB=m
CONFIG_VIDEO_MT9M001=m
# CONFIG_VIDEO_MT9M032 is not set
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
CONFIG_VIDEO_MT9V032=m
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_NOON010PC30=m
# CONFIG_VIDEO_OG01A1B is not set
CONFIG_VIDEO_OV02A10=m
# CONFIG_VIDEO_OV08D10 is not set
CONFIG_VIDEO_OV13858=m
CONFIG_VIDEO_OV13B10=m
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
# CONFIG_VIDEO_OV2740 is not set
CONFIG_VIDEO_OV5647=m
# CONFIG_VIDEO_OV5648 is not set
CONFIG_VIDEO_OV5670=m
# CONFIG_VIDEO_OV5675 is not set
CONFIG_VIDEO_OV5693=m
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV772X=m
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
CONFIG_VIDEO_OV8865=m
CONFIG_VIDEO_OV9640=m
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_RDACM20=m
CONFIG_VIDEO_RDACM21=m
CONFIG_VIDEO_RJ54N1=m
# CONFIG_VIDEO_S5C73M3 is not set
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_S5K6AA=m
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_CCS=m
CONFIG_VIDEO_ET8EK8=m
CONFIG_VIDEO_M5MOLS=m
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
CONFIG_VIDEO_DW9714=m
CONFIG_VIDEO_DW9768=m
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=m
CONFIG_VIDEO_LM3646=m
# end of Flash devices

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_MSP3400=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# CONFIG_VIDEO_TDA1997X is not set
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_UDA1342=m
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_WM8775=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
# CONFIG_VIDEO_ADV7183 is not set
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=m
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=m
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
# CONFIG_VIDEO_TC358743_CEC is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
# CONFIG_VIDEO_TW9910 is not set
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_ADV7170=m
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=m
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=m
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
CONFIG_VIDEO_GS1662=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_E4000=m
# CONFIG_MEDIA_TUNER_FC0011 is not set
# CONFIG_MEDIA_TUNER_FC0012 is not set
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
# CONFIG_MEDIA_TUNER_MT2266 is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
CONFIG_MEDIA_TUNER_QT1010=m
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_XC5000=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=m
CONFIG_DVB_MXL5XX=m
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_TDA18271C2DD=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_DS3000=m
# CONFIG_DVB_MB86A16 is not set
CONFIG_DVB_MT312=m
CONFIG_DVB_S5H1420=m
# CONFIG_DVB_SI21XX is not set
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_TDA10071=m
CONFIG_DVB_TDA10086=m
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_TDA8261 is not set
CONFIG_DVB_TDA826X=m
# CONFIG_DVB_TS2020 is not set
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set
# CONFIG_DVB_DIB7000M is not set
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_EC100=m
CONFIG_DVB_L64781=m
CONFIG_DVB_MT352=m
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_RTL2830=m
# CONFIG_DVB_RTL2832 is not set
CONFIG_DVB_S5H1432=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_SP887X is not set
CONFIG_DVB_STV0367=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_STV0297=m
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_TDA10023=m
CONFIG_DVB_VES1820=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=m
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_LGDT3305=m
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LGDT330X=m
# CONFIG_DVB_MXL692 is not set
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m
CONFIG_DVB_S921=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=m
CONFIG_DVB_TC90522=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
# CONFIG_DVB_TUNER_DIB0070 is not set
# CONFIG_DVB_TUNER_DIB0090 is not set

#
# SEC control devices for DVB-S
#
CONFIG_DVB_A8293=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_HELENE=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_IX2505V=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_TDA665x=m
# CONFIG_DVB_DRX39XYJ is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=y
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS=y
CONFIG_DRM_DEBUG_MODESET_LOCK=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DISPLAY_HELPER=m
CONFIG_DRM_DISPLAY_DP_HELPER=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_DMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=m
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
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=y
# CONFIG_DRM_AST is not set
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=y
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_DRM_SIMPLEDRM=y
CONFIG_TINYDRM_HX8357D=y
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
CONFIG_TINYDRM_ILI9486=y
CONFIG_TINYDRM_MI0283QT=y
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=y
CONFIG_TINYDRM_ST7735R=y
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_SSD130X=m
# CONFIG_DRM_SSD130X_I2C is not set
# CONFIG_DRM_SSD130X_SPI is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=m
CONFIG_DRM_VIA=m
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
# CONFIG_FB_BOTH_ENDIAN is not set
CONFIG_FB_BIG_ENDIAN=y
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=y
CONFIG_FB_CYBER2000_DDC=y
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_UVESA=m
# CONFIG_FB_VESA is not set
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
# CONFIG_FB_LE80578 is not set
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_MILLENIUM=y
# CONFIG_FB_MATROX_MYSTIQUE is not set
# CONFIG_FB_MATROX_G is not set
CONFIG_FB_MATROX_I2C=m
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_ATY128_BACKLIGHT is not set
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
# CONFIG_FB_ATY_GX is not set
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
# CONFIG_FB_SAVAGE is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
# CONFIG_FB_SIS_315 is not set
CONFIG_FB_VIA=y
CONFIG_FB_VIA_DIRECT_PROCFS=y
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_3DFX_I2C=y
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=y
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=y
CONFIG_XEN_FBDEV_FRONTEND=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
# CONFIG_LCD_HX8357 is not set
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_PWM=m
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_QCOM_WLED is not set
CONFIG_BACKLIGHT_RT4831=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=y
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=y
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_CTL_INPUT_VALIDATION is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
# CONFIG_SND_VIRMIDI is not set
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
# CONFIG_SND_AC97_POWER_SAVE is not set
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
# CONFIG_SND_CMIPCI is not set
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
# CONFIG_SND_CS46XX is not set
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
# CONFIG_SND_GINA20 is not set
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
# CONFIG_SND_GINA24 is not set
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
# CONFIG_SND_ES1968_INPUT is not set
CONFIG_SND_ES1968_RADIO=y
CONFIG_SND_FM801=m
# CONFIG_SND_FM801_TEA575X_BOOL is not set
CONFIG_SND_HDSP=m
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
# CONFIG_SND_LOLA is not set
CONFIG_SND_LX6464ES=m
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
CONFIG_SND_NM256=m
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
# CONFIG_SND_RME9652 is not set
CONFIG_SND_SONICVIBES=m
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
# CONFIG_SND_VIRTUOSO is not set
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
# CONFIG_SND_HDA_INPUT_BEEP is not set
CONFIG_SND_HDA_PATCH_LOADER=y
# CONFIG_SND_HDA_SCODEC_CS35L41_I2C is not set
# CONFIG_SND_HDA_SCODEC_CS35L41_SPI is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=m
# CONFIG_SND_HDA_CODEC_CA0110 is not set
CONFIG_SND_HDA_CODEC_CA0132=m
# CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_SPI=y
# CONFIG_SND_FIREWIRE is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
# CONFIG_SND_ATMEL_SOC is not set
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_FSL_EASRC=m
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_UTILS=m
CONFIG_SND_SOC_FSL_RPMSG=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
# CONFIG_SND_SOC_INTEL_SKL is not set
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
# CONFIG_SND_SOC_INTEL_GLK is not set
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
# CONFIG_SND_SOC_INTEL_AVS is not set
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU1761_SPI=m
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
CONFIG_SND_SOC_AK4104=m
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=m
# CONFIG_SND_SOC_AK4458 is not set
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
CONFIG_SND_SOC_AW8738=m
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
# CONFIG_SND_SOC_CS35L41_SPI is not set
CONFIG_SND_SOC_CS35L41_I2C=m
# CONFIG_SND_SOC_CS35L45_SPI is not set
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
CONFIG_SND_SOC_CS42L73=m
# CONFIG_SND_SOC_CS42L83 is not set
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=m
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
CONFIG_SND_SOC_CS4341=m
# CONFIG_SND_SOC_CS4349 is not set
CONFIG_SND_SOC_CS53L30=m
# CONFIG_SND_SOC_CX2072X is not set
# CONFIG_SND_SOC_DA7213 is not set
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
# CONFIG_SND_SOC_ES8316 is not set
# CONFIG_SND_SOC_ES8326 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
# CONFIG_SND_SOC_HDA is not set
CONFIG_SND_SOC_ICS43432=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
# CONFIG_SND_SOC_MAX98390 is not set
# CONFIG_SND_SOC_MAX98396 is not set
CONFIG_SND_SOC_MAX9860=m
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM179X_SPI=m
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3060=m
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3060_SPI=m
CONFIG_SND_SOC_PCM3168A=m
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
# CONFIG_SND_SOC_RT5659 is not set
CONFIG_SND_SOC_RT9120=m
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SRC4XXX_I2C is not set
CONFIG_SND_SOC_SSM2305=m
# CONFIG_SND_SOC_SSM2518 is not set
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=m
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=m
# CONFIG_SND_SOC_TAS2780 is not set
# CONFIG_SND_SOC_TAS5086 is not set
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=m
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_UDA1334=m
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8731_SPI is not set
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
# CONFIG_SND_SOC_ZL38060 is not set
CONFIG_SND_SOC_MAX9759=m
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
# CONFIG_SND_SOC_NAU8540 is not set
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8821=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SOC_LPASS_MACRO_COMMON=m
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
CONFIG_SND_SOC_LPASS_RX_MACRO=m
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=y
CONFIG_SND_SYNTH_EMUX=m
CONFIG_SND_XEN_FRONTEND=m
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_VRC2 is not set
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PXRC is not set
# CONFIG_HID_RAZER is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_TOPRE is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

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
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
# CONFIG_MMC_RICOH_MMC is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=y
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=y
# CONFIG_MMC_SPI is not set
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
CONFIG_MMC_HSQ=m
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
# CONFIG_SCSI_UFSHCD is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=y
CONFIG_LEDS_LP8788=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
# CONFIG_LEDS_DA903X is not set
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_MENF21BMC is not set
# CONFIG_LEDS_IS31FL319X is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_RT8515 is not set
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
# CONFIG_INFINIBAND_USER_MAD is not set
# CONFIG_INFINIBAND_USER_ACCESS is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_BNXT_RE is not set
CONFIG_INFINIBAND_CXGB4=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_OCRDMA=m
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
# CONFIG_INFINIBAND_IPOIB is not set
# CONFIG_INFINIBAND_SRP is not set
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
CONFIG_INFINIBAND_RTRS=m
CONFIG_INFINIBAND_RTRS_CLIENT=m
CONFIG_INFINIBAND_RTRS_SERVER=m
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=m
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I7CORE is not set
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=m
# CONFIG_EDAC_I7300 is not set
# CONFIG_EDAC_SBRIDGE is not set
# CONFIG_EDAC_SKX is not set
# CONFIG_EDAC_I10NM is not set
# CONFIG_EDAC_PND2 is not set
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_LP8788=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8998=m
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=y
# CONFIG_RTC_DRV_PCF85063 is not set
CONFIG_RTC_DRV_PCF85363=m
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_RC5T583=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=y
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=m
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=y
CONFIG_RTC_DRV_DS1302=m
# CONFIG_RTC_DRV_DS1305 is not set
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=y
# CONFIG_RTC_DRV_RX4581 is not set
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=m
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
CONFIG_RTC_DRV_DS1689=y
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=m
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=y

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=m
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=y
# CONFIG_HT16K33 is not set
CONFIG_LCD2S=y
# CONFIG_PARPORT_PANEL is not set
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_MLX5_VFIO_PCI=m
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VMGENID=y
# CONFIG_VBOXGUEST is not set
# CONFIG_ACRN_HSM is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
CONFIG_VDPA_SIM_NET=m
CONFIG_VDPA_SIM_BLOCK=m
CONFIG_VDPA_USER=y
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_NET=m
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
# CONFIG_XEN_DEV_EVTCHN is not set
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
CONFIG_XEN_GRANT_DEV_ALLOC=m
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCI_STUB=y
CONFIG_XEN_PCIDEV_BACKEND=m
CONFIG_XEN_PVCALLS_FRONTEND=y
CONFIG_XEN_PVCALLS_BACKEND=m
CONFIG_XEN_SCSI_BACKEND=m
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_ACPI_PROCESSOR=m
# CONFIG_XEN_MCE_LOG is not set
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
# CONFIG_XEN_VIRTIO is not set
# end of Xen driver support

CONFIG_GREYBUS=m
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
# CONFIG_COMEDI_PCL724 is not set
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
# CONFIG_COMEDI_AMPLC_DIO200_ISA is not set
CONFIG_COMEDI_AMPLC_PC236_ISA=m
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
# CONFIG_COMEDI_RTI800 is not set
CONFIG_COMEDI_RTI802=m
# CONFIG_COMEDI_DAC02 is not set
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=m
# CONFIG_COMEDI_DAS16 is not set
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
# CONFIG_COMEDI_DT2817 is not set
# CONFIG_COMEDI_DT282X is not set
# CONFIG_COMEDI_DMM32AT is not set
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
# CONFIG_COMEDI_MPC624 is not set
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
# CONFIG_COMEDI_NI_AT_AO is not set
CONFIG_COMEDI_NI_ATMIO=m
# CONFIG_COMEDI_NI_ATMIO16D is not set
# CONFIG_COMEDI_NI_LABPC_ISA is not set
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=m
# CONFIG_COMEDI_PCMMIO is not set
# CONFIG_COMEDI_PCMUIO is not set
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
# CONFIG_COMEDI_ADDI_APCI_1564 is not set
CONFIG_COMEDI_ADDI_APCI_16XX=m
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=m
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
# CONFIG_COMEDI_ADL_PCI8164 is not set
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
# CONFIG_COMEDI_ADV_PCI1723 is not set
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
# CONFIG_COMEDI_ADV_PCI_DIO is not set
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
# CONFIG_COMEDI_AMPLC_PC263_PCI is not set
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
# CONFIG_COMEDI_DYNA_PCI10XX is not set
# CONFIG_COMEDI_GSC_HPDI is not set
# CONFIG_COMEDI_MF6X4 is not set
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
# CONFIG_COMEDI_CB_PCIDAS64 is not set
# CONFIG_COMEDI_CB_PCIDAS is not set
# CONFIG_COMEDI_CB_PCIDDA is not set
# CONFIG_COMEDI_CB_PCIMDAS is not set
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
# CONFIG_COMEDI_NI_660X is not set
# CONFIG_COMEDI_NI_670X is not set
CONFIG_COMEDI_NI_LABPC_PCI=m
# CONFIG_COMEDI_NI_PCIDIO is not set
CONFIG_COMEDI_NI_PCIMIO=m
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
# CONFIG_COMEDI_DAS08_CS is not set
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
# CONFIG_COMEDI_KCOMEDILIB is not set
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
# CONFIG_HUAWEI_WMI is not set
# CONFIG_MXM_WMI is not set
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_MERAKI_MX100=m
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_HP_WMI is not set
CONFIG_IBM_RTL=m
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_THINKPAD_LMI is not set
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=y
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
# CONFIG_INTEL_WMI_THUNDERBOLT is not set

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_IPS is not set
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_WDT=y
CONFIG_INTEL_SCU_IPC_UTIL=y
# CONFIG_SIEMENS_SIMATIC_IPC is not set
# CONFIG_WINMATE_FM07_KEYS is not set
CONFIG_P2SB=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=y
CONFIG_LMK04832=y
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_CDCE706=y
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_CLK_TWL6040=m
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_XILINX_VCU=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
CONFIG_DW_APB_TIMER=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_VIRTIO=m
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
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
CONFIG_ADXL313=m
CONFIG_ADXL313_I2C=m
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=m
CONFIG_ADXL345_I2C=m
CONFIG_ADXL345_SPI=m
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL367=m
CONFIG_ADXL367_SPI=m
CONFIG_ADXL367_I2C=m
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
# CONFIG_ADXL372_I2C is not set
CONFIG_BMA180=m
CONFIG_BMA220=m
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=m
CONFIG_DA311=m
# CONFIG_DMARD06 is not set
CONFIG_DMARD09=m
# CONFIG_DMARD10 is not set
# CONFIG_FXLS8962AF_I2C is not set
# CONFIG_FXLS8962AF_SPI is not set
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
# CONFIG_MMA7455_SPI is not set
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MSA311 is not set
CONFIG_MXC4005=m
# CONFIG_MXC6255 is not set
CONFIG_SCA3000=m
CONFIG_SCA3300=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7091R5=m
CONFIG_AD7124=m
# CONFIG_AD7192 is not set
CONFIG_AD7266=m
CONFIG_AD7280=m
CONFIG_AD7291=m
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
# CONFIG_AD7766 is not set
CONFIG_AD7768_1=m
CONFIG_AD7780=m
# CONFIG_AD7791 is not set
CONFIG_AD7793=m
CONFIG_AD7887=m
# CONFIG_AD7923 is not set
CONFIG_AD7949=m
CONFIG_AD799X=m
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2496=m
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=m
CONFIG_MAX1118=m
# CONFIG_MAX11205 is not set
CONFIG_MAX1241=m
CONFIG_MAX1363=m
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
CONFIG_MCP3911=m
CONFIG_MP2629_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
# CONFIG_RICHTEK_RTQ6056 is not set
# CONFIG_SD_ADC_MODULATOR is not set
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_ADS8344=m
CONFIG_TI_ADS8688=m
# CONFIG_TI_ADS124S08 is not set
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_TLC4541=m
# CONFIG_TI_TSC2046 is not set
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VF610_ADC is not set
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog to digital and digital to analog converters
#
CONFIG_AD74413R=m
# end of Analog to digital and digital to analog converters

#
# Analog Front Ends
#
# CONFIG_IIO_RESCALE is not set
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
CONFIG_ADA4250=m
CONFIG_HMC425=m
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
# CONFIG_ATLAS_EZO_SENSOR is not set
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
CONFIG_SCD4X=m
# CONFIG_SENSIRION_SGP30 is not set
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=m
# CONFIG_SPS30_I2C is not set
CONFIG_SPS30_SERIAL=m
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
CONFIG_VZ89X=m
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD3552R=m
CONFIG_AD5064=m
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
CONFIG_AD5421=m
CONFIG_AD5446=m
# CONFIG_AD5449 is not set
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC2688=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=m
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
CONFIG_AD5766=m
# CONFIG_AD5770R is not set
CONFIG_AD5791=m
CONFIG_AD7293=m
CONFIG_AD7303=m
CONFIG_AD8801=m
# CONFIG_DPOT_DAC is not set
CONFIG_DS4424=m
CONFIG_LTC1660=m
# CONFIG_LTC2632 is not set
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MAX5821=m
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
CONFIG_TI_DAC7612=m
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_DUMMY_EVGEN=m
CONFIG_IIO_SIMPLE_DUMMY=m
CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Filters
#
# CONFIG_ADMV8818 is not set
# end of Filters

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=m
CONFIG_ADMV1013=m
CONFIG_ADMV1014=m
CONFIG_ADMV4420=m
CONFIG_ADRF6780=m
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
CONFIG_ADXRS290=m
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
# CONFIG_IIO_ST_GYRO_I2C_3AXIS is not set
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
# CONFIG_BOSCH_BNO055_SERIAL is not set
# CONFIG_BOSCH_BNO055_I2C is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
CONFIG_INV_ICM42600=m
# CONFIG_INV_ICM42600_I2C is not set
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ST_LSM9DS0=m
CONFIG_IIO_ST_LSM9DS0_I2C=m
CONFIG_IIO_ST_LSM9DS0_SPI=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=m
# CONFIG_ADUX1020 is not set
CONFIG_AL3010=m
CONFIG_AL3320A=m
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=m
CONFIG_AS73211=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
CONFIG_CM32181=m
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=m
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=m
CONFIG_SENSORS_ISL29018=m
# CONFIG_SENSORS_ISL29028 is not set
CONFIG_ISL29125=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_LTR501=m
# CONFIG_LTRF216A is not set
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_NOA1305=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
CONFIG_US5182D=m
# CONFIG_VCNL4000 is not set
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
# CONFIG_VEML6070 is not set
CONFIG_VL6180=m
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_SENSORS_RM3100_SPI=m
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# CONFIG_IIO_MUX is not set
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
# CONFIG_DS1803 is not set
CONFIG_MAX5432=m
CONFIG_MAX5481=m
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
CONFIG_MCP4131=m
CONFIG_MCP4531=m
CONFIG_MCP41010=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_DLHL60D=m
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
CONFIG_MPL115=m
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=m
# CONFIG_MPL3115 is not set
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
# CONFIG_HP206C is not set
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
CONFIG_SRF04=m
CONFIG_SX_COMMON=m
CONFIG_SX9310=m
# CONFIG_SX9324 is not set
CONFIG_SX9360=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
# CONFIG_TMP007 is not set
CONFIG_TMP117=m
# CONFIG_TSYS01 is not set
CONFIG_TSYS02D=m
CONFIG_MAX31856=m
# CONFIG_MAX31865 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_CLK is not set
CONFIG_PWM_DWC=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_SIMPLE is not set
CONFIG_RESET_TI_SYSCON=y
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=m

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=m
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DEBUGFS_MARGINING is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RAVE_SP_EEPROM is not set
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=m
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
# CONFIG_FPGA_BRIDGE is not set
# CONFIG_FPGA_DFL is not set
# CONFIG_FPGA_MGR_MICROCHIP_SPI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
# CONFIG_MUX_GPIO is not set
# end of Multiplexer drivers

# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=y
CONFIG_INTERRUPT_CNT=m
# CONFIG_INTEL_QEP is not set
# CONFIG_MOST is not set
CONFIG_PECI=m
CONFIG_PECI_CPU=m
# CONFIG_HTE is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=y
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
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
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
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
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=m
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=m
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=m
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
CONFIG_UBIFS_FS_LZO=y
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
# CONFIG_CRAMFS is not set
# CONFIG_SQUASHFS is not set
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_QNX4FS_FS=y
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
# CONFIG_PSTORE is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
CONFIG_UFS_DEBUG=y
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
CONFIG_NLS_CODEPAGE_865=y
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=m
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=m
CONFIG_DLM=y
# CONFIG_DLM_DEPRECATED_API is not set
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=m
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_KEY_NOTIFICATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_INFINIBAND is not set
# CONFIG_SECURITY_PATH is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
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
CONFIG_INTEGRITY_AUDIT=y
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
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_RANDSTRUCT_NONE=y
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
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
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=m
# CONFIG_CRYPTO_SM2 is not set
CONFIG_CRYPTO_CURVE25519=y
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
# CONFIG_CRYPTO_ARIA is not set
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_HCTR2 is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y
CONFIG_CRYPTO_ESSIV=m
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
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_SM3_GENERIC is not set
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_VMAC=m
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=m
# end of Compression

#
# Random number generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_RNG_CAVP=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
# CONFIG_CRYPTO_CURVE25519_X86 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y
# CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
# CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
# CONFIG_CRYPTO_SHA1_SSSE3 is not set
# CONFIG_CRYPTO_SHA256_SSSE3 is not set
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SM3_AVX_X86_64=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
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
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
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
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
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
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
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
CONFIG_DMA_CMA=y
CONFIG_DMA_PERNUMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
CONFIG_CMA_SIZE_SEL_MAX=y
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=m
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
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
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
CONFIG_READABLE_ASM=y
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_OBJTOOL=y
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
CONFIG_NET_NS_REFCNT_TRACKER=y
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_TABLE_CHECK=y
# CONFIG_PAGE_TABLE_CHECK_ENFORCED is not set
# CONFIG_PAGE_POISONING is not set
CONFIG_DEBUG_PAGE_REF=y
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
CONFIG_PTDUMP_DEBUGFS=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
CONFIG_DEBUG_VM_RB=y
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
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
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
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

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
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
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
CONFIG_MMIOTRACE=y
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
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=m
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
# CONFIG_RING_BUFFER_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
CONFIG_SAMPLE_TRACE_EVENTS=m
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_TRACE_ARRAY=m
CONFIG_SAMPLE_KOBJECT=m
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
CONFIG_SAMPLE_RPMSG_CLIENT=m
CONFIG_SAMPLE_CONFIGFS=m
CONFIG_SAMPLE_CONNECTOR=m
# CONFIG_SAMPLE_HIDRAW is not set
# CONFIG_SAMPLE_LANDLOCK is not set
# CONFIG_SAMPLE_PIDFD is not set
CONFIG_SAMPLE_SECCOMP=y
# CONFIG_SAMPLE_TIMER is not set
# CONFIG_SAMPLE_UHID is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
CONFIG_SAMPLE_VFIO_MDEV_MBOCHS=m
CONFIG_SAMPLE_ANDROID_BINDERFS=y
# CONFIG_SAMPLE_VFS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
# CONFIG_SAMPLE_WATCH_QUEUE is not set
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
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
CONFIG_FAIL_PAGE_ALLOC=y
CONFIG_FAULT_INJECTION_USERCOPY=y
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
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
# CONFIG_ASYNC_RAID6_TEST is not set
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
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--laD6gYvoCVUaTODo
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
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-next/master'
	export commit='b38994948567e6d6b62947401c57f4ab2efe070c'
	export kconfig='x86_64-randconfig-a001-20220418'
	export nr_vm=300
	export submit_id='63658d8d756f6e689c2bfb38'
	export job_file='/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml'
	export id='1b2451e4f580a666745801eec59a706ed0ab1bad'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='quantal-x86_64-core-20190426.cgz'
	export compiler='gcc-11'
	export enqueue_time='2022-11-05 06:09:18 +0800'
	export _id='63658d8d756f6e689c2bfb38'
	export _rt='/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/8'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/quantal/quantal-x86_64-core-20190426.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/8
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/vmlinuz-6.1.0-rc3-00010-gb38994948567
branch=linux-next/master
job=/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a001-20220418
commit=b38994948567e6d6b62947401c57f4ab2efe070c
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
	export modules_initrd='/pkg/linux/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-182'
	export kernel='/pkg/linux/x86_64-randconfig-a001-20220418/gcc-11/b38994948567e6d6b62947401c57f4ab2efe070c/vmlinuz-6.1.0-rc3-00010-gb38994948567'
	export dequeue_time='2022-11-05 07:01:29 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-182/boot-1-quantal-x86_64-core-20190426.cgz-b38994948567e6d6b62947401c57f4ab2efe070c-20221105-26780-hvpjtf-0.cgz'

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

--laD6gYvoCVUaTODo
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj455pl5ddADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0cBaGDaudJVpU5nIU3ICatAOyRoDgsgw6LNN2YAnmjHievX0rNT00oeesrfk+LA5Ri/BoYQU9hfY
jq3XZhpzFdN3+nwxa/OqivKfiLAOeEsPXWdikkFmgLFiSTtMfhqQVlHx1Hny7Cw9uA3G0aTnyllj
5qXzd+GSONxywzyEZgN+Wz8p3QhA8vMPmx+7YnDD85NWFORESsOTJDPQnKGTdtuFWWMV8EbF2kR8
Je1VQyWsWNm3VdoLsOb8Tg1ioGXpHduSIvvSgddiox3NG9pSBxpt8C0gDsOcsjYZkd5Ur3lhom1e
dzBdTbeiZ50Dx3o2xLspkg/+kys4ABGJkG8rJBPgW+hOx/5P9Ou8DXPiEZoD7wUATKQJXkcdfP+T
ejkbeI/kzHG/klT06xm8YX/EYwal6wIS/0x8kZvUoq98D5+8F1rOZ4nWZua9DW3hXlIO4b1eWGKj
CQGZGH+AXgfe3cw0u/fV82maNeZ0dLBrh6wPqR0tIKQ5HIIVwm5pMLMRbrwxTCFXJ9jO9q4VRJUa
elquNZjdQq68MpzT/Q8vW7jFJ6FjfZmanRbTnJX5xoheCECRoLFZD04or7ajrOmHdVi/68KqrCLv
LD3Ky6W5Fg0yHt9/RMlhfEx/ov+l4bTYDeu6yJTnPWuhP5lJZRdubClEL/tGk7Ef3Bt0VAYvvwsa
pb8BQOq8dDanxVwDD2HI29NjiY0AZSl8B0IzV0B+cDlx8AmIb033nvIfhGiSryF+TjRRqMk4RV++
Yw+zMbNvFMIa4UsNoaYECvukUT3N3zNnS0tLqXv4C7J+LsWw6eNKs38ox6Ibvz03GI6zXCB40MyC
icG7Qbd5uCI/R972Rv5F60B4iST0W2u+LPCS/j7mNhS/lqz9dxqMgKrasHQ9XTNy9hAKmxsh0YYP
449ngmtaVMnx4jqQ5TsWjs0THXevimE7CYNHkxhWz1yZHqlKmndxIG9IWIXTfAjOJeJXRXMy+TU/
GzTljO5hm4D7tqEI4rulifqrvFFUWxOX2+1sLBs0kYPWSqSJYJzDaptoSeC1Ew2GUzMRWJN3JBVB
Z7QGm02yhWwCXijRv/UdsnpbPIPk52jyFgbJIPclQg43yNw09zaWZ+xHhfSDiEDOtNYdk1rWVhKK
2AtMS5EZFUnjxMSCXz8+yIu8Hm8iU++m6o05pPxyHsq2Aeha1dpJU4anr8jWlDyISiLGCWU3vdih
wqkiTCDAz4h9/N4LS1BAowwyxQrxWQKezUGZMD32cPdsyDWI6l3c2PhRLrpqlPQCzmPFSTu8BBXX
2/s5qsA2IQKwNkSvH1icWRRNkF/1kSyuCIxqcl0LIXWImhQmKOPAYBzifL9ggUyw0bI2Y5gDNGvN
d/ZiVRh/KrfaOMPpl11XFxkdNcAPV2KWiMuxvEU9T64FeqhoTeDuXuRmoPCQ1NCrUJ+TwtuuExcy
UHWE6nwD4wYVscixTrktRMH2mxVRhArxwMbmruTA3v9rlL+r309lHo/lLM0voMvXA2fKHoRbM37R
lzDHCbZ4yQw0IoMyXwA/rztFOjZ9shtyP5roZhEpIMONsPSq55USkVcx5Uu+ChcU5sI/KKBQnRTL
vd8L5NNmMzE+NkQdRAiuRihmqJwX7qMhVJ6EMacPGOOKlLTasGGFS9eDz+UgNP2LI+t0+qclzqzD
R5twDBuNHiGaEu35/gg6Lpe3PXTFIgfQ5GLctxsjLYvTXFw1WRSqXSFNatjJak6PLbEpDV1LUee5
RvhRjUQbzCn2Ygh1iS72G9Vf2B0cM8Yi7z5iUl50hV3v3HyMb5t+FBLTCARVmuOrMjEvphKjgleZ
byYkL++FSvMDBYDXcxYku//uWoGSfDZ9J9kxytjAWfLP9Fjnm9HW6EMWmrBI71gnTZkiR7UGguBG
AkYJB3O5xO1gztlYkB3PN+AhmlJF7EA7SyhSICRizvY3dx1zc0VrCexjbpfxVyPMcMElja+DRqbj
BrRV4owAMEXW25ivlBJc9v8Fzxl7cDYmL7ilfjLfLdWUtfa30G3lSlc4aSXekQtcQOvYKcF0gdWk
hkCb0cChpdHU3bJVhjkJQaWlrKShXq3/xmSEPxj3rZO2q8enasnnGXviPKG7wDG2/1ESlsNeKYDR
fIO5wMUaBhMxL8Zi+mFTgUMXgaaeSDy9h2mFBFBus5LS65peEX6rFaFhZrTJpsf0zbVkNslez7zH
wH9uOz8jcaraJeANZU2M6lk/nlhTBYnQuhJBZR6wt5V8lBwJ9VW2U4jpZ5XXgFL9CIVkUm7IzFk2
jNSMXChd7RsduA2r6h4WbRCBNEi2rHvp0oFCyficVzFpmNc6n3h+6W7hP2FYt6X5ppq2LM6i8h6r
xquy7qQUym8p+YdlVhwJPAe19y7OAUr7U3xArCJxwBJnsFvSrz9yL0VNjuikLSc+nVjpy2Yqf4N2
bRD+uzj7nvHkT1aT/DS54Y0f47SFU4LcpyxMDIbZ2/j0vS5SsXkCuMvRkZNM5+mwZGDFwOhUfpN2
c8ogy1/+MHrexITvTOUWq7ksWJuZahbZ9bMdM/m0rKAZV98Asc8ytXgg7p7lL8NMv3SiMNwMtoss
cckqoDA3I9ADz3KwELF5i9gWXAxpVXh+6+CpGawdXONk/2aP9rFHuf75SGJWOBT/Zm5zSWs5UOkh
zkiX9OEBONkaRt8jEstt7dxha+xpW5Tia6C+kGE9c2w/Qo77cbWd3uh2Ke6EdbwK6SavrbPdpjz1
I+/aORUvlXTqaQmXn3J+4wrBjD6lJk2yUvdusbBj6eLWuUP2PO22q/UQNEbzHDBF5l5x1G+sxFGu
0RxKesD1Hlke/DS5OYqE34G4w6qlfRUp9de6pyGsn/yoKwW7tSO+Owe8aauWibvNpeh7y66yK+e4
4hW+Ud5mngH1T+lH8jOR/eILK58090Zw5q/3bMgFZ0W7zzJUcMdbgOehcVOcsP2qoxPMB5HYMFC7
xy0f1IGVWnSH0Qtmj+dTfyqalwFeWv467vQlCiWYhGDpk4xJxff/p5SUcmb00gnQkzNvyMEwOEJk
I9/FMvqp+ilsdU863txufTW+8IpCNiDYlk9TP1mVYu5xD9RUBmYBVB71m83DxLwRCfX/MxZ/rPCm
U3s9Jk2PQMwPRiFm/3vGL411wB/d3VgwC43X9J+f96856WT9kiFCrbaiLjvA+ORkknl6sK3tPvmO
DN+T5SPXjJF3qB/4GGHil79ppoMavyMMF8hq8wDwP3LUpY4BUIq9izxDU5gTTJaxjU/hs2R03o8O
0wWGuxaEz9D/bXbmYLDs1LFaSUqUal4Az1t0x2pDnoMGueb8wuF+2MkPqQeiTKBQcy6w0U86Q7sA
AjMeCPwT3w2Y48P7PFoxSlnk0O2kB7yA0CXuOAUBxbJlh5/cFzNMIYCJ0ZfWZ6uYzyLyuBUvtIOe
uCxQLfLIyDCdYUMYm2Ul+NE9AeTiJ7Ip9rNkG5GZUhe3AjpUAs+b4aCtoiIOQnToUqt5B2fnp4oR
l07FpXBK59C8I1MmZiQNFxF4NoYUTR7I9A8w7p+/he3mf78gajzmigkDYFqoYYppRaFlX41JwrHy
tUi987PswdwXdC0Ww7LE35H1gHc4cFKQ8IvJPCW+DSDbhAPRDJt04yzauIopWfK9oANzEk6+UNjK
epMfw4gtIVcbt7oKl0LGglgGQCaSrBXtHLePTYoKulw6nlUpHXbfUPuKwNCpkaxXZgiNDCAPNxaM
WAOj6lDBf0gGth6FNnk186+4EAdrJngDB0l4GL3vns1yRzaHwKUL5LeEMGZ4MohxM2ICHdHtn8E8
/jk7BPXrUtxm8NaE4CkXKf9X6TCdzU/A6rp7HGlJRWTHa4RoTTQbjH6MCi8alabqFuE77Zqlg85O
f88lCWGMzOM4/juqh6x54CRnguNRXijebnuBkGGP5Q8DGJVo6fKqWbkfny8S5fc6k89iscjMLDg4
wnVCGXLkCYmmkveRsi8cOm1EAiKz98EV2mUZn0QwZ4kv8HA+GpPekO5c1o6l7efs2nj/RvjBELA7
nIZ2elK6ONDFYPlaG2srdKfztdFdPEHolS4ZWOmOos8BGTPmoZ3+eRu5qHSqJLkWZjhXg7ZyjICK
aSZGkSanDjHGlBgS38kPzkX+3/DphVs4TJ7JaufgIZeXSdUetSuFc/B9eQ6reQVPYvJtCAkb1eyg
go7O01TcFmR1vX/dRfdHyyAeG2roJOdm6OonTjzaHIr7ey1N1PDm0i2xm9wHuqZnYypN3YunSLhO
OeI/O6CiDZJWOwBjpb9YWk3rQbwsAMYcQ8HTKYrYdR8+2i1qsBmUqYNPbUlz3HEkUkROGgOqnbY2
9CgcLmkKys6bslBHihMFvORFekqNp9ilzYz6qtRJoaBeynhWU35b8xgG0uK/dWUuGQkRztniV5+3
Tc9CnBGkB/3O3hfWZNPOVwIwOHiGjI+V4hv4bunc/JvCs1Dt5ybqbQ4/1/a6sMISA1PinHEs+KgF
txqWK3KBHCOFDiEbtRaY8h0/jTm2SYcNsU6IwEqYRo5blVgTpndOz93R0RtaTQXqa5CeVINNScEG
jiGUEG6EqS4mMdeMXPCB6+it3iow5eAt605aV+eF0EBBqXmYnC8ZQ9i2z7JbY7TtAKfvOXIb7b1v
UyThU1bHmgcgRyaM2N1Cq/uRGJW2AFxlL0LZ/d4gUHNkJpIyl/9iHIPrx0CV4qqvOMaVd72vzq5u
hHeh5mV0Nq42Fp0u4Lie9JB66q++MYaJWzTpe1y/Xj/f+1wbRVAFct6wCuAElcc2dj0xJkQ77fVb
T7X6X/WQclBCN11vn2E+7ZM5TJIY7xMri5qCF9ZL3BRmQ+xp8bN3sH9hj3tyyAXtOMUW2NdVq9hk
kdgW+vOUuuZbFW9W/kWtHZbgOPyjO1/kbDO3PmIHhm6TpfputQmP6CzldeLpTRwHAk9QlRkIcQvm
lZfLZapuygshH9HPW4vjfIXMjei4K8snOjpjnRCf9DUiaxXXWqf0IpPEczhHCl75cyI3SaQ0yCzA
9nL1kcJVSIz7+sDd9HPPVjoem02O1lrSV5GIucIGuev0JLN2JSyZLoETSieTuqPg55e6w+YJAzLJ
cS6YeRy4TyK9uMCrKZS2nV0HeDZkZGi/MNEoFOzojRKckEsn+SjOpqMEslmuX20J2oWrmbgZ2uxP
edYobkML09J9OmXyVC+U9xvgzlhI+O3g/hxM8LPWInjf3XG7ylM0R9vfUdYrf6gsRQmHNxO7j0Uv
ZZD8Kl+vQuEsa2otTZ7+gYetJXhHU2DawOmZNpb+SPdpCiJHXXFe+1CV6COcfR2WMm0i4PvhA8ca
ebW1VXIBiCz8p6N9vBIDfJbJ/6pCD9SgAwKskpy6s7SWBMLtloqt2N4YAYY2UKC34fSYt4TGgQop
Pxf89+kZon0JFczwmxpim2UkM8wDkWnfRDjAEAu4CzoaezXBPHR47b7qUvypm5ghvxMQH0nVLH59
o2kNIVuOagbHSFV2WUuIIq7uzpDtD48Gh2flz9J3wGt6lmrL/BQWg8kpeR0yQsrllSTVKh8egoQd
FRWXgFYh134aI1Vn0bQOIMv/CoGRiixV25eoaTxv7VRskU3iDNfOBi0Byj5wzXWGJtDDcI0jQX48
iptamPTsjwHncsaZDnn4WAigBNyM9e8wQweGsVRIrkI7vtMtNQP0BB7x0EEJxRKo6BAZPhz4s7iD
LeXXSx95hLuhzFqRuX3CTn/1TGqJ89aEk9lSS2GNghZa7XjmwlKiBUmeUfQ0RalFKWAS+UJhntWN
lqt3lgLwjSwnbFSUyH64bYKofZNHklJun50eJOILGzW7f/nwNffZeAGrinfu9vzDkUmmHTYjwN5P
urUq2WPdnFHXa+8DTEhqOhGg033XrKhho2W9dAZFY5E5l4Z+ZoRh9Fd5eijNOBy6gkqzg8EuE0KD
qvEYVK7S+xT3vwpehmhZQXQ2txxVa9mv7SSHjKhc37pAKMiGUxyAklr32czjhKqas3L89v/HxXdd
wVEp1Qg9TaJofe/2qne7ttjBOmwiKCOvwtztXWvVBnaNYPCmIr+m8j8CIWYKcP3YDiVyzd7HnGho
VjFbavKAkPtqwHKL4hiLGwyAdd5LHoqk4p0qEspurMYJalpmBD/Y00q9K/RWrDeJRqQJsVUFy2V5
zWkUxrlJNWav5oiMFZOp7WCx8d9YSh84VQS+nIlzLYGhADRSoaRh1tZYaPNxuFQ8Y3Hv0Uab/qDm
SQaDBp98sLkp8/sRNXIxyZ5XmztWECOtU8H6H6CrEtwqZE6NxLKwtmpnp6Y6qsZ1ZQ7wYURayB0j
sUZ7omuhOC6faFCCGKYdyVAxnR85xVzUmekw9s8r5cDhk9ew/M3VKUf0ILRLEfS2k3e0NNLrRmtI
x2z4TOoEPZ4o74Dz+LdkKTrc51tJXdIZHM81SOwX59ejvYhiGh4o/6wyXeeDipfDOwT9slSKkUtt
VsDwmxai7W+Cts+zr2Nb2bR0tFfWu0dFyp430PmiGeojIG0FJ5dLgzDBDFz7D3PsTmHDcEoBB7at
TIpiQSfhJD/3RE1MIvu1imPmI0klmfFDH4SYKatKBMXblbnbexKTU1FRQfYKz8bIpfIUG79qwThq
sAz1rRFr6Z8W6PkWsOrWMkGu1fuyLKz9U6O2tGFpSdlPA/wPuIMPyKNeBUrJQCb2zEA5FV6PLBDF
vZcPvvLr9pzRETXuohq9c7TjO2vAYlJW4VHu9UKC51MVKj/rqKA7EXWe7M0jL4UZSKNI3LLAZazY
p9WcPS7rVkM6xTBG0eaXfEbr5kPQMQKq/clkFsbuJ2IozS2mBzaWWnUxL7tqVP7Z+JJtG37fx+Ap
Hu1KgJ4P7YP+WQURu6PWIG0JClQ3RNoN8TIv702IMtf2b+hOJv8LPN2HU4Kj4TO72xn6QilD6mHk
JZQ0Bm4ielyJ69GRCPPMAP+8nK7Ldd1qb3+n0I3CBseVPxhogEyZ6sjo8ZYLDEd+F0BYj4XEuznV
W3VIJ6MMiM3wh5i/8SCjxLVCssdoBdUjWbW0cTNsELcALu2NqHTmN9GBCbWLGcQ6rr0amrLUyZ/7
EpsnhoZXKGnp1fOvQgMzPPNnDETBDpJ5QQlVdHrUn9G/vRBvCrPOlaqyCtqzd8OSECQt3vWwlzV5
ugO5Sy+ngTqmfewuoirLgyQvT7F+ShUmlFdEL95s8EjbGMZ1D1hDce+jf1aelQRrDL+YvA4M7VL6
N1OjQ/5kzsMAQ7ASV46XwMx7XbWdG4MWlKr1cJ4fj+QJ1ixf7XFJWpYGRJwL1LQohpLHm3akZAmF
bhe2TMPX941EoSZ6CJhDpG94dMJMKyfD4jmzC34DqqipbwB/eOL7OHsyULZVY93pqJSnPc5Xv9Rc
J1n2amRoi2t86rL9iDOwFoh1QBdLBYe9HHGp527Ly3pBbJ69u1Bj4UpU6VSanFrinr6hPObp8p4b
5hlq0SeDTGjhFcSjnW8rRAuc07zFgNGY/1345wegY0qwS0340YWNdrLtJymNiEAcHJLONs3huEaU
rYScklKGHNXw4bBrFQRRw3vRM2CBl/coTbrAq/U5LFiof2jD/LeXIE1+zJG84us3rafIl7Nrrb0N
InQx4hEwS6rvtDfZQlb13nF3Cw0txBrNcrhwDS7Vifx83wU1eD/y184gb4TZUKZ8DOHByQqWmVuN
VGBgNgqriX6QcMMgkJGW7U2jA3JhZzzEYJTB4y+gvealNgX/bSS3X4gw+9F/BqNNL8L/JF25rhKA
iXrdDfJ+QFRHIYzLzhy46AHkeT8hIbVKF9DT5PaxrspWqBNJAUPY+DvlN8LD0Uk5OkriBz3EOrG+
yVcJ5alNOK7VziRPGQf7UaG/6YWaTe0rCj/4x1500dvQJriwbS/YVmLsMMc8u9JWdF7eDP/vVFgk
C4JbtFhiP/HeD9iBkjtIcw/wgf1+2nU/sY1JAJYgWozc2/RBmRFPCESFuGEaN9bQQXF5WuBzt+I0
snO+9VUAceU8OzlvQqCH3/3Q0PUbk+4CvcCqYE1EWLMrFQIz8pqUHLinyqo5cQcRyfmwrl2z0GdP
q4DRBjs9+I85DbjS/r6qNEPlTke28rpGEK0HRnfZzeTsI7BPQjAwXItXVNVw3dpjwLjakKgk2XEb
dz5C7PGN6svR4cLl45rLDBxI2CL8NUqnBd7gZnNWPK4dpTpGsVIxUagu6xv0hTNYUlqxAt9VRFFf
SgJmkeGSBtdBGR4x41/E2Jkh5imSn2069t0j8TO5PcD1POIQ2i2cwyNt4u88JfReXtIV4Q95xxKJ
f3174NnTQv6FENNfU+3hMoxO1SHmHNB9rRR9Amc+6PUct57+Vi8bQB63gJoxoRbGYOkQy2FEWDlk
3W7t9c5bMDCTH0JyxNx4kwUqCoiMM48EJ75cToOAJfFDYZH2Bdzi2t6cbIyMIrQOY+ziIeS56Ag0
oAS/9s0w3Ms/vWlfmJNNJRDbtuJfqnzwsLQflFHh79qM+wgocG2WZTS4+QNN3wdg00gX7K7630eZ
QDyJ77Uj9M87nWxzwPpJ9rVDW6FgsDOh9kRiVL3fz+gOg+IhwZQbvmBW5rvH5osvxjyPC6Zc2z1Z
e7OYN1F9a40ANXwYIP14Y9uMeXt4EYQouQnHjwPLUiLGaibmuU52w20Cows7MepK3YhZBObRwlrI
9cToJKtyXAyNVCQrWSq8bcMQjKYLFeiMTcjo0YqUUTmfccdbg8HBjopgxfQWlY5Qd/HUaRIVFZP8
yrTlVBeWargkFWKGevMbub/y1LDUqU+S8+7pIm5O/wka6C9Z5Oy71Yd9LNhal6cWM4+tkjDGRfmb
mEO37MujreMddcqSoDbD2USqKVhpUBfK8Vqr9s3mp3gzAI3SFQ0piy4beDOmdZYtff2pdQS35vhf
wudspNnbS3pjNaHVFMdcBZVvtNS2HocgY+ta9LMp90Xxh15EWfOoAdgdMh9kQwYEAymqSjvb3PeN
wuxlcfxIwZUxviexZRhIfx6xKaLdf4ZzzrtpcBJJK62qMB90Q18tgkTkKcEnjBQ+zUPGgquh3DwX
qKPUFUlQr333sLS1yt2usWwUoaLjzcOn9qtUd9EK2R9P5HDNMyMCv6YhvO0zpeQpGDV4o9foaka/
TOdqwKVL7RbZzYSVJOWvEKzF9U/Askn9sfJ1J8PzeCzowenAkI3S1J1KOtT5ziuGOWMXHD9mUwLS
YYfdHxaW2AIrTitE8lkDbiW7wvO1HxTQlwMzVyrdPR+TzE+8hGiPsTmz20UffBWRAQb9QPLLck5k
GMSXjU39Fqg4GsWsCgo6a6RPGPVXJcJq4SwQc7H07MOYsZNqa0ICOEqeP2ZXA5odHt0DrjSTvNoG
/uvuhqbB9dccFIAlNp5KHIJZkTLpzne9xXWOG47VV8FSRTnPLosQcgiSPp7nS8ODpzZ6JeHTqyt2
eHWy6gUyQb7w1DZjFb3gaEHG2BTLUzzf55yUsVdlj0PnfLGAS92ii6Gh+6kK0lG2ZzNRJqBs+yAS
FZzkEmMg62E0yKZbsTZeW+M+nzNJBeVLRQDUhlMATlCpiCaVivsS/RzvS6lWfplnJrVPmxDBQOuA
6xe5nnGUjKxMlFxf5jIIk/scsHLZqt0ZP1PEoy758uN8d355/6SY7e8yAXkHO+CK86G/yCcyLkVT
CM801jaU1qR1SrvPbM1EClWESLKQaofryw+NW7JD+KwWVQIckQ9bVcoK4uy7EVWcWmHGQ+2KYVss
ojUrObEPXFRutp5eCCFD9mfEEzyB9D03RMZgPmUYvSJE+N72RLnUD2tsXirtV4aftt6MVD2z+juK
tOiYUqgdZN/XquBQuCVduKxQamdd2dMdJPma+mQkNJhqSvrgG+UCIshUioJTOiBJRBlB7gN9Vir3
xLz4VtEzxrUgIa0KL84jG+1/5GHcqd5vpu1aIUkn+NB0YrsAdVhGEVFv90N6XvYNfKgLhfKhhDK1
gSTXQSyB3b+WS2t1sSgNjBrJsM16/s+DrQlu8BRIE52VgJ4xucB78A2bE/dzviP7lShUyVWJpPN3
r5GIp6Vaz0A7vbCecylhe2brN+V0z8WvlzP+bM8B7qqbtzvDPUzq2VZASBc4ialMFPCeyiD5wbCN
ngLZjhDwV9m9qw/VBafuXc3Z9vNsSAGhGlP1ydq8QMHy+VSaWcaXb7xq0qsfWFpfx2ahRTkUpt3Z
J5NbN9OvFSdafo3qbvvczumUyZDDQw8eXlRaFdhvgUzR6Zb23M0aVgpKZHFapoDe9QmKCWmSoTrA
02nDOPTU2OgopBpFYYg5zagsatnFVCWK1VHk9IcyMfOz52GrmxQLEPMNz7vg9JjONxIE6dpeopw+
2BGTbLL/kuive2bTHoIe+txNz5hlMbqqf1BZS+w+DTK+xWIod0bIMvlWvqdob/AQocBgCF4qVUiD
7eLL4ZgwE52szrcmyRdJKNiWOsmv18VR/cGM82sR3zGgFXj43MB3t09rANZAzCaPNle2zigqvt72
WekzI7gRcT3JxtRINA12D+pscLvEa6e1pxfM0rpSxUr03K2GyDVBUCa5+wh0bE19IUS1epctDXtB
+YYDkpye4pbdHG3IkkRCxvscwZDzBIr2hBuTEbfEmZOgMcjJyPykNLKcAlCYimWNUAAzzBWgEgrR
nAUFVIjR6Q4L8ZbN0XY2UNupscPYKSVk5GJJEstgQdtpCyiNqdJh29RljjwL1jNc1WUdQl+XJwM7
0bFfOqr2tM49Ey74i+SSBkMoZRP9b1kjLefA6JiYZ5UkxPkIbybQ3UY9Cfj1GXhL9LGLi3XdHlJ3
pON2yzpLpODhhZMjdo/DrZnCO+tQe5Z54lgzKBMFLTDmaK735c0L6xr+TBcP3GD89zn7SLQy/d0b
gXuPMxXRIy7Cw5V5RuyWHkoKK46x8vHShYpo3bcIHjwbZK1dBc7Kc3kmRpFi0U3s0vqi93P0mJMC
l3jYw82R5uCwJNR4+1G1Vamgp5567j2Wkmrfz6Sv+SJkSif76AcwdNS/Lb4r0F0/ZdOdUzwH/2zF
Z40auSMZfB9gKMFxN9yYclr3ECcAjgA6JlI30TmphS94eoE/Xac89IQtwsNqESYCACfMr7iVQ6dA
JQlF36Tt+/MD3psv8NFuWzUhrqjqKjwe98QepLas29P+FGnHw26zUuSrlJKKUOXuG4h1r/PqDw1R
s7NcOPG5IfxlJcj69jxinvRPe3WFPBjBR2FVWNaKFE4R31vHAxHMy5fj2qCpf+Xtih6dAiRPCv2x
zrCzgG7w08rMrrx9FGt3sv4X7F27fsJw9dTlxfZTAYhdwOfU6+Ev/ySN/1XvFBpmqkY7x/aAkfH2
k4rzuoGKchopmwzvN02kbmdawtixSCTwx4U8frO/oNM4Z12I/bLeTwNogKO6J6kxYwPDaOExuPr4
UPZiyIglVnGEQ/sjNLn2P9WKi+lvhZg03QPUO8wXmG376+0f8ZQDyrCmjaHOAIE+2fuw7eJiV0A7
NcsJMVp74jZTuYkT2oFYjMkS6Izpae+PrCldS1U/+M1c4H2g+1mQVZvs71Kk01nCorU5u1N/GuRt
9M9BTcbBsfi0UffAN17ymXqTaMm7aBVcFQUcNMO1j74KG99wUcNmc9jd4JvHL193Sw2q+AFDXbbP
6mvwO1RbuScYS9BeLoqN4iB6dmfj/KfsopyKfSJfdveJEnCg+KTHUSFZ9QpFU9eCHleYUcU0KALo
epVMVkvm2VSvOeGVdPwbZ3kITwKVESL8UPWoMzBpPRzm/vXjKhQdNH6lbcK1XOqz6Ns9g+ZjKOGw
VovIF9VaLIo8YzK+I0ntsCOmvi4T86IaEYHpivz5JdgA1zPbj7oOUc7RReKf0ywb296jqsJf/+AF
Dk7gEpubwivfowwvb5IhlZ6W6IPdhUiC3tZENp3t7xPEA2cTKq+B+Ngui9wQD0ah8PD3ytIiT7uB
xPBYWcI/rp/K59tBXGvxd4nAfholeU46j7NFaig99NLSgctdn2hkx0UK9E914pT74ohWeN/tFMY3
ZtLjE5PnS3l440FA8KsnzVLa0mdvM0KCczovDVVZcjBoZqxPH9oyMRD0c1bw9rP9cbR10dZXFwc0
lDhwr1IvMM2OIfnPYi/dkDvho2P+gVPN0FuxajevGTOrI0ZeosESps0ali/kW8u/TspY2NKRRqTP
JXUC+v3V/hbxK+NyINUxS9EGKzFxdJc5q87V99s9gNWYmLkdboN5ClD+VkpmWXSC+0cNMle0XxVT
Xz8Z0mYNxBg+B46AXveVpfIZRgeMt5Oiw4ulQLxT2dlxDDwDxinW8zL78nTLSXhJyO4I0LTyv9Uo
k61bV0HY25DyU6u0AvNhwUm1W7rvgo5Z8pCrogP3bClGU4yikhGg62mK9fWv+Hl3KSJi1dB6I6T1
qNoab8Q5+QfFXqqsML4Ob7rKEM/5o+x+xZepZ3P2xLSTuftzCDM6UhdSUrvxgAALrFhpPkduqO0r
jBejlGGIWEwuFn1JImMnZblFS3uRcAima6tIXD0Qk6Rfkwmoey/eAyo+hwnkIGcdLBFhmCn6Tze5
Kj/KSl1NIu91XjVsN6BXlN0M3HxRw9BOd5YFxo+gy0eKpbkjq4/ho/kD5J4aTHwfBxtVHxlpGhVW
fJqvBK4bSG0iWRvkPS50vJ7o8ONlHx/DH9tLWfDRxu2UWrHehzOgNOtlKN5XLcMF31PzLjqwxSWx
rNfBwdjf+TgoJh8pnVVghNl6QYOP2xkMJ8qft8oHLtPKwXjbPYbMWtiz75b5xhdKxO3Tbi3I9UGW
RiJzVvBYF8RD9QqidluSnotxbLTUy/ZoKgKs7lKuceGC3Y1mSL+9TSRndJnQB3Jjkgiwvt7a4M3a
/MPRn2Qp89Ya/XvF3v8gFNz9RCfXNaqZoV1rl428h2c3ZeCChUen03tNdHCG/LP8sdmF6SltRGYK
8EtlPKZmqnxoW8jCjBJELN91movOsc0WI9Bjx2UnyVTlIElhqwi97obYeEVK5GW1x7FzG8Q1u6sI
Q9vqJfeiYaBBdBcUTklBxBiGxWkVVGQXO9eehNkERlT0yu4tV8gnKOwo9aojNsEeimjRBy81LGFR
+MK4jBH6JX958aVItko1aT+lb9jClCOfQBYAndfZECS2aXgIMQC36G43Ffwx9fsc0u7B294C8W2t
quE52lPu//vVP376C504xudJKREAfEgJJjYvfz4IYHyoady3cV2GPEcCJ1hpmw2Dug6THWXZ/YnX
xIMyr0jBXnHVdLa4/O1ND9rjwYagPVPeGhgNHZnYydPfYMOQqwoBKY6Rp4V30K4kVuEcNyF+EW9X
dQQJ/LXmCOhTl4yel5gCXnMp+HPQWQrRwoN0/UiLzq+jU5z/CmBa7Wb77dd2+PSAHb76g3bUpJS1
2mkrYEDYdrXZGsZfqwliT+ieB2fTRw5urBxjqcjR0l9M0OsICi3eTbY1Qiplee6OAP8DaUbl/cKd
72Y20osQXYLkfLGeqvwEkRBX4YfXOed35F1PKHnoLArEu8XPHHTFLq5ZZXcIvD9Y+zfeUlSXknB+
D09BUvl8hoBhb0pB1/IZh4mTpDA20bOy4xbnKSikwEXMhhseMaTLM1KgbKVNZascNrYuafp8FAZr
bs6QmI6uFLBT6mP1K/w48qnmWxLThQAVHnTXixHGqd5N5nK+c6C4CRT7/1lRIKJ3939djidUwspr
eGNM6edWIEw41/M/c65uZZwhaNRA7hkwOCbPrGUp9EFthUPF/r+slBWD69b6gsHNv9uAEE3x0+gc
OYaT/hc103u8SxR5Q2IjSOkxq4+/AmXZH9T9GA+GWDR9OeQhWljIYaQHsyRqenv1nMt38YDKvKUH
J92A51IXnky/OIIFK1AkRpXalhIzsP5glrGP7o9l37T+8ijVm39DET9r43or6UiIJ2V2o4XhobCj
2gTCREK8ykgU2jsjBkdNJWbWCCIE3wgaqegZBmn8fT7TTxWznCpMRR5LSDmg3ACVWGK0RxAsWifs
bQIXoH89xNenCL1sDquM2jIQZi6mCNUscujWAbt43t7ZbYViR64exSYN6jjkkeSgWxN2a6/8zlAf
Uu3dXz/+Yiat7xNUl4gzYK+SkdDI0K6JQaeWRHZPzpf4IENt/dtm5U+CcbEd7uV6Amfxr6ssyWGE
MPQhHCpB5CrXbckwpvWAeuwHV3fxgL1amygn2y5OWRBPxDjvsU1c6jMUq0eMXm88+ypzQkHx/V3z
4t0/FW2GQ434Z/LA7bmB2QFYSnr6zUMqvuke0ToIHQpQg6VDCPy1huBAz5ykCY2cZY0BiyvCKsu3
OVgWhqkOWYgsuAOWAo/OGOgNBbx7Ys36VkzRoHslzceITi4gkNxZ73o2fKIYdsHRhLM1Nk+JzfO6
793wBYKS7s6x6wFfqSzBQafkyz3lTVyTn1sWXfEmPnlMM5dkYrTlaT9ySPufJVJJW8122mVm1oAp
PySTzY4YjZKaj3LrbvOE9/6P7jlfd9YMxUQYCgdF+bSMQe14c6Q/kjGvhaYUmJAeUwqpKlvYzN8R
Yh0detkZb1Q0H7oApEnCbqhvEaTk0Je1eSZ5gmyg0NmmbPlP88ZUOVkv4wk2Mvg7JW/K6NGGY9z+
H2/3nG9GlewcKePyvIgkFujCmt2YeKT8wXwXN90FxxXqtjlHcNDWE/rKSltn4Avvy4n+iVJAF1Lr
uHLLcZVZp73041wb9oR17yUUa4hcf76DePeriOhh6b54L+/ecvzVN6pCid4j3VDbi8BgL3MtN2ao
IhPpWddk10RxXdDVvIr/O8J7skekI+QphPLrNJaxTyQBemUqLBSFmBY1bkfrx7tUwe9Z7UiDCOZR
Xa0/tsrFsdFEmhCtp+g5vzZOQfXI5ChgdIqLEBuFllYtDQl/wToyPfVZfJ7Mh38VcA2jxKOlpfka
rSx/RZLiqmn1r6evgzHByRVJLdtS9QhqcoO9Qxxtm7AwQkm84CdkW8dcZOtk80t1sHdoyWhSxj6w
81CuUZwvYkgEkkgwqMalGTwxFjItlYlOz+fLIRJAT665JNZdbFoeGPraq+N7WEQN/yrsF0chZWCB
Rlt0Tl8OLp3gk1CLIRV2lLPs8MhkqQug0KWk1t0+NDGvAdNHxKrtKe9Vv58Ds0Uo51PIzjirZvXn
vmRB1JSk6pQIuE6S4+MoWtrI/oASpMkKJcMZs3Y4AkhsE+Fayynfx4jyoEEqihbhxRqbiXrdZJdA
6xXpk6qEbVygeSaObYVn6kHcjTlhpihXavA+cKCYVtzMC1pwjwDPkdpLIsiLA5wBCHxpq67i5piD
R33GPlB9qpB/9Fr0ENF0quxr8pdpRhOniYeK3a0WVVlwsJr/UH3BTDS7LQ41H0LfbwKMLmt2ulwC
WiyO32P3jDH3jA6iiijiB+OfK6NAOQyx82Ail6W2nb7MbIhnfmpjZydLASlIbCcCtXfRxpnlgS9V
Ypj0o2rOzWnEswvlaenkvuItuC5weffpMmYN/NZnYgukYJPof5RDdg2wn24VemWtzljGjfhoOVdd
cbKWMrNIejSpYzKqUT24IidtclR2lehmjWUQEwChGLJlUXF1O+x469c1W2zkJsH5syU6xgppAUeV
oe4oUmj16sNoz5zjuNOciG0Xq5I3E7u4xUA58UyEKM+h2EdxIbOYLFr5v0jlFV5kYEaejmDCu7HW
Qovx1SNP6ZjYAmdGJNFXumFtyEwJZWpEuW1ucGszSijgT/+jL32t84X3yZwOv8QYxp9LItLgk1XZ
7X7G2pCFTpBeI7jfNGjftf33rfReVOO+LwHU9E6CTObxSwIN73wcAG3HyUP7qM8JYTD7xAbrB5hk
c/LtNFfiMk3tSbdaoRzK/OCin8CmnqbeubF/+U9af+uidi1g+3srrNcnSX3I3Vr578AUCWcxwzpN
Ql8SNvp6lOJW7sYxThDV35jrLZOsqUh0pZQiKHXm41BfB5aeoG25GqSsFKRC8quH/j3AhZrU4kV8
yU3bhEXpD4wTpJ5wrYjMXPImVCXCA32D5fFEUWEMOxYyIe6Q2o0GkG4LeupQwq8gjtdAWpGxVnS4
tSndgEbtN73WeG1l/krzLFjGo9XXrysy0cNtlInnag2uyQOEYPQvtGoDoIMGt8uka+zobzuhXttW
udjd5mBdnjH4hUV6Ts2TkyZyvvN6DedvGdCXkjgGOTlLPm1u78zb1arps6lbIQQDlYwu0rZv1GGF
2LFkHM7svJbF+eFd4PRL51qiAr2U/d9oqg30Zwrxlm73qGwhZ35w5Wt8GO9hWWbX6gQiB9l5O2Bl
KhOmTskbeicgpRQR5KxhqO5zpVZ7YEBqHbkKCb8I3OVr5evdSxmoy7SfnaR3lRM0ngYNg2twfrUc
Yl+Zmr8PCkGXJpkyFY44+LbCBsIVJh20AJvrgflW5L6zW0RzHpOGBDmeIkZKWY2Dmw3ndaRq6e/Y
QPUniSBqyb6mGSRqeFhf3tvSp7bxGiWJbPEKeVr7zbzZkY5ggYbLlPecZ98KO7m81a3ZXHFlifPH
yXuUcJFqad2a/pUjmnllYdUxPVgUcOZBaL9ImV34dWKonJvJht8J3sJ1/9C7M74G8nulPGl8+l5i
CBpSxh4mTi1ri904AKfxBzeQHsNDlN3Q6ILxe7uQ5tNwr4C3N98hZWJMvfoueu0vR+Mehi8YApxB
nsSFghHl3dy2EjjLl8qw3gtp0ZbdVMnSkepl8WXJsZPT4JrlzkaS+gcKnanyvDtBi4kV2i4meBYw
t+N8Kl4Mksw1Uz5/AFDU7th8L6oiZXiaQUurpu6cXzmH2Q4SbwiVBAKR/f1CxF/zOjYozXNi0/u8
ZdxNrBPuK4j25MLYHggMj3/cD36CP60Y0nqQnq5F9JJzEEqATxbUWg33FVh7kkZFha89Z4LCVHMZ
LvIyBcyF21he0hlCanwrn4OuRzPRswLCjAMv1+bmxxooy2chuvL+9zyW00QNI4T6wrRKh/OntIE3
QTDydty78v/3hXh5gHH9HimYwkGaeMFgVKiXtgydLB70gCfgpvc42rU74GyzkaTxSOvL7QJicfb3
o02dWp5a+JCtWiy56nRX0lgZKJ1T/k1y4zWxZp2KnUr6TIxnTqnhgn3wwkgIYBxxiBpOs7DqLALn
MNRC/CNTGo91HRkSVYe6zX6i63wOzoJ66/4JIOFsCD3YSxYdR34yKwaV+sPLqnMLdYUk8JCQTuJk
qc40HhQvuy+cK7cilT8sK9wgwdiqsGiNOibuYl0NupPwMFEt7Bis9nUs9vlxC66B5qf76zeKy35t
LQTgEG91Lc+TzLW4ux4dU944YLQQwCB4brF7B1psIfJWAAl4HYujcJmdrngfWy1sRMBSLT02Lo4e
+dpqYaCeo01l/lIPFt72wrnkzAqigs1RsfhPvGW9GQqGabmR6mfsUe4bPJIaWYb9YuFGGVC6kgOU
FB9T/cnf9gWP9lPXecs0ygGidm09GxlUsPNF3LIVW08iN36zUj3FFRLnlMFqbSIyX1jYpfoQmeBb
3t4NbsFf/KYDdnA2ac7AqGTmP94ZzJ4ge7R4U8NwxMibT0aZJZDT0G/rz2mjqYfOuEWiOhjJgfeB
TRlBXeI8C1GafpHG4/pBW1kEPHc8Mro01s1XGhv55pq7eN7LkMdEnDtf+an1mN4qY8U8ZCk80/q8
4nMtgZpsl3mIZZ326X7EphAS1LO+X+QSSPRFQBAijGqPA2s0XBEKO462xP9XGOHKSgQN4GJTq8Ya
F4LpOaLUvApg8ReyUApmyDWVoZbj6Kmx/YMxTIeR4PiOJfLspb/JdRR+lWay2vdDDyLTfm9MuiOU
3FxTYVjC6bYNWHX5EL0iIjYqP8WTcA/vOT8rL96tSI5NLsysnsidUqvl6PTR61mnXMzaTthCxc0H
STRXNJY1UCiRfoq3L1hQ1yfJZpUEQ4VjbyjvQb+HbzddM2YprqRiCQk+BIQdsdd1AqT13I+snlZT
PEeWfb+EU+70zceAF3Jqgt/9+pAMq4vXwpChHqlWQXvhUNZVDS2vpnVivKa4wpZbmVa9EUAUG+UY
oOtN3NpcX4Q1rJppZiTrcjSbsdmD0wz+DfTgQut1UE9QKBfpb4augC7vp7zNV2WOyNxa09/jhuUi
gkvdnY8bU6OaB9nBdtEy7KuQr9Jtss67daKZO1Nn4vExUZiwNgKwzFLJ/1R3KM4+KT97wrazDY0Q
h38rRlcnz7MEIrmOoLWy7nWZTg8nqw39IM1MC2O6VLgGGmgPsD2ivkPtq8/8Cuq2l8NvMiG80nuZ
Keq2gkLJIZVGiCmgoWx5+7YNJzywJtDH6n4hzDIkQu2zwMRZPVzvQeZ8a7LwJLh5PtCrGGCCgudN
1qRRuqBx4YL4uJ9fExNpxryDonSv1RVwy3F/KhMou7uIZMjVOSaBQ4A1S4EDUfM0FjlUfE8I+MhW
XziLGJwqMTC5TqBzee+2ssBGvBGYMuM29pSBtMMJeXoZXpyqqhkUvUfxPKJPZELZ0HzwKNvyMa2G
nvDPlEVQaGeCfJCtT1X3ULFWT5cAcaYsHYupFSO1vGnxO06oRjY/+0Juovyq0SP6e2XdkUEaJhNN
KKqI5sMTEgGzrZiu3Z/VyhtPjWQcyTdNEUfVbDZHc+0YhSCrL1fG96jV2IXYBWmbQMz4/M2LtWLu
ICRtUCFcKxnaZuTF96vTA06w1CaTLDAj/73c18WRTC9FdNdoJw1J9G9ZjpNZo6ZeIyS9EssOB35Z
q4dRrlVF6RkPRO/nZFmpAXm9ZFlGzwBiLPkCk3FCwRgIj6nh2ZgZ0SEWk39GwnimGNCzCLbaxcFR
XqyDcCbsWMj+DZk0nHWRY6gp3SZZS5zxkvOqKhyssOoRrtolHytCpjcMSjkH++nmnmY71yPRDzmi
p3hJVnVNtd3PPYHKCoNcUXAyoyOAmKSEqBkasJBxlhht23mUexM3kK6foijEntxdmBAyiwwGoFil
b1suGniYHtnwp7xz8BfcpIPlQBUVroRKGRe1q+ZUBnp4ck6Wn/8bOlKBDGJW6GbwNiW/VrZid1tf
moZyFz0eAtqyO0GNh3LG7ooF8lEBrrbhrofEB3Qwl56MeCQCNm+qKxO+OZIymEkzvGrrZDxc256k
DHosvQuormvSDNuWCsT9fMWgO3mfbQfGWeDiW58Ltc39wzBieDdlaRLquvffam2u9U1SLXMMgyJo
182imQUCT9KaQyQ5CTJ5JhO0YEEiHqEJyExK85a1ZbNe0GLUZh4KOMhf4W5lpWNQrU6Gpr8pOp6O
RnYOBptwJ0E1g15HTYvSAoXMlUg0K8gFdnpu3x86aX1pscxGMCKz3JzLzzGqOAlzX3w7e3nN+xAo
IIixhTmnccgfmPDOcfh655SWi4XJVXE66OFwlmUzNvixOV1rvsoz9v84oA5nuaJUaqfWlbFqn8JL
0WOEO1GsXU7OOIst8zF5Ql7VSEXj2FEiIwcoUYnZFO1RHb1ZXAHK5AD3Xz9lC9Lrql/RTkCiC2aq
+2sSEppopvFCWTS6lbLZFwTgJHYak+jsdg1YUQ/Fxy/JgpXEjlVoNLKhSILA3mPGlMkkMMsjl//y
cFvEjtY7nCRTrk7PD7PW81fDTxmRbQBBRIy++A3uFt48JDNFzMJv75KEdyET4P2lZiLcM4FH6sli
KhrtpvVsbLkmNrI7b7SLqxL+PORVTGaZ2iPcmItCvBE36QPHp5rHoLvjqgiWD56xGyxYFW1dsJ/q
2Vmeczc0vhcQoaENJSRMJoyu+PHRF6D62LKkc9M9fR7bePssQc+W+Z1TdcgJbKsrc32IPRoW55Io
dCWwdTW+za+FwevTWz0xV2u9TF+gQ1/dCtDI1SU9f9C4HeyWI/sDfOl2U8+v8/akIKzWaxFkK5NR
KIqiYN9zU5cLFOws3hjke/7yl1TLH9FzZO8ZHOBEAOqS8jcEOM/rHX4+2vkZNoWPL3Nhc4AUt/fE
rCs0UfwE1V5e8LnlTkL1tMYzJkS36rBftfFJzTOSmYoxo3bLQUSp9ZfiCi3fxrIlKuLeZvHArn7C
3B422+8jxc6ghWc87qkJoVFJeUeuSJ4IQ4z/CY2wKZqfPKGYhI+bFltlNmwO+WXxcbZ/uH4woozm
wNB9l3Pzx29joOsffP/I9P5/aEUnZo4UAPeh6qUFzijb6IqnlSlZvDdmWj6HO9fUfztMHdQ3yx3O
ndZQXfSwpA+seaokMSTX7eWhoT+32ZLyNhCu87xkEnipyOEuOCIk0pqzl3sbwa0X5TddLBDQMHaf
jE8w12o/AM6NgdUdrGZn1JAlHXCDYA3ohExdRBJh1ULvqlchopIIBLTqi5eQRTluiV7v2cgaUeHl
LCdjpM45QgLy/XP18fq/C4Se6/Yd4dv8XUh38osIk4eR0DTyqeiUMPnw8Jic805gC5TZ4oizWt/Y
opwYm/eMptazUsX1Z0xCYOBZzrNUYSUcPrE2QcGrwKb1ya2dmWOFSPqQBpm3i/3S+UXJZ8NJIQ6D
8yFsA/uYzi4VS+vCqzhpf8e+DWsPGfAF2m7v9wAk6n3yEW8S6kOv2L6L9F057nXExW17murHtBV+
+v3wUjpJpq4o6r10+LmWdJgZeD78Rr7qd0KJ8WBj0BQAdIldOb8jDU4LN5StQ32SMMz6Lbsfkyva
kWabZ6CEDAINLS91To1oxccyIZNvqUac6nCG3U5xGYtWoMryE60gF0ed/vPrjngPNkOD+TN7SiVi
QmISSKot0r0S8JSjl+ywvVSQr9WNebrDvFVfTXFW77sTfOHEdATj2A8QGFNJ/K75TPnLTp4Eq9U7
Ubi731TGflqFOx1Dqfpd2VkRVjkFYbvigypIjBAOozuVNq5cMSq4tDQBWvcGvLYQHG7huZBcBq4o
SuE4jQXw1hEQdyvGesEsXuLWUx6s1j4ImIjQRnra8uExRvzETBh3XJHe+0c2AuoNQV/j7kn4+YXY
grIpF3A5Zbi2m0Wl2ew/u2oItrGM9V/CEqzuZL04Wf78Zu21egsp7zGWoyXTT5M0klmSdj6QhI+P
s96SZtRTa0gjtfeEE0tKz3SJrSFl72pxCXXIzAt1DqNI/J1SdF9dX3DtdlOSWZ7AC0SiwkxQqcHI
xNgYfrxo5fZ86t/505Q7jY7btJA8q5j7CTBdrPkRApbnbEfu/SDP2fXsINATOssTesw/v7AmUYoO
2LQwJiPvEvWHi3Bfb2Fc+b+CzGrG8dX0CBHfs1K5p0f91n0aru3OlrRGn6l8R37E4siiFtQsDUAe
3fTfaT3jnn4iNPmt/v7rPPQEjXspxn7cvLK5fk7MzKztEAgeFtk35ho7nWxtL6eNvumXouHo4b4O
CePsYI0OA2NgRvCoP7Eh3bEg/kmRvLtyIjon8wcgmbMc1pAjPXeLnnWsUwPw5BUVidmaZtgf0PpH
1qLb0PTclimT7ie2WrITWimcao64EgXO9frK76ER1dsD5MoZSehphnHxcQkTLBLs+3Br58ITPxnO
R5Sds1kjrfCHQeLQSyKaLe+8qpkXLxoYXEZs7S68hMOGJiMpdFJxNotCBzb0+LbHpgUzokp00E2L
NrMaggasI3B05s4cABWV/InjZKzygG+4N6FpwufxuOGjmcmukUOKlk9UlITA1eV0ikO2y4v3NBbi
cz989JbKRF0JaeNHvVpWDH4aTQ0pBhYpB/asFyZP/7s2XasqQIvKLKRsSqvf0vPp891XTXJhfWDd
Mx4iZw2p3Kyx/8irxyc1f/xMQMcZTkvurl0vfVP2CdGj4CvYEXyxR8ivFj1QGal8cpV9dSLGHefM
oO+Li+ccAuz2PLyCIoA6Jl4IlEepESB2cf0xbAwfamPLBU/Gga6mlZiGGXxqi4KMrVeg84qk3eC7
MS8r54DI84E/RMXC9FdoLOSSUNR8bIW5Faom6nlnU3pVDo9mfCPW3BevZ8jsp+4/ox/NUX6cDKeT
nNn7YR7m9GoEUrzTbMo2NKPlRso0KF0fHyud0rXzmJt6PzbTVUc2yaV8XyH+LQWzVLQYyu6rxVEN
epptsaV5oVUMsYfZHS1H5KNDnoY1e9v3Hr0y+1WlXWJgc3sW7KjPvM3Vm5OXgchsZWL+1HIx4oTH
9yGNfSxd7pXP2Of2SIBpUx9ff315ezVRr7NZTU8GfrP5lNzEqvVtMH0Mii8j26SxJFZmmdMMYSFx
TmmAs+ku0Dku/gvt+wJEoL+aq/x5jKgoli6E9ZMJUrhtgIDFEc4u1/b1RD1qz4MAqB+3omD4b3Xr
H96yIiGDBEPw4+8dskPOsgiSCvlW6PwwwDEJgkN5P3dwnJuxuoZEVNqGU3WIWOvF7jESLPnx9Jot
MjddTU5ICKzNi+RNO9polxLQgStvfSvKnGTmTraNWcQvI2HDSFwd6qgCNiXJG/H5Sls+PM23yyc0
Lq/0Ah5UAc5eHHY/Q7aPNAuxxSDlFrLCwqz9FJAWEemGfObHTnaLTXEz7CiUa93/lEwDjlBcFg/c
afWnIuHspAZ4r83hKBxOOi9VoaYIrt10P14WBWOhhK9QVJ2+heDE7Fz4eFy9tiQ8+RuYf+DKlaX9
y0tO9Z1J3YcMw2PTQnopl84UegbRY/sLnfHjkYrary3DzzFBkNQ2G4g6uPCrTKAfoLQhhhXOBFxl
kzanQMQQevd7rmqXE0UFWRfpo8ABHo5MzI6TdafWSeYLT65ZfseoC6oXbCDb4WdABuGqH3V6L/Q9
P0Ozb7Z8T6RW8Ubk2LSl/47Li9khCM/hBerwOp5pmBLCB83mEafY3h0jbvIETJn8VDXgvjNVuEpi
xEN/WA4EuWiQEm7sAo+EyKYBjX5WDPqpKVCoQpyZ8sKSifrTJ5zUAEctQvguoPPhBDQ/EMzgtzhd
6wfyT22aaGWEEQeK58py3l2/w5Ql9sAUTUS/5IB7cItyZwqyG2mds4UTWCmPjODQGLJ+Yff3VWYg
7E4lHWy67vZgWv73LTKfj8KgnCa73FvUAQPZhnbdHqvluC+JdAe/UBYQdXisSEX7+xiY6SgdppY4
H7BgzGmKBMfLt7UKKj2K6l5A5/xY9sGytbP0vz58ku0Gz4hcsJRfDom1O/3VkLrTTZxLqOtQFZgp
CgygNAu2DC7GdYOgPyg6VvwTCxPmwzHdx0fEn0IWh/oLO5PVtUe+kSdS2i+u3pZIix1odKZvGxQy
JkWlEowJ91nMORhdgD62bvC7y1mrdC8eGF5xX/zmA9MLRYTuWoD0SCfgjOzaopiCXffz0cV9h6xe
vFcKBGxJQIQanDinLBWjZ7S2SIka8p6l2h6kMd7zK7SwVk58x+6d5qSA4A/ZSJGFx7WaMIKiuJzy
ELoNQajZN9KToW4UlBJ7Wl+kTzFci7whAkPncr4AznSrxh2AZnV+5xxVauXSinGs81TSGf80Bd9c
A/AUKF3oXTCaLQuom7zP73+DxYI9zlJj0e2Jl+mEkvL+/1egpsEEm1eKirSTnahCvBYs3hhXeWsE
WFO2qIra5fv7sxp38XoAts+ZAhcf4bjckBvud6mTb8zXZAM2yChSFPsxcMx+teUhWD8qDKQdOZFv
Ji5/52P5BzAn0d6h3s1dRj35UyoxJ9d/gcUIkrc/CxNv/g0RtBv1UPRGpvB590Mvd6cgFS+M6sWd
ndjSY/q5+io86kgQ6Co/V1Ckux1U2Tpq3MdLAsvBYnj0em564W1+ZazRHfQBMyhSggR7e6McIr5S
BJJ8laSxk4rTkjvGraArTdxXM6aCVZihxQz+VZA2mzEuEoW9WVNOiTpn8mHMpG7/oCjBr6nzBg/B
Cg+1GvAt3q6VnmBs7Kzgyl1x/QDlTVeDsWURiHhnrphvDQ0WeLqfXhGZ5bHO59bYSyBgBBbHtDvo
W2uv5XILLqg7DxPRSwM8IU6ivWZHFBrCqXNR8xTth7F1jlMX5Q9T7RNqFTAhRzpYZIBK6T40oBLP
H/anFkhx6YTrW9Ad+THRqr/E4Te63rSAj2/diDcPwaSwfH5sRFftw0as5/2sXr7GpNZWM4uwHmPC
IKChFXRVIodnIMBrsffYPIQ7G0PfulBMao4iOtYuEoZQUkLB53Vw/lxwcqyX3k2L95idBv1hpvfp
BbXUWPuWqtuJRLckXYViOJ9XXxBrgrM5oOlIeJWvYSlD+/E+cYj2AkUamOoni15WkmFM3mw+ixeD
DS/1m7mwTdn+UgHTRP5bqZQfNwKntGN0mRjPDdJ5MJxwkZftJup4nePtOOQNrnpM+r+kH4ZV8vsT
a9Bqcsh2xl5JYNdqIqRDv6BEZd72uliedyJefDjP9XImWECMB/BeV55IslqxxIhNQdTmee2QQ9Kn
aJoA2HIypbhwaqs6ZhpAN25RaMJKCi/kyOzfxUDApTc8oN8JIl1LJff+K1sWWlqxHiNU76iYJmlQ
6YDVCSZhBE7IgSqmQQDbtW1zW9PWALh4e/AKIXDAPk1r6fqA3HxkLC/ppKROEuxknNECktIO/kj1
U1FQWdaMVa6N3xdyP0jKmMcYIxVUDg4mmugEqSrKUGJqsRK3W+wx6wWFzU7H/EnQW+PWOjDQ1K2C
2dc9fZfnuM+tKV19ddgY6a7BG64NyWtqAK0hp+zQ9Q9jRhil7PB8bln5Iym3QWPzVwfUsxWaY10U
8rcUqCaMh4x4glDfjaVNzMmEn9kiY5BHm89/6rHQHT8Vp9ptvosGj0M4/nskku929oEkrdF6buJB
yrm8jAmskQL6Q3nGeKmMaQII35mHgmWrO5o9oQcvW1PugwsImuWdj+nIZ3lf2Kb4d/z8jQSi19ew
IACnjoGlzBsrS0Feyxwvi37YYA5o6C4Oh69YG1J+hqFLThtp7zMV1LqMML/jTV6ZQJw24gQYQ0Qu
XxuLFFUpbQgPrNWLDGShb6f5ijc9JwH8H0T5uTPlTBVxNtRVb22+jt0mTrRdW8ED1GRVNcEAKKFh
A7kiPYTPeU28xUH3dnA76ZI32kCXOpJTo1tCtTp0jG3+AtSSMIjGhRgdl44JCsXWRKjFyJJDdkPC
GFHMSI3+JFIDKYujf+7n8z10lL7nFwY00FiMOTeBShD8mKDfhGngy5zN/nW/ULsB7HXGV0aT4ppp
2QH2WmeSh1mDtpdmz0ZCwuiF8teFGrlfkNiToV3/IZ9Hp2k1tM2HMtaIGJCdvZ1nst1gPLbLZpQp
CdarYSsBGIo9LrJo3Tby3urbYdfLn4+R2kk4xqM8e5v0MGEzxB/PQs3weu1mj76e88JUM+PBMcaC
mkEmSnQe/uIMgONG8fC0dwqzaFv4n6HFyTF1ob3g+Gj/NJQQdAcJCmIhEOkGpVfcj+6LxFtVh770
QdQDclzx4H6NfjK9iN0jDr2Cb2vq5YWn0W44YNfRiNRqEg2NPmnrrtaG8IJeeQQDEVRLG/2FnMI3
ZqIvUhBazCjqmSPd41cKbahG/pP/3fUy6DZS1w99aOdrCvQSmFIjKIc7GmlhL8WzHQwmKtTiAsRh
W3cyQ+dVZs/kSRYnSDsKOYbdaOW3/AQ75iqjTav0YUC+rmoa5NLg5IKJF8P2WthmCG1Z/S9a99K2
VlX/2CsTLGLOIu7xSm/CyNYKWbW9QBKlu7VuVlPTAId/xjiUyrysaegktHSqgR20WW6cMSPAxhzP
6L8JedG5oIdiBC0jOCKj9U5s7qfZV7JBSIJ9onXIdvcERLygw83jYNTT04ctkZbEwlN3/2IQM+/D
rNtDymRH9DB9afiDzxZXi8xby7hnN+41TVCfGGIZQ+hokDpPADNDL0dWSEjyQJ1kRTb1A684X164
qdotYVbBt/IfCufRHIvJeNCerWJhXNJbsWd9XIrDL4BTomVdzMXC04IdNaG9bPPhPQsTXlbJmfjC
ewMC+vOvg4C5SUZ0Z/wbdZbrOOx/0RXCGjIzk05cyo2tdEy5/g/JJmiFo0CSI09EXOTOvfZxRo3V
KawNg9rhTPq8AIvWf0JfYZ6VJZNSTikJ22CwyXNPIIqexE6SmHtMTLo+o4rhP2/O5RmpVwyCPuAd
yszFrNET5jJZHELo1vcJqbR1VroddKL8KlhMNVpx6UVB4PeyNeaDB3Fl+PTGKQWSFYYg93gR1fnq
PtFkJpZbHznDLeFdjZoP9/DHvh22/iBlXNsWs/ouq4HtdHObm/8vYhcdIJG6mdM/ORew2y8XbbEa
766kSzBNOgem6Jdof+Kdt8+wkqES7rHsL9Mjv1MRziuLdnud5UgxESY/LJXUkqJIAhvSihktYy9Y
kBKv4xnYmNgT4IWMMhnpRxb/C4Aeu0yIyJZy8LNVmQovbTRcZasP0kjfUH5hasB9SlPR1sQ1oIEC
mvTuaqBnbiWFmfSFv/cjXfp/U1JzLnlx0Z2J6s/JBeb7O6QJfhuqMxc5ZWoyVBZqA4vX7sPIUj1J
fc0urhiZgY2S8lCVu13B4nY1NOPNgEsjMcgSaZjNgtIJHOlfkeZH8Ofm0wsQIZtagpmX6YPoq0+m
VhF7Kn/tuZ3AcCIPm/Dshi1l2BpU0+vwlI9LHVdJcxEEiQvSvhbb0ImqXpaP7Z4jQqTTXpx0ovfk
2HjstuQvOyz5SyO80RnzYzrkr0m5P2DW8Idro+VK95ZcKt177kBMCCrN0n2UhbPdXj8qPCdtf3Q2
dGH53CQP9O5+LiVL+z+u+GRCukTCDpzSgqcdWswM+glWXCiS7JQe848TjbCMoPZuNvaCqrxHWZfm
A4VqN3Qsv8qZjUbfmPtIfX4p3uCzxAqwPvkxsRMaJ98ym2PGge6tZoNubtc8dRblKRUaD/ENjwgw
soN+uqU9rEfd/yhRk7h0VoFmV/ZnuMNDnTk8JuLzZ39QmvXhTUgFG0rU7795Zpo7YiS6t6TV1me2
XuTzYmYIoxhTiAZLlliyuBxM5vMKC+8oIV5qPrrU6l31Ibf73YBoJX0AHdsCKj4ZpJR9XjrXGzN3
OeFR1YXvKMGRLUENNPLq1RQtqesHkwsesPW7GYNhN/h/HHoL9y1ek8NwEqLYElWAbY2cuYmvlTb6
2PC+3ZmyxP4XdeLMdm0n2PKzyeRQiW8L+1ZisrDBgjBcvSyQrZqh3m2xqi8nw+pZr3LC/wEk+fiT
9DtbNFUGl/tYm0qlae5415Nz+1y0SOVkuOVcymCUup9S9fSez6chot4kSBYikoV8TomNFvcNt6Ac
EWk5tL6Fl9iuxVuoDhPtI8MqqUK0gP0Z3zIW+7Aq7Ty959QQfEaR51aioQ1hV48u9pOqfCYww9g8
8zS9gMSSybehieIUgC79/R9Usy8tLTm+oyW8ms9I9R/Hg2OG7isOxHmCnNS4j5ZC9UKG5m3LO66D
rwhU7HWa6GQge3QXLJQ46ksex3hNSS/K6S2WFCJmzjLLwlYwjmEUzHMQnAtfgoUY8E9gdDyhzhV7
6ei2Nj5phQ4DghTpq4kEYT3d1WMvG46BAVc71e5eulVLR5tCF6P+0Xm3WN5PcNgT/9bY1olbYwGl
GCzYmc4elfY3NpnSAwA/XaO4jUO5DvjjflkwzIBp8StICYfI259DPnF/4u+TaJO3NffRnZJDZvo9
Lzx9LhpNnjNxjugZaavTDxsQC1nlDdiBuY6yGqhSXY5TMpfznkZ1oJg4oktU7mEBLudxEjmZKgBD
qP5kB4sktwk96VaiWp5MV2bAtU9WnmHp4GFlIavUdT7kQ2tN9d8QQNwieeDzktA+6bKKv0JHh0m0
wD/wJPCuWU0eWy879NavqRfdAfigoltopjRqgzmg4jDUX5iuo08VRsVItkGzNesrAbYNY1qB9uZF
1YTmDav2H314tM97uEwmikpNs1FYk5zc9qTnYI9sRVZ4wgBCVA/UsAwnSRwUHEWSw5emeVoi5Xm0
PVDCKK/X7tA9Q0NBA6zkFrZfiWXFxZcAu7nScbNGEB+nh2upe28PvbKSCV07HWg+XLbZplMnxM9J
lnqUWdWUEAWCq7SXGdpSecyX73AI9w3I2+wbPDiP+qs9HQGuVbq1IVjKt4THmqauaEiBPpP870YE
siUfJHenile/1jdl4i7/dBKZeNZmSDXVRNXfknGoUv53YyWaD50NzGPxGEz9PZPEoHv8n3lWHz6V
XaiE+wl+pa+4bn0BtuNwaYoAkNnYxsHg3WequaxefoWbPS6jyMGhnkh/uIERNO3muLHgz0BrNN3h
ic/7rCF43BDJH+G5KpRPsbh+XxmE35Ko/by+v9rqU/HqFsGQLuGwV8iA6S4ZY7rKWQk5qLTPqU6K
hlqSXa5t7BXCvk4zKebNSLaZeRdS/Fnq3mUdhMrb0gERr9wqbxFRJz3LSTZy9mcylaNKhvM6zBW5
d3H2ArjrDtq/m2L9y85me+Q9eVBlIc4JG/Ow/d8VsMxkVWOXfddos0KWVtU6Z5OYeYvKuzStiexT
XMyxUtmjGbVfYmXlUbPI2k9I2KMpkPzrnw6aD8MJMANreRzJZqoSSjg/OEYUW5njXW1igRbJ3Atf
vZPzsCtezwzMW2nfaJcSs5z1yLcnsmPnrIzhHqasSfRaTom9alSH7Llo0C8HIAgdCOZ1KrrJK0UT
CwBX5gk+2UeJhYXUT/z6ajg7kuVYDT6KEJinnFcMdKHBWkFvIHyP0hudzT4O1EMgG44u3LkFcDkK
BbH1S1oR0SmoZPnLkPxHwpmHFDl4PLFbni/mmpdfTLNO4gvy7eL7sW2CGlUtZ22jPxE3zaJtiLaX
/NfaqHUTrgfXpH2snXOl1vlT0prvbagxvazduwsRE1AgYEplW9qSIowKCVZBeEzEWV5i4KEWbPLG
t2OvPe7VS8TSUunkuqszE40PpiWxfB8krPhddETpSielmQccMDFXE13VQn2ODS2Fw2dI+GdBUSF/
U0DJ307jpIXEbsO+xLOhAGWb5hhE2Y+HiIJO/9Mewj53AikHVeZtg7gUoh/5EIslkUaKZ4BKnXeK
ptzumo9GV/71gS3b2b3hwTkDoNRDJr6SVGLhAw22FSA/lJQBsF4m3fnYrdPJnhFcjdEMrlfW/jfT
Pzrd1DscoJALfnoqkwl/Q7NVRfLw1HqdhXVSsB/FSyNmNOc+YvcUtdKFicIfrrKt/6xjjTNd8d4C
euV771QVZZ7r5eX0tAQgNcZ7RVLM2diQP20pN+KVlNDZGcoQoLY3B68bR4F0GDE0JSneGv3f/ikr
U20kZupccukekC2ZwVll49ghQJT0RKiK3QX08N9QMT5cQ2557T6XkhNwl+TovubMFaUSw2d8ZJvG
ATiO/sgmYNKdldqLwJg/uITxETf0KKQRbV87MqnRNiU8Oob1puOupHuIFq52B+oOVOCoPyy0ymHH
Vn5XuDM+foDxksf3F1JqFK2O99HuGQzFpPLGKX6tkQQhP2OJzf01127p+u/lK5wrROIQEMpNSSBw
o13UOAzcKZVKq9uL3bdU/3fiJ2tLkAV63nTg4m8NP5mbIkeB5mnhPfayXmWEGEKhfTR4MwHeGK+l
sp+Q1Vb2q7uy1+Z1xbsX2n3TXnP1cqOZmEYmjEkq6bxr4yShJmXEZIKYG0gh4SIGNDKm4Y2wkHit
knOr1d9fRk8sPf4tV5fHitIuElKiOmSb8MSW4Ja5bsmso18+V52WJda6ckZ80EyFxKxkhlXL+nn9
b9B8669R2VqEH06qhMbiXH5LjwSXYoThJw9xFtaDyMJRtDx9ZZryOk2v9V4rMN+34yAWYqxaBPpN
c8VeIQAeDk3sTFjHFo+K2GZ3ZkaHgnW2LifYkheGfqIwX44d+yqsALkUaR4ISci+x4hU8uf0JNGP
41Uj/TF/kfwwICmjBEJSf4zeViebzn57oifDD2CYkVOOCmonpD8FbAmL7gd9d0EdKi1itQxDz6aW
v6fUE7EiwIbY1Va1iiwMDKUm9MMjxw2jCzJCZYJPC3eCMeakugXpgynbxbX6lPaNXLgkxvHuhRdD
PUPbq6zNlfTyo5HEwzKiK9+MMPiLxJIYnDTBe/7aQM5uYH8E8uuHTiNJ3CQr0paBI72xQnQ5CT9V
d+edRYKuAsljG3/9GYSQfqqSo/Irnay+P95So9yyPXmCKP5HJr1S5pMO1Tr651gRESFQh1wD78+E
DOUqmD32nZQry7RA4vdqXPHO41lBjKDrzQ2i3kAFbfML0Hw/Hhfsj2zEWn5t/A3C3qgv4ryxfoup
oNX082aty10rnw0MmF1Lyqy82tzup3sI7X8jHCr/VYPTxLFcxv+FMFtJhLg3V8GFsND3VPFuuFbT
fMrhwAfuw/ScafPNbipZDj6QZdGeBdFFS3Zs+a/M3Wk9dJoSICRsga8QYICxHWRThLWVY/IGgvUr
2XrP7hJRiMNl2q5rrnvOwg913bM9U4u9Iz4f7HI48qaWlsSHiWJK7WsGfcXEkCv55gPNL0xL3Adl
DjvFjB6M6teqvCzPk66NzExzP2T3fB+lY+witpw3tSifnnP0vKprwdGHr64gDADOlKu3rBgCmBWT
yxLXRypozaEAtIgH2le/G/FXOlrIeBWLO3uFzVaMuiPZHA6taBEd4rMQYKxAz44JSAbzvQfcVBCL
RZPruzVbWQV3GaslPNmwLEx45fcrGxEDwAiTCd4+dN6pwPdD8xQhzVWJddYLOFnXaCiefHmFaZNP
RmB/YllEoEd2qpx/uxX9Tq/+Ub3FF2Cdjihhyzq4y2L+pcXKiUzktzHdwPylXMA+hAYUyrQiXrK9
Y6J7k5Djgw2fDQA3qjbm7+QDRK7kC7D6ZxxbNPtFHaWl9M/GRjiXr7/UDu0Qm6FtIO+ARIRyKpuy
5MtWjubJNaAIh30oNP3yV6liq9v8luIgTlvZAgsMsI3Phg6HSE4wFBYT7lBOffQaVNvGsOQUA7nF
LyxfBYYce3E34TMY3A+qQC3XvqH84j/gUgN0a0WSkA0fj00vfyrRp34PakIS5nDg3wU5fooGvNSL
u9+pBy2NtAU2qYZWjaBnfakm3S71eEdQsNlAJ3uhGq49VMZ/dy7JRWI/c/iS0tvum+E3sBefUPuQ
lhSei6ZYpxXrJJ3XPI+8MZSIr2/lDjOrmmUmVrrDGlQbKcCXcpqzK3DMUQsTKfYruQUqQrGCrHNU
KJgB+ZuAohUzuPemPYG4M0+dLeNmVvEVjV2MMzcQhpSDetx4wN1BlmJrdtBvGdZyrIO7a7sgiWGS
8Wqx69PuhQGHfBUH4xo+WMDRduwWLXJB/pAiprQIJ4W4woIcM39Vz3v+sz953BULbFd481kqb6jq
Oq+6sttu+YLIZ1Mhl8scy/YTT4xdGldFVyT8zoMN+NnHrwxnZVU1Wuh2jHRoH2SI1v6QCaG4Cqbf
pT+qhL3/ovpUTfBOeeABC5cU04WC0Az5B97G0QVI8OHhbeVFpWe0BJiyLE76Ier/48ZAAa7xF4PF
2UYlCuZGcHJ27yRik2PDjpBKibGw0fk+Hicmt/L5SH2NZYJmqFqRfl6SHUdmPqR0X3u9hjjczZKX
p7xBndPNP5u6eqFjEdHf3DL4kIr1qc8z0nAQk7PLBvIcLZPL3VKP4RbeKledv35iCe1L5GSJZ9KV
HNluD29ah6FivNtXx1SX4SGrhWhFoqk+y+5Ru00kx1CgSxSbh12j+8IYyqzlXG8Esrrz4LfWcI2v
j+/sefNWgzQY0DRPxCMaNUIhYct9LFCRNj+9W+5m/ru/CENLpCL8hqrUkViZGW6Ai81I6rwHF7HF
/2C1i0NjXsVE+iGYpiakWq46hU/R72pE9VG421aVEhxeD4SFOTQlt6ukOO3sbfpWRI/Qgx+6uLou
wiaC4zRqW8yE6ogGc48UKpSuRl/mfkEsvKHA0s1nistvBr+h7sBPpuUrVICBsDE+q++b47arnLbS
/BbrmHW3xoIAElJgAm+bQmfdv9bIdDIoeOlHRLdg+/RpMkjeBcoQF/3vLyPM//q6epQywOVjOPzV
3e7LRMDFIQ+t+IEmBNfs7vmgtKDPDdhTHsUVKTkVUd50F8rTOm2f3Qn14zgHxvT6x28j4VjnzpWv
/dx4WOxADcXDWh1FOfKYXFr/0iqi9O66cYZod8zQLU88+8e5Bp1JNrkwtJaJgb7e1T9kgX8Rhb6Q
AgroYK9Vs+Qi/EQ67Vc6fIBTkbWlDqlnM/zQeGP6HqfWz0/P5RWdbRnVG/omUe5yAlV1RFtceS/C
6h1neopCxPNUzEsMgqMH3oHHMDhuNDhpQY2k3b5SU6JZdWbr5xWxgqMqrhnisuiYQtVJlFu/j9wy
F8hKNse02+Q3wbMO0Ej/KSexcr8aFQoMSEdJ63XMSrw9AVl0pb/9yxt1qxKj7J5ZXUQFBcgRCNgL
76QXMuy1Iijp8ITijnTP/NGLKEYGp34oqg+DEjtMGWnV6f8XK+n33ntLU99wYD5iShFt6iER5CUw
Egwl3yJTXFRtz3ypXR5FZKReeKbIrcw0GrrJTtpdXlay18QkaUo368SZ1oDV+QwtcJ6E9IlqXgEo
zVvO9OPL8WJNlwE2JbC1JICRGf0AWHnwoBQQTXYntNadjML7RpF8mDYalzmmzT0o4KLwCdRe3Zjw
8ZfV6Yt9m4FbHpPbSB3/tcEfi4yhgbWcLTa3E8vNXkntBtQotwIkEEJ7ZxBxKkICMGTwwaVJXI62
QapMc4Fv78gx2QQdOm7ty+Lc2/LLgO2USj6gzAj/xD+EWIIwsogcpN5ov1yY+wBOKYrhyWITfDAD
nFfGZ9i/o713JqYQqgz5WSp8p0pgzkItUFgyGjwPmZTEHcX5eUM/2oJ0V3MJUm1xEENcjmABXBh+
HfIkiyb217CK9yv0l/g64vrKy8t/qilf2S9PhSltlv3QilmkYOFJsgGTlaozEObf84ZLNhGtlZ5T
ybfJhWkluhlhFn/zllKWsS61c38jwd/BiPuLtgorQEG8M7Myq60q8J9xTFrnoPGTge0Cu9VJQCfb
bxdDpY5Uqi8PtsVQwxcTfJMkNfTiqXGuYXtB6+2t8d+xix0W6Fdj29Kk5WbWpwIPrqv3d3rO4mMz
60IgH6hUVSttGhLuxDtUjJT/yVF568scdZfS69FpPxsAqiX+yMYzuHYq22wLrZjlNMwbEQULZH5o
f8hXYIRLODLRVIB4cHOHmQU8oHiEEw4cOwHpZbULsBn9PDkC69eZjf8NQ4YnKDQGz4eOFu92BdfZ
BU4E8N4ToqY2tlSN9n2S4R7YJ9ejJRvnfyGdbZaBOBXrlcT70ONl1nKWYbk4DyC1P3sPyPoFMPNE
oom1+DAFqsE8mF6Z97Weda0ENdbkvghOed+3eqaXYk99tIbKSgDLJ7bnTnVqRdrmjkk3k4pblU+4
H+ZCrk4Ap7/8dPNIXI07RZ2EYr3u9JccbCiWyijybsnPrnLxvyjYeDFt9QneV7Mt+YfsCxHfcDGy
WUbTW4H5iyW1uINCLBBAPufuNTXb4Si1keCCu2dIB0ucLPWSS6AbzxWlH70qHA5kYsqSJZooSMtn
iBQsDN3gMkBOsUG6hNKgKswK+6Hkd6OKcwafnE63j4ALo4OUoAh3+zM7PI6qAyUaUxbiDHfrno8T
1jtY8rl8l9oLYz0djkv67vxo6EDpFeGupgAWq0UZVVGFKlCAlLjTgBJuNLfF04umNxGva2jVDncM
BbEf7WwW6zrFpbpErvxoUjNn37Ew0aEX5gJpJtzku+beYnyGjhjmCo4dHlxdQU7yNvgFM7HYFWKM
hH8rJHFkEnMyT1dT1ZMaK6SLE81d1waaf/gIampwmae9+v+3NJ52T8eUGkyTRia9HekOleIj+oxh
G25D0l6jWGKp3jIr2n6Jilp19XUDBBKhz8DbG+ir5GXiTXs19uoVqQpJjijQsnkhiEx1czdegwjm
shMJc09XLuuJSe7CbqjCvCAd4sUNEiShbM/aWgT1dLxJ5/3DjLtw6Sxmk54hTTu7Hu5hDu6bwXi/
I/CL1I4tUYfMC78luB6QUIL4jFGFu5xbh/WZorvYvBeGNalyLN+tQyqEnWy9AQLSn8XFXI/0ukmL
DIqM4C/gSEs+Nr2sLK4HecqfAUmfA/jRK79tnLetcPKY4EAf+W03SdQEW2codfi1xVsLJvrC+nR2
h/xn5TKTnYZZYFElRtADFv2SsrQIReWoeRSCsLXRNcCWT8eq1XDi745S4PGIZ6SSrh3oLdGn9k5W
Gj3CPiipuu6/SFFNNbPvOWA/Og8kFLXgMLB+HAFJUt0+TtHstllm7aLWREf5ghnaNFR9j+T6K1X5
ex68hueDu7wLmJ8XpcSHUKJTv3CBpcAqIvTf9ZU6EcwyDC4UpadjIoWN47jtgL6INn8MCECu8PYH
NO8OhiHgMjQdV9wLIfuda7IRSPrMgsYlw+Nmfd/V6vj0VTJTcQHkGm8R6x2b4SG9esBDxeZvKoAm
sLHRu2tDAg7tB2Qik9aRPVIhg6wlOHiN0O0vQ6bpqpUsNpx8sHbOQ/2U6sHF6VDO/tIQi/uJXVQV
o32uGdEDTlXt7C/Ot52qkn1FB+Nz3Xvdei/6Dpzh9DnTUKmhKkcUFG+nauW9NbrBNLm7yjjy7EdN
MtXsYYbOIk9GdrS3jDj8nYoWVPNm/wTmgFWX9xekyacDxsHz145Gsdp97VFYNIRYuAaR4ZxvJb50
adhYEqxDrf8B85E2ZmO9cQI450DiNl0NWhaQ/xJaZlNWJSnjtRmcjrHz1Eg/1pRlk3FiryTHqc5i
4bvpr2CnK+XFe+3gygXrHdwnPt3fD49AkTVS9vbN4cnwnTYLhnTqYTP8Rf3jrBsr18nSnnG1uHd7
TrppBSUB8Vtgikmp2OrDFDpD7QEJMkb+VGc7qI2u2ni1hlmUVuQfAZh6lDBnBlAP0DSQKnXn9Mz0
ftzGp9lMIWo+2XRqjBx9KKUOAxxwRX1EquoJ+2Y+Bc6VsrQSgXZrZDMhDtdA6NYRq4poMnQdX6Sb
JkV7As2le9RF1tHGpqp4n8GU+53582jCzIVKHSEnc/MDUEd5YNqOvQQwoLnHM7sd5dUjG85Ff5yB
Knspf2xTun2H7HGdwAU3hGeHjfBXkJph3qMpKxE2R5qOSL6RPZS79QmGnInQ24Rcwa68zVhCMkbG
K3aSna+l6plBon3vFb+KEYN7Fv0LS3AHiuZB9NMB68vpVjUcJwqWqrkaz54GhTtTt3Om1p1fbogz
t36nHDBPlMen62eaH4Jdo0ALlCDwVnDjOxm9cTkGkGOlNdKqpLdedCaJM+FhNFhMXu4zUYFzJ6E5
he1/wSNJboA96WmQgEWoq2VLS6bHiuMIiiS+TCby5NigdJAuNTawIfMzJhOUz4DOu3vAI0qxlfDH
xpda5+oPVz7GVAWy+jHAOIAF8+wJKVvGG5m7HqXRT9cVod7DRaX/t1B+VDTiTiqN78ryGhHTXdW2
ml79Ab0VZQjqPI3NyHC2m3CqWr6V/2IXklVfv8Kfgxs68CUQolLT3DaH3J8TEGhY/T5/0CInoyoD
LfqZwOX2RhZDoSiPNoYMGHg0z1IQ1XxwZzSGRyLHhBkNUbxoGPqMSMUzzgZ+1eKVMufIrOTs/2LK
Yhnpw1WHZB6ezthT1D+e/pvlQUfOiefOak1WB469NNt4qk6mrQHTH7OSWyWcyMufO9zhkn/9pU1C
m/NeFIeLfVx8XJ2GmKRXqS4JHv4wVpqpgxxTdK2pixJIq0TDHEiKl7+R1CGtbAXZBBvHc5zI438j
WpiBI5/+RV2LMXIocubi1yBfbW9yo59lEMU9ThD9njReDrW0G+/8Mapq66jgBeXjc40BnQoOvXk+
8U5usQKGZNlj0ZmlDQIIJErTht4fKHpF7/bQYYREF2I4f4dlUPQOiNyQ51uKnyj+IAfI0bQ4uwzK
pUOtnimG2czrNVh9uudBzAAZta38q7VeeYKvL/VheM/Ka4mayTPfH5/vdN1FXcVlXmWybLANotGV
N6Kv84tc/GPtwOl6dtQA9pmB1Zl7lz8/BSf6NepSJSc/8WCEVd2HRiiYU3KmSqwdhc3RgyHPsRR0
IOYYIAXtno77q6Wskt0Nfyiev19afMyMf+TKfDQE6rO7Bn9kWu3ghLEoYT9U8Uu1V1D9UjvqMpsh
qwS8RjSRmYwUcmRD/kMkgKlYCDYT321ybapDuSyiFBMCrSkSeXmwWjUsHowsIsIaH9KNRR7MBMOT
AIIh1/k1tDW3cBmxkR2QDULrMDNycwCA2nLWqI5uS9KU2q7KCbFlw719E/jY5CtR1fnVeL83JbCG
AjPNb88VojaGpTgi65gL1zN2bCjQME2CDix0uFf4A8Csf7lQvLDj9GXvgZncNx2f3hZo77M0CBaH
rkQ0QVpwJVZ5pzWOGoMAzmSsUNwaWOKCu77JoykB0P7FsGKuyV/DkXM0THiWFDhjatXOliqNyxSY
P3TKkggtxarlF4ZwMzKKqrZJO66lQ/ziP8J1bnZd4w4CK/6c9k01dMyhMmq+gFtRmLx+V8vS0UUO
zt6ywbtsBqsBTc0qNtZCLz3xPWzwsG4YnbJ95Qx7i5Qxv8Igo8/ZVBEmuqV2Skc7xdw2YZxYhH3L
5I0u9MhPE+hbzT8f9DxnDhLDC6DIbZhYVc8mAVOEK+DU9gUZjIbHkb7tsVZWXJD0GUa72BKei32d
DhXW/noud121fCBkC1UtrsZE5sh5xOHSBYuSsEKq3/g2FuDNeG+bM2a1KX6P5wW6pFu0PX36aSmk
qVEO4h0wAiGr7yU3TThBqExQzut6L2p0PLZ3vxbJIvTHsv6fdHa5GN4NbHKdirAB3uK5/4F5fOcD
8j9lH8/Y6OiLV3sKavStgFaIvxckpTBsUeTVytvsqV4mWHgzK5Vx6Ey1DcOOXhuYggXSagJJQt/i
+ncApD53zpjklSa66CAwSybCTrVL+RbXHVWBR/HVpT9ZPfauHKJ7DJ8gXoeqjJ65Pm/xBdQWdhid
evnTv9zER/qXVFLAyEBALGVsOLy8byFbnF7kmWrNGvydASC9tZwN49YdlEmN+XbOfpW+Dxx544W8
KJSVlo5Dw1yKGZamWOc0bSehkMKEjE0nHSXDtd6AFIrwiephOUgiuRbgMQ72O1Dc2Um6dsFdAMRn
12EkgzKnrgr/sUeFDJX5uAJz/CZQ6CFg4vBdnNPZBKaG6OtHwKXodeSiMMPDZtFEzYeSSRIC9Wq8
/hHI6OizqmwfQMBt2HmpofShRCAIuv86d5nYr8MTgIsOgHVq/DxI24jz59Eqg3ShIneOnCz+rDEX
VGH/d7QBw3rM31KfGhiSCGFr1z2EPWF5yhpce1GIoLCf+ietH5QpncK9XUuFr1/su8SCMvLXk7Go
mDTnOe0rDXuN7AWJdjuZhKRRmu4morlFodCC5TapTdHo3rlMTp4nqEhO+FKfvcEdT9ga/4Pd0iVf
g2nC5LDV8sV+YAxLJTwZK2gTiILDVyN1TSXgbpphn1cwEUXi3gTxc2uZ5ZSqxwmD9F5QQ2G9PHej
PvkILuyEiW8T1L/F55OOv+1bKVBTegXkgdDCupf1xtPd0X//ElPThYYTywbfFn61buKAtuF6zfNj
O3ym43leopUXbV6cmNTTB+LTf5iLL+9P8MNJv+CL/mo3MSIeQ/8LG0v409JbFKJMAMCfZORkX2c5
29ru91e3QCKd+2OAafJSm23Y8ujiF/tvjaPgrL7w0CdXAwNyirLocA8alkaK+es5imO6Zn5tYqQF
xlfMwrnkY/Xid5GL/SNOL5wB3rNi3FDiMcM6QmiMxGsK+UvHstVk9pdb82cM90BoaDXqAkPuUtZj
QITFqY+Nikke21S/YfDUf3zkW4xF5DfOprbL9PFvzgJjIYthI5ajGlF1qQpcD8DVf0ek2i51Wh+q
JK8yRvYoLrSkdYVY5nkdHRt3X0QAbTOGAhTZgDbH4i8xF2thQTg0QtvY0m1sqOXZzMFuwLisiPwl
zoxHDGWaJBg1b9TDsT/fTwQBo77GztJXLNEe5UTBo05eDpSbl7p/mQ0ceyWelXw9LheTMo3JSrIk
yfAVkaMar5di7yFlxJi3iHd54aziVitkkLjtFDjsCtnYnwUGTNxpYlfYQQcXn7NMc06SA//QSiId
sHJp/9V99ZsBGxKXuXvQMHveNYWuX62JqM54UwP94wnIuvIJTGAyEuLNx2XWzY0o4mAzr00/YmVw
Q0gZV6b625MPKyaavypV1KpFoJElUywePjjlO8FmuD4LX3uDJ9NgvtnvAqPpBd/J3KE9CbtXp2zF
kjYjNGjvAdaoFAotVdtnHjZ/4gu1VnSa+Rj6M4XTSjM9AnEHu56KOz/0BrfPRJ8wk/FrSShOTvgd
6RAwtOFmPzWy84BA0W6/d8D3Af1b3KTv62C6AHOE9FrTlZZ34/s6NurGwHOiH+mN4UjWfLPmDVIn
06OANmpHa0Apmr5b5dGykwvHjPOVGRMC/G0W/9NjeDWDg8Bqo2HKzljQ8WSfjMnk8E1b+/Sv9gBC
V0yo1bGQk2XLOus1/XTQIR4VKpO/qPZZoZQ4cKuc+QYqjeow3pzHe2jsLCneYpQPUDVG5Zd3XKJG
Rr7V1FJ6XwgJiI8W55d0QBKZbO5HeTwyxJNxoFHY7pSPUP/uI8nFwLKVk9KnsVeF1x18IuHTackl
hDfqn7esMYK5v7OApXesFrZicTly+PHLj/dQZOAiWH1mhJbydhTap7jL26Zv0tFMUwFRqa7LA9Nx
N6ZJldh8BzYcmvkVKF78bALHVXo5Fhu8WPzlxdtPxv2eOMVZ1d4Ktw4k8FR4D2GWD1nNrk4gOfhg
0Wdspm+L0gPEznwxo5EhnbBtmtiCOhBloAdpYFUkjPJUExaOS6pSjY+G2KHy83AmMuX1osYPyS6D
7ywf2ElZaDPkPXsnHya64e3PrGQS0uOqtGa+HOD4vseqcrXxOjHfpGfnIvEasR2J1JE8FHT8EHwy
cY5XvkAOVW1FtRu2c/PkpVz+oIn619+t2wV6WbzcJWuHBZ0fBFcbkOuaADF4ifRrSmbPaLHGd/tN
jn005uy/sxlxVQgSQpewJsDPuAJ6ehTsHbOY0+D/HyGICLl0BmHhsIpnhBAbZDWkBg5sTLstoRHm
fFMxrWqD4VGl8rYae6EO4AEecV7HvvEx3Wmk45gIXDDh8xF/6cI5gPC74CcA9AOOgE6kzRGtMZi4
Od8mWZ+nGNn67gOhokzO2ZtWiZ9BxouHxZrbnnpZkbT1zKBZoNA72SO62nwjDNxoCfOy0vDxI9Hb
/HET2ct128G1kBjcycL6LJXTehbyiTWpqogqXGPf4m0O88MIjPMpg73u5jftS05SVbW3fE7RcjW2
Ucv66Ub8gOm/lPX5Egj0hl53201sZTU7CLFYd0TULtBx0Mn/mEkYciuUVGPOcjfCs1F5GWwe3B0x
ne+UVCunArf8gjfzKU9z3n676gkNSz8P+dY1TeeQRn/MgSIz7uxUlGPMJ7hPtfU0j99tiYBdlGeI
gTtsRkqha2rk06Dy9CeRMmemEHLUsaH7Bb6hsvRpVLx4LjkhtM7lflCaEu4qG/zmH9cb4OERzK67
nFJiC7Ke2gJ/05qkMz5tlsWxizPsIn+JKnbFPi80jwGeaTFtrfSLhZuOCE4k5q6tW0FsaXZ5WpaN
48g6Szo8vfySh/L68ph+mJ2DsVE5yTJc6Cwfoqgp1TKvQ+ic1kroLIG/gJqvv/nRkmWbQHDu9OI/
Ki6o1f7FlMcnaWjtoRBtOhfggDsLBszzBA/zlwRXbA3u5M/X4ilRwRY57Pa9psJN7tMcdHfmvtWW
kkKQkNd1FIdsnJVPQ8ERDCiyy0hHMgu2UxoSYOw/OLC50pGHi5JxRVlIxOXGP3XqZ1LZwwWPeg5B
ZUHAnnwgmC8+eQUIoY0D/x2gS/toxACLA+SqwqpKTww1whWnOsHDj9Bu14vCiglWw2iSeYCNt3Up
iOhaj/cqIrZtfq+bwLlc9ctUhNT3tvh9SL50D/BHaqgAcEdA3E85KSTP6FFC8S9uuJ4f9ddRpnen
eJ65Gy49sAGrlNE5+HbAPUe7Ktcw31KPYGn5xlwcU6HpdVMnJH3+r5+n1GYAyZhv7dNrArKmMQt0
sxWI1MDcmGns7apO59ghs8pYk9lLGnh9MRr9qZW4JDYITE1+OuEEjaAawSaimgdXbrAOBhFgG2f7
1OOfnbEWF5AxcNyyr86UGVkC/maTX7W+HPHOPrajGakzbU4NhUY5Fme3Qy/Iaaa4MUU7PytQ2R6C
UXfUu1V2xY56HiddP1ZNrBQ8vB7ggF+YiLUrXUq7gA49HEJuXy84oDB8IOE9w3kAUkWP2hnV9cx/
HAnJ3gBvkoLgV+AFF1I8GgQvtD9JzEeqOI6fpfTiRwxh2Lbag2RwkQ8kckzYxb7liLag6ihrF3DP
zVh8K0G0mlAfd+z/RqO8AoK9MCbS1soeMmPpgv/U2yzjghww573SiMT7cAPvwDQXmjDAJMSnObRq
15b+fgoaLYLCMG8iASG35QcHrnoAT/qwGjxxNi/U2PQAY4ARd61Z9K4zlMCsc4GnYexXwlMDunsH
6ATYvRP053Zi6jrnfYIeIc9DUEPBDlogi7POkf1xjL1oiScx+MQZHZdkGROzKdw2VbTeQJn271tV
USinXtz3GWRJrj5LiEseZexSzURq9osD4XYX7/8/9w0H38H6yUGog69BwnwMtuHA9528tNH6wSsv
kSV5z7LhXRI4326J7TqhICQ6s8ykeFsQyQ7EPqMeqWNfPwv2N8hbgYEP3UnBmg6PVywPlM3uDejc
C5x4R5Phx3P8bu8VK868LmqQ2b77ZFubVSmaFBZ+GHZh7nitzP1s4JqVdPqTnXhbj5z3JyhaPZkf
xfVCQQ+MXA6pCXpE6hM12XkldmWYNyVYQ/h5qP91ybUQKNlDQ6YZdoYGL/czolWUzXgC0uhHSvSa
KtBU67JeeEOjsi7t6CfaWoyx6XWl1TLbeUde0NMLTmwpJlV2YywReco4CixHRAvg7ViXUZREC6y9
ZSdBtHdiHknsP1vvKCEwN+mdg5+Zs2tgeh0j3p5CMruZbYEfoEtVHCnHmgjttYT91H6QzWe47Ch6
JuXheog9yFJOEqHDgPFL8V4PQ/k48pttMbrNExFy1SJWJKsSGd4KpWZ6V8hv8nX7VJH2pvjOJJmF
qtYwJkaA0QQYxTEK0E+Q8j340TZ/d9cyK+57odxrxhDBT78zzQXivEpEa1K+6hzL85YxNQ5d4pkk
LUQpEGrRLQXR21JresHai7U+I99C/B9altnBbv7+d85UoNYIj4yr4XlfnrxwC5cIT6DNE9zDzwMe
l8uWVxcPjwv60/GAuXLQKzXbTm0Iwpr57e5MQaSSbqErHO0BuA/8efoGuwiuTSwxHjKkahae3Og0
WQH/wZ1OKjwGUcOrSivRz34PnP22beYahOgF1ZEgX2rchzQKWx2XHtM08OMmtJMW+r7MXW3pQqCb
bX+O0cyjUOCh2EGGxV64N9iV8nA43UNq+jWmuvESmweTa7G3e5qA8RBBL6h/ZdnozVPPdSSvmP0J
1aL/Zfk9V5Tw2cQQeNPDvrc696rOE7azPPYb1HRPcydjTTM2hrxB0qU9IMePh3ziFw9BkJHhnVTl
W/zQWT51mAgg/DI2HMhfHOLKH7dFe9y6iBymWCFwHpaiTL6QA1oQ3pj9Od+lr24MbiEGpQl7JcIq
2+aaf8gZNwoNMCvrxLIdblng42UycUjngvtpMdhK3MWgODCbkk6tDMW86lVLoDN2iimSohEfOgz6
6EJHZJ6UdxKzEEdhV54GzI6Nofh74xHmM/bL7iDutdoE8SPIYGPlii/eIn5BeLwGNUXc6f88aTty
fNy+lWLp1v4ixnP6JaKol82g5YsiOwd8ht3A5YJPgzly2lAgF6H4jO4DE+W9bpLxSqDrikpsHJvW
ChEOBykONZCPIVf+5GUyj1qySAJSoBUUEZaxjq4m1uCBgNuj24KBEhMdc7WuQ+fvaGIFbrM5AGve
szHi30Ut/GA+9dWKckfVvs1sxjziNG5nzLRxOawwaMSqomhgogTCB9GBeHd522AWFOvOv/AfWCqe
ay5M7WVd4889Km6O9bsSAFRhw4Td5rEGqHB6N9yvqxD+o2XMiAsWGuqgGzhJFHots5NpgbCKrT5l
rMnVqS1Oda7wn/O0TcWMa6O75ZMxcXJZfb63cvdbefIB49Y7sRsYneTC53V+daV7Lt8cbCZgqmdr
/lL60cC6krXuUJfK7rgzO86i5yqaCGwH2D/Qj3K873toEapAkid08HcWFZZTJoBJbOr3SNIYrFt8
pyzVh7wKyi0HvekGdyHMCMl+NwE8d4/BkrNNqyxdD1gXAt0Bc6yGnQ8NCw3N188u3Cy5IRrYaPpl
Ezt4cl38b27apMrntD28MfC7n0184WpNG4TacKm0oZSiLI17hBGZhXY0EyRosDJLT8xyDjEn/Z/6
BKzm5zoqs/F5IlljXScIJbKmQlQeNESjTD4Melx4dwmHAVY8ymWND01HiohxhFULTxDMadwjiphJ
wL2xxo++dMipxKG8tfWw8z8iXUy89x02XquMC/psNgFl5eibx9iUoUzfvhBUPvgQVFYU+yw2z5mO
betLndU1xvyIPnX/kKturWgUeZJUpIlg5Zu/40Uuax/GPrw25cW2dp+SSi64uNdT+X3f+I+87Xt3
b4cTymjyii/16Sn/MzTjvO5ZFpP269Yo07OygFfgoKQex5K3sHdJscclAcN2a8CYPZ10KO2pp0jO
wjKOmkzbbXLMDL8L8g+bLVlC0DxFPrFRuI6PTiZasQ9xG8MNnYRNBaIABiSfUodoW9Ec39KolHiO
Sj7CWs/WOlM5voSuXRpEbHcmYZEVXLo1urAHnZkHZyrTBMSB6UlkubqYDba3HRuvTU1O+xRgwu5e
eyjuZLZmBpHpKZvqm4dc9kjovce6jO8arbFmQ20eZVAbyx3DeUmUqeWl+tebjbgFle2fF6pLqNuB
Hix5OwnTZ7RuQd9viSFxmn4VSMCXeUTWgspgX51CiP9Qvxsc5FQZCUtA9BcjsJlQOkf2/xiFj5Mw
TzatyfQDKCSp1UA6i+2vmZRiYoo21OXymDfhn3J+E+E49BiykRAsOiySBA0O4fbVekM5hZJHswdu
5BbZbZOCVgnku5c+6V7k/ZJ0v4RISvB1iv1AZDwhW1y3DTKKQo1AtUmgWEFZ5hEqV+nvBoVICfjp
sInIyN6FLD1MYIgxpTM6tnWoEA6Z3xXFD7A/KjnNG7FEszBuTgnOHFBRjEZw/bZ95sm7xyi0grVp
rnSAbwR5yfCd3rKBaVkrnO/XTHJw6YI8GidS7x4nocLWImNj6hfEkd8/tFJiFfEh4rv8gdv7ILk1
FmMhe7mhES6kmOqDvFj8k+a64jjdUynqkZXtanGeZHgJqXfPODPQKuQHLzMlW7WRPXs0+0z4/ZTg
G8Z8gUhz/nMOaT2Q0DSh9FWqXBBmJsQu5gMmNlBVMxLPrCUsBs56PTVzZGHqbfh9hjRStaxE/BfY
vyZCrzPotzCOFUIX8kj/qOLIQXbkydQVVspl8oM8JMpcesJlRugOxx+b0g4ZPrmlePRCD6S3oe5L
tvnIOiK7oTjITmFn21pSOhX1KK+PKcvc+mVgdJsxGIk4gSlYqgnExE5eGpQyx49GMoamxyGtc+mA
C5OJbEtGq8lHKvNHfsuba6f6jByyUVJJBwZ8fbBjXagsn4lrgP+g8WiBgsOTKZKNyLd/DdVARBkF
UrqQ9bLKFQ18X4O1t0TWj7FckQylSC/TN14cDB4zyTn4R9IO8plzG89jPB2enqD/z9tX/MZ514tX
uuiyd+58kujwXNkxgcd1Uagio8HLtC1yWlNQC1XjVpV23xo+1jNSjUsu3vmPC7jvcAgSSFQmP2YU
RhOkA/si8QPaHbPjEuXiGlRtEiVykWR/o7TgRsnD0nMMee4yz15zC1yjCe3ny1SWc75GJJZmGcEa
O0JTw6zRNKTzZeRaOOUKuvEUvyJ/fAwrdLn6UAJmQiy3FFsQomJLBM2b2cDnQiUlnJ56gvY2Q418
PodMzHotLrxQIHdMPngBegPL/oNGxG3EDUFmtHok1fs9Y6JgziN9XnAEuGpzpiPOKVl8XcP+Od1+
3NYWm1Gcyt5KmlCiBGgLdfE1oe5iSTQiYsAa/K/JvIvCOdDgswr0E9RuPWTt+yO5vsLFrMsI0rPZ
zmwPxynB9irkCDnNEcW9MVFL7xiE7rzVBy3gqlltiOo30vYUdoOtPNSagfoFxX7N2Kgh5EaO3w/8
Q8TdnaGk1RFeSxxQ/T6MAnzTI4f7fwzpOYyhJK+3J/ydvjl6vcLTqezyjz752lWZzVJvs45Tvz/F
+zw9TLopX5iIsIllqtAvyrH70Z6zGsl/PjSTBBS12Lon4E8F/M1AZXeRTMd17XRO3PE29XU1WRJf
VPIkYjw2AGsPYhjgsd4T/yL32vK2ZcGecJa29J9YOpzD53Yx8PVqkTOBXh+fSWE8+I7GI9yGE1ll
KBsnHG5xM74RQBMHKflauf+6o8CjZazmWNXV7Q3t9LLUkAGW4QPxlcAVc/0jU1NYeFvgj+0wkSF2
w981fiJ5ArabkPFbrKQTqNIvQWg3oqG1M+Xf6gLETIo6cZ7vUPcueNe9P4BmxG3S+OiXGb9U2ZZ1
VcCvaI8fL8UWVXgdFsz8bHpuUvMkIXE+LjEj1hBjidGOiGgf79NezTq7HcepQDPabIK4cBceizvI
RmUOIqlmWlmiM/QiyPUX/oE//9Y0p45N9NV3gSSNOkbu9JUK1FDxTQz+VqXjVQz6+NG6MyIsehlh
Zt1YMT9RK1LgRL0Hu2rYNfJoki3QI3BhJQm2nbxlbgwU8pT267Q9gWPw/ijpdYxqrN4WKI6glNC9
y/nNSwg/CmRTcrDqL0VY+WDX/saRs5sjIWQI4WzzhijhMcAP2ZgqGK+4vyPpZe4hAg9IUiINow+N
0IATDn6nrPB8DrcaYSPSi4emIJW/l2a3eBvizHqoEHkMFivxKR/2FRfSIJ3/lpXU0mnzd7l72+Pv
FCHxzWx1ZYXFjOMpWrK2hOoorjNJwBsafEL40iHUpg7krOCADgCE1IOF1Wa7GgfGMrwSxG7zpeKJ
FFZDQQYlcRkJlZSApISR3I0DJ+GBQIKXTP71mdkac99QiIsU/tTnW5E65lmnorOuT/ogcLUcuW5z
dAlYOZTFMWbHneQzWwYVfYgrrd6UftTWZs+u+S77nL9FwIwkwYtPD6jQl0JYrqRmEG9rk9htFFbS
Wi2JCWTkJ1a/1tyhljJx6rPnrDQeAnRalhhPNJLwAux3IJx1ku4dioiuD9AWqHTlp9GK2y4V77ua
3wcP8PjkqJT7/96SoiRNOF/ImeFGaX7EqTM6B7vUE2tQ0hbu8QVYKaC/Iz39qyukps2CI3nFv/rq
VGsdUmOpbhRSv0OwWNreYgGQdD0Ciy58OLXrTvsL4bBWpaY1NQjJqbCtyjx/LorRGBd/fs2QmsW1
5Ke2mMRd1OhrzjnVHY/XRiYpIaYrPdQWNl9o4SjrnazeSuj7WlOytmsG6HJRltC80qxlrVImGavn
jpiAOhW26KkBO+Rj/8SyI1BrV3KhCiidxSKh1h+IbE0MfQ5u+Z1D5ZplPeW7+5J+HgYcEyXOVkus
Iu42oyNn7JrhEBX3E/L7f7sj8UvohRTvIKrWePtl4x44XVYCKNv9FWXaIwpXa8Vc0lAiA3jlyaHc
jO2ZAqfCgFu9EpxsgQHrwlre9Yb18DBrTLoTmQK/ViWKpGzwjZl+VcZopHsEU8saLj2QPSDquomu
rpKmuCQaD+4eVVD96LIxhj3IGwjDXeJi4Wsn2ydbTZfPmxQMTBgPU2fRlHPNCvKM/Hx2c0LsSJub
WCAGlKZ3FJGpV9G9KJtrNZZvT/xnYxqz6OY+DrJE5hEGar/1gaIRDAGwIoOcUEDP1COO+555J/gc
8ah4MtgekqdD0YsnSY2A4WVNP0FcMpJ5eaubYlCqpkrf+pfKhiWZd+VLz3OvsfORmK2mjDQYef5m
6DEG/ss3Ic49nvIHPiSw5kOYIyEUiriio+u9MeESPn2kQ80nsmwiD95Ht0iMMY47FOlltS2CNsOs
bkADGhAkQqx9gJkhcZHrP1u+U6gg+peJD+LftDen0ss6VKqEyyGOTHqb+EWez/sBhPRJzKczlM84
YKcmUIrTxBmD9X0lHcHq6GqiTbwBPpj0yRzEgPvisonGeNHpRFps8sCpZGu4w/Vg7OKswUkSri0E
AY1qRpRHcM67XZkfW7UnJ/TuhuxC2RmbhdOvlCCyFMIbmd4i4PU9nTvDneNZaheWcRAy4xouFHiE
2JNtuOsnAxE9Rwn5LeYN7cZjoBO6Aaw+XnPyVMME7nhKbc8S2vObP1xmteDbgKdzUGB3nt8twsqv
YteOSbcG1BrHj3WB2B1EsnCjh1rVeZE1eM6SJ5LMkkhkOdXZk/5sRHN8O5T4O/A2NrmoiqjB6l2N
U0nGe41CwayxwQeqA8jSqEh7eLrQMQ+YHeksl2iBx13bNLp3OhmGsUE4mZr98QtHFmJkWrP+PWNR
GA0/4PBxhB/d2cJCEorXyw7F9QM0hOi9pM9qMyRpBI9BVPqBA7bZSpF8b4kMigQO31hoi4re9I4x
zZwsfQ5Uf+MNpJ5MwodCnOZ7chCQcuPo15H2uH+PJ3fkHd/AmSFIKmuaRXT33Ey44LmKeLgF6bVU
iBeMv9101qV+pFSqaDDxNElRVSrQ8K7zNtbJtMBjTSvfBWxnK+6bgQX3QAg+g68JJnEJypLGuVC0
30m9YjRIdJYUtj5FZcdw/wKnXpO+0/wfFbdul6jKglKb4khrNiqDkQ0IKTTF0uvLoZ9Nwei4SCDY
7QxW56jeBOCILSROT4x1B45H81//ZmcBr/YrvGViS8c224FWTlYim5kE4AEMLVqJ+IQd1SsVcnYO
0ljRQHphEPk2nOhlDBr0m9dc6VWwiHze0xeFRWuWEBzNCf+qP2UJyJ7yA4elG0Fgjyeyi1HWFo2K
5BTVUTbYABB/ypqlfzBlAUctWM5R697p8sa5A/oVlCufKm0v8ToAqi75dnGxBAY8cFKlcQKXwbH1
+8VXHqsItkAhSUhRJCSuiwZihCQ7aW0WBu7Fsol10/rh/iZvQxBVlB0Pgb0WcggOn1AIiibtsONJ
MCNc+sge68lRHeob4/pxbYOOKOG4sDJ23cE/ig/Hb/t9BJTPYMNVvrFUuZXJp/HQ/ksUZDuMXnse
/7hBJfZCH36y1aN9YzAY1TsIGtc0+o2i3koiRU/kPpuElzx6/ubws6REGdv5bP6UpwNps0PeZp1X
Ky4ekw6OtLKSoy7679cCbpD3vLQqf8CAQ0X9k6arJDUHYh5NJt7v7cyg87TXxrUcVE8VcVqCk21/
SgYmxdXhHoaJPvnSFSMi+ggdd/ii1DmeGF8X+brWqPMcoHNYCedwmRv9bLufJ5ViuQS6ncOts7n7
Ike7/HvACWCSvnbY45gjWdkU1IQvBrYxv2ESoWDICBKJblEdbTG8bpCE5TXTHxpXlUKql7EfrVFl
TDI8se+vU0a8yA0ftvZsOvNrQssvN5M6n/Rtzqbii0M75AlCsLnx5xd+VUcUUNmX+lMRVe1dQafW
IOLqBpZTCpQlSW4VSxX7oMRYW/5rbnuRnH9ah07kj22z/BPGdHv0bA0VykF/dHURB7GJfg5SolkO
V1ol3xRtnaDqON4NcpeFPOG/uMj1Cg3NG3dEvREmkcdbVKfsJhDBlcK3LmP6S+YIShRhh40yjEIy
I+neDvx/+RgcxC4vuL0DOZc5ztrxK91w5lzCzyMOIVtV8kD8MyIoNToFwFPULeZEMUjgDwKPDUhN
nXCVd0x+X3P+4/3lnHTgmLd+pZct1Pq0TBk6TnIV5iTbRpdUITLW7+OjLfyrAC3tkxADSZyWiFlA
Y6mJ7L3swJjvUzz3ggcaaCoNG3UaEOnP380OShqDiEhvzOEXHph1mQOtniTXhBXO49aSKeZDFSgZ
VwBwcLOpOg6CNR6t0NBTPatKfERcjmoFzWra9VLbe8PEz/Nu6VUIPf7+xfYLdEjTSuKiktJjOOFL
Vi2kwklJOrCbaGiTNb4sE6ms14vWim9hDlCjXRc1L+IJQo07LlvlH/r9CVcAWJh1jfSXtLnbhCQD
HMS2vVlKjWN14JZ9U/0rs9rxsuCAfubWKF+XWvn/3CKaYbPyP3KvUlJPTRVi97SULivCoQbzquds
ETLGDMYsgHP6kXKtarIIkkdh6m8fc9d2TyTYOoKIHIgowrQNWBa5hH4hkS4eg81ntM+XbycfgFMq
lx5YLI19AlAgRqNqe8ujLNTWGiB0oBaD1pPfMcW80zQJuYoBTmySyIs+2/yTAO82+8KiuKhBG0cb
Q8iSqXktd8JkZUu1gfA79hZV1F2jtYnFguCdoVLQopX2S/XdMaNioRsylvUF0YDFJnsBCiq6RahK
5wTDobKkGlOFrZarHWD0sTkrwYhebXasW8EQztOjwzGvsgYhdzl8KvAMsVX0hkuJfc7pTW3Dl+Np
0K0DtrfIxhvYTewIRGd0ATEvWok/R6g0gZ14FLrmf31Ya6jA5RuKMmcs9o/t1F6EYK8J+6OYJEr7
o2lG+sptRD7JKFnIQT9I4wGGDbiIcaQQ8UOIH1xXOHRCKw8MVIhrZASN2JkWhn+lvdCyat3nJsld
vDCzzPtFHAqADIgkrijG5nIGgJ9CNfmf5fIMjtTPwBTuwbiCyAU+ojOFZfSholg6NVDGeA1QXnT/
dLTP8Nwsjv1rfbJ4205oq7Gr2kW/Drdpo+K/32WlLur+ek+e0J3WGH5otlb3Nsn4qYj5l4f5v7He
wdOImTv4Hg7PVAspVu1VaL3DUDvv5TDPB3f50Bh0IVkh/WlqLG/z7hTD86twHuZJ9VYNW99tJuyl
P5CHK1NaqeNPEjTQCULYr9iJUeHH4AV5LUF+eMS5+3vImH5EuNukiTBwHR+5zP0P2AyXYlUllox/
jl26llwBOmQQOzMlvGO7DQh6hzuOj//zw1vKZnsqQEuLX2E25SSuypsOxWsT9qyZw3hXSn9wgNcP
znWt8QrZwyG+n1FC+7InRUHBkHtfjP3tj/1XYYxrNpb7V3bdJZJchhtcXbwTqj2KUaYPOJMxRlft
CVjNQpzhbnOoRdgvPeplJyBJlQ6lI/I6ilumcQIMvae+0EqAkixTwnhTx+c3zdhk+iZjIRuoYiAP
Bu6wJU8HbDzi2c4gFWUDYKbnu/34rU/jKdj9abZgMSf+piPlu4/9VnIyc37YVXBjxpIe0xY8jshK
1TnhVspgFtd+NElwFCITgd0/BDu74yxSfapqFDQ8ysKnmlsnGOxJeb3HTquyqaQdYXU9m3UyD1be
ky8LbIQerfsFlkmsOjZKIvvuDqyPX31lqXpUMluPJwyWf8mmcc0jEsK0SoQPvxgApBkdy/CC5J7H
38x6kVwJslk1cvTpOxrHVmtVVRJ01kvX/tHtRZM+Tz64idumSXaR9vdmtPUQt4bvK6qMa4csrSO3
TlBaLjryyh4HqgcLn8p3HZlUBnBLTfWTkeunz5SMI9rqU9zTD5WXI9sTTscr8XFTMfR2qp3xa+z3
dmvEIzIXeMQ0QoNAPjmSgfq72iXhagVV5LUBTnBn5LFBArCKPQUMuvRxFOSWDCQzBFyoilnNS3St
WJFkLzXnQQZ9VOIQe+1lPjjp/PUl/JxVc8znOgg4Q214SOCP+RQ840Q4WBulJOPVf9CSq93MIJKH
0jz+WN5SnhyhVh/ACnDXC5YZvCWoC379MPze/BhG3EOnDvLNs1kDDBASmdEz/QaTuDgegGqF0W3b
wExv54debu7JkiMIschxIxBkQ1nym+uCq8i3HThi6LNPtC1dfzrfpQsw2JztjKkqoSekjYrnAlGm
ww7x7NyaZgWKZylq+RzU6vW/J8kc5+VsLcy1nE408V0tl77tywh042GayKeDfNo9PYS9JVpfOxrM
QD3qyQrM6sDn8Zk2kUyQZvmBrTZNf93C0+b6DF6To/65AV4xnrwP0M/0QnVn+/hzc5DL3nDR0hYn
C7ONtADPrLoLd03QK47cFzsjU0dYwaIOscsiCJrTgI/TbDfT8JvhaVd+KqGCOSqaZZzLykrTUPZE
NWcJ7KVMU45gZOY2I/Oiy8EtCfA2B+AdgXtXBqkOcGCPPBDCIaDFe4b5ol3rJihZWVYq0hJer+Wp
eUKKtba7ZwC6fvH2MwPpZg2DxkE5WkuprliFO09bnIrgJr0XgJVQQzrvEsn8BafwSpWvX2F+hpTv
jugrDYDLfriB50rwgs041072Y1BfQuCjHXR9vSr9vtJt1OdKYSVQDA+yPVjL/4M5ltrdV7/7cGxB
SzwN192eZFrk6WL6HSxBJtHpIOtZ8yx82F4+11UQc8q0qxD71HClSvn8Q9onBufT1OPg1Q0MYSvj
83BHKlpSBC7tmJ7OqONhJ2sUMF7NVHHZ/uPX5VGHMqmG0Sb1pwJoqCxZFZNQDavpHNgd4qyYWzx+
zFwKxsnz5aUaov54iuNf5IqSee7mvv3k+cphRXmp6noRv+ms5PnomVot8GG/AC5fGi2/8lAitVCT
6PhwOyaz3Nsz1cHrNsYPK95mvhx7LEdIoxyBk7oIR8CBE8viuo6JMEmQeXvV5n6WYlXkXa8pU+Ih
fRLrrxF+ZvFeJCmK+XisNXVQVioB1DjwZ09CajvjQ0t1brrwmDbg7uTmGQQRyc5DpRfgBdJI61rE
TRWmxh1IlES/l5NlNZxdLgDX07/hq+G1GWL2AWXswKLe7J741FH/LCNwnTUQYJgIfQODJ4HN34dk
cKWNUf9xb9OP2sYAvL+ObGzoJ+2Xp/j+xTMMnPVDYeJmj9U4A5MQCrecLysNULnTbgWySSl+zZgx
xIlMLJi54DAX6i2Dtskgj7CMTz+lbG+RrKaTWk8jsEkjwJdWJdhdhIxwR4r3bNnwlspA+wVPCNI1
xFSwsphhZbVdPzmJcCqGf/8EN6ZYxRbOyMPxKiyQ3CpRNX6lwPjc6GW+Gbb/ZltutMINdcGdLQHe
wSsfbxuo/r/SHqWHdHDdXvmKGkvonZoRI3DW5UA7/zvjh/LqxHGzjxb80vcL0XFHhWB7nJlTOiaK
bQD6FWvgyD0E8lPcGMhB1R+WKQ0z/FTTo9UAFLUrwgRHsLYcdbce/8bpv96zuWiRX9GsaAvbRgxu
kdMy0nF8WE94ewDixiSfvlDxgUcQY/YKaW+JcBvGDyCU8MM8YIAYrIAACXiiPJqGBTUAKzhT4csH
rJOcAcM4mPjiVyxc84dldF9+E69ZYy7bL8xW7e3X9F8T8twEcK5F9rAt7JYtZ3dexikrEmP501AP
HYKy86Ohe6WzQQoW3uu15qxwfNolDbbDckkSkRuXtBZrWCnrSau1esh4IvJGHHXK/4mu+DB5xSW1
iAngdTNowW81qXxgbN5RdMaz939LteN1ZdAwlbUbGzc51waD1ExWzf7rPILi5cf6eAgAF8QmlKS9
vUgjn8d5KeMB59OTu+Cc2hoQj4+8DjMU6Osej+TnGEN7amUhajIIMg5B8zN5TD+5GcPOPIoc94Aj
VMB16HM14f4gLCiH28gduzLNfeL33qVe5RdjvkVfDYuyJDo92M7LkQoid5fBaQ3WvN2l/EO9bUlO
iUyYgRHJ3Ww32Dnfp8+OFz59x59WY93fJ7pKBFSkGg2mNv0d+kCU0rC5UsX0po7xaJLhnafQj3Wy
13MtrR+3gNtdUzY9ZfDVzIAWlaXrQ6h329eCo6qA1L6CiikVIjODzrGWgzoFxWSuysl3MgQeaxYY
isbtC6CbYm+1mCsyeMCeplNGH6Cwxe/G0yBnfuYLyFXdPU6f9o+MetZPK/cBTZze68aUiwJdZZHm
sWQMROulU/X7r6+kJCyqah/L1S6vhGkS9HnC0ySVAuZLoXyxkks3QYosx/ALcKKTKlkT0tmSdn78
0bgEgnCaYtEpInXpN6dCwESqdjsUAACYxTGOBPWisAABs68C6rwOD+zIDLHEZ/sCAAAAAARZWg==

--laD6gYvoCVUaTODo--
