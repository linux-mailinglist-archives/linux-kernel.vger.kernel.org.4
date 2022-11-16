Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6A62C367
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiKPQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiKPQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:05:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D03E554FA;
        Wed, 16 Nov 2022 08:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668614753; x=1700150753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rKmQan3/DJHoyXleVttFj6KJvLoSJmLwAud/B8qqdeY=;
  b=lF4PAqSHP9WFXacrg5qcrCABlRcTT18GJIsovG7WCJYGvtj1xiRzTn8r
   i8s+6gnv0YIUA09SA3zv789CJPO7K7SPwJ/KsLpyCzitqq90kyU2NKINw
   7EJbAd9CoNM7G9EKgSehuTCfeW7rzz+GSzitqZj09i/+ZdNU53WikAvM1
   YYyNw+qLoLXAtIEwB+aIMk+RjHNfCdf7KvVPQaixrGkOpPVRyr3RuFmhE
   SeiM1EWFJpRiQqPn4lrzG/Cn95gnnVukC3n3fu1//HIk3zjvfiA9g6Uq0
   OMUYnSaDSXpULhNfyFuqdZyAZ9DgiHNFseonCTlsht8dkm0NsxjbiHj/d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="295946927"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="295946927"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="728419829"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728419829"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 08:03:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 08:03:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 08:03:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 08:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE0AAn2Wp/P/9lZw/GpFmZYlxyJ5OkzYEROR97CgbSerW10o9npyAukyQuEvrImbvbEBknQo/1UG837WI270KS7edx55L2M3Sow2M6JlKsPfgwe2QfDZfAf/kkKkLLuwfd5Lsv0Apb/Vxcp51/xQ9L7pgZO1bcxumARGP2120QkZnxrlMBqJIuYDTjCea9Z6ysdYrobIsqnbMm2vRUCop9kl5WqeGYc+6x+EXDdbRys5vSrqL/VJHVAAVWXSWtA56816Hw0GwgPd6pHnjVIhxd+iQ5uBZ5xeWpIQeMudFoopl7m8Zu5e0uHIYYywtkdoJGUU55GCMyJHSv3dUV9FFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DodF27TVasqumnDqpXSteqiaPFz7bdWEyqSBqQ03wLI=;
 b=fgNdG78QF/jsFHyMLHe5XFP4qTls5vzSiObSiTdW1fy4Wxqe+7g7f0llhR9VccoUOWawjkhKmnmWs0ZslAxduSZVrDJb0ezfk2liHY3w8NDsr4bS4ScZKSgeloqrO7FVjjQzi1yQZ4Une5wrOL1Bkfh+SaepK+I0CmFt/O+b5kwUkC0rifnI03wwxES6IZT6TcDw5E6sieDhm69auJwQGhSrlyTBJsrEnyay72VJooEhxZwMXnyVPqlsEa8jjsvDfVsIXF4EtF1RmGyEaqEMgJcAgN7iwUMuVodUOANtOY+xtvLHmmeJdcG1tinHKmZSM7zqP3RpjKrZZYMafBUkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 16:02:30 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::6dd2:a8a3:7f9:ad%4]) with mapi id 15.20.5813.013; Wed, 16 Nov 2022
 16:02:30 +0000
