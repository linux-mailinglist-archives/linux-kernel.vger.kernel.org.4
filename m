Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD871642FC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiLESTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLESTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:19:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C847B1583D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670264356; x=1701800356;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cD0czx1X6nfjsI1a02GNEMyD/vppgXk9mztvB1qz07I=;
  b=ao7AGeddfylPh3ASmTZ0wd5TEQv1ToU5e5ftz3TgxMr0L4zmMz8We+uh
   1sFiP31nf8f2PzifrzyWy1lun+MJXHdmSMjh6TWu5M2LHaiLtbHjlYZbo
   z1E8SptnGpkfYbXSZH3Rp7cAkd7JopMcuqHJSbhJ7JHSFaImsdm50cC40
   fjngAZcBV6RJWHqsQ/bykjzip6NQTsTxk0uxd7GHqTYSa3SIGNb0LNspD
   myqKMM91n280U/W7eJ0SYyTvsAOExcy8KxsiJt2LI+yccAgHnGItbApvI
   PZcFHz6Nd9nIJgAKf0IX6UTgfiL1uN6Y8pFt/GelDBZ3flH06twDJ3MY8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343440289"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="343440289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 10:19:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623601474"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623601474"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2022 10:19:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 5 Dec 2022 10:19:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 5 Dec 2022 10:19:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 5 Dec 2022 10:19:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EASKM+zaNXUoP/qRT4RBJS3ErgbrTv5yOHlJGir1MgZjo3d7Sm7xeBwPMCGbbun7gw5UMqdzXf9R05ltI9d6CaXE/qTeyGq5cHgP4GvTaD49ZbBaATWSkOs47wa76t2FDkmxL+7tr8Ry5yjG3QE0pZTffMHuMKSNBYO8qjC64VxVO/lBzBBSfTPPEbtWPfirxxKL9u41qsLVpFBsi41vHXFjqd2TifkvSZfyFtpV+sBgjRQr2AEEUnvEfgHhqWPmS8R8q7bJXQ9fpujK+a/YdvJbfDdVOguuKZK1PUdnpT6MhYxjEZxi51p6THm0QAqpfbf44WnC0puhS2S1mr+iKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn1MU+ODRAUB8902KZvoRR9rhyH3ovve2bFuH1JJ/js=;
 b=OJvK6R7JUk44aojMtdUQCD7vAcl5s4vDb3WEdLQx3wj9tFaF9xDMWqKtT4xdgegNNPfBx3FB6jsITkGThNC/YYLBJQIcGNg93NBsvnX6ib8h1YIAnb9IIXvna4enx9lfD3lUrKIA6WgGIrGFVbKjZfnOOlkzGGf1/vxsHb6YyxFJBj6fNG+mlDBS3HFjLpLP6K/8feAiVM7DaAfrDCg+HHbberSHyOdZd6SFXrWckNvanoKRN5AJO3JS965UImOb83IZZlt8YQD+kaxEBQ8HPDUe28SRDfMazUq6WeX7WiFEUa/y2cWUtNHa/gwSE9OnW8aiJfalCwjKtNzJ0X1ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA3PR11MB7464.namprd11.prod.outlook.com (2603:10b6:806:31b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Mon, 5 Dec
 2022 18:19:13 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 18:19:13 +0000
Date:   Mon, 5 Dec 2022 10:19:07 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch V1 7/7] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y442GzMi1EE9SV5R@a4bf019067fa.jf.intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-8-ashok.raj@intel.com>
 <87v8mtob6b.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87v8mtob6b.ffs@tglx>
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA3PR11MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: ac460faa-f5d6-404b-97fc-08dad6ed3622
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sz/P4YT83ATauUOA9PUhfQKJnVT+K/w/GoZdaMCpFAVzWYVydUdZY57bR3dZbzDjRIoyuDPzDcK3XpJkm/Dls/RcdYiHpUZt1JLukRj1H4BEV2X+wfkWkqHlnPVCB4ycafMd3irklJq72My5TTx9DG6zirn/mp+rgNe9RjDTvUOFlfTVptmFN+bAdFeCwfzi91UItiTPsOy6WBEj+22bMhQQNKaiWPWyaSWa0hng17v8Hn9QIeTdqkjfiT4Ht2B0xuT8oez93H2/UKOvQpZel87gduu99UDB2YMCNlG9igq33qeyYtACffq3sJAXz6IClcfmb19oYRLLtomwPXA1cQ/IWmJQH+x0Ocmm3z6TmiqglMLro983ZoFJDqf0FLKjiRj/d4+3H9GwzW5xwr7AZofXCU5MDsaJsdjHUchX/E5CB+WB0EjbY/2epru0cZ0wCYmwCmDdzO8SyVKMzJ/3gaVDXRqhJX7UHvNja/She0+g4m8i42kW3bMvDMchyhx9wULGIA5rqTaeQWrSA5pvQjbavO3HTYhUcJe0eNCwWZcFg6O1ob8PXYFdTeUYHndTp4tFl4ogMhlOjM2XSYugy+99dJQadovTsbWk38cPMI8tZHonEG5zDqIB5DIZmaiNQAblfk1vCWQd9fKAIBqlfu8FkdFxO0QvsdfqCTOIAcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(5660300002)(478600001)(6486002)(4326008)(8676002)(966005)(66946007)(41300700001)(66476007)(66556008)(6916009)(316002)(54906003)(82960400001)(38100700002)(6512007)(107886003)(6666004)(186003)(26005)(6506007)(86362001)(83380400001)(44832011)(2906002)(4744005)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7maRhAesVmAOzLZb2ee74GsEkoJN4KVVs6dnBv72deC0A8aj203BChvSK3gB?=
 =?us-ascii?Q?WLk7KK4erXGzw7ziHvit1npOIHrl8cIjj3+O88X6pK6eLq/ccVh4ZtIZFtuS?=
 =?us-ascii?Q?f8/7Ws/ROXg+hFQ7paWHYTKCjgV3hQN/18Pv0r9S1O/eob379BUNio/0GPHf?=
 =?us-ascii?Q?WA5m9vAbzMG/Fqf3y6GWaHN3EhSsYak2sGIcY7SPlNnpISVWkmOX6WEMRaiD?=
 =?us-ascii?Q?ZR3aM0RQIyBrbkl74G5VRo01k/AfN+KpYRfBSRXD4D9aGeLFERzNPBqmReFY?=
 =?us-ascii?Q?vwapDUuYJ9qt1agmTSUnLViVp0aPSxrkm34H2LqvihOBI8kubOffAu1bg936?=
 =?us-ascii?Q?07pOy2ys/I4VH6bngNQK7IOf3jav7oIvETF6EXSQNzD3Zq/rOkxOFhplSOko?=
 =?us-ascii?Q?kp56gOt01R+e9mj4qioWXb9aK3XPsZL/cI5v4x6NDT+X7KxQqVfBERT9rho/?=
 =?us-ascii?Q?4ZjysNKfVSlB9HbGBRUXYOEl4Ul9MSZ4ABOO+OgS4t1HCFXmdk3l6LQQYhjQ?=
 =?us-ascii?Q?5ngDhIv9dsPRpLmRk5vcudDdgubG9B5npAuTMDVow+5iN0kXB5x3jva+M7Wf?=
 =?us-ascii?Q?vKvM2eIedrstamAIjH2dRb9gl24Bh+8KJKYiWUk+oxhHFEVDL491bay8sLIX?=
 =?us-ascii?Q?DY9DJFRqVp8pMpxBlz5C5gLqfwcRc3ALgg6eOm4xw/zkvk0N+h+pddsxx5Fx?=
 =?us-ascii?Q?fsFl3Co4WwIltwySjeqVTtbf0sWDhDjmgS9Ph04JfPZzFLfHGO3evyLJAr1g?=
 =?us-ascii?Q?F+gfPWoAaZs6pXRnz1xpAfLS52SK/m/837k++Z0t0iPgtbLEQR+KUpID7JfK?=
 =?us-ascii?Q?TfGkY1aG3xnBMVJA/Skhl+7NJTwJ48B2yEPOUNEjqd6i8oVvrDD56aFJz+8z?=
 =?us-ascii?Q?f9xXw0Ncl4ZgScXZ6Uj/tLCCW/V2YP9pA0cvWOgB8YOS0cpcgtzZffviqjKg?=
 =?us-ascii?Q?XxOaIzvIqV92yePjmlKG1GedheAcbLMLkiE/jiAe2QIzb3x33z3ZaIZBQ5w8?=
 =?us-ascii?Q?BqUaaZ7cw+AGr9LXTJQ+avDE1mFEEzU733UypwH10pNt51WOpkts5qfMByPK?=
 =?us-ascii?Q?b4XBck6gVI2ZOUXtN0FaPpgQ5At/ZwJN6FAj6EhDK69YQT7gdQEl/EXdtN38?=
 =?us-ascii?Q?d4+PXKuyZ8IFjJjTaUWbLkFnj+/9GfzettiDl3HSAbz01SzNXm205hpuja0E?=
 =?us-ascii?Q?ghJawNFfUjXyzTAmpUPP2SsJYhWGoeOvo5mQB/6TZ26Y4qZ9kVfQ8cDCwzMC?=
 =?us-ascii?Q?YnDbBdQffey38rNq9/nKNLPj1WF2AYne6sn5gY1PM9K9R+wE0fL6fg3+0n9C?=
 =?us-ascii?Q?dk/zAMV0sykSW09BpVu5paknbalQCm7cjhCFCZJv6fvvYlH8HiGGMiGZBVZ0?=
 =?us-ascii?Q?btp9l8E6rTzLnvY+3gBR0cm1/LsUk7oaItYfc/RdG81+mM2buvRRbbdAK8jY?=
 =?us-ascii?Q?Iqgxi0+fn3ctA1644Ba8y319PQ9fBQV/qRVlAbfYMA6ofevrABe4CPXUaMKc?=
 =?us-ascii?Q?Wcp2YUfgo3Fj1KxKn+Qc61ZyTx/EFNbXQzcAB21o033RHBMZbnxLBJJ8CdJ0?=
 =?us-ascii?Q?xf8i+TTjYvQ4ZQRAmKO/rlShMGKxtuV+m2SD9lexcfJnu0MxUSMaie+4RBcd?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac460faa-f5d6-404b-97fc-08dad6ed3622
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 18:19:13.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJiIXIRsYiJU0DsvajJLZSxf2B7D2yyiiIa3fiuI2bjAX5pMQhxUJl/h/8HlCKRdIULdpYDdv3A08xxnITEBGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7464
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 08:30:52PM +0100, Thomas Gleixner wrote:
> On Tue, Nov 29 2022 at 13:08, Ashok Raj wrote:
> 
> > Currently when early microcode loading fails there is no way for user to
> 
> the user
> 
> > know that the update failed.
> >
> > Store the failed status and pass it to print_ucode_info() to let early
> > loading failures to captured in console log.
> 
> so that early loading failures are captured in dmesg.
> 
> Hmm?

Thanks for the review Thomas. 

Boris, I have fixups to address all of Thomas's comments. Would you
like me to repost a new series with those fixups?

I'll drop patch1, since you have merged it in tip. You have a candidate for
patch2 as well, maybe I can drop that as well.

This patch has a type cast warning for 32bit compiles that I have fixed as
well.

I added a new patch to address Thomas's comment to print revs only when
loading succeeds[1].

Cheers,
Ashok

[1] https://lore.kernel.org/lkml/874judpqqd.ffs@tglx/
