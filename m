Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC773C3C9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjFWWJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjFWWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:09:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0B126BB;
        Fri, 23 Jun 2023 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687558139; x=1719094139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/AL/LTlZLylP2OITNoUD3+4dQnEHAgFTnFHPYvFS2q0=;
  b=QyUcJTFlzQF600e670tBHrJMwdLHhGwulHoqTe1Q42CgoSkCTgut7iVO
   MPfVg7+aW7Wk34DZeS4yjZYQJ3nW012iKcw6Gjie/OoCKy96J7CMwGawB
   hvqGtUyKRe4GwE3AOKhGky9FMZFhMELhuxBlZWtVnOnIpqq147SoYIf4u
   4zTc6xNpsESDzJw9mkfGhZV/NJqvZ+c3C7JpFe2quosYt3ZtcZa2cL2bo
   zbbgfFKcbr/3iUchaLVO2WlvdA1zDl5MgkveOSv5VD9sUbirPJPXtZKPP
   GXPWXyw42MQW83ZuePEbnfmafmaN+ghrF+3HEwdzHY/59wBsHL+Semeg6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="364317294"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="364317294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="785491395"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="785491395"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 15:08:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:08:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 15:08:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSATgeobvuy77pBimevuHVG1SsATRJMxQkeEhlKvBCqpgX2qJKhztKCt6kReAP9oGsPg90tpfNQsR2yxCmcH1Y/n84HtcbIwgBJ7cZWvxINCJwS+J707FujuL6JvFNno/wZvJorz4q0/XTitmfR3tJI+6FJ225dyAB9vfFZh9FLOCknTfrnZYcYT8sPMU+Y7ZUha3BPOdqxfgad4oaT56gSeNNKxCrwiQY2ozgarWCSA4MIDaUQgXlaT3npKcZrkG6X5kRX+TqHgaOGp7tA6p7pZdMrWzroiNbX/TdywU04u10loSkpJsLkl7fPGBT+Mhwy0zUA7PlWV9vZxReJSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY0vF4M4paD4IgxUMOXdSytXJdPRUcRjwxNlp7IY1Bk=;
 b=S2EoX8QzuVPWp+8lfylIXVrJ59VUDmnuNVGadPbda91Uj/bSnVQZVwtGzcI7Ruyyd0uFEe04LxE4zytKBDht5vkoZmj1yJDc/zpklqrSHSYzeZHYyDhwoFoEPkQOc876pEwk29+npJ+9oy/Ewx9YXvMkg0agQV0AzCVr85bnolKnWYSdrVmdPvQ0zwOOiS9dzIDTiyfcM/zYmK1GAr49i/fGLUIArp64G+/1lm2dDbnXjeBTxpzJ1LdGOaPz3rChxrmoEOhsOVTqHR/F23+pKPTxFQhP1pSc5CAGrgodvdoFv4u5s0+VUHZGIXiyoMcBIPVva33+D1BnuxSzrgiupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Fri, 23 Jun
 2023 22:08:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:08:55 +0000
