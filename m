Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6176F8CC7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjEEXZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjEEXZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:25:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D46435A2;
        Fri,  5 May 2023 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683329113; x=1714865113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/iGX1dlD6HSraL28mwZhfnbHJduONiYMTk+Bjsi3Oo=;
  b=S/ZTL5T7pZ5bDPmi8xfCiQ2dihOikLb8hQKm+kqFI6QM3G1znGIUuGqz
   mImeTPQfj0eBbRUGJ0fdcbx+Qki0tVVF3fTpZEjwGsrVCTbwPpVtyV8cz
   FXySWI7SjP75zU6b9z/BXEVxVpt7l0buI5pDjF9Z2QtlAnUflT+W8JunL
   e6KQlXuDYMKJqAKtWCglvtxIH4R5idqkK/SwiFI+j3WJ/22INvOkNjeQf
   mjlStCbQpB4bY86vwWLQ9fr0xgKCLulPKmtDqw8UaUeyevr2qzla3pJqf
   Y9zxQb3moBXFLdHftB9Dk9ONggo8b0PAik8Als4tpaBkH6Gu21uQ3/5bU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="328938457"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="328938457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841958942"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841958942"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 05 May 2023 16:25:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:25:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:25:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKOfyhHScYdcUs/KAxl2K3Y8hj11w6o3C5xLbKHQaEjb0QFI1HaHV649DkOQYSGTVHr63pTZDfo7oj8sKiinLUqqxR4Krstfv6U8bLAFmuCPkPWu9klHe4M9f9qhZcs5z2i+FKyA4Lzn3zCXUiMln6vBQxQF8Ycc5k32d0FUqUSnQZ9zHI9CU+avhaiUrx9n9JfwcAHel+C0QsuZ1gT05CBPx6rNQk+jeJjj9ikPb7noNX2kmF6t6sWKKZzU5//EoM1AE701Hc8ufnKSXF1mDy642fE4RFn+W7di6aNxIGWUm6kRhk+XfyEFRRQNc69mbLpZHU6ThftiuBUwAUHqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV2wcjDV8by3241tG807T5eNbPE9UoCpv+GsrIbnAfc=;
 b=QT7tqQdf/Kr4FG2OHtZL9Mbbz+aSCagAJhEla50Uy+fUeu4uU/aDXM46zcRo5X0OxvWEwdwwMKKj6DlR4hiApiqJFwC7uf5rOXs8CN0gKnU8vBuRHgNW68RJA1a+NYhXy+HL7Q3CSyunq7JnPCL9Rqro4vIrErAoHOzgr9ibrZQ5Wd0OzcLEYSGDC4bIOkxmF3pqYjojVpvwOE3SH98VC02p1lHXE5Ctt7UFc7KAI/yOIb4CwmzDI7gr0oz+bKVJrDo6pfA6KSVsZAHwiVW+DTPEqwaZDHUYtzOAPgWM/+mTKcijUDyT/WYiyBJipFZ69a3LEoze3s+/8tKRpsW0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:25:09 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:25:09 +0000
