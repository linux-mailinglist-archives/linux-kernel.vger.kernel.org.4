Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87F5B6480
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIMAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIMAXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:23:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B514F4D177
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663028610; x=1694564610;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jl/MyAXPP1hxxNAWi+jhpa1FEXV8YlQLAbeTiisda24=;
  b=eH2UG0f0kvcqBcPFUCD3lyjOYNVYVLzWdxKiwHkMjoJVqkguPurOjAeW
   rlM5VYyH6JwRztyq5HNh+2JBVlil+3ud2B1j12HvCfCZjkvUFMXfIXLGz
   kcMqMUdBvzgMdqdgoHD68gYq2Aktojg1hWjm9oG/Gjj/VLRwe4t9Jkmth
   GeX3ABQ351kVsDsLZgZxR+0sI0gxxdubnJi0lVSp9aBziIc7tcU5tovdt
   dP40vK44nFkuBqfCvOw06p6jje6FIY0nd2L2rXaO34hdGfRg4VXuvOTQt
   pSfJ7XHDSFhAOhkFp2k26dC4MLp7TZC6Zth9T1nlCvWtq1WeX5o2p0jl6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359727935"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="359727935"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="684642747"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 12 Sep 2022 17:23:29 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 17:23:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 17:23:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 17:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaPi7jUW6GMfRWej/UiVjgZwUFnVRLRrqJXGmhpeoLUNbunOlikb8uL16Kv2qdNYf0iqULOspgeM2SQOxPCJxU7XcQ49t8b2XEPj3MYDeSaa7MPQju2gAb6jwMHYwvonVlWv36tGiWkiD3EDw3F6BnzSgM2sU2sMXJFO7ayfEhBUWiMQOZf5Fn+UOBV51bpu6aHPsqkqk6TJDWTJWudmBjgPeplZpN5DuJ0Zx+x09IbSYVQWEynkbS7qgryKSnML4HqYBxwkITG3fbvSgFmwO4vOLKbGC2kd05awj21Yl+jfvXPIIxTFWW8b06wSCgLNuYi2Igd62DwMMGtgY+P5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgvPV4GzOhGcF0vaMKReFHgUUpyIg096KmvMnz3n94g=;
 b=Vjk9XRctU/Hd9Wu9YIYryd9hoP4Hrbjpog6evhSU99h810TD2m1ATPs7XU+d/yIyLKw/oSQJEPLjbXOxqqPgrHdIZlQn4UtrcqnFlFYmq28LYC6fFXREzMvtyA1mQ51vaW5QRCfcaFIJ7lzZgV4EQ1aQGWCwdDrWijus+A9OSMpFoQIdxqxHGR7TX12MbeGtjnvcOLlWnCly6MEE60SiK8CkvtPtVRdd94OZT2XQUmBLyScnPFefhQUdDfo4ZHGzV3z511TGO4KrYOBeADo6koeVpZ35T5z8aTqm9rgXODiPiu/6WaT1meYeh74SY59bWQlD9KQLgBXoVZMGW0a1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CY5PR11MB6415.namprd11.prod.outlook.com (2603:10b6:930:35::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 00:23:22 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::3804:7656:89b8:1fe1]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::3804:7656:89b8:1fe1%5]) with mapi id 15.20.5612.019; Tue, 13 Sep 2022
 00:23:22 +0000
