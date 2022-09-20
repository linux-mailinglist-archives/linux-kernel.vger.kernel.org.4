Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D365BDAB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiITDNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiITDNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:13:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2243ECDF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663643617; x=1695179617;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1AKbbVQs/evmcYwAh7vWOby2uZvq5ayhRMKO7wXAgB8=;
  b=ic5LsscMvOQNR412FUGp6vGTuhzPnZE/HDjrJM8N2JDTdtRpFa8nrQ6a
   FPd1ZD+Y8RD+HtL0UglmBrNP2ZMdMk3e16lZXXs59AUUy0SxaGPt4tRvV
   DuaZX6pX7giRoHg6+2BTiVVxKPlPRpVRCy3Ni314tWln4MQ7iaC2m/HGJ
   1hoxv2NNvmZvobWsK1CigRpBzA3j/qkze1QPQ9rIOY3NK0N3S08wqczYn
   YfVu5hZ4vhCpyY6ZG8UwzDgI4Flws3+l5FQmoXnzatQLUbqTM/vC5b7O7
   Weu5//vzfuFVUO1FHjbxkV5ZODfHcY2J1omTg5MPSs61UWLpGYPZw3l8T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="300401600"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="300401600"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 20:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="761129552"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 20:13:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 20:13:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 20:13:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 20:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlubiXoXPXkVkCabpIWu9W/3Wio0DvpkspEX6g4zeaksO+UkTnRXS4Zq4p59zLGCLwOJmZy5WhUXmXwv0zH1GqrktqxGLxbFMuTm5QSy89YYdR6hqkY+gHcIAsbJdIzvJ7H8Kq/hVcEbShiVKUB1z24QHKByqNGyaAt84IuiThX84I30IhF/LrxxNwIKMw/rNK0i8Van31uNKHhxlXhXoYR+2lqClgJqX7wK2iBqRZGOuV79BAvtwPJ/K29eDq3eRXFwUEWV0HrDx3VfXNNT5eM3QwO+PII777S36BF+0SuZZxjeXF7rBYl1Y1giOncz39JEvPcHm9yy+7T7c4G9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrqnWXYyHCPE1FV34xP3pBwHKsxS+znTfi2H/hc1V2M=;
 b=KdPanzklnL2jQMSkSyb2RzQNAApAed+IbyK5fnjHgfZmvcToD+zEauf5Y/nvjvqMt46sVAuzx1rfdxpGANVgzYiStFBMfB000c6Tia2x5V2BrRUiHmiVYWIH+3Muo5TC/ZS93gdNMLUhgckW34EFDhnfvi4NBBeimfd3JPqHL6z6w4NiQPgYwdAnGMtlg8NUINEDU/2BbwZpOEGHxaR2H33YBxniQlY3D2ZXgPUDh/CVWc3ybQp293xrb9z1MlgdLRHLnTsDcFCnSHvrXovZtlZhw/hYZzJU8rAkMoQEyPnYU0YXBHFPkcRKUAHfV3SFUUsNrSer8bsedjII/1uYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 03:13:33 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::9db3:6204:5b3a:4ac5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::9db3:6204:5b3a:4ac5%5]) with mapi id 15.20.5632.018; Tue, 20 Sep 2022
 03:13:33 +0000
