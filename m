Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4F657C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiL1Pa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiL1PaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:30:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C837D1581B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672241420; x=1703777420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ToqJ4x3kb25XM6hJQS4w5aIZ/14eMTiZlFH18JEmhps=;
  b=SJYp7b2k9eOeNK7x0bprLlkaf6YzXum6FxRdqiRwq3RHhtFUC3M4SxZG
   rldlOo+7/TJ3L32AZjS+rEyijVZn4lxnKxK+4nt29/piH4QzrZ2zS1ROq
   as83j0cHpBvxKNenmhhOhEEotHAWFh8Z6mq8BZJPkTFEwssuScB8qDSl4
   aKIxlkbX2MXUF8WDB1njTPU/Vc6974nPOBN1OyIf3rMuQadTSBrvegxPk
   AiVNE/WaIts8IF/QVHUqM6lP0ckpa574ZfOndes+YbzM4dur9It0Pwxm6
   UtOQrd0g3MW5ChV+khlzBGuOFFKgKaHu2/wpOK2AadndFLuHT9ptrxCNo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="407153503"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="407153503"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 07:30:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777458395"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="777458395"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 28 Dec 2022 07:30:19 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 07:30:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 07:30:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 07:30:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juFCgv+PHpYar1phrHtTBzFiBgantB8DRoBU65nmBm4wIcyS4X5LQqi+llzQXwulKRuF/59FIWY0BMHQoaPtiTEIySNHUyCn3qXP3b8QB2K97ypxH0P9Qn3prgrZ7w+Z3L2+JQ4YvAQ5GcEW3NIioK/zXB1IBTjrdX9rVdbMJm1vAFZUGEahVX2bVDuGNqt/5ZcNfLK/6cfzL1IHLnzY8wKAirfTCuOo8+MqNdtS2jfqs8dAS5t3fhpB8mOYFlIC+ZHcyGPmi6QDRPkabmNo2klTG8QpSjExBzKdbHwIXG7l7ikgJSsS0G0TpLFyxTEnf/7Sm3389RfotoRdSnBg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCnuPzags8wSFvdDopjzAsAVekSXk6NtpW1N1EsPwMY=;
 b=HmtZg/Gas0JFrlyRXhia5ICTb336R+cJB0aTZ5QjAm9ey4hsBq5Pr11Y8g1c+a54UkWJs2UV5dbsf5M1C27WgvTTzyg6nxbKuy8UWCaQz2v0ayMK8EUJuV7L2c9KrA9NM1CQYyLtk42LKTfcrrtF6ATEqp7WIxbOyta4SzoU7xZZZMZW3CiBoE24mMTEzzVzqqsRtL9pw8MKrPBOqoG6kNsicqDBkt6dNaJkD/7gWwu4nl/przCe6HX155X+tOXQJlOSxTUK7HXXGXFmtDQAu3D5ZLsbl+7P10DfyMMTvtkVz22kX5cfC511vff06GUUypI79Odl5meRbNSQoH5Y2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DS0PR11MB7879.namprd11.prod.outlook.com (2603:10b6:8:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 15:30:15 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::11d0:8d26:91be:68b2%3]) with mapi id 15.20.5944.015; Wed, 28 Dec 2022
 15:30:15 +0000
