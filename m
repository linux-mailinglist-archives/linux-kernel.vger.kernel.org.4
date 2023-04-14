Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F906E286D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDNQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:36:19 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6CA19D;
        Fri, 14 Apr 2023 09:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0S9CK/DVYjb8Pnic3Da7pbkakPqSImJyuu7ud1xyZNt+rdsXpkF95ZjzEAjVNWOGDxgWI3KaRJEcope3lqy221fiT9C+whSvwnVhTDlH20g6sKPziPiAGna6si4ipL/V8A+r3bzwCcVfeAb1KT8RmfuostfKfpZNSqZ7VCMyMunG9DIK580xXD406R2bHxTCApFrf60q6QIyYwta/l3SAdeIN7iW/IiEX8GdVWEPlH3Kisyj0DGyHbxLJYGGGXiNuWMDJzP6xXM9bd6Ibt230YCAfwBMtC4mXt21ha3trQXzKS0X+YNHgf95IyO8meL52C29G3kdTQ6mJBPkj/66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QAhTWqvdAoPXqYGf+/vZaAtz72AMXbWNQelAgjVWR8=;
 b=AOLp1nwsXECsctgdAcj6gV9lJ9ySEehXst6EEdfpOI96lxd41I88KLoebzrFkg0AV9JqAxgpGbA1l0h7JWJGzSl/hPCYJbMTi4oxvHIQ/gm3czBUSZHv+DcCKDzG/HxMA7Va25K0DrAtkCxi6dl6iizG1VqX8RCVLvIdrTJr5d4jlZoHuyp5i0vVlGEwmfZbke13MDOqlHUxCwFmoYjQq+zH3i0MQt8S4cKNhHWsPRJSO64quGTT5jRbVPW8l7qGlRl1hbDWGmfYqMqclrgxhwyscwHxiU14V3wIsmNhB4A6o7jFQ1vZVPJSh2F8rLYDWjL6hi8Psw0MeCsCnijyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QAhTWqvdAoPXqYGf+/vZaAtz72AMXbWNQelAgjVWR8=;
 b=hmfLvwxenxjMcNzSaxjUkBV3o/uSvgXg5lo/9+HAXeeJGIJnE+uinHLw/qqVRxmCRVNCaQqfmLj+XFK1oE9g/N9CN8BSBQbcjUM6HBuK748V75z4sgxsjXURua4rFwigk8C6qGUz8r0hQw5+2ccdPHIMYkp9N7NOksIeSU+Rd3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Fri, 14 Apr
 2023 16:36:13 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 16:36:13 +0000