Date:   Tue, 20 Sep 2022 11:12:22 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, lkp <lkp@intel.com>
Subject: Re: [PATCH] x86/mm: Set NX bit when making pages present
Message-ID: <YykvlsPEHZRU65IM@yujie-X299>
References: <20220909152721.1685334-1-dave.hansen@linux.intel.com>
 <14fea0e6809b42393388d20f5b62509108a87a71.camel@intel.com>
 <c83b4d34-8447-03dd-1068-99aaa159e04b@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c83b4d34-8447-03dd-1068-99aaa159e04b@intel.com>
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7b7e6e-4c69-4a7b-195e-08da9ab61957
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvETntvQI58FVDLhjxuerawLs68qH3fZIEZhkFUknzysy3k1BXFiKqpINwAsLmXgEgrU7Bl6Y6I2cquA4jttPoQE50Jkj7+HRjdO+9Jbt+gVnm+4J5WhcmUpnBMhPP+AZHqn6WKWio1gf1SACbRCVD8t/HibaUasKWFMfhQcO/kN1uXbbDTR91JDHEQPHlUFyd2u3Qhf3dPhdyZlfTur69B79aWd6RDu/BbIEFdeuuUIcUMky80HorTPAJj3uIbn0ObgnMQ6uXOPOzsbrtOPp5PAMMnD8sctNVG2Epawamn0BmvtUfLeqkdsbHa/+Q0f4NCgcLV9HFUVF5i58nCQFu5DV8W669MJsoNeeti6ScnVJLJGrCPYHAwEtqahm5wQBPcbOjS2EiQmaG4zS5uUUJs1U25f7tFUd35b8HUqfHWtsgvv80a+Y4zRH2lOqVJCV/QPKO8Jg11LRpoOS0dQ3+neZ51z5ocTb8h1cowF9XD6NbaVf86aOUQj0czVqppKahDmfylzygw7xHse5vd29BTMKxOsL6LTkTJCaXgvvI1RCUKvEkRdRxOBPdRRQ5B9F75kvSsmnyVU+MZfXKq7tDmRCn1V+O1vwNvcEkLwuqcM2n4QXXqVIBiT/oJqbaIswA0ZowS43eIxybXZ0bHKwEPMxru8IJUWPxIfBon+JH8Y+tjOqzdsPOIKKboexYkbBNryvsWWEiDkvTkW+joY4dWSU2MYOANFRSeN33LUBiIeLC8nBjZom0r0g2+wg2XwBSNnosQQAna7pE/qAhVbOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(86362001)(33716001)(66556008)(110136005)(54906003)(966005)(316002)(6486002)(38100700002)(82960400001)(8676002)(6506007)(53546011)(478600001)(6512007)(9686003)(6666004)(26005)(41300700001)(4326008)(66946007)(8936002)(66476007)(44832011)(83380400001)(186003)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHj+mCR5Jziadk7EE2wfEoU3W/5U1eMGqdWSxKWbnmyXbLPTb1uj4SiRPlV7?=
 =?us-ascii?Q?NWCzr4xbXybx5pDl96H2FnKo3sIej3vxso8N7Rv/V7OlbLgUmJUT1bPP7xkK?=
 =?us-ascii?Q?l5SzapoBdwB2c+vjEXOON4jzletJA3k7Rbw3resGg9aX4QAkEIlLmFrWE6VF?=
 =?us-ascii?Q?SjjU97ddC5XrC1WAiCjP1OErVP0IZdOMpAceE6pNiqUFLSfZ/luJIYQh1hSa?=
 =?us-ascii?Q?naG8IGzADccwA+L8YkctdrKZVT1fxNNlhc+44j+gyw6UUEVggUWmwpcZaFiS?=
 =?us-ascii?Q?hHBwq2VIwE4HJUouCD6iY1NV9/F35/TVqtnspXc9erqf8uFfZ4MTMmiXBriM?=
 =?us-ascii?Q?UykH6lYmNSaZ+9g7XrTUeOdfdVXikI8XTBuWX0ERTF77r5XepLFoYucSNuG0?=
 =?us-ascii?Q?m8isjLBbo5uMuw8A81i0XmxLlFSwadOHk4n3mS6srDrdpIFyLOR+O/qKXN1l?=
 =?us-ascii?Q?+uT+s7qyYiEuAQXXXWxB9ax3095mBsiOPDE365sNt/TYWSDgYKCyWG+kWWRP?=
 =?us-ascii?Q?M/B7hP2s7ZrZbLAGx4rbB/efXG3wEFHhZgKRcahiBJnNX//sDUKO3kxhrP4P?=
 =?us-ascii?Q?AxOvfaxsHWPPPIAZpBqO5Renaqvk6nrqeirYi7OwsgKbhwfS4TeyJ1kfgRU4?=
 =?us-ascii?Q?bK0qG1ECC0ByhXaPOFY3ne4mULwbe0aOHkBPJcGtSxa+ug6We7Mc5sYuaFcC?=
 =?us-ascii?Q?NdWeDlWqZGCXVfBSYyVozy+GZcHy1DQWAzHwiMnbpb39Q9B5Nbri20P0fkwn?=
 =?us-ascii?Q?aU2gVtutY2WhYqS9UevL6O5UuuWmgE/pltJfdFrq3pZZ4+/hTHAL+8wCFWHi?=
 =?us-ascii?Q?VN8Do5ecHYgFe06iPTGOPnHOYRfDr0z+M6qCOXSN9jt8Adm2adv1RoWpoxqk?=
 =?us-ascii?Q?5naFZ1S586R9/GTP5WewfXVu3Nx9FeM8KYSaicXH4I2qslVt+cBaHGUD8JB+?=
 =?us-ascii?Q?FoAL80AB0rw1nCTwD8rYXotongNcOxwa0YgFuwzlk0jgfxYBKcVU7CDKPByu?=
 =?us-ascii?Q?zQel19EYrARTaoicTP9Np4WX91W3LB81WSIWx0u/jizF9eOdxpcFlxBZ4rCD?=
 =?us-ascii?Q?6Wcn2iAJ6KwBhAJH2aQx+2gYi2FYZ3q1m5ta1qklyKyc3C5BMt5xyJQcfq1p?=
 =?us-ascii?Q?3Mg21A+OgSxGSgdFGq4ZW9f9Rso3pkD8SJ1+hrzvWTFBziUxdpTlet47qu3Y?=
 =?us-ascii?Q?31mbusnnew0xb/dihEMeZfnHDkAvaEPutoAQcBdwWK45AD5Mto/Gjg0Gpxhf?=
 =?us-ascii?Q?V9tBMeUJC1LdomVkhmcGo4+pEamL3omqqabOdG0rr866DE1v5uEVETXHWxUq?=
 =?us-ascii?Q?UrFeaAmSDelJM8RghPVoL9jmOVkRjKrVfJCeL4SKYY1TPAnMxWHVdTBkJMe1?=
 =?us-ascii?Q?srYct8nlBt4SOZYSjYFJtMKKLGMBCoo1D4plSEyVmsQU6oEfbo6WKHlEnx/s?=
 =?us-ascii?Q?dO64meEYIb0vAaXtUwqhoGCsodDoiTXskHJ9H42s2DvWaT0QmrlTkIHeaanA?=
 =?us-ascii?Q?K8lXWR7mllCuJp9YgAoqRvaW8XhaP7jZqOeKcKXN+MdJ1H7U8k9S7w9wxq5y?=
 =?us-ascii?Q?oykbVDhu5+7PT4xRVM9d1uo+YHuWKG+F5qgArUcu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7b7e6e-4c69-4a7b-195e-08da9ab61957
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 03:13:32.9350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sqgwWksSw0QKogpA4XikfAdFNPVt7uj4coc0FL1Vlj93n92rkUolku89tOJI86Tq1NqJbvt6B/Q3DdT95Ntpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
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