Message-ID: <fc4dc234-6d66-4ad8-0c6f-3f0b0119087e@intel.com>
Date:   Fri, 23 Jun 2023 15:08:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 24/27] cxl/pci: Disable root port interrupts in RCH
 mode
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-25-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-25-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a052e4-026b-4c3e-b34c-08db74366f5f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYhp4w0uOX9y6RKUI4gHe76d+ltTzsk338JZqr80Jj71L6in21d+sj4MZ5mipe2SuhccgGBCdMAT0i6pVFvqqilzT1gjRdycTWDA9q3HY7UtNZ63jhnsVcHKc4uO7U7nkFK7inl3+Xz3UW9wUL3m9NsjdDxcqFXUhThH2q0ao/9ygpZWZlWMOEfgh3XRa7+jE/j+cs0/zZ5ufGhRLTHXAe+DlSBdFPQWzIU5AhHyTCHPefIo8M+mo3q+rZcGXZzv/zlBe5yI/Brdent26BmIueqbPRkAsGsGu7pB3ZcZ1e70GtPweR0sEl/atWFM5SJ/Wj4bkFHq0z6y+SaUlNi8VfFc5NirX/0TmDOo+m/Y6aPFut9kHxy/1UMYRgTdsWSI0UAoslx+7a5gdN01ZkCzK6y21SCAGqIJMBg4zceFEo3y0x789MWyqAwAG3vy8FPaMDoBwO/Mp/i7QUcppix89JeuZC0roPwyPLVqj8wOO92Gx4aMyYZUtDrSHURWLFbnUxLBWUIAxt54jpskgDq5pX9ALmVAe1fFkEdjM643E/+2bEQKWgIw81V++mEYlkC3hqBAI27uOL7nblnCWjt53fEXWFr1Pu0woM17DjEmKUnOl8FxXYUgSvFvB3fI0fg+u7pPNW+PC+CBthwqxCrWfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199021)(2906002)(6512007)(5660300002)(44832011)(66476007)(41300700001)(4326008)(31686004)(66946007)(66556008)(6506007)(186003)(8676002)(6486002)(53546011)(8936002)(26005)(2616005)(83380400001)(478600001)(316002)(82960400001)(38100700002)(6666004)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZpeENTR0hYT1UzNGk0dWk3ZlE2bzUxUXc5NXlIN0JmSE93TWpIUFJZZ1Z5?=
 =?utf-8?B?Q0tsbUh3SlUxeDVhUEVQQXpLRk52c2tPblQvaU1pVmc3ZG5PSGhMYkFNbVZT?=
 =?utf-8?B?M1UxWFpHcFBkd2lwNnZpRzJkaGxMb0RBQ2VjaXB1Q2Vab3RIS2xhTHdGRHNV?=
 =?utf-8?B?TVdzOHZXOWQ1YUVmOEg3VnF3OWlib2IrSE1nNnMyZW50R2tCSkRGUFk1MkNy?=
 =?utf-8?B?emd6bmZYeXZFQ2J4WEpKa2Y0Vzg1M1IyUTIrQ2hiamIyZlpMNlljWkc5Z1Vm?=
 =?utf-8?B?b2FZbGpQUGpBSFVCTEFISEdSMElvYUF6UTlyMitOTmtQaFhSUEJJRHhXaTR6?=
 =?utf-8?B?ak5HTHllYXdTS2V4eDdVMG1ZeDJKU3BsRjd5MjZJdlZSZTZzRGg5clU0NUhK?=
 =?utf-8?B?aVIrRmhxcEZ6djdNQmpjQ0kvdVc1OWVOTDhIbmw2UjJoSlpJVVprTGM1aHk0?=
 =?utf-8?B?eDVwNldnYllGdnJ6cVpkOStXYmpZUHRmclJ5dzkxdXVQQTQvZ1dzSDRNdEh5?=
 =?utf-8?B?K0VqaUlkRkZET3AvMzhzcVhqWHM4NGZLdFpxK21WN2FZcmxXOER3QVRtOS9E?=
 =?utf-8?B?K0cxSHFEV2JadzFiaCtrUFg4ZWVwc2MrQzZnM2JENzJHNWNlRURhY3pNSXh6?=
 =?utf-8?B?bjl4TEsvMmw0OXlJRlRlWVhEK3BmcFBPOUlmUVgrSkZJNEd3dm5ocDlVL1M4?=
 =?utf-8?B?ckZ6cUsvdVdad1puTXVqbW1rMGNLMFRYSUNHdS82MkxVQmdKeGZPNzR5bFU3?=
 =?utf-8?B?RjNxZDZvMUR4TWtPUTZ6enhHNW5KTUlFY05tOEp2b1NYa2JHdWVtWUw3MExL?=
 =?utf-8?B?Z08yUjhkbnNEOEdkZ0NuTEQycjFkSy9YM2grMVErWU0vYytIWW5McUhXaGJt?=
 =?utf-8?B?RzdYWGtVYzRCSGZpRE1McE4xOXlGRVFMbXZ0WWdEM0RmcmFMWWFpSStiRlRw?=
 =?utf-8?B?REFXTjRoQUFoZUNKVUJpUlBNejlBL0h1QlozdnVNU0wzVTNTcUFsNFFGN0FY?=
 =?utf-8?B?WnBOcjgzZ2FKMEZ4OFZZN0Z4UVZSNWFtUUFQUTM0cXZXSnkzQ3oyd2l5bjcz?=
 =?utf-8?B?cHhOUkQ5ZjQ2dmJYNXM5czlpcndldmRha3NJZjByR0NrQ2tjUWExdnhnY1ls?=
 =?utf-8?B?ZUZDbTJsRXZaSFNtZzBMSXZsakRacU5PNDdYSGFNZHVlRzZYNUN6VjI3WUZ5?=
 =?utf-8?B?YkRERGxwclFmc213MEtRL3N6U1hCdTMxN2diUWsxY0RjWG1nb01aNnhDY2JN?=
 =?utf-8?B?Y0JDU1FidDdycThIbVRnSFF1T2JncjhqWlRvbC8xOWZWaStuNklhUkVaNkp1?=
 =?utf-8?B?RkFNMHVJb2JzZWUzZGNRSHZQNUVZTmRTWFZ1eG9QbFR6WExxSGZnTWxLR0l4?=
 =?utf-8?B?cTYwK3dHNnJxTHRvQnFXVEtUNkZQSU5Rc1p2TERia1lSWG9GRC93ZGpWMkND?=
 =?utf-8?B?WHMzODN1czFVWXNDZzR6WTk3YkJkdGVCVTNiTFFWMFdLZzRuemtjT09tdmFB?=
 =?utf-8?B?eS80NUFWL1RaTTlQQnYzOWRrdHpQbGI1eUxUSUVpVndOaVhRbUxXYWlTejJL?=
 =?utf-8?B?b2wxMmNxMTN0ZXpORXNZaVM1Q0QxaGtsU0lMS1c0UTE3MGJHK2w1TkRBWjZ1?=
 =?utf-8?B?cjFaeldWZmpTTGNDTkNOc1BBMHZWOGNtVGVpRlhQNThvQ0J3TlRKc1hwRE13?=
 =?utf-8?B?K1o3RzRwaVFPNjM0cGN1b0o2ckRsNm5rSXFhWko0M01EczZsL1FyS3dZTW5G?=
 =?utf-8?B?QlhTbFBsM1dqb3plRDdlR3RCOStiODlva01pV1l2eDZyZGVmMjlhckFuc09k?=
 =?utf-8?B?aTBEbERLVS94eFNaQUtMVnk3dk0rOXNJZURiSVIrR3pHdVpUQmlSN29jU1Rl?=
 =?utf-8?B?UkRqWUwreWI4a3hrc2JiaGZXcUhRYVQxaG9hZDVsZFBJRi9wSnhsNUFNY1Rj?=
 =?utf-8?B?R0k0Y0h5eEczOHBUMjArZ2d6Y0J6UnA0b0dsWUFDVElKYjFJY3hDaU01OU9I?=
 =?utf-8?B?T0FZREROSmNQMllUTE1uVnRyWElXS3pOYVIvRWxoNFdsOWtnckQxdENpb0Ra?=
 =?utf-8?B?K0pDaVdjbkZWem5vL1Vac0ptZllFRXFERjJRVm1Rd2NteFlSMUVRcnFoQ3Uz?=
 =?utf-8?B?djJZVGlHTmx4TlRka2FXbGZMVDBYcDBoWFhrN2V0bFlscjJVRW83TUJoeW1O?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a052e4-026b-4c3e-b34c-08db74366f5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:08:55.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rV4C3HmcZUDN7VCfY5+RhfdfJ1Yfl8yeemx4YC5fFCT5UsCvznxP1svDDKiYvwIxmpxiNnycnl22Swar/1OaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
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
> The RCH root port contains root command AER registers that should not be
> enabled.[1] Disable these to prevent root port interrupts.
> 
> [1] CXL 3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/core.h |  6 ++++++
>   drivers/cxl/core/pci.c  | 29 +++++++++++++++++++++++++++++
>   drivers/cxl/core/port.c |  3 +++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 87467c633123..880bac9db376 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -86,4 +86,10 @@ enum cxl_poison_trace_type {
>   	CXL_POISON_TRACE_CLEAR,
>   };
>   
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport);
> +#else
> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { };
> +#endif
> +
>   #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9e0eba5ccfc4..897830c19d1a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -838,6 +838,35 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>   		cxl_handle_rdport_ras(cxlds, dport);
>   }
>   
> +void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	struct pci_host_bridge *bridge;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	bridge = to_pci_host_bridge(dport->dport_dev);
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	if (bridge->native_cxl_error) {
> +		aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +				PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +				PCI_ERR_ROOT_CMD_FATAL_EN);
> +		aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +		aer_cmd &= ~aer_cmd_mask;
> +		writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +	}
> +}
> +
>   #else
>   static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>   #endif
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index a92794e6b7b4..2fdfb31f16c1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1037,6 +1037,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   
>   	cxl_dport_map_regs(dport);
>   
> +	if (dport->rch)
> +		cxl_disable_rch_root_ints(dport);
> +
>   	cond_cxl_root_lock(port);
>   	rc = add_dport(port, dport);
>   	cond_cxl_root_unlock(port);
