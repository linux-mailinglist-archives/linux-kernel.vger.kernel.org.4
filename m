Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4A619FDC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiKDS25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiKDS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:28:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A912728
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667586527; x=1699122527;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6oZzFaw3fyJuzxywVb3pc3XSjpU9slJE0mqS2P6YGmA=;
  b=Ob3XBm0O1hyA3j3F7AxD4TwNpVQR6X9yoPWHrGMbRenJSRdzRVXkjAUI
   WfYFmCF1h33BvWES13GIAdErezFI+0ElR3rPJxe/2JvF2doL614MaSSW+
   vmNGtfER1NQBN7+N/SfCWBkIejATQtqpLbz1M8WtH2bXKpisuY4lj1ojW
   3MJzJRYmVpaBkT8jRVYuwIwZXYs23uOlQhVk7G3Vpgxnq14OnzrdMSNw9
   Sk0QU/V/0wcBIobPEEbGqa/AMWM7XqCOjCkkAHozSbo56xiccG6VwyErg
   ZA8qWoMhYGOKuFIuY6+USJss5YU0R0YM9G9ybt4xEcSNbIYlFk4A5fOal
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="372146532"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="372146532"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="635184388"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="635184388"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 04 Nov 2022 11:28:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 11:28:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 11:28:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 11:28:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrndn57B3M0SUvPat9tWiFiM8ZdRSy44+g89Nd/PaDlv8/1Tp4XyFUQAr5z7OJJPj1UE7i98O1ORYqqS2Tr5CTJEzYQ9gIr79Z9s+S7veVSSgg5+aN0Hnocv5W/gFOxwJ/aBKrqTkdhPM9e+N/+Cqdunvy/x+yBBG5QNn91IvNuFETVr6PGKEdFb9UdV2bkwkhzqTyBC9EvPmyl4Xz2mJI2dJy+j4G4jfbsXNf8dE+nZyovkgePpnJfXrsujxe6JgcnhjrEt1z4t92nSMlAESqcWl8ywpGPSJAVtdQ+88A7i+eNN3ZFzSXLe8mgFzI3WiTZzFiajgE5k02eUI63WXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNvPbn+MlmvA1RW2US6Oz1B/vYDL+FvTmZYziHCz3+0=;
 b=e3TQXW+mVN2QqQst+nRP/qM4Rmfvrdu07fchYr1mcvlRo8u8JCIu4ZzTHwZmh0TSBYg5qCRgMjYQKsmQzdbsT/70uV4He5SD8uuDaa2yz4h9E9WzRWHOmZLVTHdqpvKvPMp48TOtQwd0Hp+llsapQx79G4zwyve+4md/v31VV5TryGovL5/sTAj8A7Jz0KexTJpYIQGChZ/U//wXcqWavq4FQmd6ZNxzqu3dS2S84/dYgPGNBk2EnU1R/jmT9oYIxKznXvN9+CHqmW2tequLr1nrqnusG29H3nc6qmP2/ByosgOuf4i4Oj6mTxGueG8v5gqrMqr8X+r7sp092AgmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by MW4PR11MB7029.namprd11.prod.outlook.com (2603:10b6:303:22e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 18:28:42 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 18:28:41 +0000
