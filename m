Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6571628E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKOAYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKOAY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:24:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFB0F5B6;
        Mon, 14 Nov 2022 16:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668471866; x=1700007866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/1QBq8lAkkG7xL90FTcmeDRyCDQEuDk6egNEqztzlE0=;
  b=TjMY0GLYQQJOR2VD/RX+2Xa/Yrpza9ZIsZUobuD03aNKwAWFCtA4jgk8
   U+tht0Cjc8B+SFUqQTnl0MkW+bvEvvbW4codpBchftXgHbGXap7zGJT9Q
   qFnqc05s2XSE3E824o9AcAY49jbV6LvX6l6V7gS5S77q7sxheCeO50wP6
   a51IKhf7IRkB9/KHwTDbjHGGnYjaPqzPkdcKkjq95iq2s0N+CjX5TUxb+
   B5u9LiTBltqDHh6PJIY1q/reTWzRRvIXxJ9wBroqLMPyd76Pel0latrgT
   NrHS7o9p8jpLWtOyozZFsfOr373hLNwkdluZTexidfYgjoqktK5yB1Y03
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="312123868"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="312123868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638717196"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638717196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2022 16:24:19 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:24:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 14 Nov 2022 16:24:18 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 14 Nov 2022 16:24:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd4Z+PHB7vaFan2oXSHpAqOsnrxi3EeFfjHtFhOKLVjfDdEQzMKe8FvgGovH5fNhF3LY6foo0b3Bb6ujW3g+rF/htCxS+O8R0CqhTaa3njK/oezEffV05Mn13ilJc4XXXvmdPWS4G7r86FKOLsn2mLia+ok1m0mFGbgXF5jyGS9cus4uQhjD4Izx/kJWK+oF5Zg9w2gAr6PHywCjvFLerBbta/5hMf+3eJzBlk1fub2w42H/ZOofhHBi5YykNy4M9QNSQAXagSK9sl7nmi/tBW4RlgI9+18Fnqpk0Qs5fnH+uZBUKUcufkzjkj8vxp4mdUQ/rYJjE2DgXLt4q9rBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuImzieSyaLme5cyIM0Jv/tdbXJoHcFJSRBWFzsFkvI=;
 b=e9iYdSZmzHeqB3eFbEgzvJYhvHM8veXs4tduiEIbDu5XeDe/SOj8s3MVu35wcPO47KX9WnwA2WbpeDYnMXMTNW1I3BtYMpIy43imc+4pGM+mGN8oMkSKROljsjAuLUjZ+7YbShj5uMIs0Ug4e1bXvhWaXvdr8+00QcrPdGZIQcNUCU3jQjHLy66de3YEOlmMV0dN331HccilxozjtSa232WVXmE9/7FBayhmZ4EQLEkU5Vj09E0LIg4DKYxKFnKu1TgsUVxXi4lNuZrUHFaddOhRGgc9+qpwGRvNcvUDt2XrhVTD4DBZlsyltWY5Hq5dfGHFou4QsRNb7LErfRAEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6388.namprd11.prod.outlook.com
 (2603:10b6:208:3b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:24:09 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%8]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 00:24:09 +0000
