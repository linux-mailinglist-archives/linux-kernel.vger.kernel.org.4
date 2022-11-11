Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F51625332
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKKFtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKKFtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:49:00 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124636F344
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668145740; x=1699681740;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2VFQ/XqRCIUFgWYgedy354WAZy4F2ae0Q7+1+R8mlSM=;
  b=WyfhXyfWzxWjdjnCw3vosYG+EzzWoaX4bnAcuz33WwQr0ydfHPQp9LEy
   gIR+8fPvGTmsoJg3FzmR7TOSSbIMCGauFEhxpP5CeRkdFbzpW5gQ3G4B3
   uZvBbM3Ek+jLh+SJv/Wg99sL77Nloe+RfehPcvy6OYu2slB8tky6mufIl
   iWwcWq6zUvcV6nBkCaUWDfTT6CslU8YPsky4qrO53eli3n2fQgf8U9jWk
   HTd22RXlGlAnbt1eRwYKjtM0I3ikh6laTJcWk4Ooe5O7+hPQld9kArdbi
   lwWGvABK5joEz+umueDSnJLFDCbT8DFOwiB41OmYdJ0/wRT/3N2DcE43R
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291934633"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291934633"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 21:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812332587"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="812332587"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2022 21:48:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 21:48:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 10 Nov 2022 21:48:58 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 10 Nov 2022 21:48:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGl21PiMLZQXKbOmhNnsgZTe1hF29HzWhVQWGXDGkpMCw6+2ghJkMqIv6V5TJX4RghNWs3xmR+UQJOUFbAhzUBcqtykH3JEyc91oYGF79sJ19h/3bcZnn8glpsGKwzt0c6f6RaC/dkV67TudVRrKajERJVz4qxuXVRnzSFTLEW5jx/PJRDJdDsAzkz6NrvnjnTkQTYe0oZF4Hmrbygapwxm6lwXIVFLRShcQL1pTdTDEnhfMGFnM+/FTSahlphRaHtDvzo6AY7zii6pEEl7P2fmE5mCo5ICTWMUiDiR8A7JRHqBW9lbljdi2QpqpZi4GNZ3yzpUzcfJTp0XT0jJwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hep84iZw0kAeEayDFkOua+ktbMVp6vsqGzHj6a5Q+vA=;
 b=mfICGLxurBkhWvnoarSjPimUhpugrgfd3Gb0bnHX74ZdhsslksrksfQAzHoruh9L2HWeX7VhxFhYGZXATxtUagLK7L39oq82FBWV7xo1ktwR2eU+0yFDtBtde1zTJlG36/sgfrrFhFaRtE92OK2te054nn8sx7S4mGXU0/IYIl4y9j8oOt8B3G5Tr7MXNGJiLkbj48p7IGA6kmoU/Xz3zf8shVqdvAkFX0W+GWVKCzriz1R276TlVEMvqCba13RRz6WnC4PxDv7Ws5XDMH/z16c/fNfp+vlJd6paff0PFXuZ6CF51BqukRCBTMfQZYsZigGE4hIR+FFwugvV3VN03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 05:48:52 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::78af:67f1:f3ad:a5%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 05:48:52 +0000
