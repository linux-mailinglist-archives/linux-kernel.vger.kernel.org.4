Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7813628DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiKOAIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKOAIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:08:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E25F68;
        Mon, 14 Nov 2022 16:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668470885; x=1700006885;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JJ4oTVvqL0LkPYYOZfVnmlpNjuH/rXAkxvix1m6pS4I=;
  b=oFtHSd0fYQTV8TMMOIrUVSk0mpB7GMrxJlidzWtmMQrqjeLCg04MuEn0
   en9WixgFxeBVvXUDIrWO/RPDHBxVSRfpy7FfsMfFOl5pmtbbWmwdP3LnN
   y0t+2a3oEQtILserb0wEvauaGf62HzH4BhVc6XraOcmQn7d/MzT51zQvg
   sxGOodQTSo9f+3PDa8piKPdDxN2Gpdn7/JTMt9zYrwkzLsrFoxE8DGx+O
   WgVlUjSyoajrF62rcR6zVn/P0/+4DpZ0wK6Yam+MormzJiwtBNVX1hGnp
   53eNoSf3tTuWqGeSzbeujCjW1iOx2WeRkaK/JQopVgUj3CrzyshCHVy6T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374246232"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374246232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="633014965"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="633014965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2022 16:08:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:08:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 16:08:04 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 16:08:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvnH4nkk+7sQmUW2JDvhN4V8rJmc+INTVJPu+tHIHygwcOy+p5ETLR+B01tKYRGPUamRuZbufBekWK21h0CD4z9IDvTWOgVuTntofIocIMuj4e9HiWP0cw5G09SKrnAJJSl27ophmHT92sowVBNikpLmh8e5/IMhRxHaIyTRheavurKMvwUflzexmM32EYBfikQketkyhTqEZyMQM0MgITncPV2NUn4oyUGQ1cejNiA80Mt3P998l2rw2h/osNI9An387mwLwYzXbz45VUSKlTYSo8JSrjp2UJlwsvSg67a1RyJ1aJLbR6a0nzBTzznCCXb8BxbiQInXtQze9yALtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdbNfvqRqk1ZTZncgso+K8Camzk9R2nkRRlD5a8VaOc=;
 b=N8qUqUFDcV1S07D2fe/IdS7RlVxhMJ6bNCR/GZeLzotlpdm6i/3KFq7KmXZgVjVornGpk4pAWIw0XaRW3n/sCnEEotV0J1VjNMPO45ruvBtte4pYTo8JEKE8FwgkUivEMcq+uzo479yjqVJdFUzOopLnm4SxNA6ijK8xcW1p1v2oDWHsmnh0bc/hL3gf2EkPerpqNxhaEnUqlRJyemVPX16hFDRpMpQqjB75hZ0ukJemJUGLpR2yx7owmhpHFcYthVHpxLu4N8nccXwI6LTpJDfEamNZiRpV8oYtbeDs4cGIjdmMd/4kLaQGpIdg5AO+ZAovrPSdsBkh5F95/HBUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4687.namprd11.prod.outlook.com
 (2603:10b6:806:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:08:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%8]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 00:08:02 +0000
Date:   Mon, 14 Nov 2022 16:07:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH v3 4/9] cxl/mem: Skip intermediate port enumeration of
 restricted endpoints (RCDs)
