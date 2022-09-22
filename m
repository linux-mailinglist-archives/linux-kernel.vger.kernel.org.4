Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91CF5E5C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiIVHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIVHPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:15:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AC1CBAC1;
        Thu, 22 Sep 2022 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663830939; x=1695366939;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=McSdwdF7Al9F6GF26bwJvoOhZFEGzKyF1yWS7lFoq+g=;
  b=ZZB7g4d/v+dQn63K9xCmGenngs0RHrr1NcU3UMK8EjVhrsfNmImqKGPN
   e91/G2u3gXQvpSS7pzTfpcijRmKNrbNP21OZgZlqVLV+dqCXrU6o+LAgA
   QytWkF4w/AhCduukqfhc0dc6beqBtY+SRZF30vfLycekrq+ItSm7zvY1D
   SJPFwd1bnwgmfvgUiydwQ1PMDqZNaEK505KN80lK7XfGZFXsJ42Uloogo
   b5/xU20dwqCmVra/DL6HOeVcAdYP0Cpws1PXlalY892RM840XqWNq4kMU
   khpwtazEqLXJXl5q87XnmUicScflQo4M0sNG0XO8ZrYHfKnyk/JqB/1ym
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364200187"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="txt'?scan'208";a="364200187"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 00:15:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="txt'?scan'208";a="619685226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 00:15:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 00:15:38 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 00:15:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 00:15:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 00:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lArKE3uWzIkFXbqi4zVD9eeBQrP028jX6Yhus2DxVSsvjZGkXTtvxaWAelhVj4eL7cuvBdLRqPeRgLlK1GmjJP9QeHudgjfHBDJqtmZhI8gad1AaX9NrbqlaHnopPfDPuwzBw4+WTXHcG4silVSLlagIgsmEKHrHM2aSky51OnODfOLakrUho09dGtzV0RdhpkmysqEFKRJooQ2DIdCHeycGR1gC6M4T6utlrc0RPDux8WuVOziKdLGLGbkVXYg1AiiQ40pvWATiC8aWO0wFDXb2cckIwCtRt4sWFZoctOHLNooW2LMKlyOP4Y1eXJEUfuH3VSAsoBBth3waoUWt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ZlkETaCO/oQxAyIyWdC8QCHGKG9bDRBJlbauxb8WM=;
 b=WIUgAq6W8zNvhzK5/IbIOYVaHI0w50gIJBt15A6codqnj0E8/wMdqXUozBQ13dqsIsFUjU9Q0o+fhDVYXHCqz3/s2jAZeb/EKvsEaY3WK3AjMoF5YYl5WkGRc+RFgAachKxSsBFoIbGqtqWlhMk2bPZhWDm7YQHsWTHVMBnxOiQv4zVdr3/u24Ly3TIA0UBsHtfLgDJHhFe8jt8i6ib50Y5c7yoUnvZnSKU5x1X/utZEAlPua+/qaXCsNwmeaA0ok+FTorR8mpO1apItbs3Mb2Z7Y9sjx/whzj4TSloTPh8ykMv6/ybGE/+mfXjaSMKm/Y26JKc6Vu/gynvHmf8BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 07:15:28 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fd09:f15d:3b12:3ae3]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::fd09:f15d:3b12:3ae3%6]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 07:15:28 +0000
Date:   Thu, 22 Sep 2022 15:11:09 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <heng.su@intel.com>, <pengfei.xu@intel.com>
Subject: [BUG report] There was BUG when executed gpio kselftest
Message-ID: <YywKjcqs0U39WSWD@xpf.sh.intel.com>
Content-Type: multipart/mixed; boundary="+jwnAk+X9uKarQqM"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ec0526-bd1f-42d1-83dc-08da9c6a39fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h4MayixfYwSzW30kZUz6mmVTevpVX5usDv/ulU9TCWHSr2Nb/+wQJslt99lvO3z9tbslUrQqT+N6vg8LjgKm8yJUrRtahLMLb3g6n0DgXF+kZFKsD1rZlM69McqNItGj4y2stESxo08CIt62fr2SzwciRwh6az/LSOVG018A+sFHToGlXdghgaIygbutcmqu6q9tJ06jn1v0xkQ6P3qtdhUSVDXwzbOJWFC7Peg6wrEetk4ZjOkWsh+Hv+Ic2197gtEhppmLrLEGdSysshg84MsJJ3gOBC8ZoO2r/0dKEALZfFbkLnKO8M8JAzoKF5WKKyhOlncedQ/yoeYVOKPbo7Nqfpg3Ku14YJ7YZcXh/2hM4AKd4JFpvRxWB7v+Gnz6FaZUXToVcMAjT1VO41aP+Vr0B7PsSRceYMV02gSvqlHCfTimxy8/Jl7yMsCyKWflgltk26D6V8fyWO/K4FcKvTAW0C86/X0P2B5bRp7fQPHYBEWWFpDqphmKvouU3j4VIuJjV5r/1SRTUekkwQQDDqUNPquJmemT0Ac4qPPdCTDI8q/XedaKdpJEJCK67CFOUffC1ThvhitVHzRQIeIcNuj7EWWidabz/ZoyF0jaEKueTwpwe1oV57x8pqqfLJ6MiLY2opOx0Y/24Z1n1B+T0YcXvHOrL731HTtszbrYUTvMFBbAWdxSJhjw6AFxUxCG2DKzoCxSGqGf3Tq04lVYPS+7vel9cFanPsGMwHhKyX5TtP43dt18OsO9XnqsffZya6eGH2sMZn7c85+7+6LJhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(2906002)(44832011)(235185007)(5660300002)(8936002)(316002)(8676002)(6486002)(6666004)(107886003)(66476007)(66946007)(41300700001)(4326008)(66556008)(478600001)(450100002)(26005)(6512007)(6506007)(44144004)(83380400001)(21480400003)(186003)(86362001)(82960400001)(38100700002)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MV302ckJoxhM3QG8uMMZ9bjIIGJ3A2j01oxSnC8h6eyfBLuV2UIOr4ygYRHK?=
 =?us-ascii?Q?dbIXsaTvvmZ2aEPlJYm8phjKs4eyv0pJx0RC0tzO+JDxlhlNl/0P907xFzIU?=
 =?us-ascii?Q?trevFmHQt3UeA+Z9bZ8c9nU7Js6twcXZjFCTe1Uuoh69VFgRuq0T3L1cbob3?=
 =?us-ascii?Q?0MygoI8rL3nXNmjZU+LmJX3fa+ubW6tsVTgggDUmKqqQVq1rB0oGFZd95F1i?=
 =?us-ascii?Q?JmdMqh/R8zbr2XxYX/2DqL99BtE6mJyDardOEz2p1nc2xYqSDpwxTu/UMKl5?=
 =?us-ascii?Q?AZ02ytS8gufrCrRgcc2V+mCscoTATnmos1CxT53Vpv2rq+UsSSVAfz+ImgTA?=
 =?us-ascii?Q?rNhF0cLE0xA6eoY65wUkTOhZpOE9oQ15WM9uwsmEFLCZEX3BqiCAlFrubJA4?=
 =?us-ascii?Q?yQMAmdkoErVHJ0De5upHHdU9pHZX7gUjTtjKHhE3lgrXk39vhLpbH/qcEyJ9?=
 =?us-ascii?Q?JtV1Ewgu1UDiYSW5x4Vu6mi9qdOtIs86FOVYFcVbWp2pR2RoL8lPXx3JouTy?=
 =?us-ascii?Q?yIhVXv46Nzbdd2tJ089DGBZzniF5Az8xlD6qTLuh30x/OMDSZcDCTcpv9WFJ?=
 =?us-ascii?Q?DyneRnX1IigsIsJZ8hqp0+xyACnuxxLRAjxP5QIKuQajtvWvzg0n6pXfkZW6?=
 =?us-ascii?Q?e7MVgOXOtbPAJ3cDYmXqTjCldqRrL6ALLCzT3YysmzyQeCYT51TB7vYA49Pz?=
 =?us-ascii?Q?6+xDWv6ykfMF877Ojg6DaRAEIb7dt5dUkrhC0U4kEQyOq+HAuyL6HhYII3Hv?=
 =?us-ascii?Q?ookxWvLGMKIbWD3kkOOCwSTryAvYEe8+sLnLX4fXqnoSvLoC22Ve5uMBXeeN?=
 =?us-ascii?Q?bndpU3XZudKz/BPqgV/LH8RvTAFxr5cKn0YlxOuHAR5BmRCpLgNBKKQSmKpN?=
 =?us-ascii?Q?6Ln+wlN52gU6Pfju9ylXF0fNiqPtkj3VO0n7XAGGQ7MsojZpaef8cIJzFruz?=
 =?us-ascii?Q?MKIcBSmbHqq4M7XqarroQ8YarxUAn/6lsUCISmee7fYCo/nvVchxsNtWVC1v?=
 =?us-ascii?Q?y9EPZoXqpRC6fdhgQ1cCaFB8PlnNUl3vwAP1GfzYvYE6UMdplRVxfrTDJqAw?=
 =?us-ascii?Q?CUZX3covtjt8UpwiMlrPpJM1q1JsiM9WH74VW96lQYzZ+X7sj/pdqmjBS/Wt?=
 =?us-ascii?Q?/nLtg86Ru96dC359+87207KGxjaoSbPhGDIRy1nxsqcwrhoDdEBuck1Qk/hE?=
 =?us-ascii?Q?DiemHHMj1ytYP07vbIqsCk6iDnRCQJgshzA6thA5w0UaLUBVsewfM2socjPz?=
 =?us-ascii?Q?NhGVlrOhjBT1Z71CXlNkf6gl6c9u3krdE5Z64OpuEz+8bZsA0OstM7M1uKOO?=
 =?us-ascii?Q?shWxk4wDOrWbntiz6NzIsXKG82IwwjeNbIKwpzsOU9avSD8PiOhsgjl33VLY?=
 =?us-ascii?Q?T++Z/4NafcAGayXijZifBDi6WIS6+xy5SMJycVnwcftWNYwyiEwLKL61Zh7a?=
 =?us-ascii?Q?wj8VxS9xDxF+91DJX6JKNBLcVkNkaC8hVKQsUficyC4hzZ2e8xLKrtPf1O9W?=
 =?us-ascii?Q?ZCoBwHtithD+ucA/6wmpFPvrB1Hs0uCKHn3G/atZ6UWmVIB5e3amuJjG57Du?=
 =?us-ascii?Q?7/c1FrJbYIgOfk8Nr48j7qSAWQo0pS0cqx791DnzX1/RBJMVeYWUSzoplTxK?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec0526-bd1f-42d1-83dc-08da9c6a39fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 07:15:28.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMn2p1wfmsHtbNOSW8i3RKNIx68XFMPgEpbGkzBx9mDS37AHLTfvfdYnhU7MxSu3DUSAQ1zUrsw3AvUAQV9R1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+jwnAk+X9uKarQqM
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi gpio and LKML developers,

Greeting!

Platform: TGL-U platform
Kernel: 6.0-rc6 mainline

When executed gpio kselftest:
tools/testing/selftests/gpio/gpio-mockup.sh

# ./gpio/gpio-mockup.sh
test failed: can't remove existing gpio-mockup module
GPIO gpio-mockup test FAIL
# lsmod  | grep gpio
gpio_mockup            16384  -1

At the step "modprobe -r -q gpio_mockup", there was BUG info in dmesg:

[   43.928611] gpiochip_find_base: found new base at 632
...
[   44.021733] gpio gpiochip1: registered chardev handle for 1 lines
[   44.036775] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[   44.036816] #PF: supervisor write access in kernel mode
[   44.036833] #PF: error_code(0x0002) - not-present page
...
[   44.037213] Call Trace:
[   44.037223]  <TASK>
[   44.037235]  simple_recursive_removal+0x9d/0x2a0
[   44.037255]  ? debugfs_lookup_and_remove+0x40/0x40
[   44.037276]  ? preempt_count_add+0x7c/0xc0

Dmesg is in attached.

Thanks!

--+jwnAk+X9uKarQqM
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="20220922_tglu_unload_gpio_mockup_bug.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] microcode: microcode updated early to revision 0xa4, date =
=3D 2022-02-01=0D
[    0.000000] Linux version 6.0.0-rc6-m (root@xpf.sh.intel.com) (gcc (GCC)=
 8.5.0 20210514 (Red Hat 8.5.0-10), GNU ld version 2.36.1-2.el8) #20 SMP PR=
EEMPT_DYNAMIC Thu Sep 22 14:43:45 CST 2022=0D
[    0.000000] Command line: BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.0.0-rc6-m ro=
ot=3DUUID=3D7c6a9fdf-13e2-4c7b-9a32-7e4eefdb34f9 ro rootflags=3Dsubvol=3Dro=
ot rhgb quiet selinux=3D0=0D
[    0.000000] KERNEL supported cpus:=0D
[    0.000000]   Intel GenuineIntel=0D
[    0.000000]   AMD AuthenticAMD=0D
[    0.000000]   Hygon HygonGenuine=0D
[    0.000000]   Centaur CentaurHauls=0D
[    0.000000]   zhaoxin   Shanghai  =0D
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel=
 split_locks and warning on user-space split_locks=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'=
=0D
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys Us=
er registers'=0D
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256=0D
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64=0D
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512=0D
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024=0D
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8=0D
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440=
 bytes, using 'compacted' format.=0D
[    0.000000] signal: max sigframe size: 3632=0D
[    0.000000] BIOS-provided physical RAM map:=0D
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000000ffffff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x0000000001000000-0x00000000049e5fff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000049e6000-0x000000002b4f6fff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x000000002b4f7000-0x000000002d469fff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x000000002d46a000-0x0000000041724fff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x0000000041725000-0x0000000044a90fff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000044a91000-0x0000000044b32fff] ACPI =
NVS=0D
[    0.000000] BIOS-e820: [mem 0x0000000044b33000-0x0000000044bfefff] ACPI =
data=0D
[    0.000000] BIOS-e820: [mem 0x0000000044bff000-0x0000000044bfffff] usabl=
e=0D
[    0.000000] BIOS-e820: [mem 0x0000000044c00000-0x0000000048ffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000049400000-0x00000000495fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x000000004a200000-0x00000000503fffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x00000000ff400000-0x00000000ffffffff] reser=
ved=0D
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004afbfffff] usabl=
e=0D
[    0.000000] NX (Execute Disable) protection: active=0D
[    0.000000] e820: update [mem 0x3d297018-0x3d2f3e57] usable =3D=3D> usab=
le=0D
[    0.000000] e820: update [mem 0x3d297018-0x3d2f3e57] usable =3D=3D> usab=
le=0D
[    0.000000] extended physical RAM map:=0D
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ef=
ff] usable=0D
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000fff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000000ffff=
ff] usable=0D
[    0.000000] reserve setup_data: [mem 0x0000000001000000-0x00000000049e5f=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x00000000049e6000-0x000000002b4f6f=
ff] usable=0D
[    0.000000] reserve setup_data: [mem 0x000000002b4f7000-0x000000002d469f=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x000000002d46a000-0x000000003d2970=
17] usable=0D
[    0.000000] reserve setup_data: [mem 0x000000003d297018-0x000000003d2f3e=
57] usable=0D
[    0.000000] reserve setup_data: [mem 0x000000003d2f3e58-0x0000000041724f=
ff] usable=0D
[    0.000000] reserve setup_data: [mem 0x0000000041725000-0x0000000044a90f=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x0000000044a91000-0x0000000044b32f=
ff] ACPI NVS=0D
[    0.000000] reserve setup_data: [mem 0x0000000044b33000-0x0000000044bfef=
ff] ACPI data=0D
[    0.000000] reserve setup_data: [mem 0x0000000044bff000-0x0000000044bfff=
ff] usable=0D
[    0.000000] reserve setup_data: [mem 0x0000000044c00000-0x0000000048ffff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x0000000049400000-0x00000000495fff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x000000004a200000-0x00000000503fff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x00000000c0000000-0x00000000cfffff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x00000000fed20000-0x00000000fed7ff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x00000000ff400000-0x00000000ffffff=
ff] reserved=0D
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000004afbfff=
ff] usable=0D
[    0.000000] efi: EFI v2.70 by Intel=0D
[    0.000000] efi: ACPI=3D0x44bfe000 ACPI 2.0=3D0x44bfe014 TPMFinalLog=3D0=
x44ad8000 SMBIOS=3D0x417fa000 MEMATTR=3D0x3dde8018 ESRT=3D0x3de0e218 TPMEve=
ntLog=3D0x3dafd018 =0D
[    0.000000] SMBIOS 3.2 present.=0D
[    0.000000] DMI: Intel Corporation Tiger Lake Client Platform/TigerLake =
U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.4391.A00.2109201819 09/20/2021=0D
[    0.000000] tsc: Detected 2800.000 MHz processor=0D
[    0.000000] tsc: Detected 2803.200 MHz TSC=0D
[    0.000005] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved=0D
[    0.000007] e820: remove [mem 0x000a0000-0x000fffff] usable=0D
[    0.000012] last_pfn =3D 0x4afc00 max_arch_pfn =3D 0x400000000=0D
[    0.000139] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
  =0D
