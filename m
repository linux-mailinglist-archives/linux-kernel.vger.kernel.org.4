Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A3622FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiKIQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiKIQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:07:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AAD21E37
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668010061; x=1699546061;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nPUy4OXFirIgtbVqkaYMcDkqLSEIsYDAFNag26+ZqlY=;
  b=AG1wGy10R7etrCI0UrbeHQKBFEekrw+udfec3tqhcner1aUH61cuYK38
   TG3iRYrzyhGFq06bESHyvfiU7E3InKfosvfvhDYLTkxMa1DO6dEClHtt7
   yoI5K7n0oh2Kk4/7pFVtKxa7wlOic1837zL5eFi0eV+Fl9U5VhwALO/aO
   XlxkTypGQ3gulkptfZsLJ4HYKRVT2pCnjMFOzCngJFDUC0XMJIPEaysrl
   udXHh2RWzZXqDnrmfwdAjmIovINiGDAkWNQJjzlVyggr93YhjeK2wFMVo
   4sY92lNj3ArhppuWExYkOCT7X2siHgkillmrWg6Rb2pVAH060EIOt/b9Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="397312301"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="397312301"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="705760465"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="705760465"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 09 Nov 2022 08:07:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 08:07:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 08:07:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 08:07:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMi3j4ETKMiXrTEvjpJivIfo6/wH+Kuf1tOw25UGGtgqAI1iJGxng4mLzINBIKM6OAzYeN19Ln5DSvU3gr4tv/uRhPi31xkVpquxBjF5wnl1UfhFlHKOzi7DPDcIVfnL84Ww0zgU/ohuAE4qxeXW+0otxLkQjQh+oCCmsEbobu8zzZY+tSSlwgFHvcX9nkz3LE5tc8cIde5clJYu2TQnlJzXHcXydz5Foy9yQYPO5h9HehLaiaNpTllXu5UXpu+prmW56MOqE2dNx0XZpJqkUTOX9r5gN0dPDJoxYkfw9I2mVG+hLBIQZXALvnCyPyfN8A440CaNj5GtZ1aEk3A3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzbWXfbhkjZ2jaNgcIKlkjjaOpUrzxLavQFBKWwDgOc=;
 b=NUZ10mFVsMxVrbnU+68wbb5qqq6+3Zy6e+vNCUHqlhczwgFEx8nhZn6T+LcqLvMjsnTAbArk5xK90Ucz9Dkhrlhv4ZQ9sn8Auy3JsHXkstRCwfsd/xS2G8uroQWJ2kj++RnGvjODHc43zmiAqayyaNRzDZPAjiOFt7MgyaU6+NDhNSUSurh/afv2489Pna7RepcD+YOPDNsa+mmsmREg7pwjapeOyZVf8W1TIVR+4nkb7UPUNSt7n2ROYjfoP0EJ0I3r0LDNoJTF69GVS4X23f6+8nQF/yW5deJzRQLkGw4Z0gi7GXHnGvOb+C3g/Ffww8vI6ElOsx1Pu47W7Pj4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 16:07:37 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%3]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 16:07:37 +0000
Date:   Wed, 9 Nov 2022 08:07:32 -0800
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
Subject: Re: [v2 03/13] x86/microcode/intel: Fix a hang if early loading
 microcode fails
