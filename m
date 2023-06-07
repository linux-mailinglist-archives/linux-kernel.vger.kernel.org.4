Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7785726682
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjFGQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFGQx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:53:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6742115;
        Wed,  7 Jun 2023 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686156832; x=1717692832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vwuRqso2oVc69+CbISXs68maDonYzyqO+lVLKpv174w=;
  b=kvwQ2qyjtZZ6Oz7pTupSFf6C3FM2Mt6YoMtCpT4UORvsUsd/EbJkAgvt
   UISUwGNZAAq/bCes7BAMeuh1BHetnKGIlVkPUgsE/bncZmRv3OBGW2TCP
   rrk8Mi3RbesO6Vcn7rAUAtyl9rDzZyBr2Rj/7OWkFJ5S9302e6Ax1dSYI
   e2zj8gZu4//NXBvPGhlw84nQ0EuqCUzluVay/l0Gf3nImHsopwIhAxlTE
   iyqprxPE8Ndqjd5FeOdX51Dzd6UP84JiyAKsiIvrztaMpvkOMORdPf88X
   gb2//IAHvVb+NYq8mNs0h93ZJNcus4ywInKX8xQwp+lNHdkDjL4qpMZLd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443411216"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="443411216"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 09:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="709623131"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; 
   d="scan'208";a="709623131"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 09:53:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 09:53:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 09:53:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 09:53:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObIICyvWT4su3Qy9RD9CzOsf4ZtBknqw2cL0Z98GL9L+GucZ5/Y40nkI3jfIW8+uwrN4viIf9nbNHcPhCM8RXpF2MhIZmORWRmBDVaFc/YIcuc2M/uXkCM+SBGVDXi+98Uwa78iH7M8N2dN8a9mE/Bttp6FIkSfPDyUi4JDoVrJUQ/ZWPydhDv9AytAe+tdkdloLTeY0WwWPaRx1pyKHWcn1euznkgRG+YmxKBUudZELeFj44+lbhk8Pgl6IK6Gs3kiE7AHiAs3OPuNoPNk734JRoNVmshwXQRyxMNRYQ87UUKNjZYv33xAfa2hWL7T18x+/kllVNJhhUxj1YtmD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy2DAOI9syseRM4AfpXq0DTBEBZF24gSbVgOFkRAW3c=;
 b=J5iII6WiMS5g2u/wpB6CjBZsm3u8Ou7cL3r1WZDsYlDXPDuUA44IFP806QiNQtBDS8p/ke13S90uIzTZ7ffeYROIEtxXll4WAT/oLUdHWtGWUUxapkZxHS+eUhIKnNgSXe6tJSEMrY5sau2iQsvM3f+LoFjI/fr2X4unA+O5JPHLtIFOSWKVZ8RzPOIB8DXDYfXoO86NnO2iUGbHP9zZt9gj0BaYbcRFDk9FU/mF60jKYItgpNzIPTGO8+ECPgS9sZFTCTpsiqcxwgzDGpsHWOGggRH6difZcpmLMg+aKOYjaEXiAnNQ49no/5Npo3eRI6uWogG5Y6ypKZwudTh4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24)
 by CO1PR11MB4772.namprd11.prod.outlook.com (2603:10b6:303:97::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 16:53:45 +0000
Received: from MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf]) by MW3PR11MB4729.namprd11.prod.outlook.com
 ([fe80::2439:c11e:512b:9edf%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 16:53:45 +0000
Date:   Wed, 7 Jun 2023 09:53:41 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Message-ID: <ZIC2FYhcm4iGzlKI@ekohande-desk2>
References: <20230606231844.726272-1-abe.kohandel@intel.com>
 <20230607112711.alcspwuwpt7nqja7@mobilestation>
 <ZICboAIZAcnYzyJr@ekohande-desk2>
 <20230607152828.4nxefvimokamhgvu@mobilestation>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607152828.4nxefvimokamhgvu@mobilestation>
X-ClientProxiedBy: BYAPR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::23) To MW3PR11MB4729.namprd11.prod.outlook.com
 (2603:10b6:303:5d::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4729:EE_|CO1PR11MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: bec41b10-edc8-4806-7b21-08db6777c1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XugtMGVOEWTkOvLYJuxIXz1xW/ntQRE2ucCnm2oMUcF6GmBbKEENMr4bFCI4WbBJOD0dZnuOcw8aiBRkNkOhaXJ0GkSorBDCPndMhd+azIh6+hKAzcmO2aNgQjauO0tVlLLR64+1GJf0kWtzSo+wePCNDZhOFryPa90UKwQ6FAGXcUYxZjw3le8Zw7B4mfRvaVV+DiQW5MRcDyTLEwQZQcQ30L8VLiNaNFUIp4/w5sWVkz/TTNcS5p5Y20Rdi27ZkJWQXsBbqiWnb2QQRJGyvdr89Ct5ONW3o4ikMGdqZeZruzGJ8fmlRAobEpsElkwddkwanPb9MMCQx5/rRgPA8PemcNGRaRYpcOQ2PeHInjX//TOxuW4/KS1h6mXU+REPgcEMX0v0OK3mXEMsOUDe9OkJr6CMSsB8hHBajb3DZNrgGPoQMWsnCY9TiATLt/x73oQG33DGuM/GYgxtaGLYos1CVCOcovmXbMoF1LHUQVHhqVw6SIy+4cvup3wbcMW6rDx5pycXFAepXAdruG4SCaNwYgjHr16W/Lx6jgsY+TaPHp1tw2l30NsK8hzP4R/s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4729.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(54906003)(66899021)(478600001)(6916009)(44832011)(8936002)(66556008)(8676002)(2906002)(33716001)(5660300002)(86362001)(4326008)(66476007)(66946007)(316002)(82960400001)(38100700002)(6506007)(41300700001)(6512007)(9686003)(26005)(83380400001)(186003)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3qZ6VYi/TMrdKbzFhFVJzDES49y5WmQVnl1EWxcYE3Nv6F5VP3zZw3Io4rx?=
 =?us-ascii?Q?89jDHgoue9zTMXyBCpHTCcj28mBZ3llj17TBnYCmkc0z2XK29ttVVirsNq5W?=
 =?us-ascii?Q?5s1a7/4ltOoi093fAA+477BGC4tejkh9GKBvhwwwFc5cSlgN/PBW6ae2tMSe?=
 =?us-ascii?Q?7TWaRcZ4RnrYeh0MtppveDFfgYQ+plHp69pve8ElmTvlhxnj67l8D2XwGnov?=
 =?us-ascii?Q?mgzjLjkqzkQMh/9HH9bu0IQ1wm/ZJdGdCI3EnLb30c/HQkrq/VleyLl6vjMD?=
 =?us-ascii?Q?1RUyQsWAQzjyl9SZV8KwvtJAe/Eoy+CphmyP/MV9U41l9ZIXadwoVAft9wvR?=
 =?us-ascii?Q?u0c0MlsIj3GMJp8kEFVk7Zoak6sE9xfTnojbdO/cTUUnvz1XLsB3TtzZ0ZHZ?=
 =?us-ascii?Q?FuZRzFJKKCaw3526ohiQ7C+guFqau9GxAonqIVN8HVKog+ZbEGwAEx1fa+JV?=
 =?us-ascii?Q?3copptgY7lzk6hNgZlWyuSv6S1EouWtqL5m7GEFz0pFXUhZHJTqOiIWVbr0g?=
 =?us-ascii?Q?hbNDxwBMzKQaD2okGk49H5+rN6bezOUHssc0rO+TA17Psgafgv3m5sDiIGTB?=
 =?us-ascii?Q?V1ldPrO3Q9po/xFQg36atisZgVp+/FCwG/RW3GAoXcEoTVj46zsG9jXPlQvs?=
 =?us-ascii?Q?stiCbe/0zz7N2tdnbouL5w21YxqV0FfjPovhwXz6zloZ+qKkfkGR0DMWHrmw?=
 =?us-ascii?Q?TGuQesmjPwHyQ6DlCn+0kDvJIpoJWnRnC9iVmOBdpiA2BqJBu1IrJxO7zc70?=
 =?us-ascii?Q?YQDMIkNhltPLIXdZWl27RPIePi9hvbtlpsiEoYxia1KqMYmX6PglGsamAXBw?=
 =?us-ascii?Q?CU9/JvDWJs2JO1JCpn68fMKbJuIBj8P9EftPczNVa10RyfQ5hHkv3GNJRnZJ?=
 =?us-ascii?Q?DX9K8jgFFz4sXax8owQKRrhF0jRKnP8/q8iPvpSsvFlxYTRX3C8EtQF/I03h?=
 =?us-ascii?Q?OktBjXr/vlZurRI7I6Jp/hnGmUIoDmFrnONe+ars+jnbl74tlBiAptWkMeuR?=
 =?us-ascii?Q?uWrk2diHxXIrlKOoVkjf0C6EZHTLkZ696crrgmJR2qb3ijnhfgXkzRCoU+Vy?=
 =?us-ascii?Q?DqzS8Govwu/k7w0h6BYpH5fLbyzgdMnnA0xg0XilrE/0nqDv9wkF0nGaHVcn?=
 =?us-ascii?Q?ZCuqYcwCKWVEHe5Jc2X4Jw9hM522uC5+T/Nkj7wbxgz3lVV1qdaTT92iHRUl?=
 =?us-ascii?Q?1sr5EkMMuje45Z2ThIctDVXMGPyInCa+fX6RMki4qw2J1YIjuFFaCnp+dNUK?=
 =?us-ascii?Q?XqgmqEyTdmV43BMm81CDbv8Nm0RykJ72pju39p+/aqbyxtwSqIpUcuKhIUR2?=
 =?us-ascii?Q?HGcjNiFxUk/e9fq7Zs/nQoGT1ziIfTPWdQ/et2kXL/AVftkEg87PW0FSkQkK?=
 =?us-ascii?Q?T283Ij1icPkzDdRrzhmaFcZiRFVOnnWux+OGw6BrFhRX8daf2FKpLB53z/G7?=
 =?us-ascii?Q?C/uvqDlUlS6FXnvtToKSWQGYzSGpRG+uJSWmtW9/qR9uZJL0EGMZLVVvitzd?=
 =?us-ascii?Q?KWJgCrXhVgtfp8Oh1l/OcA/vxHErT6s00y/YqOtyRaYQBHVKirMnp4He37ZT?=
 =?us-ascii?Q?Ys1ytsF8eaAktoGpSL3eaiUT9OnZdr1GIKPgdZOX6IOtmOp/sXSZAyhOqAK3?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bec41b10-edc8-4806-7b21-08db6777c1e5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 16:53:45.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a++MSRJiHdOew0FGpJBOIE6k7TVPZc1ZeV8f6Opz+VrZ7bOr1KU/HswPArqWYOtcLHFbbJC/Hu8PHmasZ76Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4772
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

On 23/06/07 06:28PM, Serge Semin wrote:
> On Wed, Jun 07, 2023 at 08:00:48AM -0700, Abe Kohandel wrote:
> > On 23/06/07 02:27PM, Serge Semin wrote:
> > > On Tue, Jun 06, 2023 at 04:18:44PM -0700, Abe Kohandel wrote:

> > > > - * The Intel Mount Evans SoC's Integrated Management Complex uses the
> > > > - * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
> > > > - * provide a mechanism to override the native chip select signal.
> > > 
> > > I had nothing against this part of the comment but only about the
> > > second chunk of the text.
> > 
> 
> > Thinking about it a bit more there is nothing precluding this controller from
> > being used for other purposes in the future. It is configured with two chip
> > selects, only one of which is used today. I removed it to so it wouldn't become
> > inaccurate if that happens.
> 
> Ok. Regarding the number of chip-selects. You could have overwritten
> the dw_spi.num_cs field with value 2 then in the dw_spi_mountevans_imc_init()
> method. Thus having a bit safer driver for your platform.

I am currently setting dw_spi.num_cs via the num-cs property in the device
tree. Is one preferred over the other? I guess setting the dw_spi.num_cs in
code is safer than using the device tree. 

> > > > + * DMA-based mem ops are not configured for this device and are not tested.
> > > 
> > > * Note mem-ops is just a feature of the DW APB/AHB SSI controllers
> > > * which provides a way to perform write-then-read and write-only
> > > * transfers (see Transmit only and EEPROM read transfer modes in the
> > > * hw manual). It works irrespective of whether your controller has a
> > > * DMA-engine connected or doesn't have. Modern DW SSI controllers
> > > * support Enhanced SPI modes with the extended SPI-bus width
> > > * capability. But it's a whole another story and such modes aren't
> > > * currently supported by the driver.
> > > 
> > > Just a question for the sake of the discussion history. Does your
> > > platform have a DMA-engine synthesized to work with this DW SSI
> > > controller? That is does your controller has the DMA Controller
> > > Interface (handshake signals) connected to any DMA-engine on your
> > > platform? I am asking because if there is no such DMA-engine then
> > > the last part of your statement is just redundant since you can't test
> > > something which isn't supported by design.
> > 
> 
> > The platform does have a DMA-engine synthesized but I have been having some
> > challenges with getting it to work which may require some further quirks added
> > to the DMA driver. 
> 
> The main question is whether that DMA-engine has the handshake signals
> connected to the DW SSI controller. If it doesn't then adding such
> engine support would be a great deal of challenge indeed because a
> software-based handshaking interface would need to be added to the
> DMA-engine subsystem first. Then the DW SSI driver would need to be
> fixed to work with that interface. Taking a FIFO-size into account and
> an amount of IRQs to handle on each handshaking round, the resultant
> performance might get to be not worth all the efforts so a simple
> IRQ-based transfers implementation may work better.

Oh sorry, I wasn't explicit enough. The HW handshaking signals are connected to
the DW SSI controller so we should be able to take advantage of that
acceleration and not have to go through the challenging steps you have
outlined.

> > One example being the system uses 40-bit addressing but the
> > DMA-engine is only synthesized with 32-bit address capability and is meant to
> > only target a specific region of memory where it "knowns" the upper byte of the
> > address.
> 
> That's a pretty much well known problem. The kernel has a solution for
> it: DMA-mask set for the DMA-engine device (see dma_set_mask() and
> dma_set_mask_and_coherent()) and SWIOTLB (formerly known as bounce
> buffers).
> 
> Alternatively modern CPUs are normally equipped with a thing like
> IOMMU, which can be used to remap the limited device address space to
> any CPU/RAM address.

Thanks for all the advice Serge, much appreciated! Hopefully I can come back
with a patch to enable the DMA engine for this platform in the near future.

Thanks,
Abe
