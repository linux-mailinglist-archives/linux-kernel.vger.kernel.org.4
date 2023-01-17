Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B41666E314
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAQQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAQQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:06:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AA302AD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971585; x=1705507585;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uQE/VZNxkRd5ZqSTO4+dKTIpQVgAM/vKm1fwgBxMz1A=;
  b=MG+AAaPbaqtKoabtR7LJ9DlU5odbdlgQYQZjKj009i6PniC/UmR4nHH1
   KpmiVFciZVZHVkExnKpRJV4T4paOoSRk0LL7qDNPtfFHqIpGVBfY6XwDM
   DhNm8BSIe2EcWNLeeEFDXhzQ6cBP9eZD+sCjXB4JDBKa3rtLdc5bleI8W
   ii4KYX/u5Kdl7c5PClbXcbZt74Haq8d8ubd74+06jkA24gdq7C3Ap0SQA
   NbVjVe8sO56I5rBdlk/VyGLXDIO2forE3VZcKj2tA/O9tSkqimjhViw6Y
   3doP+S9uqt/v5rMbLkcODqrkUsmp5aeGMdwYTWONw7Mxg6uQONBvTTKIT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322421604"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322421604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:05:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689833205"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="689833205"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 17 Jan 2023 08:05:47 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 08:05:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 08:05:46 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 08:05:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmo0s+yrdJLrMmMjzCw1p2Jd0A+51tpfPVB2mNrx2ZXQ+ZNgdf3hj9g8RUKBuEF5vioCGnTdL1R560b7N8QtuigHfQWAScTV3dUmDE5FMCynO4zIOFGrnn5R1Dx6mZmSFQGfAv7PAbWEIAkAoNsJPCTCwq/4jrf+JzQLfeNJN42Tn648v7wvdlkDpER34KDlKaTvTwAroa/8mwkallIOtYYm0MTnCK9xke55k0AeRkH2j/43I+9g72cA7rkaytfBb6RvIY4BwHhsM1hWuT2Ag3v/BGndtCXbwVgztDX6o9J75e69EfBX6lFHCIZP8DBSGiVWd6XULJC1AmLfrA67Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWm31HQ1xY56CFJvUoxhDK5/oW5uwWV9HHtiaWSw1hc=;
 b=JbxRpRdMJSP9SO5/4vmKsvGq5pprLDHvl9Opz85RrS7YCdSe/UHDeEAmqV2cfzPEoaGn4wLdd64KxkgO3MXbpc8xRSOBIBzO12kE2PnJYvBut8AisT42RD0z0pMOof0ccuPKHgTHxVepruJJvk13XL/GCvRMJUR7t99yap9yG367PnhPQZMLtehT+VsrkXDp9M6pFdbyEn1w0BKE14ldDRbIM3gw6rZYUc6MCfFikFvs4ecE1ZQzUPhqSkOLe72rnzPrRSgyX0tDx517q1EHPHC+lyOSwWTXX1lbqGmLlovM1F5VcfU9mdmRFgSx4I66aMbkzu1+sNRxqXsId2swJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.21; Tue, 17 Jan
 2023 16:05:44 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%8]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 16:05:43 +0000
Date:   Tue, 17 Jan 2023 08:05:38 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>, <alison.schofield@intel.com>,
        <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Ashok Raj" <ashok.raj@intel.com>
Subject: Re: [PATCH v4 4/6] x86/microcode/intel: Use a plain revision
 argument for print_ucode_rev()
Message-ID: <Y8bHUpkHknqcq6ti@a4bf019067fa.jf.intel.com>
References: <20230109153555.4986-1-ashok.raj@intel.com>
 <20230109153555.4986-5-ashok.raj@intel.com>
 <Y8RWZu/SGYV7Eqst@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8RWZu/SGYV7Eqst@zn.tnic>
