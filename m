Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88EA5B82E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiINI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiINI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:27:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D776525D;
        Wed, 14 Sep 2022 01:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663144035; x=1694680035;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3UUYnny1iBpYJjqya/EcsYb0kXEtPDG5k/BilNXUlqo=;
  b=mwpn4k08LdczTtj0+3WJV9AqCRrYSkFVmOG/nEehtqN9LZpvTJjkI7oF
   /ocIOl6qQkFGtnGcoSMOev/YGrFmSuaxp4nOmbCP8JlBYjtVF3EpCGOB0
   R7cP0d8i54Zo/KibWG+Bs6XusXPt7WyL7z4n3PDwfgfG4s9ZWycE+EdVS
   AbdKbShpxCndm25cmT9EJiWH3wK823xgJRP5aSsfyfc52RpS+xqundFDV
   YRLTc8hozV3FRpxCYayvPkTQIay6SeyvI08fuBkAWD/+kJC/9Ep95Q04K
   twoum0Qe9j1SdjDFX/qDW6Ty6XQbSBPE2VUGS+EMC1NYRrqYfFd9aS8/U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285410950"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285410950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:27:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="759131258"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 14 Sep 2022 01:27:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 01:27:12 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 01:27:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 01:27:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 01:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQBWQhGSD3fT79CpgomTF9h0+Vzq6CxWyJIq8MCheTP7SldH3DfITsDnMyLYXW/qh8iYn+igkt5O1eYguNw0Uh91GqfgCqNu6PR5s1itcrxARMIstmRfcQpiT4Wu7yN3Zl7EcIOgkREm9TvaDztxHJZhSrIKyDYn8xDJp3RbgqoBo8tyggrNP4GgD98ueVUvYqK0N/SfOmkFIyDhL6w9O+NsothCEBdIutzJgpWWJ6YlLQ7TCaLwgMyawYcjH9USrHabJE2/Nn59AsaN/EdCP6RX9VmEZfCPzF2ESjiMAuILFlO0fUxKdHaJFifX1c8KrpxMsGbkcJuiBJT9WLzTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyC857AyAw6+zCncxtPxFhEEJa8MEx3MB2oa1aA6GlY=;
 b=fy5uj287Dg8cnAodd6iHDvBp9ZQr3Az4YkIBGhqGT/KZijEKgA2+UAoh+xvdTDjKYBOxRq5CYV3wPJZ3GVKT7DV3TdaeITHTunrbyyL4tD/u40wcnbAMAg4MKP4VZ3vzLrASFgqTs8bNvODfSWYePEwnLWBpyHbuQOwcYgmezYHHsHga7Ris1o6NfO4btaa1BG+rVYvnlgFzbndSFRE5N2+slYdBKKRFZ0WR5UU3UZzW7UDDhOuMD5BPqzG0MsPeJwcFkPmwRCzc9zMKNhh24wvpI5DVwLd/tfPkKWPSWjt5DD1NJUpVl3WCh0G5DWXUVknHtLLeKQN+imtDYKx9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by CO6PR11MB5572.namprd11.prod.outlook.com (2603:10b6:303:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 08:27:09 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::a022:f698:30d:3779]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::a022:f698:30d:3779%6]) with mapi id 15.20.5612.014; Wed, 14 Sep 2022
 08:27:09 +0000
Date:   Wed, 14 Sep 2022 16:26:58 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [cpuidle,intel_idle]  32d4fd5751:
 WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