Date:   Wed, 16 Nov 2022 08:02:24 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 03/39] iommu/amd: Remove bogus check for multi MSI-X
Message-ID: <Y3UJkEb7ejrxbW22@a4bf019067fa.jf.intel.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122013.772447165@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221111122013.772447165@linutronix.de>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 425fd910-2f71-4103-4613-08dac7ebf5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaFLhPoWIXDBczN23Ba21f6gEPSCkDuUdVl5fvj8i2ZeRGARgqAgEuZCuvzaMzP7D224AUmOW1NxoKAAUhBaOPvPhjVCGKeKGx++VIiOFN1j4NdvkIuOoa6teo9jIHdBtRG4F4Pdrv5zQQOjFbbnmpj20RJcPMCJnwpdyoFLqGMqJufKKYhStkudOrMcNDZfkI5k6EboduOhbuPIYgbBUZCKqCAPZlVRRFAwMhS1v32nD10d39pxHqE1ViOQNzm6cVEN/V5FuG6ciDfq6txmnlYlQ+L3fEUPMbqvrGi7rPeKU2K7fna+17iC+axHNv1GmJuvZKBe/CC3L+OjVnbkN8FsBIVqvHuyHo2uV/7f2tQQXpm8ZIoV4BbMVzf4aCsgHz9ug0QJaiP7KeNT5fPLdxZjkdBGjTAnLftOAhW/mV+as0wZdg6DxGS1HG1fto+uaNS/MEYAajz99aGIz0Mx8qNIHTQk8Qui4e7DToadvIbRh5ArGF6dV40V0Mw6VQwk91uMPH2w9SZNtOHM1aa35YfUNN4dHVsCgm3BNcYaePIlaEXtm6S9/DTbvJDiOX26+5QCFEsfxS+vFatYVhb4xr/7aXY2vnvO1PBcrxYj9FUjeHpf8mnxdkNttEgEgENh0EK674xHWplNhb9S+x2ooD3ZwsdinTwj3FhS3DITvPIBxdDf4wt676Ti3ItkbNUogRo3snQr/aONV96HSxxpSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(82960400001)(2906002)(8676002)(66556008)(4326008)(66476007)(107886003)(86362001)(26005)(44832011)(6512007)(8936002)(4744005)(7416002)(5660300002)(41300700001)(66946007)(6666004)(6486002)(54906003)(478600001)(6916009)(316002)(6506007)(38100700002)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jEFvEqdV8vhhcpxNm7B9fEluG9Bnxseo8sCBx2kEXMrSzV4uXTfxKKNkW+7X?=
 =?us-ascii?Q?WuTKvGWg804ey64Yag91dfLMpTlO4MN3dhbuIUabPU05sDlSNLnW15B8C81Z?=
 =?us-ascii?Q?hxGtgiNsFuyBzTMS5mFPSZo6x3O03y4ZNHPXH09LvUqtvptUOLLCE2WLt+KE?=
 =?us-ascii?Q?qTbt0rehEEd5jCJID8FSbi4TGz/8UkrOk9uxNFfy+VmCeC1FcqCU1EG3sLUB?=
 =?us-ascii?Q?IF/g1Thy3DkmJFEqhqY1K5iQFhkiNj3uWegAGx2532ojucXuIifIgRU8lXPo?=
 =?us-ascii?Q?nLnyi7NmYo/JOcKTS/XOzlltfPbCI3u2CGRAznYpXtqnTiQ6oAX5Y8HGzTIq?=
 =?us-ascii?Q?YbhxzZNBfrhgR7VYHtwqx1Lx7u/ikv92fD+erp1hSfe255HFoeR/0zju6IUN?=
 =?us-ascii?Q?9ffCFRm/VbQzGawbSY+/T3bQapRf2fnN73AmwJGr/tRmX7ELOrCprqaVNH5b?=
 =?us-ascii?Q?85CpkU1KJt8Jxve65fiaE+r85H1aWNVJBypxHkgFYkLwhHk41mIJ91CojTvt?=
 =?us-ascii?Q?Ar1jCJeRblyvNMXZVG2idXt6FTojIZlUCkjR6o1aFF8+cmAieceHi6Kv5284?=
 =?us-ascii?Q?u3do3YZNemgvMFUxm8Y6K7kgzE1HcE5OEX/dnxGJlbDal6urWmdxF/0XcAd+?=
 =?us-ascii?Q?2s4xtGlTy5u5wEEwP7bfhmhK+n15mD+OEIHq0qoaRCfuVGeuLmNHIRNXXNvf?=
 =?us-ascii?Q?/6AM1KRvTfNtmnnIAMpzLHps0VdAx0o2YdubzJRfVlzl+bBmwhSGqA7Prgtb?=
 =?us-ascii?Q?V9Fjy3M1W4gV8eJDaAuA+9Q9H91zRsyWdmxPV/Hpn/p6h9IQ7x1PZesJ4hOq?=
 =?us-ascii?Q?mjxVDyKzFEmywBOvCVOvIx/bqicRHZhYNsDRn+DZjBPir4GcBiLpbWWob5f4?=
 =?us-ascii?Q?EFzPAQIn/fCnoUd/Pzgdv5OCXCPowDjS9ANkJlsOti0LA6sABEA2dtlEF0za?=
 =?us-ascii?Q?d01o8GAoBqO2OBwWeQMjs37ifwPeKMbkEggjvYPIVvfj5W4FvDO5cd/6ELcH?=
 =?us-ascii?Q?m1/kATS5RQo+MGRsYLIH/jGJfrO9cULf4WomDWlxgXp+RM2kdBoCbGMbYf2z?=
 =?us-ascii?Q?ekKt+YnxEk34CAcGj1aYFkreCySwtiA5fcsYEO7jDTmc9UWedoi7VR4YmH2r?=
 =?us-ascii?Q?ysjEEuBw0ANy/yI/HMAExBcbbT17XwO7phE0MpjzNjJgP1UOlHtzRP5DIOBw?=
 =?us-ascii?Q?F3hs2543k3KZ/vLmYFNNX8WoykfJzf+n8bX2ZOmYJYxa6WjJbnZH7hG75Cgj?=
 =?us-ascii?Q?7+LpVbQGcdbWrj1SvJ7T+5wAAXDPF6OK34Nz3ppni0qYwKwKHO1IxflPWr7p?=
 =?us-ascii?Q?oFleuHvUfYFUpq8zMBv0BdH9+y0ghCFyqoBYi4qJn7G3gBQuA5CzKc1NA01T?=
 =?us-ascii?Q?gXd++3KpqVWahee2dlYhYtKUA+mubXHamqsT3FrXkhLH2syh1sKw85noxwvg?=
 =?us-ascii?Q?X2J/2SqnMXD9GEC9eS/BXPF1uutXcjOFzTUJllKEsQKc/a5yQOI+8IScotWD?=
 =?us-ascii?Q?C4TXPCUyN5F1vHAtQOCk+UpE6ohM7L+EQnHpZpa4IvByHqziEBAGRCF49LPM?=
 =?us-ascii?Q?8hCkdkYbnVIbjyq1WCe6FcZof2MLyHejf7D2OQjefgHxCdtO48Mrooa5AXvk?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 425fd910-2f71-4103-4613-08dac7ebf5cb
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:02:30.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPI0UBRwmYuuogxHN8baTpVvWiN8lIwSFkPyPQ6+7y1WCtrORDQ0I3weutbSb5yB3ylvBORP0vMxga015NkMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:19PM +0100, Thomas Gleixner wrote:
> PCI/Multi-MSI is MSI specific and not supported for MSI-X
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/iommu/amd/iommu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3294,8 +3294,7 @@ static int irq_remapping_alloc(struct ir
>  
>  	if (!info)
>  		return -EINVAL;
> -	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI &&
> -	    info->type != X86_IRQ_ALLOC_TYPE_PCI_MSIX)
> +	if (nr_irqs > 1 && info->type != X86_IRQ_ALLOC_TYPE_PCI_MSI)
>  		return -EINVAL;
>  
>  	/*
> 

nit:

maybe better to merge patch2/3 since both seem related?