[    0.000856] last_pfn =3D 0x44c00 max_arch_pfn =3D 0x400000000=0D
[    0.008230] esrt: Reserving ESRT space from 0x000000003de0e218 to 0x0000=
00003de0e340.=0D
[    0.008239] e820: update [mem 0x3de0e000-0x3de0efff] usable =3D=3D> rese=
rved=0D
[    0.008275] Using GB pages for direct mapping=0D
[    0.008595] Secure boot disabled=0D
[    0.008595] RAMDISK: [mem 0x2b4f7000-0x2d469fff]=0D
[    0.008596] Allocated new RAMDISK: [mem 0x4adc8d000-0x4afbff883]=0D
[    0.012633] Move RAMDISK from [mem 0x2b4f7000-0x2d469883] to [mem 0x4adc=
8d000-0x4afbff883]=0D
[    0.012637] ACPI: Early table checksum verification disabled=0D
[    0.012640] ACPI: RSDP 0x0000000044BFE014 000024 (v02 INTEL )=0D
[    0.012643] ACPI: XSDT 0x0000000044B55188 00010C (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012647] ACPI: FACP 0x0000000044BF0000 000114 (v06 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012651] ACPI: DSDT 0x0000000044B80000 06DF3A (v02 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012653] ACPI: FACS 0x0000000044AC3000 000040=0D
[    0.012655] ACPI: SSDT 0x0000000044BFA000 002576 (v02 CpuRef CpuSsdt  00=
003000 INTL 20191018)=0D
[    0.012657] ACPI: SSDT 0x0000000044BF4000 005926 (v02 DptfTb DptfTabl 00=
001000 INTL 20191018)=0D
[    0.012659] ACPI: SSDT 0x0000000044BF3000 00060E (v02 INTEL  Tpm2Tabl 00=
001000 INTL 20191018)=0D
[    0.012661] ACPI: TPM2 0x0000000044BF2000 00004C (v04 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012663] ACPI: ECDT 0x0000000044BF1000 000069 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012665] ACPI: HPET 0x0000000044BEF000 000038 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012667] ACPI: APIC 0x0000000044BEE000 00012C (v04 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012669] ACPI: SSDT 0x0000000044B76000 009632 (v02 INTEL  TglU_Rvp 00=
001000 INTL 20191018)=0D
[    0.012671] ACPI: SSDT 0x0000000044B75000 000E94 (v02 INTEL  Ther_Rvp 00=
001000 INTL 20191018)=0D
[    0.012673] ACPI: NHLT 0x0000000044B73000 001B25 (v00 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012675] ACPI: SSDT 0x0000000044B6F000 003D7A (v02 SaSsdt SaSsdt   00=
003000 INTL 20191018)=0D
[    0.012676] ACPI: SSDT 0x0000000044B6B000 0034DF (v02 INTEL  IgfxSsdt 00=
003000 INTL 20191018)=0D
[    0.012678] ACPI: SSDT 0x0000000044B5F000 00BE2D (v02 INTEL  TcssSsdt 00=
001000 INTL 20191018)=0D
[    0.012680] ACPI: SSDT 0x0000000044B5E000 00014C (v02 INTEL  IpuSsdt  00=
001000 INTL 20191018)=0D
[    0.012682] ACPI: LPIT 0x0000000044B5D000 0000CC (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012684] ACPI: WSMT 0x0000000044B5C000 000028 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012686] ACPI: SSDT 0x0000000044B59000 002720 (v02 INTEL  PtidDevc 00=
001000 INTL 20191018)=0D
[    0.012688] ACPI: SSDT 0x0000000044B58000 00012A (v02 INTEL  TbtTypeC 00=
000000 INTL 20191018)=0D
[    0.012690] ACPI: DBGP 0x0000000044B57000 000034 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012692] ACPI: DBG2 0x0000000044B56000 000054 (v00 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012694] ACPI: SSDT 0x0000000044B53000 0015FC (v02 INTEL  UsbCTabl 00=
001000 INTL 20191018)=0D
[    0.012696] ACPI: DMAR 0x0000000044BFD000 000100 (v02 INTEL  ICL      00=
000002      01000013)=0D
[    0.012698] ACPI: SSDT 0x0000000044B52000 000D12 (v02 INTEL  xh_tudd4 00=
000000 INTL 20191018)=0D
[    0.012700] ACPI: MCFG 0x0000000044B51000 00003C (v01                 00=
000001      00000000)=0D
[    0.012702] ACPI: SSDT 0x0000000044B50000 000144 (v02 Intel  ADebTabl 00=
001000 INTL 20191018)=0D
[    0.012704] ACPI: BGRT 0x0000000044B4F000 000038 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012706] ACPI: PTDT 0x0000000044B4E000 000D44 (v00 INTEL  TGL-ULT  00=
000005 MSFT 0100000D)=0D
[    0.012708] ACPI: FPDT 0x0000000044B4D000 000044 (v01 INTEL  TGL-ULT  00=
000002      01000013)=0D
[    0.012710] ACPI: Reserving FACP table memory at [mem 0x44bf0000-0x44bf0=
113]=0D
[    0.012711] ACPI: Reserving DSDT table memory at [mem 0x44b80000-0x44bed=
f39]=0D
[    0.012711] ACPI: Reserving FACS table memory at [mem 0x44ac3000-0x44ac3=
03f]=0D
[    0.012712] ACPI: Reserving SSDT table memory at [mem 0x44bfa000-0x44bfc=
575]=0D
[    0.012712] ACPI: Reserving SSDT table memory at [mem 0x44bf4000-0x44bf9=
925]=0D
[    0.012712] ACPI: Reserving SSDT table memory at [mem 0x44bf3000-0x44bf3=
60d]=0D
[    0.012713] ACPI: Reserving TPM2 table memory at [mem 0x44bf2000-0x44bf2=
04b]=0D
[    0.012713] ACPI: Reserving ECDT table memory at [mem 0x44bf1000-0x44bf1=
068]=0D
[    0.012714] ACPI: Reserving HPET table memory at [mem 0x44bef000-0x44bef=
037]=0D
[    0.012714] ACPI: Reserving APIC table memory at [mem 0x44bee000-0x44bee=
12b]=0D
[    0.012715] ACPI: Reserving SSDT table memory at [mem 0x44b76000-0x44b7f=
631]=0D
[    0.012715] ACPI: Reserving SSDT table memory at [mem 0x44b75000-0x44b75=
e93]=0D
[    0.012716] ACPI: Reserving NHLT table memory at [mem 0x44b73000-0x44b74=
b24]=0D
[    0.012716] ACPI: Reserving SSDT table memory at [mem 0x44b6f000-0x44b72=
d79]=0D
[    0.012717] ACPI: Reserving SSDT table memory at [mem 0x44b6b000-0x44b6e=
4de]=0D
[    0.012717] ACPI: Reserving SSDT table memory at [mem 0x44b5f000-0x44b6a=
e2c]=0D
[    0.012718] ACPI: Reserving SSDT table memory at [mem 0x44b5e000-0x44b5e=
14b]=0D
[    0.012718] ACPI: Reserving LPIT table memory at [mem 0x44b5d000-0x44b5d=
0cb]=0D
[    0.012718] ACPI: Reserving WSMT table memory at [mem 0x44b5c000-0x44b5c=
027]=0D
[    0.012719] ACPI: Reserving SSDT table memory at [mem 0x44b59000-0x44b5b=
71f]=0D
[    0.012719] ACPI: Reserving SSDT table memory at [mem 0x44b58000-0x44b58=
129]=0D
[    0.012720] ACPI: Reserving DBGP table memory at [mem 0x44b57000-0x44b57=
033]=0D
[    0.012720] ACPI: Reserving DBG2 table memory at [mem 0x44b56000-0x44b56=
053]=0D
[    0.012721] ACPI: Reserving SSDT table memory at [mem 0x44b53000-0x44b54=
5fb]=0D
[    0.012721] ACPI: Reserving DMAR table memory at [mem 0x44bfd000-0x44bfd=
0ff]=0D
[    0.012722] ACPI: Reserving SSDT table memory at [mem 0x44b52000-0x44b52=
d11]=0D
[    0.012722] ACPI: Reserving MCFG table memory at [mem 0x44b51000-0x44b51=
03b]=0D
[    0.012723] ACPI: Reserving SSDT table memory at [mem 0x44b50000-0x44b50=
143]=0D
[    0.012723] ACPI: Reserving BGRT table memory at [mem 0x44b4f000-0x44b4f=
037]=0D
[    0.012724] ACPI: Reserving PTDT table memory at [mem 0x44b4e000-0x44b4e=
d43]=0D
[    0.012724] ACPI: Reserving FPDT table memory at [mem 0x44b4d000-0x44b4d=
043]=0D
[    0.013141] No NUMA configuration found=0D
[    0.013142] Faking a node at [mem 0x0000000000000000-0x00000004afbfffff]=
=0D
[    0.013148] NODE_DATA(0) allocated [mem 0x4adc62000-0x4adc8cfff]=0D
[    0.013283] Zone ranges:=0D
[    0.013284]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]=0D
[    0.013285]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]=0D
[    0.013286]   Normal   [mem 0x0000000100000000-0x00000004afbfffff]=0D
[    0.013286]   Device   empty=0D
[    0.013287] Movable zone start for each node=0D
[    0.013289] Early memory node ranges=0D
[    0.013289]   node   0: [mem 0x0000000000001000-0x000000000009efff]=0D
[    0.013290]   node   0: [mem 0x0000000000100000-0x0000000000ffffff]=0D
[    0.013291]   node   0: [mem 0x00000000049e6000-0x000000002b4f6fff]=0D
[    0.013291]   node   0: [mem 0x000000002d46a000-0x0000000041724fff]=0D
[    0.013292]   node   0: [mem 0x0000000044bff000-0x0000000044bfffff]=0D
[    0.013292]   node   0: [mem 0x0000000100000000-0x00000004afbfffff]=0D
[    0.013293] Initmem setup node 0 [mem 0x0000000000001000-0x00000004afbff=
fff]=0D
[    0.013298] On node 0, zone DMA: 1 pages in unavailable ranges=0D
[    0.013315] On node 0, zone DMA: 97 pages in unavailable ranges=0D
[    0.014105] On node 0, zone DMA32: 14822 pages in unavailable ranges=0D
[    0.014536] On node 0, zone DMA32: 8051 pages in unavailable ranges=0D
[    0.014613] On node 0, zone DMA32: 13530 pages in unavailable ranges=0D
[    0.032462] On node 0, zone Normal: 13312 pages in unavailable ranges=0D
[    0.032468] On node 0, zone Normal: 1024 pages in unavailable ranges=0D
[    0.032509] Reserving Intel graphics memory at [mem 0x4c800000-0x503ffff=
f]=0D
[    0.034774] ACPI: PM-Timer IO Port: 0x1808=0D
[    0.034780] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])=0D
[    0.034781] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])=0D
[    0.034781] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])=0D
[    0.034782] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])=0D
[    0.034782] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])=0D
[    0.034782] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])=0D
[    0.034783] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])=0D
[    0.034783] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])=0D
[    0.034784] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])=0D
[    0.034784] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])=0D
[    0.034784] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])=0D
[    0.034785] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])=0D
[    0.034785] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])=0D
[    0.034785] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])=0D
[    0.034786] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])=0D
[    0.034786] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])=0D
[    0.034869] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119=0D
[    0.034871] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0D
[    0.034873] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=
=0D
[    0.034875] ACPI: Using ACPI (MADT) for SMP configuration information=0D
[    0.034876] ACPI: HPET id: 0x8086a201 base: 0xfed00000=0D
[    0.034886] e820: update [mem 0x3dded000-0x3de07fff] usable =3D=3D> rese=
rved=0D
[    0.034894] TSC deadline timer available=0D
[    0.034895] smpboot: Allowing 8 CPUs, 0 hotplug CPUs=0D
[    0.034919] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]=0D
[    0.034920] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0=
x000fffff]=0D
[    0.034922] PM: hibernation: Registered nosave memory: [mem 0x01000000-0=
x049e5fff]=0D
[    0.034924] PM: hibernation: Registered nosave memory: [mem 0x2b4f7000-0=
x2d469fff]=0D
[    0.034925] PM: hibernation: Registered nosave memory: [mem 0x3d297000-0=
x3d297fff]=0D
[    0.034927] PM: hibernation: Registered nosave memory: [mem 0x3d2f3000-0=
x3d2f3fff]=0D
[    0.034928] PM: hibernation: Registered nosave memory: [mem 0x3dded000-0=
x3de07fff]=0D
[    0.034930] PM: hibernation: Registered nosave memory: [mem 0x3de0e000-0=
x3de0efff]=0D
[    0.034931] PM: hibernation: Registered nosave memory: [mem 0x41725000-0=
x44a90fff]=0D
[    0.034932] PM: hibernation: Registered nosave memory: [mem 0x44a91000-0=
x44b32fff]=0D
[    0.034932] PM: hibernation: Registered nosave memory: [mem 0x44b33000-0=
x44bfefff]=0D
[    0.034934] PM: hibernation: Registered nosave memory: [mem 0x44c00000-0=
x48ffffff]=0D
[    0.034934] PM: hibernation: Registered nosave memory: [mem 0x49000000-0=
x493fffff]=0D
[    0.034935] PM: hibernation: Registered nosave memory: [mem 0x49400000-0=
x495fffff]=0D
[    0.034935] PM: hibernation: Registered nosave memory: [mem 0x49600000-0=
x4a1fffff]=0D
[    0.034935] PM: hibernation: Registered nosave memory: [mem 0x4a200000-0=
x503fffff]=0D
[    0.034936] PM: hibernation: Registered nosave memory: [mem 0x50400000-0=
xbfffffff]=0D
[    0.034936] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0=
xcfffffff]=0D
[    0.034936] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0=
xfed1ffff]=0D
[    0.034937] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0=
xfed7ffff]=0D
[    0.034937] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0=
xff3fffff]=0D
[    0.034937] PM: hibernation: Registered nosave memory: [mem 0xff400000-0=
xffffffff]=0D
[    0.034939] [mem 0x50400000-0xbfffffff] available for PCI devices=0D
[    0.034939] Booting paravirtualized kernel on bare hardware=0D
[    0.034941] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns=0D
[    0.034945] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr=
_node_ids:1=0D
[    0.035083] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144=
=0D
[    0.035090] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=3D1*2097152=
=0D
[    0.035091] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 =0D
[    0.035117] Fallback order for Node 0: 0 =0D
[    0.035119] Built 1 zonelists, mobility grouping on.  Total pages: 40463=
09=0D
[    0.035120] Policy zone: Normal=0D
[    0.035121] Kernel command line: BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.0.0-r=
c6-m root=3DUUID=3D7c6a9fdf-13e2-4c7b-9a32-7e4eefdb34f9 ro rootflags=3Dsubv=
ol=3Droot rhgb quiet selinux=3D0=0D
[    0.035182] Unknown kernel command line parameters "rhgb BOOT_IMAGE=3D(h=
d0,gpt2)/vmlinuz-6.0.0-rc6-m", will be passed to user space.=0D
[    0.035589] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes, linear)=0D
[    0.035784] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes, linear)=0D
[    0.035853] mem auto-init: stack:off, heap alloc:off, heap free:off=0D
[    0.035868] software IO TLB: area num 8.=0D
[    0.063829] Memory: 15938684K/16442796K available (20493K kernel code, 3=
489K rwdata, 6928K rodata, 3284K init, 9420K bss, 503852K reserved, 0K cma-=
reserved)=0D
[    0.065558] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8, N=
odes=3D1=0D
[    0.065560] kmemleak: Kernel memory leak detector disabled=0D
[    0.065605] ftrace: allocating 61497 entries in 241 pages=0D
[    0.072222] ftrace: allocated 241 pages with 5 groups=0D
[    0.073034] Dynamic Preempt: voluntary=0D
[    0.073126] rcu: Preemptible hierarchical RCU implementation.=0D
[    0.073127] rcu:     RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_=
ids=3D8.=0D
[    0.073128]  Trampoline variant of Tasks RCU enabled.=0D
[    0.073128]  Rude variant of Tasks RCU enabled.=0D
[    0.073128]  Tracing variant of Tasks RCU enabled.=0D
[    0.073129] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.=0D
[    0.073129] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D8=0D
[    0.077349] NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16=0D
[    0.077688] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.=0D
[    0.078060] Console: colour dummy device 80x25=0D
[    0.078070] printk: console [tty0] enabled=0D
[    0.078118] ACPI: Core revision 20220331=0D
[    0.078490] hpet: HPET dysfunctional in PC10. Force disabled.=0D
[    0.078491] APIC: Switch to symmetric I/O mode setup=0D
[    0.078493] DMAR: Host address width 39=0D
[    0.078493] DMAR: DRHD base: 0x000000fed90000 flags: 0x0=0D
[    0.078511] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660=
462 ecap 29a00f0505e=0D
[    0.078513] DMAR: DRHD base: 0x000000fed92000 flags: 0x0=0D
[    0.078515] DMAR: dmar1: reg_base_addr fed92000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078516] DMAR: DRHD base: 0x000000fed84000 flags: 0x0=0D
[    0.078519] DMAR: dmar2: reg_base_addr fed84000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078520] DMAR: DRHD base: 0x000000fed85000 flags: 0x0=0D
[    0.078536] DMAR: dmar3: reg_base_addr fed85000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078537] DMAR: DRHD base: 0x000000fed86000 flags: 0x0=0D
[    0.078540] DMAR: dmar4: reg_base_addr fed86000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078541] DMAR: DRHD base: 0x000000fed87000 flags: 0x0=0D
[    0.078544] DMAR: dmar5: reg_base_addr fed87000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078545] DMAR: DRHD base: 0x000000fed91000 flags: 0x1=0D
[    0.078549] DMAR: dmar6: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da=0D
[    0.078551] DMAR: RMRR base: 0x0000004c000000 end: 0x000000503fffff=0D
[    0.078553] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 6=0D
[    0.078553] DMAR-IR: HPET id 0 under DRHD base 0xfed91000=0D
[    0.078554] DMAR-IR: Queued invalidation will be enabled to support x2ap=
ic and Intr-remapping.=0D
[    0.083578] DMAR-IR: Enabled IRQ remapping in x2apic mode=0D
[    0.083581] x2apic enabled=0D
[    0.083633] Switched APIC routing to cluster x2apic.=0D
[    0.094927] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x28680fa287f, max_idle_ns: 440795281151 ns=0D
[    0.094934] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 5606.40 BogoMIPS (lpj=3D11212800)=0D
[    0.094936] pid_max: default: 32768 minimum: 301=0D
[    0.097201] LSM: Security Framework initializing=0D
[    0.097203] Yama: becoming mindful.=0D
[    0.097426] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s, linear)=0D
[    0.097447] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes, linear)=0D
[    0.098035] CPU0: Thermal monitoring enabled (TM1)=0D
[    0.098037] x86/cpu: User Mode Instruction Prevention (UMIP) activated=
=0D
[    0.098141] process: using mwait in idle threads=0D
[    0.098142] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0=0D
[    0.098143] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0=0D
[    0.098146] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization=0D
[    0.098147] Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBR=
S on, data leaks possible via Spectre v2 BHB attacks!=0D
[    0.098150] Spectre V2 : Mitigation: Enhanced IBRS=0D
[    0.098151] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch=0D
[    0.098151] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL =
on VMEXIT=0D
[    0.098152] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier=0D
[    0.098153] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl=0D
[    0.098931] Freeing SMP alternatives memory: 52K=0D
[    0.098931] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GH=
z (family: 0x6, model: 0x8c, stepping: 0x1)=0D
[    0.098931] cblist_init_generic: Setting adjustable number of callback q=
ueues.=0D
[    0.098931] cblist_init_generic: Setting shift to 3 and lim to 1.=0D
[    0.098931] cblist_init_generic: Setting shift to 3 and lim to 1.=0D
[    0.098931] cblist_init_generic: Setting shift to 3 and lim to 1.=0D
[    0.098931] Performance Events: PEBS fmt4+-baseline,  AnyThread deprecat=
ed, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.=0D
[    0.098931] ... version:                5=0D
[    0.098931] ... bit width:              48=0D
[    0.098931] ... generic registers:      8=0D
[    0.098931] ... value mask:             0000ffffffffffff=0D
[    0.098931] ... max period:             00007fffffffffff=0D
[    0.098931] ... fixed-purpose events:   4=0D
[    0.098931] ... event mask:             0001000f000000ff=0D
[    0.098931] Estimated ratio of average max frequency by base frequency (=
times 1024): 1499=0D
[    0.098931] rcu: Hierarchical SRCU implementation.=0D
[    0.098931] rcu:     Max phase no-delay instances is 1000.=0D
[    0.098931] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.=0D
[    0.098931] smp: Bringing up secondary CPUs ...=0D
[    0.098931] x86: Booting SMP configuration:=0D
[    0.098931] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7=0D
[    0.107598] smp: Brought up 1 node, 8 CPUs=0D
[    0.107598] smpboot: Max logical packages: 1=0D
[    0.107598] smpboot: Total of 8 processors activated (44851.20 BogoMIPS)=
=0D
[    0.111634] devtmpfs: initialized=0D
[    0.111634] x86/mm: Memory block size: 128MB=0D
[    0.113391] ACPI: PM: Registering ACPI NVS region [mem 0x44a91000-0x44b3=
2fff] (663552 bytes)=0D
[    0.113391] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns=0D
[    0.113391] futex hash table entries: 2048 (order: 5, 131072 bytes, line=
ar)=0D
[    0.113391] pinctrl core: initialized pinctrl subsystem=0D
=0D
[    0.113391] ************************************************************=
*=0D
[    0.113391] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.113391] **                                                         *=
*=0D
[    0.113391] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  *=
*=0D
[    0.113391] **                                                         *=
*=0D
[    0.113391] ** This means that this kernel is built to expose internal *=
*=0D
[    0.113391] ** IOMMU data structures, which may compromise security on *=
*=0D
[    0.113391] ** your system.                                            *=
*=0D
[    0.113391] **                                                         *=
*=0D
[    0.113391] ** If you see this message and you are not debugging the   *=
*=0D
[    0.113391] ** kernel, report this immediately to your vendor!         *=
*=0D
[    0.113391] **                                                         *=
*=0D
[    0.113391] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    *=
*=0D
[    0.113391] ************************************************************=
*=0D
[    0.114934] PM: RTC time: 12:00:29, date: 2022-09-23=0D
[    0.115820] NET: Registered PF_NETLINK/PF_ROUTE protocol family=0D
[    0.116006] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic alloca=
tions=0D
[    0.116011] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations=0D
[    0.116016] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations=0D
[    0.116050] audit: initializing netlink subsys (disabled)=0D
[    0.116057] audit: type=3D2000 audit(1663934429.020:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1=0D
[    0.116057] thermal_sys: Registered thermal governor 'fair_share'=0D
[    0.116057] thermal_sys: Registered thermal governor 'bang_bang'=0D
[    0.116057] thermal_sys: Registered thermal governor 'step_wise'=0D
[    0.116057] thermal_sys: Registered thermal governor 'user_space'=0D
[    0.116057] cpuidle: using governor ladder=0D
[    0.116057] cpuidle: using governor menu=0D
[    0.116057] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5=0D
[    0.116057] PCI: MMCONFIG for domain 0000 [bus 00-aa] at [mem 0xc0000000=
-0xcaafffff] (base 0xc0000000)=0D
[    0.116057] PCI: MMCONFIG at [mem 0xc0000000-0xcaafffff] reserved in E82=
0=0D
[    0.116057] PCI: Using configuration type 1 for base access=0D
[    0.116057] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'=0D
[    0.119000] kprobes: kprobe jump-optimization is enabled. All kprobes ar=
e optimized if possible.=0D
[    0.119078] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 page=
s=0D
[    0.119078] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page=
=0D
[    0.119078] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 page=
s=0D
[    0.119078] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page=0D
[    0.119113] ACPI: Added _OSI(Module Device)=0D
[    0.119114] ACPI: Added _OSI(Processor Device)=0D
[    0.119115] ACPI: Added _OSI(3.0 _SCP Extensions)=0D
[    0.119115] ACPI: Added _OSI(Processor Aggregator Device)=0D
[    0.119116] ACPI: Added _OSI(Linux-Dell-Video)=0D
[    0.119117] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)=0D
[    0.119117] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)=0D
[    0.192201] ACPI: 15 ACPI AML tables successfully acquired and loaded=0D
[    0.193586] ACPI: EC: EC started=0D
[    0.193587] ACPI: EC: interrupt blocked=0D
[    0.307925] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62=0D
[    0.307927] ACPI: EC: Boot ECDT EC used to handle transactions=0D
[    0.387485] ACPI: Dynamic OEM Table Load:=0D
[    0.387485] ACPI: SSDT 0xFFFF974101FA6800 0001CB (v02 PmRef  Cpu0Psd  00=
003000 INTL 20191018)=0D
[    0.388228] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked=0D
[    0.390000] ACPI: Dynamic OEM Table Load:=0D
[    0.390005] ACPI: SSDT 0xFFFF974101937000 00047F (v02 PmRef  Cpu0Cst  00=
003001 INTL 20191018)=0D
[    0.391649] ACPI: Dynamic OEM Table Load:=0D
[    0.391654] ACPI: SSDT 0xFFFF974101935000 000647 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20191018)=0D
[    0.392841] ACPI: Dynamic OEM Table Load:=0D
[    0.392845] ACPI: SSDT 0xFFFF974101926400 00028B (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20191018)=0D
[    0.394039] ACPI: Dynamic OEM Table Load:=0D
[    0.394045] ACPI: SSDT 0xFFFF974101928000 0008E7 (v02 PmRef  ApIst    00=
003000 INTL 20191018)=0D
[    0.395268] ACPI: Dynamic OEM Table Load:=0D
[    0.395273] ACPI: SSDT 0xFFFF974101934000 00048A (v02 PmRef  ApHwp    00=
003000 INTL 20191018)=0D
[    0.396362] ACPI: Dynamic OEM Table Load:=0D
[    0.396366] ACPI: SSDT 0xFFFF974101930800 0004D4 (v02 PmRef  ApPsd    00=
003000 INTL 20191018)=0D
[    0.397452] ACPI: Dynamic OEM Table Load:=0D
[    0.397456] ACPI: SSDT 0xFFFF974101931000 00048A (v02 PmRef  ApCst    00=
003000 INTL 20191018)=0D
[    0.401662] ACPI: Interpreter enabled=0D
[    0.401706] ACPI: PM: (supports S0 S3 S4 S5)=0D
[    0.401707] ACPI: Using IOAPIC for interrupt routing=0D
[    0.401740] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug=0D
[    0.401741] PCI: Using E820 reservations for host bridge windows=0D
[    0.403151] ACPI: Enabled 8 GPEs in block 00 to 7F=0D
[    0.405042] ACPI: PM: Power Resource [PXP]=0D
[    0.543178] ACPI: PM: Power Resource [PAUD]=0D
[    0.548350] ACPI: PM: Power Resource [PXP]=0D
[    0.549877] ACPI: PM: Power Resource [PXP]=0D
[    0.552126] ACPI: PM: Power Resource [PXP]=0D
[    0.667904] ACPI: PM: Power Resource [PXP]=0D
[    0.673490] ACPI: PM: Power Resource [V0PR]=0D
[    0.673864] ACPI: PM: Power Resource [V1PR]=0D
[    0.674248] ACPI: PM: Power Resource [V2PR]=0D
[    0.680370] ACPI: PM: Power Resource [PXTC]=0D
[    0.680860] ACPI: PM: Power Resource [PTPL]=0D
[    0.682197] ACPI: PM: Power Resource [PXTC]=0D
[    0.683582] ACPI: PM: Power Resource [PXTC]=0D
[    0.687687] ACPI: PM: Power Resource [WRST]=0D
[    0.691056] ACPI: PM: Power Resource [TBT0]=0D
[    0.691345] ACPI: PM: Power Resource [TBT1]=0D
[    0.691611] ACPI: PM: Power Resource [D3C]=0D
[    1.185927] ACPI: PM: Power Resource [FN00]=0D
[    1.186017] ACPI: PM: Power Resource [FN01]=0D
[    1.186077] ACPI: PM: Power Resource [FN02]=0D
[    1.186136] ACPI: PM: Power Resource [FN03]=0D
[    1.186195] ACPI: PM: Power Resource [FN04]=0D
[    1.186723] ACPI: PM: Power Resource [PIN]=0D
[    1.187582] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-aa])=0D
[    1.187586] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI EDR HPX-Type3]=0D
[    1.190340] acpi PNP0A08:00: _OSC: platform does not support [AER]=0D
[    1.195497] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME PCIeCapability LTR DPC]=0D
[    1.199925] PCI host bridge to bus 0000:00=0D
[    1.199927] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]=0D
[    1.199928] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]=0D
[    1.199929] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]=0D
[    1.199930] pci_bus 0000:00: root bus resource [mem 0x50400000-0xbffffff=
f window]=0D
[    1.199931] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7ffff=
fffff window]=0D
[    1.199932] pci_bus 0000:00: root bus resource [bus 00-aa]=0D
[    1.201037] pci 0000:00:00.0: [8086:9a14] type 00 class 0x060000=0D
[    1.201345] pci 0000:00:02.0: [8086:9a49] type 00 class 0x030000=0D
[    1.201353] pci 0000:00:02.0: reg 0x10: [mem 0x607d000000-0x607dffffff 6=
4bit]=0D
[    1.201359] pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 6=
4bit pref]=0D
[    1.201362] pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]=0D
[    1.201377] pci 0000:00:02.0: BAR 2: assigned to efifb=0D
[    1.201378] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics=0D
[    1.201380] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]=0D
[    1.201405] pci 0000:00:02.0: reg 0x344: [mem 0x00000000-0x00ffffff 64bi=
t]=0D
[    1.201406] pci 0000:00:02.0: VF(n) BAR0 space: [mem 0x00000000-0x06ffff=
ff 64bit] (contains BAR0 for 7 VFs)=0D
[    1.201410] pci 0000:00:02.0: reg 0x34c: [mem 0x00000000-0x1fffffff 64bi=
t pref]=0D
[    1.201411] pci 0000:00:02.0: VF(n) BAR2 space: [mem 0x00000000-0xdfffff=
ff 64bit pref] (contains BAR2 for 7 VFs)=0D
[    1.201607] pci 0000:00:04.0: [8086:9a03] type 00 class 0x118000=0D
[    1.201623] pci 0000:00:04.0: reg 0x10: [mem 0x607e180000-0x607e19ffff 6=
4bit]=0D
[    1.201890] pci 0000:00:05.0: [8086:9a19] type 00 class 0x048000=0D
[    1.201897] pci 0000:00:05.0: reg 0x10: [mem 0x607c000000-0x607cffffff 6=
4bit]=0D
[    1.201910] pci 0000:00:05.0: enabling Extended Tags=0D
[    1.202078] pci 0000:00:06.0: [8086:9a09] type 01 class 0x060400=0D
[    1.202171] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold=0D
[    1.202218] pci 0000:00:06.0: PTM enabled (root), 4ns granularity=0D
[    1.204060] pci 0000:00:07.0: [8086:9a23] type 01 class 0x060400=0D
[    1.204133] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold=0D
[    1.204156] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid=0D
[    1.206007] pci 0000:00:07.1: [8086:9a25] type 01 class 0x060400=0D
[    1.206080] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold=0D
[    1.206102] pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid=0D
[    1.207942] pci 0000:00:07.2: [8086:9a27] type 01 class 0x060400=0D
[    1.208015] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold=0D
[    1.208037] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid=0D
[    1.209871] pci 0000:00:07.3: [8086:9a29] type 01 class 0x060400=0D
[    1.209943] pci 0000:00:07.3: PME# supported from D0 D3hot D3cold=0D
[    1.209970] pci 0000:00:07.3: DPC: RP PIO log size 0 is invalid=0D
[    1.211860] pci 0000:00:08.0: [8086:9a11] type 00 class 0x088000=0D
[    1.211868] pci 0000:00:08.0: reg 0x10: [mem 0x607e1ed000-0x607e1edfff 6=
4bit]=0D
[    1.211984] pci 0000:00:0a.0: [8086:9a0d] type 00 class 0x118000=0D
[    1.211992] pci 0000:00:0a.0: reg 0x10: [mem 0x607e1d0000-0x607e1d7fff 6=
4bit]=0D
[    1.212012] pci 0000:00:0a.0: enabling Extended Tags=0D
[    1.212124] pci 0000:00:0d.0: [8086:9a13] type 00 class 0x0c0330=0D
[    1.212136] pci 0000:00:0d.0: reg 0x10: [mem 0x607e1c0000-0x607e1cffff 6=
4bit]=0D
[    1.212182] pci 0000:00:0d.0: PME# supported from D3hot D3cold=0D
[    1.213966] pci 0000:00:0d.2: [8086:9a1b] type 00 class 0x0c0340=0D
[    1.213978] pci 0000:00:0d.2: reg 0x10: [mem 0x607e140000-0x607e17ffff 6=
4bit]=0D
[    1.213985] pci 0000:00:0d.2: reg 0x18: [mem 0x607e1ec000-0x607e1ecfff 6=
4bit]=0D
[    1.214020] pci 0000:00:0d.2: supports D1 D2=0D
[    1.214021] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold=
=0D
[    1.214173] pci 0000:00:0d.3: [8086:9a1d] type 00 class 0x0c0340=0D
[    1.214185] pci 0000:00:0d.3: reg 0x10: [mem 0x607e100000-0x607e13ffff 6=
4bit]=0D
[    1.214192] pci 0000:00:0d.3: reg 0x18: [mem 0x607e1eb000-0x607e1ebfff 6=
4bit]=0D
[    1.214227] pci 0000:00:0d.3: supports D1 D2=0D
[    1.214227] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold=
=0D
[    1.214504] pci 0000:00:12.0: [8086:a0fc] type 00 class 0x070000=0D
[    1.214525] pci 0000:00:12.0: reg 0x10: [mem 0x607e1b0000-0x607e1bffff 6=
4bit]=0D
[    1.214610] pci 0000:00:12.0: PME# supported from D0 D3hot=0D
[    1.216667] pci 0000:00:14.0: [8086:a0ed] type 00 class 0x0c0330=0D
[    1.216692] pci 0000:00:14.0: reg 0x10: [mem 0x607e1a0000-0x607e1affff 6=
4bit]=0D
[    1.216792] pci 0000:00:14.0: PME# supported from D3hot D3cold=0D
[    1.218563] pci 0000:00:14.2: [8086:a0ef] type 00 class 0x050000=0D
[    1.218605] pci 0000:00:14.2: reg 0x10: [mem 0x607e1dc000-0x607e1dffff 6=
4bit]=0D
[    1.218618] pci 0000:00:14.2: reg 0x18: [mem 0x607e1ea000-0x607e1eafff 6=
4bit]=0D
[    1.219322] pci 0000:00:15.0: [8086:a0e8] type 00 class 0x0c8000=0D
[    1.220102] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.223822] pci 0000:00:15.1: [8086:a0e9] type 00 class 0x0c8000=0D
[    1.224602] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.228330] pci 0000:00:15.2: [8086:a0ea] type 00 class 0x0c8000=0D
[    1.229108] pci 0000:00:15.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.232788] pci 0000:00:15.3: [8086:a0eb] type 00 class 0x0c8000=0D
[    1.233568] pci 0000:00:15.3: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.236866] pci 0000:00:16.0: [8086:a0e0] type 00 class 0x078000=0D
[    1.236891] pci 0000:00:16.0: reg 0x10: [mem 0x607e1e5000-0x607e1e5fff 6=
4bit]=0D
[    1.236996] pci 0000:00:16.0: PME# supported from D3hot=0D
[    1.239023] pci 0000:00:17.0: [8086:a0d3] type 00 class 0x010601=0D
[    1.239041] pci 0000:00:17.0: reg 0x10: [mem 0x88620000-0x88621fff]=0D
[    1.239052] pci 0000:00:17.0: reg 0x14: [mem 0x88624000-0x886240ff]=0D
[    1.239063] pci 0000:00:17.0: reg 0x18: [io  0x3080-0x3087]=0D
[    1.239073] pci 0000:00:17.0: reg 0x1c: [io  0x3088-0x308b]=0D
[    1.239108] pci 0000:00:17.0: reg 0x20: [io  0x3060-0x307f]=0D
[    1.239128] pci 0000:00:17.0: reg 0x24: [mem 0x88623000-0x886237ff]=0D
[    1.239205] pci 0000:00:17.0: PME# supported from D3hot=0D
[    1.240078] pci 0000:00:19.0: [8086:a0c5] type 00 class 0x0c8000=0D
[    1.240858] pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.244560] pci 0000:00:19.1: [8086:a0c6] type 00 class 0x0c8000=0D
[    1.245340] pci 0000:00:19.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.248635] pci 0000:00:1c.0: [8086:a0bf] type 01 class 0x060400=0D
[    1.248758] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold=0D
[    1.248800] pci 0000:00:1c.0: PTM enabled (root), 4ns granularity=0D
[    1.250004] pci 0000:00:1e.0: [8086:a0a8] type 00 class 0x078000=0D
[    1.250783] pci 0000:00:1e.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.254518] pci 0000:00:1e.3: [8086:a0ab] type 00 class 0x0c8000=0D
[    1.255270] pci 0000:00:1e.3: reg 0x10: [mem 0x00000000-0x00000fff 64bit=
]=0D
[    1.258538] pci 0000:00:1f.0: [8086:a082] type 00 class 0x060100=0D
[    1.258948] pci 0000:00:1f.3: [8086:a0c8] type 00 class 0x040100=0D
[    1.259013] pci 0000:00:1f.3: reg 0x10: [mem 0x607e1d8000-0x607e1dbfff 6=
4bit]=0D
[    1.259089] pci 0000:00:1f.3: reg 0x20: [mem 0x607e000000-0x607e0fffff 6=
4bit]=0D
[    1.259245] pci 0000:00:1f.3: PME# supported from D3hot D3cold=0D
[    1.262766] pci 0000:00:1f.4: [8086:a0a3] type 00 class 0x0c0500=0D
[    1.262793] pci 0000:00:1f.4: reg 0x10: [mem 0x607e1e0000-0x607e1e00ff 6=
4bit]=0D
[    1.262819] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]=0D
[    1.263122] pci 0000:00:1f.5: [8086:a0a4] type 00 class 0x0c8000=0D
[    1.263143] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]=0D
[    1.263345] pci 0000:00:1f.6: [8086:15fc] type 00 class 0x020000=0D
[    1.263391] pci 0000:00:1f.6: reg 0x10: [mem 0x88600000-0x8861ffff]=0D
[    1.263627] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold=0D
[    1.264263] pci 0000:01:00.0: [8086:f1a5] type 00 class 0x010802=0D
[    1.264283] pci 0000:01:00.0: reg 0x10: [mem 0x88400000-0x88403fff 64bit=
]=0D
[    1.264675] pci 0000:00:06.0: PCI bridge to [bus 01]=0D
[    1.264678] pci 0000:00:06.0:   bridge window [mem 0x88400000-0x884fffff=
]=0D
[    1.264712] pci 0000:00:07.0: PCI bridge to [bus 02-2b]=0D
[    1.264718] pci 0000:00:07.0:   bridge window [mem 0x7c000000-0x881fffff=
]=0D
[    1.264724] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bff=
ffff 64bit pref]=0D
[    1.264769] pci 0000:00:07.1: PCI bridge to [bus 2c-55]=0D
[    1.264773] pci 0000:00:07.1:   bridge window [mem 0x6e000000-0x7a1fffff=
]=0D
[    1.264777] pci 0000:00:07.1:   bridge window [mem 0x6020000000-0x603bff=
ffff 64bit pref]=0D
[    1.264822] pci 0000:00:07.2: PCI bridge to [bus 56-7f]=0D
[    1.264826] pci 0000:00:07.2:   bridge window [mem 0x60000000-0x6c1fffff=
]=0D
[    1.264829] pci 0000:00:07.2:   bridge window [mem 0x6040000000-0x605bff=
ffff 64bit pref]=0D
[    1.264874] pci 0000:00:07.3: PCI bridge to [bus 80-a9]=0D
[    1.264878] pci 0000:00:07.3:   bridge window [mem 0x52000000-0x5e1fffff=
]=0D
[    1.264881] pci 0000:00:07.3:   bridge window [mem 0x6060000000-0x607bff=
ffff 64bit pref]=0D
[    1.264991] pci 0000:aa:00.0: working around ROM BAR overlap defect=0D
[    1.264992] pci 0000:aa:00.0: [8086:1533] type 00 class 0x020000=0D
[    1.265018] pci 0000:aa:00.0: reg 0x10: [mem 0x88200000-0x882fffff]=0D
[    1.265053] pci 0000:aa:00.0: reg 0x1c: [mem 0x88300000-0x88303fff]=0D
[    1.265084] pci 0000:aa:00.0: reg 0x30: [mem 0xfff00000-0xffffffff pref]=
=0D
[    1.265199] pci 0000:aa:00.0: PME# supported from D0 D3hot D3cold=0D
[    1.265387] pci 0000:00:1c.0: PCI bridge to [bus aa]=0D
[    1.265392] pci 0000:00:1c.0:   bridge window [mem 0x88200000-0x883fffff=
]=0D
[    1.294043] Low-power S0 idle used by default for system suspend=0D
[    1.309420] ACPI: EC: interrupt unblocked=0D
[    1.309421] ACPI: EC: event unblocked=0D
[    1.309445] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62=0D
[    1.309446] ACPI: EC: GPE=3D0x6e=0D
[    1.309447] ACPI: \_SB_.PC00.LPCB.H_EC: Boot ECDT EC initialization comp=
lete=0D
[    1.309448] ACPI: \_SB_.PC00.LPCB.H_EC: EC: Used to handle transactions =
and events=0D
[    1.309556] iommu: Default domain type: Translated =0D
[    1.309556] iommu: DMA domain TLB invalidation policy: lazy mode =0D
[    1.309556] SCSI subsystem initialized=0D
[    1.309556] libata version 3.00 loaded.=0D
[    1.309556] ACPI: bus type USB registered=0D
[    1.309556] usbcore: registered new interface driver usbfs=0D
[    1.309556] usbcore: registered new interface driver hub=0D
[    1.309556] usbcore: registered new device driver usb=0D
[    1.309556] pps_core: LinuxPPS API ver. 1 registered=0D
[    1.309556] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>=0D
[    1.309556] PTP clock support registered=0D
[    1.309556] EDAC MC: Ver: 3.0.0=0D
[    1.311743] EDAC DEBUG: edac_mc_sysfs_init: device mc created=0D
[    1.311751] Registered efivars operations=0D
[    1.311751] NetLabel: Initializing=0D
[    1.311751] NetLabel:  domain hash size =3D 128=0D
[    1.311751] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO=0D
[    1.311751] NetLabel:  unlabeled traffic allowed by default=0D
[    1.311751] PCI: Using ACPI for IRQ routing=0D
[    1.316488] PCI: pci_cache_line_size set to 64 bytes=0D
[    1.317086] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010f=
ff]: no compatible bridge window=0D
[    1.317677] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]=0D
[    1.317679] e820: reserve RAM buffer [mem 0x01000000-0x03ffffff]=0D
[    1.317679] e820: reserve RAM buffer [mem 0x2b4f7000-0x2bffffff]=0D
[    1.317680] e820: reserve RAM buffer [mem 0x3d297018-0x3fffffff]=0D
[    1.317681] e820: reserve RAM buffer [mem 0x3dded000-0x3fffffff]=0D
[    1.317681] e820: reserve RAM buffer [mem 0x3de0e000-0x3fffffff]=0D
[    1.317682] e820: reserve RAM buffer [mem 0x41725000-0x43ffffff]=0D
[    1.317682] e820: reserve RAM buffer [mem 0x44c00000-0x47ffffff]=0D
[    1.317683] e820: reserve RAM buffer [mem 0x4afc00000-0x4afffffff]=0D
[    1.317689] pci 0000:00:02.0: vgaarb: setting as boot VGA device=0D
[    1.317689] pci 0000:00:02.0: vgaarb: bridge control possible=0D
[    1.317689] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone=0D
[    1.317689] vgaarb: loaded=0D
[    1.317689] clocksource: Switched to clocksource tsc-early=0D
[    1.317689] VFS: Disk quotas dquot_6.6.0=0D
[    1.317689] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)=0D
[    1.317689] pnp: PnP ACPI init=0D
[    1.317689] system 00:00: [io  0x06a4] has been reserved=0D
[    1.317689] system 00:00: [io  0x06a0] has been reserved=0D
[    1.317689] system 00:01: [io  0x0680-0x069f] has been reserved=0D
[    1.317689] system 00:01: [io  0x164e-0x164f] has been reserved=0D
[    1.317689] system 00:02: [io  0x1854-0x1857] has been reserved=0D
[    1.319642] pnp 00:04: disabling [mem 0xc0000000-0xcfffffff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]=0D
[    1.319647] pnp 00:04: disabling [mem 0x42448000-0x42457fff] because it =
overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]=0D
[    1.319680] system 00:04: [mem 0xfedc0000-0xfedc7fff] has been reserved=
=0D
[    1.319681] system 00:04: [mem 0xfeda0000-0xfeda0fff] has been reserved=
=0D
[    1.319682] system 00:04: [mem 0xfeda1000-0xfeda1fff] has been reserved=
=0D
[    1.319683] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be reser=
ved=0D
[    1.319684] system 00:04: [mem 0xfed90000-0xfed93fff] could not be reser=
ved=0D
[    1.319687] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be reser=
ved=0D
[    1.319690] system 00:04: [mem 0xfee00000-0xfeefffff] has been reserved=
=0D
[    1.322828] system 00:05: [io  0x1800-0x18fe] could not be reserved=0D
[    1.322831] system 00:05: [mem 0xfe000000-0xfe01ffff] has been reserved=
=0D
[    1.322832] system 00:05: [mem 0xfe04c000-0xfe04ffff] has been reserved=
=0D
[    1.322834] system 00:05: [mem 0xfe050000-0xfe0affff] has been reserved=
=0D
[    1.322834] system 00:05: [mem 0xfe0d0000-0xfe0fffff] has been reserved=
=0D
[    1.322835] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved=
=0D
[    1.322837] system 00:05: [mem 0xff000000-0xffffffff] could not be reser=
ved=0D
[    1.322838] system 00:05: [mem 0xfd000000-0xfd68ffff] has been reserved=
=0D
[    1.322839] system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been reserved=
=0D
[    1.322840] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved=
=0D
[    1.323103] system 00:06: [io  0x2000-0x20fe] has been reserved=0D
[    1.323354] pnp 00:08: disabling [mem 0x00000000-0x0009cfff] because it =
overlaps 0000:00:02.0 BAR 7 [mem 0x00000000-0x06ffffff 64bit]=0D
[    1.323356] pnp 00:08: disabling [mem 0x00000000-0x0009cfff disabled] be=
cause it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]=
=0D
[    1.323645] pnp: PnP ACPI: found 9 devices=0D
[    1.332228] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns=0D
[    1.332484] NET: Registered PF_INET protocol family=0D
[    1.332982] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)=0D
[    1.335661] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5,=
 131072 bytes, linear)=0D