On Mon, Sep 19, 2022 at 11:30:09AM -0700, Dave Hansen wrote:
> On 9/19/22 11:14, Edgecombe, Rick P wrote:
> > Clearly somehow it is though. The original report has this in the log:
> > Notice: NX (Execute Disable) protection cannot be enabled: non-PAE
> > kernel!
> 
> Ah, crud.  Nice catch, btw.
> 
> So, the CPU has NX, making cpu_feature_enabled(X86_FEATURE_NX)==1, but
> the page table mode does not have support.
> 
> I guess we can either clear X86_FEATURE_NX around the "protection cannot
> be enabled" message, or do something like the attached patch and just do
> the check at runtime.
> 
> I'm not sure we want to mess with X86_FEATURE_NX itself.  It seems to
> get used for a few different things, including on the KVM side.
> 
> 0day folks, can you see if _this_ one (totally untested) helps the
> situation?  At least this is a real oddball case.  It's not something
> that folks are very likely to hit at all.

This patch fixes the issues in below two reports. Thanks.

https://lore.kernel.org/all/fcf89147-440b-e478-40c9-228c9fe56691@intel.com/
https://lore.kernel.org/all/202209141701.e293ea84-yujie.liu@intel.com/

Comparison of test results:

=========================================================================================
compiler/kconfig/rootfs/runtime/scale_type/tbox_group/testcase:
  gcc-11/i386-randconfig-a013-20211012/debian-i386-20191205.cgz/300s/srcu/vm-snb/rcuscale

commit:
  652c5bf380ad01 ("x86/mm: Refuse W^X violations")
  0718e6a68e2a7c ("nx.patch")

652c5bf380ad018e 0718e6a68e2a7cb20800b1b1372
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6         -100%            :6     dmesg.BUG:unable_to_handle_page_fault_for_address
          6:6         -100%            :6     dmesg.EIP:__change_page_attr
          6:6         -100%            :6     dmesg.Kernel_panic-not_syncing:Fatal_exception
          6:6         -100%            :6     dmesg.Oops:#[##]
          6:6         -100%            :6     dmesg.WARNING:at_arch/x86/mm/pat/set_memory.c:#__change_page_attr


=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
  gcc-11/i386-randconfig-a004-20211104/debian-i386-20191205.cgz/300s/vm-snb/cpuhotplug/rcutorture/tasks-tracing

commit:
  652c5bf380ad01 ("x86/mm: Refuse W^X violations")
  0718e6a68e2a7c ("nx.patch")

652c5bf380ad018e 0718e6a68e2a7cb20800b1b1372
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
          6:6         -100%            :6     dmesg.BUG:unable_to_handle_page_fault_for_address
          6:6         -100%            :6     dmesg.EIP:verify_rwx
          6:6         -100%            :6     dmesg.Kernel_panic-not_syncing:Fatal_exception
          6:6         -100%            :6     dmesg.Oops:#[##]
          6:6         -100%            :6     dmesg.WARNING:at_arch/x86/mm/pat/set_memory.c:#verify_rwx

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 216fee7144ee..005492257abb 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -844,6 +844,7 @@ static void __init x86_report_nx(void)
>  		/* 32bit non-PAE kernel, NX cannot be used */
>  		printk(KERN_NOTICE "Notice: NX (Execute Disable) protection "
>  		       "cannot be enabled: non-PAE kernel!\n");
> +		__supported_pte_mask &= ~_PAGE_NX;
>  #endif
>  	}
>  }
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 1a2d6376251c..f8162fe94bd0 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -587,7 +587,7 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  {
>  	unsigned long end;
>  
> -	if (!cpu_feature_enabled(X86_FEATURE_NX))
> +	if (!(__supported_pte_mask & _PAGE_NX))
>  		return new;
>  
>  	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))

