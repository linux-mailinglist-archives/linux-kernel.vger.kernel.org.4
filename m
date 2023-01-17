Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C592670B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjAQWJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAQWIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:08:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1830FE
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673988064; x=1705524064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1qWbdAydn8nj61ymHIB3SGVCP9iMgXWrtqNyIK4Coaw=;
  b=hoYliQQHNnep2GTuIoA8yuHMGRfXj6DDEqlc2QzC+IsHN/PJ8uofu3hB
   lb0wRp8CODS49Z0/9B0aV4bnhWQB7YeA0UFc7wWY3C5sBIFVVgRlCvRtI
   42KPYZbWjPcLRKR3lnqynzrKzCrS1yW04JDD7vBWHW8Sii5bIkS+wK7OK
   Jmxk4P+bJQYXNXYwQBpNhIctE2CwGLSNOC+1a/8jzdive8N3jZR2YVvzn
   jyjvrvuDfYIGDO//YbATtre4u9+Wy915MO/Rd8GXJ2kXMpJQ8QP2Tlkw2
   HAwPq2MS8qCr+oIZv+uZsYdbr1YAgXvZNyRuo77scldUt1HH3jkqV112z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411049051"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411049051"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 12:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="609370725"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="609370725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2023 12:40:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 12:40:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 12:40:39 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 12:40:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br4cP21vnDdvIxH5W65WudPHyKjAAYsWdmPzjREHNzQqRfXDNBpW2fZtMorUty/myZl91gkz9T1+F2h4kgXLK5jrUYvnkmjwlBpy0nAtLO9Qb7i5jC/6wC+fJHxMIGfhDiJmqrY3/cMg5kHTSp+6TPqw2XZ5AiTUPYlavLA4N2qAznKnqbFUfXN6bEEG7sfUFyVs6HlUs2fM0XZJyEZt/f/+xGZ9tl2BTo3mJaLLNYPYgctqMuFxzuD7aat3DKEWvmBmMOI2ffFPOMOISDciRbCVzJyK2eBMmncb3SjgLRRjy5PkkXmv3H6dg0IoLIzr5qc4kq5fPbG3BNhOa/k1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD1lFj7XQlvcr2n+3hoxkj8f/sscINH+HGW/y1xB8nc=;
 b=oDyCbDgdV55gUcOlg7jgnuePRcOjDnf2s2kXOA4zimhgKHeZJU8MMT11WvoStCEc5J02Gql+JnMidR5AKAonROli/TdUZ6fnexAeVGXct0iUPggGxJnDWPwm1zVJqmKst3YnK8I1DuJQMJJgaF+jgmLUaFe6m/Aw1uc6xV5fVDi+jPTcApitFOogDro7tpd0wuNOxr89Qgkq/vH81YgJfaUARrbbAATFbHilnifO67BHc/87An+pDZSaWG5OFWhQk4wnNPGI6IeD2UeteXceUuBccKEbPgXuihsh7mXW0ckNsRxsBaQgPD2tZbajSOW9IC73tpI0JSerGbytl+O2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) by
 SA2PR11MB5116.namprd11.prod.outlook.com (2603:10b6:806:fa::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 20:40:36 +0000
Received: from DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775]) by DS7PR11MB6198.namprd11.prod.outlook.com
 ([fe80::c0ff:f667:f68c:2775%9]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 20:40:36 +0000
Date:   Tue, 17 Jan 2023 12:40:30 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 6/6] x86/microcode/intel: Print when early microcode
 loading fails
