Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF93562200D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKHXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKHXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:06:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD264A36
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667948790; x=1699484790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tqjIW8L5ZljjBWE0RAzUKYCjjag903/kjlVxTCtHRJc=;
  b=ct6N5aFYmjmGTYsZgqP1eBnzEThypMJvpwAuOov87Nk7O2CwNaz/suQy
   iQ3BRddqXlk2avv7DFyySN72Is3/HNHzLUlu/rQnCSnfMr8kqFt13Urao
   jqQS+5K3T3Sld+g4A1gRB+zV1nsdEfCEjLapatRZcAjlpywuTfgzN5ZPo
   Czx4PUukDATFUWp9Hrdycq47Od5p6jnB3mMAdZfA3ZUcHyabHdA4nDqy9
   De7AXqhaqRzeoQ4ks5XnfmJBD40mej4dp1r8Gyh0OAzSbGBVGnTPyGTKk
   IuuGg3a8dBa19rNWVWtf01igGo2GhYXpRmhepO+5ysvHcjFF0Bx6iwy3a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298350166"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="298350166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 15:06:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669726528"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="669726528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 15:06:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 15:06:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 15:06:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 15:06:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlJhYXqWMgm7LeZS0eCZnIUt3xM8FeYc1SZL0Fv3bsJZEfVvvSP2jAU6ekvq4JvGB+Rg9MlRfS9kvmlxhKY3t9TTb80j8apLg6tclTafXs6gWP0akHRqx7UiyDovZbTtuAUsLVMdklrWQLK+gt9sUCuQy/c3F6G0d7R2GvN77DM5b81ZngOdr8K9CUI9/j6/6HF4McL+ck76YyOg1c2Fi5shdGzDBpvMW75jdntumq6djprU280iUI9HTZp9KCgc9eICgq7OaONcrlEj8csDQBLAU05+SmtAdh28AQa3dqc0MVDH+OZ7JU/qt3kBKSNXbsZAyS4HWxCQcQ/gS+LZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyTDsSB01DNnkOCAR9h2J5fJBd8Qh38c1VyJMpjQZqI=;
 b=VgHlyS+g6i08+8HemUWRPVXiq56NbwjmJbFL74nyXoz/v9HCXvysi4Rz2oPM2CfgpKaXwKPSAWun96D0HkPPJ+jUCcAQDon72xwChU07r0q/a/av2FUKGdfdHHRXhYQIC5F3XkHXnyerDpgLGhGYSyD2pHWZMoX1NILe4isFmY59Y+urHC7edQzS6rMs0KIwA55lYtRPVJ96T0odP5ei0akxkXcp2lrwJFvwo/s7gl0Aq3p/bqU1DrBiSvEDY1wsdFtw2X3m6zd/JK78SjHgbEgAUgHXGGaAiBPJHhpUUCz+UHBWyXi/DrxI7nNoQs+Iux8E2c3p7T8zVkwqS+76JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 23:06:26 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 23:06:26 +0000
