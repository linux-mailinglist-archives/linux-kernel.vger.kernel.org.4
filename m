Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84F742F03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjF2Uw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjF2Uvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:51:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158C3C14;
        Thu, 29 Jun 2023 13:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688071873; x=1719607873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=govh/khzOu+Nd2SSZjGFMiai+2vdM6evYr1UvwRcvgE=;
  b=jPgpDpSA6/ORUgb2PjgJH6nqyisqiGDEfTT/OBES2Tsix7fOjsuQPsHd
   8O9JBOXCig4vYDpcxo+tGL2pd0k3Pq7X5bQEDaDt9S7dKlVl2ZjES1CGV
   wCGdDrNdYRsFTCOObXZTo4agOmIe9cIURijfcUUaY9KRcVhafX1peFICq
   xwHMcOhmGAfXrNRvsSf2iRav2RRwpUZqqC3qWXcbY4BWbgUpkaaOawiRu
   VERyB8kungi3dygpyNJkE2/beaBEL06ubRrS6aSwh7tvBx9KkgL4YmHb9
   vG54R5vmzsah3KUd5/05rSaipSc2ekcOxyZwhOrGn3BbFrjfEPK9Lj5cY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="392950801"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="392950801"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 13:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="717544770"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="717544770"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2023 13:51:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 13:51:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 13:51:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 13:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgitdruK94g/QBQ4gRNAaohwm/MM49rq3Ct1VIIta2wDGq/HWxiZTGbbLqPfKe1/4lM9j0ilBSo6h3uWa/P62RAhDgJuOY1+K0qlS1fJqrX5LXQwCL39ZtKL9eaQK11Cw6AoWapwuUu+VVb/tAO5KXnal0MnPI3VG6vB3ib1LtDgDaNh9/zMv0vfitGILgOxtYfwZ91iADNmAgf4IS2NluL4MfWXZQTTBZvO1bdXVaItKoyu1iUdRbhwJVgnSYr/JQUVRj777Fedhi/cwOehwmGsFOk3Ah5UsBGN+IhFw3qkhJdodS7r4iWrH85TXqAz5jZyvLwsdAUxMAOjudOMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhdXBEZSMgC82CqSbDrILzjMsYUwyBjFKY5bjNh09kg=;
 b=NPKVgyufAPFfUJMUMSXx/hEDEIw5HvvESIHZZhq9rxznCSvoFIZeoUc7cN+ua7jwdynC5bZdwB01GyfySHxmeUiD3Q+I7zjOI1xE2eGjior0FGEXKbaeBaTO9ly/TKIbE7LpFw/dsYWcn6LQYZxD3JhYb82cxqx7pGN0Dvr3SCelToNxSUdYub6j2/MqzwXubUBlwW+0V1QwBaJSjs+jIEHwgaXNwkG5y77isppYdp6gkUX/LPY5fuvzs4fzs2PopKZ61LL0LQnzxcUieZDMh1cjZPJIu/PSqy/atjlLab0XD1bUG3R2r5wVuwNiJTY7cYBSjvi+21y7YaqpbdPuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 20:51:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Thu, 29 Jun 2023
 20:51:07 +0000
Date:   Thu, 29 Jun 2023 13:51:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <lenb@kernel.org>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: RE: [PATCH v5 08/10] acpi/nfit: Improve terminator line in
 acpi_nfit_ids
Message-ID: <649deeb7c0e94_11e6852949@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230616165034.3630141-1-michal.wilczynski@intel.com>
 <20230616165034.3630141-9-michal.wilczynski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230616165034.3630141-9-michal.wilczynski@intel.com>
