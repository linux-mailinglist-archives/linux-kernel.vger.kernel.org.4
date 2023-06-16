Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3511C733B41
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjFPU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjFPU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:59:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C38630F1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686949181; x=1718485181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4dDNxN6FVJleF5h3VCc4uAvkReCHgN+dAUUa7tPStJk=;
  b=FIE/6dq+cpOu3JTyDE0axx8F+JjLEfIFjEtT3Zt0jK2CZ2vFHH/mgsgQ
   W/AMB/+YI6AgybC+XNeyTlwmvMmw4XAJHnxVJvUsWFMEH5J0F//rCebyu
   c3Q2vmpdXFV1QoMn7Ma7xBrirwJLiifk+wmgvh2P1xmqHAhh2uZyomTlb
   nin2bPkPE3bxhm9YcSqGS/Fgxw6a7LkQAQvZ6nTh/xS2v/7Zdy6os5OVX
   4hQwNPE/hBLmg66ZhWRkVuM3TNl/BR9fzIoDQH3YN/AgTA97GOKZpcF02
   8O8C0krdTR+KxRURV+9hqS1syxZ5kTJOreXgXCj5QM52sAKva1nAIlwcL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="356802084"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="356802084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="1043216236"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="1043216236"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2023 13:59:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 13:59:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 13:59:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 13:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBJ32xZARRJM4kmqnuwiPifJaiuhoW05P4NpgdQ68xaSuUfwy6f8f9mlLYvd4m3PP/piN+phM2D/tHoXmqXWa3MFpbnFuxoIq+Sxqqm0JGbuBbW8LvMxpARwsI6bHyd0DQws6RMqqbPV0rg7xSL3E7lHOmS8or23VkWsJMkJBmO9NwNz0hwk8Rgj03KCLmASPqx9XV5P7P3LPyvMzjVa6tQ9EdmFl8uUikf0t1b5/FPnYHGew7p5wh6b3vWyqegzq3aMO/ef5du6pI64toMa/J7qa8NTVJQCBAjVFcAlHlZFHP1vklkPy4jpfckrmlQt2f1LMfkzBYFrGA8c6aOMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpD02aBneN6OTpA9vBHznbkhCybwQ/66ZHsQyP2GYkQ=;
 b=VQBeJpzlVmamyv0oRZOUdDQh8QS+kE1XBIrKGPzfyE5QcqIrF1bbZ4elH6JK+Q77wtWC/ReF/bWM9RDvLYBeeWstvtcO5r68rXc+ZtLHo+UlYmC0y3UqOuTRhhte5QSDlkcyoDDdXCvjFUqjiqpMC5bEm5rjUUAhrmcLyZd3k4/F9EQZXaptJ/wipJ1Ddzi5P0OV/Bhnukdy3BzgthJPjyQXBapgrWZIX7PKMW9TGNvOLhoNecozhu/SpthDgLwcZlEvzrjUwAjajwSte56vk7AGaZ8O3PCMV17P6CJAK2AOqr+oVD6p5IwvhnS8GPK/aKmtN3m23UUzWHDjbdAV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 20:59:37 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6ccc:155b:3b7b:754f%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 20:59:37 +0000
