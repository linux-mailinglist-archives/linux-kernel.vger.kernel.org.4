Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF44172D0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjFLUkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbjFLUjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:39:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE7D3;
        Mon, 12 Jun 2023 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686602394; x=1718138394;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Hf46LasQNNtVyTHOLuyJdF8laqUnhNQ0OSMrvbcro28=;
  b=AU6VW3q+nr9sxyGJ+3Y2Be8sEHH0ZBp9djWXcGYX31fe4nt12aT+6wVb
   d0PHzadrKZPK1+NtZxLgPiPQO/RKYouFj/ch6P4hF8PJWGoqrtp4xATY0
   7y+JMu66A1n9Uktz9vZvPWqjO6QgJpxKtH4K8uoqo3UZ2x7aQ2zaIQt7T
   qIZ/GX9BbbB4EUbSmOOgdgz+5fQfyZyBJ4VW2KYUP2vr3ef5EQsmtvtcO
   AnmW4aMtS7GskATRS+1awtVgQdlNXS9tgprZI+RjWdM7goM2uk++6/gXc
   n178yGHi4HN4SB7SoWxhF69lKPE73LDXRHg/V5RzFhqwP2aLf1f/bmj7J
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361520594"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="361520594"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885583590"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885583590"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2023 13:39:52 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:39:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 13:39:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 13:39:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiEF7LG+XLsvOKowylwa+WCaVK3jCRlpnNmSblMQhE5I0gBN1PBxd50OygTjyg7s2FUGA4NQIz7ge5KZ4rDkSjosppt0OdhhcwpyH6+l627d0dOWYeult7od3fjcgeLtD04q0lrfh41VY7Q9zxuceBBHugs62+6djYfOFuRBjTdpOXXA6iOqh+aN5yrtD41uQ2zMECV5bV/Y5tWNjW0Eic9cRDo/FvA++Kro9dZ5Xtuo00495+X7W+JvRS3XTfLIQ/9DwdDPnTdVzhzvBztkpD8cNhuwG4RbnIdUOhc52Z0H5hdhc6q1r44m8erLTQ3hBrtetOKGI/2V+tkXUvw77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDEOzU7dsgzBsQeP5S5ihMHEtLWs07mCNZmUAVOuRNc=;
 b=AbZ9eNWn/2OmiFYgmgRCFcM9fZCFGnCIwHzcRXSoDuYHAWjbvWVx8IsiCfHVfEdawGzWJ/Ai70xVsu7iV8KRKJlVRSyq6crYdXeJdT4HXv/W9nF2nh+wPtqgP9af9eADiixeXH7WG1ugN091cZzobQFR/lDzG8xb5Y6SiBXdrOR+CcKLSHmWixLWnQMj4DJJvw5NzbQKxCR1dB7V8NeKdS5JiwEFbUA+ZMfb5ptmgiSoQsvAtKQ8a2fllr/tBiT+V8jnW/WynymZwOqtcRDmcdV1F9ldJzT4nlY5Bng0hDQYrKO6ah/iP2YFE+PulORl5+WSlHo3FnOyaTNnuwpBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 20:39:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 20:39:50 +0000
Date:   Mon, 12 Jun 2023 13:39:47 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v5 11/26] cxl/pci: Early setup RCH dport component
 registers from RCRB
