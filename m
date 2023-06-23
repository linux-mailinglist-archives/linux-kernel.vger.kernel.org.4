Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFD773C3E7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjFWWTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjFWWTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:19:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0F272A;
        Fri, 23 Jun 2023 15:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687558739; x=1719094739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t48uJ/GRUKSRqB5prlo4xK1zOW7//dRTrgn7fi05ctU=;
  b=iVLcjwpwYizj0U3cRp48QQEERgCvIz9l5Mo/pKbPjFJ2DLWT3cfp5OP/
   0f+fEjAaVhlpqYqGBRDo58kOCZiUVhQx5rF8jTxTpCJAm444bzSv5IrMW
   SRmEGtdmdp8IiXsvlnv5PjyjyLocDIGxPYwnza1AGzvE7fsM9Kv0pdrhJ
   U+CyDXpbjCtBE1n08f7XiHb1s6G93t0XzvWUhRUzSEy7bgDcPt0cdlkS6
   0jSqJUv5QY9kSfsCPyug7UnOYWkaWCxY0Wv3PIgQ/PbRqSHwlTxCpS00K
   sa+03kLPs/urHgY+lDeK0OV+bnzkkdfs+DrEBHYA/pj3BG/QSgF8prgiR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340467043"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="340467043"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="839597616"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="839597616"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2023 15:18:58 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:18:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 15:18:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+ocuWK+F9lMuy9GLdHAdOX0eEewqJ5cnppnmgXVNIcaJoy6egc04uR04SMsac1H4674Jw+2vxE8U+m16RtDSe0zSWQ/J0SObf12YQ3zM7TJJDWLTJYzAg+Q1kSMDS+yLECtukOLOI5R7ix5WSv783iGEXFY4/7aKOUi46YSwjGl4sbdr97JF28igDxYCKMVkGX3Xy8RzHq/DV816DH5RNuwYUJIGhJrawDeuN1lowMsYGc0qJeJH4hS71KkiOXXHrBi/D7sQYX/orEdXGOneTycD0H5w1WWX860BJRtV4657SRpTtEzF0SWXnojnP4Si17tYsSsz3Ln8ydrMU8Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFurBMlE/MdWXBPze0LHOco2/az6ZKfrGiW0rjtaMQA=;
 b=JfZ2DX9pvt38Bqw1NLV50/p3onMiXxr6ww4NU/EVVPS8H4b/wcyHXdzz3G8dO/MybzsnxNH7SVmXyymL4RjIT26mDimsMhQ2WbbmdFNZ8ONHnS6vwBSiX5SkpwOzQZBm8u8N1JMhnmm3O+ru3rswP1tkOf1gQSnlSWSTNUtNVzRGpmWOACJK1yfBw6JCP1+pNJpSmpIkYQIUFwI58jXwwDLNQ2SXNsYhYpP9FEzs37jSMrLOlWCFzMBeEEAMpvAeYinLpUzlXvXlrV4U/BPNpU0Iva1R0y95SSFkZcpf05uRoF3WqMF1VJb+c+WHEcTIzKy9DGBEHdt7YRCLgiA0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BL1PR11MB5430.namprd11.prod.outlook.com (2603:10b6:208:31e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:18:56 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:18:56 +0000
Message-ID: <60626151-d838-c335-47e9-246bdbe02dec@intel.com>
Date:   Fri, 23 Jun 2023 15:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 26/27] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-27-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-27-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BL1PR11MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be109e0-88f3-48c3-793b-08db7437d580
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4LqESrBHJJu8sbazlEnSSLqbEZjmLpgIlBkCNujeo5rfQqeqG2WmtrLLjqQpAU1IJ0rBTzVGRVgaM8wsgCsqCnr6mb/y9Ib//Y4W2rlbJ2+RTc39QmjbcP4skhndze8le1uxC3K026/2d1gF4hHg9TQw40SFq9kwMoXviTNAmK73mmYASXQwSr/gT+z62GOS9V3Wb+Ei5avnfDI3UxVejStpKv/BUw0qSq2r59ivnFJ0F0/Tf8Bgk0VeeZ/qgfT6oIGVSWd5u6EY0ROMsCuZuNhBsc7ViUGgFX46Hn/L5dUAvLD7buFHwMr6/Eu5u2jKouKKAeLUCrxmArkbCdjAg+S7Kx9w9YhUJ16AFATVleqDwEFQA353cJxdwczJM7/9PZ46IcudtHSrRL7sjnOq3dzCt+yYAjN/anLWzwgKkf1sVsOaz/sMM2a+YV5IlZL6gT5t35GhSmxSnCYitDBCMm454esVF/rYfi7GTmWn0+4bZoCCs2xM+4qQ+NTPRi/aG3SSVe7jA5RPaYhrwJBJq+dSbfGJsRnN2jquncgqcFU/hVFkzJyGzBQ+k0AKbO715hAB/0uDt4iL3BTY9UEVsb7JplCIN8Ur/LHsSjibCukm0mOp+JhT+v3Vd8LA8RsVmFtINmXmpdkzJnIRdH7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(6666004)(478600001)(5660300002)(6506007)(53546011)(6486002)(83380400001)(4326008)(66946007)(8936002)(66476007)(66556008)(8676002)(41300700001)(31686004)(44832011)(2906002)(36756003)(26005)(186003)(6512007)(38100700002)(82960400001)(2616005)(316002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdEczJzODg5QVk0dmRpRTB5aVN0bExMaU9xb0IzY24zb1RrM1NES2ppVGZP?=
 =?utf-8?B?QTZ3MjRiUGlGRWNpOForeE1ySFAyRFB5TGFNSi83bGdKcHdLZTh5UXdOTi9G?=
 =?utf-8?B?MGxCWmJYdy9qZXNLOEx1N1pybVFjUGp5MWExZFdkVkNqaFU0STBxaGZvTFh5?=
 =?utf-8?B?a0M1VWJMTWNjZFg1bzJDRnZ5V0hyTS93cDNNQVFOejZnd1E3UmdmcmpZZWRE?=
 =?utf-8?B?YWpBS3NFNmpVN1FkaWdLMExWTU9kYTlMcHdNbStDQXJnZ2NzdklkM1VqZWJF?=
 =?utf-8?B?VVJPRG9SNWFBblNxT053Q05RS0pndnVPa1ZxbWVlcDFtRkErUUNiSlhncGg0?=
 =?utf-8?B?MUpJVGFrc2dybkYveEhoK3pnd3MxR2FGZVNMK2s2VHp1SVNuYUdtWkc4Z1pK?=
 =?utf-8?B?QmlDUy9ycGFUVmRBSWxiWHRJQ3J6SmFxRTZETHkvRlg2ak5hQm8rMFM0eCt2?=
 =?utf-8?B?dkVNeGlnZTU0eFFGZTlwb25YcFFITUk1c2pTNkhWZGdZT250a01zbDlSellH?=
 =?utf-8?B?YytObkVQSkRXSmFtdCtleDFOWDdGMHZiTVJrVzdaQlpJWjZSeFBVYllpZ1No?=
 =?utf-8?B?RkFLZ3BGYURMaCt5MER6MGNnRWxDRTBxa2Z2dWh5N3VObnJpWE1NRjM5NTJp?=
 =?utf-8?B?UXF0WHFtS3EyNlNIejllbmJZLytKNU5TekFWajBwL09iRTlrYTBQd2pnWWhS?=
 =?utf-8?B?MUZrNnRuL1V5YTdkMFdvNWVEV3RHOWpMVDQ5NktRVzVRU25kZ0RGTUM0K2tS?=
 =?utf-8?B?VjJFNkpZcnhPWmF3eWpNdm9wZEtBeTFDSkUxNnhicGtDelRkYzgvSU0ya3Ba?=
 =?utf-8?B?U01wa2t3aXkzYnlXTUM1dnhPQzF0SklMQ1d0Y2dTQUdXTDIzQlhNTXVYK08z?=
 =?utf-8?B?V1ZucWFSVTR0OERVSFlhYjd4RHA4ZDA2VkhubFcxSlZFc3JjTmZRbyt3cTJH?=
 =?utf-8?B?Y0xrZEF3dGJoQmI4eGxUNEZETVBmV243M1h2R2Z1TFo0YkJuY09YcEh4UnhP?=
 =?utf-8?B?Q1EzNlNTS3Z6K04vR2JaQzRYekZTTmlSMkhta0FXSVYyQlh1M2Fhd0VtL2JK?=
 =?utf-8?B?NWZFa1JiM3JydmZwbzJkMnJ3cFNxcFZSbTQvR2Q2TEo5U1BCa1kyc01FWSt1?=
 =?utf-8?B?M3htakx5WEkxY2NzajdGMTVDNGE3QzFJekxYMUJvL21UK3hidW5NRE9rUVdm?=
 =?utf-8?B?dzg1SXJyckpvdTJWTkx2eDU3dEx1aThMUjIyTUJlZnNJVjVGaG1ISGdCaEFG?=
 =?utf-8?B?dmV5bDZxYlJsdllHMFI3blh4OGxrRjJhWHpoYzY0Z3V6RUZvcWxtL3kwVitW?=
 =?utf-8?B?NFUyaVNpMDIrY2xMa0VDdms3NUVqTlg0TTRzWVBnUEJUYzNtV2Y5NzJqZ094?=
 =?utf-8?B?YW9GcWlUWmJidWZHSjZhN051WTE3Y3I3dGR1V2E4ek55T3hWZFAvVlNwUlVs?=
 =?utf-8?B?WTkxTlZaM1JKeEhMMmJnVFI4K1FBcU5hdnhlT3d3ZXJxaXVyZ2ErYk0yT0ZS?=
 =?utf-8?B?TFJuMlFwZWNtaGhmd1N3cjg5U1VyUnBVSEczNUdmbXoxVEFxcGF4L2o4YVFy?=
 =?utf-8?B?RWZOZDNLV3lLdTZyYWNwdTBzNFE2Wk93MlAvWE12RWFHdzdTS1hKQ0xaNWEr?=
 =?utf-8?B?djVGcHJZZnpqbGE3WlZ4Q242WUgxSnlQSmpYeTJzWW9TZktEcTY4dnJnaDZ2?=
 =?utf-8?B?WVpHN0NmclhheGkwWWtVclpUanlGZWROcTZlQTN6T3o0M2k3dU11RFZ6VlFO?=
 =?utf-8?B?MzRkSEo2V3ZUSW0xR2ZHV3BGRXoxalpTMlkzblZKdjhQL1RuV09aWENpUkZy?=
 =?utf-8?B?aDlOL0dFUk4wamNEZStERERPSXo1Si9Uall0ckd0RGVORm5ZVUtna3hDZzJN?=
 =?utf-8?B?dEtMRkN1L2ZsQ2lGeHFkQk9heVZtRms3MEhvcG5TVzB5ZXVmenZIbUdBYUUw?=
 =?utf-8?B?OHArYktwVzJJVUhOMWZ3NWFpMUlKRHpYVjJ1elpEWncrT2Q4bnJkSmxEM1p6?=
 =?utf-8?B?aEZFK3dod1Y2b3BzbTNyMkRlczlGcUI2M0VEWlpyWGVBS2JmOVR4aUN1d0Zr?=
 =?utf-8?B?bHpOY0dqbUJ5eVJPNldwSGVlTHhhV2NCVlRHbzRlNWFGWWswMFN4NjBjT3di?=
 =?utf-8?Q?1PJ8is0ao3cnNtAC8FreCXvwJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be109e0-88f3-48c3-793b-08db7437d580
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:18:55.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4C5CTUNk1NLDgNtjfhottgEJ418PVEP3BdNZRPvnc+8GRvr6V/9pXCYONbmWX7hHHREKZU5m6Lcjwx0og4LKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5430
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 13:55, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> AER corrected and uncorrectable internal errors (CIE/UIE) are masked
> in their corresponding mask registers per default once in power-up
> state. [1][2] Enable internal errors for RCECs to receive CXL
> downstream port errors of Restricted CXL Hosts (RCHs).
> 
> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
> [2] PCIe Base Spec r6.0, 7.8.4.3 Uncorrectable Error Mask Register,
>      7.8.4.6 Correctable Error Mask Register
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/pci/pcie/aer.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c354ca5e8f2b..916fbca95e53 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -948,6 +948,30 @@ static bool find_source_device(struct pci_dev *parent,
>   
>   #ifdef CONFIG_PCIEAER_CXL
>   
> +/**
> + * pci_aer_unmask_internal_errors - unmask internal errors
> + * @dev: pointer to the pcie_dev data structure
> + *
> + * Unmasks internal errors in the Uncorrectable and Correctable Error
> + * Mask registers.
> + *
> + * Note: AER must be enabled and supported by the device which must be
> + * checked in advance, e.g. with pcie_aer_is_native().
> + */
> +static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 mask;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
> +	mask &= ~PCI_ERR_UNC_INTN;
> +	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
> +	mask &= ~PCI_ERR_COR_INTERNAL;
> +	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> +}
> +
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>   {
>   	/*
> @@ -1027,7 +1051,39 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>   }
>   
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	bool *handles_cxl = data;
> +
> +	if (!*handles_cxl)
> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +
> +	/* Non-zero terminates iteration */
> +	return *handles_cxl;
> +}
> +
> +static bool handles_cxl_errors(struct pci_dev *rcec)
> +{
> +	bool handles_cxl = false;
> +
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(rcec))
> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +
> +	return handles_cxl;
> +}
> +
> +static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +{
> +	if (!handles_cxl_errors(rcec))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(rcec);
> +	pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> +
>   #else
> +static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>   static inline void cxl_rch_handle_error(struct pci_dev *dev,
>   					struct aer_err_info *info) { }
>   #endif
> @@ -1428,6 +1484,7 @@ static int aer_probe(struct pcie_device *dev)
>   		return status;
>   	}
>   
> +	cxl_rch_enable_rcec(port);
>   	aer_enable_rootport(rpc);
>   	pci_info(port, "enabled with IRQ %d\n", dev->irq);
>   	return 0;
