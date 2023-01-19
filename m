Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99E66745D4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjASWWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjASWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:21:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B135B3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674165938; x=1705701938;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ufNSkPXshLvV81NwrzP8h+aGwe3XvYtPVe73z+chtGU=;
  b=CcHl1RNpig/2Fa01fF+4LKo/sX8lFOZAbqWeRsfbvQ7XJ4ES8VEEKAvj
   wEoCcnEaf0G3NubTYtbr1j5noCyn/exiwqeXQyJtrzlFoIsJwZmeT88ol
   Zx1tkROiF+6QVF3RrDV9YoGCAkPsRd7TXeFEp1R5nVvkON0CQAeoqxW30
   +Q9Qknfq/EG0mcwsIM9nqEE3AwtkLxr0z/WMYc/R3oNBx4Qbo5tXbMX+l
   isi/k/YbbrlTH3bUKznBv+9gQbH08hFyIDq506BYZgNO0Dq7QA/pvE7oZ
   ClHS2Z6pUf88B2VOoVijYMvbLr+wNuczArSPLW7h+1h9y68Bb7dZAaPTA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324121884"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="324121884"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:05:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692598734"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="692598734"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2023 14:05:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 14:05:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 19 Jan 2023 14:05:35 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 19 Jan 2023 14:05:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDfFakoGuAsFf6YfyxB7JbDLUdke38R2aTvR/s5S/9dw9pkr1PXVnQcTcPmYgHMGH6HOvstC7rAiGUA4wO3rYPhE21uZfhVNU6ULG13I9ntl5H+LNUbWWjglBNIaZDutwjwCRaP2cn/MFjepDQU2lmijSHbCp3pod720+r2W+UzX27n5wt52Uo6CTSiklvl2fuhgKkSkqsfr1lEZGHo67KtGlQj0hLJgtHSHfOmBCk2WV/1HdrshanITsKxy+WODL9iZkTkuxYrktFwJeiQMkKD7ZamLLtBWQQcl+JmPQmCfSrlvyb3/hXFV1D6dHAMnevGOh9md1qcW/GPTmZVuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfAAkSO8pIcbfGc1nA064wFZgIsedtYKGbEcu3vga+Q=;
 b=JLdzVN1dEbpRDhdDf8bWwerUDg/81ow2osbkJ9vCCaoiWXzVtTk4DgF2L8w0daS3HCwaqI74cTUpDDutFW46b8fq9/ONjrsSIIAJLo99ER4zxaDItfvVIMoh+SAGHxxf4al+/1dfZt/Kvog07nmlNNCwG5x1eJLnnuEKThwSt1TkxqivB6XxtVntGVWsjvzv75tm3VDC/sqLQwqngYvJZZ9et4S3zvcRg30364Z7Df7kIia0Ay1TPrrGMXQki+rCRVaTJy8FWpNRu0tlI3ZLUtam4YCY2Bt1xUpQ+jFoVWHKGyh8GU8w+dfSbTBsrD1XS5ABwfhNUlFQEhvJ4stpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SJ0PR11MB5583.namprd11.prod.outlook.com (2603:10b6:a03:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 22:05:32 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 22:05:32 +0000
Date:   Thu, 19 Jan 2023 14:05:26 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 Part2 1/5] x86/microcode: Move late load warning to
 the same function that taints kernel