Message-ID: <1552ec3c-fa30-2f2b-c73b-5a9f4cd999be@amd.com>
Date:   Fri, 14 Apr 2023 11:36:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-5-terry.bowman@amd.com>
 <20230413175043.0000523e@Huawei.com>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230413175043.0000523e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6f3560-15da-4df4-c7a9-08db3d065c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDNZHFO3vPuGMWeU0LHmk73Z06A3CpsMBFCzd/h/gE79GzT4MpL+GIwVUbejXLY15vcfWwx9kYF3VW1OQ4JIu6hrUrpHNu2E5TWfYJunqeXeb4+dFjP+LsneCbpoBdZmgFGg9BVQ4Or5bIoisG9/jeA2u72HEsQOOvrgWs/BKBRrnFQo6T4pkc+uJG30uRj7oU2Xn2AP2smYta0iNG9NTuJuvK52GQhqskjyhS2j5xj+UNHKlRjhWSOFU9X/o07ZeJw7wNyz54XRQcomQ8Gf/3HOYA+C1pU65aiwfJjEhD/so9u+jKKwtkPNnpHEo9URjAJGJogOUaud4/qL2TvWE6PzyPDLS79CbORN/bFAsGyH9Prk7L2gbNfsj6ocy0A2OjxjlphErpvE4xK8Duy5kjkpgQJMLCB/qwsswQQO7/Q7Ke8aNx1Qyop/h2CIffQW5A/HFcGTcA/CEUnMU7GtU43u/O0+bLqg5Q6MqNYSvUvHo/0c3VhaTNUS9eD0Ss6OcMbqp1/9HsKgSbJYsJqP6exaK+N/PPpOxA/JnYmUA8p0j56MRLd53M50FWBZ/IGUXUKP2DafCaTL0Rqn1wxKgmPLrQwlM7ISuAkOVFAR9slgVYf1o69kRn4E+H4mltihkMoEvX0FO+MUN4rJF0PIOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(31686004)(36756003)(6486002)(4326008)(41300700001)(6916009)(66946007)(66556008)(478600001)(8676002)(66476007)(316002)(86362001)(31696002)(2616005)(6506007)(83380400001)(6512007)(26005)(53546011)(7416002)(2906002)(5660300002)(8936002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUp4ZXYyMW5CV0JuUVhRWllJT0RqaHlOVTRhYUlyTmpTQ3NoQjBkRzNEZDZz?=
 =?utf-8?B?WllJekp4ZjJwVm5PUC84VFVlRC9DNVRTMjBJbXl2WTZJQUoxSm51OUFMKzRU?=
 =?utf-8?B?K3VzNDFnTFFLSDhnUWkyeXhndlNFN3dONndrRWhaNlJTWGJHMUZTdThJd3h2?=
 =?utf-8?B?VW5MSy9MWUJOZnVDUUN6QmJzWGhYUXhnVzZsUG9uTGFCK01uQjVMUFd0SVZH?=
 =?utf-8?B?b2dZUFlVOVFSTGcxc0k4N0JZb3VFNWJqSllIamQzNVVZZEpqMEZVZmUvbzBy?=
 =?utf-8?B?SGIwUTlkWmh4REh1ekVHUm1HMWtUT3UzY1F2Mm0yS25SU2dnb1ZFWjNYNFVk?=
 =?utf-8?B?MlJaRU40bmhiekRDdFk1Z213b2VqUW5KN1lPMHh1VExZeTRPSzRBd0RXaGJz?=
 =?utf-8?B?dU5naGlrcDdoYWd5VjlxbnU1R3dDUWZLdmdkdUxJUFlJZmVlcW1TKzFQMXFS?=
 =?utf-8?B?Zkw4a3hYU21Tc1Z0VVgzblZVS1ZxRlRLaXFVWGcvYm13UW42bCtaMlFaUmp0?=
 =?utf-8?B?U0c1M2dNTjRVVzc0MEVyZjZDbFNuamJjdEZ6WnJSQ2wxOWxwMjUxUWJXOCtx?=
 =?utf-8?B?QVBDeXRBVlVNWHYwMEV6REFLaHA3UlRFZkw5MVlBSTVOc01NZlpXWklyTjRp?=
 =?utf-8?B?MlRIT0ZQcGhNbVpMYitmZmUxWFRHSk5VT3FTY1l6a1gvYW5LNjAzeWlDV1RX?=
 =?utf-8?B?aWVJSWZ2MW5DaGdSSitSSkgxbS82T3I2YUNoTlFaYk5Ia3R3ZmZsVXA4aGMw?=
 =?utf-8?B?QUlFSnRnSUlvT3hQbW5XalFiQnJBSkRuZVFRcEF0WVpjaHd2NW9qaXNTbFlR?=
 =?utf-8?B?WVZzakF5enBCZ1p1bHN0T1l1TVRHYVdRTUdqWTVVQ0hNMWFHU3prL3lUZ0c4?=
 =?utf-8?B?RFFSSjE2WVFxMUIrTVpaS1Jyc0JqU1M2SzhZTWdXM096aUxEMkc2OTlnRFhu?=
 =?utf-8?B?R1RzaWZUV2J6SjROZTIrQVV6UGFURWFuWDI2NHdqRkJZL0oxY3RpMDlKb25D?=
 =?utf-8?B?NStNOEkzVHJlaWdyb0xYNGtyMUVuR3h6SE1ZSi8rb3lyVnQ1YW9HTDYvN3po?=
 =?utf-8?B?Q29nUkJiSml0Mlg4R0x6bmtvZG54aFpxaDJnMzZPSnIzTFNET2RFUDhCckJR?=
 =?utf-8?B?d0NsVkdZMGFtRHF4czk3WTVHWDhaRU5NKzdDRzBBWnFINkFQR2MwRlluRTVj?=
 =?utf-8?B?ei9FeElRbjY1MVpVdzR4NjB4V2F0YnM0dytsdlcxT0lNN2EzV3k5Nll6L3J3?=
 =?utf-8?B?bUJpdzQ1ZUFhbkpUUWhkK1RFYWlFOVV1YmtBc2kxU2g4Vy9sSFdBZGtaLzBh?=
 =?utf-8?B?b0w1bjE2MXdKdnNkMDNaWWpRMlY3K1VSV1lZUFRWbCtmSTREclh6RDBmUEhT?=
 =?utf-8?B?dGw3RThUL0cyNXRTMFhkU1FrbjZvYUJLa09Qc09oVkRjZVNGTFg0ZVFSVXQ3?=
 =?utf-8?B?K012SW9xa1U4T283b015UFpSc0NSTnhaWm5LNURidzFEVmc3dHpiMjl1bTZN?=
 =?utf-8?B?WVpORlpJK1Z4RG9rQWc3WDZHazdHWHV2M3pFbGlOWm5LZkZ2K3NGdXVMd0J1?=
 =?utf-8?B?Z0dWMFVtUG5ydWxXeTd3U0d3Sm0xSTRVZ3dYT1p2Q0FEaVIva21zT1pYQlNv?=
 =?utf-8?B?RjFMem40aWVETE81QkhRYWlhOENKNHFxbDRoYjRyMDRaN2hhaVdHVlpwMGdI?=
 =?utf-8?B?MFgvZ3NaR1R0cG1sSU80MVBIRHlaMGc0SkFNT3Erb2w4cCtkT25GcG9ZbjBo?=
 =?utf-8?B?VzZuNUdxWVBEOU96N2Y1My90Q3R6RTRkZUNUdWhMY1Z1MFNCaGdlM3Y4Lys3?=
 =?utf-8?B?Y1pwenAvbkF0R0Y2UWUyWnhYdWd1bVluMTVNV2RqaDc3eUUvbFNQRnJDZWND?=
 =?utf-8?B?anI0S1ovRFdjdmNNOVZ5bXA4SU50czh5c2tEcGJDRXluci9LcUE4OFZ2Z2Y0?=
 =?utf-8?B?TmhhRkkwblErUFVMWUZtRGlySnhsdHdBRGdXd1pJOGxMVlFCWHIxTS96aXo5?=
 =?utf-8?B?V2s1NHEvNEtna3JjY09YSTlLMmdYaEVTNE8wL1BWUlFMRWpub1V6VDRlbk5K?=
 =?utf-8?B?M2ZocnI3YmtZb0ZMNkNHZFY3R3BPQUhjajNqcVcwNWdGSTh2TUtRYzZxcGls?=
 =?utf-8?Q?YGvUMurL0/+7Gxwxax3yAWPYc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f3560-15da-4df4-c7a9-08db3d065c81
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 16:36:13.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E97shha2r8v9CLesrpBQC4mMgxDyHF78iQhai0PoaHtgt3d20pvEXluAUvm4R35c92WeqkBNaaCs9s4EGldlsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I added responses inline below.

On 4/13/23 11:50, Jonathan Cameron wrote:
> On Tue, 11 Apr 2023 13:03:00 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> RCH downstream port error logging is missing in the current CXL driver. The
>> missing AER and RAS error logging is needed for communicating driver error
>> details to userspace. Update the driver to include PCIe AER and CXL RAS
>> error logging.
>>
>> Add RCH downstream port error handling into the existing RCiEP handler.
>> The downstream port error handler is added to the RCiEP error handler
>> because the downstream port is implemented in a RCRB, is not PCI
>> enumerable, and as a result is not directly accessible to the PCI AER
>> root port driver. The AER root port driver calls the RCiEP handler for
>> handling RCD errors and RCH downstream port protocol errors.
>>
>> Update mem.c to include RAS and AER setup. This includes AER and RAS
>> capability discovery and mapping for later use in the error handler.
>>
>> Disable RCH downstream port's root port cmd interrupts.[1]
>>
>> Update existing RCiEP correctable and uncorrectable handlers to also call
>> the RCH handler. The RCH handler will read the RCH AER registers, check for
>> error severity, and if an error exists will log using an existing kernel
>> AER trace routine. The RCH handler will also log downstream port RAS errors
>> if they exist.
>>
>> [1] CXL 3.0 Spec, 12.2.1.1 - RCH Downstream Port Detected Errors
>>
>> Co-developed-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Some minor stuff inline. Looks fine to me otherwise.
> 
> I do find it a little confusing how often we go into an RCD or RCH specific
> function then drop out directly for 2.0+ case, but you do seem to be consistent
> with existing code so fair enough.
> 
> Jonathan
> 

This was to simplify the code from the caller(s) perspective while also trying to 
generalize the logic. 

>> ---
>>  drivers/cxl/core/pci.c  | 126 ++++++++++++++++++++++++++++++++++++----
>>  drivers/cxl/core/regs.c |   1 +
>>  drivers/cxl/cxl.h       |  13 +++++
>>  drivers/cxl/mem.c       |  73 +++++++++++++++++++++++
>>  4 files changed, 201 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 523d5b9fd7fc..d435ed2ff8b6 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
> 
> 
>> +/*
>> + * Copy the AER capability registers to a buffer. This is necessary
>> + * because RCRB AER capability is MMIO mapped. Clear the status
>> + * after copying.
>> + *
>> + * @aer_base: base address of AER capability block in RCRB
>> + * @aer_regs: destination for copying AER capability
>> + */
>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>> +				 struct aer_capability_regs *aer_regs)
>> +{
>> +	int read_cnt = PCI_AER_CAPABILITY_LENGTH / sizeof(u32);
>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>> +	int n;
>> +
>> +	if (!aer_base)
>> +		return false;
>> +
>> +	for (n = 0; n < read_cnt; n++)
>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> 
> Maybe add a comment here on why memcpy_fromio() doesn't work for us.
> I'm assuming we need these to definitely be 32bit reads.
> Otherwise someone will 'optimize' it in future.
> 

Correct, this was to enforce 32-bit accesses. I will add a comment.

>> +
>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>> +
>> +	return true;
>> +}
> =
>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>> index bde1fffab09e..dfa6fcfc428a 100644
>> --- a/drivers/cxl/core/regs.c
>> +++ b/drivers/cxl/core/regs.c
>> @@ -198,6 +198,7 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>>  
>>  	return ret_val;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_iomap_block, CXL);
>>  
>>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>>  			   struct cxl_register_map *map, unsigned long map_mask)
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index df64c402e6e6..dae3f141ffcb 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -66,6 +66,8 @@
>>  #define CXL_DECODER_MIN_GRANULARITY 256
>>  #define CXL_DECODER_MAX_ENCODED_IG 6
>>  
>> +#define PCI_AER_CAPABILITY_LENGTH 56
> 
> Odd place to find a PCI specific define. Also a spec reference is
> always good for these.  What's the the length of? PCI r6.0 has
> cap going up to address 0x5c  so length 0x60.  This seems to be igoring
> the header log register.
>

