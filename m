Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60972A8C8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFJDXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFJDXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:23:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267001730;
        Fri,  9 Jun 2023 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686367420; x=1717903420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TxkuYx/l8pHlSaM19HIPPX69tm7UAPdgmuR9HWa/+Ck=;
  b=Fnud/mzLPlz3gxaBYM6xeizF5Nb8aAyKbESf0AZXhx4ZdvspTfT3Pshw
   yQTqqHOtQ+drSS8t2+fju2ix/pXTaxWOXWuMv6qGWpg4BY3Z+9s94x1qd
   2dPa1Rt51bThwfmR2aaZT/GsrkwrD4JzGr6i3dpZI9ZmfJP1iBftYmnIZ
   tcqsrVa+wgdVFgAfidBKY66YweRqjgtDOockgYYVHnSTkf/lv55OVLKIJ
   x1T0fqCS6RcMN3bToCxLU/XH2+690DL8DG34zPJL2hIGcaFIfoj/wAMjr
   TwqrNP1X++qYo27RwIYO/97xY0jsRipZOC7e7ZhL10Y1CJpwykb/NmP1j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="356618862"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="356618862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 20:23:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="957359215"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="957359215"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2023 20:23:39 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 20:23:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 20:23:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 20:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUi3Ydoxofl0YwTF/zdKN0d3PZRsMOI0V2i2uX/8+qI/elr/PFfRBhqyOG+kasAtgYjt9XAwxP+VRGeeTIeKPjQwnJikNLokPOggpxwKNF1irZ24ikORPCYQnSamXfpxTFEMUN3nUKyJzMvaFUhKJO1mAhc0z1/VMJGtYy6Xr1EBpizMopmpPRu16auOMjGBuPCdOCxB3JJicMenYWa42doSpTBacBzjN0AmG7ZJqUjwXMpcvBARtcV0oZ5wtlohGYPFPlnuGAXVX7CO+yM7Ndk/P9NCMQN9u3/Tf8k02mMDNmcz3qlGfy2yMAQ/zjcjdSRTmJ1nLvnWjRm9qmtfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYlcOkaulHYCvjFBdB2HzQImCCFrfPgVDdpeLwd6eWQ=;
 b=KxirzvxlE9j2bIob3gP/BVJDpK3xTvBWOJPGI3xcrplj/nri5/FSK7qtLtVJIY9OyDR9+9TVupdpE5tkIrQAxDIyXPzK9bixZvdOI5PylaMIE9/NbbWXlyF+bnT/flidd+YMKaia8iwuHKiRkr9tjCU+LtbZAws6rxrNi5v0EfMaUiaMTJGu8H+nA7bapz3pJJHBUrB7xkpt8Ih2KLjRthw4r9MxMuU8kepkkuxE08udI4ll8e1klQkh6BOnc+yIyOu7i58FJ3PqVr/fPRi7rab/No8BgKlIq7qvtpKyp1azXfPapflcxnedsA7t5Fid0IbU3ooWk+Mj8GlA3Ri9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6714.namprd11.prod.outlook.com (2603:10b6:303:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Sat, 10 Jun
 2023 03:23:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Sat, 10 Jun 2023
 03:23:38 +0000
Date:   Fri, 9 Jun 2023 20:23:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 22/26] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
Message-ID: <6483ecb5a4526_e067a29490@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-23-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-23-terry.bowman@amd.com>
X-ClientProxiedBy: SJ0PR05CA0164.namprd05.prod.outlook.com
 (2603:10b6:a03:339::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: f165d3b3-7fa1-420d-ee13-08db696214ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AgurMw6ZUSNJld6vgowPk+cH8lXfvbmDu4R+aWEwU8OvesDKg2FSBBeqbmN9ztiImgUsSrjSaaobo8CyIRIIhcPsAnRQQPCb4f3LurLU1G5RavRvpJMPw7yhkhe5cx+cT6frWfrAnR+9Qsm3osXbcvgWLSyfwRC9nk6Q09X/qzkPJ3WbQ+B+BGRjKf/R2Y6Kign5a+BOJpqlwM5aTY4i2QfxJIFrPV3mbPkp/jDpwhz7lcZUoz8v8D26CFiw/isyVCg01cSXpZ7KF8L5UVviVx36E2mYLWN/SRpJZR8IsqilVeGCs8YX8x74/72DtMfz6h/O6/cEbMi7hD6xTsL5d8g643QmoqsxGabz/kjibT95pMzQODsgvzMy8lxi9ZzGaE0q7aHJ24JQueNjnOsoTJP3fz8mVHQ+pW4AbWsEZ0cz0+r3fUzhgVBgcQIx2Ni5Ek2ZiNThbuN3lIB2Zb20P9svXEzrNcW0wSH+7hZuNlMKj3q+fP0ornCA89vhMPjmKcXVB50NE3mrSVxN8WPak5d1c909F0BQLRyj/WR2PxoNkGqs44HjpVeLRklf03g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(82960400001)(38100700002)(478600001)(83380400001)(66946007)(66476007)(4326008)(66556008)(86362001)(6666004)(6486002)(316002)(2906002)(26005)(6506007)(186003)(6512007)(9686003)(41300700001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2/ecA8abpBg/a8uOhy67s7w6heiGNgogLgoy2ebxSEien4nnU78+bjQDNV+?=
 =?us-ascii?Q?GDC/M7q/mYudO9BiiMrjFo+IxfkCsYxmfMAKQnyR6p/9zi19udAVXadYqEEH?=
 =?us-ascii?Q?IknRgTzfxM8ZQqCv8gupuZ4Muy4iAvUYKnHUcGMEtuoFvCNTh/DijfX2dvU1?=
 =?us-ascii?Q?DvjtMKhgW7Ifr9qWfnep6lCLTozVod4w/kul+xI1LMRAhTZDS6P7ydEYQPHR?=
 =?us-ascii?Q?RpEh4SAciFUWyGHLKfHCl3BUaQ/c/Zyphch36f4cBVcD+kuJBmqDz6Gdq9ZF?=
 =?us-ascii?Q?o8bapaU7Z5IPxUxWvywUPTE3+/7iulZhszb86gw24c0OQigBukI1HD0dWATO?=
 =?us-ascii?Q?f+kd8T2hky2HO1YogUKOg8dDTqjhtqBF9hX6Y/k5R+zCx8NEIUHGuFEntz07?=
 =?us-ascii?Q?H/9qUIVBNMlq+7l40ou3OR2Ep+LJJhLawLIlqwaSypep7G54gbHfiBNfp5mE?=
 =?us-ascii?Q?5e0HuEE1Et4+cfi4BYUBWsMAsWCt50yOHADh10tqAR+kjRZzLQ/VzidHIimv?=
 =?us-ascii?Q?qxuToGICtEACFS30PAU6az/oysX0mvySS3HkyQ75zxIM9NAGaJqqivIi/HDV?=
 =?us-ascii?Q?MRRNrmOiDAgCvdmmwIaBvVVjf885+CWpWmD5CNYWa4fOrOFo3nYA9fOMWqyL?=
 =?us-ascii?Q?WDSOUlVtuGGb9lhLRr+wUGJEIyzvFZQy5OpbXSozvxhzKedsGVhL5mmTlvHx?=
 =?us-ascii?Q?QrlLXbZ5ipCt4iru5A3OlBmmpK3l2mmUyqlHT0kiQY9nlokgIisD0N1haQwh?=
 =?us-ascii?Q?xsbnPDTw83QYfflirqRVlnTAiUGhR/ZgStyQIv0lF9VTcJiP6JXISCWo9Lb+?=
 =?us-ascii?Q?VZ+ESwoO/g9Q7mtCzmWnxflZP2Wyu+45PX0g30ThIgGKJZ47d6IOR7ZWRLNI?=
 =?us-ascii?Q?+M0iXbh5JU5uK50Kz8D8m7wIL66XpqgKOSL4aop4zg47oYjxYd0o4Vcj1yTH?=
 =?us-ascii?Q?BE9HADIihxzN/PUysEPZzuhQsgp855fyQg47wxIolnb8ejYxCY8OLZUKSvB+?=
 =?us-ascii?Q?oLOVxfOrC5ORajNBiQZJSHcLy42zoDjZNOJ8hUh4VJ3r+BuMf8viUip0SqxJ?=
 =?us-ascii?Q?kaItIoyHCiw3vWGnsIEpJp436ZpNg34aM1R07/Uo0sAXSXXrqSh7hPxbu+oP?=
 =?us-ascii?Q?RtBVFD3QPhDKNbZFIX0j9Q+DVsj1QzT1YekT4cVUJ7DfnwnEsIvCLOyJ1l6K?=
 =?us-ascii?Q?78Rk3ck6DBzcVlrsCYdpUQwi9xRBIte4jtJCkfM0E9LsWw0fW4/FrimhrKcr?=
 =?us-ascii?Q?RVf9XDd88D7y9LdI2YJdSl+92LRLExp8QW7cnVIOqlyNqOIjcQxhM8QBfILt?=
 =?us-ascii?Q?MfnJXPxQlfTQ1ug48nM/ujOgVSjRlpkugZOxmX6foNadZDkLqoLsnwfQik5e?=
 =?us-ascii?Q?DqhC/G0I6ZYdRE5G+yXDoJ6YSDbSP5uqmVZ9lLELe5m074Bnfr1kF2kUDQvU?=
 =?us-ascii?Q?s2OU6ifbmaLIYeP9Ttwh6nx0vjVcBibEVJmyAn3rHKwERaflYJZxBxeu9cmG?=
 =?us-ascii?Q?g19i1gpPWLmuA7XoEKqGBkezSA7RixrcxPk/4t67j/Cuj35J2Uka1hrlnEsN?=
 =?us-ascii?Q?rgOPOFki+iqxjhGp0ge3LOzVwXnnkGIAgtr0lIP4Exwss8ijfaaMmZPEIFl8?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f165d3b3-7fa1-420d-ee13-08db696214ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2023 03:23:38.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkH8CJsOk0MoS7VkimYsbQTofyeNwS9f5NMeVr7CjRr0O9Xw1JM/906wjBdL2L5E46pLT/W/wc6xbezioDg05giQjS+1JMiANuh1kCZxP8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6714
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

Terry Bowman wrote:
> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need
> to be virtually memory mapped before enabling interrupts. Update
> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a unique copy of
> the RCH downstream port's mapped registers.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/port.c | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/regs.c |  1 +
>  drivers/cxl/cxl.h       | 11 +++++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3111f754c740..bc5d0ee9da54 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
> +#include <linux/aer.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
>  #include <cxl.h>
> @@ -947,6 +948,39 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +static int cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	resource_size_t aer_phys;
> +	void __iomem *dport_aer;
> +
> +	if (!dport->rch || !ri->aer_cap)
> +		return -ENODEV;
> +
> +	aer_phys = ri->aer_cap + ri->base;
> +	dport_aer = devm_cxl_iomap_block(dport->dev, aer_phys,
> +					 sizeof(struct aer_capability_regs));

@dport->dev is not suitable to be the @host argument to
devm_cxl_iomap_block(). It needs to match the lifetime of the @dport
allocation which means @host needs to be set to @port->dev.


> +	if (!dport_aer)
> +		return -ENOMEM;
> +
> +	dport->regs.dport_aer = dport_aer;
> +
> +	return 0;
> +}
> +
> +static int cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->comp_map;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(map->dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dport->dev, "Failed to map RAS capability.\n");
> +
> +	return cxl_dport_map_rch_aer(dport);
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1000,6 +1034,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc && rc != -ENODEV)
>  		return ERR_PTR(rc);
>  
> +	rc = cxl_dport_map_regs(dport);
> +	if (rc && rc != -ENODEV)
> +		return ERR_PTR(rc);