[    1.335699] Table-perturb hash table entries: 65536 (order: 6, 262144 by=
tes, linear)=0D
[    1.335701] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)=0D
[    1.335916] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)=0D
[    1.336109] TCP: Hash tables configured (established 131072 bind 65536)=
=0D
[    1.336170] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear=
)=0D
[    1.336224] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, l=
inear)=0D
[    1.336436] NET: Registered PF_UNIX/PF_LOCAL protocol family=0D
[    1.336487] pci 0000:aa:00.0: can't claim BAR 6 [mem 0xfff00000-0xffffff=
ff pref]: no compatible bridge window=0D
[    1.336491] pci_bus 0000:00: max bus depth: 1 pci_try_num: 2=0D
[    1.336528] clipped [mem size 0x00000000 64bit pref] to [mem size 0xffff=
fffffffa0000 64bit pref] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.336532] pci 0000:00:02.0: BAR 9: assigned [mem 0x4020000000-0x40ffff=
ffff 64bit pref]=0D
[    1.336539] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.336541] pci 0000:00:02.0: BAR 7: assigned [mem 0x4010000000-0x4016ff=
ffff 64bit]=0D
[    1.336543] pci 0000:00:07.0: BAR 13: assigned [io  0x4000-0x4fff]=0D
[    1.336544] pci 0000:00:07.1: BAR 13: assigned [io  0x5000-0x5fff]=0D
[    1.336545] pci 0000:00:07.2: BAR 13: assigned [io  0x6000-0x6fff]=0D
[    1.336546] pci 0000:00:07.3: BAR 13: assigned [io  0x7000-0x7fff]=0D
[    1.336547] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.336549] pci 0000:00:15.0: BAR 0: assigned [mem 0x4017000000-0x401700=
0fff 64bit]=0D
[    1.336920] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.336922] pci 0000:00:15.1: BAR 0: assigned [mem 0x4017001000-0x401700=
1fff 64bit]=0D
[    1.337273] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.337275] pci 0000:00:15.2: BAR 0: assigned [mem 0x4017002000-0x401700=
2fff 64bit]=0D
[    1.337658] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.337660] pci 0000:00:15.3: BAR 0: assigned [mem 0x4017003000-0x401700=
3fff 64bit]=0D
[    1.338042] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.338044] pci 0000:00:19.0: BAR 0: assigned [mem 0x4017004000-0x401700=
4fff 64bit]=0D
[    1.338416] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.338418] pci 0000:00:19.1: BAR 0: assigned [mem 0x4017005000-0x401700=
5fff 64bit]=0D
[    1.338810] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.338812] pci 0000:00:1e.0: BAR 0: assigned [mem 0x4017006000-0x401700=
6fff 64bit]=0D
[    1.339216] clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffff=
ffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.339217] pci 0000:00:1e.3: BAR 0: assigned [mem 0x4017007000-0x401700=
7fff 64bit]=0D
[    1.339608] clipped [mem size 0x00020000] to [mem size 0xfffffffffffc000=
0] for e820 entry [mem 0x0009f000-0x000fffff]=0D
[    1.339610] pci 0000:00:1f.5: BAR 0: assigned [mem 0x50400000-0x50400fff=
]=0D
[    1.339638] pci 0000:00:06.0: PCI bridge to [bus 01]=0D
[    1.339649] pci 0000:00:06.0:   bridge window [mem 0x88400000-0x884fffff=
]=0D
[    1.339720] pci 0000:00:07.0: PCI bridge to [bus 02-2b]=0D
[    1.339723] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]=0D
[    1.339730] pci 0000:00:07.0:   bridge window [mem 0x7c000000-0x881fffff=
]=0D
[    1.339732] pci 0000:00:07.0:   bridge window [mem 0x6000000000-0x601bff=
ffff 64bit pref]=0D
[    1.339736] pci 0000:00:07.1: PCI bridge to [bus 2c-55]=0D
[    1.339738] pci 0000:00:07.1:   bridge window [io  0x5000-0x5fff]=0D
[    1.339740] pci 0000:00:07.1:   bridge window [mem 0x6e000000-0x7a1fffff=
]=0D
[    1.339745] pci 0000:00:07.1:   bridge window [mem 0x6020000000-0x603bff=
ffff 64bit pref]=0D
[    1.339752] pci 0000:00:07.2: PCI bridge to [bus 56-7f]=0D
[    1.339755] pci 0000:00:07.2:   bridge window [io  0x6000-0x6fff]=0D
[    1.339760] pci 0000:00:07.2:   bridge window [mem 0x60000000-0x6c1fffff=
]=0D
[    1.339764] pci 0000:00:07.2:   bridge window [mem 0x6040000000-0x605bff=
ffff 64bit pref]=0D
[    1.339772] pci 0000:00:07.3: PCI bridge to [bus 80-a9]=0D
[    1.339773] pci 0000:00:07.3:   bridge window [io  0x7000-0x7fff]=0D
[    1.339776] pci 0000:00:07.3:   bridge window [mem 0x52000000-0x5e1fffff=
]=0D
[    1.339778] pci 0000:00:07.3:   bridge window [mem 0x6060000000-0x607bff=
ffff 64bit pref]=0D
[    1.339817] pci 0000:aa:00.0: BAR 6: no space for [mem size 0x00100000 p=
ref]=0D
[    1.339818] pci 0000:aa:00.0: BAR 6: failed to assign [mem size 0x001000=
00 pref]=0D
[    1.339819] pci 0000:00:1c.0: PCI bridge to [bus aa]=0D
[    1.339842] pci 0000:00:1c.0:   bridge window [mem 0x88200000-0x883fffff=
]=0D
[    1.339908] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]=0D
[    1.339909] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]=0D
[    1.339910] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]=0D
[    1.339910] pci_bus 0000:00: resource 7 [mem 0x50400000-0xbfffffff windo=
w]=0D
[    1.339911] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff w=
indow]=0D
[    1.339913] pci_bus 0000:01: resource 1 [mem 0x88400000-0x884fffff]=0D
[    1.339914] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]=0D
[    1.339915] pci_bus 0000:02: resource 1 [mem 0x7c000000-0x881fffff]=0D
[    1.339916] pci_bus 0000:02: resource 2 [mem 0x6000000000-0x601bffffff 6=
4bit pref]=0D
[    1.339917] pci_bus 0000:2c: resource 0 [io  0x5000-0x5fff]=0D
[    1.339917] pci_bus 0000:2c: resource 1 [mem 0x6e000000-0x7a1fffff]=0D
[    1.339918] pci_bus 0000:2c: resource 2 [mem 0x6020000000-0x603bffffff 6=
4bit pref]=0D
[    1.339920] pci_bus 0000:56: resource 0 [io  0x6000-0x6fff]=0D
[    1.339921] pci_bus 0000:56: resource 1 [mem 0x60000000-0x6c1fffff]=0D
[    1.339921] pci_bus 0000:56: resource 2 [mem 0x6040000000-0x605bffffff 6=
4bit pref]=0D
[    1.339923] pci_bus 0000:80: resource 0 [io  0x7000-0x7fff]=0D
[    1.339924] pci_bus 0000:80: resource 1 [mem 0x52000000-0x5e1fffff]=0D
[    1.339925] pci_bus 0000:80: resource 2 [mem 0x6060000000-0x607bffffff 6=
4bit pref]=0D
[    1.339925] pci_bus 0000:aa: resource 1 [mem 0x88200000-0x883fffff]=0D
[    1.340265] pci 0000:00:0d.0: enabling device (0000 -> 0002)=0D
[    1.341804] PCI: CLS 128 bytes, default 64=0D
[    1.341839] DMAR: No ATSR found=0D
[    1.341839] DMAR: No SATC found=0D
[    1.341846] DMAR: IOMMU feature fl1gp_support inconsistent=0D
[    1.341849] DMAR: IOMMU feature pgsel_inv inconsistent=0D
[    1.341850] DMAR: IOMMU feature nwfs inconsistent=0D
[    1.341850] DMAR: IOMMU feature dit inconsistent=0D
[    1.341853] DMAR: IOMMU feature sc_support inconsistent=0D
[    1.341853] DMAR: IOMMU feature dev_iotlb_support inconsistent=0D
[    1.341857] DMAR: dmar5: Using Queued invalidation=0D
[    1.341867] DMAR: dmar4: Using Queued invalidation=0D
[    1.341871] DMAR: dmar3: Using Queued invalidation=0D
[    1.341882] DMAR: dmar2: Using Queued invalidation=0D
[    1.341884] DMAR: dmar1: Using Queued invalidation=0D
[    1.341885] DMAR: dmar0: Using Queued invalidation=0D
[    1.341886] DMAR: dmar6: Using Queued invalidation=0D
[    1.341910] Trying to unpack rootfs image as initramfs...=0D
[    1.342406] pci 0000:00:00.0: Adding to iommu group 0=0D
[    1.342417] pci 0000:00:02.0: Adding to iommu group 1=0D
[    1.342425] pci 0000:00:04.0: Adding to iommu group 2=0D
[    1.342457] pci 0000:00:05.0: Adding to iommu group 3=0D
[    1.342485] pci 0000:00:06.0: Adding to iommu group 4=0D
[    1.342499] pci 0000:00:07.0: Adding to iommu group 5=0D
[    1.342510] pci 0000:00:07.1: Adding to iommu group 6=0D
[    1.342535] pci 0000:00:07.2: Adding to iommu group 7=0D
[    1.342545] pci 0000:00:07.3: Adding to iommu group 8=0D
[    1.342564] pci 0000:00:08.0: Adding to iommu group 9=0D
[    1.342575] pci 0000:00:0a.0: Adding to iommu group 10=0D
[    1.342618] pci 0000:00:0d.0: Adding to iommu group 11=0D
[    1.342626] pci 0000:00:0d.2: Adding to iommu group 11=0D
[    1.342637] pci 0000:00:0d.3: Adding to iommu group 11=0D
[    1.342647] pci 0000:00:12.0: Adding to iommu group 12=0D
[    1.342662] pci 0000:00:14.0: Adding to iommu group 13=0D
[    1.342676] pci 0000:00:14.2: Adding to iommu group 13=0D
[    1.342732] pci 0000:00:15.0: Adding to iommu group 14=0D
[    1.342760] pci 0000:00:15.1: Adding to iommu group 14=0D
[    1.342771] pci 0000:00:15.2: Adding to iommu group 14=0D
[    1.342780] pci 0000:00:15.3: Adding to iommu group 14=0D
[    1.342794] pci 0000:00:16.0: Adding to iommu group 15=0D
[    1.342822] pci 0000:00:17.0: Adding to iommu group 16=0D
[    1.342840] pci 0000:00:19.0: Adding to iommu group 17=0D
[    1.342848] pci 0000:00:19.1: Adding to iommu group 17=0D
[    1.342875] pci 0000:00:1c.0: Adding to iommu group 18=0D
[    1.342891] pci 0000:00:1e.0: Adding to iommu group 19=0D
[    1.342929] pci 0000:00:1e.3: Adding to iommu group 19=0D
[    1.342959] pci 0000:00:1f.0: Adding to iommu group 20=0D
[    1.342972] pci 0000:00:1f.3: Adding to iommu group 20=0D
[    1.342981] pci 0000:00:1f.4: Adding to iommu group 20=0D
[    1.342997] pci 0000:00:1f.5: Adding to iommu group 20=0D
[    1.343004] pci 0000:00:1f.6: Adding to iommu group 20=0D
[    1.343040] pci 0000:01:00.0: Adding to iommu group 21=0D
[    1.343069] pci 0000:aa:00.0: Adding to iommu group 22=0D
[    1.347451] DMAR: Intel(R) Virtualization Technology for Directed I/O=0D
[    1.347464] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)=0D
[    1.347464] software IO TLB: mapped [mem 0x0000000038726000-0x000000003c=
726000] (64MB)=0D
[    1.347673] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff=
], which spans more than pnp 00:04 [mem 0xfedc0000-0xfedc7fff]=0D
[    1.347675] caller __uncore_imc_init_box+0xc3/0x110 mapping multiple BAR=
s=0D
[    1.347790] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x286=
80fa287f, max_idle_ns: 440795281151 ns=0D
[    1.347916] clocksource: Switched to clocksource tsc=0D
[    1.347941] platform rtc_cmos: registered platform RTC device (no PNP de=
vice found)=0D
[    1.352868] Initialise system trusted keyrings=0D
[    1.352970] Key type blacklist registered=0D
[    1.353051] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0=0D
[    1.355573] zbud: loaded=0D
[    1.356324] squashfs: version 4.0 (2009/01/31) Phillip Lougher=0D
[    1.356707] fuse: init (API version 7.36)=0D
[    1.356829] SGI XFS with ACLs, security attributes, realtime, quota, no =
debug enabled=0D
[    1.364435] Key type asymmetric registered=0D
[    1.364436] Asymmetric key parser 'x509' registered=0D
[    1.658825] Freeing initrd memory: 32204K=0D
[    1.661540] alg: self-tests for CTR-KDF (hmac(sha256)) passed=0D
[    1.661567] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 243)=0D
[    1.661612] io scheduler mq-deadline registered=0D
[    1.661622] io scheduler bfq registered=0D
[    1.662266] pcieport 0000:00:06.0: PME: Signaling with IRQ 127=0D
[    1.662503] pcieport 0000:00:07.0: PME: Signaling with IRQ 128=0D
[    1.662517] pcieport 0000:00:07.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+=0D
[    1.662845] pcieport 0000:00:07.1: PME: Signaling with IRQ 129=0D
[    1.662864] pcieport 0000:00:07.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+=0D
[    1.663140] pcieport 0000:00:07.2: PME: Signaling with IRQ 130=0D
[    1.663168] pcieport 0000:00:07.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+=0D
[    1.663389] pcieport 0000:00:07.3: PME: Signaling with IRQ 131=0D
[    1.663417] pcieport 0000:00:07.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL=
- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActR=
ep+=0D
[    1.663727] pcieport 0000:00:1c.0: PME: Signaling with IRQ 132=0D
[    1.663896] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4=
=0D
[    1.664167] Monitor-Mwait will be used to enter C-1 state=0D
[    1.664184] Monitor-Mwait will be used to enter C-2 state=0D
[    1.664191] Monitor-Mwait will be used to enter C-3 state=0D
[    1.664193] ACPI: \_SB_.PR00: Found 3 idle states=0D
[    1.664679] IPMI message handler: version 39.2=0D
[    1.664684] ipmi device interface=0D
[    1.666890] ACPI: AC: AC Adapter [ADP1] (on-line)=0D
[    1.666934] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A0=
8:00/device:1c/PNP0C09:00/PNP0C0D:00/input/input0=0D
[    1.666958] ACPI: button: Lid Switch [LID0]=0D
[    1.667014] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1=0D
[    1.667095] ACPI: button: Power Button [PWRB]=0D
[    1.667123] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input2=0D
[    1.667144] ACPI: button: Sleep Button [SLPB]=0D
[    1.671455] thermal LNXTHERM:00: registered as thermal_zone0=0D
[    1.671457] ACPI: thermal: Thermal Zone [TZ00] (37 C)=0D
[    1.671515] ERST DBG: ERST support is disabled.=0D
[    1.671888] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0D
[    1.671923] ACPI: battery: Slot [BAT0] (battery present)=0D
[    1.671971] ACPI: battery: Slot [BAT1] (battery absent)=0D
[    1.672050] ACPI: battery: Slot [BAT2] (battery absent)=0D
[    1.673291] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115=
200) is a 16550A=0D
[    1.675423] serial 0000:00:12.0: enabling device (0000 -> 0002)=0D
[    1.675859] hpet_acpi_add: no address or irqs in _CRS=0D
[    1.675879] Linux agpgart interface v0.103=0D
[    1.675920] acpi INTC6000:00: GPIO: looking up 0 in _CRS=0D
[    1.683436] ACPI: bus type drm_connector registered=0D
[    1.684236] i915 0000:00:02.0: [drm] VT-d active for gfx access=0D
[    1.684239] i915 0000:00:02.0: vgaarb: deactivate vga console=0D
[    1.684318] i915 0000:00:02.0: [drm] Using Transparent Hugepages=0D
[    1.684838] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=
=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem=0D
[    1.684958] i915 0000:00:02.0: Direct firmware load for i915/tgl_dmc_ver=
2_12.bin failed with error -2=0D
[    1.684960] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/tg=
l_dmc_ver2_12.bin. Disabling runtime power management.=0D
[    1.684961] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915=
=0D
[    1.817230] i915 0000:00:02.0: [drm] Selective fetch area calculation fa=
iled in pipe A=0D
[    1.827498] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0=0D
[    1.829117] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  =
post: no)=0D
[    1.829577] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input3=0D
[    1.833828] loop: module loaded=0D
[    1.834355] nvme 0000:01:00.0: platform quirk: setting simple suspend=0D
[    1.834401] nvme nvme0: pci function 0000:01:00.0=0D
[    1.835084] ahci 0000:00:17.0: version 3.0=0D
[    1.835713] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode=0D
[    1.835715] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slu=
m part deso sadm sds =0D
[    1.835973] scsi host0: ahci=0D
[    1.836095] ata1: SATA max UDMA/133 abar m2048@0x88623000 port 0x8862310=
0 irq 135=0D
[    1.836325] mdio_bus fixed-0: GPIO lookup for consumer reset=0D
[    1.836326] mdio_bus fixed-0: using lookup tables for GPIO lookup=0D
[    1.836327] mdio_bus fixed-0: No GPIO consumer reset found=0D
[    1.836328] tun: Universal TUN/TAP device driver, 1.6=0D
[    1.836386] igb: Intel(R) Gigabit Ethernet Network Driver=0D
[    1.836387] igb: Copyright (c) 2007-2014 Intel Corporation.=0D
[    1.836414] igb 0000:aa:00.0: enabling device (0000 -> 0002)=0D
[    1.837494] fbcon: i915drmfb (fb0) is primary device=0D
[    1.843522] nvme nvme0: 8/0/0 default/read/poll queues=0D
[    1.849761]  nvme0n1: p1 p2 p3=0D
[    1.866091] pps pps0: new PPS source ptp0=0D
[    1.866138] igb 0000:aa:00.0: added PHC on eth0=0D
[    1.866139] igb 0000:aa:00.0: Intel(R) Gigabit Ethernet Network Connecti=
on=0D
[    1.866140] igb 0000:aa:00.0: eth0: (PCIe:2.5Gb/s:Width x1) 00:1b:21:e0:=
f5:26=0D
[    1.866360] igb 0000:aa:00.0: eth0: PBA No: G69016-005=0D
[    1.866360] igb 0000:aa:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 t=
x queue(s)=0D
[    1.866390] PPP generic driver version 2.4.2=0D
[    1.866598] VFIO - User Level meta-driver version: 0.3=0D
[    1.866635] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=
=0D
[    1.866637] ehci-pci: EHCI PCI platform driver=0D
[    1.866643] ehci-platform: EHCI generic platform driver=0D
[    1.866648] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver=0D
[    1.866649] ohci-pci: OHCI PCI platform driver=0D
[    1.866667] ohci-platform: OHCI generic platform driver=0D
[    1.866671] uhci_hcd: USB Universal Host Controller Interface driver=0D
[    1.866769] xhci_hcd 0000:00:0d.0: xHCI Host Controller=0D
[    1.866773] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus =
number 1=0D
[    1.867895] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000000200009810=0D
[    1.868138] xhci_hcd 0000:00:0d.0: xHCI Host Controller=0D
[    1.868139] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus =
number 2=0D
[    1.868141] xhci_hcd 0000:00:0d.0: Host supports USB 3.1 Enhanced SuperS=
peed=0D
[    1.868161] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.00=0D
[    1.868162] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0D
[    1.868163] usb usb1: Product: xHCI Host Controller=0D
[    1.868163] usb usb1: Manufacturer: Linux 6.0.0-rc6-m xhci-hcd=0D
[    1.868164] usb usb1: SerialNumber: 0000:00:0d.0=0D
[    1.868425] hub 1-0:1.0: USB hub found=0D
[    1.868445] hub 1-0:1.0: 1 port detected=0D
[    1.868521] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.00=0D
[    1.868523] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0D
[    1.868523] usb usb2: Product: xHCI Host Controller=0D
[    1.868524] usb usb2: Manufacturer: Linux 6.0.0-rc6-m xhci-hcd=0D
[    1.868524] usb usb2: SerialNumber: 0000:00:0d.0=0D
[    1.868717] hub 2-0:1.0: USB hub found=0D
[    1.868726] hub 2-0:1.0: 4 ports detected=0D
[    1.870204] xhci_hcd 0000:00:14.0: xHCI Host Controller=0D
[    1.870206] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 3=0D
[    1.871403] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x1=
20 quirks 0x0000000000009810=0D
[    1.871736] xhci_hcd 0000:00:14.0: xHCI Host Controller=0D
[    1.871737] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 4=0D
[    1.871738] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperS=
peed=0D
[    1.871774] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 6.00=0D
[    1.871775] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0D
[    1.871775] usb usb3: Product: xHCI Host Controller=0D
[    1.871776] usb usb3: Manufacturer: Linux 6.0.0-rc6-m xhci-hcd=0D
[    1.871776] usb usb3: SerialNumber: 0000:00:14.0=0D
[    1.872016] hub 3-0:1.0: USB hub found=0D
[    1.872044] hub 3-0:1.0: 12 ports detected=0D
[    1.874543] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 6.00=0D
[    1.874545] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1=0D
[    1.874546] usb usb4: Product: xHCI Host Controller=0D
[    1.874546] usb usb4: Manufacturer: Linux 6.0.0-rc6-m xhci-hcd=0D
[    1.874547] usb usb4: SerialNumber: 0000:00:14.0=0D
[    1.874822] hub 4-0:1.0: USB hub found=0D
[    1.874844] hub 4-0:1.0: 4 ports detected=0D
[    1.875381] usb: port power management may be unreliable=0D
[    1.875716] usbcore: registered new interface driver uas=0D
[    1.875724] usbcore: registered new interface driver usb-storage=0D
[    1.875760] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq =
1=0D
[    1.875761] i8042: PNP: PS/2 appears to have AUX port disabled, if this =
is incorrect please boot with i8042.nopnp=0D
[    1.876057] i8042: Warning: Keylock active=0D
[    1.876286] serio: i8042 KBD port at 0x60,0x64 irq 1=0D
[    1.876583] mousedev: PS/2 mouse device common for all mice=0D
[    1.877038] rtc_cmos rtc_cmos: RTC can wake from S4=0D
[    1.878902] rtc_cmos rtc_cmos: registered as rtc0=0D
[    1.879279] rtc_cmos rtc_cmos: setting system clock to 2022-09-23T12:00:=
31 UTC (1663934431)=0D
[    1.879282] rtc_cmos rtc_cmos: GPIO lookup for consumer wp=0D
[    1.879283] rtc_cmos rtc_cmos: using lookup tables for GPIO lookup=0D
[    1.879284] rtc_cmos rtc_cmos: No GPIO consumer wp found=0D
[    1.879303] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nv=
ram=0D
[    1.879306] i2c_dev: i2c /dev entries driver=0D
[    1.880311] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. =
Duplicate IMA measurements will not be recorded in the IMA log.=0D
[    1.880376] device-mapper: uevent: version 1.0.3=0D
[    1.880493] device-mapper: ioctl: 4.47.0-ioctl (2022-07-28) initialised:=
 dm-devel@redhat.com=0D
