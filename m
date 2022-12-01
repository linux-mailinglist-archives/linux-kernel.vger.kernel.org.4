Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70C63E956
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiLAF1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLAF1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:27:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD74DA1A02
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669872437; x=1701408437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yZbWQ8CAPIHa/7QPwXurBU84lE4YdzdxyCkiIGLKu6w=;
  b=R0hln0NzjlYZ7xWX/FEIuvY/to0hb4oVnMdWo3efOi7O5u7tFXpXn95y
   Or+bgWggBqykuudITTJjMY7dorDT2VPxU0yT25QOkzo7PqNUDuYyUnzq5
   ftd0RVBEZ1MzXOzioY3rAX+4xLg0HBdDfdHR6JNDzZdOaRUio980M51vy
   gY4fKBTT7mC8yqzEeRN2YrRTlQdbRHm9l9/3bIf44r6VsmpL1VYmy6Zbp
   CVX+JUYoSV/ndadRsw//0XTJR953His3aNOW7zKlIdV+laDFYU5ZFOdU0
   D5rw7fGo5Ix82KqJbYooiBXxNw1oR3tNEs81UTLiSWd8bg7VSdsuKoezd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379868950"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379868950"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 21:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818909926"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="818909926"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2022 21:27:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 21:27:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 21:27:16 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 21:27:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLnePEeeLDerLWNog+rnZlhaUqW6KQFhECW6P4UsC+uiCGO+Fi+XOSomD/TZEG8XDdB/GJebC+W3ZbVLYPyVliYuVp8cpbyHy1RmWo0KJGz926h4S/mhqTGrW6VZNltz/1KO60jgp9bk7aNXAty/P5SxrZJzUuxAj0jbfmXzLfx1vVjPtpKgBFIZ16fCoEz5bs3/+v0IG5LPE/B6hJ2umM3vVk1j/SjFaJ4fRxGhs07Mtez9KCt+9lQdF40vL1gMg19aSuvhKUaMogT/QqtjmBjtNs034SSbE/TazDKfIJ3JiTC01ddF0F+iOo1hDPiql4r8Bv23TBPfHlm328L4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie+t0D1+fnHR4RdbauVa/h3VZTofhP8v8D2gbtDoL4M=;
 b=Tv8/DEI7cxSGF1REO8K5zNth+7HuyQVGOUDbKHin5kpfe1dCnIpv3CoQOTWctyv1dVN9sM6frEMERaCJFamx/it2ly7XRg/OYMJ1wlFDuCIFb0fXrXWcVXmt6d6OcEvjnJW+idAWVXvNZJf5NMynhQ/xkARTFldEJ2dt+SdYvqjlagUAL3ly9Eq0AkbVXgyJy2r7RMMiTRj2cXYfLKxIiz3VtHNM9Toz7FrQes6HQgIBBBYqMcb9sIVNyzwxCkxQglUq2pTH4VMU3de+Or25LpngFxhQF6I92pHD5xIFQ6Ln2L3zTGkFehu97O/w/if3G7FsDElC7bT3hGC+N0hu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CO1PR11MB5105.namprd11.prod.outlook.com (2603:10b6:303:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 05:27:13 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 05:27:13 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Liu, Yujie" <yujie.liu@intel.com>,
        John Ogness <john.ogness@linutronix.de>
CC:     "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [linux-next:master] [printk] 8bdbdd7f43:
 BUG:scheduling_while_atomic
Thread-Topic: [linux-next:master] [printk] 8bdbdd7f43:
 BUG:scheduling_while_atomic
Thread-Index: AQHZBN9J/6HdWR5aqkW0F3V3bBqNOK5Yf3eA
Date:   Thu, 1 Dec 2022 05:27:13 +0000
Message-ID: <PH0PR11MB58800C1C971387611633DA7EDA149@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <202211302358.ef0db537-yujie.liu@intel.com>
In-Reply-To: <202211302358.ef0db537-yujie.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CO1PR11MB5105:EE_
x-ms-office365-filtering-correlation-id: ded37d97-a655-4d30-203f-08dad35cb3e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQM6YjmBHONi1am8ikOiHyriSMmFpgqQgssgeZZaqkB/8TBBWQzbx7yPB7QDGhITkQVqnDpT93dVYjFsER6LBpfqlBYeW2vmXzYXuoVJCtXf/vsk1JpcB/2CBn7wdkC0eg2ndkarlVXs8nJCKbjozXqNT9yA5YHMbp/wE4/r/8PRgFSLbKPJZa2HOSGOErukw9K8S09C9wLf8of+EAqu1ivYfgZ+sZyMAc2oL1DCfHrXw597BJoaafLMG3Cvn7LHMOvnlGlRIQL+YDlN63P7Kli9GTpC1dx/FMJakUA7VJQAtNBe7VWbiUZRcyqRW6f8zEKyEAUcpIomcO9GJ2DQGxYjVDJR1kCAYxXmLpdttVqyL5Ybhfkr+L31g2x9aQe3n89CuqhW1weWJn0CvaN+tQO3bG9qPRQrGKdtdeA1vMfxiFAvWc5HI3WEZ/ieEliAoSRA+Qm1/HOPgepL6GPtERsAAE7rOk/v22Nh3JlSJb2QMqNDwfY8Hsw2VChoOsVOWCF3VCMjEN3O8q7q6Re8hc2CeguOnL2osmV3CfAC9fR6ZvEchETdq10t7RzsS4YSxM4iVFlc8zWMPLySl5LKjiQrZlqEqvDGT1wInqTNLM6VjikMalfb1S6zan5RZU4FiQhfpuQfMfjn4QgdC2ULC7r09zOHybLZLyOthPiQ0loiwaV6yl1plfcFDioaL0WrJO4Lqxt/48yP7zcyzrIFvbahwDPTkrDV3iWqVneQvmCFqJlbB0CqQRokJbugXhQJJ2yx97cSQ8duEaZxJcb/bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(83380400001)(122000001)(86362001)(82960400001)(8936002)(38070700005)(66556008)(30864003)(5660300002)(2906002)(4326008)(41300700001)(52536014)(66476007)(55016003)(9686003)(6506007)(26005)(7696005)(186003)(110136005)(316002)(54906003)(66946007)(76116006)(64756008)(66446008)(966005)(8676002)(45080400002)(71200400001)(478600001)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SPG9SRPzbZFvMoG++u2Auqet8Xhorma3YdWvTNXyGsJQM8FNBuDzoxPgbmk4?=
 =?us-ascii?Q?bdy2ldZa/Q4voUsVZT2KidQz3NYbAwwkUeiojkX+I7FzzDL5Y7/dlOppiizN?=
 =?us-ascii?Q?Ivtv5vuuv31VpXC8kI9SPCVB8qNTxAiiR7eP3W51mbjO6ClEF+qq7H4duJSP?=
 =?us-ascii?Q?aoSLF6p7tR7L0jA3uk1v/MHvvP3gvQSBI/hv5Qxnk87/yW/WQoWXdPX/Uuur?=
 =?us-ascii?Q?dAuaAXcLWlYagmS/s2f+09PAO57ooZ3zsoFb0U9ttVssnC6mMlI15Ll3QOvv?=
 =?us-ascii?Q?Sr8e9FIIGdBIrFW2kNYzh7CmlGKnuAH7ftyOluV03ohqFaGCv5+TwGJOZNhh?=
 =?us-ascii?Q?yfVXYjgBkvZTJfCgU5lEv2NehebM0wpZ28q1bcFnN8B/xTcanpRcaaqW2nxL?=
 =?us-ascii?Q?s3FKhilW4F+qbW4QO4Tk4MqVW8ctC/Tf4UtzyIL6MfVKvCtnFtbTbC+KFa5W?=
 =?us-ascii?Q?GQfNBdeFHDB3tYgyyHkZmVEbNqTx60VpUfjgqXmTaRIPH4ftKftBSJoOATOV?=
 =?us-ascii?Q?qZzNWM3eF5Qgkh1gOrB5fcK42Q13fRPEfo7oVuiThKjJNyv8G81jl9a0TGsA?=
 =?us-ascii?Q?9FT3bY+poHxli8w8pAnoC+THNO+jTVxxD1LVCPmtJeRBp47P0lSuNVp+DNJg?=
 =?us-ascii?Q?FvVHy25nFbly0q/lHVVJ5N39dWzp5EtPlnaIq2sCcToiDTDbmKob/2zL+9OO?=
 =?us-ascii?Q?IA/ttPcg3se+LXutFMynsg1CN5TwZPiKx3p/rzKDmMpcKoMWzBXuIjEjZjaG?=
 =?us-ascii?Q?Tt4mn+dhqRvZ/022P9vDssnI3U/Tp09GUUP0nu8IXRegM+Bgkkrl6hda+Ghv?=
 =?us-ascii?Q?x9sv9aCdqxgJxzDedrZFk/1sz+6O7jU4b/+SPe/mp6LbP9nte2Hf+VIEDT6N?=
 =?us-ascii?Q?dG5B6cxdBp0HoTkvAryKYxGCW4bMtvyE61j0R1BApLcdwEawuUcBiyewNOiT?=
 =?us-ascii?Q?KUUxKJcMTXPJbgV6SmwUd4rakOmGLqGT3D6UaQqhGJwDeTE8ZFx8y1NPcFWO?=
 =?us-ascii?Q?6Zf0fNcdFd8AGCIZ/CDn4c1iZc1g5Ty8HDFBKrhxg0aMMzhDerGrGpzzpj6O?=
 =?us-ascii?Q?rHHXPqofMcwY0HxL2t4pXA47V88t/WSlEt2L08Fu0bughpkghVdVzptAavl0?=
 =?us-ascii?Q?Cwi+Fe1ZEVupIMbX6C4ynlWNcivkiTIzLvoAlUVScFPkNwbVCGjwCv4wD2IN?=
 =?us-ascii?Q?CrYdywjhDpnnvnlFV8j6/5Axf9o5K9xxNgWTJif+FmKkSwmeaA/ohAgXDEE9?=
 =?us-ascii?Q?zfKadBp66CQy4vVGgGP0qkZEYbBAunkuWdIyd85lTafbjuLoP4fm7CfBgTBr?=
 =?us-ascii?Q?WDMvYNbeswbn/IJwuQ8UI6CX8ONPLAB+GP9BqnvZhSfdGIgSvLqjTvhIehI+?=
 =?us-ascii?Q?DGJl4dX2zP+MfCoY0AB4mE7HfztSQEy8kUS7Y4zXKqrkQBpTuzQQUgX9G8ge?=
 =?us-ascii?Q?Z1r1lEZt3gq1Sbx4Ddikav8BEsjJiQktnkiVRSHA1oxGkApnkzcy8MRoHYTV?=
 =?us-ascii?Q?KkwnOks2qo7nA3HDBKOUuuLUMFjH3vYRszcYouFLNdmpkq6IH+ipPo15WVfc?=
 =?us-ascii?Q?e2Lpk9pitZVee62VmKK9AsaS46ER6KeoUImG2Epe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded37d97-a655-4d30-203f-08dad35cb3e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 05:27:13.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5beLFnWVo5YHZ+Kylpnqv7TKOf+YpJWZA9JCbnATXyZQLWtjfapFSrGyArP9azwoZ2J1U9B8ZhAjb/Hz5CAAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5105
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greeting,

FYI, we noticed BUG:scheduling_while_atomic due to commit (built with clang=
-14):

commit: 8bdbdd7f43cd74c7faca6add8a62d541503ae21d ("printk: Prepare for SRCU=
 console list protection")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m =
16G

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):


[    8.561823][    T0] BUG: scheduling while atomic: swapper/0/0x00000002
[    8.569154][    T0] no locks held by swapper/0.
[    8.571934][    T0] Modules linked in:
[    8.573001][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00=
015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df80ce
[    8.576740][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[    8.579942][    T0] Call Trace:
[    8.581143][    T0]  <TASK>
[ 8.582054][ T0] dump_stack_lvl (??:?)=20
[ 8.583312][ T0] ? netdev_notice (??:?)=20
[ 8.584753][ T0] ? lockdep_print_held_locks (lockdep.c:?)=20
[ 8.586563][ T0] __schedule_bug (core.c:?)=20
[ 8.588171][ T0] ? trace_sched_switch (core.c:?)=20
[ 8.589753][ T0] ? save_trace (lockdep.c:?)=20
[ 8.591135][ T0] schedule_debug (core.c:?)=20
[ 8.592582][ T0] __schedule (core.c:?)=20
[ 8.593902][ T0] ? __sched_text_start (core.c:?)=20
[ 8.595356][ T0] ? add_chain_block (lockdep.c:?)=20
[ 8.596847][ T0] ? find_held_lock (lockdep.c:?)=20
[ 8.598368][ T0] schedule (??:?)=20
[ 8.599564][ T0] schedule_timeout (??:?)=20
[ 8.600937][ T0] ? console_conditional_schedule (??:?)=20
[ 8.602773][ T0] do_wait_for_common (build_utility.c:?)=20
[ 8.604522][ T0] ? console_conditional_schedule (??:?)=20
[ 8.606462][ T0] ? bit_wait_io_timeout (build_utility.c:?)=20
[ 8.608196][ T0] ? _raw_spin_lock_irq (??:?)=20
[ 8.609935][ T0] ? lockdep_hardirqs_on (??:?)=20
[ 8.611646][ T0] wait_for_completion (??:?)=20
[ 8.613253][ T0] synchronize_srcu (??:?)=20
[ 8.614825][ T0] ? srcu_gp_start_if_needed (??:?)=20
[ 8.616664][ T0] ? rcu_read_lock_any_held (??:?)=20
[ 8.618281][ T0] ? console_trylock_spinning (??:?)=20
[ 8.620181][ T0] unregister_console (??:?)=20
[ 8.621875][ T0] register_console (??:?)=20
[ 8.623401][ T0] ? serial8250_isa_init_ports (8250_core.c:?)=20
[ 8.625281][ T0] ? parse_options (super.c:?)=20
[ 8.626887][ T0] univ8250_console_init (8250_core.c:?)=20
[ 8.628583][ T0] console_init (??:?)=20
[ 8.630025][ T0] start_kernel (??:?)=20
[ 8.631558][ T0] secondary_startup_64_no_verify (??:?)=20
[    8.633502][    T0]  </TASK>
[    8.634624][    T0] ------------[ cut here ]------------
[    8.636289][    T0] releasing a pinned lock
[ 8.638693][ T0] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5352 lo=
ck_release (??:?)=20
[    8.641591][    T0] Modules linked in:
[    8.642864][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W     =
     6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df8=
0ce
[    8.646469][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 8.649578][ T0] RIP: 0010:lock_release (??:?)=20
[ 8.651243][ T0] Code: 00 00 e9 0f fe ff ff 48 83 05 06 f6 ff 06 01 e8 91 4=
e 2d 03 e9 67 fe ff ff 48 c7 c7 20 8c cf 84 e8 90 3f ec ff 48 8b 54 24 08 <=
0f> 0b 48 83 05 a9 f6 ff 06 01 e9 66 fc ff ff e8 67 c9 99 01 85 c0
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	00 00                	add    %al,(%rax)
   2:	e9 0f fe ff ff       	jmpq   0xfffffffffffffe16
   7:	48 83 05 06 f6 ff 06 	addq   $0x1,0x6fff606(%rip)        # 0x6fff615
   e:	01=20
   f:	e8 91 4e 2d 03       	callq  0x32d4ea5
  14:	e9 67 fe ff ff       	jmpq   0xfffffffffffffe80
  19:	48 c7 c7 20 8c cf 84 	mov    $0xffffffff84cf8c20,%rdi
  20:	e8 90 3f ec ff       	callq  0xffffffffffec3fb5
  25:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6dd
  33:	01=20
  34:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc9f
  39:	e8 67 c9 99 01       	callq  0x199c9a5
  3e:	85 c0                	test   %eax,%eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 0b                	ud2   =20
   2:	48 83 05 a9 f6 ff 06 	addq   $0x1,0x6fff6a9(%rip)        # 0x6fff6b3
   9:	01=20
   a:	e9 66 fc ff ff       	jmpq   0xfffffffffffffc75
   f:	e8 67 c9 99 01       	callq  0x199c97b
  14:	85 c0                	test   %eax,%eax
[    8.656638][    T0] RSP: 0000:ffffffff862077c0 EFLAGS: 00010086
[    8.658249][    T0] RAX: 0000000000000017 RBX: ffffffff86244244 RCX: fff=
fffff8631a420
[    8.660383][    T0] RDX: ffffffff86244218 RSI: 0000000000000008 RDI: 000=
0000000000001
[    8.662798][    T0] RBP: ffffffff862078e0 R08: dffffc0000000000 R09: 000=
00000035545d9
[    8.665205][    T0] R10: dffff7fff0c40e7a R11: 0000000000000001 R12: fff=
fffff862fcf58
[    8.667420][    T0] R13: 1ffffffff0c40f06 R14: ffffffff86244220 R15: dff=
ffc0000000000
[    8.669824][    T0] FS:  0000000000000000(0000) GS:ffffffff862ab000(0000=
) knlGS:0000000000000000
[    8.672552][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.674557][    T0] CR2: ffff88843ffff000 CR3: 0000000006235000 CR4: 000=
00000000406b0
[    8.677082][    T0] Call Trace:
[    8.678220][    T0]  <TASK>
[ 8.679230][ T0] ? __lock_acquire (??:?)=20
[ 8.680709][ T0] ? kvm_sched_clock_read (kvmclock.c:?)=20
[ 8.682309][ T0] ? sched_clock_cpu (??:?)=20
[ 8.683854][ T0] ? kvm_sched_clock_read (kvmclock.c:?)=20
[ 8.685268][ T0] _raw_spin_unlock (??:?)=20
[ 8.686730][ T0] dequeue_task_idle (build_policy.c:?)=20
[ 8.688259][ T0] ? set_next_task_idle (build_policy.c:?)=20
[ 8.689822][ T0] ? update_rq_clock (??:?)=20
[ 8.691387][ T0] __schedule (core.c:?)=20
[ 8.692782][ T0] ? __sched_text_start (core.c:?)=20
[ 8.694287][ T0] ? add_chain_block (lockdep.c:?)=20
[ 8.695869][ T0] ? find_held_lock (lockdep.c:?)=20
[ 8.697314][ T0] schedule (??:?)=20
[ 8.698529][ T0] schedule_timeout (??:?)=20
[ 8.701929][ T0] ? console_conditional_schedule (??:?)=20
[ 8.703826][ T0] do_wait_for_common (build_utility.c:?)=20
[ 8.705395][ T0] ? console_conditional_schedule (??:?)=20
[ 8.707189][ T0] ? bit_wait_io_timeout (build_utility.c:?)=20
[ 8.708779][ T0] ? _raw_spin_lock_irq (??:?)=20
[ 8.710371][ T0] ? lockdep_hardirqs_on (??:?)=20
[ 8.711982][ T0] wait_for_completion (??:?)=20
[ 8.713487][ T0] synchronize_srcu (??:?)=20
[ 8.715020][ T0] ? srcu_gp_start_if_needed (??:?)=20
[ 8.716772][ T0] ? rcu_read_lock_any_held (??:?)=20
[ 8.718477][ T0] ? console_trylock_spinning (??:?)=20
[ 8.720179][ T0] unregister_console (??:?)=20
[ 8.721644][ T0] register_console (??:?)=20
[ 8.728846][ T0] ? serial8250_isa_init_ports (8250_core.c:?)=20
[ 8.730692][ T0] ? parse_options (super.c:?)=20
[ 8.732180][ T0] univ8250_console_init (8250_core.c:?)=20
[ 8.733762][ T0] console_init (??:?)=20
[ 8.735096][ T0] start_kernel (??:?)=20
[ 8.736425][ T0] secondary_startup_64_no_verify (??:?)=20
[    8.738088][    T0]  </TASK>
[    8.739057][    T0] irq event stamp: 494
[ 8.740376][ T0] hardirqs last enabled at (493): dump_stack_lvl (??:?)=20
[ 8.743081][ T0] hardirqs last disabled at (494): __schedule (core.c:?)=20
[ 8.745797][ T0] softirqs last enabled at (0): 0x0=20
[ 8.747882][ T0] softirqs last disabled at (0): 0x0=20
[    8.749889][    T0] ---[ end trace 0000000000000000 ]---
[    8.751520][    T0] bad: scheduling from the idle thread!
[    8.753351][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G        W     =
     6.1.0-rc1-00015-g8bdbdd7f43cd #1 9e431b4e696756e99f94acf7e74ac6e512df8=
0ce
[    8.757566][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[    8.760783][    T0] Call Trace:
[    8.761970][    T0]  <TASK>
[ 8.763067][ T0] dump_stack_lvl (??:?)=20
[ 8.764611][ T0] ? netdev_notice (??:?)=20
[ 8.766213][ T0] ? lockdep_hardirqs_on_prepare (??:?)=20
[ 8.768214][ T0] ? print_irqtrace_events (??:?)=20
[ 8.769911][ T0] ? kvm_sched_clock_read (kvmclock.c:?)=20
[ 8.771550][ T0] dequeue_task_idle (build_policy.c:?)=20
[ 8.773087][ T0] ? set_next_task_idle (build_policy.c:?)=20
[ 8.774647][ T0] ? update_rq_clock (??:?)=20
[ 8.776280][ T0] __schedule (core.c:?)=20
[ 8.777729][ T0] ? __sched_text_start (core.c:?)=20
[ 8.779238][ T0] ? add_chain_block (lockdep.c:?)=20
[ 8.780922][ T0] ? find_held_lock (lockdep.c:?)=20
[ 8.782560][ T0] schedule (??:?)=20
[ 8.783988][ T0] schedule_timeout (??:?)=20
[ 8.785515][ T0] ? console_conditional_schedule (??:?)=20
[ 8.787500][ T0] do_wait_for_common (build_utility.c:?)=20
[ 8.789162][ T0] ? console_conditional_schedule (??:?)=20
[ 8.790997][ T0] ? bit_wait_io_timeout (build_utility.c:?)=20
[ 8.792567][ T0] ? _raw_spin_lock_irq (??:?)=20
[ 8.794292][ T0] ? lockdep_hardirqs_on (??:?)=20
[ 8.796008][ T0] wait_for_completion (??:?)=20
[ 8.797520][ T0] synchronize_srcu (??:?)=20
[ 8.799001][ T0] ? srcu_gp_start_if_needed (??:?)=20
[ 8.800696][ T0] ? rcu_read_lock_any_held (??:?)=20
[ 8.802508][ T0] ? console_trylock_spinning (??:?)=20
[ 8.804316][ T0] unregister_console (??:?)=20
[ 8.805810][ T0] register_console (??:?)=20
[ 8.807364][ T0] ? serial8250_isa_init_ports (8250_core.c:?)=20
[ 8.811167][ T0] ? parse_options (super.c:?)=20
[ 8.812693][ T0] univ8250_console_init (8250_core.c:?)=20
[ 8.814269][ T0] console_init (??:?)=20
[ 8.815765][ T0] start_kernel (??:?)=20
[ 8.817296][ T0] secondary_startup_64_no_verify (??:?)=20
[    8.819246][    T0]  </TASK>



Through the config file, it can be found that the following options are ena=
bled

CONFIG_TINY_RCU=3Dy
CONFIG_RCU_EXPERT=3Dy
CONFIG_SRCU=3Dy
CONFIG_TINY_SRCU=3Dy

This problem should have been fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3D0bf43fcbf8ebbf84a2b1b8770eaefcdb4a99afd6

commit dbc6ca150842650d513705f26e3e6b7a4e182ce9
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Nov 9 15:36:38 2022 +0800

    srcu: Make Tiny synchronize_srcu() check for readers

    This commit adds lockdep checks for illegal use of synchronize_srcu()
    within same-type SRCU read-side critical sections and within normal
    RCU read-side critical sections.  It also makes synchronize_srcu()
    be a no-op during early boot.

    These changes bring Tiny synchronize_srcu() into line with both Tree
    synchronize_srcu() and Tiny synchronize_rcu().

    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>


Thanks
Zqiang







If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Link: https://lore.kernel.org/oe-lkp/202211302358.ef0db537-yujie.liu@inte=
l.com


To reproduce:

        # build kernel
	cd linux
	cp config-6.1.0-rc1-00015-g8bdbdd7f43cd .config
	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 olddefconfig prepare mo=
dules_prepare bzImage modules
	make HOSTCC=3Dclang-14 CC=3Dclang-14 ARCH=3Dx86_64 INSTALL_MOD_PATH=3D<mod=
-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is=
 attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.


--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
