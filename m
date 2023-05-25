Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3E711691
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbjEYS7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243771AbjEYS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:56:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482B4EEC;
        Thu, 25 May 2023 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685040486; x=1716576486;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=PjhBjwS3th3SyaAVxprzvC1sQhp70S41vyCVuCT/iPU=;
  b=msrKda2u7/yntLqcqosCbsO9vOjA/czEAVDIiIJcEtoBugqH5RhfPQMR
   JU5+oshpxDd2UxYTwBJXgbhwLTwlhoRIhxXp9bLen7QjmnxhF6tug6B9g
   GOhcRDBy91ZPP1qe7vq6UomqWPx87WziexyRuyCqeZbQUo+9xa3gayHY6
   WD0t5OFUayLsB1+sq0430uAIK5FpkHCkVDuaPWrOsm8wRnF9Uc7A9aneK
   9Qe9j83p0ar0slwsNfnzfp3ZBLXe7znDSkYW/5fUOKgJ36lgI8lS8jKuL
   ThPy2z8ZHpGcJz9oQValr3FFoFP/p3Z5spKJhb2/P488EYO61SKBGYRpb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="338588675"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="338588675"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 11:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951571714"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="951571714"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2023 11:45:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 11:45:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 11:45:41 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 11:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKyOV0zMAaPDPQ4Jaxi7Kg8sKWSxsYT1JEcNJvC+OR4XpJIyb16sW0mNhJcAfxGsMFpa1mGVZ/TfSCBeCgmAdsDhztPk40Lq5qDwtkRn7EHbQzyQP74YdwuOOv8SqSyfgFfaeA+K7eWo/1gGIDlxLppM04mFbKMU2i2gcxxZ64gqDj6LnsWLJL8EjXMnojdJM5fEvGdwyDjOQO3gw4O+PP74pRFCTOz+tgp7pyjXUdclpXLrmSj/+bK96NJtAX0nmvY3UM5W9WjomXmNJLEOouHFr94Gw95DwI/pxRTQ2jCsdygDD43gE1mNYwTJNACLTqbZ66l6KXuwMIXqGfhWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBemwG8fuK9VClomC7yIZ9vd3Pn7m7Q6DB70JP0rLrk=;
 b=h7WVhgcHXS6MipaveGmbuTlpcpfmIOwcYCh7pAQwXTZRzNP/TDKtYjuPrOSDESCsIMBvxVrmhhjusj5Bnr02BiotgP8QpPJ44VHSqXVqTkUt7Z5FE2q2IDIKjJZndL5PKoHYcTssWStX/NXOZzkTAQPKxim0NBsKhBmD+nNzfTe8i1NvCPMH7bFb0nK/NM1Z4jK5S8VBzVka49FtABSQIcSXs5dyl8cKga04f/fVgqGt6pilKuriAvl2SRZMAbyYrWJfPcnbgGBwQVGCOom0Fm0XYgp/SYhoNHecHe+5l6D85SDBWV1cUjZL9j/zEA3/lnQkAWP9So4xGDLXwzrGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB5520.namprd11.prod.outlook.com (2603:10b6:5:39f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 18:45:38 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::44e7:c479:62f4:3eb4%3]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 18:45:38 +0000
Date:   Thu, 25 May 2023 11:45:33 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <song@kernel.org>, <lucas.de.marchi@gmail.com>,
        <christophe.leroy@csgroup.eu>, <peterz@infradead.org>,
        <rppt@kernel.org>, <dave@stgolabs.net>, <willy@infradead.org>,
        <vbabka@suse.cz>, <mhocko@suse.com>, <dave.hansen@linux.intel.com>,
        <colin.i.king@gmail.com>, <jim.cromie@gmail.com>,
        <catalin.marinas@arm.com>, <jbaron@akamai.com>,
        <rick.p.edgecombe@intel.com>, <yujie.liu@intel.com>,
        <david@redhat.com>, <tglx@linutronix.de>, <hch@lst.de>,
        <patches@lists.linux.dev>, <linux-modules@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <pmladek@suse.com>, <prarit@redhat.com>, <lennart@poettering.net>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <6gwjomw6sxxmlglxfoilelswv4hgygqelomevb4k4wrlrk3gtm@wrakbmwztgeu>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB5520:EE_
