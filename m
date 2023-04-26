Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2D6EF0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjDZJR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbjDZJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:17:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CB344A2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682500644; x=1714036644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cBpLvV6wfK3H69cr/6RYp0jaeWVd2/bgifPSGte70kw=;
  b=cAbDQVMx57Pd/DSrSjmj6kqz0S0xjixKvGZRCa7XkANvW+b3Wdjd7VT4
   DpGtRVJbhvTyQsIzmvTJhjs6Kiryy5wrfNtE3xVjWoT44qd6tWyRwgFIR
   Sb3O662FlYHS3//tueagYc3QQzOp0t5x+grXaeBi7LNYM96kGSr+v3YCm
   bQtinbTwt4t2PkDVWn3aCnBwFTNtCr1/saNLZXRrkBCIrDv+ECMyWgBUP
   +y2A1NVR+Hfy3gcZf0kcpFam6IcwqZ6TpjvqT5XDtdPM1kkWQ7FaqGkEn
   SMii9YuzTD8nysYRiWcrCf2ko6VCd/vRlGDI94DDgnLFGlVce5YXlI2zr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="345802874"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="345802874"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 02:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="763248649"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="763248649"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 26 Apr 2023 02:08:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 02:08:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 02:08:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 02:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViTEHaI4NL78baVAp2rNbb0cSgdRDczpJxQhkdAPSs1fBQ48IywTxBBBpd4jDSMo/UnJHH+yUg7BDEgCvt+u3u7bUeMg4OVlHcA4TnjLcL51PiOLUNnz6dEI3pNR4ILtlY3SSqpBa7WSqM6PlP6/YB+RugTRB+ywwAFX2VvO0BnljlzYj4FOK/Yp4wjXZApfycBWEBDVPBOqnGPWhJ/pvnRcc6xTNVRv1dQ5rcldfgckRJf9Qg0qWXjIsRs4WFQRQSf+m7U2BSzOZTTFyjkThVjTIf5hJhizG1wP1WBFmbeIfDznMzXvTy3EILdahyn25iCvtICuAhKWTAlDqOrCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEY5bsd+r+FRvxzRBYIdzMqbfrMSFhVmvRrL1aoy+9c=;
 b=an/6K4mx5KXkbru2Ds+PbccNmZ1304DajVFmFuHAv/D6yTwHeaVtDtLBWEoSpKQp2PIjF6eLYfhMGcKWm0aOX5GpQqMv7XdJDUsno5f4H6SH3zuD2N6vk4G1zTw5JPZZJkdyOmb98UuXbz/zFFmXnK4qgyhTsEn7ZE2rmWPCGFvkpehq4yxRM1qnaa4ILbK60skKEzyifIS1agqijA4bDGneuj1muLzhXscGl0pRPjppC9zs3p+6Rth9WPJgBTYIJ+mcLKz7iKt4e3g1hX4e6WR4F25X5/l2Jbr3rGWQ943Nl9LLZx+zjtaKA2fXNgeuUlgXPvXPrxdoLYBnUv5gGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 09:08:50 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%7]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 09:08:50 +0000
Date:   Wed, 26 Apr 2023 17:10:31 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <krzysztof.kozlowski@linaro.org>, <jarkko@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>,
        <heng.su@intel.com>, <peterhuewe@gmx.de>, <dhowells@redhat.com>,
        <lkp@intel.com>
Subject: [Syzkaller & bisect] There is WARNING in tpm_chip_unregister in
 upstream patch "tpm: st33zp24: Mark ACPI and OF related data as maybe
 unused"
