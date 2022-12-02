Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD563FE46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 03:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiLBCsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 21:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiLBCsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 21:48:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2408A4331;
        Thu,  1 Dec 2022 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669949298; x=1701485298;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K8Eb4nWl10yvVPIml7NJMpmT/mP3lkEmvj4Cbp0Yrec=;
  b=QFw72hQIwFLPs/tD6tN1y3gn2urYNjBEo50wRucSvnWQVewvn2OxzoN/
   N77W+RHW7jIL8KX/uJdZ3xMOyrf1Gh7iizmt5oApjQbKkF1/WvQv3I6gx
   OziFxJFE+PcOzJqtVNXZrzjOmUNFgaNmM8VNst1aps9ZYicgvqOif5utw
   xFFYYnrL9ww1020j7SSdX0h5WXi8sYvLW8yDmUDTohyYmJLt24+EE0Ct/
   LnLOTIBEcac2ID64TAt+a98EDmNCvLqbZZIIGtkTaQBWPi2L2dK0QZnvf
   h+9HK4isKMs3wBPFJGY1Erb72YHYnoJWMSD53Gf3aRvkMCKn1WlV9GfZX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="315881527"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="315881527"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 18:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="647001220"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="647001220"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2022 18:48:18 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 18:48:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 18:48:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 18:48:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMp9UTf6X50phEsbDinKD0CD6HjNZFirBFASmsMGYIs+8FiqP7mKv7VpKbH+NIfiAxME7SG95jnzEmSoYGmYuE/4G7tTB17iIgLKVI4BqkQzIOW3ij7VAJvrcyhh1wFchosD9OzfbpeH5Meog6rhrFKcC63duGPZ7H/RG5M9FX1KAn0wTHO4CEK4Q2HwHSWfZeAvyko7jrQ4h2pRt7vhJ/eRwXj5pHsVjVv47BYUlF9EuWdJVsh1L6fmCqrmtSF3aZ/ZVWL5JDoZ3++2Pprf0ukPgn/WZQAjRvNzhtABz/MzghHioTKEBuNtwf924JnMFG3mLjtDTj2jIhPmbhX7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeXfHFYSseaOHfkpMpB/2xE5n1Vls9PQ22UQSWlCojs=;
 b=jKZboPpGqfuDIZBlD/0HydBXWOObFc48RvlfPC9nFGURf5IuncLTyrU2VRC04LOIV2tWzQaCiKRn/XGMa83CqpcCzo7wJUF0ZCTuN6B9cc2bv8jdl+hZetYf/MCJEZ8CXflgUHT5mP/Nn++HtLuILehG5nPRLPDOuBJG2lbaVZxuEgizj6XutccV28gToxDwcF7ZDAF1tPyMo+Xr6MjuSX+wvlbHl6ONKFF2YERqASs9J1pMgMb8SZHTWtucFIecnxD4tYE8UhAUQETCe6ldAXT3LKmkFCzN9lKzsdtTyi8EvEXppmxrtI8XENt3ekga2OZ13/LfXuZqH3l5vKiP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 02:48:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 02:48:15 +0000
