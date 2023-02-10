Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03F69170D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBJDPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBJDPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:15:22 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDD658EE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675998921; x=1707534921;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zARo6vKb9gkxzAyLcrsSNG2cuegGKN4SnXZGaqVGBGk=;
  b=FtWAiHpb2s9N8c4wc18hg9/o+UUvLycvE18G8VhhXN5lpBdE2SLoOf/S
   a3zQXIpCGp4jJHFAx62SB1k6TWmnG89pytzWufDHdytujmKawqS2LaG8T
   QFRi9bWbZx+kkQ8Ce6eH/oMmz6YS8fAkTQxJXyY70SHfck9V82cCb8/ZP
   I+PdJd/+e3PCOtyi3MF6ZsANvK/HvVFuwWWmz9lNlvbwEoWuB8AwgBRt1
   U0b1HlwFIpNiRdParTXyCdYt62Vr9ajU/j755PMFZ/eeudu5d8bqpL7ha
   whsdaH8FzKerxmMz/nVbRJ3KacZuutHl4igAlj5PvPBEcEeVqhSC8vb8b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331626383"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="331626383"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="810650104"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="810650104"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2023 19:15:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 19:15:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 19:15:20 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 19:15:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls65FqxuhJXaDnbhlXWIYqD/H4JW4Ptt7ifYjSO5UpUJkKPurB/m4yChMeJ8BZIiIgVFNhJyIoGqpdl3ga/mXuZPj/TMvE8XgXro/DPV93HbvN6gRGxVxlyKu1b4uiVIpndsbs1RvQvntxJjFU6fNEfMN3+Nu2Ob6rjqIWg9Pwtd3zMKTAtnrz13P83lphVazaJgZWh1Zz7PoU/hrcwi3KToDP3bzmiPH39Kv1IEzwyIRXx9VrMEuENfBl0Wscfux1qxpdV7YUvicK/iyADK1N7Ho5UXiK6L1UozmojRqY4NhpYFRF/SRI5i+cNDyzHV73gZ69fbotHQYCsmpm5S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GH6J6XCcX0u/Pi89Er4+oSn7VJGYtOpRqmjx3SOpzU=;
 b=MSr4q2+fzBL3yv86mZz9E4xQm96VaUwKMwhIPUI5FyTs8VTW3lZKweK5YglF5V/igUdqMtfjQeW2trX5R9LSLOfUNr5hOkgYDJh6/Cpb3NsEv6BVPZ7W8x/zRe6lW+TrTEyR+hq1bLe4mp8Ain9A4AfIRQNlSg2S/W89NseDZXM6iqMMlDFUlNHeKQgAxItN/UJE1jZLaQ+MkyDqcilySadnNmOSveawIVWm9oE7LbvtLqWLd75P4Xe2r3fHcc0gHUh7yPm5m+hHh8wado6LiU/6N8kZ0V07B32XP9r9IfYRWv5gIrDeykGjyrsY6V00TjuxnzRQ/s18w808fRiEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 03:15:17 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::66b1:16ec:b971:890c%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 03:15:17 +0000
Date:   Fri, 10 Feb 2023 11:15:00 +0800
From:   Philip Li <philip.li@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     kernel test robot <lkp@intel.com>, Babu Moger <babu.moger@amd.com>,
        <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [tip:x86/cache 9/13]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but
 not used