X-MS-Office365-Filtering-Correlation-Id: 03113594-9149-4197-f0c3-08db5d503b4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5CoE9cWU+Md2N6Mz5F5Bb7TgzLuXDuroRPxyFKlWqdpdDd+8HHFMRlC1k+/8Kcyyc3bOLMJjoWOcGUCMRsu4LFJSngpUkscN+ywOHdwUlw7y+C7azLqciM5Fq9rWv6pnHEMGZWyG8tVGSdGsU4KAtvR+jJyu2N0YpoBIxb619xEIbkdtvkNs3x/obF01KqI/H0zT93vCB8G1JBQKp7mRjdUDqbrUDLAQnzk+iSuD9Fx2KEqGA6VpjKe9ELvxVSerOpVWv9lou8aNQtSrN1LSBz2Mkj5YwFTVdHLjxj5WQLqPyLcrMP+tttriLtHwUI3Ht4IA0U129QxlT69xUzCepJzn3pHyqe7pkvRnLD+g5U3I26oezPXVQDiPzETpFcmchQ0REIxANmC7sSLvIart9pfR7ESDjsMxYtsOrajnIcOrwSEf211U0l9pDlK07gKegZ2arMvwSv5stYX/nVXjUDLEPMSR20lECVg9uzJNzXb9Ebt+DV+yySWQdlGViMoQ5WBsJajzdHueaJ/S7M70EFHYM0CkM1SvrwcUEBoHXK/xvG6e650DzE/zvjZZIfKhyCrEPp7S/n/iOjQQHLc/juo7IN/0xzyd332KJc8Pg2Rt2+nt67WZ/D2omLtel2uHqyznveTXnC0kgxNyZIwA7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(66899021)(966005)(6916009)(66946007)(66556008)(66476007)(478600001)(4326008)(316002)(54906003)(86362001)(83380400001)(6512007)(6506007)(9686003)(26005)(186003)(5660300002)(41300700001)(8936002)(8676002)(7416002)(2906002)(6486002)(6666004)(33716001)(38100700002)(82960400001)(27246005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29OLzh5bUc2TTBod3orKzh0NkZPVGYyTVhGTy91QWpnU0l5TVVHV2doWUFr?=
 =?utf-8?B?aVZxSUp0c1pJc0lnTDBnYlpNTXU0dUxDNzJEeDU1K083ZGZlalIyeThKZmIr?=
 =?utf-8?B?aU5zdEV4dlNVMVBlSUFwQ0U4amNkeDh1QmpRVHJUVHkreFlCQlVpME5hSmdq?=
 =?utf-8?B?NFNFK0lReW0rOWh3WFVLZWxVaHhnQlNHRUpXbHJiV1hxWVJzYlFrSTVlem01?=
 =?utf-8?B?bFB6cGI0Y1lWb0VhZTBydzE0cmlBVFdXQy9MVUlaL0dmeXZhaExLT2dkeFVW?=
 =?utf-8?B?bmdOSC9rS09NVTRXc1dFMWt6L1IweXUwQ3pyWk81OGE3L3BlTjB4QUFOMDFG?=
 =?utf-8?B?eWdvb2hZZ01hZVdXSWcxcWhqMmlVT0RsWXpXeUxKMGZudm5aRU1pbThDNi9o?=
 =?utf-8?B?NDhWSTM3NlJnZ2MzVnNWR3JLdW9YVUhneGcwUnIxdUtJVFZFeFRhdUxzYUZ1?=
 =?utf-8?B?UENqOGlZRk1aZlZ4VXVCVnBrSnBuUkNVRnFXZUN1cnFlaG53Ull0Q0w5UXBr?=
 =?utf-8?B?QU5sUXhCYmVKTjdRbkZmUWU3MlJ6czRQQWNnTHFTbFlrMHE0WklPcXEveVpB?=
 =?utf-8?B?UDNRTVNEdGJDRXl3UHA3RFBINForM1BZSEUvdWl3U0ZKNGxkL2pJNHBMMC9P?=
 =?utf-8?B?ejIyVTIzOFBlQmZ2STRxUEh5L3E0cHhmbURUODY0eVZPV1dHSVQxWVZiWTgz?=
 =?utf-8?B?UmNDYkQwTWhiYWVZakM1N1ZGNlQwcWRKbmRBL1VzRFkvV3pUUEd4UklFNEpu?=
 =?utf-8?B?MDlsRS9jOEw0QVB6bUVWdEliRzRYazNHM2FRbEw3VTF5aWtyYTRnb25zQ3k4?=
 =?utf-8?B?WlVnSkY2c082emhHOVlsdGNYcnd2aVNIL3ZDeW5zR1hiWUZtRERKUlVxQi9u?=
 =?utf-8?B?N3k5R25RTmE1R3djTWNoZFNtUytJUVpLYWl5d0cvTVFxK3ZWZE9UeFBleFVz?=
 =?utf-8?B?TUpZb0s5WjREWHNhRUxjNDdCVFBEa1VjQVRpeUNjZWg2Q3YvNHcwUWxFU2RS?=
 =?utf-8?B?dTVSZ0gzL3FZSUlSaDVsenpoUExOOG5TTTRkZW8veTFlc2lmMXpoQ3pmZGlF?=
 =?utf-8?B?QVBMZG1NK3RLT1VKTVFVZ1NDQ3lrL3V4Q0x0WFhCZXIrTmpiWWdXTGNpaFJh?=
 =?utf-8?B?N09obFE4S0wrZGdqdm5keDlGUThLdXg5MGREY0JQVXpJeUVEQ01aTzZKb1Rv?=
 =?utf-8?B?RUhZVTF0bFZTOWhOTjczQ2djY2p5aHZrUHFFN2R1Z3lSNU9DT2Vvbk11UTBY?=
 =?utf-8?B?aGJlYURyUTh0UjY3bkVBclFTR2tsbjFpdDVmY3pjY0hkNitONlAvNUNNZUds?=
 =?utf-8?B?Y3R4YzdMKysrSHo3aG0rOUtoNmd0NUI4KzdlWC9jSWljaUtHUUQwU0s2dmFF?=
 =?utf-8?B?RE1qNFExU29mTytGckUvV2kvT2ExYldrWlRKUFdhRGVPdHNkUUdDQW5Pd0ky?=
 =?utf-8?B?YSt6djFqaXFDZlAvUTk3YWR4UitJdjA1T3lTRnI2ellranUrMStha2RhV29Z?=
 =?utf-8?B?TldGbk5zV2tIZGpQK3dkN2d5SWpsSWZKOXJlQWNrTUFuUk9GNXNiN3Q5L1Fp?=
 =?utf-8?B?ZEVKSkI5UFhvU3J2VFdiVFZ6ME1UMEJ3dG1pY1p3OTY4ekFsQW1SK2c3ZEtz?=
 =?utf-8?B?ZmJjMFF1NjVSbytIMnZTNS81RG1TSXBBbUhaTjJnYkZlbDRjbGd1UGtWSEZo?=
 =?utf-8?B?alNnUTdYT0RhdTd2NkN2ZlN1MENEYTl1akNMUSt2YVlXVWNOOXZ3bElESVRC?=
 =?utf-8?B?OFFlb2xwYlFBVjg3U2JaRE0wOXZkWi8wZTd0S1ovTzY0RHlaZTRWY2FPZHdG?=
 =?utf-8?B?OVNLclVVTmhBejFMMGl1TjBtdW1YamUwTGhDbXpIVmZtVi9PQzgwTHIzc1Iz?=
 =?utf-8?B?ek1XTDh5cm5uWWJjRXhQSUx3ZkhxK3R5U1QwaTJwSkpQNFdjQmpkS2xWU093?=
 =?utf-8?B?a24vdU14VEh5YThzck5zL0tWRUdEdHBKMHBZM3F6UjRVZjl5SVVWNURUVVZx?=
 =?utf-8?B?UDhuOVZiNFgzVldvWVBlMkdGeVFCcUZDMDhrcy84Qm1pVjdUVW9OMHdLeGdO?=
 =?utf-8?B?S25INVFlNDR1K0k3MGd1OHM4TjlScm5iT1N0QkpYZFlNMVZJTWxDdDFicW9E?=
 =?utf-8?B?RC9IZ2JCMXErVzUrTlBJT3hlQVNhT2xvVFNheFROcCtxMkFvMDNLeDVRbHQ4?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03113594-9149-4197-f0c3-08db5d503b4a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 18:45:37.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebtrVVQDT6PiTH7r0RDiKo6bZdfdvDgXbrFXIbg/oVI1uY9UJ5D0DalNEYz2GpBQmO9zjWmqeCX7p2jVuWcWiGvAZDzNx3D+p7mpXiTCCA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:07:23AM -0700, Linus Torvalds wrote:
>On Thu, May 25, 2023 at 4:40 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> kmod normally uses finit_module() only if a module is not compressed,
>> otherwise it decompresses it first and then invokes init_module().
>
>Note that it would probably be good to teach Fedora and SuSE to use
>the kernel-side decompression, if only because we have it and would
>like to try to avoid using the old "load contents from user memory".
>
>Mainly because it allows security modules to actively check for
>tampering (ie things like verity etc). Long-term, it would be good to
>just deprecate the old init_module() entirely.

Right... I was trying to remember why that wasn't done yet since I
thought it was. The in-kernel decompression is much more recent than
the finit_module. Commit b1ae6dc41eaa ("module: add in-kernel support for decompressing")
was actually the one allowing to decompress on the kernel side
and  commit 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
brought the algo support on the kernel and userspace side to parity.

I will teach kmod to take the proper path considering the in-kernel
decompression availability.

>
>But yes:
>
>> It means that these and similarly organized distributions end up using
>> init_module(), and adding complexity to optimize finit_module() wouldn't
>> actually help in their case.
>
>Yeah, I think the real bug is absolutely in udev, and trying to load
>the same module hundreds of times is very very wrong. So I think the
>"mitigate it in the kernel" is at most a quick hack to fix user-space
>brokenness.
>
>And I don't think 1/2 is acceptable as that "quick hack". Not at all.
>It also seems fundamentally buggy, as it uses purely the inode number
>as the file identity, which means that it does bad things across
>filesystem limits.
>
>That said, I posted an alternate patch that I think _is_ valid as that
>quick hack. I don't love it, but it sure is simpler (and avoids the
>i_ino bug):
>
>    https://lore.kernel.org/lkml/CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com/
>
>that patch hasn't seen any testing, and for all I know it won't even
>boot because of some thinko, but I think it would be acceptable as a
>workaround if it does work.
>
>But no, it's not some kind of "fix" for the bug, and yes, using
>init_module() rather than finit_module() will circumvent the quick
>hack. The true fix would be for udev to do proper handling of its data
>structures instead of randomly spraying duplicate module loading
>events.
>
>I don't know why udev does what it does. From what Luis told me,
>apparently it's just forking stuff and keeping all its data structures
>in memory, and has no actual consistency or locking or memory of what
>it has done. Luis pointed me at