Message-ID: <YyGQUu9S+ISHaNFi@xsang-OptiPlex-9020>
References: <20220612160006.GB35020@xsang-OptiPlex-9020>
 <20220623112358.chwk2ld6k6sufeb5@shindev>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220623112358.chwk2ld6k6sufeb5@shindev>
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6297:EE_|CO6PR11MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeb9f82-4222-4043-282c-08da962aea6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/PV8vidgwS4hrSx+U2c/Swoc60JtUsJXTSupibDCBzSZwmg5tcccRMBG/sf+eoxgvZp/cAG9vkAjEGzfZBZKE1oqJC4SnVqARdXgtxK0NxJW0lUOFdD3AwBUFlvgw8zzZAbxnHHS/REeh/EPdYv/cp4eeG0sSz1vylc6uyowCj8SkTiqNZul9B1Km14NbNIiOAIBwDcPnu8KE4iI1PxweAoumHmsiqZjXaf/zMgK3fDZzlVDvZ4luQwegsmd+kbZshxO/+gtEEu9isKCDXXGxUd5m+/NotA4QeFIG11lTcaJ0CE6K/u5ZpX0vW6IJmYC5Xo89+4dSISvaI66WdpntluhfcSFGrYEhJz6TTTrK/j1CRdr2fSgB6pfhLzZFQtzpeisF1qHVSlQGaxFvc+5G3TUm67SH051N7AnkteJyuHbBNPt9IO9WX/FlUASvphnumpk3Xw/pXl0N9Fo3PwTMz/DtS+eOu/2XqjMLo/yt1TQ/b0js7wwCqwMCOtXjaNcVj8dbIvL6WFMSmzXXizAPtbUCU58BpRFbPkXt0M347WZ+zkGK850s0YCYxlqJOlxi0ha/2tm5/IBEzAPaCPYRNb6lcUVqLmT1tHZE9+wS0b/fJEG1Luuk38/6s/DowE+DC9fu//m+RjykEXgxBWOUiv6xbl41SDi/eBtM65GxkWVOgiay34EhnEfPeBzeqbtq4l9CqjwondoQ2UcLG3tZX9ANVxD+TZRSN+T3qnrxKigZb+YJioQ7q9dpn4uV+JIJ2mH0Z0GM78xPkPp5Kk9TtZyuFj5zhOByCZT+dFtKlHwTDu1JNyCk6C63bpxsFhvuZNT2jHfmWhkCOcgQKwUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(44832011)(9686003)(6512007)(186003)(82960400001)(41300700001)(6666004)(38100700002)(8676002)(4326008)(66556008)(26005)(5660300002)(8936002)(66476007)(66946007)(86362001)(33716001)(2906002)(83380400001)(316002)(966005)(6486002)(478600001)(6506007)(6916009)(54906003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVYb2+U2sVbJmbcSbCPifK7UnC5EGu+u4rt6/vK8m1glnQSjZhkiIOzPv6qe?=
 =?us-ascii?Q?PAzNN9PVhrZedmaX00vVbKRO+jlv7gY8WBHbahA4akX6XnHfvIK0o4ca+x1N?=
 =?us-ascii?Q?hgK/2ARPUo67Wz3Febv4Cr10e5grWQeMBnMimmJwzq3gx3nkk1SKPrH0CuOB?=
 =?us-ascii?Q?pxcmcR0YTpVjozKZBdWwqjWs6BWjDofjWQxqedSa8IDUV+sJc3RrI8V37JPT?=
 =?us-ascii?Q?KlHNOv+0N/fhrvOLh0qLHVUR1RSREvkxh926Ly6wmvkjxhx78CJr7Usbi8dB?=
 =?us-ascii?Q?9yokNGVHe4EnYYQOR7FmObDaeVYGHPlFoqvpJW+KHLO357WpOVAEbtgNW4j4?=
 =?us-ascii?Q?BCWzs605U8EzNXgwSa4c3fwcb3XbHLJwCDo10QhicjgebQqhms+WfxAXmE5P?=
 =?us-ascii?Q?E5C8TNtDx1HDTK+8i7z8ibJoY2R7bPSLPIjMZsv46AZf8lJQgE725wdF9XwD?=
 =?us-ascii?Q?zpxmkMBv4Bu4g7hxfY0EE9w03Gh7MvS/kefVkqRweIW8H2gXN0/vgOEkR0NO?=
 =?us-ascii?Q?4gu4/IXdv8cZIXxePoWEBaiieiI2df/XQ7xgeZYN/wnZ9XqVEq0fosain9QG?=
 =?us-ascii?Q?oXkcGxg9MoG1x4qxGBvhHrpPgaiu9ANiFrstyTwoVC+0FH+7bGBZxKv1Jq5H?=
 =?us-ascii?Q?cXaBuCxVutw3Lq3gcHnWUelallyN2ysPFc60tjWrJEFGuJXYqX6LXZPM2e8J?=
 =?us-ascii?Q?+mJAPfjyUAey7q8ll31dq4LYgRtX1OmvuHv3d7SdKcgC2xC5WI0ZiaFwaeLR?=
 =?us-ascii?Q?VbpYzsrUI/I8MWl4WXWQYosUzH4LGwOBePCQmo9+d3f5R1cKbd576+uGNUQY?=
 =?us-ascii?Q?JeIjLqTKT8OopmMmBGiXIgmXlwEA6nUJubuslwQddGSdffhsZVWuXp3GwVs2?=
 =?us-ascii?Q?CoSVMbfnHw/enDdBTsI8F28eW4MNXs2bE18HGX/TcljgMh9x+uR76ZOsJJGu?=
 =?us-ascii?Q?9c1oN11RAh8pN39DhK6DO5/v/ubk6BohdWqKUkzFnqoXx/vGwB75lNJCpjho?=
 =?us-ascii?Q?YiH8qvl14ZP+MyDeLw7PSDfbEEpI30twYvxciGV0h5TjBkbzSFABOrpltarT?=
 =?us-ascii?Q?e7TtU6Hpq4z+NSLIoKFt1I4b2+V+PONOnj7qEtg48omaFaP1r8XOKhOEtdhi?=
 =?us-ascii?Q?G2mPHrgV6vuK4HVBXOBxkxOcEhpSrhlckjm4KRDzKfuhujFlJMvOslQvcWCV?=
 =?us-ascii?Q?waqpzj3KNVet0dOXe2xtbyqTDlUGZYYaLhZdJGl85PfW1ukIjS/zQZl4xBv4?=
 =?us-ascii?Q?I1aIhqjaGGY8HOcj7AvgVgKisjpbNv/njdQbOxzgp+fuKUOcclLsC2K1XIG2?=
 =?us-ascii?Q?5Pvr5COAiwFA4t5L4vIaNTqaoLXadEUT/nFSfmmcIZSzQly5v6bRjRSinxuZ?=
 =?us-ascii?Q?M1M1FoRRabod7C4sTGDmbIFnFhJ8DdFve/0h2yJnE5UbgFrIqRa0sKdrYw/u?=
 =?us-ascii?Q?8RV4wFH+bW4s9GSe2aqtryPieb2hUZWulD0rRCxiFQmbFhqoyJgzK1xWcQLW?=
 =?us-ascii?Q?FLAqJDTk9Ypw98onsFfmrqyJJhXD0ADNRa7Azxhq4Kchzfizb4/GWmBSe8tH?=
 =?us-ascii?Q?3dM+F/HoRX/dvdH8n0OMWM/F2N3SQvzLWAtUGTV68VlTXhJBhW+tl4jjJne6?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeb9f82-4222-4043-282c-08da962aea6f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 08:27:09.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpox/gn/Kf33h5WcLP2zuUN49Hzu+1OiNve/yvp/bauTK4uQZV4l1lUETIoHueepqLhpQhbRlmexjJI7qktwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5572
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shin'ichiro Kawasaki and Peter Zijlstra,

