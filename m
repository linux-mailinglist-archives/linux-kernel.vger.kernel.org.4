Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591737139DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjE1OFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1OFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:05:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BE4BD;
        Sun, 28 May 2023 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685282728; x=1716818728;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=YsRjsjYmy+coou/ayqZQU5o53Si6obpi8bu530ELh9o=;
  b=lAkKA10RR2NhspyQbqedvGb9KSWwF87N7DW/p8vZza9Uu8c0GalJ4fzB
   RmJfpX+rfga8fJEQYSA13lMOzyeLM/LUPgcqG5bZByPUfKV3yxvvS8Rh/
   OcajQ3hz30mNbJs2jIGjSZS3HifN7Bca9YSyhNNEgFESoRYMzIs930xS9
   ECvmIKojEU/fqPcSPZVTHYAPjq7B8L5oFaKMsJzLVd+GiGON4E0UPZZ9z
   dhhWbroBJ8YzLeNwMl3IKh9i6DZoFzI2cHHMN3yuVaAGifNGTF20+//uT
   QsB2C4ystbvEVlSSJjsf7ycZWidB84oy7kW4BK2CVmgji0QNACC50B3IJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="334140787"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="334140787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 07:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="775637974"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="xz'341?yaml'341?scan'341,208,341";a="775637974"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2023 07:05:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 28 May 2023 07:05:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 28 May 2023 07:05:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 28 May 2023 07:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewlottaPfpn6cscm6BNOisC3WN8n8O0TAShtDQFUX4pZNHrk9z2PggOm8/HMTdfLs/3o/XHYQ8zgdknwQy75wP1Px+KtybCVXCZbAvsGrgVytc7Yvjd/hBCQ0ExXHp3XEsfUApTmGDylIF1EcpJqopTkgFdLOjnprwE2Dnhzl5LLodjwpuIMmxZ6RYkNeRQ3gpzf86JXHR6pvulkcxhaBZ8sE16RzYPDqrMNnKxvPUulYiuwr7dx1a2jjr+VSZS3a35af/kKrIhXF54VnGYfVIa1xnXzci0hfM/mjZ8v61sBs/f+7NHOHeCyr3XQZu2OZJMsIGsEHHh3xYMD7GqwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNJPIIQJ/ZGSUwkNHRWtAwXhplzqzBkPKzK6B81jy80=;
 b=mAOTpjZw4ytkj6psVsbC44bjhKD3zJHTJfR8afhnmRDw9vljkq9sq2tYhniN76YGXYqoaEmi7+En/wN4d9RC7FLm+ORSydjBTqhT6Zh91yYJ2tYBktpvisrE0btZB5JeLGXcVU4b6Fz2THJ2fYcRYevMWlw4tntGjFMPxwbR4+m6ocAYFBhAec5LIBDt0o1uZbyd6J+9Qy4nEfUj+Lo494x+/zLmjQXs48QgroLiadrJ1XxzC9FeihdcXXPuIDg7a6MpztoxbjxdT+WHnz1Aq5gUMKOB1q1pHVyqDAsnIr95zyd9/C9l8SMHsHFE9kBDCl1chTGsN1scpKHB69JJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Sun, 28 May
 2023 14:05:12 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%6]) with mapi id 15.20.6433.020; Sun, 28 May 2023
 14:05:12 +0000
Date:   Sun, 28 May 2023 22:04:57 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <xudong.hao@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, "Paul Turner" <pjt@google.com>,
        <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, <David.Laight@aculab.com>,
        <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        "Chris Kennelly" <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        <libc-alpha@sourceware.org>, Steven Rostedt <rostedt@goodmis.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH 2/4] selftests/rseq: Add sched_state rseq field and
 getter