This was to avoid including the TLP log at 0x38+.

I can use sizeof(struct aer_capability_regs) or sizeof(*aer_regs) instead. 
It's the same 38h(56) and will allow me to remove this #define in the 
patchset revision.
 
>> +
>>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>>  {
>>  	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
>> @@ -209,6 +211,15 @@ struct cxl_regs {
>>  	struct_group_tagged(cxl_device_regs, device_regs,
>>  		void __iomem *status, *mbox, *memdev;
>>  	);
>> +
>> +	/*
>> +	 * Pointer to RCH cxl_dport AER. (only for RCH/RCD mode)
>> +	 * @dport_aer: CXL 2.0 12.2.11 RCH Downstream Port-detected Errors
> 
> As with other cases, I'd like full comments, so something for @aer as well.
> 
>> +	 */
>> +	struct_group_tagged(cxl_rch_regs, rch_regs,
>> +		void __iomem *aer;
>> +		void __iomem *dport_ras;
>> +	);
>>  };
>>  
>>  struct cxl_reg_map {
>> @@ -249,6 +260,8 @@ struct cxl_register_map {
>>  	};
>>  };
>>  
>> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>> +				   resource_size_t length);
>>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>>  			      struct cxl_component_reg_map *map);
>>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 014295ab6bc6..dd5ae0a4560c 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/device.h>
>>  #include <linux/module.h>
>>  #include <linux/pci.h>
>> +#include <linux/aer.h>
>>  
>>  #include "cxlmem.h"
>>  #include "cxlpci.h"
>> @@ -45,6 +46,71 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>  	return 0;
>>  }
>>  
>> +static void rch_disable_root_ints(void __iomem *aer_base)
>> +{
>> +	u32 aer_cmd_mask, aer_cmd;
>> +
>> +	/*
>> +	 * Disable RCH root port command interrupts.
>> +	 * CXL3.0 12.2.1.1 - RCH Downstream Port-detected Errors
>> +	 */
>> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
>> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
>> +			PCI_ERR_ROOT_CMD_FATAL_EN);
>> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
>> +	aer_cmd &= ~aer_cmd_mask;
>> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> 
> Should we be touching these if firmware hasn't granted control to
> the OS?  Description in the spec refers to 'software'. Is that
> the kernel? No idea.  I guess this is safe even if it has already
> been done. Perhaps a comment to say it should already be in this state?
> 
> 

