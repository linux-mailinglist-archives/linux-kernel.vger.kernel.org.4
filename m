Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B96B9D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCNRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCNRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:43:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4B935A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678815827; x=1710351827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pcK/vq9YiU/eJak+aXo0sEs6415gl6d6POpGjw3W/S4=;
  b=Ts0QS1APgPO95k4XX0/CrfcIbNeDtTzn72PWYR90IRWr0FcEsXP0MEKy
   KlP28GkCVBspsELyL34CclJAR6en116jEjj5kdx2ZIj1Ya6j5AIbBfLzU
   nnyIp+aizI49Foc4b1iVTsuCkUM1D6wB5NI59nQ/9jS80PyQvtXU5KVJp
   XC8gQlMllXjtWdXfGvYwr28BWSQ3Is2XtvM4YAiZgW+wIB7XMBR/KC89Q
   S8N1biOK2HUc3++2sYs4t0RtB2wyOrjFNzNaX0ozd6925eVJvWQVZ8jZi
   4iKa2Y407gmL3ErDLt/v76f0clp4jeezgXHFoH14SCAUn4YsLukwj3aw2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="339041945"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="339041945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822459874"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="822459874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2023 10:43:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 10:43:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 14 Mar 2023 10:43:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 14 Mar 2023 10:43:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrvQNMGihBGyI1oEhlzwK621w9jPvl242+wDZlFwq4GkJA3NYa2o7Env7l5Zq/2Q7QUxfKDDoBlDq+AXrMg4ezq4WT2oQiTkRDaMyzo0bktpq325v5TAhwnY+2TQW/rZ7BkAhl5ckEfOmSBd6os4Fj6gLi5F6kqgfEiaYm+ck3CdpFs1H9CCtAVCTqHfYp+HG6r05urYvgJcC3Ubs+4eDU4kU5qv+QIyfDeWrk7sbKfZgv4r33i/edPVtYfb22OWz4OgIT8ntNIlI2NPRIt2dvmQxlOAUARU/4WQ+fJDm1AmPQylGbkbBJ+EY6G5oTX3WLVrft7JZhIQ8yMlt2ptuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F79mZwtWi1jBkJ21i/i6DGpPci/oPGU8k3nh322ovr4=;
 b=cHyFJBxBn7+3kzNhgIKrRvKcGOLnEfakluOyLcRtgjQxB46z6HRtQagBY3DZy5w4lmAsq2jlJGftogWW6xj1ww3V740huT58eiFanNk2leskeCOUb/Er1lgFgvVPtiVfzq7vNmXUIiOUduPLll7Lm0vc0IchuQydAlLJahePH/sXjNIhRHBmq8Ii/mMPpv+sYBS5WocrurkaN/Psp5ukM7JQuGM8S6rufHeqvrf2ixa+lZIM+Qg0uz8pRSaRPmHNiaeJio+RTrWZ+eXFp9MnKUEx/IhGjqG1duMKlGBAFJW+lT9M6l5iUGRfLa+lNdp9LWT2DtE2LIGZmB0r+DAdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 17:43:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 17:43:40 +0000
Date:   Tue, 14 Mar 2023 10:43:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alex Shi <alexs@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Eric Dumazet" <edumazet@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Hannes Reinecke" <hare@suse.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>, Hu Haowen <src.res@email.cn>,
        Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Subject: RE: [PATCH 23/36] driver core: bus: mark the struct bus_type for
 sysfs callbacks as constant