Message-ID: <Y8m+pr3t84VQTQTM@a4bf019067fa.jf.intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
 <20230113172920.113612-2-ashok.raj@intel.com>
 <875yd2i4b5.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <875yd2i4b5.ffs@tglx>
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SJ0PR11MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: f993ed94-66f1-44e9-6678-08dafa694829
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v90E4PxwkH/OhR3Bp/xdPH6xqz/LlegJijqOvowKrO1XlD2SITPhBxBc/MuH3j2DcK0kXOYEtzpCoXOyWzR/8gyq7irRkxIJ93QSYH1We7McDcPclOx7zX9hNZczMweYZ2Dnr+iZVGMFKN8IcdLNxf29+8y7IVvvN/1a8MK8Dqf0JZIQbel9464qU+Rv+8RktGx0siTVo3dLCrb0i3hmdcHA9NG93GXBMHk0XfgPXzbF+Jar9CwhcCpQkn60IrSb1JnVe8D5WdKi6tbThU4R+kZhaSPMBXo5vsX8ENmP+nPJHkEp5QNOjibm84wyywkBRN4P4wxTrbe2u0w0VNWtT743jl2L7dtelONACFLX8HI12vcrKW7VSBLdxtHxgiJyF9akU16n3dSED+Jhw6Hn1jv60CV7Rkx2PfUGm51aT1WtFSR/LA4ZgYDmLeLmKtwasZCUfiDZ15A2bg/hfpS4TI9VNpiNBB3vhlplV09KdRL+XhcJoHLIcAm5ZfUriVqKVZVbwO5OeFsMBCvAxFxcA1dPu2NOAE9aLJyOHMalkugx21lTYQG8SfdH2hFA7V3c7bHYeKf6uJswuX9jEHXdZj05DwPuQfg8DA9KQqn1NJzN1ygqfn5smZWbAvMc7+It/f4DApNfqo8gLAN7DxcCYyrDzO6SVDfli/y6j/Po7vDAo1YsmUdaZY0nogmIvEqg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(82960400001)(83380400001)(8936002)(38100700002)(4326008)(66946007)(7416002)(44832011)(5660300002)(66476007)(6916009)(8676002)(66556008)(2906002)(41300700001)(26005)(6486002)(6506007)(186003)(6512007)(6666004)(107886003)(54906003)(316002)(86362001)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WpiPjZT4QgVMlZnpSw81l4+t0geGjrww+YprWEofToDOsnTZa0HdSFovU3a6?=
 =?us-ascii?Q?Dk3mOYiXAzsW36b/+C91+z7LyAPYM1KUg5pgqKAA2n9WbQdCpKA+lIkc/Zcz?=
 =?us-ascii?Q?rpZRj1OAdqknyyrYdDGyWxGDeHaCwH0B9/VTpYgPoqIJEstR7c8KNaUp92gr?=
 =?us-ascii?Q?AsWIiKqcrlTX98RNkJPpiwZFlz6SxW1FY9yBKHFHRQYTBmow3dCfhpGFmxth?=
 =?us-ascii?Q?4V7JJJvwhsuBLzMkShi8JYtYsamooPrFla0h/x3i1jx+P+z74J7ZqBUHR+YU?=
 =?us-ascii?Q?fwNfxdvp1kBglu8LbQkFBkau0f2rlmuNajEqYY+lB8KCarHkx9JAZZ9MYuJp?=
 =?us-ascii?Q?l4C0P0/GDZSeRQzZh63BZ9SXvXonU8ZVbmEda8x9zTBlhI64XJPJNP8VgVw5?=
 =?us-ascii?Q?PDlV8JClpgJpW0qGj6v1pDsCGaikqYw8mjYYHQYue5L9jGEpiffKp6CVpeJX?=
 =?us-ascii?Q?ziCzmB92JKxtsWMG4nfNwXnTzqlcwmpesmTv7DSI8YuQnHLcO9PCMCsGrioJ?=
 =?us-ascii?Q?xI+x+X8TBD+iwyNMFPUuHRSrwFig++8wd++2p1RDzK628drOwOYYueJwpkqd?=
 =?us-ascii?Q?LTLqY/U+8EwvOTBjrkvNzRrzMwj913Sq7J93zxmfKyQiI84r2CJHIc9+mHIm?=
 =?us-ascii?Q?Hpujy8BgK+poP6OFV2Cv52mcx1y0gOviXFCeFLS5+JhEWOqdibAI8E/Bk7CP?=
 =?us-ascii?Q?lbTqzMgS+ZGr4MyoDPrLu3kFy/DeKPIqS1VE/ZN+bGs7TopCdYhC3+RAX9DU?=
 =?us-ascii?Q?gdx0dVpvO8pY6KR5gP0WvMNx3Npy2iGq6v0ZqNJnn/et8FBo0VXjvfUuK4M5?=
 =?us-ascii?Q?PAZ+Px5OZ8avB0m0/ND4b4b9dfJe6urtIdSVNqsvaqCbVAMQpsPKuvgdOqax?=
 =?us-ascii?Q?qsLWRxlrsKLofqHp/aKcVDld/15gDPALy5U8t7LB/IbjOatFn8zC2efr+lLv?=
 =?us-ascii?Q?H21WmUTapcYhCsg18cJleVF5DSB/Ya4sKeT9gtk6hDUkKOpOKRbw+4c/Op/f?=
 =?us-ascii?Q?RlLRwd23j6CUu+caKguTatGiw6MWBN+q7x9JYjtgorH5nd7gHXDOBrhDrWgV?=
 =?us-ascii?Q?8K/6gKwka8XsHBtO+U1cXlQ0rZ6MPFjJIMHmOuEp1H9FIjcDtOE4sJxEvUhq?=
 =?us-ascii?Q?2+ivrTGIH/WytBzRKq/GmYh04C/4Se77hv/HjbtvhN6ZFv5FHV2GDwCNK3FY?=
 =?us-ascii?Q?yzR59XbZXgoIj5rmAQAEyNca5cX6ePuosHn3PpC9wumhfgnMd2qSl18BmBZ2?=
 =?us-ascii?Q?8B6c5ZL8G9dDNtqNeOv9KS9nFlvDj9hLHfJ6E8dysWsIa848p/3Il4Qwvlrf?=
 =?us-ascii?Q?eBon/rKzWy9KPhszwP6BVQe4Jy6sz0TUIilmgQPNhxH23aVBlDKsZLxYiDnC?=
 =?us-ascii?Q?LPjtPXAvJNi7QE8yEaGUNwHUhwPCnf8BKLFGCEz4q5+rsPQImwpeTttjMtlY?=
 =?us-ascii?Q?aEpbOKwOENe7Szo7jP6tTmG8r86XYIFVJs30f4bDDuwju0t+SB3+SCIgolA4?=
 =?us-ascii?Q?GmmNCSIQsz/18/9lTucS+4gFxAVyQPz7BHqknriMfylaIsgNLmhQHiYHHjdw?=
 =?us-ascii?Q?4Dk7Rsblh0ZROLlOpL0OmjDQU0Eb//yGsxCOnNnEhdVTqam9icALw836RYzH?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f993ed94-66f1-44e9-6678-08dafa694829
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 22:05:31.9122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5UPCKvTYke++KfPj5IadCrUgHMSY83MoPri6G5Q3tDbKTrXpoaEvPsRQ1XWHnq2fHLMjWM+s0bb81lh4c2pCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5583
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:48:30PM +0100, Thomas Gleixner wrote:
> On Fri, Jan 13 2023 at 09:29, Ashok Raj wrote:
> > Currently the warning about late loading and tainting are issued from two
> > different functions.
> >
> > Later patches will re-enable microcode late-loading.
> >
> > Having both messages in the same function helps issuing warnings only
> > when required.
> >
> > Move the warning from microcode_reload_late() -> reload_store() where the
> > kernel tainting also happens.
> >
> > No functional change.
> 
> I had to read this more than once to make sense of it. Let me try a
> translation:
> 
>   Late microcode loading issues a warning and taints the
>   kernel. Tainting the kernel and emitting the warning happens in two
>   different functions.
> 
>   The upcoming support for safe late loading under certain conditions
>   needs to prevent both the warning and the tainting when the safe
>   conditions are met. That would require to hand the result of the safe
>   condition check into the function which emits the warning.
> 
>   To avoid this awkward construct, move the warning into reload_store()
>   next to the taint() invocation as that is also the function which will
>   later contain the safe condition check.
> 
>   No functional change.
> 
> Did my decoder get that right?
> 

Yes, that is accurate.. inspite of my awkward phrasing :-(

I should copy this commit verbatim before i resend :-)

Cheers,
Ashok