Message-ID: <c7c9d854-66ac-4998-b2c2-43c5a26cc431@intel.com>
Date:   Fri, 5 May 2023 16:25:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
 <1cec24f4-e4b1-682a-3ada-b51d2a7c83a4@intel.com>
 <88de8b87-6bcc-4794-5e20-cd7ef9891ede@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <88de8b87-6bcc-4794-5e20-cd7ef9891ede@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0059.prod.exchangelabs.com (2603:10b6:a03:94::36)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 75757a79-530e-4452-610f-08db4dbff7ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LuACkWCS0u5bF3WtExuYs3nVs+3jkX8roDJdzkKUC2noKDbeoPjsu3tvCwe+C6BOsX6Ke2dI91C42Zd4hqa3jEjoTxBuUrxID5Wu1aTY+1aQxsaXBOMRLGU/0PUAOPSfxbPWlEYHzZyMN65Hk2Cxs/vTxy/h7aDk3aH/vf6jVZ7LKzmH/mXDl8t9UjjAJW782gmSwZ00ZORa9SUUMW+KfUeETDzBGjE2S6NKZ6sQN/8DKhYc65QghAjm6C6CzWkKg5sKcHt41DEh9e3fvgr3PlcQvfpTkeGe+LTcltaEZMArqeBa3VaQuvswNLNkBylUVJH4HG/dDw5SWE7JT325TdxY/v8I95kRE9KK1UAO5KO5ZQRWu8RU2NWXmEQ4gt+whQAvp42etAD/4xTo9P3nXnrn1hLB+JKuZXU4E9fkKMIdAL0gS0n3QZAXNuq9LZW8sDqIgTTVRLBjgXLV5hlXZ4RgSaMbb8DwfsDBov5emFdPKebtmL/OXW2XHjVFVIIogvlLUvPVaxZDdOmN6dPvC0rk4DMkFDRukarx9y2pzYTk48l7QfnDOc4YwjgYnvyB0eATnL1eE7DFIpbEUX7hMPhNTAB43+o36vh9c3k1Zsa5zgHkrdHoCtgEguxr0YU2Ge2Xb4weRndpL3rwJba8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(83380400001)(36756003)(6486002)(6666004)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4326008)(38100700002)(7416002)(7406005)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWw2b3JjSzJleXJDMFBDbnVMZFNpTDJmSUFPeXZzdTlQZjNFZUtHVjdSYnMr?=
 =?utf-8?B?T3FPWDZuc3lTZnRueEFYTE5pcVRsQlFoVFZuWW9hQXd2dk9JOGthLzE4cDB0?=
 =?utf-8?B?UWZDU041M0UwV2ZpOGRuZ2NPWGtWSTZUK0pnaFB5cmJpVm0zUXdEQ2ZyNFZ0?=
 =?utf-8?B?SStGR3RNRFFJN0MxeGhObENGdVJmMHdkS1lRbnYzaVllTlZpMlYvRTVvZENP?=
 =?utf-8?B?MkdOT01jenRTL0dyRUVpRTM0aTFHUUViT0tETUIwOWZ5RzJDSmQ2OE5NQVFi?=
 =?utf-8?B?VGtUVEd4YS9EeWFjLzBvclpBQ2ZNeHdWbkYzaERYbkNLMngrRmhSRFVqeXRp?=
 =?utf-8?B?QzNmcmZ3NEdEUGp3Y1JhTWVWdWd3c29uYk1YdzRJVFBjRC9RT3NocWdYelFQ?=
 =?utf-8?B?Z2VYVENodFdlN0F4QzE2MWhmUVQ4SzY5d2ZzcDFsTFIyOWJsSnFIbVo1RVov?=
 =?utf-8?B?T0h3OHdKV1dQMElxZTlOc2pORnVJa0RGMEx0aTlndGJpTENiRXlwRU9NMm52?=
 =?utf-8?B?eG1kdk1nZi9QTU1ORnMzTW5UQlFyR0M5REVlVXhQQ2FUSTRpWWQ3VzNHdVQ5?=
 =?utf-8?B?S3d4bHZySmNVb2ZZZHFjcWFPa2p3T3E4a0grNUJPM1hSbUNrYTNyODMwZ3F4?=
 =?utf-8?B?V3pwVEhVSjNxRGgyQVlNaUFmM3dxUUJNTTN4T0hwdjkxbU9nRDZ6Uk5LcVY5?=
 =?utf-8?B?VXg4SkY0YzZ3OEZya29hSjJHTDhYOFpGK0NWL1dqUzZnNW44RVRGN21IZ3l0?=
 =?utf-8?B?T3dLbUpYRWhVeDB1aFlFMkNKVHMzcUd6SHZPYnVoSlNPZlJ2Y0pBYXMwYnND?=
 =?utf-8?B?ZXF0bzZESUxxL012MmxrVjBwQUR2dUVsd2Jodi81L09DQVhMNmV6a3VaV3Ez?=
 =?utf-8?B?SGNqWHVUN2RMbFhQZlV2VkJtSU16alZmcllja2VUakJRUXR3aloweDVWVlR3?=
 =?utf-8?B?bVlvSVpHZnArczBOZnNQOVY5Z0d5S1V3TmxUVjN2T2x3clNnc3dFQ2ZYdW05?=
 =?utf-8?B?VThqUWJweWQ5M2psdXFzK0xLY3h4eGVsbzkvSWxyYXBZSE9aVkhBUFpHMyt0?=
 =?utf-8?B?RlFyNEhjR1dmRWduMzNRaGVxTnRrSnY1N0lUNmsyZ2lZaTEwV3VvYVdhT3Nv?=
 =?utf-8?B?MHpRd29RNW8vWGhPR2tWSnh1T1pZYWNxSnkrdzFFdks5ckRNWDN2ZGlUWUJG?=
 =?utf-8?B?ZitnQ2htVFU5YkpZZFV5cXBGRUl6dmUwcTNDMi9mMlhCZ1NITHZXNVdzdFF1?=
 =?utf-8?B?b0liSEZ4azFxSExRVy83bDNMbjEvNUlGSnNzN00rdlE5MzZ1M09DemtycmhP?=
 =?utf-8?B?ZVBkUFVCM1h1MU9hUW91UTBCdXhLV0RrM1Y2MVVsd1ZUS0FRTWhvWHVTS2cy?=
 =?utf-8?B?SnE0RzNzK1RNaDhlcHNTNHNuQitzV0pTVmdFb283MmZ3YjFid1doSGp6dnJ3?=
 =?utf-8?B?QWkweWhySHJGSVNvSUZXYzBLTVpzRml4anZRTi9ubHlIOWllNCtxUFhZZU96?=
 =?utf-8?B?MVJ1bDFUK1gyNmRhSE5FS1hWMCt5N2dQMnNPZnI3clVQaWNPRWZKL0M2N2h6?=
 =?utf-8?B?NWUzaHVrVXNpSzh0UU9QZ3FFTW1iNXlJRWxUMjBmem9Cc1FUejFtRkprWHZq?=
 =?utf-8?B?MWxPNXVKWHNXT2IwS1E3dGltUXdKejFTMVBCZ0hvNENpd2c5UllaQzRjSktU?=
 =?utf-8?B?cHhaVThIcVo5bFdBSzQ0TjlQWFVBSXVycE96K2RsQTN0dFRpUGZXMWtVUUc5?=
 =?utf-8?B?c05NN3huM1pycWluSXhoWlpyVktOMXlzVlI0WUlFeTJZV0ZYOHhGRk1ScnFj?=
 =?utf-8?B?dUYwRVd1bnZJYXJyd2pwbmVJZDhvY0hvSFFPRCt3SGlPS3ZvdERRUHFJNytT?=
 =?utf-8?B?dmF4M2lmMVE3VlhaMkJKOUpIbnlPbXlwQ21MVU5qTXZKbGI3OEx1WmkzWkNT?=
 =?utf-8?B?NHFQMXFuZ1hHUmoyeVNIYnJvVUExTG1VcFlNTSttSzNveVcrK1BNdXNjWDFG?=
 =?utf-8?B?d29KZWdNUmlQOUs2cHVISTlrM0E5N25QNW92QzRnckladnhoQzQvVmRWVlFX?=
 =?utf-8?B?MndjVElvZHZGRkNGbXpaS2NSaGFmR01QR2o2T29BZ2VLZFlBREd0UWNLWmFq?=
 =?utf-8?B?Yjg0eGZVakprRnY5L2lHYlJJSzJ0TnRnbWlMM2hmZmhnblY1WWJDVVZkU2lK?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75757a79-530e-4452-610f-08db4dbff7ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:25:09.3595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVb+9us3qXVpGqb+semxySwX/aGxLM80OeGBkWCP8AuD2i52kJ+lOXelbbGhiFoNZaS5wjjWHDoMdWv1dGRrXb2In4fdW038BQYShIFDm5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 2:45 PM, Moger, Babu wrote:
> On 5/4/2023 2:04 PM, Reinette Chatre wrote:

Thank you for trimming the header in replies.

>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>> When a user creates a control or monitor group, the CLOSID or RMID
>>> are not visible to the user. It can help to debug the issues in some
>>> cases. There are only available with "-o debug" option.
>> Please see: Documentation/process/maintainer-tip.rst
>>
>> "It's also useful to structure the changelog into several paragraphs and not
>> lump everything together into a single one. A good structure is to explain
>> the context, the problem and the solution in separate paragraphs and this
>> order."
> ok Sure.
>>> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups
>> Please highlight that CLOSID and RMID are x86 concepts.
> ok Sure.
>>
>>> display in resctrl interface.
>>> $cat /sys/fs/resctrl/clos1/clos_hw_id
>>> 1
>> This example does not match what the patch does (clos_hw_id -> ctrl_hw_id).
> My bad. Will fix it.
>> I also think this change would be more palatable (to non x86 audience) if
>> the example resource group has a generic (non-x86 concept) name.
> 
> ok. In this example the clos1 name sounds x86 specific. I can change it to ctrl_grp1. Hope this is what you meant.

Yes, that is what I meant. ctrl_grp1 sounds good.

Thank you

Reinette