Date:   Fri, 4 Nov 2022 11:28:36 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Message-ID: <Y2VZ1OSJkwJPnRa8@a4bf019067fa.jf.intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com>
 <Y2Tw2+LCmZe8XBJn@zn.tnic>
 <DM8PR11MB5719A5BB1C56D442F0E25544923B9@DM8PR11MB5719.namprd11.prod.outlook.com>
 <Y2U1J2NbGNjYUbjv@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2U1J2NbGNjYUbjv@zn.tnic>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|MW4PR11MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5ace12-1ffd-48f7-3d85-08dabe926651
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OQE9pFsr8xUQNTRYJ2SimVKPp3J9V1A1WBmIsqUR+F4d10ju2zPeVbx/SFeMsaSULEn2eoYLPceVVgRPUE36EkHHItMcrt811QHfd2FY99ovB7t+Ushcd+gpOAeggIN26FO8+ny067qo7PaAqqia8a1I2tjr55C2hQ54htmET5T+9xS67md1STvmCWKI6IilW5ZV12GAE2aozXQ2beA5vQTPTiJ8scK9Jbs2hrOZSmP+BpV3XQZh7KKj8J4LpbhL+hByUXUBDNtUQIywEegqhGiDtA++yc8ripsJS/qzHHVMuoqUNs4+pXPMnY8SD0EoSlCNOO9Ca2B7zgk5NRJX9YISpwZampcBNQyDcY9I35rBQJraLaHyR/eV6zCCr3qmZsTP4b+2ov6sfHgXgb8Ge50kU3bloZaZPaKdRev7qOAW9YJIp11bx2l0Mxs4h2fKh7Xwjgvb/1FvWnuqroTML3lXahvVFRMlJKTxRgvQDxMsEswcv+/s1IHWJAEMse39ySgB6atQ55TCbfn8+BW8Ak1R2YBvLjJzK3L3nYR/fkbPkLWINNbkpxhLUEiTFqa4Cvzb4g57C0VXt/q0tOeR5g9Cf+jy6PYt5x7Ksk/ym94I7ec0iENes8YBZOsPXQHpjRalBHE9RpnL+x2RUrWcha+m6U3vss8BULsHhdFdZDEZKCD+ibJTRU0XvMLtRAriNKaCpmTsLjCuedCQN4iDu51XeBCGnPRq7qPenEYSFzhT/NVGph0mAQO7jATO++4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(6512007)(86362001)(5660300002)(82960400001)(38100700002)(66476007)(41300700001)(44832011)(2906002)(4744005)(54906003)(6506007)(4326008)(8676002)(107886003)(966005)(66946007)(6486002)(6666004)(26005)(6916009)(316002)(66556008)(186003)(8936002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DoPNF7yRueFRVZInBfZGO57SEhfrFYXEPByPSfhRke6JQd42AIw7FJ1SWQer?=
 =?us-ascii?Q?rDW6HPuuGNpVBZAR/FVO+gkBN5h3LIeAvegIVgjnMFjq4uDpEeswlBk8tdvE?=
 =?us-ascii?Q?ymKyQYRLKPNyieUz3E7941DhicWwvrHudN54nB3R5aCKJgKRVeUQZ9/jOS19?=
 =?us-ascii?Q?H/EUTsH9Eu9/SzfL4MUAH6TF7MhT2L1EKvb2Ytea9jQIgu4jzOBoPt1zZuI3?=
 =?us-ascii?Q?/rQ8OEKUjyhT7dNhOFwD9usACqDBcB3GmXC4Jje8NnSmmy+6OJy7g5IU/LfJ?=
 =?us-ascii?Q?mTgQeRS7S77XnLzQJhHnVj3aZPs2ydaQnMG8wiJbHhcdBLbstKkYuNpm/1Fd?=
 =?us-ascii?Q?xtNol/0EprflTGrCPd2SD7MUBvZzk6vcf5Bt6JaJwa40CbNxhvHPUSIifTR0?=
 =?us-ascii?Q?h4utaumDju4ngpAGFMF3Wi8u46Y18VIplV2wZbe9YGBJW2pME37zH14nuKF/?=
 =?us-ascii?Q?YS89a+KgYI3tNR+S1itAStFJeRtZecjFeVN7kgiFASjoGLelOjT0BLLEV6ne?=
 =?us-ascii?Q?OjvbqYwExFgiHAAkiK8Ttw++KIUeboZNg7UFuF7Wid/28Ui049Jf03bFvj0/?=
 =?us-ascii?Q?cwq3Fguqc2cQINNnyggJeGA2DXIPszY1qFX74EmHspLnuHatcoyJiH9h/3+0?=
 =?us-ascii?Q?xVsNtZVGbMB8j1yCyAbm/w+CyPnFd/ozdpyx54ow7IXVKNpplmFa9ub5F9/b?=
 =?us-ascii?Q?N1dz+mc81c0Iixsr8uIbMEvxiBsI+hB98i9USiJ5lNkCpGvBZsLvp3LxmSUI?=
 =?us-ascii?Q?UaQI4cIubf6Ll2tjVTevczagjJJOBq+KfHejUd/1XwUr9QSBjeG+aBj9dP54?=
 =?us-ascii?Q?hqG8UeCQsvrFufUqWQrO0s3RoDP3mAKA0Wd4MPpI3CYYoB7jGSO8xioz9I63?=
 =?us-ascii?Q?Awkmmbq0xewvuzV1WToKHnm4txWHXvR5kbwuUCOWZCPHXNVXD0EJ7GLOeHgD?=
 =?us-ascii?Q?5vU0m6fQrh5txlReBJQZFaIAZMWPDamWEf+bGUWxk/vW+TrGmoVhv+Ks6x99?=
 =?us-ascii?Q?+1iHjaNNw1OE8Szmt0l6h/WflR7YCV1dpK4CX5gNxVZu84n5jkWtbV0zsCjZ?=
 =?us-ascii?Q?6xCpCfq+rwAkr2ti9nB/4qFM6UglXrIrzaWEzMzntZKPEs4SwGPKoHeNC4bE?=
 =?us-ascii?Q?iRgPdi9XWQrzRVhaxIrqaMMdiQZ87faxkd24Gzj1h2TTO1ECdTJpQPif5B3x?=
 =?us-ascii?Q?E7VEj8BWvvzigkcL7q+LWLEJieOtsEC6H3z/wC3B7wbx9l2uinT8YG2uNXez?=
 =?us-ascii?Q?bq+LgvziIGgYEAORV7s8NY/jal7VzJ8vchicB8cOYUf7z9sSAbUvE2Q7ND53?=
 =?us-ascii?Q?qER1htCTN7l2X1CAJAEq4ddxs1kp3YSOTgl1C2soJbchlsLStIwisZ5a1AaD?=
 =?us-ascii?Q?kaay5aIkjRalnIOVpWqRn//GhdELttDVXZgo27VB85erOFHe24WbyvlqxsCN?=
 =?us-ascii?Q?IM1jyzYrYRPSsN4/DVhwex+RpiC+fogDUIOgd0gdUQ15grej9FsPHcTPUH10?=
 =?us-ascii?Q?ts7k2zUfefJnWozdbqFO8kh7k2Uk5S6u79w1zaBm9xnkWMIwBm1a3TqE0S4v?=
 =?us-ascii?Q?CTfhY55uirA7ouUBckMsWmPmvygeraBLE8RD1PXO0CclJlluG5PswI23SkRG?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5ace12-1ffd-48f7-3d85-08dabe926651
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:28:41.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHE75EKrrGxUgGvIbs6y+/jyY6HUWLL1/Xpt7vcv2vwnhRGHZ4bcfqnBTCTdadsCu4bopPQLnHL/xG7XYa+qNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7029
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 04:52:07PM +0100, Borislav Petkov wrote:
> On Fri, Nov 04, 2022 at 01:53:22PM +0000, Van De Ven, Arjan wrote:
> > so I think by all means, if life is simpler, stop doing complicated
> > things for mixed stepping
> 
> Ok, that's cool. Lemme put it on my TODO to remove the cache.
> 
I have a series cooking too, but this series got too long already. 

Didn't want to slow the minrev and the late load enabling patches :-)

I'll submit right after. There is a bit more cleanup, I had planned.

Wanted to add a check every AP that if its different fms+pf warn 
and bork late-load. We don't need a list, all we need is a single entry.

We didn't push the fix below, but removing the cache is a better option. So
that's already in my list.

https://lore.kernel.org/lkml/20220817051127.3323755-2-ashok.raj@intel.com/

Cheers,
Ashok
