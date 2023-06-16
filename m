Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46E37335F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbjFPQ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjFPQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:28:06 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944A30DD;
        Fri, 16 Jun 2023 09:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQIqf6cFpqbfPmArQISS2LJyF1dGLXT8pCiRQIsZJ5Oden5X01kK28CS3l3DVz3Au6MlD6SYzsogSZ91dffLuzKrXRsqXPfBEZt+4+cwgPVJqfvAmMuf8zVcq4wEecpefwRKZymx1mgXCXFMuuUQeyD5hCecin/NpzV3VEUg2y+hJMavsmf6m3L11qOJuluDYUJdsnw9Y/q0rk3ID5B+PLz3G/8kL17pDwPOCF8SK6Z0CrUTaXPbeIojbKNhZmMG98zpCC3pYj+AMA+lZ4eswJ7gQv4SU9GZOjv9XFYjAGKzY7Zsy9gpyuPlxxKIEaE+2yShh+5oQ5TppseyWQoAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfOBp7+fJhzCfYvwZOLaIrXGHiIJ13buAfHJ3UR88Qs=;
 b=hV5n91mE9H+QWSoVkiP/q9Gt9ae1rLjevVwyaFw1fl1QSGfiZAef+gQdA0EujpRIFQUW3mA3oTvprx9c61bOF76giyHCq1/8MiKIRRA6xGnoyIJ7uR8I5vHR7G2F86E5fw/gllQxMn7eqjQod4AeICql//1aWFCcUNCLUWsOQQLLZm0uyAqkyKAgcvJOFxrhbu71uNZKl4k8EMs+oOujuAfxYyUOuIOr1uKP0RnF1noKJ6PClamqiQGT1yQsPksDuRCIVXMCCV9okPU3Q+IhsZb7VUv2FAoIp4hbO08pI2XX79jMb07Uaqg6TEBQp72zKLZUYKDypTrOZR7uIydR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfOBp7+fJhzCfYvwZOLaIrXGHiIJ13buAfHJ3UR88Qs=;
 b=4kR1c61yZ/UlK12H9y9wt4OHVPyW6eudZJXlNoiortk6cUsh82ZdDavGx1axcLg7CcmYoRdgU4iLkTPkGUBOOpZ5bEE6GzEWkzf/rYH9ko9+LkFH5rfjAhyU583XlHD37y4GivBvAbN+KsJ7Im1935V9KHiZ7ECQyC/VHABACuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 16:28:03 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::f7fc:407f:3bae:bd96%3]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 16:28:03 +0000
Message-ID: <2e59f65a-5bc3-1b82-14eb-b36bc82f3126@amd.com>
Date:   Fri, 16 Jun 2023 11:28:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 24/26] cxl/pci: Add RCH downstream port error logging
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230607221651.2454764-1-terry.bowman@amd.com>
 <20230607221651.2454764-25-terry.bowman@amd.com>
 <648790561f7ea_1433ac294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <6d229237-58f3-655c-5e7b-912cdc64ec94@amd.com>