[    1.880496] intel_pstate: Intel P-state driver initializing=0D
[    1.881029] intel_pstate: HWP enabled=0D
[    1.881057] sdhci: Secure Digital Host Controller Interface driver=0D
[    1.881058] sdhci: Copyright(c) Pierre Ossman=0D
[    1.881076] sdhci-pltfm: SDHCI platform and OF driver helper=0D
[    1.881104] ledtrig-cpu: registered to indicate activity on CPUs=0D
[    1.881170] pstore: Registered efi as persistent store backend=0D
[    1.881626] intel_pmc_core INT33A1:00:  initialized=0D
[    1.881775] drop_monitor: Initializing network drop monitor service=0D
[    1.882090] NET: Registered PF_INET6 protocol family=0D
[    1.884927] Segment Routing with IPv6=0D
[    1.884956] In-situ OAM (IOAM) with IPv6=0D
[    1.884966] NET: Registered PF_PACKET protocol family=0D
[    1.885039] 9pnet: Installing 9P2000 support=0D
[    1.885072] Key type dns_resolver registered=0D
[    1.885823] microcode: sig=3D0x806c1, pf=3D0x80, revision=3D0xa4=0D
[    1.885966] microcode: Microcode Update Driver: v2.2.=0D
[    1.886119] resctrl: L2 allocation detected=0D
[    1.886121] IPI shorthand broadcast: enabled=0D
[    1.886132] sched_clock: Marking stable (1869151386, 16961562)->(1912629=
940, -26516992)=0D
[    1.886563] registered taskstats version 1=0D
[    1.886791] Loading compiled-in X.509 certificates=0D
[    1.886960] zswap: loaded using pool lzo/zbud=0D
[    1.887171] Key type ._fscrypt registered=0D
[    1.887172] Key type .fscrypt registered=0D
[    1.887173] Key type fscrypt-provisioning registered=0D
[    1.887240] pstore: Using crash dump compression: deflate=0D
[    1.887503] Key type trusted registered=0D
[    1.889697] Key type encrypted registered=0D
[    1.889797] ima: Allocated hash algorithm: sha1=0D
[    1.923546] ima: No architecture policies found=0D
[    1.923552] evm: Initialising EVM extended attributes:=0D
[    1.923552] evm: security.selinux=0D
[    1.923553] evm: security.SMACK64=0D
[    1.923553] evm: security.SMACK64EXEC=0D
[    1.923553] evm: security.SMACK64TRANSMUTE=0D
[    1.923553] evm: security.SMACK64MMAP=0D
[    1.923554] evm: security.apparmor=0D
[    1.923554] evm: security.ima=0D
[    1.923554] evm: security.capability=0D
[    1.923554] evm: HMAC attrs: 0x1=0D
[    1.926326] PM:   Magic number: 6:979:26=0D
[    1.926385] acpi SER0002:00: hash matches=0D
[    1.926430] memory memory66: hash matches=0D
[    1.926564] RAS: Correctable Errors collector initialized.=0D
[    2.099071] atkbd serio0: Failed to deactivate keyboard on isa0060/serio=
0=0D
[    2.126974] usb 3-8: new low-speed USB device number 2 using xhci_hcd=0D
[    2.151841] ata1: SATA link down (SStatus 4 SControl 300)=0D
[    2.281415] usb 3-8: New USB device found, idVendor=3D413c, idProduct=3D=
2107, bcdDevice=3D 1.04=0D
[    2.281418] usb 3-8: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0=0D
[    2.281418] usb 3-8: Product: Dell USB Entry Keyboard=0D
[    2.281419] usb 3-8: Manufacturer: DELL=0D
[    2.407070] usb 3-9: new high-speed USB device number 3 using xhci_hcd=
=0D
[    2.479086] atkbd serio0: Failed to enable keyboard on isa0060/serio0=0D
[    2.479133] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input4=0D
[    2.556975] usb 3-9: New USB device found, idVendor=3D05e3, idProduct=3D=
0608, bcdDevice=3D85.36=0D
[    2.556978] usb 3-9: New USB device strings: Mfr=3D0, Product=3D1, Seria=
lNumber=3D0=0D
[    2.556979] usb 3-9: Product: USB2.0 Hub=0D
[    2.558430] hub 3-9:1.0: USB hub found=0D
[    2.558859] hub 3-9:1.0: 4 ports detected=0D
[    2.847099] usb 3-9.1: new high-speed USB device number 4 using xhci_hcd=
=0D
[    2.961654] usb 3-9.1: New USB device found, idVendor=3D0b95, idProduct=
=3D772b, bcdDevice=3D 0.02=0D
[    2.961657] usb 3-9.1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3=0D
[    2.961658] usb 3-9.1: Product: AX88772C=0D
[    2.961659] usb 3-9.1: Manufacturer: ASIX Elec. Corp.=0D
[    2.961659] usb 3-9.1: SerialNumber: 000B10=0D
[    2.991490] Console: switching to colour frame buffer device 480x135=0D
[    3.017525] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device=
=0D
[    3.027281] Freeing unused decrypted memory: 2036K=0D
[    3.027629] Freeing unused kernel image (initmem) memory: 3284K=0D
[    3.027630] Write protecting the kernel read-only data: 30720k=0D
[    3.028137] Freeing unused kernel image (text/rodata gap) memory: 2032K=
=0D
[    3.028389] Freeing unused kernel image (rodata/data gap) memory: 1264K=
=0D
[    3.034170] x86/mm: Checked W+X mappings: passed, no W+X pages found.=0D
[    3.034174] Run /init as init process=0D
[    3.034175]   with arguments:=0D
[    3.034176]     /init=0D
[    3.034176]     rhgb=0D
[    3.034177]   with environment:=0D
[    3.034177]     HOME=3D/=0D
[    3.034178]     TERM=3Dlinux=0D
[    3.034178]     BOOT_IMAGE=3D(hd0,gpt2)/vmlinuz-6.0.0-rc6-m=0D
[    3.044247] systemd[1]: systemd v250.7-1.fc36 running in system mode (+P=
AM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL =
+ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +L=
IBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BP=
F_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)=0D
[    3.044326] systemd[1]: Detected architecture x86-64.=0D
[    3.044327] systemd[1]: Running in initial RAM disk.=0D
[    3.044342] systemd[1]: Hostname set to <fedora-36>.=0D
[    3.106273] systemd[1]: BPF LSM hook not enabled in the kernel, LSM BPF =
not supported=0D
[    3.139789] systemd[1]: Queued start job for default target initrd.targe=
t.=0D
[    3.139877] systemd[1]: Reached target initrd-usr-fs.target - Initrd /us=
r File System.=0D
[    3.139924] systemd[1]: Reached target local-fs.target - Local File Syst=
ems.=0D
[    3.139944] systemd[1]: Reached target slices.target - Slice Units.=0D
[    3.139962] systemd[1]: Reached target swap.target - Swaps.=0D
[    3.139979] systemd[1]: Reached target timers.target - Timer Units.=0D
[    3.140080] systemd[1]: Listening on dbus.socket - D-Bus System Message =
Bus Socket.=0D
[    3.140153] systemd[1]: Listening on systemd-journald-audit.socket - Jou=
rnal Audit Socket.=0D
[    3.140234] systemd[1]: Listening on systemd-journald-dev-log.socket - J=
ournal Socket (/dev/log).=0D
[    3.140326] systemd[1]: Listening on systemd-journald.socket - Journal S=
ocket.=0D
[    3.140395] systemd[1]: Listening on systemd-udevd-control.socket - udev=
 Control Socket.=0D