Date:   Mon, 12 Sep 2022 17:23:16 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Jacob Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <Yx/Nc9gyAhEZ16Ai@araj-MOBL2.amr.corp.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <Yxtk4gMbcVgTKzKg@araj-dh-work>
 <20220912133935.3bb3e247@jacob-builder>
 <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <356d4ad1-f7d8-b8ff-3b63-819a64bf5b9f@intel.com>
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CY5PR11MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: a0827506-cc04-43b9-1f77-08da951e2a08
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2CNdqLStkifOXJ7SCnJW7ETpgAtgPk8Pa1cdP3ggf+3uL5CMsi4MOFB/41cCNJUe7xVkRi6Jdt6fZWkxkt8K2aLObDABgyNjC8193fFWnnb6eIxys0krtOCyZajO0HReGkznw3Z5yQpRdxPnH11Z7jisKHXhjnkaCqfdRHqo9uLWXYlwnDyZb0L3EOvjbddGSgVjiNc9RkpAJ2q6oKJKwfYbHLnti9rtF723/tWPHA9G1jKvcMtD4HsyRPEYtm+6jBbT0nxtUNU8z/BUGnYcxX32SwSaRddr6hqpaqYVav1L5IxsF4kT3UgpSqtIWri19UZGyHmoHpx3C2idOf45wQYGeowuN4xentYqVA8W5g3vvLtSi6CCSXq1Q5vhz12EZv1mzEc9ODxQCPIqp/rQ9OeTCmfMvWSFOMl+ZYbwuQkuXHuRG1eEb6NpMqCYmE3/7t3dhyvL+sxPG83QE1BRygGAJOQBdog1GUJ+JeQsHtJ3Xbe17u7RFNUrxGZyOUAnA2+uPhplFRaApe3lmieltiGENfS0cEK3pZeMoyUp8Sp/V9iQr5QtjmYth29g41g16KuwHgb5ONe1MNBotqut7A7ll/HEypttKIQ2mLeY20Bp2HOgKEBXnQDAIFKdQUjOqdssMBowP/r8g8ja3V+2PkzBEwYSLdJCpZz8lILUKNSl+Q09oePQLnYEI3O4A8DrCre1RAdWocskfGTlXho2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(5660300002)(66556008)(53546011)(44832011)(66946007)(82960400001)(54906003)(26005)(83380400001)(186003)(6862004)(4326008)(6666004)(478600001)(86362001)(6636002)(8936002)(316002)(6512007)(7416002)(38100700002)(66476007)(41300700001)(6506007)(6486002)(2906002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfOk+Funl2TjOUbq4q7JWl7eMjj8Egez9FXuYovLJQgQ80O/MzOqtaFFkFt6?=
 =?us-ascii?Q?Ki/u9PIi/smLNEKTWqCjv+kUhY8Fe+j55Hf5U3mgR3Bci1CPK33AxLbQg0SH?=
 =?us-ascii?Q?1iJVMVcF/ghrxfBxIiwKCj6f3v7ELmmEu3kV3R2asJ0ZsFHGvACvWs+TzfO/?=
 =?us-ascii?Q?N0OtnON6JT1XA+H+JgCgXjQpqX+rVoEh7vEM41NcwpTbV3QNHEg29r/d1pm7?=
 =?us-ascii?Q?2JHoQsE/zOb6GGVUAHWRhzc0jYS4pSVmK/Vkmm/KmSEI3qoCHtIOf3JAgXPa?=
 =?us-ascii?Q?5yfp4brMHZg1ewREU6igXTgnW9ORckUPosHhCVkjPjaOO9z7dzeGvokbxEcg?=
 =?us-ascii?Q?Acz4ID18hPWhOxaK0goecjQKPqzjb1iD0WMPWHKSvjGWKAlLo7633WGs/Ri3?=
 =?us-ascii?Q?MWcRWTfDGzUUbKJns9WleZwjWCNKWmgqDPrUHiQeuFNIOZKzjr5Ti1kjuKNa?=
 =?us-ascii?Q?MrYDP9uTCUUNSfHmNm1poTIABzE2OvM04yLiVlXBuhnbq1OslmvT9jjcCIve?=
 =?us-ascii?Q?XV9zgL/L/KQkV9fm9E6Xm9z9yC/d4JhfnwBmgjSEPtWDlLbGofVf2uReWKHG?=
 =?us-ascii?Q?x5h+3YvUqfP83bxhQcYql6fdX+Z6UbaRFI9GOmlbXp1m1+RwfXiGmcTfG/7C?=
 =?us-ascii?Q?i9S8BelIxXGtRzC5aQm5N69Fdmv5autCuQnjqrifpJn/SRHTG4OhSiN7W53B?=
 =?us-ascii?Q?0aXekowByjrHz/xFhYU5k+hMvpz+M3mVDpl5LbRcug2eoAMQqBEkbbqVMtaQ?=
 =?us-ascii?Q?cvIqC0TFOKXg+lxCInYQWsWE5y87GgZVk4OMRldcN1bUy4iyZ37c/pH/lka2?=
 =?us-ascii?Q?szccIN2d/nvLjX0AhQ/YCtAaIVtzBq7fQHwwhY4wHw4RJwvtLvAScgBpioUx?=
 =?us-ascii?Q?DYy2F+/48RuDbUgKRRdnfv4OTWscma2qajZTPRTvxXsgqXRKpp0Wkknotp8F?=
 =?us-ascii?Q?F+Y5o//HLu8Is5v0vFhTEUEXwTf9abM3pDtdxuG1DlWli5J/ZC/9TX6vB4HH?=
 =?us-ascii?Q?tSzAX388wyRxm6HE4fRJwIt1acv/aCdbQdQd2uTND2WipUVCInw+31RDpeev?=
 =?us-ascii?Q?Xljo7SbVmhKLPOquD7PSG5UahFs7AuQvW8Ed8nOkyLlo2+S4bEoNvkIXwu4r?=
 =?us-ascii?Q?7HAtHfRn+ArYhXx0IB/sOHWDaThRR1HaY77OUzYvhpAKjg0sM8oGNv3lE2CN?=
 =?us-ascii?Q?EwVb7TtANwspeGLuIBq0V8AwlMLNo8O/S5ATjQvoYh3ECj5Ax9Zh7K/YpStR?=
 =?us-ascii?Q?M5A2ga7BhIli0PY8qhKY3zUMjAEB8S1j6cu13bvBXUax4h9P6kjxAw/r4BSb?=
 =?us-ascii?Q?qrzSGJTqzDcubivybNzBXGTtbiB0qu7meAuq7JYi7+fzLEBwjAkyqQV7aWW5?=
 =?us-ascii?Q?PTgPPV7/pVf0YBXzk3v4TCpXlxtJ+90pAITSJriEfhFACMzazKA1ufmtb1ZK?=
 =?us-ascii?Q?9ljw+wlyYqL/daMpgWZBpfmghntUW21PLVueA8xKpJd3AVjbQKq3JNA0UP/G?=
 =?us-ascii?Q?UFWv8vXOhztg/mtg10cCYPAkHJfw+6N1TMall2tYfgpNjTNANLrVyO4rpQSz?=
 =?us-ascii?Q?UCFo+jSxBVJ9CPhZSKv/ok/ZBuJ70S0sT/4oAyrA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0827506-cc04-43b9-1f77-08da951e2a08
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 00:23:22.1517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hc03VNWsMaTDWnU8cB6aQwo55Tm+zwb46v6S+fg5FYtzMFqi+CnlAonbnnsF7rvUn4uHCE+tO//x+o1h6YYy4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 02:41:56PM -0700, Dave Hansen wrote:
> On 9/12/22 13:39, Jacob Pan wrote:
> >>> +	if (pasid_valid(mm->pasid) && !forced) {
> > I don't think this works since we have lazy pasid free.  for example,
> > after all the devices did sva_unbind, mm->pasid  we'll remain valid until
> > mmdrop(). LAM  should be supported in this case.
> 
> Nah, it works fine.
> 
> It just means that the rules are "you can't do LAM if your process
> *EVER* got a PASID" instead of "you can't do LAM if you are actively
> using your PASID".
> 
> We knew that PASID use would be a one-way trip for a process when we
> moved to the simplified implementation.  This is just more fallout from
> that.  It's fine.

Agree.

> 
> > Perhaps, we could introduce another prctl flag for SVA, PR_GET_SVA?
> > Both iommu driver and LAM can set/query the flag. LAM applications may not
> > be the only ones want to know if share virtual addressing is  on.
> 
> I don't think it's a good idea to add yet more UABI around this issue.
> Won't the IOMMU folks eventually get their hardware in line with LAM?
> Isn't this situation temporary?

This is more than just the IOMMU change, since this involves device end,
ability to report tagging feature, communicating the width to ignore
etc. I suspect PCIe changes are required for the device end which would
be a long pole. 

I suspect this would be moderately permanent :-) memory tagging is more
of a niche use case, and hurting general IO devices has lots of design
touch points that makes it difficult to close in short order.