Date:   Fri, 16 Jun 2023 13:57:59 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Tony Battersby" <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 1/7] x86/smp: Make stop_other_cpus() more robust
Message-ID: <ZIzM13q+zI7d1eZs@araj-dh-work>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.263684884@linutronix.de>
 <ZIvByEFqiJZOyau2@a4bf019067fa.jf.intel.com>
 <87mt0z7si2.ffs@tglx>
 <ZIxt9Er5nJRjCUXh@a4bf019067fa.jf.intel.com>
 <87h6r770bv.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6r770bv.ffs@tglx>
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 840610bd-b317-400f-2d0c-08db6eac9827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28uPxo8AJmx5UyAvLVKT+yW4Rv49k5hZ0jLR0AgBO1lbk+qBhKngv8lESyF5AJ2M6EI2h2QDJdmTgmwSzYJqBr/oJRZ8IzN7wnwIsb0lgLYJT6IAulygi16kwnKT4CE0eGIVVm6iO0Ub8VhqxdHYKC61zkDHBi+TP4zQzBEajQDvZ38yOkngzFaQ9lAvcsU/4cQGzdfyNYIN+2M1apx17I4PsFD6Rtmbebe4B8TDaXhuQzZ9+utXNWmXPeOx80dBkwjwC1XN0JGZj4OGuY8SlkZrFI28rg2Mup/xlwiZ8QiAxIip8UuvkfTY4Q0wiTAQdeOy7IIx2oA+O6J60ypaTppKeJVRIzaVyI/FRwt2ziGSKxdoX1rcn9T5iIZJ4ISY81oWr14d4C9vKgYobPhjHD2WTcjpeXD7OSP8gKZOKWKegrUwT+cgGBYdP3yy5AG1c7OWbws8H0AlWPR4GVtGlQhhtgMOZKMDUKyHV66Z1QP7h4cGoi2ogpmBkTJC/vRs7DzbkVpU+DSwrN93OGsubaCqLu1rmauec8Yhwy0TE2sSWviu1sGmwncklE3ckSSee/4SxMxK1m9/wez/kn6TC0KaKOhstPvSm71V3mJ1mjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(8936002)(2906002)(4744005)(5660300002)(44832011)(41300700001)(8676002)(316002)(66946007)(6506007)(6512007)(6916009)(4326008)(66556008)(66476007)(33716001)(478600001)(6486002)(6666004)(38100700002)(82960400001)(54906003)(186003)(9686003)(26005)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRw+aPkiipARBsosc+68zqkpVJl8Z8jfFZg5xjiClpNgOyBTS5ZoBetDo2H4?=
 =?us-ascii?Q?Z/+djCOMwbIw3TdR/P2aqqMcQebBKu5oijdDOZSm5H31ZSozi1Iwb/Q17TIN?=
 =?us-ascii?Q?9kXcGsCRX1gQr5JmRwKsU5/aMf16O22mqK+ozpEbuQ+CnKhl3m2Om3sbYv8S?=
 =?us-ascii?Q?YB+aVDcSbcDEAndpE/NANUTeZV2Xn437Ht639+I5gQnRiwTgUjS7WkR8bTHt?=
 =?us-ascii?Q?Dd6Qtg2MMPoQXfMNYQ96eNM86dlsqc4wsrI0zaCVHhl/E4tKywINnJLDvfbN?=
 =?us-ascii?Q?QAkxVrZtmf6YsMKoghtZJIgmIgRnogcx3mXfTrQjkDYRjnynLivUb/12ayeZ?=
 =?us-ascii?Q?zCRYvDpN9Apvew0y7vqNLynNncjd8oViU2p8R4OiLVVEmj6AYaOS0deuBvsr?=
 =?us-ascii?Q?SjH2VCbzAPVDwpMiamTaqXD5s4yN5QdiWw3rk3DdNXdSWquZE/DR27Kw8Gwu?=
 =?us-ascii?Q?HsDoXobkvhoyvI3brRqGioVcsI+jnuhku3/5W3p167gTHT6woxGmbwCXI7W/?=
 =?us-ascii?Q?2HUjWdqISX0R2gdPX1JQAzU4PIJcW03yRpOaA2Ar0CneYjKp773LUybFeufT?=
 =?us-ascii?Q?5PQv61sD9aqEkl1hb/LkBg+yxWpBHZjmP/O/YtYVj1eiA5HZxXClt3j8ElFB?=
 =?us-ascii?Q?/5JrpVgNHGgLm3Xnwdbe2hbXErw/YpX5eksmVVcDMt02MmGn5feC6+8o8/tj?=
 =?us-ascii?Q?qwfcqQWPJPM4cgiYxezY5+3t9UUctYBgxAMNCaFHgll3eypDmaERzC5S15Xs?=
 =?us-ascii?Q?W8L8EHdkjTqv6jUZwqpO0CqdPXBIBtwcEUY/3lKgmh2oT6TLjoBzsnmrr581?=
 =?us-ascii?Q?oTCxKAetnw5zbgpXHpEGbCn2BfjxWp434DnIYoew9K3Xg1/dQGqlXzD08GsJ?=
 =?us-ascii?Q?ZflvD08QoZz/B8PbTbtYj6m3W1DB6Y1x+aIVIJ+oY0LOZa2j6tJFD/mQ11qy?=
 =?us-ascii?Q?pKxhsmHI+m+vV9wLK4rIg5p+QTy8v16zFVFNYmg/4fCN9IEhjpdVp7f1DvVO?=
 =?us-ascii?Q?Mo/CwgSIonlK1R3Po48azC9913v6PJot2P7JU7MTpvbcU0wVpwylwD9szajS?=
 =?us-ascii?Q?mcQaf6lYaCUvxsmZ9qD8VkUj8j4QnlpQGFV/lzxkzIMTggYYAAoACEHcB3dh?=
 =?us-ascii?Q?QT6GxrMj4nX+uEPVuuQuUUbv0CWWSXNG0xEnmcbT3iMojcDr8rx4ty1g/D7H?=
 =?us-ascii?Q?q0GnO2wEnP7vJ61zqKODozkM4lGnShPz/nmo97mqNYJ++KizMGYQMF/nprJX?=
 =?us-ascii?Q?IDOu2R4KBNR+pEbEXBryxIL8n11pPkC4Pc8Cc3kwBw4YKc/77/DKD+AUUrmD?=
 =?us-ascii?Q?a05sVg1bSyKOrOCxfa4uHWHapOJ03VcQvMLJvcWvMY/1yf1YulnwEKkurvrR?=
 =?us-ascii?Q?KWPl+e7WnTArn4QEJCDGvF+zjwLDuWHXoIL/439++TUeciIn1mAxNt4rAY4c?=
 =?us-ascii?Q?EItB5OPm1AoC47cor7UuCybyAinEdKL9aX2cCXyxY2NwmKYJQIIiLikwY/9G?=
 =?us-ascii?Q?gVljWg258V55EL4U08KhFdB7ElqrSSaFqMEG+w1n5plV3TIm7WNUkdl0bval?=
 =?us-ascii?Q?v8M7qIyYX0EoWs6vJLEzAef1ApaDP7K2M479xHlavJrIqHIrWWtPapgFCnMi?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840610bd-b317-400f-2d0c-08db6eac9827
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 20:59:37.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M++N3nfQDrinl1KtXSZE/s242WSu5Hard+jypmDQ7KH99oowd526pBoNR3ohRst8c3O74v+DrQuOqosZM9GQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:01:56PM +0200, Thomas Gleixner wrote:
> On Fri, Jun 16 2023 at 07:13, Ashok Raj wrote:
> > On Fri, Jun 16, 2023 at 09:53:25AM +0200, Thomas Gleixner wrote:
> >> > can we simplify this by just apic->send_IPI(cpu, NMI_VECTOR); ??
> >> 
> >> That would not set APIC_DM_NMI in delivery mode and the IPI would be
> >> sent with APIC_DM_FIXED.
> >
> > That's correct. 
> >
> > Maybe if we use apic->send_IPI_mask(cpumask_of(cpu), NMI_VECTOR)
> >
> > apic->send_IPI_mask(cpumask_of(cpu),NMI_VECTOR)
> >    __x2apic_send_IPI_mask() 
> >       __x2apic_send_IPI_dest()
> > 	  unsigned long cfg = __prepare_ICR(0, vector, dest);
> > 	  native_x2apic_icr_write(cfg, apicid);
> >
> > __prepare_ICR() seems to have the magic for APIC_DM_NMI?
> 
> Bah. I clearly neither can read nor can remember any of the internals of
> that code:
> 
> apic->send_IPI()
>   x2apic_send_IPI()
>     __x2apic_send_IPI_dest()
> 
> It also works for all other APIC incarnations. 

Works!