[    3.140443] systemd[1]: Listening on systemd-udevd-kernel.socket - udev =
Kernel Socket.=0D
[    3.140459] systemd[1]: Reached target sockets.target - Socket Units.=0D
[    3.171874] systemd[1]: Starting kmod-static-nodes.service - Create List=
 of Static Device Nodes...=0D
[    3.171906] systemd[1]: memstrack.service - Memstrack Anylazing Service =
was skipped because all trigger condition checks failed.=0D
[    3.173007] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...=0D
[    3.173678] systemd[1]: Starting systemd-modules-load.service - Load Ker=
nel Modules...=0D
[    3.174527] systemd[1]: Starting systemd-sysusers.service - Create Syste=
m Users...=0D
[    3.175169] systemd[1]: Starting systemd-vconsole-setup.service - Setup =
Virtual Console...=0D
[    3.176267] systemd[1]: Finished kmod-static-nodes.service - Create List=
 of Static Device Nodes.=0D
[    3.178321] systemd[1]: Finished systemd-modules-load.service - Load Ker=
nel Modules.=0D
[    3.179031] systemd[1]: Starting systemd-sysctl.service - Apply Kernel V=
ariables...=0D
[    3.181776] systemd[1]: Finished systemd-sysusers.service - Create Syste=
m Users.=0D
[    3.181830] audit: type=3D1130 audit(1663934432.796:2): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysusers comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'=0D
[    3.183063] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Cr=
eate Static Device Nodes in /dev...=0D
[    3.184094] systemd[1]: Finished systemd-sysctl.service - Apply Kernel V=
ariables.=0D
[    3.184121] audit: type=3D1130 audit(1663934432.800:3): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'=0D
[    3.186029] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Cr=
eate Static Device Nodes in /dev.=0D
[    3.186053] audit: type=3D1130 audit(1663934432.800:4): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup-dev=
 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? te=
rminal=3D? res=3Dsuccess'=0D
[    3.209411] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.=0D
[    3.209482] audit: type=3D1130 audit(1663934432.824:5): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'=0D
[    3.214694] audit: type=3D1130 audit(1663934432.828:6): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'=0D
[    3.226908] audit: type=3D1130 audit(1663934432.840:7): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-vconsole-setup com=
m=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termin=
al=3D? res=3Dsuccess'=0D
[    3.235734] audit: type=3D1130 audit(1663934432.852:8): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddracut-cmdline-ask comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'=0D
[    3.268946] audit: type=3D1130 audit(1663934432.884:9): pid=3D1 uid=3D0 =
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddracut-cmdline comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'=0D
[    3.342932] raid6: avx512x4 gen() 74096 MB/s=0D
[    3.410932] raid6: avx512x2 gen() 80554 MB/s=0D
[    3.478932] raid6: avx512x1 gen() 73769 MB/s=0D
[    3.546932] raid6: avx2x4   gen() 62345 MB/s=0D
[    3.614933] raid6: avx2x2   gen() 62367 MB/s=0D
[    3.682932] raid6: avx2x1   gen() 50432 MB/s=0D
[    3.682933] raid6: using algorithm avx512x2 gen() 80554 MB/s=0D
[    3.750932] raid6: .... xor() 47505 MB/s, rmw enabled=0D
[    3.750933] raid6: using avx512x2 recovery algorithm=0D
[    3.751461] xor: automatically using best checksumming function   avx   =
    =0D
[    3.780884] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes, fsverity=
=3Dno=0D
[    3.786113] audit: type=3D1130 audit(1663934433.400:10): pid=3D1 uid=3D0=
 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddracut-pre-udev comm=3D"s=
ystemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?=
 res=3Dsuccess'=0D