Message-ID: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c755ace-19ad-4de3-4daf-08db4635d9c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb9k6uQIH0LCP1T57JYCGxxxrXkWFxp61LX24qbsUQf8t72ACAS51qECYDUN4Vvv/4fXo+f8st0p0a/WvYmdLxynUYWiREkHQvpA2z+NR+IB+XwuT2l69/IdPVam7KodcwLLVggB9VfTGrpjUc5ch+NSZIxk5luxuXgZ5zDxeDHy4Zi4b/sGEGBwbsT8nboHhK0t9A3BzLbp0zNQYofyhbm6BaL9pk3CPoPTW1GXt+xuVoDib07CVwzAOx1XgO8mihflDnzAhP9zj6k95BnOnksi9gI+B1048QXr17WBuHqIIxFkZ307E3bmR3WiZgkLf4R2qgiXCU0LCj1N4IC5U0uV5SlEWOkQCMmrt1s53oAVwF07hAPKVgz7WOEgBTqpp015u46w2u+ROMKCPR3r2IlCyMuYM6J+MWEkxAjP5Bu0IXLeIp+JR7LUwNMpHk+sdyzj4OHlwtMK7ofTUtdJ5uO0loo4s7uJBA18b1Sen2lW42GUd2lOqgPkjyN7pwHIUgzl+J6abCQtC+gzPu+eNQ8ASDK2x3MqVBm9W3pSvq1Q0KmPHF3JH/I8ynKQ3yZP2fi57MvNuJjdZe2veFMvcJoyAo0hFuSm5Zr7yiXnmESeWQWke8p8Lrr9nZsE/XWtFdvgKrAMTrCLvaP67GYJVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(82960400001)(30864003)(44832011)(316002)(8676002)(8936002)(5660300002)(38100700002)(66946007)(86362001)(41300700001)(2906002)(66476007)(66556008)(966005)(83380400001)(4326008)(6512007)(26005)(6506007)(107886003)(186003)(6666004)(45080400002)(6486002)(478600001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NtRc1oGziVSSyHxx95BYM6EYIBsUtA0CpI75cA5Y3fNWLZRy8y17VrShddnF?=
 =?us-ascii?Q?l0JIP0kDK/UExPjAOj8Utl5sfdkxrh0owuVBE129y8l4IQjNMUEUC01d7qIA?=
 =?us-ascii?Q?s90c0cyQsCkI1f777RwFms0KTQNszyzkuqlYf42KzpjMG1/mTjeBJirh4Ifn?=
 =?us-ascii?Q?ApvyqKxC0PHwjUtspaDE9374qfnHPMqJSCBj61dMjrBAkqNdYL+bU7O7SSFL?=
 =?us-ascii?Q?4GrJNScAzP5e2piRTO6ubXozIt090f64x51L9fRwrAO91m2uVPMGSXf3FCRo?=
 =?us-ascii?Q?zfDQIhaWGAkapCVwHDiOFYTK4OngqhZIWDAXgMJyPFQucWpHFjrPOJF8xsZa?=
 =?us-ascii?Q?5afLKAUFsn0SGkKXpKjrWiPVG8aX5PXxzCp3FH06TbZSOPo35SN7LPxRCiKn?=
 =?us-ascii?Q?5vBxgMSI2EaxOooyj/FjWRSFOOf4BGZStDiXFcptv329IWFn9gf8VpusREVo?=
 =?us-ascii?Q?+H6uIIIWXp2qdgEPZ4zHmcAe3gXsrulaeB8VZBMQK3VSBMnQtK3e8RkbWp1o?=
 =?us-ascii?Q?XhV2qJ1zA8ObHQAWa9TZLSHQmupi2V3ULd+pTiJWZEPI4i13OmTBULBP0B5s?=
 =?us-ascii?Q?+X7NWGrH+WmazdSAbMNEJIdthdoLOc2ORS5AHqlt431+IU88QlvHOq8lMhdP?=
 =?us-ascii?Q?7wllnRqPdX7SRd5g7zC+1I3kLHS7lUSyZQBjFq88WEc1PzDXL4nt6Vom3yUq?=
 =?us-ascii?Q?8/vLSNguM7JGkYxrDMWfl01Ir03YFNfvXRDhXZtwJXOXC6SHgjPDXhSEtavM?=
 =?us-ascii?Q?OD46ZZG4mjgD2D5u8Iuj1P00Vl48dqhB1u9KFhoaej0+TP5+JQBvMgH1uhSP?=
 =?us-ascii?Q?9S423mRLTdmRYuP0e8Oz++79eLL58Yq3oTlViZyPeCHt7N0XopuzCc/sJ+WK?=
 =?us-ascii?Q?qgBB6gsSA2lZU8MGty4lwhidkx0S6OUnHI5qrH7x+D7T5xzJwSWziZaRFUxb?=
 =?us-ascii?Q?HacYvMMwnTzKOc5qPCVgF+N+WW5bgkz+Segs4ksNngR+578iiTDPj+1jjlez?=
 =?us-ascii?Q?YzeBEQ1gTn9cDR7LeN8K4EhT3R7/jNI8vF5F/DjsBvQ7c54Z4v9FRzm+fBVI?=
 =?us-ascii?Q?CMD1mWeuSYndSXjvF5yQLAMQPuHt1Z94KCcV9+6fjkexspZzkyg/IgienX9a?=
 =?us-ascii?Q?A4A9ypnz0PvUg4Z4PZDDbkTkD6Amb3n9JAmwEXw0oaUzGlMZY2wGeCoajJuS?=
 =?us-ascii?Q?buGAF2ja6VllhusVNEdN1CklBKzRu4Cniqynxb82FZd9HbvPw7RpzHlcS5KJ?=
 =?us-ascii?Q?pd0mcebKENfNfQxNOIV2UgnShizBojfugwNu9Jbi7h6LMPz6V7SDswdM1QR+?=
 =?us-ascii?Q?uzk6Pp7PmLV8EgRgv80R5GQdXafAB58+JyDAbXPpjZwCbLk3a6fuqU/zFL4w?=
 =?us-ascii?Q?FnlfPcl9H56HMlda5xBzBW6sjhrp/jt0fsmFjHLAOaVyIu0xmXx4U0UAAbU4?=
 =?us-ascii?Q?x3z29K77nYGOGgQ3ytaG27RHZqw1/Qr4YIvcUheCmZovTi6Gxrfbnsxfilkj?=
 =?us-ascii?Q?2xDu8ro4uAXVW1pRMk6uANR8m3uj7xPoSdekzxjJ7tAJ22/7ZttP5DnV1JYg?=
 =?us-ascii?Q?1t7dtUbvHdydfw0c5qdgNRq2cbm5WM0yUPs/guIk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c755ace-19ad-4de3-4daf-08db4635d9c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 09:08:50.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDkiHdFVKht45vj2OwF2JdLtkSeWKG9UtBoIqYox8Fpz/gu+rRR663DFaw0tGroWCvD2empWAvA8jvy/p4bv4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
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

Hi Jarkko and Krzysztof Kozlowski,

Greeting!

Platform: x86 platforms

There is WARNING in tpm_chip_unregister in upstream patch "tpm: st33zp24: Mark
ACPI and OF related data as maybe unused":
https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org/
-> https://lore.kernel.org/lkml/20230319141354.22907-1-krzysztof.kozlowski@linaro.org/

We tested Intel internal kernel and found that, the above patch caused below
WARNING and then kernel BUG dmesg info. After reverted above commit on top
of Intel internal kernel, this issue was gone.
I checked that internal commit:"c3985d8b9c22 tpm: st33zp24: Mark ACPI and OF
related data as maybe unused" was same as above link patch.
This issue could be reproduced in 155s in VM.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230426_132902_tpm_chip_unregister_warning
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.c
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/repro.report
Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230426_132902_tpm_chip_unregister_warning/bisect_info.log

"
[   24.638052] memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=329 'systemd'
[   28.731375] cgroup: Unknown subsys name 'net'
[   28.741433] cgroup: Unknown subsys name 'rlimit'
[   35.900833] tpm tpm0: Operation Canceled
[   35.901377] ------------[ cut here ]------------
[   35.901648] refcount_t: addition on 0; use-after-free.
[   35.901986] WARNING: CPU: 0 PID: 4095 at lib/refcount.c:25 refcount_warn_saturate+0xe6/0x1c0
[   35.902444] Modules linked in:
[   35.902627] CPU: 0 PID: 4095 Comm: repro Not tainted 6.3.0-2023-04-24-intel-next-591f7c2026cb+ #1
[   35.903093] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   35.903679] RIP: 0010:refcount_warn_saturate+0xe6/0x1c0
[   35.903968] Code: 1d 99 79 26 02 31 ff 89 de e8 86 b1 55 ff 84 db 75 97 e8 1d b0 55 ff 48 c7 c7 78 a8 9e 83 c6 05 79 79 26 02 01 e8 3a a9 39 ff <0f> 0b e9 78 ff ff ff e8 fe af 55 ff 0f b6 1d 63 79 26 02 31 ff 89
[   35.904941] RSP: 0000:ffffc900015efd88 EFLAGS: 00010286
[   35.905218] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8112384b
[   35.905600] RDX: 0000000000000000 RSI: ffff8880147f8000 RDI: 0000000000000002
[   35.905981] RBP: ffffc900015efd98 R08: 0000000000000000 R09: 0000000000000001
[   35.906358] R10: 0000000000000001 R11: ffffffff83d638d8 R12: ffff8880146e0028
[   35.906736] R13: ffff8880146e0028 R14: ffff8880180cbae0 R15: ffff888007095fb8
[   35.907104] FS:  00007fac3687f800(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   35.907521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.907825] CR2: 00007f843e8b4720 CR3: 0000000007538005 CR4: 0000000000770ef0
[   35.908197] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.908564] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   35.908949] PKRU: 55555554
[   35.909097] Call Trace:
[   35.909233]  <TASK>
[   35.909357]  kthread_stop+0x349/0x360
[   35.909577]  hwrng_unregister+0x182/0x210
[   35.909816]  tpm_chip_unregister+0x1cc/0x1f0
[   35.910060]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   35.910342]  vtpm_proxy_fops_release+0x8f/0xa0
[   35.910589]  __fput+0x11f/0x450
[   35.910628] tpm tpm1: Operation Canceled
[   35.910780]  ____fput+0x1e/0x30
[   35.911178]  task_work_run+0xb6/0x120
[   35.911393]  exit_to_user_mode_prepare+0x200/0x210
[   35.911660]  syscall_exit_to_user_mode+0x2d/0x60
[   35.911926]  do_syscall_64+0x4a/0x90
[   35.912136]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   35.912414] RIP: 0033:0x7fac36a8fe37
[   35.912613] Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 66 90 53 89 fb 48 83 ec 10 e8 d4 fb ff ff 89 c2 89 df b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 16 fc ff ff 8b 44 24
[   35.913548] RSP: 002b:00007ffc4fdbe320 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
[   35.913878] ------------[ cut here ]------------
[   35.913944] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007fac36a8fe37
[   35.914212] refcount_t: saturated; leaking memory.
[   35.914564] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000004
[   35.914869] WARNING: CPU: 1 PID: 4103 at lib/refcount.c:22 refcount_warn_saturate+0xb1/0x1c0
[   35.915203] RBP: 00007ffc4fdbe350 R08: 0000000000000000 R09: 0000000000000032
[   35.915630] Modules linked in:
[   35.915993] R10: 00007ffc4fdbe320 R11: 0000000000000293 R12: 0000000000402400
[   35.916164] CPU: 1 PID: 4103 Comm: repro Not tainted 6.3.0-2023-04-24-intel-next-591f7c2026cb+ #1
[   35.916525] R13: 00007ffc4fdbe4e0 R14: 0000000000000000 R15: 0000000000000000
[   35.917000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   35.917363]  </TASK>
[   35.917934] RIP: 0010:refcount_warn_saturate+0xb1/0x1c0
[   35.918061] irq event stamp: 1787
[   35.918332] Code: 1d cf 79 26 02 31 ff 89 de e8 bb b1 55 ff 84 db 75 cc e8 52 b0 55 ff 48 c7 c7 50 a8 9e 83 c6 05 af 79 26 02 01 e8 6f a9 39 ff <0f> 0b eb b0 e8 36 b0 55 ff 0f b6 1d 99 79 26 02 31 ff 89 de e8 86
[   35.918509] hardirqs last  enabled at (1795): [<ffffffff811f2d2e>] console_flush_all+0x3ee/0x790
[   35.919437] RSP: 0018:ffffc900015ffd88 EFLAGS: 00010286
[   35.919874] hardirqs last disabled at (1802): [<ffffffff811f2efa>] console_flush_all+0x5ba/0x790
[   35.920161] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8112384b
[   35.920605] softirqs last  enabled at (1484): [<ffffffff82fda6a9>] __do_softirq+0x2d9/0x3c3
[   35.920974] RDX: 0000000000000000 RSI: ffff888018168000 RDI: 0000000000000002
[   35.921397] softirqs last disabled at (1471): [<ffffffff81132b14>] irq_exit_rcu+0xc4/0x100
[   35.921765] RBP: ffffc900015ffd98 R08: 0000000000000001 R09: 0000000000000001
[   35.922196] ---[ end trace 0000000000000000 ]---
[   35.922562] R10: 0000000000000001 R11: ffffffff83c830d8 R12: ffff8880146e0028
[   35.922809] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   35.923171] R13: ffff8880146e0028 R14: ffff8880180c9ae0 R15: ffff888007095fb8
[   35.923525] #PF: supervisor write access in kernel mode
[   35.923888] FS:  00007fac3687f800(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[   35.924169] #PF: error_code(0x0002) - not-present page
[   35.924594] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.924859] PGD 12df2067 P4D 12df2067 PUD c390067 PMD 0 
[   35.925167] CR2: 00007fe31371f000 CR3: 00000000144c4003 CR4: 0000000000770ee0
[   35.925441] 
[   35.925443] Oops: 0002 [#1] PREEMPT SMP NOPTI
[   35.925817] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.925904] CPU: 0 PID: 4095 Comm: repro Tainted: G        W           6.3.0-2023-04-24-intel-next-591f7c2026cb+ #1
[   35.926134] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   35.926501] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   35.927027] PKRU: 55555554
[   35.927388] RIP: 0010:kthread_stop+0xd9/0x360
[   35.927963] Call Trace:
[   35.927966]  <TASK>
[   35.928108] Code: 44 8b 63 2c 31 ff 41 81 e4 00 00 20 00 44 89 e6 e8 1c 08 17 00 45 85 e4 0f 84 81 02 00 00 e8 2e 06 17 00 4c 8b a3 40 0a 00 00 <f0> 41 80 0c 24 02 48 89 df e8 f9 f1 ff ff f0 80 4b 02 02 48 89 df
[   35.928339]  kthread_stop+0x31b/0x360
[   35.928470] RSP: 0000:ffffc900015efda8 EFLAGS: 00010246
[   35.928592]  hwrng_unregister+0x182/0x210
[   35.929518] 
[   35.929520] RAX: 0000000000000000 RBX: ffff8880146e0000 RCX: ffffffff81173814
[   35.929725]  tpm_chip_unregister+0x1cc/0x1f0
[   35.929995] RDX: 0000000000000000 RSI: ffff8880147f8000 RDI: 0000000000000002
[   35.930216]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   35.930303] RBP: ffffc900015efdc8 R08: 0000000000000000 R09: 0000000000000001
[   35.930669]  vtpm_proxy_fops_release+0x8f/0xa0
[   35.930890] R10: 0000000000000001 R11: ffffffff83d638d8 R12: 0000000000000000
[   35.931252]  __fput+0x11f/0x450
[   35.931512] R13: ffff8880146e0028 R14: ffff8880180cbae0 R15: ffff888007095fb8
[   35.931874]  ____fput+0x1e/0x30
[   35.932101] FS:  00007fac3687f800(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   35.932460]  task_work_run+0xb6/0x120
[   35.932627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   35.932999]  exit_to_user_mode_prepare+0x200/0x210
[   35.933160] CR2: 0000000000000000 CR3: 0000000007538005 CR4: 0000000000770ef0
[   35.933570]  syscall_exit_to_user_mode+0x2d/0x60
[   35.933761] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   35.934056]  do_syscall_64+0x4a/0x90
[   35.934301] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   35.934664]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   35.934900] PKRU: 55555554
[   35.935276] RIP: 0033:0x7fac36a8fe37
[   35.935465] Call Trace:
[   35.935467]  <TASK>
[   35.935822] Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 66 90 53 89 fb 48 83 ec 10 e8 d4 fb ff ff 89 c2 89 df b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 16 fc ff ff 8b 44 24
[   35.936080]  hwrng_unregister+0x182/0x210
[   35.936226] RSP: 002b:00007ffc4fdbe320 EFLAGS: 00000293
[   35.936414]  tpm_chip_unregister+0x1cc/0x1f0
[   35.936546]  ORIG_RAX: 0000000000000003
[   35.936663]  ? __pfx_vtpm_proxy_fops_release+0x10/0x10
[   35.937599] RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007fac36a8fe37
[   35.937803]  vtpm_proxy_fops_release+0x8f/0xa0
[   35.938068] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000004
[   35.938289]  __fput+0x11f/0x450
[   35.938488] RBP: 00007ffc4fdbe350 R08: 0000000000000000 R09: 0000000000000032
[   35.938751]  ____fput+0x1e/0x30
[   35.939109] R10: 00007ffc4fdbe320 R11: 0000000000000293 R12: 0000000000402400
[   35.939341]  task_work_run+0xb6/0x120
[   35.939698] R13: 00007ffc4fdbe4e0 R14: 0000000000000000 R15: 0000000000000000
[   35.939864]  exit_to_user_mode_prepare+0x200/0x210
[   35.940225]  </TASK>
[   35.940387]  syscall_exit_to_user_mode+0x2d/0x60
[   35.940747] irq event stamp: 1668
[   35.940938]  do_syscall_64+0x4a/0x90
[   35.941301] hardirqs last  enabled at (1667): [<ffffffff811f5718>] vprintk_emit+0x3f8/0x590
[   35.941547]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   35.941666] hardirqs last disabled at (1668): [<ffffffff811f2efa>] console_flush_all+0x5ba/0x790
[   35.941899] RIP: 0033:0x7fac36a8fe37
[   35.942075] softirqs last  enabled at (1596): [<ffffffff82fda6a9>] __do_softirq+0x2d9/0x3c3
[   35.942265] Code: 12 b8 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 3b c3 66 90 53 89 fb 48 83 ec 10 e8 d4 fb ff ff 89 c2 89 df b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 89 d7 89 44 24 0c e8 16 fc ff ff 8b 44 24
[   35.942704] softirqs last disabled at (1585): [<ffffffff81132b14>] irq_exit_rcu+0xc4/0x100
[   35.942975] RSP: 002b:00007ffc4fdbe320 EFLAGS: 00000293
[   35.943438] ---[ end trace 0000000000000000 ]---
"

I hope above info is helpful to solve this issue.

---

If you don't need the following environment to reproduce the problem or if you
already have one, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
   // You could change the bzImage_xxx as you want
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
make
make install

Thanks!
BR.
