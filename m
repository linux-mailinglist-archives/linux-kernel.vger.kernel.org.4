Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDA67DC16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjA0CEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjA0CEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:04:06 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF6761FC;
        Thu, 26 Jan 2023 17:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674784768; x=1706320768;
  h=date:from:to:cc:message-id:references:in-reply-to:
   mime-version;
  bh=XVoBrL1u+ovY+dPD6G1D/dONTla12lyDTSb13RbsByQ=;
  b=CaE4HG4y/TDqsbPUv76aCr41JZvjd6wsMazJqS9gPQMNocZB7fDxm5g2
   fOWUAJuk5kx7rEwkVUTW43Ndrg4jSKSuz5eX/rI+ZFlFvZ/jP5EWyK3OB
   7olr5WoUZ/P4m9Hw8TSKl244I3em4XOhriLygYloV3lEU4OREvwO/ZXbg
   GCu443lxf6lw7TpldTMSnJ5zvrNwjJPJAy49nmTj6id3M0C39VHguT1wa
   JRSXXmhz24jkxa358b+i4aXut0Jpka1aWf2O9nP+i/IuMMrqw2BgY+ORx
   DG/lXVfQPBpnRDg80+W2PN5ef6IYORHdGJmnwegrWYsoXMAtB2hEYrlU3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="306657447"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="306657447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 17:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="663122200"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="663122200"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Jan 2023 17:59:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 17:59:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 17:59:09 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 17:59:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI959XeUBnMJbk3/kccp+tW1VUSXIBpoCBZcVBZfiMOoQStMM8ZrJM4QRnD74nWQK/hFKSeRkaovAa0TavWtWAYM43z7qk6IsNPQomp4Cfihc0MppXMJrbsIJs36LGrXDVMe9GhGUP1NiMSXIOX1Gq30pdJ7IoaTRAUd8u6YAkGz1Mz94LPiiQmu/yaam8g/6b37jsy3Yu+3Y5Hfbi22ewBXZIuTEx3fqJoLFJMAJPio1u8mimh2zm4/gmcS8nwjZlIPjYpzEoXAK5kIc2Xcjdcfs6yDmH9f1BBaNNEUFgJqJTcdJg3XmIBaB9/RLDPEzQ277crxVDidqN5eqGgIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUtfowpkaYO4FO2jM2lQu7HdTrUjsl91zmPdkT8JXao=;
 b=Npg40CZGWva5jiiyfrxxxpwMNDf3lbDcbAzWjD5ZnLXC6qp3fyVM1MI5HhmzZaHwcSKAGFWy5l/qOdad9DTTpadJ5pSdkXAdiGbtxfjGu1Oby05jRAGCAvJzKTT4cJJK7bZizuKth17/D6AO4PDY3DDP4rYiQBGieWg+ydbre3OD521/Lh0xtDBJsXeDwwVggoiM6LbEjF3iHZSg3O9H1t9c+czcTFFD/xRTqKGzswKUomVPSffndxJOp3ADN/nTDM7Aa8c+d4psAtLYlJX2wrmoVa5whmYotv5nKSIRcMEKe9RxEkIDM8ZzuFv5OSarZpviznaEPcvcqWzs7TfdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4962.namprd11.prod.outlook.com (2603:10b6:303:99::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 01:59:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 01:59:06 +0000
Date:   Thu, 26 Jan 2023 17:59:03 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <63d32fe783ee2_ea2222949f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674070170.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1674070170.git.alison.schofield@intel.com>
X-ClientProxiedBy: BYAPR06CA0063.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6842b977-2767-4764-8caa-08db000a1224
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ng9YdU7wNmp9PldFIsl56dWoiyUKTVLyK7DsyV63yiPH2oHKeFXN8LlZUpq7wQ7NixZSEMnXplfh8jlfgWGBxNKZWD+T3U/KCRtgDUkZyLA93jg/F7T+273VKUvV5ElAiFmQpfa464tqYGUkX8WFPmCz6/RZYPe66jtl97yj6g/zIaOz/b1DNhNxWCbqxAD93Kvmrs3S7qQ/GuCmfmIq7d7j+xtsdclg4rhe3VO0qtJ3LmZwawjK0YjEI3/Vb8fYqLm+QOUYvK9iQFBKhjlHyl8oHIO5iYrmRGrlpXoiZYS8gYNy7D3PF2f7/gstmqMcp5crwJRLDIMdF6o5Qi9xPTeQ57PXIsaJ7LTpgc2lGv5uqcWpGNrmn2vYp2GuVV2oM3PV+U2xOtJjfG0vTcvd7fqUPb+q6c8oMcnzYyetJNtvH0e5OLrSYEV9mIZM4Rbj2Fn4CgsEYeDwd615KAuNN8iE1mPHs+DSVXAnAUOup3MdzCobYinyRohgAO7yQGuvXyn4aOQikU0Ou9FG4mQmJpVY/Q6rxyBM6jx7nc/YvOPxQ/fvbF+zVtNb2uuDveXQidfKHQJ1v4G2PU8HNOiVIfQC2Ers4henVjV4g26/yhVB9lGPjzWtL0+IfzqrsHDmQGaoFEKjZEsZcOnxjt37laTisCFqrFP5JXJ3omHWrETK0O4f/AiPhfCzuZNso8n/lrh0f8g3Kq7HqkYWdgefN2rZBwibEp5x7WganknflqV8jqESFkXf+g8Gl8BT5iqKf0xVqFMA9ulqBK1bTP40w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(2906002)(8936002)(41300700001)(5660300002)(83380400001)(966005)(478600001)(6486002)(186003)(9686003)(26005)(6506007)(6512007)(6666004)(4326008)(86362001)(82960400001)(38100700002)(66556008)(66476007)(66946007)(110136005)(316002)(25626002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2cwbQ37Z7CUJ3kb2feL3rDKJ6h3+ansikyF+UBtow/6VpgLy6je96gRuuRv?=
 =?us-ascii?Q?qd4LvNB0lfopfZPt1fNjIxpIoqbSLk1LuoLSI9WDoXfFpmSFMO48PxKVLArc?=
 =?us-ascii?Q?DpQ2TXJHDSx5ME0Jq2cmsFlvYW52+zq/BVOl9U5dOBghMabeVYWQ0KZwCRMl?=
 =?us-ascii?Q?Vb27s2m0/v9jfCLrcvLXDxr+fo3chWSPiMNEhoBNjAQ/4u2XDyRAMm4nKxPn?=
 =?us-ascii?Q?vHE7re7LR9CisSDhlU21KLKquciPSXdYkDMLH7NiFlsUEisGkJ9Cj67GwL9T?=
 =?us-ascii?Q?lWcbaKCN+O4+WWvRbv1VFGmT4WiJsCZT6kNOci3C9koVVUlL0bsfM/EqyBQ2?=
 =?us-ascii?Q?qzTamnsn//MABl9X0aqMoai+47WZSOkCzpsIjpWqwXKECZQ4DF8Qq7KZzhb2?=
 =?us-ascii?Q?f3HJScNdnVaCaSED7EewJc7kPbPEv3QAt6X/NGY9yR0tWlF9ZV6O783QxXeR?=
 =?us-ascii?Q?sXoCj1P8Pjn7GtAM/AQnePTAy3RaoBNZx0cfzHvn97ly/w93QoBRYQ81W5sJ?=
 =?us-ascii?Q?V+OHKWgVdxuDjLy7vkfd7BiLeJ93W7K2JlgQdAWwE+oPC/SOQf43yt7SDfCL?=
 =?us-ascii?Q?9Kp/cTsr1gUevhcA8M1gK4A3t7H7qG7ScwsE4qNkgI5ISSFKaQDlqxkQuc/p?=
 =?us-ascii?Q?2asREhuzfg0ZdT5tIYDzY3WYHBqJzuBe9uaoxiy8u2dhHfJQ9ZlmVb6Rqro3?=
 =?us-ascii?Q?g9uJR5Aa4jbAULTTpc9BOwioNrP85h06afQHiT3yCBYmdAFsCaxD21OFOa7C?=
 =?us-ascii?Q?77y18gxzuuySkdXkt7CsaCcECQVDClUUD6EU/JzzqU9KgxoYvQ1V2DJLcxHU?=
 =?us-ascii?Q?rcMf28K0UD01b07/zVt1IsfU74pGetuKqMl8cxu870KersbUUNoPgKi9pNNc?=
 =?us-ascii?Q?Njgetomu4p7dp5NZY414SdTl3YupfMwdvGqOsg8YTglgeaHxMqitYJigbPL4?=
 =?us-ascii?Q?b3gdP0Xg+7wzR1lk7EaRactrSoHchQZhJ//7r/b0Rp401eh2+kP+b7saLccw?=
 =?us-ascii?Q?pGkJhtpCFSNfq8jx7BENtrSLAZLBuvkZ3y/vSn5MMXDYw/ntnS5Onl7kyhPT?=
 =?us-ascii?Q?3zD3iJZdn8Ohyfx/Z06trz9OjdIsh+sJujCA2k8UMiPQr/+/9kwceEJjR9dN?=
 =?us-ascii?Q?WRFNOeVbTKr89ZDkB3IWgv2DyB3Tsu0VdI8anOKGtt6ubNKxRaQkiG9wEpyB?=
 =?us-ascii?Q?0P881nYJXu/h+woqaQ0Vv6GmrPsHdPQLS0Q2OEcNoiB+/WThUK2xp54bie6c?=
 =?us-ascii?Q?BjUtu6lr9p1eWk9caK7y+meSP4oFy8jlwqmN/vU3EY4y7FS0MFJ5R5z9pAra?=
 =?us-ascii?Q?Ls1PVgBZ9yaaFPBmgEH8cldM8OL5sV7W+W5SeW/USU81lWOesTTB7v/9GLAE?=
 =?us-ascii?Q?VNNbt0FoyFV/ZTwtHIE4D9muIaPpfahbQ7DyJTA4H+466HLaCWUNAyhxN/Yy?=
 =?us-ascii?Q?Dvr0pUxKHJe3Eo01P1tSwWHC2pVhI/3B3YrjhRh4Q3mg7W8s4PYjyEU96inu?=
 =?us-ascii?Q?mGbkMPqE7bOtq+CDWJj9+djFz7Kh8C9xLY7cg9yHLNFRZJM7kmWSAUZ23Pxj?=
 =?us-ascii?Q?RSy2kRVmgBF5M/GyTTzt86UlCdFNjx8aVKQU16dvIoxKRLjmCZYaziDEHH7D?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6842b977-2767-4764-8caa-08db000a1224
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 01:59:05.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AcB9tckRe5PYppX41Dy8cuw1UvsGwCUJKojzIU8OpwuPiZgVxYN6BkRZWWwQW5GOtBETgoCUfLMPYwR4uoDxUSNhRjWh0Y1SqiLZzRwiBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4962
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Subject: [PATCH v5 0/5] CXL Poison List Retrieval & Tracing
> 
> Changes in v5:
> - Rebase on cxl/next 
> - Use struct_size() to calc mbox cmd payload .min_out
> - s/INTERNAL/INJECTED mocked poison record source
> - Added Jonathan Reviewed-by tag on Patch 3
> 
> Link to v4:
> https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
> 
> Add support for retrieving device poison lists and store the returned
> error records as kernel trace events.
> 
> The handling of the poison list is guided by the CXL 3.0 Specification
> Section 8.2.9.8.4.1. [1] 
> 
> Example, triggered by memdev:
> $ echo 1 > /sys/bus/cxl/devices/mem3/trigger_poison_list
> cxl_poison: memdev=mem3 pcidev=cxl_mem.3 region= region_uuid=00000000-0000-0000-0000-000000000000 dpa=0x0 length=0x40 source=Internal flags= overflow_time=0

I think the pcidev= field wants to be called something like "host" or
"parent", because there is no strict requirement that a 'struct
cxl_memdev' is related to a 'struct pci_dev'. In fact in that example
"cxl_mem.3" is a 'struct platform_device'. Now that I think about it, I
think all CXL device events should be emitting the PCIe serial number
for the memdev.

I will look in the implementation, but do region= and region_uuid= get
populated when mem3 is a member of the region?

> 
> Example, triggered by region:
> $ echo 1 > /sys/bus/cxl/devices/region5/trigger_poison_list
> cxl_poison: memdev=mem0 pcidev=cxl_mem.0 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> cxl_poison: memdev=mem1 pcidev=cxl_mem.1 region=region5 region_uuid=bfcb7a29-890e-4a41-8236-fe22221fc75c dpa=0x0 length=0x40 source=Internal flags= overflow_time=0
> 
> [1]: https://www.computeexpresslink.org/download-the-specification
> 
> Alison Schofield (5):
>   cxl/mbox: Add GET_POISON_LIST mailbox command
>   cxl/trace: Add TRACE support for CXL media-error records
>   cxl/memdev: Add trigger_poison_list sysfs attribute
>   cxl/region: Add trigger_poison_list sysfs attribute
>   tools/testing/cxl: Mock support for Get Poison List
> 
>  Documentation/ABI/testing/sysfs-bus-cxl | 28 +++++++++
>  drivers/cxl/core/mbox.c                 | 78 +++++++++++++++++++++++
>  drivers/cxl/core/memdev.c               | 45 ++++++++++++++
>  drivers/cxl/core/region.c               | 33 ++++++++++
>  drivers/cxl/core/trace.h                | 83 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    | 69 +++++++++++++++++++-
>  drivers/cxl/pci.c                       |  4 ++
>  tools/testing/cxl/test/mem.c            | 42 +++++++++++++
>  8 files changed, 381 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 589c3357370a596ef7c99c00baca8ac799fce531
> -- 
> 2.37.3
> 