[    3.883066] tigerlake-pinctrl INT34C5:00: Community0 features: 0x000003=
=0D
[    3.883215] tigerlake-pinctrl INT34C5:00: Community1 features: 0x00000f=
=0D
[    3.883353] tigerlake-pinctrl INT34C5:00: Community2 features: 0x000007=
=0D
[    3.883467] tigerlake-pinctrl INT34C5:00: Community3 features: 0x000003=
=0D
[    3.883508] tigerlake-pinctrl INT34C5:00: try to register 277 pins ...=
=0D
[    3.883510] pinctrl core: registered pin 0 (CORE_VID_0) on INT34C5:00=0D
[    3.883512] pinctrl core: registered pin 1 (CORE_VID_1) on INT34C5:00=0D
[    3.883513] pinctrl core: registered pin 2 (VRALERTB) on INT34C5:00=0D
[    3.883514] pinctrl core: registered pin 3 (CPU_GP_2) on INT34C5:00=0D
[    3.883527] pinctrl core: registered pin 4 (CPU_GP_3) on INT34C5:00=0D
[    3.883528] pinctrl core: registered pin 5 (ISH_I2C0_SDA) on INT34C5:00=
=0D
[    3.883530] pinctrl core: registered pin 6 (ISH_I2C0_SCL) on INT34C5:00=
=0D
[    3.883531] pinctrl core: registered pin 7 (ISH_I2C1_SDA) on INT34C5:00=
=0D
[    3.883532] pinctrl core: registered pin 8 (ISH_I2C1_SCL) on INT34C5:00=
=0D
[    3.883533] pinctrl core: registered pin 9 (I2C5_SDA) on INT34C5:00=0D
[    3.883534] pinctrl core: registered pin 10 (I2C5_SCL) on INT34C5:00=0D
[    3.883535] pinctrl core: registered pin 11 (PMCALERTB) on INT34C5:00=0D
[    3.883537] pinctrl core: registered pin 12 (SLP_S0B) on INT34C5:00=0D
[    3.883538] pinctrl core: registered pin 13 (PLTRSTB) on INT34C5:00=0D
[    3.883539] pinctrl core: registered pin 14 (SPKR) on INT34C5:00=0D
[    3.883540] pinctrl core: registered pin 15 (GSPI0_CS0B) on INT34C5:00=
=0D
[    3.883541] pinctrl core: registered pin 16 (GSPI0_CLK) on INT34C5:00=0D
[    3.883543] pinctrl core: registered pin 17 (GSPI0_MISO) on INT34C5:00=
=0D
[    3.883544] pinctrl core: registered pin 18 (GSPI0_MOSI) on INT34C5:00=
=0D
[    3.883547] pinctrl core: registered pin 19 (GSPI1_CS0B) on INT34C5:00=
=0D
[    3.883548] pinctrl core: registered pin 20 (GSPI1_CLK) on INT34C5:00=0D
[    3.883550] pinctrl core: registered pin 21 (GSPI1_MISO) on INT34C5:00=
=0D
[    3.883551] pinctrl core: registered pin 22 (GSPI1_MOSI) on INT34C5:00=
=0D
[    3.883553] pinctrl core: registered pin 23 (SML1ALERTB) on INT34C5:00=
=0D
[    3.883554] pinctrl core: registered pin 24 (GSPI0_CLK_LOOPBK) on INT34C=
5:00=0D
[    3.883555] pinctrl core: registered pin 25 (GSPI1_CLK_LOOPBK) on INT34C=
5:00=0D
[    3.883556] pinctrl core: registered pin 26 (I2C6_SDA) on INT34C5:00=0D
[    3.883570] pinctrl core: registered pin 27 (I2C6_SCL) on INT34C5:00=0D
[    3.883571] pinctrl core: registered pin 28 (I2C7_SDA) on INT34C5:00=0D
[    3.883572] pinctrl core: registered pin 29 (I2C7_SCL) on INT34C5:00=0D
[    3.883573] pinctrl core: registered pin 30 (UART4_RXD) on INT34C5:00=0D
[    3.883574] pinctrl core: registered pin 31 (UART4_TXD) on INT34C5:00=0D
[    3.883575] pinctrl core: registered pin 32 (UART4_RTSB) on INT34C5:00=
=0D
[    3.883576] pinctrl core: registered pin 33 (UART4_CTSB) on INT34C5:00=
=0D
[    3.883577] pinctrl core: registered pin 34 (UART5_RXD) on INT34C5:00=0D
[    3.883578] pinctrl core: registered pin 35 (UART5_TXD) on INT34C5:00=0D
[    3.883579] pinctrl core: registered pin 36 (UART5_RTSB) on INT34C5:00=
=0D
[    3.883580] pinctrl core: registered pin 37 (UART5_CTSB) on INT34C5:00=
=0D
[    3.883581] pinctrl core: registered pin 38 (UART6_RXD) on INT34C5:00=0D
[    3.883582] pinctrl core: registered pin 39 (UART6_TXD) on INT34C5:00=0D
[    3.883583] pinctrl core: registered pin 40 (UART6_RTSB) on INT34C5:00=
=0D
[    3.883584] pinctrl core: registered pin 41 (UART6_CTSB) on INT34C5:00=
=0D
[    3.883598] pinctrl core: registered pin 42 (ESPI_IO_0) on INT34C5:00=0D
[    3.883599] pinctrl core: registered pin 43 (ESPI_IO_1) on INT34C5:00=0D
[    3.883600] pinctrl core: registered pin 44 (ESPI_IO_2) on INT34C5:00=0D
[    3.883601] pinctrl core: registered pin 45 (ESPI_IO_3) on INT34C5:00=0D
[    3.883602] pinctrl core: registered pin 46 (ESPI_CSB) on INT34C5:00=0D
[    3.883603] pinctrl core: registered pin 47 (ESPI_CLK) on INT34C5:00=0D
[    3.883604] pinctrl core: registered pin 48 (ESPI_RESETB) on INT34C5:00=
=0D
[    3.883605] pinctrl core: registered pin 49 (I2S2_SCLK) on INT34C5:00=0D
[    3.883606] pinctrl core: registered pin 50 (I2S2_SFRM) on INT34C5:00=0D
[    3.883607] pinctrl core: registered pin 51 (I2S2_TXD) on INT34C5:00=0D
[    3.883608] pinctrl core: registered pin 52 (I2S2_RXD) on INT34C5:00=0D
[    3.883609] pinctrl core: registered pin 53 (PMC_I2C_SDA) on INT34C5:00=
=0D
[    3.883610] pinctrl core: registered pin 54 (SATAXPCIE_1) on INT34C5:00=
=0D
[    3.883611] pinctrl core: registered pin 55 (PMC_I2C_SCL) on INT34C5:00=
=0D
[    3.883613] pinctrl core: registered pin 56 (USB2_OCB_1) on INT34C5:00=
=0D
[    3.883616] pinctrl core: registered pin 57 (USB2_OCB_2) on INT34C5:00=
=0D
[    3.883617] pinctrl core: registered pin 58 (USB2_OCB_3) on INT34C5:00=
=0D
[    3.883619] pinctrl core: registered pin 59 (DDSP_HPD_C) on INT34C5:00=
=0D
[    3.883622] pinctrl core: registered pin 60 (DDSP_HPD_B) on INT34C5:00=
=0D
[    3.883623] pinctrl core: registered pin 61 (DDSP_HPD_1) on INT34C5:00=
=0D
[    3.883636] pinctrl core: registered pin 62 (DDSP_HPD_2) on INT34C5:00=
=0D
[    3.883637] pinctrl core: registered pin 63 (GPPC_A_21) on INT34C5:00=0D
[    3.883642] pinctrl core: registered pin 64 (GPPC_A_22) on INT34C5:00=0D
[    3.883643] pinctrl core: registered pin 65 (I2S1_SCLK) on INT34C5:00=0D
[    3.883645] pinctrl core: registered pin 66 (ESPI_CLK_LOOPBK) on INT34C5=
:00=0D
[    3.883646] pinctrl core: registered pin 67 (SNDW0_CLK) on INT34C5:00=0D
[    3.883667] pinctrl core: registered pin 68 (SNDW0_DATA) on INT34C5:00=
=0D
[    3.883668] pinctrl core: registered pin 69 (SNDW1_CLK) on INT34C5:00=0D
[    3.883669] pinctrl core: registered pin 70 (SNDW1_DATA) on INT34C5:00=
=0D
[    3.883682] pinctrl core: registered pin 71 (SNDW2_CLK) on INT34C5:00=0D
[    3.883684] pinctrl core: registered pin 72 (SNDW2_DATA) on INT34C5:00=
=0D
[    3.883685] pinctrl core: registered pin 73 (SNDW3_CLK) on INT34C5:00=0D
[    3.883686] pinctrl core: registered pin 74 (SNDW3_DATA) on INT34C5:00=
=0D
[    3.883687] pinctrl core: registered pin 75 (GPPC_H_0) on INT34C5:00=0D
[    3.883688] pinctrl core: registered pin 76 (GPPC_H_1) on INT34C5:00=0D
[    3.883689] pinctrl core: registered pin 77 (GPPC_H_2) on INT34C5:00=0D
[    3.883690] pinctrl core: registered pin 78 (SX_EXIT_HOLDOFFB) on INT34C=
5:00=0D
[    3.883691] pinctrl core: registered pin 79 (I2C2_SDA) on INT34C5:00=0D
[    3.883692] pinctrl core: registered pin 80 (I2C2_SCL) on INT34C5:00=0D
[    3.883693] pinctrl core: registered pin 81 (I2C3_SDA) on INT34C5:00=0D
[    3.883694] pinctrl core: registered pin 82 (I2C3_SCL) on INT34C5:00=0D
[    3.883695] pinctrl core: registered pin 83 (I2C4_SDA) on INT34C5:00=0D
[    3.883696] pinctrl core: registered pin 84 (I2C4_SCL) on INT34C5:00=0D
[    3.883697] pinctrl core: registered pin 85 (SRCCLKREQB_4) on INT34C5:00=
=0D
[    3.883698] pinctrl core: registered pin 86 (SRCCLKREQB_5) on INT34C5:00=
=0D
[    3.883699] pinctrl core: registered pin 87 (M2_SKT2_CFG_0) on INT34C5:0=
0=0D
[    3.883700] pinctrl core: registered pin 88 (M2_SKT2_CFG_1) on INT34C5:0=
0=0D
[    3.883703] pinctrl core: registered pin 89 (M2_SKT2_CFG_2) on INT34C5:0=
0=0D
[    3.883707] pinctrl core: registered pin 90 (M2_SKT2_CFG_3) on INT34C5:0=
0=0D
[    3.883710] pinctrl core: registered pin 91 (DDPB_CTRLCLK) on INT34C5:00=
=0D
[    3.883723] pinctrl core: registered pin 92 (DDPB_CTRLDATA) on INT34C5:0=
0=0D
[    3.883724] pinctrl core: registered pin 93 (CPU_C10_GATEB) on INT34C5:0=
0=0D
[    3.883726] pinctrl core: registered pin 94 (TIME_SYNC_0) on INT34C5:00=
=0D
[    3.883727] pinctrl core: registered pin 95 (IMGCLKOUT_1) on INT34C5:00=
=0D
[    3.883728] pinctrl core: registered pin 96 (IMGCLKOUT_2) on INT34C5:00=
=0D
[    3.883729] pinctrl core: registered pin 97 (IMGCLKOUT_3) on INT34C5:00=
=0D
[    3.883730] pinctrl core: registered pin 98 (IMGCLKOUT_4) on INT34C5:00=
=0D
[    3.883731] pinctrl core: registered pin 99 (ISH_GP_0) on INT34C5:00=0D
[    3.883732] pinctrl core: registered pin 100 (ISH_GP_1) on INT34C5:00=0D
[    3.883732] pinctrl core: registered pin 101 (ISH_GP_2) on INT34C5:00=0D
[    3.883733] pinctrl core: registered pin 102 (ISH_GP_3) on INT34C5:00=0D
[    3.883734] pinctrl core: registered pin 103 (IMGCLKOUT_0) on INT34C5:00=
=0D
[    3.883735] pinctrl core: registered pin 104 (SRCCLKREQB_0) on INT34C5:0=
0=0D
[    3.883736] pinctrl core: registered pin 105 (SRCCLKREQB_1) on INT34C5:0=
0=0D
[    3.883737] pinctrl core: registered pin 106 (SRCCLKREQB_2) on INT34C5:0=
0=0D
[    3.883739] pinctrl core: registered pin 107 (SRCCLKREQB_3) on INT34C5:0=
0=0D
[    3.883752] pinctrl core: registered pin 108 (ISH_SPI_CSB) on INT34C5:00=
=0D
[    3.883753] pinctrl core: registered pin 109 (ISH_SPI_CLK) on INT34C5:00=
=0D
[    3.883757] pinctrl core: registered pin 110 (ISH_SPI_MISO) on INT34C5:0=
0=0D
[    3.883758] pinctrl core: registered pin 111 (ISH_SPI_MOSI) on INT34C5:0=
0=0D
[    3.883759] pinctrl core: registered pin 112 (ISH_UART0_RXD) on INT34C5:=
00=0D
[    3.883760] pinctrl core: registered pin 113 (ISH_UART0_TXD) on INT34C5:=
00=0D
[    3.883761] pinctrl core: registered pin 114 (ISH_UART0_RTSB) on INT34C5=
:00=0D
[    3.883762] pinctrl core: registered pin 115 (ISH_UART0_CTSB) on INT34C5=
:00=0D
[    3.883763] pinctrl core: registered pin 116 (ISH_GP_4) on INT34C5:00=0D
[    3.883764] pinctrl core: registered pin 117 (ISH_GP_5) on INT34C5:00=0D
[    3.883765] pinctrl core: registered pin 118 (I2S_MCLK1_OUT) on INT34C5:=
00=0D
[    3.883766] pinctrl core: registered pin 119 (GSPI2_CLK_LOOPBK) on INT34=
C5:00=0D
[    3.883768] pinctrl core: registered pin 120 (UART3_RXD) on INT34C5:00=
=0D
[    3.883769] pinctrl core: registered pin 121 (UART3_TXD) on INT34C5:00=
=0D
[    3.883771] pinctrl core: registered pin 122 (UART3_RTSB) on INT34C5:00=
=0D
[    3.883772] pinctrl core: registered pin 123 (UART3_CTSB) on INT34C5:00=
=0D
[    3.883773] pinctrl core: registered pin 124 (GSPI3_CS0B) on INT34C5:00=
=0D
[    3.883774] pinctrl core: registered pin 125 (GSPI3_CLK) on INT34C5:00=
=0D
[    3.883775] pinctrl core: registered pin 126 (GSPI3_MISO) on INT34C5:00=
=0D
[    3.883776] pinctrl core: registered pin 127 (GSPI3_MOSI) on INT34C5:00=
=0D
[    3.883776] pinctrl core: registered pin 128 (GSPI4_CS0B) on INT34C5:00=
=0D
[    3.883777] pinctrl core: registered pin 129 (GSPI4_CLK) on INT34C5:00=
=0D
[    3.883793] pinctrl core: registered pin 130 (GSPI4_MISO) on INT34C5:00=
=0D
[    3.883794] pinctrl core: registered pin 131 (GSPI4_MOSI) on INT34C5:00=
=0D
[    3.883809] pinctrl core: registered pin 132 (GSPI5_CS0B) on INT34C5:00=
=0D
[    3.883811] pinctrl core: registered pin 133 (GSPI5_CLK) on INT34C5:00=
=0D
[    3.883812] pinctrl core: registered pin 134 (GSPI5_MISO) on INT34C5:00=
=0D
[    3.883812] pinctrl core: registered pin 135 (GSPI5_MOSI) on INT34C5:00=
=0D
[    3.883813] pinctrl core: registered pin 136 (GSPI6_CS0B) on INT34C5:00=
=0D
[    3.883814] pinctrl core: registered pin 137 (GSPI6_CLK) on INT34C5:00=
=0D
[    3.883815] pinctrl core: registered pin 138 (GSPI6_MISO) on INT34C5:00=
=0D
[    3.883816] pinctrl core: registered pin 139 (GSPI6_MOSI) on INT34C5:00=
=0D
[    3.883817] pinctrl core: registered pin 140 (GSPI3_CLK_LOOPBK) on INT34=
C5:00=0D
[    3.883819] pinctrl core: registered pin 141 (GSPI4_CLK_LOOPBK) on INT34=
C5:00=0D
[    3.883831] pinctrl core: registered pin 142 (GSPI5_CLK_LOOPBK) on INT34=
C5:00=0D
[    3.883833] pinctrl core: registered pin 143 (GSPI6_CLK_LOOPBK) on INT34=
C5:00=0D
[    3.883834] pinctrl core: registered pin 144 (CNV_BTEN) on INT34C5:00=0D
[    3.883835] pinctrl core: registered pin 145 (CNV_BT_HOST_WAKEB) on INT3=
4C5:00=0D
[    3.883836] pinctrl core: registered pin 146 (CNV_BT_IF_SELECT) on INT34=
C5:00=0D
[    3.883837] pinctrl core: registered pin 147 (vCNV_BT_UART_TXD) on INT34=
C5:00=0D
[    3.883838] pinctrl core: registered pin 148 (vCNV_BT_UART_RXD) on INT34=
C5:00=0D
[    3.883839] pinctrl core: registered pin 149 (vCNV_BT_UART_CTS_B) on INT=
34C5:00=0D
[    3.883840] pinctrl core: registered pin 150 (vCNV_BT_UART_RTS_B) on INT=
34C5:00=0D
[    3.883841] pinctrl core: registered pin 151 (vCNV_MFUART1_TXD) on INT34=
C5:00=0D
[    3.883842] pinctrl core: registered pin 152 (vCNV_MFUART1_RXD) on INT34=
C5:00=0D
[    3.883843] pinctrl core: registered pin 153 (vCNV_MFUART1_CTS_B) on INT=
34C5:00=0D
[    3.883844] pinctrl core: registered pin 154 (vCNV_MFUART1_RTS_B) on INT=
34C5:00=0D
[    3.883872] pinctrl core: registered pin 155 (vUART0_TXD) on INT34C5:00=
=0D
[    3.883873] pinctrl core: registered pin 156 (vUART0_RXD) on INT34C5:00=
=0D
[    3.883874] pinctrl core: registered pin 157 (vUART0_CTS_B) on INT34C5:0=
0=0D
[    3.883875] pinctrl core: registered pin 158 (vUART0_RTS_B) on INT34C5:0=
0=0D
[    3.883876] pinctrl core: registered pin 159 (vISH_UART0_TXD) on INT34C5=
:00=0D
[    3.883877] pinctrl core: registered pin 160 (vISH_UART0_RXD) on INT34C5=
:00=0D
[    3.883878] pinctrl core: registered pin 161 (vISH_UART0_CTS_B) on INT34=
C5:00=0D
[    3.883879] pinctrl core: registered pin 162 (vISH_UART0_RTS_B) on INT34=
C5:00=0D
[    3.883880] pinctrl core: registered pin 163 (vCNV_BT_I2S_BCLK) on INT34=
C5:00=0D
[    3.883881] pinctrl core: registered pin 164 (vCNV_BT_I2S_WS_SYNC) on IN=
T34C5:00=0D
[    3.883882] pinctrl core: registered pin 165 (vCNV_BT_I2S_SDO) on INT34C=
5:00=0D
[    3.883883] pinctrl core: registered pin 166 (vCNV_BT_I2S_SDI) on INT34C=
5:00=0D
[    3.883884] pinctrl core: registered pin 167 (vI2S2_SCLK) on INT34C5:00=
=0D
[    3.883885] pinctrl core: registered pin 168 (vI2S2_SFRM) on INT34C5:00=
=0D
[    3.883886] pinctrl core: registered pin 169 (vI2S2_TXD) on INT34C5:00=
=0D
[    3.883887] pinctrl core: registered pin 170 (vI2S2_RXD) on INT34C5:00=
=0D
[    3.883888] pinctrl core: registered pin 171 (SMBCLK) on INT34C5:00=0D
[    3.883889] pinctrl core: registered pin 172 (SMBDATA) on INT34C5:00=0D
[    3.883890] pinctrl core: registered pin 173 (SMBALERTB) on INT34C5:00=
=0D
[    3.883893] pinctrl core: registered pin 174 (SML0CLK) on INT34C5:00=0D
[    3.883894] pinctrl core: registered pin 175 (SML0DATA) on INT34C5:00=0D
[    3.883896] pinctrl core: registered pin 176 (SML0ALERTB) on INT34C5:00=
=0D
[    3.883897] pinctrl core: registered pin 177 (SML1CLK) on INT34C5:00=0D
[    3.883900] pinctrl core: registered pin 178 (SML1DATA) on INT34C5:00=0D
[    3.883912] pinctrl core: registered pin 179 (UART0_RXD) on INT34C5:00=
=0D
[    3.883914] pinctrl core: registered pin 180 (UART0_TXD) on INT34C5:00=
=0D
[    3.883915] pinctrl core: registered pin 181 (UART0_RTSB) on INT34C5:00=
=0D
[    3.883916] pinctrl core: registered pin 182 (UART0_CTSB) on INT34C5:00=
=0D
[    3.883917] pinctrl core: registered pin 183 (UART1_RXD) on INT34C5:00=
=0D
[    3.883918] pinctrl core: registered pin 184 (UART1_TXD) on INT34C5:00=
=0D
[    3.883918] pinctrl core: registered pin 185 (UART1_RTSB) on INT34C5:00=
=0D
[    3.883919] pinctrl core: registered pin 186 (UART1_CTSB) on INT34C5:00=
=0D
[    3.883920] pinctrl core: registered pin 187 (I2C0_SDA) on INT34C5:00=0D
[    3.883921] pinctrl core: registered pin 188 (I2C0_SCL) on INT34C5:00=0D
[    3.883923] pinctrl core: registered pin 189 (I2C1_SDA) on INT34C5:00=0D
[    3.883924] pinctrl core: registered pin 190 (I2C1_SCL) on INT34C5:00=0D
[    3.883926] pinctrl core: registered pin 191 (UART2_RXD) on INT34C5:00=
=0D
[    3.883927] pinctrl core: registered pin 192 (UART2_TXD) on INT34C5:00=
=0D
[    3.883928] pinctrl core: registered pin 193 (UART2_RTSB) on INT34C5:00=
=0D
[    3.883929] pinctrl core: registered pin 194 (UART2_CTSB) on INT34C5:00=
=0D
[    3.883930] pinctrl core: registered pin 195 (CNV_BRI_DT) on INT34C5:00=
=0D
[    3.883948] pinctrl core: registered pin 196 (CNV_BRI_RSP) on INT34C5:00=
=0D
[    3.883949] pinctrl core: registered pin 197 (CNV_RGI_DT) on INT34C5:00=
=0D
[    3.883950] pinctrl core: registered pin 198 (CNV_RGI_RSP) on INT34C5:00=
=0D
[    3.883950] pinctrl core: registered pin 199 (CNV_RF_RESET_B) on INT34C5=
:00=0D
[    3.883952] pinctrl core: registered pin 200 (GPPC_F_5) on INT34C5:00=0D
[    3.883954] pinctrl core: registered pin 201 (CNV_PA_BLANKING) on INT34C=
5:00=0D
[    3.883955] pinctrl core: registered pin 202 (GPPC_F_7) on INT34C5:00=0D
[    3.883956] pinctrl core: registered pin 203 (I2S_MCLK2_INOUT) on INT34C=
5:00=0D
[    3.883958] pinctrl core: registered pin 204 (BOOTMPC) on INT34C5:00=0D
[    3.883959] pinctrl core: registered pin 205 (GPPC_F_10) on INT34C5:00=
=0D
[    3.883961] pinctrl core: registered pin 206 (GPPC_F_11) on INT34C5:00=
=0D
[    3.883962] pinctrl core: registered pin 207 (GSXDOUT) on INT34C5:00=0D
[    3.883963] pinctrl core: registered pin 208 (GSXSLOAD) on INT34C5:00=0D
[    3.883963] pinctrl core: registered pin 209 (GSXDIN) on INT34C5:00=0D
[    3.883964] pinctrl core: registered pin 210 (GSXSRESETB) on INT34C5:00=
=0D
[    3.883967] pinctrl core: registered pin 211 (GSXCLK) on INT34C5:00=0D
[    3.883968] pinctrl core: registered pin 212 (GMII_MDC) on INT34C5:00=0D
[    3.883969] pinctrl core: registered pin 213 (GMII_MDIO) on INT34C5:00=
=0D
[    3.883971] pinctrl core: registered pin 214 (SRCCLKREQB_6) on INT34C5:0=
0=0D
[    3.883983] pinctrl core: registered pin 215 (EXT_PWR_GATEB) on INT34C5:=
00=0D
[    3.883985] pinctrl core: registered pin 216 (EXT_PWR_GATE2B) on INT34C5=
:00=0D
[    3.883986] pinctrl core: registered pin 217 (VNN_CTRL) on INT34C5:00=0D
[    3.883987] pinctrl core: registered pin 218 (V1P05_CTRL) on INT34C5:00=
=0D
[    3.883988] pinctrl core: registered pin 219 (GPPF_CLK_LOOPBACK) on INT3=
4C5:00=0D
[    3.883989] pinctrl core: registered pin 220 (L_BKLTEN) on INT34C5:00=0D
[    3.883990] pinctrl core: registered pin 221 (L_BKLTCTL) on INT34C5:00=
=0D
[    3.883991] pinctrl core: registered pin 222 (L_VDDEN) on INT34C5:00=0D
[    3.883992] pinctrl core: registered pin 223 (SYS_PWROK) on INT34C5:00=
=0D
[    3.883993] pinctrl core: registered pin 224 (SYS_RESETB) on INT34C5:00=
=0D
[    3.883994] pinctrl core: registered pin 225 (MLK_RSTB) on INT34C5:00=0D
[    3.883995] pinctrl core: registered pin 226 (SATAXPCIE_0) on INT34C5:00=
=0D
[    3.883996] pinctrl core: registered pin 227 (SPI1_IO_2) on INT34C5:00=
=0D
[    3.883997] pinctrl core: registered pin 228 (SPI1_IO_3) on INT34C5:00=
=0D
[    3.883998] pinctrl core: registered pin 229 (CPU_GP_0) on INT34C5:00=0D
[    3.883999] pinctrl core: registered pin 230 (SATA_DEVSLP_0) on INT34C5:=
00=0D
[    3.884012] pinctrl core: registered pin 231 (SATA_DEVSLP_1) on INT34C5:=
00=0D
[    3.884013] pinctrl core: registered pin 232 (GPPC_E_6) on INT34C5:00=0D
[    3.884014] pinctrl core: registered pin 233 (CPU_GP_1) on INT34C5:00=0D
[    3.884015] pinctrl core: registered pin 234 (SPI1_CS1B) on INT34C5:00=
=0D
[    3.884016] pinctrl core: registered pin 235 (USB2_OCB_0) on INT34C5:00=
=0D
[    3.884017] pinctrl core: registered pin 236 (SPI1_CSB) on INT34C5:00=0D
[    3.884018] pinctrl core: registered pin 237 (SPI1_CLK) on INT34C5:00=0D
[    3.884019] pinctrl core: registered pin 238 (SPI1_MISO_IO_1) on INT34C5=
:00=0D
[    3.884020] pinctrl core: registered pin 239 (SPI1_MOSI_IO_0) on INT34C5=
:00=0D
[    3.884021] pinctrl core: registered pin 240 (DDSP_HPD_A) on INT34C5:00=
=0D
[    3.884022] pinctrl core: registered pin 241 (ISH_GP_6) on INT34C5:00=0D
[    3.884023] pinctrl core: registered pin 242 (ISH_GP_7) on INT34C5:00=0D
[    3.884036] pinctrl core: registered pin 243 (GPPC_E_17) on INT34C5:00=
=0D
[    3.884037] pinctrl core: registered pin 244 (DDP1_CTRLCLK) on INT34C5:0=
0=0D
[    3.884038] pinctrl core: registered pin 245 (DDP1_CTRLDATA) on INT34C5:=
00=0D
[    3.884041] pinctrl core: registered pin 246 (DDP2_CTRLCLK) on INT34C5:0=
0=0D
[    3.884042] pinctrl core: registered pin 247 (DDP2_CTRLDATA) on INT34C5:=
00=0D
[    3.884043] pinctrl core: registered pin 248 (DDPA_CTRLCLK) on INT34C5:0=
0=0D
[    3.884044] pinctrl core: registered pin 249 (DDPA_CTRLDATA) on INT34C5:=
00=0D
[    3.884047] pinctrl core: registered pin 250 (SPI1_CLK_LOOPBK) on INT34C=
5:00=0D
[    3.884048] pinctrl core: registered pin 251 (JTAG_TDO) on INT34C5:00=0D
[    3.884048] pinctrl core: registered pin 252 (JTAGX) on INT34C5:00=0D
[    3.884050] pinctrl core: registered pin 253 (PRDYB) on INT34C5:00=0D
[    3.884051] pinctrl core: registered pin 254 (PREQB) on INT34C5:00=0D
[    3.884052] pinctrl core: registered pin 255 (CPU_TRSTB) on INT34C5:00=
=0D
[    3.884053] pinctrl core: registered pin 256 (JTAG_TDI) on INT34C5:00=0D
[    3.884054] pinctrl core: registered pin 257 (JTAG_TMS) on INT34C5:00=0D
[    3.884055] pinctrl core: registered pin 258 (JTAG_TCK) on INT34C5:00=0D
[    3.884056] pinctrl core: registered pin 259 (DBG_PMODE) on INT34C5:00=
=0D
[    3.884084] pinctrl core: registered pin 260 (HDA_BCLK) on INT34C5:00=0D
[    3.884085] pinctrl core: registered pin 261 (HDA_SYNC) on INT34C5:00=0D
[    3.884086] pinctrl core: registered pin 262 (HDA_SDO) on INT34C5:00=0D
[    3.884087] pinctrl core: registered pin 263 (HDA_SDI_0) on INT34C5:00=
=0D
[    3.884088] pinctrl core: registered pin 264 (HDA_RSTB) on INT34C5:00=0D
[    3.884089] pinctrl core: registered pin 265 (HDA_SDI_1) on INT34C5:00=
=0D
[    3.884090] pinctrl core: registered pin 266 (GPP_R_6) on INT34C5:00=0D
[    3.884091] pinctrl core: registered pin 267 (GPP_R_7) on INT34C5:00=0D
[    3.884092] pinctrl core: registered pin 268 (SPI0_IO_2) on INT34C5:00=
=0D
[    3.884093] pinctrl core: registered pin 269 (SPI0_IO_3) on INT34C5:00=
=0D
[    3.884095] pinctrl core: registered pin 270 (SPI0_MOSI_IO_0) on INT34C5=
:00=0D
[    3.884098] pinctrl core: registered pin 271 (SPI0_MISO_IO_1) on INT34C5=
:00=0D
[    3.884099] pinctrl core: registered pin 272 (SPI0_TPM_CSB) on INT34C5:0=
0=0D
[    3.884100] pinctrl core: registered pin 273 (SPI0_FLASH_0_CSB) on INT34=
C5:00=0D
[    3.884101] pinctrl core: registered pin 274 (SPI0_FLASH_1_CSB) on INT34=
C5:00=0D
[    3.884102] pinctrl core: registered pin 275 (SPI0_CLK) on INT34C5:00=0D
[    3.884102] pinctrl core: registered pin 276 (SPI0_CLK_LOOPBK) on INT34C=
5:00=0D
[    3.884104] tigerlake-pinctrl INT34C5:00: failed to lookup the default s=
tate=0D
[    3.884117] tigerlake-pinctrl INT34C5:00: failed to lookup the sleep sta=
te=0D
[    3.884237] gpiochip_find_base: found new base at 664=0D
[    3.891082] gpio gpiochip0: (INT34C5:00): created GPIO range 0->25 =3D=
=3D> INT34C5:00 PIN 0->25=0D
[    3.891085] gpio gpiochip0: (INT34C5:00): created GPIO range 32->47 =3D=
=3D> INT34C5:00 PIN 26->41=0D
[    3.891086] gpio gpiochip0: (INT34C5:00): created GPIO range 64->88 =3D=
=3D> INT34C5:00 PIN 42->66=0D
[    3.891113] gpio gpiochip0: (INT34C5:00): created GPIO range 96->103 =3D=
=3D> INT34C5:00 PIN 67->74=0D
[    3.891115] gpio gpiochip0: (INT34C5:00): created GPIO range 128->151 =
=3D=3D> INT34C5:00 PIN 75->98=0D
[    3.891116] gpio gpiochip0: (INT34C5:00): created GPIO range 160->180 =
=3D=3D> INT34C5:00 PIN 99->119=0D
[    3.891118] gpio gpiochip0: (INT34C5:00): created GPIO range 192->215 =
=3D=3D> INT34C5:00 PIN 120->143=0D
[    3.891119] gpio gpiochip0: (INT34C5:00): created GPIO range 224->250 =
=3D=3D> INT34C5:00 PIN 144->170=0D
[    3.891120] gpio gpiochip0: (INT34C5:00): created GPIO range 256->279 =
=3D=3D> INT34C5:00 PIN 171->194=0D
[    3.891122] gpio gpiochip0: (INT34C5:00): created GPIO range 288->312 =
=3D=3D> INT34C5:00 PIN 195->219=0D
[    3.891123] gpio gpiochip0: (INT34C5:00): created GPIO range 320->344 =
=3D=3D> INT34C5:00 PIN 226->250=0D
[    3.891125] gpio gpiochip0: (INT34C5:00): created GPIO range 352->359 =
=3D=3D> INT34C5:00 PIN 260->267=0D
[    3.891324] gpio gpiochip0: (INT34C5:00): added GPIO chardev (254:0)=0D
[    3.891404] gpio gpiochip0: registered GPIOs 664 to 1023 on INT34C5:00=
=0D
[    3.951466] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)=0D
[    3.952450] hid: raw HID events driver (C) Jiri Kosina=0D
[    3.956391] igb 0000:aa:00.0 enp170s0: renamed from eth0=0D
[    3.957777] usbcore: registered new interface driver usbhid=0D
[    3.957779] usbhid: USB HID core driver=0D
[    3.962760] e1000e: Intel(R) PRO/1000 Network Driver=0D
[    3.962763] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.=0D
[    3.962819] e1000e 0000:00:1f.6: enabling device (0000 -> 0002)=0D
[    3.963666] usbcore: registered new interface driver usbkbd=0D
[    3.964178] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode=0D
[    3.996639] BTRFS: device label fedora_localhost-live devid 1 transid 19=
326 /dev/nvme0n1p3 scanned by systemd-udevd (389)=0D
[    4.012610] cryptd: max_cpu_qlen set to 1000=0D
[    4.015691] AVX2 version of gcm_enc/dec engaged.=0D
[    4.015844] AES CTR mode by8 optimization enabled=0D
[    4.082414] input: DELL Dell USB Entry Keyboard as /devices/pci0000:00/0=
000:00:14.0/usb3/3-8/3-8:1.0/0003:413C:2107.0001/input/input5=0D
[    4.143334] hid-generic 0003:413C:2107.0001: input,hidraw0: USB HID v1.1=
1 Keyboard [DELL Dell USB Entry Keyboard] on usb-0000:00:14.0-8/input0=0D
[    4.196733] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock=0D
[    4.269263] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 88:=
88:88:88:87:88=0D
[    4.269266] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on=0D
[    4.269454] e1000e 0000:00:1f.6 eth0: MAC: 14, PHY: 12, PBA No: FFFFFF-0=
FF=0D
[    4.274626] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0=0D
[    4.375827] mdio_bus usb-003:004: GPIO lookup for consumer reset=0D
[    4.375831] mdio_bus usb-003:004: using lookup tables for GPIO lookup=0D
[    4.375832] mdio_bus usb-003:004: No GPIO consumer reset found=0D
[    4.427426] mdio_bus usb-003:004:10: GPIO lookup for consumer reset=0D
[    4.427428] mdio_bus usb-003:004:10: using lookup tables for GPIO lookup=
=0D
[    4.427429] mdio_bus usb-003:004:10: No GPIO consumer reset found=0D
[    4.473252] Generic PHY usb-003:004:10: attached PHY driver (mii_bus:phy=
_addr=3Dusb-003:004:10, irq=3DPOLL)=0D
[    4.473395] asix 3-9.1:1.0 eth0: register 'asix' at usb-0000:00:14.0-9.1=
, ASIX AX88772B USB 2.0 Ethernet, 00:0e:c6:a5:e7:01=0D
[    4.473411] usbcore: registered new interface driver asix=0D
[    4.475552] asix 3-9.1:1.0 enp0s20f0u9u1: renamed from eth0=0D
[    4.677711] ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: [hid-ish]: e=
num_devices_done OK, num_hid_devices=3D6=0D
[    4.686703] hid-generic 001F:8087:0AC2.0002: hidraw1: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on =0D
[    4.696478] hid-generic 001F:8087:0AC2.0003: hidraw2: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on =0D
[    4.705566] hid-generic 001F:8087:0AC2.0004: hidraw3: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on =0D
[    4.715202] hid-generic 001F:8087:0AC2.0005: hidraw4: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on =0D
[    4.723955] hid-generic 001F:8087:0AC2.0006: hidraw5: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC2] on =0D
[    4.727428] BTRFS info (device nvme0n1p3): using crc32c (crc32c-intel) c=
hecksum algorithm=0D
[    4.727434] BTRFS info (device nvme0n1p3): using free space tree=0D
[    4.734140] hid-generic 001F:8087:0AC3.0007: hidraw6: SENSOR HUB HID v2.=
00 Device [hid-ishtp 8087:0AC3] on =0D
[    4.753108] BTRFS info (device nvme0n1p3): enabling ssd optimizations=0D
[    4.978052] typec port0: bound usb3-port1 (ops connector_ops)=0D
[    4.978060] typec port0: bound usb2-port1 (ops connector_ops)=0D
[    5.061789] systemd-journald[252]: Received SIGTERM from PID 1 (systemd)=
.=0D
[    5.131775] systemd[1]: RTC configured in localtime, applying delta of 4=
80 minutes to system time.=0D
[    5.136290] systemd[1]: systemd v250.7-1.fc36 running in system mode (+P=
AM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL =
+ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +L=
IBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BP=
F_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)=0D
[    5.136508] systemd[1]: Detected architecture x86-64.=0D
[    5.154222] kauditd_printk_skb: 42 callbacks suppressed=0D
[    5.154225] audit: type=3D1334 audit(1663905634.768:53): prog-id=3D27 op=
=3DLOAD=0D
[    5.154226] audit: type=3D1334 audit(1663905634.768:54): prog-id=3D0 op=
=3DUNLOAD=0D
[    5.154227] audit: type=3D1334 audit(1663905634.768:55): prog-id=3D28 op=
=3DLOAD=0D
[    5.154228] audit: type=3D1334 audit(1663905634.768:56): prog-id=3D0 op=
=3DUNLOAD=0D
[    5.156573] audit: type=3D1334 audit(1663905634.772:57): prog-id=3D29 op=
=3DLOAD=0D
[    5.156576] audit: type=3D1334 audit(1663905634.772:58): prog-id=3D0 op=
=3DUNLOAD=0D
[    5.156577] audit: type=3D1334 audit(1663905634.772:59): prog-id=3D30 op=
=3DLOAD=0D
[    5.156577] audit: type=3D1334 audit(1663905634.772:60): prog-id=3D0 op=
=3DUNLOAD=0D
[    5.156651] audit: type=3D1334 audit(1663905634.772:61): prog-id=3D31 op=
=3DLOAD=0D
[    5.156654] audit: type=3D1334 audit(1663905634.772:62): prog-id=3D0 op=
=3DUNLOAD=0D
[    5.179261] systemd[1]: BPF LSM hook not enabled in the kernel, LSM BPF =
not supported=0D
[    5.302256] systemd-sysv-generator[570]: SysV service '/etc/rc.d/init.d/=
livesys' lacks a native systemd unit file. Automatically generating a unit =
file for compatibility. Please update package to include a native systemd u=
nit file, in order to make it more safe and robust.=0D
[    5.302297] systemd-sysv-generator[570]: SysV service '/etc/rc.d/init.d/=
livesys-late' lacks a native systemd unit file. Automatically generating a =
unit file for compatibility. Please update package to include a native syst=
emd unit file, in order to make it more safe and robust.=0D
[    5.998946] random: crng init done=0D
[    6.012590] zram: Added device: zram0=0D
[    6.058160] typec port1: bound usb3-port5 (ops connector_ops)=0D
[    6.058172] typec port1: bound usb2-port2 (ops connector_ops)=0D
[    6.096136] systemd[1]: initrd-switch-root.service: Deactivated successf=
ully.=0D
[    6.096186] systemd[1]: Stopped initrd-switch-root.service - Switch Root=
.=0D
[    6.096400] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.=0D
[    6.096501] systemd[1]: Created slice machine.slice - Virtual Machine an=
d Container Slice.=0D
[    6.096690] systemd[1]: Created slice system-getty.slice - Slice /system=
/getty.=0D
[    6.096851] systemd[1]: Created slice system-modprobe.slice - Slice /sys=
tem/modprobe.=0D
[    6.097010] systemd[1]: Created slice system-sshd\x2dkeygen.slice - Slic=
e /system/sshd-keygen.=0D
[    6.097162] systemd[1]: Created slice system-systemd\x2dfsck.slice - Sli=
ce /system/systemd-fsck.=0D
[    6.097313] systemd[1]: Created slice system-systemd\x2dzram\x2dsetup.sl=
ice - Slice /system/systemd-zram-setup.=0D
[    6.097430] systemd[1]: Created slice user.slice - User and Session Slic=
e.=0D
[    6.097442] systemd[1]: systemd-ask-password-console.path - Dispatch Pas=
sword Requests to Console Directory Watch was skipped because of a failed c=
ondition check (ConditionPathExists=3D!/run/plymouth/pid).=0D
[    6.097483] systemd[1]: Started systemd-ask-password-wall.path - Forward=
 Password Requests to Wall Directory Watch.=0D