Message-ID: <202305282101.a1fb6386-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="E87YQmuknHbL+aHw"
Content-Disposition: inline
In-Reply-To: <20230517152654.7193-3-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH0PR11MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: e64b90a2-5e61-4aa0-2426-08db5f848d81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jx2qmoHVXkp3TGUShAuiEeXi5unKL8wdMeVn5upLg7x/RS5dxswOh5b1vOmuKqsLisEiY3bArKS18gWI6g1l8hB4V5Q2553cANM12MIPMEz3IrCxeolEngjGh9F8UdPoa88hjTB6JjTsq3EpTO9pTW+Pg5ek/6SN9eE848lDrvXxIZIsjlz0EO2V3tbRjtgT1qrefeIZlz53AduNkxFvPd4P3UpgzQrrVS/pkYy0f77PYxvVEpAVZ1NR7pxwhFOELaU5iybdGAeHes1J34JlSSZloX2rmFq8v48p2XT9jSaPeLW2urj1EBjGtb+v9S/GOoAqAqK5RepjpoGLIIcp7a3izwA9vumHrVwqm7c+jCF9o3PQiZ67le7O6tOGTT0PARMxBbAn6li9PBRs1vVK2b8LFOc58gH9KSZkbbclGo0kA9h9EkRw+EbABV5Qh29CMfe/TteX3c3qDZ7SLjb6zZCs9GdafESZFt67upvQ8qDOt/HDtzgrYFboj5u11cIN1tEsOXTfZmJYGlFL5Kha4IuuseBB1IK5QVQglrOWYGvFurZuvGyXqUMtsyXus5JrbpPIM99Airmv6CLpcSyz7VNWlnk26H+Xrm5uZJ7ocL5e/2f3B0PDpszk/AevTuKkQkti2Mg7FYFtGLAKYmZwvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199021)(54906003)(478600001)(235185007)(5660300002)(8676002)(8936002)(7416002)(36756003)(2906002)(86362001)(66556008)(66946007)(66476007)(4326008)(6916009)(82960400001)(316002)(38100700002)(41300700001)(2616005)(21490400003)(966005)(107886003)(186003)(26005)(1076003)(6506007)(6512007)(6486002)(33964004)(44144004)(6666004)(83380400001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y041QXhWeGdGdDVwaWRVUWVGaXM3cU9RYS9uY1YvQjJ0V1BXQVo4Z1FaaHNp?=
 =?utf-8?B?WjhRUXA3bzFYRHBxUnhNdnpZMTcvZFhFWVB3ZW8wc2NpdU1zMFBDeVVndHJU?=
 =?utf-8?B?QVVPN2Q1bU1RcVBndEFHdUh2RHVJb2JMMm5NS1R1L3FpenRiMytUeEIvMExp?=
 =?utf-8?B?Z0tROGk4RUdIZGxyNG05RGNTNTFPOUFjU1F3Sllla1prbTRNc2JnQTEwaUpR?=
 =?utf-8?B?VzNLSGVKVmgrdlVidHo1Umo5RTJ1Y2NFVFNVazd5S1NmbFV5eU9neUY2eWlN?=
 =?utf-8?B?Rlh1RW8xUHhPM1JsZmRxd1pwQU9NUzUvNGI0dXZEK1VRaXYrOElhV3NhZXIz?=
 =?utf-8?B?ZTRQc3pvVlhDUjRZekxnRkFITkw5RkRWOS92dXdlRmhFYTJwdFZCRnd5QkJt?=
 =?utf-8?B?aUNYLzA0RVI1L0pkei9Pb2NXMHc2ZmFSSm11STlrM1c1MHorWWZpVm1neVZa?=
 =?utf-8?B?akxOQmYxTGhjeUNaQ1NaTzA3TXdJKyt4U2VEZ0VNNEE3dUZ3SGIzcmR1TSt6?=
 =?utf-8?B?N04vWVhFZzhTS2lobUg5dHZqK21GMTdCTHlYeGlpS1FkRUF4MXFsTTJYUTkz?=
 =?utf-8?B?U1BIazA5ZFgrSTk1QkwzVlZtNDlWZ2VObFA5NW1MMzFZUGttak9CNC9Tb21j?=
 =?utf-8?B?MU43TTdwN0ZQeDBSQTZ2aDlqOTlncmRDM1phT0ZnSCtmcDZlQ0RqYXE2S2Nw?=
 =?utf-8?B?R3ZIT3F0bXg0VWxkTHpIb01KS3UvajlwcmRkOGo0bVlENWJ1SitKaDB0OFlC?=
 =?utf-8?B?QlFvZTRTeHJvSmtUM3pydHdmUCtqYWV1UkpqczFkQkRySU9RdnZ6QWd2cDBu?=
 =?utf-8?B?cjZBVk0rTG16aGRDSk9ocngvUStjcW5BdlNYTjRGMGp4ODhhdTRvQzRYZHA0?=
 =?utf-8?B?WDVlWmg0NjFaSUliWFN2Q0hZQmNTem1mOEgwRFJ0MWZEb0cwTzk0QlpzNHhR?=
 =?utf-8?B?SXByOHc2SXZjRlhyall2QUFYQmZFMjRTYWxFNGpzU0ovdllaZjRQV3lWV2N5?=
 =?utf-8?B?bS9rSk5Rcmx0Yy9wbStBM2orWHhuSzR3a1QwNHc5TklpdmRlaW9kU0gwaWFR?=
 =?utf-8?B?bC9zYUh3V0crU05OZ0xGaVR2NUEwNm9QbzhkbEtjb0hQY295MGdzOWhwakEx?=
 =?utf-8?B?SGk5ODA5UHBkWUdHVEJRME1wbnRBZkhyb0ViektsbitnblA1ZGNldzNBUlJM?=
 =?utf-8?B?UFpDNDNxWW8zWFRJS2lzbk1CdWVRcUpWbWttdGJDKzh4OEVuaFNBUkpIUnQ0?=
 =?utf-8?B?TDFBc1pBK2ltUDU4MFhtMStrdmFtSVI5TVpFTk1oTWxrcHByMmdyNWlZTXJa?=
 =?utf-8?B?UWZ3bVhTUEE3WEdNcmFjYWJFMHBMWHY0bFI3NlZWVVBTd2pNdHlucVdqM3JF?=
 =?utf-8?B?L21TTlo2NEZvbklGcWNleWVRaDdvNGpRV3FkcURxbkdpY0tjUTl0K0d1aHEz?=
 =?utf-8?B?NlhQUzg5SjFvWnVmZXFrZ0Q2d0Nyc2pQaElyeUJqRExYNno4ZDNvdjlTNCth?=
 =?utf-8?B?WlVPeEdEMjh6a3VoRDZuaSsxQnpIZURDbUpNRmtsb0VxQzlrUXlVTkhJOFR1?=
 =?utf-8?B?ZDlsOUI3UGhPcnNxYzlSeWN4WUxFcVg3OXRrc0s5aUx3SDZScUkvYUdGbmh2?=
 =?utf-8?B?a2NzTE5kd1JTUkFacTYyVmtIU015SkJ2a0ZGK2RsUElhVjRpcTRXUGIyUXBK?=
 =?utf-8?B?LzMvcU9BcE5CVjNMbGx1UFF3REg1b1hLNTVURUgvNzgzVEdqTEpKTGhwZ2Q2?=
 =?utf-8?B?MG9jbHNPemRiWUZlbzM1cG9QVWFCeUoxREloRkNvb05RekdTNjRMYy9oTlJm?=
 =?utf-8?B?TktOcEQxUHBzeWdkN0UvWmtiZzk2TzlIczVqNElFWUNUaG9oaUdva2RMZzNW?=
 =?utf-8?B?alFpb2hEQ24xVTU2QnhRVzhxcEcrMjkwTUlOeTdwWVM1UTljNWtLVjhZbHVo?=
 =?utf-8?B?Ly9HT1BjTExsZjByMUQrQ3g3d0FDVmRHbGdHR3lURTZleE5UZ1JzdSs4L3Yw?=
 =?utf-8?B?bzNPKys2bElGazI1UGJiR0p4bjVlN2xkZFVUaDJmSnF4ajFHVWZxN2JITTVt?=
 =?utf-8?B?NlB5enNENFYxNXdVc2NSM0EwVWc3QkowSUxlNkt3M0RVTGxIV3ZDQ1kyeHVV?=
 =?utf-8?B?ZTZQR3dYNm5FWC9CTi9GenovQ0hEMkJPdy9kLzE2SjRXTFJJTFhYc1lxcXov?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e64b90a2-5e61-4aa0-2426-08db5f848d81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2023 14:05:12.6811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYNSzE+uBMHC6ltXGVM50VlsmcIBNtYPmg7J5ktPikjNQ+q27Mxszx6Ozd6ZubmU7RB73PBJyTJZ7Bl4sn/N9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello,

kernel test robot noticed "kernel-selftests.kvm.make.fail" on:

commit: 1f70aced56e5ae7bcdaba5f55ff62e610c105089 ("[RFC PATCH 2/4] selftest=
s/rseq: Add sched_state rseq field and getter")
url: https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/rseq-=
Add-sched_state-field-to-struct-rseq/20230517-233229
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.gi=
t next
patch link: https://lore.kernel.org/all/20230517152654.7193-3-mathieu.desno=
yers@efficios.com/
patch subject: [RFC PATCH 2/4] selftests/rseq: Add sched_state rseq field a=
nd getter

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: kvm

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


compiler: gcc-11
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphi=
re Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue, kindly add following tag
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202305282101.a1fb6386-oliver.sang@=
intel.com


In file included from ../rseq/rseq.h:20,
                 from ../rseq/rseq.c:35,
                 from rseq_test.c:23:
../rseq/rseq-abi.h:40:6: error: redeclaration of =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
In file included from rseq_test.c:16:
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:40:6: note: originally defined here
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
../rseq/rseq-abi.h:44:9: error: redeclaration of enumerator =E2=80=98RSEQ_S=
CHED_STATE_ON_CPU=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:44:9: note: previous definition of =E2=
=80=98RSEQ_SCHED_STATE_ON_CPU=E2=80=99 with type =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make: *** [../lib.mk:147: /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/rseq_test] =
Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'
2023-05-27 01:58:33 make quicktest=3D1 run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   rseq_test=
.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/guest_=
modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucall_common=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/processor.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/handlers.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/rseq_test
In file included from ../rseq/rseq.h:20,
                 from ../rseq/rseq.c:35,
                 from rseq_test.c:23:
../rseq/rseq-abi.h:40:6: error: redeclaration of =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
In file included from rseq_test.c:16:
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:40:6: note: originally defined here
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
../rseq/rseq-abi.h:44:9: error: redeclaration of enumerator =E2=80=98RSEQ_S=
CHED_STATE_ON_CPU=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:44:9: note: previous definition of =E2=
=80=98RSEQ_SCHED_STATE_ON_CPU=E2=80=99 with type =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make: *** [../lib.mk:147: /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/rseq_test] =
Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in t=
his email
        bin/lkp split-job --compatible job.yaml # generate the yaml file fo=
r lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.4.0-rc1-00006-g1f70aced56e5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.4.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-12) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24000
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24000
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=125
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
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
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

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
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
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
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
CONFIG_SCHED_MM_CID=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
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
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
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
# CONFIG_EXPERT is not set
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
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

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
# CONFIG_X86_CPU_RESCTRL is not set
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
# CONFIG_INTEL_TDX_GUEST is not set
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
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
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_LATE_LOADING=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
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
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_X86_SGX is not set
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
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
# CONFIG_ADDRESS_MASKING is not set
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
CONFIG_CPU_IBPB_ENTRY=y
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
# CONFIG_PMIC_OPREGION is not set
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
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
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
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
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
CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
CONFIG_KVM_SMM=y
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y

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
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
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
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
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
# CONFIG_MODULE_DEBUG is not set
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
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
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
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_SLUB_CPU_PARTIAL=y
# end of SLAB allocator options

CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_VMEMMAP=y
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
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_GET_FREE_REGION=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_DMAPOOL_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_PER_VMA_LOCK=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
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
# CONFIG_NET_KEY is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_NET_HANDSHAKE=y
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
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
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
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
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
CONFIG_NETFILTER_BPF_LINK=y
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
CONFIG_NF_CONNTRACK_OVS=y
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
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m

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

# CONFIG_IP_SET is not set
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
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
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
# CONFIG_NET_EMATCH_CANID is not set
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
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
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
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
CONFIG_MAX_SKB_FRAGS=17
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
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
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
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
CONFIG_PCI_HYPERV=m
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
CONFIG_PCI_HYPERV_INTERFACE=m

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# CONFIG_PCI_MESON is not set
# CONFIG_PCIE_DW_PLAT_HOST is not set
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
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
CONFIG_FW_LOADER_DEBUG=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# CONFIG_FW_UPLOAD is not set
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
# CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
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
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
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
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
# CONFIG_NVME_AUTH is not set
# CONFIG_NVME_TARGET is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_SGI_XP is not set
CONFIG_HP_ILO=m
# CONFIG_SGI_GRU is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
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

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_GSC is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
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
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
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
CONFIG_HYPERV_STORAGE=m
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
# CONFIG_PATA_PARPORT is not set

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
# CONFIG_TARGET_CORE is not set
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
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
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
# CONFIG_MICROSOFT_MANA is not set
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
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
# CONFIG_TXGBE is not set
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
# CONFIG_MICROCHIP_T1S_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_CBTX_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_NCN26000_PHY is not set
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
# CONFIG_CAN_DEV is not set
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
# CONFIG_WLAN is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=y
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
CONFIG_HYPERV_KEYBOARD=m
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
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
# CONFIG_SERIAL_8250_PCI1XXXX is not set
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
# CONFIG_SERIAL_JSM is not set
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
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
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
CONFIG_I2C_SMBUS=y
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
CONFIG_I2C_I801=y
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
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_MICROCHIP_CORE is not set
# CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PCI1XXXX is not set
# CONFIG_SPI_PXA2XX is not set
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
# CONFIG_GPIO_FXL6408 is not set
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
# CONFIG_GPIO_ELKHARTLAKE is not set
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
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
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
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
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
# CONFIG_SENSORS_MC34VR500 is not set
CONFIG_SENSORS_MCP3021=m
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
# CONFIG_PMBUS is not set
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
CONFIG_THERMAL_ACPI=y
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
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
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
# CONFIG_BCMA is not set

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
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
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
# CONFIG_MFD_INTEL_M10_BMC_SPI is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
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
# CONFIG_IR_SHARP_DECODER is not set
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

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_VIDEO_CMDLINE=y
CONFIG_VIDEO_NOMODESET=y
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
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
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=7500
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_VIRTIO_GPU_KMS=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
# CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
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
# CONFIG_DRM_HYPERV is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
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
CONFIG_FB_HYPERV=m
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
# CONFIG_BACKLIGHT_KTZ8866 is not set
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
CONFIG_HID_SUPPORT=y
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
# CONFIG_HID_EVISION is not set
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
CONFIG_HID_HYPERV_MOUSE=m
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
# HID-BPF support
#
# CONFIG_HID_BPF is not set
# end of HID-BPF support

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

CONFIG_I2C_HID=m
# CONFIG_I2C_HID_ACPI is not set
# CONFIG_I2C_HID_OF is not set

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
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
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
# CONFIG_TYPEC_MUX_GPIO_SBU is not set
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
# CONFIG_LEDS_BD2606MVV is not set
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
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
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
# CONFIG_XILINX_XDMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
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
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
# CONFIG_UIO is not set
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
CONFIG_VHOST_TASK=y
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
# CONFIG_HYPERV_VTL_MODE is not set
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
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
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMF is not set
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_LENOVO_YMC is not set
CONFIG_SENSORS_HDAPS=m
# CONFIG_THINKPAD_ACPI is not set
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
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
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
# CONFIG_HWSPINLOCK is not set

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
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_PERF_EVENTS=y
# CONFIG_IOMMUFD is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
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

# CONFIG_WPCM450_SOC is not set

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
CONFIG_IDLE_INJECT=y
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

#
# Layout Types
#
# CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
# CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
# end of Layout Types

# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
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
CONFIG_LEGACY_DIRECT_IO=y
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
CONFIG_XFS_SUPPORT_ASCII_CI=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DRAIN_INTENTS=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
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
# CONFIG_NETFS_STATS is not set
# CONFIG_FSCACHE is not set
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
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
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
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
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
# CONFIG_NFS_V4_2_READ_PLUS is not set
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
CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES is not set
CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
# CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
CONFIG_SUNRPC_DEBUG=y
# CONFIG_CEPH_FS is not set
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
# CONFIG_DLM is not set
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
# CONFIG_SECURITY_PATH is not set
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"

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
# CONFIG_CRYPTO_SM4_GENERIC is not set
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
# CONFIG_CRYPTO_USER_API_HASH is not set
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
# CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
# CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
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

# CONFIG_CRYPTO_HW is not set
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
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
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
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
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
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_PER_VMA_LOCK_STATS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SHRINKER_DEBUG is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
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
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_NMI_CHECK_CPU is not set
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0
# CONFIG_RCU_CPU_STALL_CPUTIME is not set
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
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
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
# CONFIG_USER_EVENTS is not set
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
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_RV is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
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
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_TEST_DHRY is not set
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
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_MAPLE_TREE is not set
# CONFIG_TEST_RHASHTABLE is not set
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
# CONFIG_TEST_DYNAMIC_DEBUG is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export need_memory='12G'
	export kernel_cmdline='kvm-intel.unrestricted_guest=0'
	export job_origin='kernel-selftests-kvm.yaml'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export queue='validate'
	export testbox='lkp-spr-2sp1'
	export tbox_group='lkp-spr-2sp1'
	export submit_id='647162286a565389f793e589'
	export job_file='/lkp/jobs/scheduled/lkp-spr-2sp1/kernel-selftests-kvm-debian-12-x86_64-20220629.cgz-1f70aced56e5ae7bcdaba5f55ff62e610c105089-20230527-35319-1ep3hfa-3.yaml'
	export id='85d6677cbca2c444191b6de5ce14ffbd21cc58f9'
	export queuer_version='/zday/lkp'
	export model='Sapphire Rapids'
	export nr_node=2
	export nr_cpu=224
	export memory='256G'
	export nr_ssd_partitions=6
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401J94P0IGN-part*'
	export rootfs_partition='/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ207201DG1P0FGN-part4'
	export kernel_cmdline_hw='acpi_rsdp=0x777fe014'
	export brand='Intel(R) Xeon(R) Platinum 8480+'
	export commit='1f70aced56e5ae7bcdaba5f55ff62e610c105089'
	export ucode='0x2b000181'
	export need_kernel_version=
	export need_kconfig='KVM
KVM_INTEL'
	export rootfs='debian-12-x86_64-20220629.cgz'
	export initrds='linux_headers
linux_selftests'
	export kconfig='x86_64-rhel-8.3-kvm'
	export enqueue_time='2023-05-27 09:51:36 +0800'
	export _id='647162286a565389f793e589'
	export _rt='/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='0e984e67854b3c473b40120ac6d26ec930844568'
	export base_commit='f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6'
	export branch='linux-review/Mathieu-Desnoyers/rseq-Add-sched_state-field-to-struct-rseq/20230517-233229'
	export result_root='/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/3'
	export scheduler_version='/lkp/lkp/src'
	export arch='x86_64'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-12-x86_64-20220629.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/vmlinuz-6.4.0-rc1-00006-g1f70aced56e5
branch=linux-review/Mathieu-Desnoyers/rseq-Add-sched_state-field-to-struct-rseq/20230517-233229
job=/lkp/jobs/scheduled/lkp-spr-2sp1/kernel-selftests-kvm-debian-12-x86_64-20220629.cgz-1f70aced56e5ae7bcdaba5f55ff62e610c105089-20230527-35319-1ep3hfa-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kvm
commit=1f70aced56e5ae7bcdaba5f55ff62e610c105089
kvm-intel.unrestricted_guest=0
initcall_debug
nmi_watchdog=0
acpi_rsdp=0x777fe014
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20230406.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='6.4.0-rc2-wt-ath-04243-g0e984e67854b'
	export repeat_to=6
	export stop_repeat_if_found='kernel-selftests.kvm.make.fail'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/vmlinuz-6.4.0-rc1-00006-g1f70aced56e5'
	export dequeue_time='2023-05-27 09:56:23 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-spr-2sp1/kernel-selftests-kvm-debian-12-x86_64-20220629.cgz-1f70aced56e5ae7bcdaba5f55ff62e610c105089-20230527-35319-1ep3hfa-3.cgz'

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
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='kvm' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='kvm' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--E87YQmuknHbL+aHw
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="kernel-selftests"
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089
2023-05-27 01:58:30 ln -sf /usr/bin/clang
2023-05-27 01:58:30 ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
2023-05-27 01:58:30 ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
2023-05-27 01:58:30 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
LKP WARN miss config CONFIG_KVM_AMD=3D of kvm/config
LKP WARN miss config CONFIG_USERFAULTFD=3D of kvm/config
2023-05-27 01:58:30 make -j224 -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/assert.c -o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/assert.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/elf.c -o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/elf.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/guest_modes.c -o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/guest_modes.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/io.c -o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/io.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/kvm_util.c -o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/kvm_util.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/memstress.c -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/memstress.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/rbtree.c -o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/rbtree.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/sparsebit.c -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/sparsebit.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/test_util.c -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/test_util.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/ucall_common.c -o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/ucall_common.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c lib/userfaultfd_util.c -=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/apic.c=
 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/hyperv=
.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/memstr=
ess.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/memstress.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/proces=
sor.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/processor.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/svm.c =
-o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/ucall.=
c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/vmx.c =
-o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/vmx.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib/x86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/../../../usr/include   -c lib/x86_64/handle=
rs.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/handlers.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ilib -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/../../../usr/include   -c -ffreestanding lib/strin=
g_override.c -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/cpuid_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o =
-ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/x86_64/cpuid_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/cr4_cpuid_sync_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaul=
tfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ov=
erride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/cr4_cpuid_syn=
c_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/get_msr_index_features.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/asser=
t.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userf=
aultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/s=
vm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string=
_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/get_msr_in=
dex_features
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/exit_on_emulation_failure_test.c /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/string_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/ex=
it_on_emulation_failure_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/fix_hypercall_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfault=
fd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ove=
rride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/fix_hypercall_=
test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_clock.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_uti=
l.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.=
o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_clock
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_cpuid.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_uti=
l.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.=
o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_cpuid
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_evmcs.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_uti=
l.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.=
o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_evmcs
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_extended_hypercalls.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/a=
ssert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/u=
serfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/st=
ring_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv=
_extended_hypercalls
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_features.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_features
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_ipi.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o =
-ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_ipi
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_svm_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_svm_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/hyperv_tlb_flush.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rb=
tree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd=
_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overr=
ide.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/kvm_clock_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtr=
ee.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_u=
til.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x8=
6_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overrid=
e.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/kvm_clock_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/kvm_pv_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x8=
6_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o=
 -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/kvm_pv_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/mmio_warning_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/r=
btree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultf=
d_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_over=
ride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/mmio_warning_te=
st
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/monitor_mwait_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfault=
fd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ove=
rride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/monitor_mwait_=
test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/nested_exceptions_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/asser=
t.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userf=
aultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/s=
vm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string=
_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/nested_exc=
eptions_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/platform_info_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfault=
fd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ove=
rride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/platform_info_=
test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/pmu_event_filter_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/i=
o.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfa=
ultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/sv=
m.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_=
override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/pmu_event_f=
ilter_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/set_boot_cpu_id.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/set_sregs_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtr=
ee.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_u=
til.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x8=
6_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overrid=
e.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/set_sregs_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/smaller_maxphyaddr_emulation_test.c /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/a=
pic.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/string_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64=
/smaller_maxphyaddr_emulation_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/smm_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/u=
call_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -l=
dl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/x86_64/smm_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/state_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o =
-ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/x86_64/state_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_preemption_timer_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/as=
sert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/us=
erfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/str=
ing_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_pre=
emption_timer_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/svm_vmcall_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/svm_vmcall_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/svm_int_ctl_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rb=
tree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd=
_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overr=
ide.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/svm_nested_shutdown_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ass=
ert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/use=
rfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/stri=
ng_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/svm_nest=
ed_shutdown_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/svm_nested_soft_inject_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/s=
tring_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/svm_n=
ested_soft_inject_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/tsc_scaling_sync.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rb=
tree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd=
_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overr=
ide.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/sync_regs_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtr=
ee.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_u=
til.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x8=
6_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overrid=
e.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/sync_regs_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/ucna_injection_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaul=
tfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ov=
erride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/ucna_injectio=
n_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/userspace_io_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/r=
btree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultf=
d_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_over=
ride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/userspace_io_te=
st
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/userspace_msr_exit_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/asse=
rt.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/user=
faultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/=
svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/strin=
g_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/userspace=
_msr_exit_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_apic_access_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfau=
ltfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_o=
verride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_apic_acc=
ess_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_close_while_nested_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/s=
tring_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_c=
lose_while_nested_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_dirty_log_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfault=
fd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ove=
rride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_dirty_log_=
test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_exception_with_invalid_guest_state.c /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/spar=
sebit.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/apic.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/string_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x=
86_64/vmx_exception_with_invalid_guest_state
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_msrs_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtre=
e.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_ut=
il.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override=
.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_msrs_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_invalid_nested_guest_state.c /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/string_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vm=
x_invalid_nested_guest_state
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_set_nested_state_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/as=
sert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/us=
erfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/str=
ing_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_set=
_nested_state_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_tsc_adjust_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaul=
tfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ov=
erride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_tsc_adjus=
t_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_nested_tsc_scaling_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
assert.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
userfaultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/s=
tring_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_n=
ested_tsc_scaling_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xapic_ipi_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtr=
ee.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_u=
til.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x8=
6_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overrid=
e.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xapic_ipi_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xapic_state_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rb=
tree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd=
_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overr=
ide.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xapic_state_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xcr0_cpuid_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xcr0_cpuid_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xss_msr_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_uti=
l.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.=
o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xss_msr_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/debug_regs.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o =
-ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/x86_64/debug_regs
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/tsc_msrs_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtre=
e.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_ut=
il.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override=
.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/tsc_msrs_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/vmx_pmu_caps_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/r=
btree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultf=
d_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_over=
ride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_te=
st
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xen_shinfo_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xen_shinfo_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/xen_vmcall_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbt=
ree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_=
util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x=
86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_overri=
de.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/xen_vmcall_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/sev_migrate_tests.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/r=
btree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultf=
d_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_over=
ride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/sev_migrate_tes=
ts
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/amx_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/u=
call_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -l=
dl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/x86_64/amx_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/max_vcpuid_cap_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaul=
tfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_ov=
erride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/max_vcpuid_ca=
p_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -Ix86_64 -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/../../../usr/include   -pthread  -no-pie   x86_=
64/triple_fault_event_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/asse=
rt.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/io.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/user=
faultfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/=
svm.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/strin=
g_override.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/x86_64/triple_fa=
ult_event_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   access_tr=
acking_perf_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtre=
e.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_ut=
il.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_=
selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tool=
s/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override=
.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/access_tracking_perf_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   demand_pa=
ging_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/uca=
ll_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/pro=
cessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/=
handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl=
 -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/demand_paging_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   dirty_log=
_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf_se=
lftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/=
testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/g=
uest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucall_c=
ommon.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /usr/s=
rc/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105=
089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/process=
or.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/hand=
lers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl -o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/dirty_log_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   dirty_log=
_perf_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/uc=
all_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/pr=
ocessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ld=
l -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/dirty_log_perf_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   hardware_=
disable_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/=
processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -=
ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/hardware_disable_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   kvm_creat=
e_max_vcpus.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5=
ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm=
-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/u=
call_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/p=
rocessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86=
_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/sel=
ftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -l=
dl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55=
ff62e610c105089/tools/testing/selftests/kvm/kvm_create_max_vcpus
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   kvm_page_=
table_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /u=
sr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610=
c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests=
-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing=
/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/uc=
all_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /=
usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e61=
0c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/pr=
ocessor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_=
64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/self=
tests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ld=
l -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55f=
f62e610c105089/tools/testing/selftests/kvm/kvm_page_table_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   max_guest=
_memory_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/=
perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089=
/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-=
8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kv=
m/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ace=
d56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_self=
tests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/te=
sting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/=
processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -=
ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f5=
5ff62e610c105089/tools/testing/selftests/kvm/max_guest_memory_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   memslot_m=
odification_stress_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-=
1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/rbtree.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-=
rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftes=
ts/kvm/lib/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfau=
ltfd_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-=
x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/=
selftests/kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced=
56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_s=
elftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools=
/testing/selftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/x86_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_o=
verride.o -ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/memslot_modificatio=
n_stress_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   memslot_p=
erf_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf=
_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/too=
ls/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-=
kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/li=
b/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e=
5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucal=
l_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdab=
a5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /us=
r/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c=
105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftest=
s-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testin=
g/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3=
-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/l=
ib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/proc=
essor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/h=
andlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba=
5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl =
-o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/memslot_perf_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   rseq_test=
.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/guest_=
modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucall_common=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/processor.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/handlers.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/rseq_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   set_memor=
y_region_test.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src=
/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10508=
9/tools/testing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel=
-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/k=
vm/lib/guest_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/ucall_common.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7=
bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_sel=
ftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/t=
esting/selftests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhe=
l-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/=
kvm/lib/x86_64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64=
/processor.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/sr=
c/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1050=
89/tools/testing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x=
86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/s=
elftests/kvm/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1=
f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86=
_64/handlers.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/string_override.o =
-ldl -o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/set_memory_region_test
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   steal_tim=
e.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/guest=
_modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5=
f55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-k=
vm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib=
/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcd=
aba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-r=
hel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftest=
s/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced5=
6e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucall_commo=
n.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff=
62e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /usr/src/p=
erf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/=
tools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftests-x86_6=
4-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selft=
ests/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f=
70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_=
64/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7b=
cdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/processor.o=
 /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e=
610c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/perf_selft=
ests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/tes=
ting/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64-rhel-8=
.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm=
/lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5a=
e7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/handlers=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl -o /usr=
/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c1=
05089/tools/testing/selftests/kvm/steal_time
In file included from ../rseq/rseq.h:20,
                 from ../rseq/rseq.c:35,
                 from rseq_test.c:23:
../rseq/rseq-abi.h:40:6: error: redeclaration of =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
In file included from rseq_test.c:16:
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:40:6: note: originally defined here
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
../rseq/rseq-abi.h:44:9: error: redeclaration of enumerator =E2=80=98RSEQ_S=
CHED_STATE_ON_CPU=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:44:9: note: previous definition of =E2=
=80=98RSEQ_SCHED_STATE_ON_CPU=E2=80=99 with type =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make: *** [../lib.mk:147: /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/rseq_test] =
Error 1
make: *** Waiting for unfinished jobs....
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'
2023-05-27 01:58:33 make quicktest=3D1 run_tests -C kvm
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'
gcc  -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno-gnu=
-variable-sized-type-not-at-end -fno-builtin-memcmp -fno-builtin-memcpy -fn=
o-builtin-memset -fno-stack-protector -fno-PIE -I/usr/src/perf_selftests-x8=
6_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/se=
lftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../..=
/tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/../../../usr/in=
clude/ -Iinclude -I. -Iinclude/x86_64 -I ../rseq -I..  -isystem /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/../../../usr/include   -pthread  -no-pie   rseq_test=
.c /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/assert.o /usr/src/perf_selftes=
ts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testi=
ng/selftests/kvm/lib/elf.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70=
aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/guest_=
modes.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f=
55ff62e610c105089/tools/testing/selftests/kvm/lib/io.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/kvm_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kv=
m-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/=
memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcda=
ba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/rbtree.o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/to=
ols/testing/selftests/kvm/lib/sparsebit.o /usr/src/perf_selftests-x86_64-rh=
el-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests=
/kvm/lib/test_util.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56=
e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/ucall_common=
.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff6=
2e610c105089/tools/testing/selftests/kvm/lib/userfaultfd_util.o /usr/src/pe=
rf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/t=
ools/testing/selftests/kvm/lib/x86_64/apic.o /usr/src/perf_selftests-x86_64=
-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selfte=
sts/kvm/lib/x86_64/hyperv.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f7=
0aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_6=
4/memstress.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bc=
daba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/processor.o =
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/tools/testing/selftests/kvm/lib/x86_64/svm.o /usr/src/perf_selfte=
sts-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/test=
ing/selftests/kvm/lib/x86_64/ucall.o /usr/src/perf_selftests-x86_64-rhel-8.=
3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/=
lib/x86_64/vmx.o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae=
7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/lib/x86_64/handlers.=
o /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62=
e610c105089/tools/testing/selftests/kvm/lib/string_override.o -ldl -o /usr/=
src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e610c10=
5089/tools/testing/selftests/kvm/rseq_test
In file included from ../rseq/rseq.h:20,
                 from ../rseq/rseq.c:35,
                 from rseq_test.c:23:
../rseq/rseq-abi.h:40:6: error: redeclaration of =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
In file included from rseq_test.c:16:
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:40:6: note: originally defined here
   40 | enum rseq_sched_state {
      |      ^~~~~~~~~~~~~~~~
../rseq/rseq-abi.h:44:9: error: redeclaration of enumerator =E2=80=98RSEQ_S=
CHED_STATE_ON_CPU=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70aced56e5ae7bcdaba5f55ff62e6=
10c105089/usr/include/linux/rseq.h:44:9: note: previous definition of =E2=
=80=98RSEQ_SCHED_STATE_ON_CPU=E2=80=99 with type =E2=80=98enum rseq_sched_s=
tate=E2=80=99
   44 |         RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
      |         ^~~~~~~~~~~~~~~~~~~~~~~
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make: *** [../lib.mk:147: /usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70a=
ced56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm/rseq_test] =
Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kvm-1f70ac=
ed56e5ae7bcdaba5f55ff62e610c105089/tools/testing/selftests/kvm'

--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests-kvm.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
need_memory: 12G
kernel-selftests:
  group: kvm
kernel_cmdline: kvm-intel.unrestricted_guest=0
job_origin: kernel-selftests-kvm.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-spr-2sp1
tbox_group: lkp-spr-2sp1
submit_id: 6470fc736a565380d21713b4
job_file: "/lkp/jobs/scheduled/lkp-spr-2sp1/kernel-selftests-kvm-debian-12-x86_64-20220629.cgz-1f70aced56e5ae7bcdaba5f55ff62e610c105089-20230527-32978-tss40c-0.yaml"
id: 15caeab4a7be973b8f7605754d3a56a2dfc3dcce
queuer_version: "/zday/lkp"

#! /db/releases/20230519164737/lkp-src/hosts/lkp-spr-2sp1
model: Sapphire Rapids
nr_node: 2
nr_cpu: 224
memory: 256G
nr_ssd_partitions: 6
ssd_partitions: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX040T7_PHLF741401J94P0IGN-part*"
rootfs_partition: "/dev/disk/by-id/nvme-INTEL_SSDPE2KX010T8_BTLJ207201DG1P0FGN-part4"
kernel_cmdline_hw: acpi_rsdp=0x777fe014
brand: Intel(R) Xeon(R) Platinum 8480+

#! /db/releases/20230519164737/lkp-src/include/category/functional
kmsg:
heartbeat:
meminfo:
kmemleak:

#! /db/releases/20230519164737/lkp-src/include/queue/cyclic
commit: 1f70aced56e5ae7bcdaba5f55ff62e610c105089

#! /db/releases/20230519164737/lkp-src/include/testbox/lkp-spr-2sp1
ucode: '0x2b000181'

#! /db/releases/20230519164737/lkp-src/include/kernel-selftests
need_kernel_version:
need_kconfig:
- KVM
- KVM_INTEL
rootfs: debian-12-x86_64-20220629.cgz
initrds:
- linux_headers
- linux_selftests
kconfig: x86_64-rhel-8.3-kvm
enqueue_time: 2023-05-27 02:37:40.154292482 +08:00
_id: 6470fc736a565380d21713b4
_rt: "/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089"

#! schedule options
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 0e984e67854b3c473b40120ac6d26ec930844568
base_commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
branch: linux-devel/devel-hourly-20230518-155914
result_root: "/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/0"
scheduler_version: "/lkp/lkp/src"
arch: x86_64
max_uptime: 1200
initrd: "/osimage/debian/debian-12-x86_64-20220629.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/kvm/lkp-spr-2sp1/debian-12-x86_64-20220629.cgz/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/vmlinuz-6.4.0-rc1-00006-g1f70aced56e5
- branch=linux-devel/devel-hourly-20230518-155914
- job=/lkp/jobs/scheduled/lkp-spr-2sp1/kernel-selftests-kvm-debian-12-x86_64-20220629.cgz-1f70aced56e5ae7bcdaba5f55ff62e610c105089-20230527-32978-tss40c-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kvm
- commit=1f70aced56e5ae7bcdaba5f55ff62e610c105089
- kvm-intel.unrestricted_guest=0
- initcall_debug
- nmi_watchdog=0
- acpi_rsdp=0x777fe014
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-12-x86_64-20220629.cgz/lkp_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/run-ipconfig_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/rsync-rootfs_20221125.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/kernel-selftests_20230329.cgz,/osimage/pkg/debian-12-x86_64-20220629.cgz/kernel-selftests-x86_64-60acb023-1_20230329.cgz,/osimage/deps/debian-12-x86_64-20220629.cgz/hw_20230326.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20230406.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /db/releases/20230519164737/lkp-src/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
last_kernel: 6.4.0-rc3-00861-gdc357a770a49

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3-kvm/gcc-11/1f70aced56e5ae7bcdaba5f55ff62e610c105089/vmlinuz-6.4.0-rc1-00006-g1f70aced56e5"
dequeue_time: 2023-05-27 06:25:22.029405432 +08:00

#! /db/releases/20230526194351/lkp-src/include/site/inn
job_state: finished
loadavg: 2.48 1.28 0.51 2/1959 5051
start_time: '1685140046'
end_time: '1685140050'
version: "/lkp/lkp/.src-20230526-150030:03bcd2bd973a:5598789cb30b"

--E87YQmuknHbL+aHw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

ln -sf /usr/bin/clang
ln -sf /usr/sbin/iptables-nft /usr/bin/iptables
ln -sf /usr/sbin/ip6tables-nft /usr/bin/ip6tables
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j224 -C kvm
make quicktest=1 run_tests -C kvm

--E87YQmuknHbL+aHw--