In-Reply-To: <6d229237-58f3-655c-5e7b-912cdc64ec94@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:8:191::10) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 31005c87-4164-4a6d-2673-08db6e86a82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CmREWZPKq/fQjEpO83Ir1GXtJVdzazi+LSQVXKU3bvp4g7MEOxF5aktMgS94N9BN1TmTkypVg7FaEGSzT1lbiNlGNralFEV03UuWZso9cAgvIYGMSUku3vMI9vgPPCJDG8Bl5YZF0cEm86U7gsra28+WRNNL6bJGN8yCFOH8LGCCppDc3CN/70UL4QIzBMtGesFv240O+ZxGFHxNCWNn0+nMRetH8CaqMtyeWmaT0OSHotxS5eI3J1KFJv6Xwod8ItUh3uiRgo458fu4D66mm8La4AN5waHEL1lgO0wV7ZcDDKDHqdjUYSGlO1uSkIN85lWpxoEXtklfm9M557lnx/gjyZVokbkTICta95YPbglOEjXMsllAXl/SJgconuh3iDNqMLVfEve0VC8+BWJ8cDyqPu+8pEkETOVnjjU8sp9EbSsTxGZx5HS1aI5pDI+VhlnN5l/4Jj0fwGShGGS0U43DyPWKA+PEEztD9byAHi+IWLQghF/lEZo2rGp0XUUEyA2ZFCkZxxv/Q1thuJvxWNL/gXduqjkDs3e73g9mT8ioyYH6I1bajE3pmejPS9g/H1qY/R8PBzeQzQx8yZ9KyuCw7Rx0H2JShvE9d+oqPxzSm1vFeObmsIm19vDHwMUx52OkX+/rZcsuUjiMWH4qGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(53546011)(83380400001)(5660300002)(38100700002)(186003)(2616005)(6506007)(2906002)(6512007)(7416002)(478600001)(26005)(66946007)(8936002)(316002)(66556008)(66476007)(8676002)(6486002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2l3VzRMMFQvYWVPRzZ4a1FkdEwzLzlFRG9MTTFxVnlMTjlxNERvU1RlVkty?=
 =?utf-8?B?d3hySno5WjQ4ekgxWFJxc0dkSDI4Ly9hVzNGaFpWZ1d5VVdoYUhWaDhSZm9D?=
 =?utf-8?B?b1ovcFdWSDVPN1dJb1dZOUZnQmszMEliWngvdmVjdmhVVTJOVVpPNVlzeG9x?=
 =?utf-8?B?ZDNMbjBUbGZRalZFdXpQQmNBUXYyUjB3M2hOWTJRVmFtbER0T28vTVBQeHJp?=
 =?utf-8?B?eEkyVGtRblJxcTBHTnliZW9JcFdKTkVZc0p5eVdUbGRWcU9yM3ZjS1hnOW1r?=
 =?utf-8?B?c2c1d0p2NEMzaE1hR2p2OXhpajJEOEZtZG5yTVV0SlJxYWtnTUMxWWJSWDFr?=
 =?utf-8?B?R0ZBVngwUGZGV0VhUWsxWTNVZUtmVDlMVXRvZVBVYjZkNWVqMU5MYXRCbEw3?=
 =?utf-8?B?anVHWVBkM2w4WXBvVS8wM2JnazJlamVBbXQxOSs1VEFCWnN3REVFd01RWDBN?=
 =?utf-8?B?UG5Lc2VJbmhNUEQyVnh3ZEZEdENmbnIyZVZqTlJzc3RrRlYwenlwTk9IZmZN?=
 =?utf-8?B?OXA1cDEwdnB2aWx4SU5FM3dyM3k4WEhHMGJUWWNmejdhVUMxMjJaU0xCKzc0?=
 =?utf-8?B?dmwza2dRSnBOSmRFUk9ZRzFjZHUzbVFyN25PanFRRHVzaS9jOTdySVBTVHlo?=
 =?utf-8?B?SHoxSkpuVjhrbk1TR2pFWkRMRmZ0NmYxQkF6VWVmck1FTFdKNmQwYmNWWC9H?=
 =?utf-8?B?ZmdkK1l5V1lnWDdlUGIvM3hKQnE2cE41TUdzeVJGS2pyTVNWb200eEJpL1FX?=
 =?utf-8?B?VzZjcDJ4ektmSjM5b2RTY3FLeFhTZFR4cG5oZnVnVitwblNLeHlzY3UxeG8y?=
 =?utf-8?B?ZnhIbjZYamFCdmVXTnZKTDlNSGdyM3hXT0VEU1p0ZnFxSml1NEYxSE8xUVl6?=
 =?utf-8?B?clAyYkhKMG4wUGNFNVVhUC9YR0xVTytuQ054bThYRWg1ellHQTZmd2dqaFEy?=
 =?utf-8?B?Rml6LzArbkdTKytyb0UzbUlBRnFXMGhmWTFyZVZXRUgzd2h1cDlKSFJ4TW1R?=
 =?utf-8?B?OTJWSWF6SXN3TUVkUmZOTEN3anpTVjhFTVpqT2haV29WWjcrWWVJOUZGd3gv?=
 =?utf-8?B?RWh2SlJQR055cXVwZ0xDUEhPdlo5Mno5UVlJUndXWk1sWW9JRlc5QzBUb09p?=
 =?utf-8?B?VUhJd2N1NyttTHFQWWpzcDJHeUFXVXZvZXBGblhwT0N6NGRMNTBmQUhORmNZ?=
 =?utf-8?B?SDlGaWtDdHFCcVR2eDJZSUcrWnFZYTE4ZTJZblkzTHRBNzVNVGkyYWlxczFs?=
 =?utf-8?B?TEZwNHl1clM1b1BQRWtPVnI2QmMyRTVNWWRtSGNDZ29UZHh0MGJncTNrbUNR?=
 =?utf-8?B?WTFnVTdBTzFBeEdkei9ETjF2MFJibkNrcmFrbHNQUVFHSUlLaEVZbUptTlJv?=
 =?utf-8?B?QmhDaFBmRldqNlRONUZtRzFhRGIrNEUyQ3kyTmd1eFVNNVp1VHF6TmgwWTk3?=
 =?utf-8?B?RWowbkdxdE80Qzd6QzJaMEhmT2JjMFY3QlFPUDhBZXVHdmpQdGVDOVIwQy9Z?=
 =?utf-8?B?eHl0c3gzaUU1Ry9FRmsrY3hGamJjZ1kvbGxwRDY0TE9ueXc0THJWYlRRYUYy?=
 =?utf-8?B?RmlHSElQMmdrY3VzRU5OdkNFeVhBWHoycFQwYWdvRytXSnhXQUJRVm1pSGxh?=
 =?utf-8?B?MmFDUTFpN1FIa01Ja2ZRdjZ6TkNFQVFyU1AwcThpZG9mLzFOS0VpMHhlRUh4?=
 =?utf-8?B?eWdxbmRDNG9yYmJHbE9RNTZ6bDFzeVJzTC9BWktrOVlpTUZ0eTIyQXZTZTNN?=
 =?utf-8?B?TGh5TWU1eWRYV2hIUWhYYmpQdVFiNjduYkM5NHBZQXRuUWtQWVo1bmJzZitV?=
 =?utf-8?B?VCtSN2Zta3c1Z0xUUzhwYTVsem1sb2lScW1waUlHN1BnSTFMbGRGcHJwUWJj?=
 =?utf-8?B?ZnVBTW1TcE9zVEJBUDdpMVp4MThKOWZ5QUVSZUw4YWlZNGZHRk9tbTJML0Yx?=
 =?utf-8?B?cTlKdmVsUnI0MUpHdzVINHd6aTBwL1UxaXBCWm1TbjJjaVhwN1F0cERmVHlq?=
 =?utf-8?B?eDd2WmV6K2NxVDRiV2dXM2ROdllacWJiNTU2amQ3azh4cHZ2QkVnWXQ4U3Nt?=
 =?utf-8?B?Qm0zVWMybDdtZnpuaEVrYmh4Z1lZWmszbmVXYTFXTGtNMWJ5cFpKMXZvSDhU?=
 =?utf-8?Q?Gk+lMZJ1rUADFEuRZFgblPAM7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31005c87-4164-4a6d-2673-08db6e86a82c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 16:28:03.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGNOmmmlxw44OkjxoY0XnfRTlAikhd6tAY+UDNkvjfMFqmpRI7CEtmBSeOgBpa2zXUUn6KFDiWVl1Z9lRJ083A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 6/16/23 11:17, Terry Bowman wrote:
> Hi Dan,
> 
> I added responses below.
> 
> On 6/12/23 16:38, Dan Williams wrote:
>> Terry Bowman wrote:
>>> RCH downstream port error logging is missing in the current CXL driver. The
>>> missing AER and RAS error logging is needed for communicating driver error
>>> details to userspace. Update the driver to include PCIe AER and CXL RAS
>>> error logging.
>>>
>>> Add RCH downstream port error handling into the existing RCiEP handler.
>>> The downstream port error handler is added to the RCiEP error handler
>>> because the downstream port is implemented in a RCRB, is not PCI
>>> enumerable, and as a result is not directly accessible to the PCI AER
>>> root port driver. The AER root port driver calls the RCiEP handler for
>>> handling RCD errors and RCH downstream port protocol errors.
>>>
>>> Update existing RCiEP correctable and uncorrectable handlers to also call
>>> the RCH handler. The RCH handler will read the RCH AER registers, check for
>>> error severity, and if an error exists will log using an existing kernel
>>> AER trace routine. The RCH handler will also log downstream port RAS errors
>>> if they exist.
>>>
>>> Co-developed-by: Robert Richter <rrichter@amd.com>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>  drivers/cxl/core/pci.c | 98 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 98 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index def6ee5ab4f5..97886aacc64a 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -5,6 +5,7 @@
>>>  #include <linux/delay.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/pci-doe.h>
>>> +#include <linux/aer.h>
>>>  #include <cxlpci.h>
>>>  #include <cxlmem.h>
>>>  #include <cxl.h>
>>> @@ -747,10 +748,105 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>>>  	return __cxl_report_and_clear(cxlds, cxlds->regs.ras);
>>>  }
>>>  
>>> +#ifdef CONFIG_PCIEAER_CXL
>>
>> A general reaction to the "ifdef in a .c file" style recommendation.
>> Maybe this section could move to a drivers/cxl/core/aer.c file, and be
>> optionally compiled by config in the Makefile? I.e. similar to:
>>
>> cxl_core-$(CONFIG_TRACING) += trace.o
>> cxl_core-$(CONFIG_CXL_REGION) += region.o
>>
>> ...it is borderline just big enough, but I'll leave it up to you.
>>
> 
> 
> I'll take a look at this. We have most of the patchset requests implplemented
> and will give me time to look at this.
> 
>>> +
>>> +static void cxl_log_correctable_ras_dport(struct cxl_dev_state *cxlds,
>>> +					  struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_log_correctable_ras(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +static bool cxl_report_and_clear_dport(struct cxl_dev_state *cxlds,
>>> +				       struct cxl_dport *dport)
>>> +{
>>> +	return __cxl_report_and_clear(cxlds, dport->regs.ras);
>>> +}
>>> +
>>> +/*
>>> + * Copy the AER capability registers using 32 bit read accesses.
>>> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
>>> + * status after copying.
>>> + *
>>> + * @aer_base: base address of AER capability block in RCRB
>>> + * @aer_regs: destination for copying AER capability
>>> + */
>>> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
>>> +				 struct aer_capability_regs *aer_regs)
>>> +{
>>> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
>>> +	u32 *aer_regs_buf = (u32 *)aer_regs;
>>> +	int n;
>>> +
>>> +	if (!aer_base)
>>> +		return false;
>>> +
>>> +	/* Use readl() to guarantee 32-bit accesses */
>>> +	for (n = 0; n < read_cnt; n++)
>>> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
>>> +
>>> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
>>> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
>>> +
>>> +	return true;
>>> +}
>>> +
>>> +/* Get AER severity. Return false if there is no error. */
>>> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>> +				     int *severity)
>>> +{
>>> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>>> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>>> +			*severity = AER_FATAL;
>>> +		else
>>> +			*severity = AER_NONFATAL;
>>> +		return true;
>>> +	}
>>> +
>>> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
>>> +		*severity = AER_CORRECTABLE;
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static void cxl_handle_rch_dport_errors(struct cxl_dev_state *cxlds)
>>> +{
>>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>>> +	struct aer_capability_regs aer_regs;
>>> +	struct cxl_dport *dport;
>>> +	int severity;
>>> +
>>> +	if (!cxlds->rcd)
>>> +		return;
>>
>> Small quibble, but I think this check belongs in the caller.
>>
> 
> Ok.
> 
>>> +
>>> +	if (!cxl_pci_find_port(pdev, &dport) || !dport->rch)
>>> +		return;
>>
>> The reference for the @port return from cxl_pci_find_port() is leaked
>> here.
>>


I will address this as well. Thanks for pointing this out.

Regards,
Terry