Date:   Thu, 1 Dec 2022 18:48:12 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2 04/11] cxl/mem: Clear events on driver load
Message-ID: <6389676c60d39_3cbe029487@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221201002719.2596558-1-ira.weiny@intel.com>
 <20221201002719.2596558-5-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221201002719.2596558-5-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: 35512954-1ac7-49dd-c95d-08dad40fa8ec
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rufFzpOWAYqTL14GOdqJCX1mraCH2RMYgA3+3Ovr+8Jf8vjB1f0tu1Bel0MxjVzH51fKqyJ34q2qUGVQtAmj1Mrw9RQnQnOXJ4Zt5HQvm7pJQ68BTIXTG5eOAG+GeSLEoj19OSQI4VSLW/nMhAvG5EiS0U3PETRioKEqoij5ATHHd527ztv/ZeCKzRomM5S1DzrynUS3KMJTSZm61mfnUInOajauEjL2kuAHN59BuZiqfxk3YQWfc46ZE4Si+6m6aVw/GCXO7I1i70dl1Nzu/N6rf2z64OP2W83F7raH/UhePbaRrAN7H1Urwq2h63tl911A12yN7A8su6Q//jLDD88+xe0EWxycs3ffRGUTgz9sfatrBv4xG+vgAeVQLiQYddiSnn4g2alKHjJntHlHBtJdReXtOE2FmgorwlwwL0PM6eELYmrsgZnnGpe0MF4B/JuDz/K5rWSyGTIexEZFyrBZgosaauynQ5KLp37RVN+WJWceiXceffYMH5nqdSKdkeXhDuPsftYrwADQbxy5/cMQSoBBeqUucDhLQOo8Ta4c19kZp7C3pJhC34QMjGvXdFuWEkqpc8bhTYeV6e02bdyIZMmy4CR+yUz6eVEnE7YO7/oSfqbbq3AvaQ5C8EAViJ5rg7v51BwuzAbWD+G9+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(6200100001)(26005)(2906002)(86362001)(66476007)(6486002)(316002)(83380400001)(38100700002)(8936002)(6862004)(54906003)(4326008)(6666004)(9686003)(186003)(41300700001)(478600001)(66946007)(66556008)(6512007)(6506007)(82960400001)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YSP29MQ1OTFqaW1SekJy8z7wisNYVMuWEv03Tlgf8HAGr+u5jPtpLWSY7Qro?=
 =?us-ascii?Q?sH1kjVWTQ9hBOPjlJ1Hu+8rC78shTkwekILc/RADvyIlhz6E0zyx7O+EhPUo?=
 =?us-ascii?Q?eSUpmUstY0s15LlZxtQ6hfMQPoDCD1GAFFUoCQKK1qnZopEwFydAN3yU1ggg?=
 =?us-ascii?Q?VKAg39EFh/exDuq+Jk4bsekLdl6wOuN+ZrFaIJeJckb6Av1wC6TLL3OjvoSy?=
 =?us-ascii?Q?0SZeAMNgc01fMXExH7JXn2p+UE7v0+CSQ8FOg3j89IhAq9dMW43xdMNP9vCZ?=
 =?us-ascii?Q?wGLwHBB/a7cFLrgIn9ABUYzVFRvCg5xs1ZI7iURmnZwQpe54Rne/X8f7swIe?=
 =?us-ascii?Q?9nDP95nDtSi9nVhRoHhXMitB61LTe7G+imTxvs7819lHghrwMTHUZVOyL9GA?=
 =?us-ascii?Q?YKmnE1gJT4JmihVyjgRS6uACx4vf/yY0fux1gMepJ4ffuW1yRxNf5MqKh/zz?=
 =?us-ascii?Q?Wh7IR6Rq2ZWtiUU8M/8JwDnLzrBIhwbXPTHexdAVgXVV1JRQB6AEAd8hfn9t?=
 =?us-ascii?Q?EfyYsropkR+6/NFQ4FNWwGGD2+GE02ib9q+rtbJ/7VcEsjOBQhJFxgHh5cdm?=
 =?us-ascii?Q?Ixx8ndzSBMe3hQ5cX3VHCgQwHTYaU42k5VZnOvSiyh3eCU/yIqnT6k5DiQG1?=
 =?us-ascii?Q?On4csJ7a0WsneMFs4m394UVPIgjTEBGPjRVncfeIGouBLucOLd1eEKRdfhzX?=
 =?us-ascii?Q?c/o7y7IV1PocP4qYFOst1HjK4LHHwoG1YLNUHLNdCDL/Hy3NwDY+89Lu1Sz+?=
 =?us-ascii?Q?rLTDAYeYqkpWW3GopFi1Mc8Q1kx4ZAL7nmkog40mbH9F3DDmm0Y1SddoAhTm?=
 =?us-ascii?Q?Gs4yAoCx7/35v4tshfOoSA7o3QYrXWPAqsztnuc3++Wz0Fv2lSWlY4mddHdH?=
 =?us-ascii?Q?xHsYgEJBQ7Wk6mKnGYZY9vZvJtMlzLV2Hpy2IlHdBmS/CDn8EKJgH1o1xd7Q?=
 =?us-ascii?Q?JrN990bolvnybaWeb9CY0qDY6KIxYMVWKF9WQ2/R409nqA9EokmrbL+Ug0qd?=
 =?us-ascii?Q?IwuJNFP0xkcyLae1qd27yFAmchdf4MrTr13OwzBabohkvLeMREjKxh1wx8TM?=
 =?us-ascii?Q?LAw52usBRYcdWODQOZAPxI3XVHOWsX74E5P6x4jpA4xxA9azGtBqnBgHV4KH?=
 =?us-ascii?Q?GoZr6UwkkOC4IyW6RV8ieylJcfdqiaVDB6F4qEQeXKOgBRbqyR+D3S/l357k?=
 =?us-ascii?Q?AEVswaRasG1So1WtB7CS7yjtEv3KlMUwxyUSuj0omlb/4akh7ti6cajL6HUE?=
 =?us-ascii?Q?gOAemAzWl4CyL4YFBcDMeGy8E+DSpx3S7vTFhww/lsuoFGu7Qj02TNfssCLA?=
 =?us-ascii?Q?X83e06HMl8bbibSmz89x02K3Njl2HwdhIirs3MtUTAHyh8tuohm5bb2S413A?=
 =?us-ascii?Q?vR7KxIopk5qED0+7JiAu5EAmbZjpvolzv2EgZ9LsNbjKmskqvqo7sX4X091F?=
 =?us-ascii?Q?UhMSf+FeJLZysPBqTMVMFA3dLKmFTIZdiyctDToYcK//ZlTjtPxoBfK90KJa?=
 =?us-ascii?Q?ZUH+ps/KuLPAbnMqHspy7QR2Sdsy1PIXRk4tVUYHfkcZK3fT45w6+EIYBU8z?=
 =?us-ascii?Q?6uwgyK3j0vOovGQ37qM6MGAZrAYQe9u59X2NstX6vGCrjAkZhVjCMpMKNffE?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35512954-1ac7-49dd-c95d-08dad40fa8ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 02:48:15.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1l6Osz4KVx5TOa7of8NvhZ72RQdtxPceB280TSM4Ajonp4OMhPSLk37ZMrl3oXllGShdzvAHFLGLSR8cJV2byk7p4Tu8kGivYFSqbI9eR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cxl/mem is cxl_mem.ko, This is cxl/pci.

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The information contained in the events prior to the driver loading can
> be queried at any time through other mailbox commands.
> 
> Ensure a clean slate of events by reading and clearing the events.  The
> events are sent to the trace buffer but it is not anticipated to have
> anyone listening to it at driver load time.

This is easy to guarantee with modprobe policy, so I am not sure it is
worth stating.

This breakdown feels odd. I would split the trace event definitions into
its own lead in patch since that is a pile of definitions that can be
merged on their own. Then squash get, clear, and this patch into one
patch as they don't have much reason to go in separately.

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/pci.c            | 2 ++
>  tools/testing/cxl/test/mem.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8f86f85d89c7..11e95a95195a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -521,6 +521,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	cxl_mem_get_event_records(cxlds);
> +
>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index aa2df3a15051..e2f5445d24ff 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -285,6 +285,8 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> +	cxl_mem_get_event_records(cxlds);
> +

This hunk likely goes with the first patch that actually implements some
mocked events.

>  	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
>  		rc = devm_cxl_add_nvdimm(dev, cxlmd);
>  
> -- 
> 2.37.2
> 