Message-ID: <Y8cHvmU6pa/rNw8n@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-7-ashok.raj@intel.com>
 <Y8ROaoJtUtj5bPcx@zn.tnic>
 <Y8bI4BBst78qrApD@a4bf019067fa.jf.intel.com>
 <e491fe87-2c2a-e9d2-3cd9-dfc7535f7c27@intel.com>
 <Y8bnEgP6iXCL+QmX@zn.tnic>
 <832b5c6c-cafa-e9e6-6e52-b741315d0865@intel.com>
 <Y8brnyIltcgtUvPn@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y8brnyIltcgtUvPn@zn.tnic>
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To DS7PR11MB6198.namprd11.prod.outlook.com
 (2603:10b6:8:9a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6198:EE_|SA2PR11MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e83b43-20d9-40cb-c178-08daf8cb163e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrMf6AyzY2wQeIdjOkGbmsDuny/Ogih9ma1MewW+JtaGhJsckAC67EOktaooJWLtu1ua9LbkWHSslCi7c0dXT3RDTXuX7LbJeyjePQTgghKXBPW4DqXplMyvt52LuXBouhs912kGlAVP7M6io3j1juUtJOF02j/Prdyh6rbJtg5s/6FfblEbDPkrKnEOhNxntyNLPvk6b4kGrxifqJbZrb4MfZXzc1opHAfkfJnuMpl5yqzNEsfxH45eYbvMnIrdTKDyozTk87HMC1zQDOlZ5ru9THsyMMECk4R39hdUJhJgV1uZEQe3lV+DGWDSfKSSxvk0bFTsXXyI7MBoJM1rX29Vi3lUGqdyaBqyjzKrvHNa1DZtoNpSRJ9hAhmoyHt9dLu41J/W9cAT5vvR6jdBojv7NBF+7yrkxYRpqgbxSqcUkfwubgGrjCfJcL3s0OQd5/kXzhHVyaHnIkNEjeWAM0exNRnxWJibhbopVbwtNzx4D6QjcGD36zUVyP5MLm1itDA4XedbX0adMGjQfTUzxRui29t2BX+OetbYWIkugGYk2qWnCZ6z6Qx11g05kAufEFT+1nCAzhByqSigX/y3JIWwP8yBHboEdA5J0AjVhJ7Ja8/hwLmJwc75XDZmLkxUANMPbfXzo6FtXMH86lLaex/2ZBIYXnV3jjy1Bke2RzC+KLEjxA188v3eNC0sVUantbGA5a8WWeVlsrkej9UJjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(8676002)(86362001)(8936002)(66476007)(44832011)(4326008)(6916009)(5660300002)(66556008)(66946007)(2906002)(4744005)(6666004)(38100700002)(82960400001)(83380400001)(478600001)(107886003)(6486002)(966005)(316002)(54906003)(41300700001)(6512007)(26005)(186003)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WmCT1JuRdj6YKFRKgp2t+daAAObFDl8ZJAllwTvBpzoT7sdPDFDJTjHJ6hw?=
 =?us-ascii?Q?eLzS2jKZ/Oi0c8iTM7SmN5Q+bTZxovyyHR4P+bFfFO2ki2JUrpJie1VVw0Hu?=
 =?us-ascii?Q?wHZ12Cc/XmGAEHsc36YVELM2tB+4b/ol2xZlN+Kmiqleqn0vDh49VaSjUbNT?=
 =?us-ascii?Q?+m9tA9Z0LkUhCeMncBvx2yI1xt8DJQgr6ffac6U3hUtoookse+dSOi4EZ73n?=
 =?us-ascii?Q?lb6aBdq8rWMMbkISK8Cp9lnXSrvKEQ9b+tM+beSOzQPvCz97TOvXpUh/nMZL?=
 =?us-ascii?Q?Y71w26OanWJD0upEo6qj8nt3as32zA/sNvnxYWiXAOgw9SSxcaruF2dLbirk?=
 =?us-ascii?Q?l++xTTp83k+alvPZSe0L+qW4/6DoedDh2aiDFzcsLUB9PogMVp8tZwkwjDWz?=
 =?us-ascii?Q?G2duk0amQhksb4RdO7k1gbpM8sZ25g8i4qwymAand7wEX0k3GubjMq5Dc+Mr?=
 =?us-ascii?Q?NHECWIoyJ+3dVYYr5eifThlj+L8P1ClytuGXnYoLH8P7LjdIvoD9QYDcrhSj?=
 =?us-ascii?Q?wu05xi2oxGVkMolgf/M+PoIxAHcXha8c3GakgHLZn/aECIIXKvRtOpvThAtF?=
 =?us-ascii?Q?A4d/6zmwcp/D953SwQ42coyKW5aGe/mfBhEuMY8zCTLu/BduyOn5RjYaGrFE?=
 =?us-ascii?Q?WrFa5UMX5VB+CkaILQ5l0rXp+QxBIQUaGd2695UxbhgB3x58k3IORzCOGR89?=
 =?us-ascii?Q?6Bb45OeQNF6vaKbj/5BHz6QGgPdkLE4gtS5Ru7nLCUTAazGKZNtb5WLvVMCf?=
 =?us-ascii?Q?V+zO7tTWoTzRPNEjwzUvHYxoyOBJCgJ27YSPbZIFH2MAHuaZFgTR3AsvJRxp?=
 =?us-ascii?Q?h0d92bkcNVj39RQpFfYyA0zm7h9PpjU3Z+pyYyh0U8h0STYQnZTbBnNPyuS3?=
 =?us-ascii?Q?j+uymabmLGKe6R4d/CgoTlFsAZmSrerBScXDVDrpNhcj5XPeohVHy5uhhSvM?=
 =?us-ascii?Q?XefnB4To0QejnWvTgH2dsTBVjwcZMGagidcidMKb1d1rqGyXaPlhrrOTVF2c?=
 =?us-ascii?Q?s1A35tMjx7y0cnHCWqlKCApsKdsn3ChJQ9CM8Q9R83YbbwR4B9zD4wmah1tm?=
 =?us-ascii?Q?0mcHf0IyV3cXoJew0IqgxsE7NoIhyjjOwaEfOQcjVcXkzSWIeNvvKA1SIL82?=
 =?us-ascii?Q?8zdcMqmQylYA7EvoFyWkJF3vTNU/ZNaykjXm9l+WxrFQ4Pi/6p/A9gLessfq?=
 =?us-ascii?Q?koyFFaoPcOzae50Aw0G3jJgT08F7mW9u6J3Z7DzMiVLBpMEDSQdqTWezuIn6?=
 =?us-ascii?Q?GpAFCgGU+BBjf0X1wNwu3EyxqW8ydWcd2C1RPvB4UZbgjXBHDt+/jBrjk/8M?=
 =?us-ascii?Q?vqzNK4Tdt3Ltx+vOvEAIk4ljT2By5a9iIRrEAi1eFOhmC+bPveA6HacYP140?=
 =?us-ascii?Q?7/G4CA4ubye7/cA/hesSuZjz9PaQ5STFgyah0lH1ErPfq2kP+6bbXpGvDDVA?=
 =?us-ascii?Q?ZpSYEnEET77q+4oI1iBSSB8HIO6hqeSSxbudXZ9potVxZPQzi/WdJhZhjCif?=
 =?us-ascii?Q?4cZK40glGkviNVZ+QYA+dWkmenn/nXG5YmvbrG/iMP3B2hwpLIlvDuzoWIPL?=
 =?us-ascii?Q?cG608f57u44kkT/ykOuMDLHF5819P6TvSxyVadZsFsjL4m+DqxjqwvvTvlhd?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e83b43-20d9-40cb-c178-08daf8cb163e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 20:40:36.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04oaQqsr9KIKCYH6N/taDoDZkKSLggtwdcnO+w414TuRrv3C2DzfJsK15p8hXncvFNKKolM8IlDkVgi07eXhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:40:31PM +0100, Borislav Petkov wrote:
> On Tue, Jan 17, 2023 at 10:32:50AM -0800, Dave Hansen wrote:
> > Well, we have an awful lot of pr_warn()'s in the kernel that talk about
> > something that was tried and failed.
> 
> Well, is microcode loading failure worth to warn about?

Is it not? 
> 
> What if there's no microcode for that CPU?

If there is no microcode, we don't print anything. So what's loaded in the
CPU is the latest version. When we have something we can always tell if its
successful or not.

Its not a microcode file in initrd, but a matching microcode to load. If
none is found, nothing to worry about.

We just agreed to show both failed and success for late-load. Doing this is
consistent with that isn't it?

https://lore.kernel.org/lkml/Y7iYLbEJSYnVn+dW@zn.tnic/

Ingo's:
https://lore.kernel.org/lkml/Y7k9DNz%2F%2FvqBAvZK@gmail.com/

Should we treat early loading differently?

Cheers,
Ashok