Message-ID: <Y+W2tFIfGJ1c8uml@rli9-mobl>
References: <202301242015.kbzkVteJ-lkp@intel.com>
 <Y8/XoT23HVXHSY73@zn.tnic>
 <Y+RjOpXP1Bbv268n@rli9-mobl>
 <Y+TCq4k+0AhfjZkL@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+TCq4k+0AhfjZkL@zn.tnic>
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|DM4PR11MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1b9696-5ffe-4cea-26ee-08db0b150856
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9HYZs3dPPaD9HrW5E0hK1/I9t5owckaktMQf7wg6DI+37h9Qc1u/5JyqbAn/lXntoq+eDSd6Cokgpojv3vrxTYOr0uTHgKsUl/FSLxp5ASI+4CKxo3D+ymOB6utAPTu1MrAROtOJPjUz0libotsbSKRxmt2Fa7g5CWS1Fwm3IaQlL/qKjNy5VFw8MissRFTnolaDddgCRE72HOZ0nk9rnXURxloYN6uviYzEv6RHfBydo8FtB1r51MIVrGONlVFaIm4kxj/fo9zC482dwBhQYgNHHVbL/Z07CqgQ4ZhNU5WQQGKxSFuJRaAKJ78cifC+9AX9JJeC8dmOlBm9+f1znRVo+7T2Bv0wTk8Jdw9JXl6bpmZDtONv34w9d0IaRMqNGrJ1EbpElAZ1O7fOszQ1pQzdR0/ZWp/2mjemLNZ98pKBTbZ9zeSiMmmOng9bMAvZsC+ubbNEGPRb/F+m7Ag+MBU3ouuoo3tvAwdsJMuV7IyW9DpeeFqnfzsEDYg8Mkn0IWH1fNa/JKBiiiFHb2eML9ZVPoupBu6ReSkvU9pdyWlX3zUzljuEfdfYwkgYU9qKQWo8kQOFu2xpeW9zUNuhqNtVP6tUUYZxMTwN4VkKmkyA3CojdO831ZetZ3CTBZrU2hj0FzsgH2uoWsVstgVgZxBohDReyVMX+aGlISYRmCriwcEXcy0lN8O3DM3kahXwzGHoGCLYpmwza+kB71ZSTQMGBPG7Z2T+sX55JQ0zATmxmJtPBcamxiV2LxVGzUKipvdSt4i92uIV5ObKSwYXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(5660300002)(6512007)(186003)(26005)(9686003)(6506007)(44832011)(2906002)(38100700002)(107886003)(6666004)(316002)(86362001)(83380400001)(54906003)(33716001)(82960400001)(8936002)(6486002)(966005)(41300700001)(66946007)(66556008)(66476007)(478600001)(6916009)(8676002)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehd4lVNatrTfMan8r+kkSzHb8NQnLqJeRQZMInuUuqSlbFJni7TT58pNryem?=
 =?us-ascii?Q?RvJhkE9igymg+kezgrRqi++xW5uxk5MHmDZ5KAwXckgOvRD8q5uSGvefJztW?=
 =?us-ascii?Q?zaai63zdEHATOqtJR5QTRdaZlsxxe0Xi3ZgI74MI1JmGcy9yD3XPVxaG2saI?=
 =?us-ascii?Q?Jkgk3tKjt4YKWcYydWoqAiE5S7tDTkNhKdb3STiTXzzMZ3csYNExghtlTB1W?=
 =?us-ascii?Q?n3Nzu/7u5e0XXMt4YinMNFCFOm47irJT95hVoE4J4OLf90QVX9gurHWn9Cin?=
 =?us-ascii?Q?z7ZyjC8g/yNbRD91WCsShLOm0pJgG//GGhFpFRm9h3j37Su82q555nUlQC0b?=
 =?us-ascii?Q?G5KIPQjcyWCDkDweyUdoPJznXzedyZeHn2DxL1XR+JwOd5HcTn/Hdoi6qw4S?=
 =?us-ascii?Q?p8gQ8ApMH9PbzaDDnxnVwLbkUIByFv3R5OspJyhAxoagvBpYuD2m40Eh6sNJ?=
 =?us-ascii?Q?jvO/YHAk/d8p8lWxI39T8TllmdngbvOIUToEAjGfBTElIgMy/NOcHXZl+Mal?=
 =?us-ascii?Q?FlG0kZzFFfNme1xFtUiCl6zul7zUWni7Hx/PoXWPktcS/xDD7W1qq24sxPqh?=
 =?us-ascii?Q?9fmv+IEL80J5TrzrW98EMoiWpTdvi27ibTPL+TvwZaP4QX/HS4dVzHYBKdav?=
 =?us-ascii?Q?mKl/oYit4hztziWsDD7j1MCRKbtEB6hfq4XbXvMbJZU/M88YUuLCYJC+eT/s?=
 =?us-ascii?Q?zR71v/n1ZGRTtMFysGeCN+MBd784QcFFQMdibVQrfOqsnBtMrzPT1JCMBqhz?=
 =?us-ascii?Q?4oGBL86YonWoF3gzrOn319bdlBln8cxResdMU2ujU8QcRmsjwQd9CX+7IEw6?=
 =?us-ascii?Q?1UT3Qr/uixVymy2Sl1I+XTdcb5xmR/iSln4c9ig1SsRi5veyWOuIGE0cZSK6?=
 =?us-ascii?Q?ay6l2GvwC6K6DmK5oNA33/sm5KnHvzALFMR98sKJmX1/makqo5oe+J8LnGqj?=
 =?us-ascii?Q?JAG31z7naOStPBQupaOzt2cMzn3ZM7CDDS5U/ddLMfo/Wqr8gqhk7jdWI1cZ?=
 =?us-ascii?Q?huD0XKzhdnK7BqSNaqbA31V0Cf0iuFCLPVAjJqX54aT8AaaLOJGyXOplnbA0?=
 =?us-ascii?Q?pYBgql+lphTdnjBY06xink3kKXl3Byz8wVzC+KYRpqcMAZne+uxf10fttVfQ?=
 =?us-ascii?Q?qoL5d9VhegIbTD+NDJY77h5Wx0oRALcMzmIYDfJlFePJdVkH96ybm5rWoAKM?=
 =?us-ascii?Q?dn+gNbiOrmD3Vn9KOlxowNOZNY4enmZlCjn6NzeiJ/SeyIoGuzq98lfoq2D9?=
 =?us-ascii?Q?v2PgIoQyYJYo2La53HXbTaoqy20CVyHtmcceA54D/PBnrYtBlVfbjEHp7b24?=
 =?us-ascii?Q?OIo2SwGv9qlS4uCcVkI2w6UEtxrNDS6iaw2dTorGjzBKkhgFddg/8WQgzSgb?=
 =?us-ascii?Q?53/13PtSoGCKHxQxn4L+La+pR9Cyv5lF5E5phQrWPMlOS9GbPZc00vRRRSY2?=
 =?us-ascii?Q?DAfnvvOizR590uk6LmytaYlDc77xhTAR+BtpvoWnmFdNIxwYRM5WVC1KCBxJ?=
 =?us-ascii?Q?NgTlKzTwOuUayRBHIbjMEFoG/Qw7aWs/s5P5vN/oHImIlKLDiS2LPNhiRS5C?=
 =?us-ascii?Q?Cc+GCvJbdVqq6iTRQ2xJBRQGcvLLsvfuY7Om7+InZQt1TQrpeXojwz02rjDY?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1b9696-5ffe-4cea-26ee-08db0b150856
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 03:15:16.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY2k5F3zo8SUo8xfUuQ9q36S1AyndDCxYS8ToEma2VTzYrDy1QhmYuNz/fGy1I+7kjAdhJCNSCmvJQsg0KiKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:53:47AM +0100, Borislav Petkov wrote:
> On Thu, Feb 09, 2023 at 11:06:34AM +0800, Philip Li wrote:
> > Thanks a lot for the suggestions, we will think of this to continuously optimize the
> > service. Right now, we try to build-test the patches that we can find a suitable base
> > to apply the patches successfully, some of effort could fail. Then we only test them
> > when they appears on repo. We will keep monitoring the patch testing status to see
> > anything we can fix as well.
> 
> Cool, thanks.