Message-ID: <Y2vQRMyOndQtG/yJ@a4bf019067fa.jf.intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-4-ashok.raj@intel.com>
 <Y2uODnpkSvQs/nbU@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y2uODnpkSvQs/nbU@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CO1PR11MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1130be87-a20a-474c-7148-08dac26c8556
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keCA4gUtzuAPU9kkuf1bnLkTpNoV7LYtaNyERB+zRZ1gSQ/1jWklhLwTn8JLE//K9j6jEOnfrSPiPf6LLjl6DVs0tbMQLonzGUlHZ4MXStkwh3cTeDd8C1XxYq0hnBe9ilzV0UaWcRvbD8mlz638DQUPy5hSDjYYBTJ1QIIiHY2kt//nHNSHc7iw09e/j6DNvHsqcKsmCnB+tfXqrL5wZQCKjU6DG7pZiUkEhc0bvgjdpUc5ZOxkqUZ6TAuJlydLldIg+tZ96FpReWGy4P5W4vg0e+Xbb+o1n9WUbrcLqO9GOw2voVPw/n5qY2JL08VhOO6QtQe2d2bP6VCBCwgyM5GRdANt6e4joajDiqm8/OdddRrWFv95C679eB+fz0eBU7hpIt8KX4f/Mazqpm/NdGLq8h01dzBoxaQ+C/vPrXfGxHg4vsnJbmBPtvNE7SqZk0CuBFLkvn8MvoXhMlw+TBh9SR17M6+cfbUFmdmKe+xv2uYdTvXSEbQDLnfMtLIJFGFQ3TBNsyGszWVfyLvzNTlwuWBGGsEB2DnwGY0BxPSkHSkvy8CrG3eZohqYsafqC2ZwlqkvddRGebS/pnEa/4+3hsaD8hm8s1Fm1KpNJiJzHzWkpy2jQfBWkHMRKor32EVNV0mu9LEBhSiqhwQrh6bkXslZeWU/L+CU5ueq6UFnsFdUcKiaszNyKgLXq7N6szJRRJVKjXkzUW2FpKuetg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(38100700002)(6506007)(478600001)(82960400001)(86362001)(6666004)(6486002)(44832011)(186003)(26005)(6512007)(107886003)(66946007)(5660300002)(2906002)(8936002)(4326008)(8676002)(66476007)(6916009)(54906003)(66556008)(316002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w6dE0RsjDk/77zUvZDtDBEMMfYB5bmwMIE1cpYlraHnWm/j8p1bnSW2CXqSS?=
 =?us-ascii?Q?ve+115Ehfq8pS3T8O2uddUSJ65705rRgl4f4NwAJah+Od1/R//JbgLZu8DDc?=
 =?us-ascii?Q?FhzpOLocN3IuQ9ZAHN8TYwNzvWvKNlg6/E8SKSfJVeg+NkbWv/Viskt2YTyN?=
 =?us-ascii?Q?VPuINYy1xrYZyKYUDTewBzTeA4HRzbDysvdV1ceUbbBt6NAg/kjGnTmg4aN5?=
 =?us-ascii?Q?K8Z922u3TTSv9ccUGkyIAbSFaj++KeJep67S4FTf6m1qjGBDyO1M5qXN/tdp?=
 =?us-ascii?Q?Bf+pOyPUEUw3yRXzhwohLVjGBTkLfF4JSkPW1td3pSUen7+afD82asn0l8Rc?=
 =?us-ascii?Q?7Dqo5ZjnOEYnaq39Sf6OcSAUiHobThrvNWOOGN96u7o04UAnnD6JgtiVJWrj?=
 =?us-ascii?Q?2y3esr+XnIL6d6usmIJ2lzVQNoO1yZ49XHfHBJekev2ydp7XauS7za62PPEE?=
 =?us-ascii?Q?zl1qFwDoBqw/B9r93eRNV53MBsupNj/TxeLoAliKozJdEQ+Zn43yI+QU8JO1?=
 =?us-ascii?Q?YCzI2Tjqr4Pa3wMt7Wxx/cL3JF+L9Gbu4tzA9mMfN1r1Dnn5Mo+qyDFZyU6A?=
 =?us-ascii?Q?cfEkPT6IeyibV5hh/KMNTtN1JYqVoPDzlXVPOIKZrxfGuRDWiMXNtqL1JDOn?=
 =?us-ascii?Q?K7Ir9o0f1tEnQaoDDPMlaGevfdPflKEwjw/BXLZ7HcQWdpmFCUZBMgdCwzNW?=
 =?us-ascii?Q?YadqBhsPfwy1IaotiqpBPoxMogCRHo2Gbt3gNndN20ljnLig49lJSSkBMK7k?=
 =?us-ascii?Q?vmyFp0BGonD8KciuvMNv/PQKP1qfFhxoW6iHven8Zrv+WkEFh8Qi6ix0U011?=
 =?us-ascii?Q?RiPZWH8RHTwb+5SibhGlXuw3Cxm7/XKuXXIkPMNgmkf1BPOKAhjbkZzIaGtF?=
 =?us-ascii?Q?rpkMi7kGcWstwJN7vfGQlaacAdhH/0XHg/vto4EwxFRkvjQKbd3UVPIq3JBv?=
 =?us-ascii?Q?Qu960kxYLhIE6v9x5rSZQdGtCEi4As/tkmiJLZCu24lT4QgqzQEPTTjzX34Y?=
 =?us-ascii?Q?IuHILKztwb20QtJla04QU/gR+iyHm/y0oWigtXl2js2LlvJwpFhgzW81VkNU?=
 =?us-ascii?Q?sLdtlKfJJn/Bt5Rls4agK14OV5sqfsYD5ZY6pW+m/KkqNwVME39P8a0NB3qJ?=
 =?us-ascii?Q?UcdTx7inUzwptoidOmInv7+PH1QmlTEMalQuHei6NpFYf1nULQ5UpQZTEZD8?=
 =?us-ascii?Q?UgamWtsdGbf0qRBlORRDpM1CM5Y5kiqoqSoTcRFlHX+AhDWRQtGVBdi3wl8E?=
 =?us-ascii?Q?HNjJmc4+S6Hh8P1vVJq+3KSHr/2/0VENbhoZUgoVp2KEs2HWCfdgcyat7gHV?=
 =?us-ascii?Q?ed4JfeFZMSgxGdSK7XtzG0z8Tjv2CM/OnXXBdb6xJqvjx4Ui4TxPHjZE1QmB?=
 =?us-ascii?Q?faKCFOnjLRjbkZTcnWCIWlIY9gXQ5oRhHTZzC+VILYmRWdpn3R5Tird0zTEz?=
 =?us-ascii?Q?gaWyQvqMuoFeTPyTfzEy3oK44SOelFpb3W/1uXPTLxKo7q14hvXB35cxDOc7?=
 =?us-ascii?Q?dj7k4StgdxmFvr/j65rQSaiTM5oThKLPHrXRGYQFyb64sEsJUvtrsd3LYT5K?=
 =?us-ascii?Q?QT0iHohPMwnI2Ls1uk3hj9Y8bO2MYsVcoyL3irxO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1130be87-a20a-474c-7148-08dac26c8556
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 16:07:37.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEl+1ptwu2ySxAiwYxDZiJWD8WLNQDL5eEVs9JAXLOHBW0sStE8vCS5cJO2St6uJircIU85SvtugZSIDPby56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:25:02PM +0100, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 05:58:51PM +0000, Ashok Raj wrote:
> > When early loading of microcode fails for any reason other than the wrong
> > family-model-stepping, Linux can get into an infinite loop retrying the
> > same failed load.
> > 
> > A single retry is needed to handle any mixed stepping case.
> > 
> > Assume we have a microcode that fails to load for some reason.
> > load_ucode_ap() seems to retry if the loading fails. But it searches for
> 
> Seems to retry because we were supporting mixed revisions. Which we do
> not now.

