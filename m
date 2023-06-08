Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F362727798
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjFHGro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 02:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjFHGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 02:47:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042EA173B;
        Wed,  7 Jun 2023 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686206861; x=1717742861;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bXwiDvlKv6Yg0JMkD0duRglRjH71oYlfpcLGEqLFrqw=;
  b=gUKedovpAevChSpugY/tTkEYGkZr99lBPPtvR47Z9S6p1Eu49+gZcK3h
   u1mP4N56bgiNreURZ/W/LhFGEig2JJrD2Nn62qiF5csy0K/t+Dd51bP8i
   yYhfiQ4HOTCzmMFPWMhOUJSqJGDsWfw14guhA4YUI1N4sKZRqCF53qYem
   eLCqvHDMKinsoIQ3oqlsjaGUuVn0D6vHS49ok/czNljAWrvNzgKZRn8gE
   AO6BWDkjyM4YaosyNRgznQDbg9JO34Dbd4vR/tnhjHERWIHXl3divJOlX
   IwwdtCacnMpLL6kI6LJpuMS8rhNcnksv1K9lHeHWbFbnTqUcT7VPmk2x9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="357233434"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="357233434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 23:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="822480037"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="822480037"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2023 23:47:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 23:47:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 23:47:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 23:47:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDGddNVLaXPiCDtWapEVLkOiSNEoGRn8Y/X2K69opaNYClEwoAGlmuwFSjBHM0vPcoNUL7chiSWhKcQyv1nKm1kIrWRQBbqjipns3DaOF5oDYgXBz5l5QCoMAYZIbhmB86ozlk2Q9dHpHvclsaSNtA7FWDX+Ho3I/7Bubri0GjiLQOSdblIr+QsjxhrPeIPNdKMB/rn4F3vi+YjVXT7c9aiWZeGTinnIQ7Gu908eac12kD6d0iithQ8LhcmABNChb1k5fjnj7KE4j1XSnCQ04R0j5hreGtf7NOydaLZcJBomw7Zco96ZLEF69zgJHQEtHHVUB8gRzPerGTEF6o/9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd1DO1efXi7l74VZeHcsAQbcfqv9+rRmAknj2SXhJjg=;
 b=PBa8PJaQborq1BaKh3BUz/+bcod2sEkq9deLAL7hs22iqYZLwNyoe/1gPL51tHvwDXr2n9utqtspeCnWlc7gV0vX7V43nn+RUwG5wSGJujTnu78QKOn7f5enTbI2iO4cFQRRzVIlR3ZebxarEQ16yZJefZ3ji8k00LatenFA/kPkCb+IqZdaLKPwjbhvK37yrKzpMC920E0opUokC7J3NrNfzULfK2sPI7kFBjhB5MjxinMGytUgDvSEc31OoTou1qrYaKXDedIBs4KSmvyj5hJEpIN/OGZIlL1g6Fi8L9hU2SFxy/wV+T8Aq8PKACH7vjPloI6vF/eBXY+lPto2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 8 Jun
 2023 06:47:37 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:47:37 +0000
Date:   Wed, 7 Jun 2023 23:47:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 04/26] cxl/core/regs: Rename phys_addr in
 cxl_map_component_regs()