Date:   Fri, 11 Nov 2022 13:49:13 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Joanne Koong <joannelkoong@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller] There is inet_csk_get_port WARNING in v6.1-rc4 kernel
Message-ID: <Y23iWU/hpUGpdqVf@xpf.sh.intel.com>
References: <Y2xyHM1fcCkh9AKU@xpf.sh.intel.com>
 <CAJnrk1ZvWfSAsYx-cErCqjQbciKCiAKss6Kvcm_4vXP5bzFh2g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZvWfSAsYx-cErCqjQbciKCiAKss6Kvcm_4vXP5bzFh2g@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf0da6f-aa02-4b7e-11e7-08dac3a86999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SxFBooSN7kcrvrFh3UZz33eEUyHWdQgIO1ogV1jMjYKQIgFlQhzdK+J5/vGatyKYE+1TCVoLfeMJgFEJpEjG409Kj0ZoeqfbIwWSNlVU2B6iYvPldbgSKRJY0SqEgjD+V85nZLpUWWheVtvhuZgk0cku1GvP7a872BfAsP9QR2CiSd4PiV302vrG6IvdliDX9naacfWOR+Y7mE4SvC6wa57D2fr0Yu2iqDIMrepWAYjnTNMrmgbuywq7jv5XlNL7Z4UTpFEUNOEgLWNTAPXPybyd6xT0e6tDruEfZxC8l1298MK/sYUhL7EWWpV5KeWYnIPlkD6TiVQJyHMlEyPwBXHAlNkeyf5c/Q41tCbLs7vzVuKUJz7tiWEmfTx2/BROxK3HxtOrj2OJ4M77a+X4ov+SMR/JGbMDG37GQQmu06Q7ZvKgWmEwVpZhy9GZcbdb6snVn0FS29ULweM6918TxDgAOmxOm+HLGrbk2z3YmHXS5oSeJK3GA/Ddyh8T94ZgTVeq+4jJ3Y5STOzVPi+eUoA73eHfrXVCSiSNxpubT+n+mzTEidIcpAt3yndpd1w76XvRdxVgia+x5xtEOnpEW2P4+/SbCD7qJvPD04l6aRkj1I3RHwDi46YSmMemw0Mu5EQqAvdROQkH7T7uaqtzAYqHRNehYHve+yUZrRU1hirkJwjsofl4MOAZGQNkweYTowbmwKBySctoqUfl8tKFqFd+CjCGQBwvLMBr+B4M3tyFPcycywAJ5loaMEVXHuC7dYs3CN/7l8qoMV5QWigd0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(478600001)(38100700002)(44832011)(6486002)(2906002)(966005)(82960400001)(4001150100001)(186003)(107886003)(6666004)(83380400001)(6512007)(6506007)(53546011)(66556008)(66476007)(316002)(4326008)(26005)(8676002)(66946007)(86362001)(8936002)(5660300002)(41300700001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7Mo236yJV87dw+KfWHIy/BgxedSb+pCEcNUHY99CLk/8PU3qJKM/bEZmo7Y?=
 =?us-ascii?Q?D4QfkH4k2nYaTMbhFrWoiFOlxG/axrZla+zVSyNxdq+g8O54DNivTPf65bSP?=
 =?us-ascii?Q?TT/cy0jRP7ia3fn6QM9RsaTsoTG+mfHgJvxg8+bmKazZOCWFxfw4FhhaLCKW?=
 =?us-ascii?Q?oDuoz+COwUTHYwlE/f4f3eavLcDTRnGbxPforAR7Axf70eEHfhzh1QZ6o9Yt?=
 =?us-ascii?Q?6nH9q3Vb02FT/dWm/M57GhVNHlJ/ze5DNkGZCLp2gLBD91R6D2FlDtYARtHL?=
 =?us-ascii?Q?Y9pcZZPZDPMnisojglBOFPfMadP7Xm8Q1LJJwV1ndqAkElmxxQIobCaWkAo3?=
 =?us-ascii?Q?V1/1v1c2XkajLSLrqOq2RQdSU7e9725Gyp/mpgw7TJx/MJgEkxggloqCbWEN?=
 =?us-ascii?Q?3t6bsnQWXu7xGw10grHGqse/Wyg2fhaexm53iXhqUF+VJYN6BruefQSS0Jhl?=
 =?us-ascii?Q?wAc91avQI3EP4Yhl39FOVLkJc2ptrIONmpOcOKP8AL8WePcVx6U5f4e1fpqt?=
 =?us-ascii?Q?cUT8wObRtxeStgqysIGPEPGEyQYGlTD98/V2psIHD11uX3kOSeWOCQ02ZKbc?=
 =?us-ascii?Q?PNmwD73oAtNvs4EznYqH1j4GFbsoudNpCayB3vJotgR94mlrQoX83eMsMmIT?=
 =?us-ascii?Q?X2Uvz3BU8SOCy5dHq5aO/pOrmG+G77P1UqjJygDaZmpYaw4nIahSzaMPJcdp?=
 =?us-ascii?Q?OU+e7XJB1cqRSkDWbRaEOOndwiU6Myr7EyICFBEbPWGZrcE+PWZXRP4NCt6Q?=
 =?us-ascii?Q?A8nZ06kYLtVCvTWnl+oSlv2OgL475yPh0V0h41VjUMU6XsLtTFpskTT49OtK?=
 =?us-ascii?Q?DUXeJJOajRjMxKDiJl/UohPenNlVuKUpP7wYIW7F++wn2wgu1hcBbvrD32xc?=
 =?us-ascii?Q?37lype9IgsdblN2/hYv+Ot/HyWVcpcnwaaX3sC8aAZ/jHlxirbkS23nsg9Ro?=
 =?us-ascii?Q?KRMt6pRVe/BEQGnsYjB7z3dldS3iNBUvJ/8tq2ZMmivOmxnE1a0mtRUQ4XAj?=
 =?us-ascii?Q?+kjSWQdnwlSdvlYqLM9QfP5sxX+JznLIgTHY3rAh/J0VHVrGvtQhmR5Te0YW?=
 =?us-ascii?Q?Zuw0Rb3lv8FUgGGvoLCmQym/mJ6h/9hq4luNIvsZugkCObqBwEZvUu808WYF?=
 =?us-ascii?Q?V3fGbPLfDx9DManSmnOC6Gjz6EhjSsYIMFLOAUi++60+wnEc8cVhi09GZTQr?=
 =?us-ascii?Q?FC5m/TsQGaDRMqH02suRyNJ44p3stZ1gNyilniC4xNHBBuqfdrsqGMlMzZ+q?=
 =?us-ascii?Q?E2mdl27l/nR3XoITFpB9mZ8nmpGpqnO2mvNJaX+6xzvVMXKD8mg3LDF0NuwJ?=
 =?us-ascii?Q?IZtVwMAACllxmyEkbUmmGGiynk5OncaJdF2NgPJSneZfMx+Pb7HqdVqstShi?=
 =?us-ascii?Q?sgxd/nwETnVCQ/VCaOiWPD/KQscBHopsAyMncK9wsrSM43WT4h/1dbmV9sW5?=
 =?us-ascii?Q?crb3DKbPQt+OkYSWHP+s7WYu6anPLfZHtfESd7Lpy8mgeOi7uG6Ea9eVYQi2?=
 =?us-ascii?Q?gox+HpThRWdy4C0CkwCaV+m7tZRDRhD1kOfVzUnylOMeCPHgxcm0uc/IuCFk?=
 =?us-ascii?Q?uKtWBIMT58KSkJTf8d8ikxWFf08W1+MzRNx3kBbW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf0da6f-aa02-4b7e-11e7-08dac3a86999
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 05:48:52.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRcW2LNtOXc53XKpW1LWWBMwl1w/to+mpYj1IxeRllV7Kigu4VFK+ROAFLnSt+eSgjV3qq7XLTo9MWCsZVfoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joanne Koong,

On 2022-11-10 at 10:37:36 -0800, Joanne Koong wrote:
> On Wed, Nov 9, 2022 at 7:38 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Joanne Koong and net developer,
> >
> > Greeting!
> >
> > Soft remind: "WARNING inet_csk_get_port" is found in v6.1-rc4 kernel.
> >
> > And first bad commit is: 28044fc1d4953b07acec0da4d2fc4784c57ea6fb
> > "net: Add a bhash2 table hashed by port and address"
> >
> > Reproduce code from syzkaller, kconfig and bisect info are in attached.
> > Full information is in the link:
> > https://github.com/xupengfe/syzkaller_logs/tree/main/221108_215733_inet_csk_get_port
> >
> > Thanks!
> > BR.
> 
> Thanks for your email. This has the same root cause (handling the
> error case when connect() fails) as the issue discussed in this thread
> https://lore.kernel.org/netdev/20221029001249.86337-1-kuniyu@amazon.com/.
> After consensus is reached in this thread, I'll submit a follow-up
> fix; I'm hoping to submit it by the end of next week at the latest.

Great! Thanks for your link!
And hope the repro.c and above info is helpful.

Thanks!
BR.
