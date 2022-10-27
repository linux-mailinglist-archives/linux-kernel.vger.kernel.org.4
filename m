Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654846102B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiJ0UcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiJ0UcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:32:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5C7646A;
        Thu, 27 Oct 2022 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666902735; x=1698438735;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/AWWefmwmbLg+powO+0x9JulqR/ywmIp/qIdcFf21VQ=;
  b=fZ9Peeab2t/tP7xr2PNGliC5EGSfvGxMLp2GOc5EJJQN8nV2L913+ey0
   oRlB6V1Jm8/r/hNzx3y1+vwwtIPSB6QoU9kNHbJQeJU1PlpV8oInk7Bbw
   pwRAEV2PBw5P2qyRKs6v5gsRbchRp0KepVL9oJj8NqOfuxzZiJ1Hm6IOH
   gdAshj2XxIL8AOgk4755lqYoOMJIl3vtBdFaU1nEgVBfShn/mlIAu6c0/
   5FqI84nyS+rbT9+o6xzvQPgFyexxFfzha2JByH7ZAmimWlnjjdITUo4qO
   STAjqcqz4UIq16tfxj3wC3NrzNKZ4OwPGg72lQdGSbGjMjyeiHfdUmBVj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="305946634"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="305946634"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 13:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="701487070"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; 
   d="scan'208";a="701487070"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2022 13:32:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 13:32:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 13:32:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 13:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCzolyA72PwzDnfN26aESm/Huf0QPkvGmOoWlXFO3rjraLtesevhMgqsY14KZ5FoV3wvOZo8A4UM+QxUybOu9MvBmsW9hSWfBbtWs+oEsy0Lanu+CoaA4sq+irspLCLCzVrUVgNgvUhfpJUyWYGukkHHjCFyuz2MOZtsNZJIEv/rE5ULMBmGkjHy7BYsvh1uLurD9+k3fAGhsvKxNoTaIr+U65FnYO7QwM6ylmk8BV0ZpoydQXC4PoNT4CACkTqhcHO50C5/OxrmWAfj7Iy9AC2Ua/ZVbzkgUH5FuHWDUL1abHD3VFGGLsW50v2YKQjqdHNutPCHJS5UAJ3Jgj/BWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnCYbSQ0fYs6TK2Qge5bEP3HeAHxojL7ZVnonBTAyrI=;
 b=dPFbBiVgLyKdPTY/DwYVr/riCJOcE3aITJxhG2iXY/XmgN0tvgslUR7ZX7l/55gr3vdzStNpIqL2JS6JO1vpB3iI0QmsfpzjU8OCdMH0HO2WNi26+qJ+f40jqXFIrIBmz4uXfV87KboAFiuSeoHEyjAUcfVsh3/lb/XAgtfbr662NKTfXWHVfZMM4APoxBBwUqbQnn09KfZFxZQhx+vxdJbZq8m5OK40Qc4lB4TpR/WgCfHXDQUPTuY+mhMNpj2a4fALOykLKGrTFGyolG0GA5XVTdAYJfYOkcIbjv3t/Xs2Z9yVwoTer6xw84KmwHH9dm3MxxtbSnvsho6yPNZw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4573.namprd11.prod.outlook.com
 (2603:10b6:806:98::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 20:32:07 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Thu, 27 Oct
 2022 20:32:06 +0000
Date:   Thu, 27 Oct 2022 13:32:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <Terry.Bowman@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: Re: [PATCH 3/5] cxl/pci: Discover and cache pointer to RCD dport's
 CXL RAS registers
Message-ID: <635aeac3a74dd_1172229431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <20221021185615.605233-4-terry.bowman@amd.com>
 <6354725122f2c_141929457@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6d35dceb-a414-7d3b-722c-5507d27b7ce4@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d35dceb-a414-7d3b-722c-5507d27b7ce4@amd.com>
X-ClientProxiedBy: BYAPR01CA0065.prod.exchangelabs.com (2603:10b6:a03:94::42)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SA0PR11MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be1480a-e022-4910-9e59-08dab85a50b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6Qd633yT85R+dOKKUnctZEf+ysuWGAbLidCI+lcp31JFTYNbSL5/b1N2YpWQB4Db6F9RJh5Ez9vYTUFNu4XpKmOeKfdsWN+C/C9K5k08aiPo9QQaygVAUfWyi94Jo/SDoF4sGQwQ47wkHgnCp2Gtzy1LAXwhVl6tdhHr5qvsgGKuP5gCwLEVWf4Byoz+3puIaiT/rUKKs5m9VpISvTnSpqmv+yypV/ZR+ySESWAfhxsqnyplNWf0qu3fVcslqHaNUcy7Ugq6yiHq9rzjj/MTi6J8pGPwjbIM7OO+S+uA13CfdIFrhG7+HgU/g0PDSfhjTK1XeMd8/wB12Q0sdOgpSDXcKCOWTi9l96Ljzi4KyNdk+y6YV3cSFXP2VpU0uQfFTZsuDO9hyPX1QlCNnQnH8cAOdbwViDSrDIsIbRU8y+l6vMEVo6DI86dDBg4OLEotUOnrnOEIVRRVuqn8VAQIz4g+tyzcvE9yOROfDUJ2TWRedr4+9S6yn5Csp/jv+4WZfK1SINStmlUT4dF8jY28Ro5kovDULJITy0si4vPbJGiRkRgSaAKNazWfSsZru0xia1vJuLzqGQYbpyxdx05edXFYfSA3fBu62q4+Qgq6a0tEZjYTU7Ez+9fGKPaime6dXfjJN9jUSsz8WWaSZ0+6Kcrg+BjfrN02VinFbQKx+AktedbkgouaKB7iPZNLoWNqvYgcZ6uuLQwmgj8LXfIb0r3V2/XLDFNguQbtUsOcoVG2V6lSa4zzMCKQ2rtqfC2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(9686003)(6486002)(6512007)(26005)(6666004)(186003)(83380400001)(53546011)(6506007)(7416002)(478600001)(45080400002)(66476007)(66556008)(66946007)(2906002)(316002)(8676002)(966005)(4326008)(41300700001)(110136005)(8936002)(5660300002)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KEJVKmueiMzWhl/Bm1te7AIKM9aZgsRj3ZyGJyJ6L+ALwIHIo2+x2xqQ8iGQ?=
 =?us-ascii?Q?1eHU/4VUpHR/NZiSDnZysdatYjziB5kCMzky6uwb1Irld1NGcsMGjQ79jq50?=
 =?us-ascii?Q?X338J90MtZBidKEmYRJXP7TKM/OxAbwt0+BLhbeC5y/4rz5eFwwWY01C83k6?=
 =?us-ascii?Q?K9cqiBx1yWRxcMevyvHydQMp3pp0Oe9NXSVmRyQ+nbHJ1VwvTJL5bZ/BH7Vy?=
 =?us-ascii?Q?XDBWA6ISrM9ZdhC+wlqP2jd5xFrOixgmFqCz6rRrXzqqms7KlTWwr8c2A7v2?=
 =?us-ascii?Q?AwJv2KVRtuK7aydJj5w9jeuu/YB5zQKQ7V9t+lhlfzw7sWSeUOR0i6K8jYbM?=
 =?us-ascii?Q?ZWLar24i26O0zONAkff9B9U7S1wtBWfzIHWXksNnVYXVPCAAzZ3gT5wTwxfN?=
 =?us-ascii?Q?Nke9Tsb30hsisv5C7HNxKvozPljj5lc8Pf6zbQuFfzgHaCFz7ukcSt8z2dLE?=
 =?us-ascii?Q?SV6KwuDpZXVGs6xzAseCo/N8QanamSOQmNoOSzlG5rHAqdAMLxu9mdqvg+I3?=
 =?us-ascii?Q?f1xZsZPXCY9Ot1hxtyRdLmiWV2q8ogMmxGc0UAJrBWaBV6tlsWfn5E/3+76m?=
 =?us-ascii?Q?p9g8t3wAhFUDQgmO5K5z14LkmbH9Y5R8RwcafF2jpR+IEnyEHCUUEurvOrni?=
 =?us-ascii?Q?HIZbsJEzF60DyMguaKt0HRuSORxZq9VUNv1b1nKn3Eiv4RdGSw2Lps6gJQa1?=
 =?us-ascii?Q?znybUvxCMphusom3pWWz6mNF6hDjokyH+ZCLjTKY0f96puJ1Whh35CN+eNMT?=
 =?us-ascii?Q?fltzErH9YteKQ7AGQl1IzYI8NQyp8WKe6CSXGntbMV44FbP4I4exDMY2AWUK?=
 =?us-ascii?Q?vtXN8ofEGJAFAnyMplXEq3FuKqK/HNUTStJtRejvWQ9rRWX0juCOQhNffuo0?=
 =?us-ascii?Q?bqPSZgFElQtpnUbAp3xjvzeyqagVZOeAe69RrfYi6RXTUmxwqm4NQpz0Aggq?=
 =?us-ascii?Q?u3DSv4grxIupAkPUdSbEFHKQ3n+ZdV6EpPpSVy9r9ss67r0CFQct7NIcRoS5?=
 =?us-ascii?Q?OMWAjzaNlgezWCukVekpCaVopF9zzngWiqXILZ4Mi8sS4jMJVKaMs/8X0wQ7?=
 =?us-ascii?Q?CTpqQlXlnAfsfttc1XaSeAaNzxRaK0xkUZR0elb0gLAYaWnLKmN2gla2Au/0?=
 =?us-ascii?Q?M4avS4AFGWFxo+A1cny+wJZl5lEPFSqbIQIakTO50Cwt0VEcJQUvq6v19MWq?=
 =?us-ascii?Q?3CRjr78Q9uVQPRcd7jqpaj6St09sJMgWNBPdy3P/R6CUhNneZqXOcLIdGuhU?=
 =?us-ascii?Q?VGNr9NR6VxCOf33OVDloDQOeTJ/qKIUTOFmlFr21YiHCWO09Kqvl4VYirb64?=
 =?us-ascii?Q?nNbfQBRKYerazJLBfpI5p73zS7F3cXLYFpxjiFdQUR8tLf3Vlxo82ppp+nre?=
 =?us-ascii?Q?vwuzpLFCCq4Ky6z3hKs09RjCYFnTXPmXEEN+Q2GHhTew6/UesbSJNM+pn+MC?=
 =?us-ascii?Q?MonMHxNVGm4BHBUKHViVfJUoQ46vgbboHmt0/m0dH7EUGqGsih05xFISqgWB?=
 =?us-ascii?Q?1dJPkJ+XkUf0WptsOoCUElJQeAbUNQ0mCBdWbG/D1NfRNZvbP0PQwe+ll2Xg?=
 =?us-ascii?Q?g3+cqv5jVHilYwJgOPI9tAL7oOZWjW3whlHXIOPZvyX/Dbwzv48ehkg70i7Y?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be1480a-e022-4910-9e59-08dab85a50b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 20:32:06.8999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8T84pX1icv7PeiwzMqL18V/zcaBPe/sQILgYYsyTL1VVs4aNzmSiAbcu4Tdb0Q7wHr4t6G8D5jH4fQ6xxPppuq/TQ2PCNBuKnCh9AzoZqxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> 
> 
> On 10/22/22 17:44, Dan Williams wrote:
> > Terry Bowman wrote:
> >> CXL RAS information resides in a RAS capability structure located in
> >> CXL.cache and CXL.mem registers.[1] The RAS capability provides CXL
> >> specific error information that can be helpful in debugging. This
> >> information is not currently logged but needs to be logged during PCIe AER
> >> error handling.
> >>
> >> Update the CXL driver to find and cache a pointer to the CXL RAS
> >> capability. The RAS registers resides in the downport's component register
> >> block. Note:RAS registers are not in the upport. The component registers
> >> can be found by first using the RCRB to goto the downport. Next, the
> >> downport's 64-bit BAR[0] will point to the component register block.
> >>
> >> [1] CXL3.0 Spec, '8.2.5 CXL.cache and CXL.mem Registers'
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> >>  drivers/cxl/cxl.h    |  4 +++
> >>  drivers/cxl/cxlmem.h |  1 +
> >>  drivers/cxl/pci.c    | 72 ++++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 77 insertions(+)
> >>
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index 7d507ab80a78..69b50131ad86 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -36,6 +36,10 @@
> >>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
> >>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> >>  
> >> +/* CXL 3.0 8.2.4.2 CXL RAS Capability Header */
> >> +#define CXL_CM_CAP_ID_RAS 0x2
> >> +#define CXL_CM_CAP_SIZE_RAS 0x5C
> >> +
> >>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> >>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> >>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> >> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> >> index 079db2e15acc..515273e224ea 100644
> >> --- a/drivers/cxl/cxlmem.h
> >> +++ b/drivers/cxl/cxlmem.h
> >> @@ -243,6 +243,7 @@ struct cxl_dev_state {
> >>  	u64 next_persistent_bytes;
> >>  
> >>  	struct cxl_register_map aer_map;
> >> +	struct cxl_register_map ras_map;
> >>  
> >>  	resource_size_t component_reg_phys;
> >>  	u64 serial;
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index 2287b5225862..7f717fb47a36 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -586,6 +586,78 @@ void cxl_pci_aer_init(struct cxl_memdev *cxlmd)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(cxl_pci_aer_init, CXL);
> >>  
> >> +static resource_size_t cxl_get_dport_ras_base(struct cxl_memdev *cxlmd)
> >> +{
> >> +	resource_size_t component_reg_phys, offset = 0;
> >> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> +	void *cap_hdr_addr, *comp_reg_mapped;
> >> +	u32 cap_hdr, ras_cap_hdr;
> >> +	int cap_ndx;
> >> +
> >> +	comp_reg_mapped = ioremap(cxlds->component_reg_phys +
> >> +				  CXL_CM_OFFSET, CXL_COMPONENT_REG_BLOCK_SIZE);
> >> +	if (!comp_reg_mapped)
> >> +		return 0;
> >> +
> >> +	cap_hdr_addr = comp_reg_mapped;
> >> +	cap_hdr = readl(cap_hdr_addr);
> >> +	for (cap_ndx = 0;
> >> +	     cap_ndx < FIELD_GET(CXL_CM_CAP_HDR_ARRAY_SIZE_MASK, cap_hdr);
> >> +	     cap_ndx++) {
> >> +		ras_cap_hdr = readl(cap_hdr_addr + cap_ndx*sizeof(u32));
> >> +
> >> +		if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) == CXL_CM_CAP_ID_RAS) {
> >> +			pr_debug("RAS cap header = %X @ %pa, cap_ndx = %d\n",
> >> +				 ras_cap_hdr, cap_hdr_addr, cap_ndx);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	offset = CXL_CM_OFFSET + PCI_EXT_CAP_NEXT(ras_cap_hdr);
> >> +
> >> +	iounmap(comp_reg_mapped);
> >> +
> >> +	if (FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, ras_cap_hdr) != CXL_CM_CAP_ID_RAS)
> >> +		return 0;
> >> +
> >> +	pr_debug("Found RAS capability @ %llX (%X)\n",
> >> +		 component_reg_phys + offset, *((u32 *)(comp_reg_mapped + offset)));
> >> +
> >> +	return component_reg_phys + offset;
> > 
> > For the RAS capability in the cxl_pci device this patch needs to be
> > reconciled with this effort:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-cxl%2F166336972295.3803215.1047199449525031921.stgit%40djiang5-desk3.ch.intel.com%2F&amp;data=05%7C01%7Cterry.bowman%40amd.com%7C33092f731a854d7a9a5b08dab47f1075%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638020755070581692%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=84oOACCwh4XtndFKOUV%2FltpJjFnp4lsFQgw75UMphHQ%3D&amp;reserved=0
> > 
> > I think we will want RCD and VH RAS capability reporting to happen in
> > the same place, and that can not be cxl_pci because cxl_pci has no way
> > to find the RAS registers on its own. It needs the help from cxl_mem to
> > do the upstream cxl_port associtation first.
> > 
> > Given CXL switches will have their own RAS capabilities to report it
> > feels like the cxl_port driver is where all of this should be
> > centralized.
> > 
> > 
> 
> I'm working on merging the patchsets now.
> 
> I'm merging the following:
>   Dave Jiang's onto 6.1.0-rc1+, provides RAS mapping.

Sounds like I should add this to the RCH branch so you can build on it.

>   Roberts series ontop of Dave's, provides RCD discovery.

Robert's series is still pending the rework to drop the
devm_cxl_enumerate_ports() changes, not sure it's at a state where you
can reliably build on it.

>   And this patchset ontop of Robert's, provides AER and RAS logging

As long as you are expecting to do one more rebase on the final form of
Robert's series, sounds good.