Message-ID: <6410b248e47ca_58a429425@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-23-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-23-gregkh@linuxfoundation.org>
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c7df28-988a-4f8c-b588-08db24b3a5d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2Qh1urWv5/kUwQuWAH94WlbOGDuBT97j2DInQ/uK1XL4m/ZZ7JWOwctAZB9gd6mBnoFAR8JYqeCwoOysXjka55D+MkqhFbColXUVFLtGMDsG49k3FbuqL9MPXxt0sz7RbpvkYG69DrySxgkdu9SVcFVSgxAdk1PwxDrKpIHAuTvZ7vdUCSy0bLPx4iYO6EGD0oaZyC0ALX+ZDq+0x4sce8ZGnXHOXfu6hTvtoo9lyCF8Q1jZb4UXoMlbed2S/C12EE08fWjbb8Iy69cW03TYHqcSLoRS+Qebg63HOxjV5kbVLNCSbbC1XS1iDIz9SuZ8zcWJ5fCNndQo0m4tzfHGxI51vrFBpqn7e8a2DG5Z5nMUseVxKdJO6T8NCulMj8EvmwF0HqudHrHT0j85GhukCHj3wsQaKJo3DGk6G5R8xlHcasW/uQ58hzB+oUBEZoJ+J6H3EqjbjYRwcqPxpswCNrTzTJY6HmjwS1dd9QDlWxR2wVuYm4MrJneW9MP+n41li3l4qwjzUIIEWpGd66W6fHu5Nwq3ZkoV3USyc8ir1nGMVV3CBrb4LppcCZCPPUsUAI3VoKj0ufX3Vzi9wHttt7HB48FQTnfISVFRrxKVR0e3Uo7DNzRFxGkh6ZLg+m5DxK736Lr9/lS+dfJH1Cn+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199018)(5660300002)(7416002)(7406005)(8676002)(9686003)(26005)(478600001)(6506007)(6512007)(6486002)(66556008)(6666004)(38100700002)(4326008)(66946007)(66476007)(86362001)(41300700001)(8936002)(186003)(54906003)(316002)(2906002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PAy2RRQG1E/Abwr4YuuSQPAvOJbR+8GenTH+pm8ueAJZcFf3TBUpT0ZcQH6e?=
 =?us-ascii?Q?jsC17D1iy7wScnvxN222KbIdkhPZ1gvdf131CjV5hYBPmcq9om4MeOviIvjR?=
 =?us-ascii?Q?ikuqr5zEUfKXYD9fSZjUXwm/I15VPIoA1exdTnD+9/pWQPqRcXw58ub6FrbM?=
 =?us-ascii?Q?rE0MFMo7ta5vQjK6ZWeu3DzSdXZMVpmUtCpjL8zj0amUn8Fyvyk1BecHtqMJ?=
 =?us-ascii?Q?mtvEV82LdocOhKdZSTyv43FLFSdu1ksUFW/9V1w4dDHr4HiO9lMfYNor8Oyr?=
 =?us-ascii?Q?YXR4Vx0uVPWyJ14RehFN+FRuURSnv5hmHjzJ7H7LwTL4fkTMwrXD4zw/Y8v5?=
 =?us-ascii?Q?7dtZrNI2w+/ihKbHMXbTS2GfRb7YRh3wMj1gZXM7ULHVZtGGwcTRJrKzvJdS?=
 =?us-ascii?Q?Y+6twgLb9MizIWfuGjCGGEYjH5O47g54VWIAwyvsWI+mTcEFzy7uQy1KphNW?=
 =?us-ascii?Q?EX1xrytLx5szAJZAE2LjW1PfplqcQf3NnqVEHQYsVEEsm9btOC7f0uH/wT0d?=
 =?us-ascii?Q?F4f1P3hy2aUQ7kZlGwqINLPUnE9oaXYM1M0yL78r0aF3MFxfWanpElzqeHYs?=
 =?us-ascii?Q?Ob8QgO0QiXL3RlV79shM93qFVRsytoLX3AJff5zJWIU3CPpUqFVZX5myeTLK?=
 =?us-ascii?Q?XDABukD1FmrlIuGPC8RQ65KSKgkrjfqVNaDvh7vqzxOTpTdg9WfFm83Z7vKM?=
 =?us-ascii?Q?WymIWN+FKPu25BerZEBslYylYBksoc2cuNDzC0lRs1/ocWL3bT+FO2Kkz0nM?=
 =?us-ascii?Q?K+C2cBWtSVI5ZlXhL9YGdIItG4oK7bu9dSE41VtpBBL5Z68sn5F9P8FIHIo2?=
 =?us-ascii?Q?1gUhh1ZpeqROSqiS4yU2H+ZZC9Pe2efiB9fP7HV0kXHk2+PaADfp30IzhzGy?=
 =?us-ascii?Q?jloVROWQKK05608vwgInaQEvvUNqg3IEpzphwth10gZwyEy14ihi6ugWDDFZ?=
 =?us-ascii?Q?4AXu+vf7RD7NcIfEHDOP8dkpiioa9krOnIcJsLK7WXut61UKP+lOk04Ofl9V?=
 =?us-ascii?Q?FAWZOmd+gNsrCuMPYbIdXwEdhG7vffyqO818ao39fRbBucqAQ8z7sL7s7vEK?=
 =?us-ascii?Q?wsm2SQamjuZ0zEe0oDFLyPDzfObJxYx83ZQpAClDfOffnFkYNkYrVmS4a7H8?=
 =?us-ascii?Q?QRq+Mlscod85iptJo/FcuGivvMQtNrWPRQYwWa0bipO05+CzVc04oozJe/dc?=
 =?us-ascii?Q?zBEIhEeyCDth5mIlsvAf10yKu4wD8WaeA+uJW8SGQkoud+2lew5xeJOZsghP?=
 =?us-ascii?Q?W2xISpurWvDIaiSdeOXiSRDVP9W/XJwz2nECsev/wTZg6dDIuMhzFYPDSfsi?=
 =?us-ascii?Q?Z7h6v62jtOI8tt/bIFoFKzhlkXgF2IhtaBEqBsqHQ1HbLe+F3u6UZd4W6xjf?=
 =?us-ascii?Q?ZN044V0ewI8zhIaWYLwul31HC+jngxIIw7Cl2hy8ZWkdqXAqNn0Cjzduk6yZ?=
 =?us-ascii?Q?8j7k2j5P+UxIKjqu6bTdG51zJt6TM/OfhNMZVCycX5FewX8aJChhMRkxm7cX?=
 =?us-ascii?Q?fvEZfuyNsjULcxyrwKCqKDjGMCRyqF/rz+ntfzT6govmJ2KihkNuxyaVLSTR?=
 =?us-ascii?Q?17bb1+NSGaN+ErDuHiB6KXhYq+IJw3SGMD680T7ZHsP8Tx4Fgghi5yB+jUTU?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c7df28-988a-4f8c-b588-08db24b3a5d6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 17:43:40.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEBenhIwdma4jDeVblGQsBD3ORS7RrXB+Aj7N7jlT5eSw+L57i6wRXo6afIAcM4mBDPDNAKcrVRjdrDg6oWdtWBuuTcKi3EGbp9vGXaAy8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> struct bus_type should never be modified in a sysfs callback as there is
> nothing in the structure to modify, and frankly, the structure is almost
> never used in a sysfs callback, so mark it as constant to allow struct
> bus_type to be moved to read-only memory.
> 
[..]
> Cc: Dan Williams <dan.j.williams@intel.com>
[..]
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8ee6b6e2e2a4..66333cd6248e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1927,7 +1927,7 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
>  /* for user tooling to ensure port disable work has completed */
> -static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
> +static ssize_t flush_store(const struct bus_type *bus, const char *buf, size_t count)
>  {
>  	if (sysfs_streq(buf, "1")) {
>  		flush_workqueue(cxl_bus_wq);

For CXL:

Acked-by: Dan Williams <dan.j.williams@intel.com>