It's a long time I don't touch that udev code, but my understanding
is that it first creates the kmod context and then starts to fork workers
(up to a limit) as the events arrive and there are no idle workers available.
At this point each of them have a separate kmod context derived from the
initial context. I was told the workers are needed because
a) they must be resilient to crashing without catastrophic consequences and
b) the kernel floods udev with thousands of netlink events during boot.
c) unrelated netlink events can't wait a module to be loaded, for example.

If the above is true (need confirmation from udev devs), then what could
be done on the userspace side would be:

1) do the modalias lookup first, before delegating the module load part
    to the workers. That will translate the modalias to the module name,
2) hand over to the worker the module loading part by name, not by alias,
    iff there isn't one being done for that already by other workers -
    workers need to share some state with the main process.

With this the dedup can happen based on the *module name*. I was told
a dedup based on the aliases is not effective as there are slight
changes on the modaliases being sent on boot leading to the same module.


>    https://lore.kernel.org/all/23bd0ce6-ef78-1cd8-1f21-0e706a00424a@suse.com/T/#u
>
>for some udev background.

the synchronization point in the kernel side rather than on userspace
used to be cheap and the race window smaller.  About the race: libkmod
already checks if there's a module being loaded before actually loading
it, however there is a race between the initstate file being created by
the kernel side and new requests arriving to load the same module.

>
>It's been about a decade since I looked at udev sources, and none of
>this encourages me to take a second look, so all of the above may be
>me misunderstanding just exactly what the udev problem is. But for
>that 'finit' case, we *could* try that simple hack of mine.
>
>I say "hack", but the patch really is pretty simple, and the concept
>of "exclusive special access" certainly is not some hack in itself.
>It's just not anything we've ever done before. So the hackishness from
>that exclusive_deny_write_access() thing in my patch is mainly that it
>shouldn't be needed at all (and that the exclusivity should probably
>be set some other way).
>
>Comments welcome.

Thinking only on the finit_module case and given libkmod will be
changed to prefer that path, it's not clear if it's preferred
to dedup on module name (userspace) or inode (kernel). Also worth
mentioning that both of them only protect against the window of calling
finit_module() and having a initstate file created by the kernel: if the
file exists in the coming or live states, libkmod will already do the
shortcut.

Are you willig to merge (a possibly improved version of) your patch
or the userspace change is still something that
would be desired?  Doing that on the kernel has the small advantage
that it also synchronizes requests from sources other than udev,
but I don't think we would have many to justify.

Lucas De Marchi

>
>                  Linus