Date:   Mon, 14 Nov 2022 16:24:06 -0800
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
Message-ID: <6372dc26c8f2f_12cdff294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221109104059.766720-1-rrichter@amd.com>
 <20221109104059.766720-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221109104059.766720-5-rrichter@amd.com>
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: b588a95d-9cf5-4153-bc2c-08dac69fb6a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zQ3n4k+oBKs9fJcNup+CTCMdc2XjR8RlMKC3IIVamNCIIv7CU0FXovNSrJ88EZ/hNq+MMOG6l5B0o8homefL/rVFLmE/W0XzNikJA45X5EnBtuWEUZwR/5Daa+59LHXQbsYtzh519fklcXf3e3mGMzPS8I1PoPnj/CjuE5TyJ8FjUR/tsh+GdNPT5uhUEk/ewF10ZW+sbAjD9prdRMxifx65DTQkdoVMVj7zVzjvMn/shPGNkBpbpVk9CE2YsRNmwk/gw+V9MsMj+reU7ofSlOXdTMeF0XoLJrfLRduz9BNer02Z6ufFvcIXao1yBDpV5PxKj1s1AZZcnstsThOb4RA7TRTGnTy+kG/nKm1HCa7fiOKfHvGl6nN5s9rZRDTkbIgr2VXlmWEnGBBnKB2cldNThbAw46GY3siTv7Kgf2q/X7/EHswxZ7fCHnRA3czj1Rvxj/E+MbGSlW7wZC4pSGLdbmsMPwAryA39Z/+YCzT3+5jaNFgo1JDDF3TOBPWPtINiHl8uHeYrgf9Io7Hr5ORqnfvIhQJzqsnOg/83BmF1XnzU/2EvvtCnI01+kV1temQ9sQtV9gYRCoVDwndFi//RLk2/7gxCxErFfDK21dZYJn+PFILI3/vKpeRN0EH6KJolp3MohSdn0eLN4znwB+JRmCUL962qVIrVujKZe5uSfOVG0jCSO4aqd37Hko+ht8JFTC4IZ16fEoqWvjLKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(6486002)(41300700001)(5660300002)(186003)(8936002)(26005)(8676002)(6512007)(9686003)(6666004)(6506007)(82960400001)(110136005)(478600001)(38100700002)(66476007)(66946007)(66556008)(316002)(4326008)(54906003)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1DQntRjyGgKkctQwNN4Pvz8m7q2ab+SkpkwfCqXQ8ks4yIrnt1ibz0Tj1Dt?=
 =?us-ascii?Q?Z62rZ57xbdyAtNAWmQQNaoh243en4X9VTW7qmCTs0tIOOfXHm2m6G5rK1JKN?=
 =?us-ascii?Q?hU1pDNXTB3nqkGPpRXXNj6CZi2KxpbOmHtjKoE4C1u0LUYh51om2u2TKkzi2?=
 =?us-ascii?Q?n+o2sQjw69ZW5eGL1B7wNrR3zt3y5mrhVkc9S7xjQdQOHzypvsVyQZwhcZ3K?=
 =?us-ascii?Q?7omQ3PMWTqoFc5KXwdguWYG27G/mx8sN15z43H8WbqsTq8anMqJbaY3i+EQD?=
 =?us-ascii?Q?JkL1WTSiTSsMl4Vs3xstRytLoufEC9I7By3vM7jyGjWEnRyYDWTfcl1d7SJ/?=
 =?us-ascii?Q?s8X0nWnithxWhRedvWfa56fJNSIEJp43kn6WbGlAi476ML1LIqNQnFGWFLLr?=
 =?us-ascii?Q?k2CrcTkvn+WXlscVmbUTz8IzCciULSfz815p766Lhw/3gvWq/UnqSLmDe8wj?=
 =?us-ascii?Q?Jw2PdlRBcmOAvSOA8l9ebHby3qOrZYdvaf0DzTFmQw/20MpJbF08Zqh2sN/1?=
 =?us-ascii?Q?tYWIcckxDzWK9JboVWsdggLwwSE6m0X/A9caKmN8S8IwbgLQr9plI5ADdWCP?=
 =?us-ascii?Q?9aZC4NgitQbaXal+Hhk9K0oJ4GeHKcQpCr5EPEQDhB3I9g8BZgUrTF5o12oO?=
 =?us-ascii?Q?VAoRswK9ULeyQp0Zq/KjEN2ZElIcQukaWiFrIiJYaeXsbK12E43+zPl76M9I?=
 =?us-ascii?Q?K9h9xvKlMc0hLnIqICkCaogf9oHUxd2+9YFsrcsRqQ3XLY2UewiYyU4YvEUQ?=
 =?us-ascii?Q?4UvIod4759c+ZOk1UkrsxwEVHKKsi+Q/YL/qD6e6gKN8FK6aVR39dDUqSwD0?=
 =?us-ascii?Q?Hu8GKcb2g9tCPPRkd3YeyJs+5NSezO1OBMwqzAxlFHAF8TqX/k5h+2EU8CVL?=
 =?us-ascii?Q?Iab86L1fC4rHJOzVupKvqTmAUCikqpAjoRPwGn4yAQYHZp6Zu/cG/chHDlbI?=
 =?us-ascii?Q?OJNb3sz5oRS4Ut5XYQqa7JC2PzLmf2Gr8buiBZnAqjTvwRWnFYJMO9ob4Qsw?=
 =?us-ascii?Q?zOyD2VUAlZnLe5hIbts4bnIqenegzUCMJbZNGkIMSgpi5dzfffGsPti+0EWp?=
 =?us-ascii?Q?BLEKg9IkBhGHppV095VP3tJWM4lszIcaipeFHREyEyF9/LJLtvoXTxkCrxPW?=
 =?us-ascii?Q?2laAk7MsdIeQZpcfc1XF9nsmaqEVo0B2+VPq0tKbGu/RTtrndtYHXAz9UcqI?=
 =?us-ascii?Q?HVMuS/Nz7LxiZc2ksL2o/nrxpkjeisZq8JVuv46sYpuvXp80HqlcsN1coKsR?=
 =?us-ascii?Q?288LdXqEM6U/N/9MXfTSWs6I7O6EK9s/ej+2k+tAyCBwTPy6gfXRhfUSfOdQ?=
 =?us-ascii?Q?SsPBZRljPHwr9yVajm2qJTqG+7AWg9Qfl4lDuzk6x/mi1juqh222cMWAHAaV?=
 =?us-ascii?Q?VBfmCnp7SUYatkv0/vJWxvwfm31LXOZ3qWFxeFEwLdQJ1sCJrmRgAuq7qeOd?=
 =?us-ascii?Q?out7S6W2PnoRVZ0tn3sDhI8UWMOw73nU12hhqXc/JohBz2K0P+jmiCdKuFK8?=
 =?us-ascii?Q?HFSZdPnddldPwqfOrIvRekyBAtvGVSHcoXJrneZF8i39O6QhGNSgchDv5Bir?=
 =?us-ascii?Q?IqAiUj7A5svKRgUFYjfCmCxQkaRhTGCJlw+Q3/S4m4bAxbR8gt+Kb1Hz86vU?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b588a95d-9cf5-4153-bc2c-08dac69fb6a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 00:24:09.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qrVg93XRzw7aH5TXRumQEiloAG0dOJsCfcOTtedwpO3JEpgrK05VXlrOb3C5xhlPrueRcNasXOyHg1RqrMsfIHunioPTz1R8Cl3mrN72pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> +		port = cxl_mem_find_port(cxlmd, &dport);
> +		if (!port)
> +			return -ENXIO;
> +		rc = cxl_add_ep(dport, &cxlmd->dev);

On second look, this seems problematic. While yes it will be deleted
when the root CXL port dies, it will not be deleted if the cxl_pci
driver is reloaded. I will code up a unit test to double check.

I note that cxl_add_ep() for the VH case is skipped for the root CXL
port, so I do not suspect it is needed here either. Did you add it for a
specific reason?