These need to be disabled because the RCH shouldn't behave as a root 
port/RCEC generating interrupts as a result of correctable, fatal, or non-fatal
AER errors. I added this per the CXL3.0 spec but, as you mentioned, isn't 
likely necessary because they are disabled by default per PCI6.0.[1][2]

This would be the case for OS/native and HW/FW error reporting.

I'll add a comment stating it is already in this state. 

[1] CXL3.0 - 12.2.1.1 RCH Downstream Port-detected Errors
[2] PCI 6.0 - 7.8.4.9 Root Error Command Register (Offset 2Ch)

>> +}
>> +
>> +static int cxl_rch_map_ras(struct cxl_dev_state *cxlds,
>> +			   struct cxl_dport *parent_dport)
>> +{
>> +	struct device *dev = parent_dport->dport;
>> +	resource_size_t aer_phys, ras_phys;
>> +	void __iomem *aer, *dport_ras;
>> +
>> +	if (!parent_dport->rch)
>> +		return 0;
>> +
>> +	if (!parent_dport->aer_cap || !parent_dport->ras_cap ||
>> +	    parent_dport->component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENODEV;
>> +
>> +	aer_phys = parent_dport->aer_cap + parent_dport->rcrb;
>> +	aer = devm_cxl_iomap_block(dev, aer_phys,
>> +				   PCI_AER_CAPABILITY_LENGTH);
>> +
>> +	if (!aer)
>> +		return -ENOMEM;
>> +
>> +	ras_phys = parent_dport->ras_cap + parent_dport->component_reg_phys;
>> +	dport_ras = devm_cxl_iomap_block(dev, ras_phys,
>> +					 CXL_RAS_CAPABILITY_LENGTH);
>> +
>> +	if (!dport_ras)
>> +		return -ENOMEM;
>> +
>> +	cxlds->regs.aer = aer;
>> +	cxlds->regs.dport_ras = dport_ras;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_setup_ras(struct cxl_dev_state *cxlds,
>> +			 struct cxl_dport *parent_dport)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_rch_map_ras(cxlds, parent_dport);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (cxlds->rcd)
>> +		rch_disable_root_ints(cxlds->regs.aer);
>> +
>> +	return rc;
>> +}
>> +
>>  static void cxl_setup_rcrb(struct cxl_dev_state *cxlds,
>>  			   struct cxl_dport *parent_dport)
>>  {
>> @@ -91,6 +157,13 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>>  
>>  	cxl_setup_rcrb(cxlds, parent_dport);
>>  
>> +	rc = cxl_setup_ras(cxlds, parent_dport);
>> +	/* Continue with RAS setup errors */
>> +	if (rc)
>> +		dev_warn(&cxlmd->dev, "CXL RAS setup failed: %d\n", rc);
>> +	else
>> +		dev_info(&cxlmd->dev, "CXL error handling enabled\n");
> 
> This feels a little noisy as something to add given we didn't shout about it for
> non RCD cases (I think).  Maybe a dev_dbg()?
> 

Ok.

Regards,
Terry

>> +
>>  	endpoint = devm_cxl_add_port(host, &cxlmd->dev, cxlds->component_reg_phys,
>>  				     parent_dport);
>>  	if (IS_ERR(endpoint))
> 