Message-ID: <6372d85ed793f_12cdff294f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-5-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA0PR11MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c100c57-43c0-4895-06c4-08dac69d760e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P18Kp3nERjVRdTuMSnKEfIQIzpf2L1JCeNwRfcedDx5GE5yQBJX3iBzAYa4mNuhjaZrgKUc3p3RPkeU7qfG3lEqe9QvL00LQGfV9n54KjxXaainZKmrf2bbMqpklZW418uWRJmq1BDNAI+mYMkkalLQ0+TkgjxpcEWpFf75tqAEKNROgWEUaFT3w09PQWbQMAFeiNOFsaNneR14GcKrObrF31wDPAXWQanZOXx0FFKPusihLXNg5UNjTGY2jKgLVFE8wanV6PxljQeb3pyLbmUfuHsaGprPHSgF+EwsEcEfU56subNoi2uaqUH97umObTGNXwoW18kr3UWhJiqQk3i2PuAchU0Q4cqJC9DXHy16A6g2NDcNxu1e+nTxsUVJJ5bezR4IpbvPF0LWNA2p+XAoYAez9cBrYpb7MusByUFmZhiZ6MYTRf8v+VkWatWD1FuTDyb1uDpNQYx+D2hcn/ADlSYqwlrDimMViK3bMZpr0b6cxYhHzyELSuvtns//1lgKPdg+xGZka3XdQb3OLeDzia79PFgfq8/niNPl3dcRqQzr+7nyc/wN9YnwpZwK37Y2cWJKdC9BnZHGZVAd6zZR+vumOmih7zLRSaE6WCOYrIDHZ9ebpYwF7lV3jNS4a3aOJmm69unuAhbeqbpJpsZrVjDE9OK7xb0WoQcumAfj2rSAROcgUPdx++1PgmzbsrGfYEF7U1EloiJmfV8e+Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(6486002)(6666004)(478600001)(54906003)(110136005)(6506007)(186003)(9686003)(8676002)(5660300002)(6512007)(66946007)(26005)(66476007)(4326008)(66556008)(316002)(8936002)(41300700001)(83380400001)(2906002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRd5Cv0SBhxg1IeHx2NIo7fKfLfQXv5ZjRzxRZvL9ayr7zxY3lMWXR+vLlBI?=
 =?us-ascii?Q?9bu41VcRuP9TFHi12ZXrFFnYvBaJ0HRZMACXOs7B4WYJrxFuJMVnSRRvXhXj?=
 =?us-ascii?Q?BDeEWrOleqRx6mXwqNXL+jPRhFO9y6b5RdIp70hOwf7wje3V2PpYQ7pWkBnQ?=
 =?us-ascii?Q?NAofe9MPoOPxYAPjG3MurHO38ek1Tw/v4fwuNdu6a4PaBiDlBo2nYywd+n9B?=
 =?us-ascii?Q?WMmYWercD25udpeAQrC58UcnWUIOAAUAbfW40o0GwKq42KqcFxn7kkN3DBWY?=
 =?us-ascii?Q?0lbVTotPllF4cS6XGzqmMncJN0qN3hZvYW9gRra/k5EhoZ4caAABN+JQ9tFE?=
 =?us-ascii?Q?wue1JBivoCM3Z/4E6KW4eBKGWJBYruQmOXIEIQrADfWcobmNPOye6mBoO3vw?=
 =?us-ascii?Q?CstE0z+sNWuodYJaX0a6ILdEqwB5OaNi34RoJO6CiGIAwZ/lkHQJ/O8r6s37?=
 =?us-ascii?Q?UNH9+t3tg4tqz2eSN+dd8z/3+ZG7U0Nhjq+pave+fP9anWzYOLrpqOsYzWYA?=
 =?us-ascii?Q?CRleRUpIDd83C24cpmHJNweqny8TZCsdX2/0diwe3drSjdNp7oYA5Hhsmw1q?=
 =?us-ascii?Q?kyTbVQ+T5UEmM5CkL9dP6qkR7zFWJDOorNMi3Je0a4YhDs6zzFMd3i0w7Y6p?=
 =?us-ascii?Q?aX8wbJW6+6/6LZ9ss6vi2Bcj6OVyfV+5HUZfje53yAMfd8zvdsytmCBEHncq?=
 =?us-ascii?Q?yu/wIpSHJkGkgb58QM4al1JdtPeBOJBGkGolIeVingrjNnvUNSA705zGOwM+?=
 =?us-ascii?Q?XxuDpuh40eUt0+EcKt8f86hAArhwcIoS37tsjKHrlCs2HR9hhbiQbWRHU7OF?=
 =?us-ascii?Q?DscLxmO8TCZHw/bRjC8PAJKqU0kqFGodaliismQfZdju/8PN0Kd7XVWbXagg?=
 =?us-ascii?Q?QzWSfo1rz2zBHexCsN5+Z9uTxpL7fMFR3XXfeQqdM7dCecJJVWrbHhB95n2U?=
 =?us-ascii?Q?E0AqBUpUEfdPjQJA2N1y7EmFv2I/+QXU//Vzxun0AryERVMufoGXIEmefHwJ?=
 =?us-ascii?Q?15qS2sX/JH3KkvTVzOL7nEnKZVUFLrG7h001wj94bpGJd4FW6wx9sUFy+F42?=
 =?us-ascii?Q?6Qa+IZXr9wCS6QRY64VcMJt//F0zojdpFwiotx6sUCFb5hP1PamuoXOb74Iz?=
 =?us-ascii?Q?M8ek7yutlDPJXyxiPJAtfytB+bAhMo2/FMARvhd3MQX+ssNsU6ObIab5fYJ7?=
 =?us-ascii?Q?Nt9fhsk7CY90fcdgv5CKJQVIfZo4kvhGazjPLNtijkkRRkXKnTchr7HjIVTG?=
 =?us-ascii?Q?fYdSdw8cP2xM0ia9IHnNRdo8g/C5684R/tCGH34KjulWT5GkgsWECaxxITl8?=
 =?us-ascii?Q?GPUdrPuzCz4nExzotOv20sO86yMoToLYTVZ/zk5S/aWe1tVygu0x4VcTcJHr?=
 =?us-ascii?Q?oMbCsZ2KwfAPwv4B0BZtG2vQ9YEBRALfwZ3jIoFgfJGILkJpCcs4724/mH/c?=
 =?us-ascii?Q?skuTI84PUzGscA8TZeIMG3eLX56bir6nzEyKEBdANchkZ2Iyvhhb2DwkyNPG?=
 =?us-ascii?Q?ynU+OzIoeYW5JFu89lmAvtvO6yGRhtcBq7UiiFvKjW9qVtJw006E+Eib1vok?=
 =?us-ascii?Q?wGJwaXOXgOqnaOM8ZUqUKMXmtY7Xg75qma0/0eW96dabSrAprar4WHHd8cNI?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c100c57-43c0-4895-06c4-08dac69d760e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 00:08:02.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMnFLjsFpGzbx23kPaTkHdzgidtXIC0LZxeFI8Ryv1O/f3Ey2fUXx9MJCpfHA7qaEF0KugSVgzV0KG3rawRdsb1Ufa0FqmPkBfXFiUp7BYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> When an endpoint is found, all ports in beetween the endpoint and the