X-ClientProxiedBy: MW4PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:303:dc::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: f11b502e-d6ca-4727-930b-08db78e28fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKv+/zlCSIheNTbmE+IedtF0YpriwVdpjVTTby5+Qtxjs8ipHecJDATbjvIsWRVDNxBzeM++laLlVl8Au77eDq9E27Gm7gGzlgyghP1OrZatV///lzdAeBTKvA4I/BpIMKy/YDxXL6Ax0qGwOvBhweMkbJrdvaygeSOp2LWl4MNlH7bLCzkCJWe7Ht0rwwAeGNAwwKs2YGfxD+j7jtRUOmxi7FRxD5rtvk2loFJDrylbe3Z43to1bbLVeCAb263pqNTmFrEJQx7vdjv5G5ZD/156h32/INAl5TQslVuO9nCb58TQ6zQCfybU8qTIhmVGoeAF3FCPyxunnkWcholGsluEJSS6H1R0c1hF1PhZYI3uU5Qg7U4Y6MF9tIUPZLJSRpKpxJ4+YlHIuGCF55+o0xZJ36viDo1if1tcM5kMNvDLMEVDPvCOzz46P9f3anaQv7hyhbhCD3OlF1PVIa59kAEyNIQLVIPibuQ1jJEXR4SP97KzqUpz/1iL5BvITrDV1eonuta5bdaPD13eBSx9DdU0HOjSS9QnIpvBDkqnpLBMFXOzpwcgJbfageSufxeY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(66476007)(66946007)(4326008)(66556008)(41300700001)(8936002)(8676002)(478600001)(316002)(6666004)(83380400001)(6486002)(5660300002)(4744005)(2906002)(9686003)(6506007)(6512007)(26005)(186003)(107886003)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDzF2qkWT6fxLYMT6X9o3Q0XD7tSPopoj2CDYSzHTvDThCUzmzhB9cR+YibN?=
 =?us-ascii?Q?CaSoUelKl6irgET4YOgP9gX71fJxVTXUCzYaw52kLO6DHTV7JEgPl16Mwx+Q?=
 =?us-ascii?Q?V6W4FYbVkQm6/n0qgwb6kZpGvEHHInUE05QYn6hkxDwabAjE2F1k5D29Wyad?=
 =?us-ascii?Q?vQnnTDNOi7HaUHhH/mt45H1LG+KA/6wZyiX4wUBYOPmdwtswgPMmeu9dw5Ik?=
 =?us-ascii?Q?kbDH5XyeRS4lzCloZT9GpO1pSd9xxLe2Y1Bp2K53DmiHqA8Y3uiDMDkZEimv?=
 =?us-ascii?Q?H62mCkbv7/7pRwVc54Qo/MX2HR+SvQePNiwxAINps8bt/pjyYodA+fDijQEY?=
 =?us-ascii?Q?OSj4kJQ4j2bVIGs7dCY6FxbUNPC5AnafAaFDSmAuF5v+XspnlGclwm3RAoDU?=
 =?us-ascii?Q?GNurgIX9A89a9EmmA9Fpw3NfPzh9wrWC5JV+3ZHTM30WlTy1VQEk6nSBW1cu?=
 =?us-ascii?Q?Rmh4DwUgN1W5mX2HVp2EoPxmPT5D7+8klRD45rqK8aYBfYMyWlv69fwOxv7f?=
 =?us-ascii?Q?TDJtXtkCoBCvNj7S9ElNlz9U+HkvQ47OEWDEafRrMMsUEyml1MN/5CTfhsL/?=
 =?us-ascii?Q?QYwTkgi+ixv7WTfORL0YJ6RI5oiJsak9aygikjWjmuLImyDw0PuETuFpHoEa?=
 =?us-ascii?Q?nHq7s+zqS1ynJn22YAEkEAjLLeGxcdcF+K1Zs7HybKrw9rj29VVA5kCz2p+0?=
 =?us-ascii?Q?VmGwMBAHMnh+PeXtHInMqMKxzZ6QhofG3YcAl3VIcd1irnBKHojbZOBmNRqF?=
 =?us-ascii?Q?ytyjRtNPPpXBPrQN+c9o+gRHI6iQNye/XQ0YswrVyXvMHnVm4iVIBhPAnYSY?=
 =?us-ascii?Q?XtUwcYCHP5/qjKyM7NFizC9OHgmdR8WuqUDl6GckhukKRxaruIJpMWrkBnCU?=
 =?us-ascii?Q?gTy3RwMGBzlGf7+ceGQTZ+CriAMkRtjl1iA6i9yrl2WSSf2XNDTEma8CnK15?=
 =?us-ascii?Q?L0jNGnWOacQ/N90JI2MPmfLEOLMTzAHsHt3IlKrhYmt7p59rIWyzCcfQxqB8?=
 =?us-ascii?Q?hSJxdJvj+d8Rf0IsuIfAcKRRPMDV3I/hsDoaywqENrCEQHq624mEoE7S2UcU?=
 =?us-ascii?Q?NksS37W+V7/n/rwAo97iDuC2WfEYvKJKtKRQ3o4v7TLlc9aEGjqdc8xxJbfD?=
 =?us-ascii?Q?ayFO1kwihqrIUm1kP9rdDwSzsab9Io/Tw+2yERrzWyIU7Akk6s1AgccZG8fZ?=
 =?us-ascii?Q?LwyFj7FBqr3ERhOGZoOsNh8kmCXUmF0dQq3U494qxbbTqW9RDMiQGUAG6a3w?=
 =?us-ascii?Q?VKjdW4Dx0safHNgg/clM1i7+CEVayTyriCUhVgcGobnkYzOtgP/F10dv8Iog?=
 =?us-ascii?Q?lO9A3PchydSRka9lzkdjA3jt7VxhttrR4XtMTIsSvpzbxhDjkGuk0NM9MSFt?=
 =?us-ascii?Q?p0Q77nCGSExyzoulk9mvxb5fkXWuQLoX8T+GzHTvy/woJHccIXbjXXdYlTP8?=
 =?us-ascii?Q?LMOdWvRTDOkHFsTe+BzD44o6LxmMNUgT+F/bF1VPJGKTmFK7EHrKxQsq+/Lj?=
 =?us-ascii?Q?WBtimYsM2De9CeaRr4sDY/34WtFtk4f1GllZSizF5uoGE0CUhzaejsnAeowq?=
 =?us-ascii?Q?wmzQumXzRt1wGmiw1+5UglrZUr1jI+SKGlj4kXW0OnJqA+A67u+tZN4KM9Ea?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f11b502e-d6ca-4727-930b-08db78e28fca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 20:51:07.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKYzH3+ncLr9omykvGZ/OnMUDISEtxrLSv/w8YBCJs0F0337Bhu62gaHm4kuZ1GXJpq7YQ2vX7gftJj1sj+YCKLD/rsgpHP0q/7toImXT1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Wilczynski wrote:
> Currently terminator line contains redunant characters. Remove them and
> also remove a comma at the end.
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index aff79cbc2190..95930e9d776c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3455,7 +3455,7 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>  
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>  	{ "ACPI0012", 0 },
> -	{ "", 0 },
> +	{}

Looks like a pointless change to me.