Date:   Tue, 8 Nov 2022 15:06:20 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Jacon Jun Pan" <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kai Huang" <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2rg7OYkhtTWQVNL@a4bf019067fa.jf.intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2e4PgwAEXuFzoMd@zn.tnic>
 <Y2kuixb0RU9BxKls@araj-dh-work>
 <Y2lSyX+YS51dxAnr@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2lSyX+YS51dxAnr@zn.tnic>
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|LV2PR11MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: a5aacb9e-0a87-4670-4d85-08dac1dddc87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMjJVu4MhIXeS6RXIoi5NjM3/Uv6G0ye4/M1iBQzw50cUIm13DAljwqujX6uTfyb1oledwFzUwFhUGI0HDAdNa0RGl5yt0DyiEum+k2gzIUl3F3qPGwvnoe4TaiFk4CESc2RydKRucgtkNgR79ow0eDb0A/AklWKmVkqdcuAKPdqDH5h8Lzp4+hVm2gQFdjkUOVU5Wh+yjwVjJ56K1sPHtQNbixBM6t67DaNGdZMzLHjW2pLh0Gx4Zdnt5FWrDtpOheK7cH9hrREy+lP8164BN2khVrlOetgEqWomgXyJAqj/Yi1ywuUXbyxRR3EHFyJLRrowVsweAu3CPClQaUMj2oBw74Nb1mNDNbiWGclbSfcQj0d05FTyd+l8HSqYvpATqULKDjF7JF+B4hIXB7fi0dhaAHcMAmZgNkifgh3JcfR8VTNrxxx7G+pqJ55LQ/iOTW3gkG0xVI+Qc4iGII1ITEYdUY0sDGkAoDFgD2eLeGs2SDee9PDcpZmtoicbjsTXrF9VYIF3AXaLM2VfsotBC85uma0Rk96bUXiYsQlpQMbzhR1SV/aVugOIdgDfbKZ4xMycDnhAj/40GGwJXEa/lNUcmSJulT2QgqLs3rZMR8beauComEUw3XJvPtrGi2fxQMFEaY+OqcxlVPeb7JSZoUVJ8z/FkdQdRjIZgpvFN38ZRvyJKNe3eAN2Bl3+y8QZEiJ/kQLRjFDPeyYUgpFeOkAlDAStc+tX122olVmyhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(86362001)(41300700001)(66556008)(66946007)(316002)(8676002)(4326008)(82960400001)(8936002)(54906003)(38100700002)(6916009)(44832011)(478600001)(966005)(6486002)(16799955002)(26005)(6506007)(5660300002)(6512007)(186003)(66476007)(15650500001)(66899015)(83380400001)(6666004)(2906002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TGXyUsd9/7uxLnnGAAYqByNpnSmVmFdLPoqN15E4POKHgcvQpy47hvXoQMgy?=
 =?us-ascii?Q?2SUQMTLZNTbBNbio/t4bb8/9ZmuyrxTZr/bhwXmgg5EZielsWw7nQ2RRfgN1?=
 =?us-ascii?Q?gVFbp/8i2tebdVQjySACNIM172CxrNa1cmOfUSFJPsaRQk31/9PqlCeKKEGC?=
 =?us-ascii?Q?NxraOVHbhmD+WrxnUkzLcP5lKQtKLM+AbvJDPrMzKsGDaNfyiacz9FBL8VQ9?=
 =?us-ascii?Q?ccixkXBnj/cDDiIBGPvZSkLqn4SP6nQHH/cKByfugvb41lHT0PMKryf5H2Qv?=
 =?us-ascii?Q?sVu1NgOOGbOam/GIgfOc/k/F11nwWS5Qn84EmyyoL9ZDM8Kik/KQ42Y5JErN?=
 =?us-ascii?Q?h8B2UGJuQSbKRJdEGNuUhe41MZzMaTyrKeIofjiC+iOX9BK1uvl3vavb9UT+?=
 =?us-ascii?Q?M0X4Bn5oabXv/pjvXwsbb+JIko8lPpHl5RiK85UZkPlEdOapNsbKVxfZjbMa?=
 =?us-ascii?Q?8icgE7a+7jHpjIutWQ+o7FFPNj+8VZE9aoYBmGNTlxK+H1Kf4TzKn+SpMjpq?=
 =?us-ascii?Q?rLD6tVuCe51Et9dzwecS5uM3TXFeMMK+goQErZlO3Tw4uRngG1CcreKUyLA2?=
 =?us-ascii?Q?VqQLs+T30Ikh64vylW6aqhG2uIZ8opsHAjzreA9J9q5LDd6nhYuLNzps4RsU?=
 =?us-ascii?Q?glGc0HpOX/tmdiwq0ipGvVI/obWsC06/G7Cf1Y+ZjPfR5SW5UQMdWMIm/oX9?=
 =?us-ascii?Q?USLoSLlenx/lFR0FiNTkC2dMBUb9A5/brIQuosEOqLCKsXlLizrVB6krSl6U?=
 =?us-ascii?Q?vDp1gDQJ4BcQaOmR3O68jgsLehrpvMgIxvX2RjekAEHXWlUXgsU1Ce8iPaWs?=
 =?us-ascii?Q?1Zv0uNFkAA4X25ZOyWK+lW6cRVHeWQ5amceOezxk3EcpbHgzSAm60VbnIabw?=
 =?us-ascii?Q?wPo77bbnEnfP+yX5jXcHQN95SLDoTLlMWe531i+bVjKp+A0jWorcyOGHzFEu?=
 =?us-ascii?Q?7u7IgLpK46GIh5zgHrIP+7VTShO4GhY39JHUAfYnrAThEzYWyqllpMFPomXr?=
 =?us-ascii?Q?ezQkMg3pzwcsR/3ZXqP9T5CBg5DqNkyvSGxAX0Lozk2Ewl78Rl30svH5JL4c?=
 =?us-ascii?Q?GZ76PW1RgjT/uBCYekGTX7LM8I5Jev/4uF3iDcLV/uv2EVyLjiik08ziN4bR?=
 =?us-ascii?Q?ZRgt+HpLt6M6pitlpTeqvTnchWhBYQL8x7wqqdeShtYNi9re2LLa2PF8PIYh?=
 =?us-ascii?Q?SBrUiHdttGK4D8P4CDLhCt57sAD/50zu+cbX+WZsRWREeLU1hty7m1UXU/SV?=
 =?us-ascii?Q?lUxppPKPfgxhbw3GoXS6Wit6mxfKrUnSJUTH16e/78StM2YWepQ6SFi4TahD?=
 =?us-ascii?Q?3R51XOilj57u1ryvKxB4nevZ0N4/OygCYEbmh1PzcPAv5g6X+sXBKJiLvzAz?=
 =?us-ascii?Q?c+MDSkdOm7ZQtdVlQKS6ub954cUXJ69SO9b7eJ7HhWiL5R7FgmKs8NmEr29U?=
 =?us-ascii?Q?So266T0d3jPXYHo1bx5ff1z9C5MW1OmOU5C0M26ngmrhWRJx5vVCn9Ta6rYk?=
 =?us-ascii?Q?y7ZoLGNTUdm5xTkAFDgbImM6yB3QmogFJWO821H6dwmZ54lniKFXaVYbFsTO?=
 =?us-ascii?Q?jjWI4bfHQBRdcqbFe3WsEYiy50DSo1IOCjsjq+741TqOongkp5zjshCFurZw?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5aacb9e-0a87-4670-4d85-08dac1dddc87
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 23:06:26.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDG+Pc3GcIL0n3LSjtsriQqzvq1ZoP2bzmpt6nE+YB5uoQ+Ei8bqEVjHJ39m6YP4i+I0dTnKXGYD7YS6gBXYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
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

Hi Boris,

On Mon, Nov 07, 2022 at 07:47:37PM +0100, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 04:12:59PM +0000, Ashok Raj wrote:
> > Only missing is the ucode date, not a big deal missing it.
> 
> Yes, it isn't. One can find it out another way:
> 
> $ iucode-tool -l /lib/firmware/intel-ucode/06-9c-00
> microcode bundle 1: /lib/firmware/intel-ucode/06-9c-00
> selected microcodes:
>   001/001: sig 0x000906c0, pf_mask 0x01, 2022-02-19, rev 0x24000023, size 20480
>   					 ^^^^^^^^^^

That's correct, my thought as well. Did you get a chance to review rest of
the patches? 

Thought I'll wait for more comments before I send the next rev.

Patch2 is a simple fix that you suggested.

Patch3 is a bug fix. I suspect some earlier upstream reports of ucode 
failure after update (early loading) might be related. The symptom is 
similar, but those are too old to followup. I got into a similare situation
when i tried to update an incompatible uCode from initrd and system hung.

I'm not positive, but seems highly likely. The following are early loading
failures, not late loading.

https://bugs.launchpad.net/ubuntu/+source/intel-microcode/+bug/1911959

https://forums.linuxmint.com/viewtopic.php?p=1827032#1827032

https://askubuntu.com/questions/1291486/boot-crash-after-latest-update-of-intel-microcode-nov-11-2020

Patch 4 is also a bugfix, today when we reload the same ucode even though
nothing changes it seems to think some feature is new. When i added some
more debug it turned out SGX was probably turned off by OS, but enumerated
by microcode. So it always reports 

Cheers,
Ashok