[    6.097582] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automou=
nt - Arbitrary Executable File Formats File System Automount Point.=0D
[    6.097598] systemd[1]: Reached target cryptsetup.target - Local Encrypt=
ed Volumes.=0D
[    6.097613] systemd[1]: Reached target getty.target - Login Prompts.=0D
[    6.097626] systemd[1]: Stopped target initrd-switch-root.target - Switc=
h Root.=0D
[    6.097638] systemd[1]: Stopped target initrd-fs.target - Initrd File Sy=
stems.=0D
[    6.097674] systemd[1]: Stopped target initrd-root-fs.target - Initrd Ro=
ot File System.=0D
[    6.097702] systemd[1]: Reached target integritysetup.target - Local Int=
egrity Protected Volumes.=0D
[    6.097736] systemd[1]: Reached target slices.target - Slice Units.=0D
[    6.097760] systemd[1]: Reached target veritysetup.target - Local Verity=
 Protected Volumes.=0D
[    6.097888] systemd[1]: Listening on dm-event.socket - Device-mapper eve=
nt daemon FIFOs.=0D
[    6.097973] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll da=
emon socket.=0D
[    6.098434] systemd[1]: Listening on systemd-coredump.socket - Process C=
ore Dump Socket.=0D
[    6.098467] systemd[1]: Listening on systemd-initctl.socket - initctl Co=
mpatibility Named Pipe.=0D
[    6.098726] systemd[1]: Listening on systemd-oomd.socket - Userspace Out=
-Of-Memory (OOM) Killer Socket.=0D
[    6.098967] systemd[1]: Listening on systemd-udevd-control.socket - udev=
 Control Socket.=0D
[    6.099023] systemd[1]: Listening on systemd-udevd-kernel.socket - udev =
Kernel Socket.=0D
[    6.099215] systemd[1]: Listening on systemd-userdbd.socket - User Datab=
ase Manager Socket.=0D
[    6.131796] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File S=
ystem...=0D
[    6.132342] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue =
File System...=0D
[    6.132840] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug F=
ile System...=0D
[    6.133256] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace=
 File System...=0D
[    6.133400] systemd[1]: auth-rpcgss-module.service - Kernel Module suppo=
rting RPCSEC_GSS was skipped because of a failed condition check (Condition=
PathExists=3D/etc/krb5.keytab).=0D
[    6.133970] systemd[1]: Starting kmod-static-nodes.service - Create List=
 of Static Device Nodes...=0D
[    6.134428] systemd[1]: Starting lvm2-monitor.service - Monitoring of LV=
M2 mirrors, snapshots etc. using dmeventd or progress polling...=0D
[    6.134916] systemd[1]: Starting modprobe@configfs.service - Load Kernel=
 Module configfs...=0D
[    6.135426] systemd[1]: Starting modprobe@drm.service - Load Kernel Modu=
le drm...=0D
[    6.135930] systemd[1]: Starting modprobe@fuse.service - Load Kernel Mod=
ule fuse...=0D
[    6.136480] systemd[1]: Starting nfs-convert.service - Preprocess NFS co=
nfiguration convertion...=0D
[    6.136542] systemd[1]: plymouth-switch-root.service: Deactivated succes=
sfully.=0D
[    6.136580] systemd[1]: Stopped plymouth-switch-root.service - Plymouth =
switch root service.=0D
[    6.136755] systemd[1]: systemd-fsck-root.service: Deactivated successfu=
lly.=0D
[    6.136776] systemd[1]: Stopped systemd-fsck-root.service - File System =
Check on Root Device.=0D
[    6.136844] systemd[1]: Stopped systemd-journald.service - Journal Servi=
ce.=0D
[    6.137733] systemd[1]: Starting systemd-journald.service - Journal Serv=
ice...=0D
[    6.138279] systemd[1]: Starting systemd-modules-load.service - Load Ker=
nel Modules...=0D
[    6.138736] systemd[1]: Starting systemd-network-generator.service - Gen=
erate network units from Kernel command line...=0D
[    6.139203] systemd[1]: Starting systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems...=0D
[    6.139264] systemd[1]: systemd-repart.service - Repartition Root Disk w=
as skipped because all trigger condition checks failed.=0D
[    6.139726] systemd[1]: Starting systemd-udev-trigger.service - Coldplug=
 All udev Devices...=0D
[    6.140650] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File Sy=
stem.=0D
[    6.140744] systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue F=
ile System.=0D
[    6.140823] systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug Fi=
le System.=0D
[    6.140897] systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace =
File System.=0D
[    6.141053] systemd[1]: Finished kmod-static-nodes.service - Create List=
 of Static Device Nodes.=0D
[    6.141230] systemd[1]: modprobe@configfs.service: Deactivated successfu=
lly.=0D
[    6.141290] systemd[1]: Finished modprobe@configfs.service - Load Kernel=
 Module configfs.=0D
[    6.141409] systemd[1]: modprobe@drm.service: Deactivated successfully.=
=0D
[    6.141469] systemd[1]: Finished modprobe@drm.service - Load Kernel Modu=
le drm.=0D
[    6.141628] systemd[1]: modprobe@fuse.service: Deactivated successfully.=
=0D
[    6.141705] systemd[1]: Finished modprobe@fuse.service - Load Kernel Mod=
ule fuse.=0D
[    6.141847] systemd[1]: nfs-convert.service: Deactivated successfully.=
=0D
[    6.141901] systemd[1]: Finished nfs-convert.service - Preprocess NFS co=
nfiguration convertion.=0D
[    6.142026] systemd[1]: Finished systemd-network-generator.service - Gen=
erate network units from Kernel command line.=0D
[    6.142508] systemd[1]: Mounting sys-fs-fuse-connections.mount - FUSE Co=
ntrol File System...=0D
[    6.142958] systemd[1]: Mounting sys-kernel-config.mount - Kernel Config=
uration File System...=0D
[    6.143031] BTRFS info (device nvme0n1p3: state M): use zstd compression=
, level 1=0D
[    6.143034] BTRFS info (device nvme0n1p3: state M): using free space tre=
e=0D
[    6.144029] systemd[1]: Finished systemd-modules-load.service - Load Ker=
nel Modules.=0D
[    6.144162] systemd[1]: Finished systemd-remount-fs.service - Remount Ro=
ot and Kernel File Systems.=0D
[    6.144243] systemd[1]: Mounted sys-fs-fuse-connections.mount - FUSE Con=
trol File System.=0D
[    6.144294] systemd[1]: Mounted sys-kernel-config.mount - Kernel Configu=
ration File System.=0D
[    6.144343] systemd[1]: iscsi-onboot.service - Special handling of early=
 boot iSCSI sessions was skipped because of a failed condition check (Condi=
tionDirectoryNotEmpty=3D/sys/class/iscsi_session).=0D
[    6.144359] systemd[1]: ostree-remount.service - OSTree Remount OS/ Bind=
 Mounts was skipped because of a failed condition check (ConditionKernelCom=
mandLine=3Dostree).=0D
[    6.144381] systemd[1]: systemd-firstboot.service - First Boot Wizard wa=
s skipped because of a failed condition check (ConditionFirstBoot=3Dyes).=
=0D
[    6.145086] systemd[1]: systemd-hwdb-update.service - Rebuild Hardware D=
atabase was skipped because of a failed condition check (ConditionNeedsUpda=
te=3D/etc).=0D
[    6.145571] systemd[1]: Starting systemd-random-seed.service - Load/Save=
 Random Seed...=0D
[    6.146089] systemd[1]: Starting systemd-sysctl.service - Apply Kernel V=
ariables...=0D
[    6.146140] systemd[1]: systemd-sysusers.service - Create System Users w=
as skipped because of a failed condition check (ConditionNeedsUpdate=3D/etc=
).=0D
[    6.146629] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Cr=
eate Static Device Nodes in /dev...=0D
[    6.146766] systemd-journald[590]: File /run/log/journal/9434decd581a4c9=
f8bbc9fbc819ae807/system.journal corrupted or uncleanly shut down, renaming=
 and replacing.=0D