I'll repeat the previous comment about replacing:

	if (rc && rc != -ENODEV)

...with an optional initialization at alloc time.

> +
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index dd6c3c898cff..26fb4f395365 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  	return ret_val;
>  }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>  
>  int cxl_map_component_regs(struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6134644b51f8..0e0bcbefefaf 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -209,6 +209,13 @@ struct cxl_regs {
>  	struct_group_tagged(cxl_device_regs, device_regs,
>  		void __iomem *status, *mbox, *memdev;
>  	);
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
>  };
>  
>  struct cxl_reg_map {
> @@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>  int cxl_map_component_regs(struct cxl_register_map *map,
>  			   struct cxl_component_regs *regs,
>  			   unsigned long map_mask);
> @@ -603,6 +612,7 @@ struct cxl_rcrb_info {
>   * @port_id: unique hardware identifier for dport in decoder target list
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @rcrb: Data about the Root Complex Register Block layout
> + * @regs: Dport parsed register blocks
>   */
>  struct cxl_dport {
>  	struct device *dev;
> @@ -611,6 +621,7 @@ struct cxl_dport {
>  	int port_id;
>  	bool rch;
>  	struct cxl_rcrb_info rcrb;
> +	struct cxl_regs regs;
>  };
>  
>  /**
> -- 
> 2.34.1
> 