The retry wasn't the problem, but hitting the same failed microcode over
and over is the problem. It is called out in the commit log.

As part of dropping mixed stepping, we can drop this retry.

Maybe the right way is to remember if the bsp failed, then there is no
point in trying to apply on the AP's. 

reload_early_microcode->reload_ucode_intel()
                               ->apply_microcode_intel() 

we aren't checking if early load failed for bsp, we should save and
skip loading on all AP's.

> 
> And if you say "seems" then this sounds like the problem hasn't been
> analyzed properly. If this can happen with the current code, then this
> needs to be fixed in stable. So, how do you trigger exactly?
> 
> I'd like to reproduce it myself.

Certainly, take the fms+pf of the platform you are testing. 

- Take a microcode file from the distribution for a different fms that didn't
  belong to the one you are testing.
- You will have to fake the external header data and change it to the one
  you want microcode match to work 
- recompute all checksums and use that file instead of the original file.

I accidently ran into it since I had a copy of debug uCode that require
additional steps before loading.

I have a tool that I can change to give you some production microcode that
will fail in your platform. Just provide me with the fms+pf values, and I
an provide one for  your test. 

Let me know if you need one for testing.

> 
> As to this patch: it should simply be removing the retrying instead of
> doing silly crap like
> 
> 	bool retried = false;
> 
> ...
> 
> In light of how a lot has changed since last time, yes, please redo the
> patchset ontop of tip:x86/microcode, keeping in mind now that we don't
> support mixed revisions anymore.
> 
> Just like dhansen said, you can split it in fixes and new features so
> that it is not too many patches at once - your call.


That makes sense, I'll send the bug fix patches separately.

Cheers,
Ashok