Message-ID: <64878293e1b01_1433ac29446@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-12-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607221651.2454764-12-terry.bowman@amd.com>
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d8a09b-0b1b-492b-9fb4-08db6b852b1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZxfXUZ2LsE+0/D/hdhZ/a4svwgp2IPZC9CKN1Z0tXawo3+AnblJ6AFvVKfLAqNcbXA/ZZQI7OegN0uT44ohTxFmjfxvdrK1MVyd0gYW5xoj9BY7m2HANp8cDEa71LQmr5KYcf2DowLpqS/mtZjv0fJmuC8Kbe1FVH5f1/0Hem/IiMWgiG84BvDoxSxRfaaPOejsO+/RLzLhPY0DB/yUfdvHZq/iPDWvy5AnzO9iGrJPrj9DjW0VRyEAG0GzOKCDt6iy4N2MIrgnkMjassN1vhZ0EfXwsjYeNVYPjlhYPsxHCBSPS7LsKu76tzaFU1d5lv8l5bzPNl1nlDTPx2SXPCPyPQyYK2NG1QEsKsvfCW6rkR+RCNJcGAD+RKtySNAIH4aDabf9VloZbrBMobh/mXKlxj0jE9+W3thabhcN7fxi9tG34cTX1tVReJJoKjm5+92DlxLBNKiUJkR/uXRUl8cjrZFro2dqwVC419wJvfxeSN9q6FBMMoG2KAadxkl8k5akNq9lrhSdGOTxNSKaBL+oYLzaTo1PDeI9NYsJb9wcosAgRF59s18UaI/6lfV8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(83380400001)(2906002)(86362001)(82960400001)(38100700002)(6506007)(41300700001)(6486002)(316002)(5660300002)(6666004)(8936002)(478600001)(8676002)(66476007)(9686003)(4326008)(6512007)(66946007)(26005)(66556008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8jKBRyeRQ4eSfHMjnlzuWex1lzB3bv68JnlYrL8B085t3L/JqJEqDy/0wlG?=
 =?us-ascii?Q?omDuAU2Y2p78lOTIRwnR39aE/W0z2Iw4Q5dDpF38tpeb2DSHqqr1uAu1uhhU?=
 =?us-ascii?Q?xmH44GARwdPXZBMP8DpZZ6FujaXsRUNH98/DOeLeT+jMIUIg067XvgGvhhrv?=
 =?us-ascii?Q?VuLTVeCAaibB7LAzoxSk4KkzPfpzfCNHwu/2LlKLXZB0KPU4xVbybz1BjRnK?=
 =?us-ascii?Q?TdjLTRgDWVnXwURlW8elljkHa3EyPo2UEWqME8tvaJVGod+NgafuTg7ch4GM?=
 =?us-ascii?Q?s5IE9gU0Xa13b/1JfXmlA2XfxTR+HmVN0US36m8T+Bm9GykcPLnlL+yzZSqV?=
 =?us-ascii?Q?Y7lLNiaTQEwNxMZRsohVKET89sJ9u76ycSi4uv5lEmSAjvy609gjhACJlqwW?=
 =?us-ascii?Q?1sC9uFZcpbDUVbPHFOBFGdE3KGb6BA8Oj3ydTfpPT5Rgqgf6NjRxEixgm6jv?=
 =?us-ascii?Q?JwQmWkC3x9weEr/wp9X5RLbvyekJs7uHYomCIEtMX/RczGyhGCOiDKon0aIV?=
 =?us-ascii?Q?v203x1htiXOwaAnSnaN2Cbqlbm+H4GMImLj+Am8pTnAdL5EVo8KNZRVcGIh6?=
 =?us-ascii?Q?bWiGepG2uYc13asrtf8bvt0DwRhhwIaY2DGFkIeZJ025mY2Gd3t89I14jTbv?=
 =?us-ascii?Q?Q2jUdMqHpxamz7BhYcVArVMUgsMKekkkN1djmFOf/QcjeiU/PvSAKU0hoeHp?=
 =?us-ascii?Q?6K4euO7QstPUWnJn1JMABr1xXhbzZEc4ZRNkla4SSyNBx19zY37MxjPpO+lw?=
 =?us-ascii?Q?3UFbl5YDqWmTPb7AJFTlNaWG3Zsu2G9jLmhr6gB/V+hGPslemYjXm7btk6tf?=
 =?us-ascii?Q?/9Dz/Iyjv/Pd6i6RvWei8Fl1fibK4u0ojLdcTy8wxCNn+USMPY9gra70AB7n?=
 =?us-ascii?Q?Kd++6qVFISL+YTiTEy/uQzOTR8GzajfLPHnOOzrqalw4RSVsb2CltpFLUmoJ?=
 =?us-ascii?Q?hPihxFzhgjS2Fsc3o4nYaknnPLn4NZKHMsMRB3g3APm9mJelPFhNtOUo6kKr?=
 =?us-ascii?Q?Cniq6Ljcw9HGCaTokUAOZdpJwSD9EBv2KAi4I2TS5BrIgFcjcSv1FNteyZha?=
 =?us-ascii?Q?MnpsNIbOXY115w0skEd4lmEcPhTX3qzIcxq4BKmTE3rKZkgG4oopLBSir7UT?=
 =?us-ascii?Q?fM9r4KE+NScheDJQbdAMfTAB50gnPwPuypFWjsTkZB1ycRX1OGh8IL5J6DPk?=
 =?us-ascii?Q?RtbFRLS0CdbgUMOKem4k2EvQkj7KLqyyUH//7BvLIV+FqPR+8m76f+mZ3L1z?=
 =?us-ascii?Q?n5+W51/lJDtgffS+TNh4y5B3l3GiYJbgZ9vcjJrXpNFWpkQ1eGEJ1sdLUu7j?=
 =?us-ascii?Q?f8N8P2RM/Tt6iOOQlfDV6Ujtdk27QhXuR2eEZVnAyj+a++YSSGcAMkM4gZUO?=
 =?us-ascii?Q?QdWh+c2jLv2WCMEjJX/52xgJqMkDIZi51CUCE3OC3nUAAx1I0lzmyJTQWVvL?=
 =?us-ascii?Q?EZ4y/nXTCFZ8WcovAUmXHurGOqnsk54HR8tIeM4b0AAtE4gCG758TysczMa5?=
 =?us-ascii?Q?nBn8sc3lcWLa7wBOFmjZYqNV4QAtVtjCQAAHNj5FOXRxDypwjGdx+QE0jfF0?=
 =?us-ascii?Q?NXcVd4Tx7Dv9OpdEbF/qAyHAtY8n18UOBIuJIEAI9bSxPMaIBhR8vw5og2PK?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d8a09b-0b1b-492b-9fb4-08db6b852b1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:39:50.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Nt74v87esK/oiybu3e1lsQ+JnjJsr2gVc7CneAXKXMavYj3b4WHAwD9TIJusD/Q15Ld2D9p2EGyWKw9642jqg+xNwvfRTw4SVWB8tJFSyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
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
> CXL RAS capabilities must be enabled and accessible as soon as the CXL
> endpoint is detected in the PCI hierarchy and bound to the cxl_pci
> driver. This needs to be independent of other modules such as cxl_port
> or cxl_mem.
> 
> CXL RAS capabilities reside in the Component Registers. For an RCH
> this is determined by probing RCRB which is implemented very late once
> the CXL Memory Device is created.
> 
> Change this by moving the RCRB probe to the cxl_pci driver. Do this by
> using a new introduced function cxl_pci_find_port() similar to
> cxl_mem_find_port() to determine the involved dport by the endpoint's
> PCI handle. Plug this into the existing cxl_pci_setup_regs() function
> to setup Component Registers. Probe the RCRB in case the Component
> Registers cannot be located through the CXL Register Locator
> capability.
> 
> This unifies code and early sets up the Component Registers at the
> same time for both, VH and RCH mode. Only the cxl_pci driver is
> involved for this. This allows an early mapping of the CXL RAS
> capability registers.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 945ca0304d68..2975b232fcd1 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -274,13 +274,48 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  	return 0;
>  }
>  
> +/* Extract RCRB, use same function interface as cxl_find_regblock(). */
> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
> +				  enum cxl_regloc_type type,
> +				  struct cxl_register_map *map)
> +{
> +	struct cxl_dport *dport;
> +	resource_size_t component_reg_phys;
> +
> +	memset(map, 0, sizeof(*map));
> +	map->dev = &pdev->dev;
> +	map->resource = CXL_RESOURCE_NONE;
> +
> +	if (type != CXL_REGLOC_RBI_COMPONENT)
> +		return -ENODEV;
> +
> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
> +		return -ENXIO;

I noticed while reviewing a later patch that this pattern leaks the port
reference from cxl_pci_find_port().

I.e. this needs to do:

	port = cxl_pci_find_port(...);
	if (!port)
		return -ENXIO;
	if (!dport->rch)
		goto out;
	...
out:
	put_device(&port->dev);
