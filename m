Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69E773C365
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFWV6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFWV6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:58:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6626AD;
        Fri, 23 Jun 2023 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687557522; x=1719093522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8p9UY4QhIBP1fVkqMlg978PuABsm1qYu1NjOBq6+yz4=;
  b=bRFvFYuFH8z9QTTdXRZcIM1llp2oP2Gul5Wj8J36XKVef1P/7rwSFFtb
   vLXOQWApf1e20GVEYGsUlOVOO2S7YbVFQKYxjEcu5+ARGcYq3s0vngZkY
   H9XXTXN6jTcXgM/z2bnlszz8g64zHrd0NKaw9jZ/6IDPC9zWWcux5qJcR
   H/EME44/nOxDHP2QYLLoBzpjXwC01pEUJ+6joXiWkFZsrx+A4XRqnYp+G
   xao/dKOe0Gwo8di4wnYdmcuWrSpqcwGgwIhWNDanlOuORFlPLN8Oz+HIs
   Lq0CHm52Jq/BGl72YmU/tCs2c5rEtaDEJIdJfj8c/+GhqnH3V7B4DKP8L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="424553175"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="424553175"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 14:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="715450842"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="715450842"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 23 Jun 2023 14:58:41 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 14:58:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 14:58:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 14:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxHpwaaONdCyha6EiMHf9wp4eVZ3RXDUWaJWnOaA3iBROPtJL1gLtbcbPP4GOKZEomm/wdfU1XDhHlG46ZMQmyqA/y/X/BNqlhy46dAtmYWbfMLJ5aQUOJz5YtQu/Kdjh4lr02D2uSUJOJIIbXcXEDhroJZr/Ptw52EsmvJczCk3fHDRQtSsXb1mPPxlsLpkmJAzf5g0/w0L+EEyKHugtqe5kBXJfOqGbMQwVq39x05hv4EOb6IjuKtv+XxVWwXWP6N+rA4P7XmRJU2mAYLSX9Dq2Si5g44GUlFusgA4kLsbkfSwfh7IwZgvBgmS+imvnRlz8LczIb1FhM9icpe+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXvyL/stDH5wIo+dFHTn8Bd1H8+wlJXV6j22968L+NU=;
 b=Lg0nQI3SdXI2CMwgpqsLUGCqB7+76gVrJQ5YsH+lU/lORBSXU48xuT5K+RCrHU4XGiQltT4cknJflKMEj7yHINeW0HzoPQGXBAXeZymBD6bzVxmKp3K2PcAS+EFEZldo3PQD5FV/dpbKnN0d9X8fnGGTm4oAa8vTjfmNGhEbGot4Kd4gwxqEbc6T5lJrAcY/nK7f2DntOWnRHqPRXUbtHetXNmjLm6WTBtmLXroBHAAtU1/Z+nm6N1ZrvHbcxZj4m56/mS9lTaE79fgxsHP/x+rlw1EJ3XCadxFm4/ccCPVv/fLNsIi4wpeZHD0hqZtiPAplT5xhlU9Eb7dWfHEdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB8065.namprd11.prod.outlook.com (2603:10b6:806:2de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 23 Jun
 2023 21:58:38 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 21:58:38 +0000
Message-ID: <b8baeeea-6b2e-5047-8ba6-dc575a0a4949@intel.com>
Date:   Fri, 23 Jun 2023 14:58:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 22/27] cxl/pci: Map RCH downstream AER registers for
 logging protocol errors
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-23-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-23-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 661e67a3-5b6d-4f23-144d-08db7434ffaa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrxdxSZnvriYFg+dQQW80e4mU+bLzVQ4gz2DbQbWs4R7NyesA3XMUOElfSMm5bORfa/CkM3STcJsX39+RPatrULJam1qXFlqdlXnqCJ7/rxhMJKcxg92mihwH/FF2nKrGGEAUBzB8Tt15lZ/CjLRs7IUHwNUqWK88VI/tyWm/8PkMfcn9ApLi6e52UNA1EOWyyhUOe9KzamCvxFkwXIBl5k0R6gWAiut69uP3li8flRS+xARkOcRroXHRV1huD7h8N+itRSnMbpqSD8UVuadZ7e0nlj1l+j4uGlB/kcC1qIh7Zl3ahs+vlGqLysOUUHTdc/4wS1UzhsB5O7NPD0RFxYxCJLlbbAzMmOiHVuMcahUZrZpQCmmeXEZ1i0sZBsoLGagJR1lMJkv8xK/M83jho7NVWPSH0F77XAszndWWefUNWzTyNYDBtmUzhcfT6QUx8jhcDTGpGsFEeXmpEc+KZdXgUL0ZdfCGcvkx11twJF1eeont6aE+AHySuh9RG1vTaGCwEVHndGuYEJKa22Ma5UVlq2tEju+zp3nZoIQ7u9XuXjV+EboISjO4BnRCE+SANW1AuM/pxqgBvWq4+uX/egJL7/aJqT+5tyYjXvcPKpldkVPwcBE99Zd+AKFd+qLM/t/enLxldEzx0ZmYXJv6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(44832011)(38100700002)(31696002)(31686004)(86362001)(8676002)(5660300002)(82960400001)(41300700001)(8936002)(316002)(4326008)(66476007)(66946007)(66556008)(2616005)(83380400001)(53546011)(186003)(6506007)(6512007)(478600001)(36756003)(26005)(6486002)(2906002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXZSWnJQckxWQW1NbmpXdkpSakx3TjRDcTNkVWpGaThSMzdjYVFlTjQyS2l6?=
 =?utf-8?B?Z09pdDVzYTBxbWRtNUN0ZW15Q3drdU4xY3IvVFlNNmhNemVmSWp5RzdLVUdS?=
 =?utf-8?B?VWl0SG9KWC9GMjVnRDlld1lzV2JpYzhNNGVIejg5UlpIVDc1aEhSS2JQZTdl?=
 =?utf-8?B?NHh0TDJKMHlFNzhqdUwxSDNVMVo4Rncrb1p5ZVJZdE8ybEFlZEtiOWdUdHpL?=
 =?utf-8?B?eXpiL2VpV3JjemU2WFhaemdmZ0VNWUhDcFFPdDhZMkN5djFBd01YRnI4aVBD?=
 =?utf-8?B?WFVWTGd2SUhxTUYyUFZtQ2VxRHVqSDJBM2FuWjlwOVRSUXRPdzFHT2QrNnRH?=
 =?utf-8?B?SzZoM3BwaS9ZdTkvanNzQ1NvTDkzengrK2o1dWNXQ1lnOTJFQUIyOUZpTk1y?=
 =?utf-8?B?QjBDK3hDZGhZVWIzRmRvSVVoN2tVZ3dEL3pVVzdKTjA4Umk2cmp4bmJPd2ds?=
 =?utf-8?B?enZEc1lmRGs2Yk02cDdKaWxlWEFOMURqSlRpSHlhcU5QZTNmNGI2YUgwREpK?=
 =?utf-8?B?UjU4RzltVnBKSWZHK0tZMEJ2UUVNUjl0NlAxcm1jSldoaFgzOURXcFpSRnNT?=
 =?utf-8?B?NlF6UkY0T2taNHgvZ2tTQkdZUkUrdk50MFY1MlNjT0wycFhWRzFLWkFRM05L?=
 =?utf-8?B?Y0RvTEpOMDVLbVZMc2JqbXpoZGlUWm5lK0JwKzB0U2xZdmN3VXVTV2I3UCtD?=
 =?utf-8?B?aC9TZnhQWDJIaGgzYXhSbHV0L0xoKy94M3I0dGl2T2FyMU0ydURFNkZjOFNt?=
 =?utf-8?B?aDJEalo4alRGd21xa2w1MHYwME9Eck1Xa3V0TFQyRTFINVhqK3FKUmpoUUpu?=
 =?utf-8?B?bEU2bWQ5TUltTml2TmkvZFRsMy91ZytNbUVtcktNcTV6bHJJRk1Rek1QTTdr?=
 =?utf-8?B?NU9yc0F4eCtYZ3J2VlhZN2F6V012NWdTNGJlQnJVdkNtUHk4c04xenJaSlZV?=
 =?utf-8?B?TVZQL08rZDFqWjMvSzZ5Z1Uvb29LZkNoYWxneDBBNmQ0YkVEYjZHaURqWkNk?=
 =?utf-8?B?RFBFY1BkZlBYRS9icGNZUU0wb3BqSlJWNTRsU1VoM04wTkZob1ZKS1gra2Vs?=
 =?utf-8?B?aGJsOEZIMUIyTHpWcCtieXVJSzF0K3pEV1RJcVBHY0VIb2orRGRTY1ZScnBx?=
 =?utf-8?B?YVBnZGV4SlhYWjFmTExFTXR3N0hMM2tCekVGWWdGQ0NiVXYrUXRvM1kvYWdr?=
 =?utf-8?B?N2MvZ2lEYUxMYXViYjI1WEkyd3NpSTBWY3B0S2QrenZiZHZGVFFJVGVxQ1pk?=
 =?utf-8?B?aU1BQ0dkUTA1dTFtMEZXZC9OeVJ5clYxc1dWUVRBcWk3NW41dnQvOTlvQzNC?=
 =?utf-8?B?YW1OdCtqMW5Kck5ObnN0NjRQY1IwNFZUZnBiZkJFS2I2Q2Z0MU9BQUdwYktn?=
 =?utf-8?B?V2xXOGN5MllVT3hjYnpzZUorbVREWkZrRGhhVytUY3FXWUlJK2p4ZzJDbzNu?=
 =?utf-8?B?VVRpYVZvLzdMOUgvY0xHUlJGMzNnUjBBM3VjU0FVbTJJM1R0SWJTeTN1SlZF?=
 =?utf-8?B?NFZ1UGNld2VGYXMzdkVJbXl0NXNmWnBlRElPRWplV1o4V0NZdGhEaHdUV3dH?=
 =?utf-8?B?bmJZdDdqeWJUK2h5bE1OR0FmY0xiTWUwdW1FRDE1OWdMSEJlaWRweGlRZTc2?=
 =?utf-8?B?ODVJalhra3hzdzcxMTcvb09jTmJ3NUtINlpuc3lsaEtJYjZUK296K0k2SDZq?=
 =?utf-8?B?cTBlbVNMRnB0d3FjamsraSsyVXY0bnpkcS90WUNVT2NsRjlSRkhQRTkreGVS?=
 =?utf-8?B?Y1NoUGMzdEZVdFBMNnRVd2RXVlVOVXBLZzlpdXpRcHNiMzdtdys4aHdoRk5p?=
 =?utf-8?B?cUNwWlh4Mjh3QWpCVEJxbkpmbHhjQlRNdStuZ1d5L0JxWS9EcmRDMVZySDho?=
 =?utf-8?B?STJCVU8zays0YUs2anNBYU1FVnY0UUhxVmZoaWxYRndjckJ0clRSQmxpOEQ1?=
 =?utf-8?B?UkJ1T2hvZUl6WjQ4SXlRQ0VjRVltZkNKYnhsc2d1N3pNZEEzUVYrZmxRR053?=
 =?utf-8?B?YzQ0UmJ1VTZpNzBIQ1FOR0pIVCtQSUxSa01MckdBTGY3bktXU1pVbEkrSHVs?=
 =?utf-8?B?VkdSak1WYTU2dTgzekZUcVdlZzltZmVJYkRRWXR3RUVMcUtqak10Uzd5VGdl?=
 =?utf-8?Q?lkkm97LMDythTHxCTiMTLcalU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e67a3-5b6d-4f23-144d-08db7434ffaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 21:58:38.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vldf/vLRZLsfdS5ONrArQEqBXYZjucWfE29E2412XMQi0H2WFCcnu/PqftubKbewS+E9Jp27mPVYpXgRDeW0ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8065
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 13:55, Terry Bowman wrote:
> The restricted CXL host (RCH) error handler will log protocol errors
> using AER and RAS status registers. The AER and RAS registers need
> to be virtually memory mapped before enabling interrupts. Update
> __devm_cxl_add_dport() to include RCH RAS and AER mapping.
> 
> Add 'struct cxl_regs' to 'struct cxl_dport' for saving a pointer to
> the RCH downstream port's AER and RAS registers.
> 
> Co-developed-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/port.c | 33 +++++++++++++++++++++++++++++++++
>   drivers/cxl/core/regs.c |  1 +
>   drivers/cxl/cxl.h       | 11 +++++++++++
>   3 files changed, 45 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 683f40e98119..a92794e6b7b4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -8,6 +8,7 @@
>   #include <linux/pci.h>
>   #include <linux/slab.h>
>   #include <linux/idr.h>
> +#include <linux/aer.h>
>   #include <cxlmem.h>
>   #include <cxlpci.h>
>   #include <cxl.h>
> @@ -945,6 +946,36 @@ static void cxl_dport_unlink(void *data)
>   	sysfs_remove_link(&port->dev.kobj, link_name);
>   }
>   
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	struct cxl_rcrb_info *ri = &dport->rcrb;
> +	struct cxl_port *port = dport->port;
> +	void __iomem *dport_aer = NULL;
> +	resource_size_t aer_phys;
> +
> +	if (dport->rch && ri->aer_cap) {
> +		aer_phys = ri->aer_cap + ri->base;
> +		dport_aer = devm_cxl_iomap_block(&port->dev, aer_phys,
> +				sizeof(struct aer_capability_regs));
> +	}
> +
> +	dport->regs.dport_aer = dport_aer;
> +}
> +
> +static void cxl_dport_map_regs(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->comp_map;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(map->dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dport->dport_dev, "Failed to map RAS capability.\n");
> +
> +	if (dport->rch)
> +		cxl_dport_map_rch_aer(dport);
> +}
> +
>   static struct cxl_dport *
>   __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		     int port_id, resource_size_t component_reg_phys,
> @@ -1004,6 +1035,8 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> +	cxl_dport_map_regs(dport);
> +
>   	cond_cxl_root_lock(port);
>   	rc = add_dport(port, dport);
>   	cond_cxl_root_unlock(port);
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 60b7ba7f4030..982ef79670c7 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>   
>   	return ret_val;
>   }
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>   
>   int cxl_map_component_regs(struct cxl_register_map *map,
>   			   struct cxl_component_regs *regs,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9f46a4e1fbec..12f11cf8e280 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -209,6 +209,13 @@ struct cxl_regs {
>   	struct_group_tagged(cxl_device_regs, device_regs,
>   		void __iomem *status, *mbox, *memdev;
>   	);
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
>   };
>   
>   struct cxl_reg_map {
> @@ -255,6 +262,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>   			      struct cxl_component_reg_map *map);
>   void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>   			   struct cxl_device_reg_map *map);
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>   int cxl_map_component_regs(struct cxl_register_map *map,
>   			   struct cxl_component_regs *regs,
>   			   unsigned long map_mask);
> @@ -598,6 +607,7 @@ struct cxl_rcrb_info {
>    * @rcrb: Data about the Root Complex Register Block layout
>    * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>    * @port: reference to cxl_port that contains this downstream port
> + * @regs: Dport parsed register blocks
>    */
>   struct cxl_dport {
>   	struct device *dport_dev;
> @@ -606,6 +616,7 @@ struct cxl_dport {
>   	struct cxl_rcrb_info rcrb;
>   	bool rch;
>   	struct cxl_port *port;
> +	struct cxl_regs regs;
>   };
>   
>   /**