> CXL host bridge need to be created. In the RCH case there are no ports
> in between a host bridge and the endpoint. Skip the enumeration of
> intermediate ports.
> 
> The port enumeration does not only create all ports, it also
> initializes the endpoint chain by adding the endpoint to every
> downstream port up to the root bridge. This must be done also in RCD
> mode, but is much more simple as the endpoint only needs to be added
> to the host bridge's dport.
> 
> Note: For endpoint removal the cxl_detach_ep() is not needed as it is
> released in cxl_port_release().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/port.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d10c3580719b..e21a9c3fe4da 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1366,8 +1366,24 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
>  	struct device *iter;
> +	struct cxl_dport *dport;
> +	struct cxl_port *port;
>  	int rc;
>  
> +	/*
> +	 * Skip intermediate port enumeration in the RCH case, there
> +	 * are no ports in between a host bridge and an endpoint. Only
> +	 * initialize the EP chain.
> +	 */
> +	if (is_cxl_restricted(cxlmd)) {

I changed this to:

	if (cxlmd->cxlds->rcd) {

...where the cxl_pci driver sets that rcd flag. Aside from keeping some
PCI specifics out of this helper it also allows RCH/RCD configurations
to be mocked with cxl_test.

> +		port = cxl_mem_find_port(cxlmd, &dport);
> +		if (!port)
> +			return -ENXIO;
> +		rc = cxl_add_ep(dport, &cxlmd->dev);

Ah, good catch, I had missed this detail previously.

> +		put_device(&port->dev);
> +		return rc;
> +	}
> +
>  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
>  	if (rc)
>  		return rc;
> @@ -1381,8 +1397,6 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	for (iter = dev; iter; iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
> -		struct cxl_dport *dport;
> -		struct cxl_port *port;
>  
>  		if (!dport_dev)
>  			return 0;
> -- 
> 2.30.2
> 