On Thu, Jun 23, 2022 at 11:23:59AM +0000, Shinichiro Kawasaki wrote:
> On Jun 13, 2022 / 00:00, kernel test robot wrote:
> > 
> > 
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-11):
> > 
> > commit: 32d4fd5751eadbe1823a37eb38df85ec5c8e6207 ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-cef46213-1_20220609
> > with following parameters:
> > 
> > 	group: resctrl
> > 	ucode: 0x500320a
> > 
> > test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > 
> > 
> > on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > 
> > 
> > [ 29.104402][ T0] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:864 rcu_eqs_exit+0x4b/0xc0 
> > [   29.104417][    T0]
> > [   29.104418][    T0] =============================
> > [   29.104419][    T0] WARNING: suspicious RCU usage
> > [   29.104421][    T0] 5.19.0-rc1-00001-g32d4fd5751ea #1 Not tainted
> > [   29.104424][    T0] -----------------------------
> 
> FYI, I observe this WARNING on my test servers for fstests, with kernel
> v5.19-rc3. It was observed at system boot, and was also observed repeatedly
> during fstests run. I reverted the commit 32d4fd5751ea then the WARNING
> disappeared. The WARNING was observed on systems with 20 threads CPU, but
> not observed on systems with 8 threads CPU.
> 
> Looking in the commit, I'm not sure how it is related to the RCU warning.
> If any further action on my system would help, please let me know.

recently we made further tests and confirmed the issue is existing on this
commit but clean on parent, still on test machine:
  88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory

=========================================================================================
compiler/group/kconfig/rootfs/tbox_group/testcase:
  gcc-11/resctrl/x86_64-rhel-8.3-kselftests/debian-11.1-x86_64-20220510.cgz/lkp-csl-2sp9/kernel-selftests

commit:
  v5.19-rc1
  32d4fd5751eadbe1823a37eb38df85ec5c8e6207

       v5.19-rc1 32d4fd5751eadbe1823a37eb38d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :20         100%          20:20    dmesg.RIP:rcu_eqs_exit   <------
           :20          95%          19:20    dmesg.RIP:sched_clock_tick
           :20          90%          18:20    dmesg.WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
           :20          90%          18:20    dmesg.WARNING:at_kernel/sched/clock.c:#sched_clock_tick
           :20         100%          20:20    dmesg.WARNING:suspicious_RCU_usage
           :20         100%          20:20    dmesg.boot_failures
           :20           5%           1:20    dmesg.include/linux/rcupdate.h:#rcu_read_lock()used_illegally_while_idle
           :20           5%           1:20    dmesg.include/linux/rcupdate.h:#rcu_read_unlock()used_illegally_while_idle
           :20          95%          19:20    dmesg.include/trace/events/error_report.h:#suspicious_rcu_dereference_check()usage
           :20         100%          20:20    dmesg.include/trace/events/lock.h:#suspicious_rcu_dereference_check()usage


as Shin'ichiro Kawasaki mentioned, the issues seems not be able to reproduce on
systems with small number of threads of CPU. so we tested on a vm which only
have 2 threads
  qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

we confirmed the issue cannot be reproduced.

we actually don't have related knolwedge, if need extra data or testing we can
help.

> 
> -- 
> Shin'ichiro Kawasaki