[    6.153188] systemd[1]: Started systemd-journald.service - Journal Servi=
ce.=0D
[    6.161971] systemd-journald[590]: Received client request to flush runt=
ime journal.=0D
[    6.294695] Consider using thermal netlink events interface=0D
[    6.297767] input: Intel HID events as /devices/platform/INTC1051:00/inp=
ut/input6=0D
[    6.297908] intel-hid INTC1051:00: platform supports 5 button array=0D
[    6.297929] input: Intel HID 5 button array as /devices/platform/INTC105=
1:00/input/input7=0D
[    6.483716] EDAC DEBUG: igen6_init: =0D
[    6.483736] EDAC DEBUG: igen6_probe: =0D
[    6.483737] EDAC DEBUG: igen6_pci_setup: =0D
[    6.483739] EDAC DEBUG: igen6_pci_setup: No In-Band ECC IP=0D
[    6.483763] EDAC igen6: v2.5=0D
[    6.491732] proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)=0D
[    6.494551] intel_rapl_common: Found RAPL domain package=0D
[    6.500287] ACPI: bus type thunderbolt registered=0D
[    6.641390] mei_me 0000:00:16.0: enabling device (0000 -> 0002)=0D
[    6.659001] intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)=0D
[    6.659656] idma64 idma64.0: Found Intel integrated DMA 64-bit=0D
[    6.772379] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mo=
de. Quota mode: none.=0D
[    6.810575] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)=0D
[    6.810794] i801_smbus 0000:00:1f.4: SPD Write Disable is set=0D
[    6.810902] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt=0D
[    6.822349] snd_hda_intel 0000:00:1f.3: DSP detected with PCI class/subc=
lass/prog-if info 0x040100=0D
[    6.822650] snd_hda_intel 0000:00:1f.3: SoundWire enabled on CannonLake+=
 platform, using SOF driver=0D
[    6.823313] i2c_designware i2c_designware.0: GPIO lookup for consumer sc=
l=0D
[    6.823315] i2c_designware i2c_designware.0: using ACPI for GPIO lookup=
=0D
[    6.823316] acpi device:83: GPIO: looking up scl-gpios=0D
[    6.823318] acpi device:83: GPIO: looking up scl-gpio=0D
[    6.823318] i2c_designware i2c_designware.0: using lookup tables for GPI=
O lookup=0D
[    6.823319] i2c_designware i2c_designware.0: No GPIO consumer scl found=
=0D
[    6.835991] i2c i2c-14: 2/2 memory slots populated (from DMI)=0D
[    6.836661] i2c i2c-14: Successfully instantiated SPD at 0x50=0D
[    6.880607] input: PC Speaker as /devices/platform/pcspkr/input/input8=
=0D
[    6.881030] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI =
class/subclass/prog-if info 0x040100=0D
[    6.881155] sof-audio-pci-intel-tgl 0000:00:1f.3: SoundWire enabled on C=
annonLake+ platform, using SOF driver=0D
[    6.881167] sof-audio-pci-intel-tgl 0000:00:1f.3: enabling device (0000 =
-> 0002)=0D
[    6.881289] sof-audio-pci-intel-tgl 0000:00:1f.3: DSP detected with PCI =
class/subclass/prog-if 0x040100=0D
[    6.881348] sof-audio-pci-intel-tgl 0000:00:1f.3: bound 0000:00:02.0 (op=
s i915_audio_component_bind_ops)=0D
[    6.888063] sof-audio-pci-intel-tgl 0000:00:1f.3: use msi interrupt mode=
=0D
[    6.931102] intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)=0D
[    6.931495] idma64 idma64.1: Found Intel integrated DMA 64-bit=0D
[    6.940818] sof-audio-pci-intel-tgl 0000:00:1f.3: No SoundWire machine d=
river found=0D
[    6.940820] sof-audio-pci-intel-tgl 0000:00:1f.3: hda codecs found, mask=
 4=0D
[    6.940821] sof-audio-pci-intel-tgl 0000:00:1f.3: using HDA machine driv=
er skl_hda_dsp_generic now=0D
[    6.940824] sof-audio-pci-intel-tgl 0000:00:1f.3: DMICs detected in NHLT=
 tables: 4=0D
[    6.943560] sof-audio-pci-intel-tgl 0000:00:1f.3: Direct firmware load f=
or intel/sof/sof-tgl.ri failed with error -2=0D
[    6.943563] sof-audio-pci-intel-tgl 0000:00:1f.3: error: sof firmware fi=
le is missing, you might need to=0D
[    6.945611] sof-audio-pci-intel-tgl 0000:00:1f.3:        download it fro=
m https://github.com/thesofproject/sof-bin/=0D
[    6.947831] sof-audio-pci-intel-tgl 0000:00:1f.3: error: failed to load =
DSP firmware -2=0D
[    6.950352] sof-audio-pci-intel-tgl 0000:00:1f.3: error: sof_probe_work =
failed err: -2=0D
[    6.978637] i2c_designware i2c_designware.1: GPIO lookup for consumer sc=
l=0D
[    6.978641] i2c_designware i2c_designware.1: using ACPI for GPIO lookup=
=0D
[    6.978645] acpi device:84: GPIO: looking up scl-gpios=0D
[    6.978656] acpi device:84: GPIO: looking up scl-gpio=0D
[    6.978658] i2c_designware i2c_designware.1: using lookup tables for GPI=
O lookup=0D
[    6.978660] i2c_designware i2c_designware.1: No GPIO consumer scl found=
=0D
[    7.079110] intel-lpss 0000:00:15.2: enabling device (0000 -> 0002)=0D
[    7.080062] idma64 idma64.2: Found Intel integrated DMA 64-bit=0D
[    7.122780] typec port2: bound usb3-port6 (ops connector_ops)=0D
[    7.122788] typec port2: bound usb2-port3 (ops connector_ops)=0D
[    7.169314] i2c_designware i2c_designware.2: GPIO lookup for consumer sc=
l=0D
[    7.169318] i2c_designware i2c_designware.2: using ACPI for GPIO lookup=
=0D
[    7.169319] acpi device:85: GPIO: looking up scl-gpios=0D
[    7.169321] acpi device:85: GPIO: looking up scl-gpio=0D
[    7.169322] i2c_designware i2c_designware.2: using lookup tables for GPI=
O lookup=0D
[    7.169323] i2c_designware i2c_designware.2: No GPIO consumer scl found=
=0D
[    7.182064] zram0: detected capacity change from 0 to 16777216=0D
[    7.194983] intel-lpss 0000:00:15.3: enabling device (0000 -> 0002)=0D
[    7.195340] idma64 idma64.3: Found Intel integrated DMA 64-bit=0D
[    7.226000] ppdev: user-space parallel port driver=0D
[    7.229233] intel_rapl_msr: PL4 support detected.=0D
[    7.229264] intel_rapl_common: Found RAPL domain package=0D
[    7.229266] intel_rapl_common: Found RAPL domain core=0D
[    7.229267] intel_rapl_common: Found RAPL domain uncore=0D
[    7.229269] intel_rapl_common: Found RAPL domain psys=0D
[    7.238981] Adding 8388604k swap on /dev/zram0.  Priority:100 extents:1 =
across:8388604k SSDscFS=0D
[    7.287763] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: =
bound 0000:00:02.0 (ops i915_hdcp_component_ops)=0D
[    7.312928] i2c_designware i2c_designware.3: GPIO lookup for consumer sc=
l=0D
[    7.312931] i2c_designware i2c_designware.3: using ACPI for GPIO lookup=
=0D
[    7.312933] acpi device:86: GPIO: looking up scl-gpios=0D
[    7.312934] acpi device:86: GPIO: looking up scl-gpio=0D
[    7.312935] i2c_designware i2c_designware.3: using lookup tables for GPI=
O lookup=0D
[    7.312936] i2c_designware i2c_designware.3: No GPIO consumer scl found=
=0D
[    7.331150] spi-nor: probe of spi0.0 failed with error -524=0D
[    7.343062] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)=0D
[    7.343552] idma64 idma64.4: Found Intel integrated DMA 64-bit=0D
[    7.352983] RPC: Registered named UNIX socket transport module.=0D
[    7.353002] RPC: Registered udp transport module.=0D
[    7.353003] RPC: Registered tcp transport module.=0D
[    7.353003] RPC: Registered tcp NFSv4.1 backchannel transport module.=0D
[    7.411782] i2c_designware i2c_designware.4: GPIO lookup for consumer sc=
l=0D
[    7.411784] i2c_designware i2c_designware.4: using ACPI for GPIO lookup=
=0D
[    7.411785] acpi device:87: GPIO: looking up scl-gpios=0D
[    7.411787] acpi device:87: GPIO: looking up scl-gpio=0D
[    7.411787] i2c_designware i2c_designware.4: using lookup tables for GPI=
O lookup=0D
[    7.411788] i2c_designware i2c_designware.4: No GPIO consumer scl found=
=0D
[    7.439074] intel-lpss 0000:00:19.1: enabling device (0000 -> 0002)=0D
[    7.439450] idma64 idma64.5: Found Intel integrated DMA 64-bit=0D
[    7.566347] i2c_designware i2c_designware.5: GPIO lookup for consumer sc=
l=0D
[    7.566350] i2c_designware i2c_designware.5: using ACPI for GPIO lookup=
=0D
[    7.566352] acpi device:88: GPIO: looking up scl-gpios=0D
[    7.566355] acpi device:88: GPIO: looking up scl-gpio=0D
[    7.566356] i2c_designware i2c_designware.5: using lookup tables for GPI=
O lookup=0D
[    7.566357] i2c_designware i2c_designware.5: No GPIO consumer scl found=
=0D
[    7.595093] intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)=0D
[    7.595588] idma64 idma64.6: Found Intel integrated DMA 64-bit=0D
[    7.618990] intel-lpss 0000:00:1e.3: enabling device (0000 -> 0002)=0D
[    7.619474] idma64 idma64.7: Found Intel integrated DMA 64-bit=0D
[    7.671824] dw-apb-uart dw-apb-uart.6: GPIO lookup for consumer rs485-te=
rm=0D
[    7.671829] dw-apb-uart dw-apb-uart.6: using ACPI for GPIO lookup=0D
[    7.671831] acpi device:8b: GPIO: looking up rs485-term-gpios=0D
[    7.671832] acpi device:8b: GPIO: looking up rs485-term-gpio=0D
[    7.671833] dw-apb-uart dw-apb-uart.6: using lookup tables for GPIO look=
up=0D
[    7.671836] dw-apb-uart dw-apb-uart.6: No GPIO consumer rs485-term found=
=0D
[    7.671843] dw-apb-uart.6: ttyS4 at MMIO 0x4017006000 (irq =3D 16, base_=
baud =3D 6250000) is a 16550A=0D
[    8.032615] asix 3-9.1:1.0 enp0s20f0u9u1: Link is Down=0D
[    8.116913] typec port3: bound usb3-port7 (ops connector_ops)=0D
[    8.116923] typec port3: bound usb2-port4 (ops connector_ops)=0D
[   10.085471] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s20f0u9u1: link becomes r=
eady=0D
[   10.085687] asix 3-9.1:1.0 enp0s20f0u9u1: Link is Up - 100Mbps/Full - fl=
ow control off=0D
[   10.495103] ucsi_acpi USBC000:00: ucsi_handle_connector_change: GET_CONN=
ECTOR_STATUS failed (-110)=0D
[   15.374536] rfkill: input handler disabled=0D
[   16.923561] rfkill: input handler enabled=0D
[   43.928611] gpiochip_find_base: found new base at 632=0D
[   43.928779] gpio gpiochip1: (gpio-mockup-A): added GPIO chardev (254:1)=
=0D
[   43.928826] gpio gpiochip1: registered GPIOs 632 to 663 on gpio-mockup-A=
=0D
[   43.936712] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.936715] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.936717] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.937780] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.937783] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.937785] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.939555] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.939561] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.939566] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.942195] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.942202] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.942208] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.955894] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.955903] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.955909] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.969713] gpio gpiochip1: Persistence not supported for GPIO 0=0D
[   43.969722] gpio gpiochip1: registered chardev handle for line 0=0D
[   43.969729] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.984588] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   43.984598] gpio gpiochip1: registered chardev handle for line 31=0D
[   43.984605] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.988140] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   43.988149] gpio gpiochip1: registered chardev handle for line 31=0D
[   43.988155] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.991302] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   43.991308] gpio gpiochip1: registered chardev handle for line 31=0D
[   43.991314] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   43.994328] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   43.994335] gpio gpiochip1: registered chardev handle for line 31=0D
[   43.994343] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   44.007929] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   44.007939] gpio gpiochip1: registered chardev handle for line 31=0D
[   44.007945] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   44.021718] gpio gpiochip1: Persistence not supported for GPIO 31=0D
[   44.021727] gpio gpiochip1: registered chardev handle for line 31=0D
[   44.021733] gpio gpiochip1: registered chardev handle for 1 lines=0D
[   44.036775] BUG: kernel NULL pointer dereference, address: 0000000000000=
0a0=0D
[   44.036816] #PF: supervisor write access in kernel mode=0D
[   44.036833] #PF: error_code(0x0002) - not-present page=0D
[   44.036850] PGD 0 P4D 0 =0D
[   44.036862] Oops: 0002 [#1] PREEMPT SMP NOPTI=0D
[   44.036879] CPU: 3 PID: 1684 Comm: modprobe Not tainted 6.0.0-rc6-m #20=
=0D
[   44.036902] Hardware name: Intel Corporation Tiger Lake Client Platform/=
TigerLake U DDR4 SODIMM RVP, BIOS TGLSFWI1.R00.4391.A00.2109201819 09/20/20=
21=0D
[   44.036937] RIP: 0010:down_write+0x19/0x50=0D
[   44.036959] Code: ff ff e8 0a 17 ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 44 00 00 55 48 89 e5 53 48 89 fb e8 2e c1 ff ff 31 c0 ba 01 00 00 00 <f0=
> 48 0f b1 13 74 14 48 89 df be 02 00 00 00 e8 f3 f8 ff ff 5b 5d=0D
[   44.037013] RSP: 0018:ffffbdbd8246fcc0 EFLAGS: 00010246=0D
[   44.037031] RAX: 0000000000000000 RBX: 00000000000000a0 RCX: ffffff80000=
00000=0D
[   44.037053] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000=
000a0=0D
[   44.037074] RBP: ffffbdbd8246fcc8 R08: 0000000000000064 R09: ffff97410d5=
9c6b8=0D
[   44.037095] R10: ffff9741518006c0 R11: ffff97410d59c6b8 R12: 00000000000=
00000=0D
[   44.037116] R13: ffffbdbd8246fdd0 R14: ffff97410d59c410 R15: 00000000000=
000a0=0D
[   44.037138] FS:  00007fcdfc00f740(0000) GS:ffff97449dcc0000(0000) knlGS:=
0000000000000000=0D
[   44.037161] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   44.037180] CR2: 00000000000000a0 CR3: 00000001676c2001 CR4: 00000000007=
70ee0=0D
[   44.037203] PKRU: 55555554=0D
[   44.037213] Call Trace:=0D
[   44.037223]  <TASK>=0D
[   44.037235]  simple_recursive_removal+0x9d/0x2a0=0D
[   44.037255]  ? debugfs_lookup_and_remove+0x40/0x40=0D
[   44.037276]  ? preempt_count_add+0x7c/0xc0=0D
[   44.037295]  debugfs_remove.part.16+0x36/0x50=0D
[   44.037312]  debugfs_remove+0x1c/0x30=0D
[   44.037330]  gpio_mockup_debugfs_cleanup+0x15/0x20 [gpio_mockup]=0D
[   44.037353]  devm_action_release+0x12/0x20=0D
[   44.037371]  release_nodes+0x3e/0xc0=0D
[   44.037388]  devres_release_all+0x93/0xd0=0D
[   44.037408]  device_unbind_cleanup+0x12/0x80=0D
[   44.037424]  device_release_driver_internal+0xfa/0x160=0D
[   44.037443]  driver_detach+0x4a/0xa0=0D
[   44.037458]  bus_remove_driver+0x59/0xe0=0D
[   44.037476]  driver_unregister+0x2f/0x50=0D
[   44.037492]  platform_driver_unregister+0x12/0x20=0D
[   44.037511]  gpio_mockup_exit+0x1c/0x4de [gpio_mockup]=0D
[   44.037531]  __x64_sys_delete_module+0x13c/0x240=0D
[   44.037550]  ? debug_smp_processor_id+0x17/0x20=0D
[   44.037567]  ? exit_to_user_mode_prepare+0x42/0x180=0D
[   44.037590]  do_syscall_64+0x37/0x90=0D
[   44.037606]  entry_SYSCALL_64_after_hwframe+0x63/0xcd=0D
[   44.037626] RIP: 0033:0x7fcdfc11e8bb=0D
[   44.037642] Code: 73 01 c3 48 8b 0d 75 45 0e 00 f7 d8 64 89 01 48 83 c8 =
ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 45 0e 00 f7 d8 64 89 01 48=0D
[   44.037698] RSP: 002b:00007ffe2b943b68 EFLAGS: 00000206 ORIG_RAX: 000000=
00000000b0=0D
[   44.037723] RAX: ffffffffffffffda RBX: 000055fdaa836fc0 RCX: 00007fcdfc1=
1e8bb=0D
[   44.037745] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055fdaa8=
37028=0D
[   44.037767] RBP: 000055fdaa837028 R08: 1999999999999999 R09: 00000000000=
00000=0D
[   44.037789] R10: 00007fcdfc1a8ac0 R11: 0000000000000206 R12: 00000000000=
00001=0D
[   44.037815] R13: 0000000000000000 R14: 00007ffe2b945eb0 R15: 000055fdaa8=
3ec20=0D
[   44.037839]  </TASK>=0D
[   44.037847] Modules linked in: gpio_mockup(-) snd_seq_dummy snd_hrtimer =
nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_=
fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6=
 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defr=
ag_ipv4 ip_set nf_tables nfnetlink spi_pxa2xx_platform dw_dmac 8250_dw dw_d=
mac_core sunrpc snd_soc_rt700 regmap_sdw spi_nor snd_soc_dmic mtd mei_hdcp =
pmt_telemetry pmt_class intel_rapl_msr ppdev x86_pkg_temp_thermal intel_pow=
erclamp coretemp kvm_intel snd_hda_codec_hdmi kvm irqbypass intel_cstate sn=
d_sof_pci_intel_tgl pcspkr snd_sof_intel_hda_common snd_soc_hdac_hda soundw=
ire_intel wmi_bmof soundwire_generic_allocation soundwire_cadence snd_sof_i=
ntel_hda spi_intel_pci snd_sof_pci spi_intel snd_sof snd_sof_utils snd_sof_=
xtensa_dsp snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi soundwire=
_bus snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel snd=
_intel_dspcfg=0D
[   44.037922]  snd_intel_sdw_acpi snd_hda_codec snd_hda_core snd_hwdep snd=
_seq snd_seq_device snd_pcm snd_timer i2c_i801 snd i2c_smbus soundcore mei_=
me mei intel_lpss_pci intel_lpss input_leds hid_sensor_rotation hid_sensor_=
incl_3d hid_sensor_magn_3d hid_sensor_gyro_3d hid_sensor_accel_3d hid_senso=
r_temperature hid_sensor_als hid_sensor_press hid_sensor_trigger industrial=
io_triggered_buffer kfifo_buf hid_sensor_iio_common industrialio thunderbol=
t intel_vsec processor_thermal_device_pci_legacy processor_thermal_device p=
rocessor_thermal_rfim processor_thermal_mbox processor_thermal_rapl intel_r=
apl_common int340x_thermal_zone intel_soc_dts_iosf igen6_edac parport_pc pa=
rport mac_hid intel_hid sparse_keymap int3400_thermal acpi_tad acpi_thermal=
_rel acpi_pad sch_fq_codel zram hid_sensor_custom hid_sensor_hub intel_isht=
p_hid hid_generic crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_i=
ntel crypto_simd cryptd serio_raw usbkbd e1000e asix usbnet mii usbhid ucsi=
_acpi hid typec_ucsi=0D
[   44.038202]  intel_ish_ipc intel_ishtp typec wmi pinctrl_tigerlake pinct=
rl_intel btrfs blake2b_generic xor raid6_pq zstd_compress ip6_tables ip_tab=
les x_tables=0D
[   44.038478] CR2: 00000000000000a0=0D
[   44.038490] ---[ end trace 0000000000000000 ]---=0D
[   44.054030] RIP: 0010:down_write+0x19/0x50=0D
[   44.054043] Code: ff ff e8 0a 17 ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 44 00 00 55 48 89 e5 53 48 89 fb e8 2e c1 ff ff 31 c0 ba 01 00 00 00 <f0=
> 48 0f b1 13 74 14 48 89 df be 02 00 00 00 e8 f3 f8 ff ff 5b 5d=0D
[   44.054088] RSP: 0018:ffffbdbd8246fcc0 EFLAGS: 00010246=0D
[   44.054101] RAX: 0000000000000000 RBX: 00000000000000a0 RCX: ffffff80000=
00000=0D
[   44.054118] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000=
000a0=0D
[   44.054135] RBP: ffffbdbd8246fcc8 R08: 0000000000000064 R09: ffff97410d5=
9c6b8=0D
[   44.054152] R10: ffff9741518006c0 R11: ffff97410d59c6b8 R12: 00000000000=
00000=0D
[   44.054169] R13: ffffbdbd8246fdd0 R14: ffff97410d59c410 R15: 00000000000=
000a0=0D
[   44.054187] FS:  00007fcdfc00f740(0000) GS:ffff97449dcc0000(0000) knlGS:=
0000000000000000=0D
[   44.054206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0D
[   44.054221] CR2: 00000000000000a0 CR3: 00000001676c2001 CR4: 00000000007=
70ee0=0D
[   44.054238] PKRU: 55555554=

--+jwnAk+X9uKarQqM--