Thanks a lot Boris for your time and suggestions. I add some extra information and next step
info below.

> 
> I see you've started doing silly tests like subdirectory builds for W=
> warnings, picking one such report at random from lkml:
> 
> https://lore.kernel.org/r/202302091432.VgittDjI-lkp@intel.com
> 
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

Sorry for confusion, we do full make for the kernel to gather all issues.
And we try to provide a quicker way for developer to reproduce the issue,
thus the step in reproduce part shows the subdirectories that could reproduce
the reported issue.

> 
> and then it says
> 
> drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype for 'mpc52xx_psc_spi_transfer_one_message' [-Wmissing-prototypes]
> 
> Yes, this is all fine and dandy but such tests should be the lowest prio
> eva! If you have a way to schedule by prio, those should wait until all
> the other build tests have happened.

Thanks for suggestion, we will think of how to prioritize different issues.

> 
> I don't know how your resources are spread out and whether you even can
> do as many so I'm only reporting from my experience, in case you were
> wondering what you could improve:
> 
> People push branches to their trees and wait for the robot to test them.
> And they wait and wait. But instead, such silly warnings come.
> 
> So it would be a lot better if you could expedite such pushed branches'
> build tests first and then the rest.

Got it. Internally, we use the merge strategy to combine as many branches
as we can to run build testing, and bisect the issues if found. We need
further think of how to let high priority issues to be reported out earlier.

> 
> And then if there are no branches, submitted patchsets on the ML.
> 
> If you're trying to figure out what base to use, you can put a doc
> somewhere telling people how to specify the base for you and they will
> start doing it, you will parse the 0th message for that info and use the
> base.

Thanks, so far, we recommend to use --base option in our report mail, like

	[If your patch is applied to the wrong git tree, kindly drop us a note.
	And when submitting patch, we suggest to use '--base' as documented in
	https://git-scm.com/docs/git-format-patch#_base_tree_information]

And we do need a place to put such information, so people can refer to. Without
a public available site for us, we will update https://github.com/intel/lkp-tests/wiki
firstly to host enough information.

> 
> And the long-standing feature request we have: a simple web page
> somewhere which says how far is it with testing. So that people can go
> and look at it and know whether to wait for test results before sending.

Really apologize for this. Yes, we got the request long before, we did some
attempts to resolve this with a web site to show the progress, but it wasn't
able to be public yet.

> 
> The web page doesn't have to be anything special - just a table of
> branches being tested at the moment.

Thanks for the hint, this is doable, and we definitely need do this. I will
plan it to have initial version ready by Q1.

> 
> Anyway, I thought I should give you some suggestions if you were looking
> for some. :-)

Thanks a lot Boris, these suggestions are very helpful to further improve the
0-day ci service.

> 
> Thanks for the testing work - it is appreciated!
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
