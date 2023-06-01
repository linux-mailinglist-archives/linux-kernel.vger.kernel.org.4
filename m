Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C7D71F1A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFASTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFASTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:19:33 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9EE7;
        Thu,  1 Jun 2023 11:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5jNyqzREMe77QjhDAgV/w02YHnQYEZWUg1Dgy/O54jCmqFCL1aCVJKAkE86K38oCS06vUFzOFcLdF+QOXsF3DneNn7mnFNxfwPKZPBIyl6M6tRxM9444nnr0KbiKvzeNTUw4O0t1IwSN650/sEawE+6ZMLzzWO42uA9/8hZPCKc62Z470DB+u0rDBiUYNHPwhev+kR/aMOotDJZvv1Mdtw3y8wqxGgF4hPYlWLwVc+t+VcObaxKWXrj61YGAKYW28WEqfSvqPe/UiYQcfLbOcAwko7FdW2bBlPpbn+R5FMiLGz2vOFLB0eGLNasL8xmqAOjeJDN26SAER/43jSrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Piv2qROtWqPvLiyBqo8HebFISfHjqvJaJcNxXNj4gsc=;
 b=kniDymhlcumYSsyqQWCQRJ97EzJb3Hp7YgHwa3GPlV9ZY26JVkHkHsKzfPfzlpBv/xOQCvGyacQWRvZlGycreGpfkPhfTqIAfmXIRqHEWHGBLCtqhH09I10GUJeqQE6YycAqfr/Z4MDUPmjlUWsC8uRJ7gKrQH5tJVG88vt1sljaCLUQ/mGvCejlVQP4j0JneLsLRLSg8pzWcid7xiJR14jtL+jWXQ8l3lE7r/VmY57I+SiHWQRJm16TVSCLKEg38qxFPosXxusqxUgB8zlVfvs0TJm5Y0x526N5Z5L2WQUnOeF5NUCHH+w9K8Bs4q965OwjraxPRyEGCl11e5Aghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Piv2qROtWqPvLiyBqo8HebFISfHjqvJaJcNxXNj4gsc=;
 b=qLPh0LLnzPLsQSsb0fjOAMikVFS60Nd27Y8IqI+gZw71qs9ikERejlM/UEmuxXNtcSwiQLnNwXBkZhSo5vvp7zW/rpfk33tSBd819AP3DMTvccHfMhx+0A7CRVBSonMdbncGMyHOSg7EFMxOzrBzRkojxRvXMhbXuUCqIfHSdeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB6752.namprd12.prod.outlook.com (2603:10b6:806:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 18:19:28 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::61f6:a95e:c41e:bb25%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 18:19:28 +0000
Message-ID: <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
Date:   Thu, 1 Jun 2023 13:19:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
 <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2790bd5d-6e93-4978-5880-08db62ccbc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHIUsFl3YihYw1DFbfE06zgGt7HNGYlNx632lTuF8wHy96phPXeifKp5SJkAZO43smZ/9S0TL0MuUDj49Awx4DOGMOExrnZY4GEv8mIZ/CcNFIN3AXfBhTQfqY536Xd75jaoBaWgWESlFqZUfG2n1xLPcmloP2PUPASLxFvl+Umr9avJRE2iA3nQ7Z1v7rhEslWXigGFWo44kIx503MrqAjJpOWi2/YN1krwMu3yMUvbnM4Fpo0Hcu0kZxJ/kSWTg0A/qkxrtvneVYXLr6ARmy7yy1mvlz5nXAfPB+rOj678rZTmBUnBnehaM281eXqgMOuKEVtQs0cUupFpG9b6iX5iTnQ3Z1F68KvBLHV2YEhNsrrlkgippDNv/juym74JwSoC/TA9rQajKx8LLcmygOCeVrII+xfAsrH2zwYjLOeXLU/c1mXUZ8e+W+ge3OoBc6SzkiqPQxvCFsyXvyNKXaHL2O71pxJvNIjBI1dqOk0IckReMpegGp5pRdZeisAbQMESo4HMjO4396hEYmXScLYK6zHMPdoSpfVJRGWnZwsz+/3IONM9gyUlLnvkK6S8p+EKPhabEPdl0ESF83GK3KiFO/X8Pu/IhjqLRYMDiitDl3oeL+PA25Fc3Pypyl35R9bgAKShGgFUqhGPduPGmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(86362001)(31696002)(7416002)(8936002)(5660300002)(31686004)(8676002)(2906002)(4326008)(38100700002)(316002)(66946007)(66556008)(66476007)(110136005)(54906003)(478600001)(41300700001)(6666004)(6506007)(6512007)(53546011)(26005)(2616005)(83380400001)(6486002)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NscVBtL3J6T0QrZ0RDQ1hSTkoxaVJKWjBDR2JWeG1uZ21uc3RwUmdHVXVt?=
 =?utf-8?B?azh5L0hoUTBabmZtZXpHL2dNL2wvVXJmSm5QamR4aHdTK3ozZWdpQkwzRTh1?=
 =?utf-8?B?MStqdWxMcmVqVDNwcFJPbndsZW5NOWNLZzJyU0FqemhJcWpOK3ZVWUQrWUVT?=
 =?utf-8?B?THUzTTl0MitYeDVCZlkySk1sbk1CMGdIQW1EREJmaVM5YThxUC9MdDM5MFR5?=
 =?utf-8?B?RzJQSEFPK3BSWW00a0pUTnNlOTBlc2YxdkRzcVdQTDhiT0FxdWFqS3BObmlF?=
 =?utf-8?B?c0NTSDNaakcrUUJocEhEN0M0NUFIWitxMkt3Y0JrMEJGRnV3Y210ZjRHZkFK?=
 =?utf-8?B?dDZrSlpoVmNUNHVuUFVOMHN2dXJWa0xVL3lDZG5FTG0zUTNlU1FHL21VdUVZ?=
 =?utf-8?B?dVJvK1FrMkdjTWtOR0dlZFlZWWd3MmdKbEYvc0ZlZkJIRWVIVVdSNGEwcllr?=
 =?utf-8?B?VWQ0eFl4SElqWktObFkyN1l5T0ZwaEppNFZtanpaS1h0MUx4NC91cGsraUY3?=
 =?utf-8?B?R1FNYmRxSExFMGgrRHhYaTF6THYyMWNzcWNGenIrVE1nVHpsY2VaeHUwb3Bj?=
 =?utf-8?B?ZEJERWVFUWdvaDQ2QnVvQmQrNE1YeVh4NktuUDdod3FPTjdOWUxXdXF0a1dD?=
 =?utf-8?B?NWRQZEJkRldRd3hXeE93Y3NZcUtYR1p4cW5jRkFqYXpReWdMNjFUL2dQUGky?=
 =?utf-8?B?NHd4Uy9VVWxBaHZQZ0lYaVV1d3pGczhRRTlOM2ttRmhob1NLaVZYZWYxVHVO?=
 =?utf-8?B?UjVmd2N0T0hnTFRRZWltSzE2enU5ckFJZjRWbHZqZ1Z3ZmZEdGFwS3RXVml1?=
 =?utf-8?B?bFlhL1FNU2w5TklSWEFkYkVkMkRFWnMrTU41anJtTXloSUtDUEh4TmRNZGpI?=
 =?utf-8?B?WmN0YjA4cWRJNkFGbG8wcnJwZ0lFOWhPZzVaSjhyaXJPR05EeUw4ZXVxMVp1?=
 =?utf-8?B?V0R0RG8wNGdMbUhBR0Q5ZFYxU2t4bUJmWWhCUERTdStpRGMxTmlXVnB0MTYx?=
 =?utf-8?B?Ykc2Yjc1MVM4MjBwNSs1Y0RUOXpaUlRzNENLb3BIbG5hditXdjA2TDN0YmZP?=
 =?utf-8?B?Qk80eWZpM1J5bTNieHcySW80cWhUTVQ0M3dzQXpnTnd4UzQwRFRWN2RKeWF4?=
 =?utf-8?B?bDJvbnJHYTA4REZjVEk1djl1M2FHWWluc01QcWpzcThBd08rR2RBOXR6SzRQ?=
 =?utf-8?B?azVxT1pualg1b3IvdStJWC9vYkp0ZXF4Y1VjTE4wYmE0WjB4aUo4TDY3blow?=
 =?utf-8?B?MFRweTlYQlFoWHZwaDgyRUFEdTRDNVB6eWk5d2poRmxLc3J5eDZmVVlBN3Y4?=
 =?utf-8?B?RVV2Nk5ZbVhJOVNsSFN2RlFxeldZeGhOaFgwVk54V3RwRTAvZXNLOWFUOGZ6?=
 =?utf-8?B?VXdwTm5vVG5YT2RZZTNqUnAyUVFnWHJrcENRSjFsNzVWYUlSU0RWb1pSRERk?=
 =?utf-8?B?ZVdWelcyUlVVd00reU91ZFNhQmI1S3pjblpuQ29UVkhmYXhoL29BRGxJbzZG?=
 =?utf-8?B?anIyUEpGWEYvV0VNdWNENG1IVkZpbmtzdkNmWm5KcVdEM2VHekYvSUF4NExk?=
 =?utf-8?B?d3RKeUI2NGU1VWlhN0dNbDJwdUQzNnRFZlI4KzFjR0o4elBjRk5Ocm5mZVlU?=
 =?utf-8?B?cFJmSFE1UTVacHlCanphRTU2aUcwaU9TV0JENWN4czV4bk1RclRkK1cxakVn?=
 =?utf-8?B?dklWQ2tqL2NkREg5L09tSm9lVjdJcnduSUc5aW5sVThRMnkyd3AzNHZicjJx?=
 =?utf-8?B?OXRKclVhVDdma3YyazdRRmVHSGVIbzcveC9LUlptVUxUcmFoZk9IeDVpREg4?=
 =?utf-8?B?SVhlRG44NFVNZHBDM0FhMVd2UG9NY09CNEJ6WjFjSXhzYlZFdmdkMzAzWDNk?=
 =?utf-8?B?czNOM2RzeWtlSUY3WjZ4ak9jbXhCRjdxckl5czR1cFBvczA2M0dsQW5JM1Ft?=
 =?utf-8?B?aDZrdmt3QURUSk5kWUtVSFZ5aGlwa21SZ1lONjBiRU04UU9KZWQra1lGMDBs?=
 =?utf-8?B?UXV6ZXRrMnQvUXpJMCsraGxhRks0ditIdUxuMjJiUXBJdHFydU9RT3BObUMz?=
 =?utf-8?B?Y2syZ3EzQ0wrR1E2NXg0Q2hSUUNnbGhwdWkrRjI2R21TaFFCei84Sm5GWXlF?=
 =?utf-8?Q?hrPiDwPjXRQ347YXr8aZdoCVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2790bd5d-6e93-4978-5880-08db62ccbc92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 18:19:28.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EEjCs9Wtf++VkRZV130sF7CR7JszLLLlvYghidCAeNkhA4CaBrTZXGqgPmaRbRq2KRf5OYCRcUeX2PcdGUpOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6752
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 15:00, Michael Kelley (LINUX) wrote:
> From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Sent: Tuesday, May 30, 2023 6:22 AM
>>
>> Hi,
>>
>> On 5/30/23 5:57 AM, Tom Lendacky wrote:
>>> On 5/29/23 19:57, Kirill A. Shutemov wrote:
>>>> On Fri, May 26, 2023 at 03:10:56PM -0700, Sathyanarayanan Kuppuswamy wrote:
>>>>>
>>>>>
>>>>> On 5/26/23 5:02 AM, Kirill A. Shutemov wrote:
>>>>>> Touching privately mapped GPA that is not properly converted to private
>>>>>> with MapGPA and accepted leads to unrecoverable exit to VMM.
>>>>>>
>>>>>> load_unaligned_zeropad() can touch memory that is not owned by the
>>>>>> caller, but just happened to next after the owned memory.
>>>>>
>>>>> /s/to/to be ?
>>>>
>>>> Yep, my bad.
>>>>
>>>>>> This load_unaligned_zeropad() behaviour makes it important when kernel
>>>>>> asks VMM to convert a GPA from shared to private or back. Kernel must
>>>>>> never have a page mapped into direct mapping (and aliases) as private
>>>>>> when the GPA is already converted to shared or when GPA is not yet
>>>>>> converted to private.
>>>>>
>>>>> I am wondering whether this issue exist in the AMD code?
>>>>>
>>>>> IMO, you can add some info on the window in set_memory_encrypted()
>>>>> where this race exists.
>>>>
>>>> I don't think AMD affected by load_unaligned_zeropad() the same way as
>>>> Intel does. But I'm not sure.
>>>>
>>>> Tom, do you have any comments?
>>>
>>> Right, shouldn't be an issue for SNP.
>>
>> Thanks for confirming.
>>
> 
> Tom -- For my education, could you elaborate on why this problem can't
> occur in an SEV-SNP guest?  There's still a window where the direct map
> PTE and the RMP as maintained by the hypervisor are out-of-sync.  If
> load_unaligned_zeropad() does a read using the direct map PTE during
> this out-of-sync window, isn't that going to trap to the hypervisor?  How
> is the scenario is handled from there to provide the zeros to
> load_unaligned_zeropad()?  I need to make sure Hyper-V is doing whatever
> is needed. :-)

Ah, I think I misunderstood this when it was being talked about. The issue 
SNP would have would be between setting the c-bit but before the PVALIDATE 
is issued. Prior to the RMP being updated, referencing the page will 
generate an #NPF and automatically change the RMP over to private (in 
KVM). However, after the guest is resumed, the page will not have been 
validated resulting in a #VC with error code 0x404 being generated, 
causing the guest to terminate itself.

I suppose, when a 0x404 error code is encountered by the #VC handler, it 
could call search_exception_tables() and call ex_handler_zeropad() for the 
EX_TYPE_ZEROPAD type (ex_handler_zeropad is currently static, though).

Thanks,
Tom

> 
> Thanks,
> 
> Michael
> 
> 