X-ClientProxiedBy: BYAPR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::16) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f95a8b6-e89b-4eba-73fc-08daf8a4af96
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skZy0qYcQJPYoNTKEYk4/FJSH5CJgkOxNC7O5SWhUAq6MEzAAD69bbYXv49tUFunta/2pEp2qyWspyprDw5sBU+qvvpVdG0zjYTzG9JVFnpzEWNhxLMh/0XHDSe7+pODfosY5Xk1rGPGzZ9L3wmDLDPZjqLrUMFs/2Zy7ooe2XKsZEsgWU4pN/mFHjzDHyWbFAcr00JDzimb4JQ6CDuZJdAq4FI0cfwqO4xwwBDo1oXIqqIqPtJwGV+SbxkGhH89wUMQ10HSMkLPpMCETnHcM/etUT8YcyKuMi6oElRzGGpPdV7Axc/ibK3z3t1gbY9Nka1c7T50tYW6c68EcUxhU2P7wRXnp1jKlHUPUGGxTjuhrY+9Db/ylEheDxui637s2PCEFL7yfjlSU8mJG1XD9tjW9FbU47N28SuwXRIc1Ycm15ZEh1CUaxxsEEO+TESQAfUwOAY9XWBJr9ADlp0UOc1clnEtZe54edTqvowhXrmw2bhPu/GGwcZd7legARX4de8MvdKQGE0yuccmweVMwsqBS6yp5GQdLbYjUVuiv+AFk5eWZUO/0wBTtjWTgd3yBllfxSozL6Jt5nJ8o1I/5LR23bV6/qeZu9VNs2arryh1bmSqxAlrvjffoa/86ZRjs0N+OwTnew+SvVVOYe5DoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(2906002)(44832011)(316002)(4326008)(8676002)(5660300002)(66476007)(41300700001)(66556008)(54906003)(6916009)(8936002)(6666004)(26005)(6506007)(478600001)(6486002)(83380400001)(107886003)(66946007)(6512007)(86362001)(186003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWIyK0pZUFc0VXAyemozOEtlamg5ZWNWWDhKbXlOdVAvbmRBSkgwcGd1TURn?=
 =?utf-8?B?d0FNQWVqUGE5bVZjOVhtWXBZUFUxRnhBaUExeFJFTXpBQmMxbFZPZjc4eTZT?=
 =?utf-8?B?Uk5tQjJRRzJZRUEzelUreGVZWHp6YVR6MFlLWjJaVlUwQUpqaTBtK3NxNEln?=
 =?utf-8?B?NUlhTEhQaDFKTXdkdjVGcXIrSU5GSksxZ1F3WmN5d0E0UCs2STdZUUxYT0ts?=
 =?utf-8?B?bEs5d0drSWJEaks3dHMvZDFETjFmeWdUV2JodUxXSmRMejdpSEpQRjNCRURz?=
 =?utf-8?B?NHIrY0dqVnNMdDNIU2Nyb292ZHp0WHg2dlgzNHFEWVo4TnoxanJzRVNiMGQw?=
 =?utf-8?B?dkMvRXRreXREWXphNkZEdEVKWE1ydUQyMzRBQXFlRWZVdWFYVXhRMnRSYWR6?=
 =?utf-8?B?emYxUkllS0orRnNHbWk1YWxJaVBXdnFLMk5lc1Vldk9iRWQ1dlV6dCs0cTFv?=
 =?utf-8?B?eVhnT0JtT3dzL0VXMEpydENaMmZITzRUQkN5UXo4cU05UFZtblh6OHIzdXRT?=
 =?utf-8?B?UXl2Mkt1Yk9OR0xPbnBSR0dOOGdmL2xXSTFneDFDcEdQdHFvM2VZUVJUVWNZ?=
 =?utf-8?B?NmkyUWdRenQ5MkN2ek9HZlZ1QWQ0NWxDa00zelpUTktUa3p4aTNvaEZWQVJu?=
 =?utf-8?B?cHMzVnh6NHJDUjFmZjRxcWJKUWE1dE00QTA0THd2czdVU3ZHcmgzUlRxd0tH?=
 =?utf-8?B?a1J0ZENGa2VuWUg2WC9yeERJeDVtdldwKy9ydVE1RXBoZnBZelRkMGFiNC9N?=
 =?utf-8?B?YWtyTTR2ckVPWG1saEFrVlVkOW1oUlNXTFhMcUNGdURQWkljWFpzRCt1Y1JJ?=
 =?utf-8?B?ZzJacGI4d2NuVlNrR0k3NnNwOXU5UkhPNEQyd3RoR2s5QzR3Rm5JeURSVE11?=
 =?utf-8?B?V1J5Y2tEWHArVXNsaE0rVHdKOHdLTitIcFYrdm9CS1U2Z0RYdkRYZmJaY2Vr?=
 =?utf-8?B?OWRoNEdkY2N0cTVsV2d0dUFITW5PZWlkUUZUeklOblB5QUNmYXlENzk3TzBR?=
 =?utf-8?B?VytCVjFRWjJaMHB2OXlmdE95eGFsbHRXMTgvQU8zUmxZNzU0aGVLNnJKclR5?=
 =?utf-8?B?TGF1SXBVQThDMUYvZ1NJdytBQ1FqdmkvYm5pWTArWkJKTGdyUktLbk40aUlD?=
 =?utf-8?B?OGtaV21rdi91WWVnOUwrNnVuS21WTU50Sm5mWHRnRi94ZXc1THd3WUNsOCtI?=
 =?utf-8?B?QUtITGRzUm5rZ2JGOG1zYitQT3R6NEdoQ1ZQMDNxU2NpSytPQkxDT2tvNCt5?=
 =?utf-8?B?U1ZaOXAra3lZUWVYRjFmazFyT3N1dW8wUG5ZUFAzclIrTER4RUxsOHpkeWFG?=
 =?utf-8?B?ZFNUK2ZSRktXUGZZVlRjM1paTy9LcDJtU2ZDbjQyMmFsYS90UWJETUdoemQ3?=
 =?utf-8?B?UlBHUDNORS9XVnhrSWM5Yi9jdFRzaHB4elU3Zm9rcm9mcTRxSFFqdEhXY0ZK?=
 =?utf-8?B?RGR6MXdXSFBka3NwMC90cTZuaFhnRCtERjgrZHo5aHcwcE11bWUwTmhWL3NS?=
 =?utf-8?B?YXhGb1NEOFh4ejB2U0FzcjhIOU5aUzAzd2xJK09SSUtmcXUwVXdJYWdENDc1?=
 =?utf-8?B?enlPaUtPMUdsbjhzYzJFQ3NSdmxLb0F0SGk4RzhiZVdtUTlIUjNKTGc4UUFa?=
 =?utf-8?B?YThhYmpBTGdmRXJRRm1QWFZPR0ZlbWpkemdHTThDOEppa1g2YUtvR0ROMjJV?=
 =?utf-8?B?Y1VlYzNjM0FhVWd4bm45TEpCZVdJRUo3dnJ1aS90ckxFbjRBQVJiU0JvazRz?=
 =?utf-8?B?S3dQeCtSeGFOSU5TMlpFQ3lqbkk2TzV6TlQyUkNRS0o4WURtc2VTaElWcWh5?=
 =?utf-8?B?VDZJRnhyeDBQOS82WE9CY1ZPMHNDa3IzSGo5QnluY0s0NXhFenFUTDBtMTVR?=
 =?utf-8?B?TS9JL1g4TXdNak82YW13QzJqandscVJoTk1MR2VrR1phZkwySHdtcWd2Zys4?=
 =?utf-8?B?b04va2c1VmpER0E1RGd3Rm85ZndsRWxjL2orbTlvZXVOVHp0MU1nL09aMi9T?=
 =?utf-8?B?RzQzUU1HWk9tY1pQWFdTMUhVZm5UY2MzOFd4ZTJqSXNMam5kV1BjMmlEbVJh?=
 =?utf-8?B?eDlFK3FmSGJzenhJbzBCenZINjk1ejU5ZFBkL1VJUUNNTXFJRFZwY0xSaHQ5?=
 =?utf-8?B?SFVNbUlPWlVvdjMzWDNPVEFaUTg2bldOVkhJeTFIOFRDOGpxVkg0amFuenZh?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f95a8b6-e89b-4eba-73fc-08daf8a4af96
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:05:43.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuSZjmHA78v+1Wh6HHwj9+QuNkaHrWZEXyIcKcguxXP0NsdEXhe7RK8HFI/43Pm0W8gYUYOrkcYEvUf9pN3hCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 08:39:18PM +0100, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 07:35:53AM -0800, Ashok Raj wrote:
> > @@ -334,7 +331,7 @@ void show_ucode_info_early(void)
> >  
> >  	if (delay_ucode_info) {
> >  		intel_cpu_collect_info(&uci);
> > -		print_ucode_info(&uci, current_mc_date);
> > +		print_ucode_info(uci.cpu_sig.rev. current_mc_date);
> 
> You must be kidding:

Oversight completely.. Apologize. I remember seeing them but unfortunately
I ended up fixing the issue in patch5 instead of patch4. 


> 
> arch/x86/kernel/cpu/microcode/intel.c: In function ‘show_ucode_info_early’:
> arch/x86/kernel/cpu/microcode/intel.c:332:49: error: request for member ‘current_mc_date’ in something not a structure or union
>   332 |                 print_ucode_info(uci.cpu_sig.rev. current_mc_date);
>       |                                                 ^
> arch/x86/kernel/cpu/microcode/intel.c:332:17: error: too few arguments to function ‘print_ucode_info’
>   332 |                 print_ucode_info(uci.cpu_sig.rev. current_mc_date);
>       |                 ^~~~~~~~~~~~~~~~
> arch/x86/kernel/cpu/microcode/intel.c:311:13: note: declared here
>   311 | static void print_ucode_info(unsigned int new_rev, unsigned int date)
>       |             ^~~~~~~~~~~~~~~~
> arch/x86/kernel/cpu/microcode/intel.c: In function ‘print_ucode’:
> arch/x86/kernel/cpu/microcode/intel.c:343:33: error: unused variable ‘mc’ [-Werror=unused-variable]
>   343 |         struct microcode_intel *mc;
>       |                                 ^~

I fixed in patch6 instead of this patch, my bad.

I updated my build to have CONFIG_WERROR, i had that accidently turned off
in one of my configs.

I have fixed up the right version and can repost if there are no additional
comments.

Cheers,
Ashok