Message-ID: <64817986978c2_e067a2947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-5-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-5-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: c791bfa3-01b2-48d8-da2c-08db67ec3f09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtSuvimUzgGhj2c6bwFIU0kEo6hywoke933P1eekv9OXFv7akgfOfh+JKQcJRy0wVUa9zV3+JIigjsJSiuzAPIjMhid+jfXUg6c7wnEtRVs+lHUyrSUbubooIpR1b/20X2DNRXzP6lO25/drFe8qL9xg2rFY4or/XrWVXDYCUQOq0aKAQ+NniIhll+gB9xJE/A/MiFveTlRsgPJBb26TkEPf9I11LJ0z3lsjPOU/O4L5k8Kx58osEJrYZ3tVJ1D136iBWNLxgzHfB4wiZUz1x4VbgnKPlX5amS9JMqvEk6hXcfYIT4I8DGCvghcfiKT+zb4bm69Z+po6PduHU16xLyZ7EHDjJj6ZhkRhnomzMCd4mWs1TKj6TacRwQvxMfN8MfLltlSjo2PSUo1wnKOd4vLrzSSYB0LllA1RReZYElu4fouB/0QYs04M+rdjh5uRPcMVM3lgm+R1fGRzP7EALM0G5vTM0ng5Lz4GIKj4DL/zsJPca7267Ro89ku0BMZcA61ceBZM+gR2CaFoWiwsD9yJbPYVjLMgS5CQsir91B1F7l0737Q4GpYz/sqrPxkJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(26005)(186003)(6506007)(6512007)(9686003)(83380400001)(38100700002)(86362001)(82960400001)(316002)(2906002)(478600001)(4326008)(66556008)(66476007)(8936002)(8676002)(66946007)(5660300002)(41300700001)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5KvXqZacgQTGNzvHqarmNHUidLwjOnrhS2OXVVt7Rgi+WF0PcuEYF+TSbMt?=
 =?us-ascii?Q?jJjmLGXIPtEmw2CJ152EV0wiA8+bLRDmXO41K0yLUuUBIGrpKqNXTepWgXB1?=
 =?us-ascii?Q?Xphrur/jpK8u1jxBs6/NlVWp5PYI8hnuS7mtWODp9OqyUJn1JyjcOhT3JK05?=
 =?us-ascii?Q?WxzKqT1p8iPeAsRepvcoDQ3pyD4PJRuqcbJUTR7OZysCy+Lxk8DWfSpia0Xg?=
 =?us-ascii?Q?5NC2LvHnIpP1pHqKAtge3pkHJs3c1hV3ZEkDoyizQn4gREyEBPi2O6WwD5o3?=
 =?us-ascii?Q?uWNIPt4wWxyvmdXQuGvHEYmEcM5e/YLMRx6Tx2OS6I59sugLF79UqJI0LFgp?=
 =?us-ascii?Q?AyEmAGgOOSnQpRDIFs5T4if1ToxX35vjBVt/m0SzJXZE8OFHI/uE/AvoJwDq?=
 =?us-ascii?Q?IVVfWbYcJ0Pknscjdz+Eq23ngw2N60pDDiD8gftNmXQNOcYyswDYOg32cctX?=
 =?us-ascii?Q?ueie7WnUQ9M+5PfGzMzFZqSxPjOXu30KO2fcTpdJ61A/huI7tEJNpNpgvUo2?=
 =?us-ascii?Q?F8aZTK8a31srBcGOEaZ+nQ6hAAIzf/MQSFO8M0go7EEbtJmO1DOYlkxrf53j?=
 =?us-ascii?Q?7otSKwTnMZxEKcpyOyDxB+Ji3ZUvKkupuNcDv2YvCDe7X9wzSirjo06xAS8X?=
 =?us-ascii?Q?vEj/jG2qsm6bvveDGg0Owd4HJmlyXJz7TQHH3ulhiT3RE+F3OMZi7k1u+8qy?=
 =?us-ascii?Q?L+yAOfWu6/bye+34q86l0X9Wm/r8XnX3T3eP6AXoQxnDG9LuaPu2OyTyjkDP?=
 =?us-ascii?Q?yTsCIjmC0tAs00kbC67TOKVitsORL/JlcX12Br85trC3IpV2qG9JNdS33YF+?=
 =?us-ascii?Q?jc1zfVmC+EavMnVyvuagPtb+WTKRbuGe/l5GBwLXfbGnlXn+bXi7GAOpmJ8W?=
 =?us-ascii?Q?chPHxqxQR+CfXIq2XjBowj1+veoN0i45RhDx9keJFciC9P2dWFLNoSY6TvXD?=
 =?us-ascii?Q?FNvLIQ4i9YmDeqYu/m55YjyK1vLpNf65AadMLk2+DDjR7yagoTSLlwHqD15O?=
 =?us-ascii?Q?YBK2sYrC2kV72O+c/676aZe68bi4Q1AIkyBENaJ5ossJH0BK3UIGNinVHKYA?=
 =?us-ascii?Q?5Pw3ZnrLi0qvwPGFXjjub9I5EsJB1RtlvPiNDEOjS+jhUb/2062CDvwQXc2U?=
 =?us-ascii?Q?Hp2+AQzwhPJca1RsZ7E0BTZSmdUZnbfvspqFp1dbc17mXNHocn8uYc3sWbw9?=
 =?us-ascii?Q?TiyiNNXO5A2L9FMnt9PROQrJh2gQDSdpBU+lFM6uKeRYFDyhPsLAlWr6luc4?=
 =?us-ascii?Q?0mVxTU3x1xPVlUYOpv50TnDO3xgGhTA2h60BT05fDItY0+beHbRbxFkPv769?=
 =?us-ascii?Q?zt/LwdA2iMlITiicEdvAHw/kErElikDsxyf3/kaYSh2c4ZKoFBt7oq6qOJOq?=
 =?us-ascii?Q?U9alSiann3Bz5rY8o6q06dZqq0RGsZC2bwj6C46L8bNh/gJsYk/52Q9Ow77T?=
 =?us-ascii?Q?R6+0FKR/piBqgvG1CwngV/LoUFl6NbxM7pRlaZ2yYRFQ/O/wbPdW+Uju4CwD?=
 =?us-ascii?Q?FOXZAVxtSblAh0oAZvvs9Iv9dVi8AOVXegH5KG+S5SIY/bDCigTZuuNXFd5H?=
 =?us-ascii?Q?Gb6IOL16LXj8XIxmveH7j/i7cCzLYrlwZgWvJNQUlWbODky9sSeF52DCEQlS?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c791bfa3-01b2-48d8-da2c-08db67ec3f09
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:47:37.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJVPc9vCkqXETTPrYEcUvhZ8aTj/XqiGcfnuKzBliRJSoHMFY1H9BvB4gysfCTrrNMZcOSQNUv958nB8Z2Kmx7KjdFVT5p5h95MCZ04SlhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
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

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> Trivial change that renames variable phys_addr in
> cxl_map_component_regs() to shorten its length to keep the 80 char
> size limit for the line and also for consistency between the different
> paths.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/regs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 08da4c917f99..c2e6ec6e716d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -213,16 +213,16 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  
>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>  		struct mapinfo *mi = &mapinfo[i];
> -		resource_size_t phys_addr;
> +		resource_size_t addr;
>  		resource_size_t length;
>  
>  		if (!mi->rmap->valid)
>  			continue;
>  		if (!test_bit(mi->rmap->id, &map_mask))
>  			continue;
> -		phys_addr = map->resource + mi->rmap->offset;
> +		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);

...but this line is only 75 chars, so not sure why you bothered, I
don't understand the consistency comment either.