Date:   Wed, 28 Dec 2022 23:29:52 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
CC:     Valentin Schneider <vschneid@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Message-ID: <Y6xg8Ir9hQ+H/+uX@chenyu5-mobl1>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
 <20221224052850.GA8245@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221224052850.GA8245@ranerica-svr.sc.intel.com>
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|DS0PR11MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e46774-600f-406f-641a-08dae8e86ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Z9xdgYZkdehiOL5WwlzkoYsOKd7f+ctKJFas/dsHOXlgBGMLfQw0V8oD6suc1EsCEIlxEHHUIFvRCUWhT7IJmO0cPy15GtXoIkEfRm6bisBU5a/tjiTzyKEzs2wjxFVOWhsj/+KLcd1AH29472eFVR5B+mEhAKq6OiEV5MvcE2wJQdBC7RKO9hZYTgVs3aytsST+k0E99oa1D+8vLv5LbjImLPz3Vzc6WywIP0s1jH2rdaRE2G5s2B0dDguz9PZ5ryG6quU1QyxyBl70XG/414YVcuscZZcuskfs2kfI3O5BWldLqsniOXDUh5yOSuAJKQPC6Un25LUyDXweTc9cyVGEeHtr1ZmxB2eKm4hrNXP6h7kf59UKgVlf9ovcbJ3STS5P1GF/itKT6Qj1ypBt0C2nVj12IX+SFSiQrc1fLmgCTQ5xTQIzuBG1ZUCp/ORwAsJxwSr6kFCoGnhyvlOf5wfSgj75to/SUsbn9H1rTJeSyhKb0dBzbtw8MwlIic60DbJa2EYkegOg5Zd8kTukmbojH0cOa2hTmgBUqtFdvwdN57KWsC2aln4XaSNh+Ju5Nf/SDj1vsz/Kz/B1kgaP4Ot2OtTtiClWenrAvCFidu1XWknWnRChA+kxjkv/1+qwxZB51c5y8SAv6C+jI3SWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(6486002)(478600001)(86362001)(6512007)(26005)(186003)(9686003)(53546011)(6506007)(38100700002)(41300700001)(6666004)(82960400001)(5660300002)(7416002)(4326008)(8676002)(66946007)(66476007)(66556008)(33716001)(4744005)(8936002)(2906002)(4001150100001)(6916009)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4uwRt69tVuljPiB/27uXXnimDEmuRLSNtNqeb9Kn/szgAFaLooVY+OCu8rS?=
 =?us-ascii?Q?Wib4kjnn9t3qc+yELiC6yY5TeQPehaHGUr6WLSAjjqRtSnsmEc+e2PCfiYT9?=
 =?us-ascii?Q?KrkYisPAFef/cfTLOzCsEb4g4/WGCSCGahX69TTCnG7I/YckBk473BH7zVZo?=
 =?us-ascii?Q?8rSHIzOfFnAwAbqkT+XF48fTrZRI2rGi8zs7NWXCEiN02krGzf5PyO9BUWy8?=
 =?us-ascii?Q?mVqlHPwWabIUfvzOwjJRjCHAl2ADrEynd/hxX2QRAKJbAzeQbNwAj29dhadH?=
 =?us-ascii?Q?fHcjdCxB9ZI93rEGhkRk6AU6V9J3Jde4VZ6B/dgG+NwJq02yDFOXQLpLnh+h?=
 =?us-ascii?Q?7bqKmoFfcTzginSQV38SiKL3TlXA+O4CNHHu8HtZRq5FcmPXxddtp3ero05+?=
 =?us-ascii?Q?0EtAwHqIvnY6r3bNKucKW3/LVncHZ0x4oE6c1NWRnYuJtv2TumtA3utIngve?=
 =?us-ascii?Q?2WeLf+qpUOwXIPpgmByqDpNDtmfmO04612R+8I9vowQG6Pay/bcZjsCd9IYx?=
 =?us-ascii?Q?wh5d2GYIBWhcN2gQScYwnCzG51DHDjDI64NoDfxiQcnaI5o2PSSjJEjJOktf?=
 =?us-ascii?Q?xYWApwF4CO90CbFjybmjsgKNUVtqZl3jNkQOvUvkqlM65OIpo7gPu1Py6ohH?=
 =?us-ascii?Q?4i3iykCVeqZqtQMD+7QO4kzOisStlqb0hErnJN5iKPUgUpdKmqn1eyx4HKeQ?=
 =?us-ascii?Q?xRLw8RDcdt5dcPLfoWIBOCN6D7vaaBJkzHc2gi1GmOFa8HlVI0RC0YGPij1Y?=
 =?us-ascii?Q?R9Y7WuEt5NNvb/CWd2VuG400dbw4PM6oHmOA1wolui5eaLYuFP59DS+f93Hy?=
 =?us-ascii?Q?bPijfK0waZz0ecR2pDyt5z2cfbv5T0qor1+Wm0BofquQQS+YVVkEVBs1IAjP?=
 =?us-ascii?Q?5APjzXK/1LKSBlJ8Kux4dNsi7o2iSSwUdU72mBFKBXZDQUu7ftaTXWgMuWbm?=
 =?us-ascii?Q?HmYvuTK+oa7FoNh0BczaVcUliZl0gl+vWEo5LfTbjAeXFGADYWI+0YbMISVp?=
 =?us-ascii?Q?3DmfTT+W8VzviUisHTKrkrGzo8YXvoc81ARq+GnAsbFrwYmHuoU07H9nhGmY?=
 =?us-ascii?Q?L7UuI1EDtDx8KD/kZt8bnUSNeTkKTV1hspR307g8+0gl3O36oTVW25lyoEsA?=
 =?us-ascii?Q?CEESoxS8Bys8e3Yl0SGBPavIdZ5PhsuSogD+01TWQwL+2Frwln8un21ERWO/?=
 =?us-ascii?Q?p0GlIzaUnUlRW3bwEiS1AK0p+Kfc0FXQv7QgPZQ/3hFJvTuYQHS+OGi7J54Q?=
 =?us-ascii?Q?OEf2E0+/RYL2L8i0ioEurpSbB2Ak4uLCGHRDpTszkCRi64DwcJqhDyw6cXn2?=
 =?us-ascii?Q?33khXRTIOzzCEz/z8RFPbP2yrTQXaUlTUlDO4nHelCDlG5J9dVhgy0h7IY+8?=
 =?us-ascii?Q?EjG0j1E3a0eldPmsN0V6S7/JfQhkweEINr7Wu+EYkKPjdG+eA4WpmwxqLKi/?=
 =?us-ascii?Q?4XeB/ZOBtF2pMV7dATNViC04C9PM/EgRB8wuR4pnX2yjj+cYdl4HlJV1TofO?=
 =?us-ascii?Q?WP6JOJ6YgG/jaRLjxLb7+rv87vy7lz6mMD4CJ+x6MVtR3bFQKSAzNqTU4NIT?=
 =?us-ascii?Q?kQxIoBfM0lB4jRvcEgmuPab2e8yEtF5JtGmbGyQ9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e46774-600f-406f-641a-08dae8e86ac2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 15:30:15.0183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U+vUw8oBu2sO425Dj/lW8vsC7b1bwf8Y5Bvyhg9WKOq9ui8RGkL8DK/CcpPb1TFb8T4KN6mMwJS4QKXynPQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7879
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-23 at 21:28:50 -0800, Ricardo Neri wrote:
> On Thu, Dec 22, 2022 at 04:56:22PM +0000, Valentin Schneider wrote:
> > On 22/11/22 12:35, Ricardo Neri wrote:
> > > Architectures that implement arch_asym_cpu_priority() may need to know the
> > > idle state of the SMT siblings of a CPU. The scheduler has this information
> > > and functionality. Expose it.
> > >
> > > Move the existing functionality outside of the NUMA code.
> > >
> > 
> > test_idle_cores() does something similar without an iteration, did you
> > consider using that instead?
> 
> IIUC, test_idle_cores() returns true if there is at least one idle core in
> the package. In my case, I need to know the idle state of only the SMT
> siblings of a specific CPU. Am I missing something?
>
I guess a similar one is select_idle_core(), but it also consider the CPU with
SCHED_IDLE task as idle. Is CPU with SCHED_IDLE task a candidate in your
scenario?

thanks,
Chenyu
> Thanks and BR,
> Ricardo
