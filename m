Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D96ED496
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDXSjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjDXSjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:39:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7713761A4;
        Mon, 24 Apr 2023 11:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWuTvm6mknIrPF/QTrR3QMQvkEdPZBAectcxVqvZmqNqpFsYhTZOng9U7vX1yY+CfzGtdvTCUItoboIoJbZT9dmOeYUX0n2cdNCWhTJ5U5+lsQUQfee3xUJcXFFd7J0dm02Xe/E6+1nhuArKvWXDiaWdU5X8RbuIozAmgf82A1fGJR+V9TAc0ceDGl+0Ea/Lyw41fwfH5bbuG3zI8ouCFnKHMoJLQP7MZVSIEtnO1ZLXM8c3g4/IklSn3skjevSekRGLPukYDPcubYWMSp4LG+G/DWgAKeBfMXh2u11QtUd0NlFX6zdSC1pb+vWvMPPW4j7q+quF699egLQdMwlU4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKbySTcBd9POX3rlY/QyE34nGPgCjhZ+zcHtuoj+g7E=;
 b=jAVgIBBNujS5tEy64MYUfC4WJW3+t1EiW1YM4+hwQqzU96czCz5KioJyXB7oZfEWUEfWgzUrbCeLSp4gHZ9bAVv+nGN7OATcNRymx8hlZpR49Smp0+i9X8VBjghfCRmXZbCiiIKUnSf6La5Ygb4gaBcFvqxv+P1UW+vzTDo9BA7LrFzAmiS+JRtMPCFHSAzkHXmP4AmfaTOxkenoDPvlyK5xnYucBwIT2sDqcnOlS+3F4kNLABvVBiYenv3Micg+jSrS017Tpe/HTP5d9RoQjkuJ57yPCYK3CTHClvDzzbcq6vLOmhd2dKqHmT8sHxRHuXNIczomiJ+AvLDr5yr5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKbySTcBd9POX3rlY/QyE34nGPgCjhZ+zcHtuoj+g7E=;
 b=IFZowRbeUp/XZ7q4zm17lneq3yGkEm6sc4TM3n1DPZLL6kZ6C6qYpgIgYCxDDs+M0iTwjSkUcgvGjQxQ1M/SRa5tzQXoWQpoRRR3VA5d6LC3Wchv0+StTuv13de+WibJdfKqL04oNfGe2h1gExT0R9Z5M5++Geg4zLjX8ULorFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 18:39:09 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 18:39:09 +0000
Message-ID: <e876857b-ab34-5b43-8355-649a7d15e2c6@amd.com>
Date:   Mon, 24 Apr 2023 13:39:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/6] cxl/pci: Add RCH downstream port error logging
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Cc:     rrichter@amd.com, linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-5-terry.bowman@amd.com>
 <643ddf0869622_1b662946@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <643ddf0869622_1b662946@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:610:b1::11) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d31615a-4cfc-4517-7df3-08db44f33112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOkLY8YYYxMZGqwzSKXOJMjb27R2XcbTSkQCqULfxpiha4ePxmjNWSPalvvKyQ4FEnOm8tIsZJ+h21MbL6TBAJh4GFaK8GydX/aghGA65h1qyJ/m1BW4wQwUWEE8b0u+jPhtMh+slSw2SEgQkwxveEYkKAVXoRz8DuL/+BXYIj1Bb6Va1o63OryiqQxT4uHZuUxeM0qqJwFjS7Xi8ECOOo9xXSFGACMyJbICpQaRWIW2H65rLY3lpyEO83H+1yBBjzo80FXYg1V1K5H05Jd3oojoYXFmCfbT8QXAoeofiUHHTNrYxF/kikNhoAfxcW216PL7aLvtSdcaayR0AP8x+HfhQ3xktoHo6Zqne86tnJP5/84r3BweJqa/BNEGyORuYrPzrnfW5N3QzW7/zwl32df8aTY0GZFXP6U7+esBPQEoGkGn9AyC4XIKilnU9f0++EzCRunTSR69RxKF4Lo/yexF/r3uLacFku2Z5BzUQqiHKbwuc1qptboCaFEUq4S+eCfOGrWGzG7Kqeel6jVJhtv3I5goJZ/oAtcsAtSewZrHv4pRMWeMpARnbieDpFUlvjK+fqJCHgPtygzi7obmtk/0EkZL0z0eLPE0y/omTEEpIchI+J+GqAfN41ZqRqcNG9kYfgcqQWpL7Rt+xnf2Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(53546011)(186003)(86362001)(6512007)(6506007)(26005)(5660300002)(38100700002)(31686004)(2616005)(6486002)(31696002)(83380400001)(478600001)(36756003)(41300700001)(7416002)(2906002)(8936002)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjlyYWJ3MXNicnlVcUFOa3BKV29NNFQra1d0TERwYTRaVU9CbTNYZDJQMU03?=
 =?utf-8?B?MUVtNk10akl4dU4wOC9ZbHdRTFFoUkRGRGNuV1NHejgzT2g1TTRJYVdzLy9q?=
 =?utf-8?B?cW1PYThVc2h5U0k5eGw2Qk55b2RPcFVnbTJOemh0UTgvT1hncWFLTDhvSGEy?=
 =?utf-8?B?clFFbXIrWDJuM21heDFlYlBHUlk3OHkvOXZFQkNIYUxkU2tzbWxPbTE4Mzll?=
 =?utf-8?B?cmZIWDZuKys5UFNhWFZ0ZEhmNWt5czZGczVNYlpINm9rbUJMNFVvZi9lc3dG?=
 =?utf-8?B?eXhDcjdSeXJZenBaVmxGWnBjRkVnbFZZQ0JLd3ZYQ21uTnRpNE9ZQzhscmNJ?=
 =?utf-8?B?WEU0a0IwTExFNms0M1pyZ3M1NnpLYkhaU3NNSXlwL1owak4wTUxpREhkaTFr?=
 =?utf-8?B?ampFcE4vNlNUV2NGZ21RalRXT0tROVpFSm1Va2kxTEVRSG9XUjNkQ0c5Wkkw?=
 =?utf-8?B?c0tTMlpVbUdjeG81V2JGYW1WZk1SVmxYWEpUM0JPTWpnMVJxSGdCMTFoUHln?=
 =?utf-8?B?QVpqTGJUaEtGR3ZBZTFIemtvUzFYajZ6anhJa3FpMmVGa2U2WndmYlBjN3kw?=
 =?utf-8?B?aEFTVWduMjN1U2k1cEUzeHpWZU82N1BNejdCdGgvaVZBRnZnd2JFV0J2eTRU?=
 =?utf-8?B?NFlXQTJlRURXTkU1cmZmM2VTNS9hcjYwUU0yRHhCQlFhZFFhY0g1bXJHTmhI?=
 =?utf-8?B?QjNoVlVwcC8weG1zVmZLWXpsbEJhNVpTZ09iYjZBR2lXd0NoWVZ2Z0FzNWlY?=
 =?utf-8?B?SDg5ZXp5aVNtaHpJbGVUT2pmd1NCcy9uL2Z0cm5TRG1UYTdXd2x4R0ZUYjRx?=
 =?utf-8?B?NnQyQjR6L29VTGdDMytEL29BZ2tuS3lHV25xRGRrU1JBNVhMUGNtU0E1b3RG?=
 =?utf-8?B?aXR2LzZiUndVeFdUd2pCbXpUVlpweTcrNXY5cTBnQkw5bVRybDRvM2NvMkhj?=
 =?utf-8?B?cldRMXM4aHdnZ1AxTkZ3M0RQbTRlMzRKU1ZETmZiblpmQytBYXpKcWRWL1ZP?=
 =?utf-8?B?aW0xVmJHYjM3UU8vaXpsV3A4bDdaanNFOVZaV3hHZXBySEZRbEgycitYM0Mv?=
 =?utf-8?B?Y0Z2STN6VVlIbHhvei94OFpvWm0rejg0ditVdWdXSjIzU3k0YTdYQWkrbkxq?=
 =?utf-8?B?NEloZzBLUzZVTVVmUy9iZVF5SUZoYXErdzN5KzBzVmZtNDlrVVQzdnBSTEhT?=
 =?utf-8?B?K1VBYVN2K1ZOV2pnWWNZRURRaERzN1pjY3ZZN0dPblI0VVMrRUlZQm9VMWtn?=
 =?utf-8?B?VE1nL2NadndkS2oybm9QMHh1dmxvTXJIclhMUjlBblBuS2xINDFLUjV1S0tT?=
 =?utf-8?B?aHRYajBuZDNoMnllY1YzL0NPWGhBZkZiTGdpZ3ZjKzgwcGV2YVkxLytPSHV4?=
 =?utf-8?B?OXpkUTViMlJLL0hVTkJaRm1Bcmplc1gxWDh1ZnREaTdXRW5KRElaeUdvMDht?=
 =?utf-8?B?MkJBY2padGRIcGhGMktEdSs1SWYzaXBsY3M0NUdQNnBXUGtoVmtDSDJ1ZGYr?=
 =?utf-8?B?MUZoQlZmSU9oSGlQdEtPRWgwSUxNbEowSHdmN29JM2FsOHQya2R3WFNXb1k2?=
 =?utf-8?B?M2lOQ29rQ1dVUE5uMG9Qc1lFZ0lCNWd1VGI3Y2FwOE13WlFXdWtlNFNFQjgz?=
 =?utf-8?B?WStTRDZEYy9HSzlzc3JtVWJSL2cvWkJ1ZytRTkp6OEZkNEhpRkFxNXg2K2NN?=
 =?utf-8?B?TG82dytlaTVPQ0Zuc0t2aDhzY0ExNWp3MnRDdE9SeU56MnROZDd6ZVVWcVhP?=
 =?utf-8?B?bWMrck94YlFFR2lmL2M5YnNVVWdHQjVQaHkvUWQvWjFGOEtibGRrZHdYSnBs?=
 =?utf-8?B?Wml0VzBuK0ZIdFlpSG9jMlVCYk1KTWZkOFIxVjEwOTh3K3l2M3A3VUVJOHpw?=
 =?utf-8?B?SnRKVVc0c2dXNGRZbU5mWEU5cmhwb1Myb0FVSzVmdjJCTFRIY2ZNaDY3Zm9D?=
 =?utf-8?B?QWlNejVQSDQ5SnB6dm8zT1gxeDFEODdDMHR6NmF3VGRmY2xCTU9BOGgyMm1a?=
 =?utf-8?B?T2VsbU9UK1J4cjA0R2F2bVcvamxhYkR6SHF4ejdYNlNSc1JlZmhzSFZhOFJq?=
 =?utf-8?B?R0orQmU4UndSSzNkZDVObDQ1dWNWUWdrbHd6bmM0bVVHWlMvd0Rtb0JhNW5J?=
 =?utf-8?Q?46OIXJgmgWBN2/UbMUuMaShym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d31615a-4cfc-4517-7df3-08db44f33112
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 18:39:09.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lu7EpwFPdppxx8xRXEN6nwO1ritpQApIM0ft4OSNSqeiBESozmuaVSHqjOCJBnDKEgBoQVTrbNkVGqyhFdjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I added comments inline below.

On 4/17/23 19:06, Dan Williams wrote:
> Terry Bowman wrote:
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
> 
> I think this patch wants a lead in refactoring to move the existing
> probe of the CXL RAS capability into the cxl_port driver so that the RCH
> path and the VH path can be unified for register mapping and error
> handling invocation. I do not see a compelling rationale to have 2
> separate ways to map the RAS capability. The timing of when
> cxl_setup_ras() is called looks problematic relative to when the first
> error handler callback might happen.
> 

With respect to timing, I see this works for probing AER and RAS. Will it 
work for caching the mapped AER and RAS addresses? I ask because the mapped 
AER and RAS addresses are stored in cxlds and cxlds is created in cxl_pci 
and isn't necessarily available during RCH dport discovery. RCH dport is 
discovered within cxl_acpi context (beginning from cxl_acpi_probe()). Also, 
port.c code shows cxlds is not typically used. 

If you like I can change RCH RAS mapping to use cxl_map_component_regs()? This 
was in cxl_rch_map_ras() to handle the RCH odd case for AER and RAS mapping. 
The RAS can be moved out but RCH AER would still need to be mapped presumably still
in cxl_rch_map_ras().

> For example what happens when an error fires after cxl_pci has
> registered its error handlers, but before the component registers have
> been mapped out of the RCRB?
>

The RCiEP ISR would execute but the RCH AER and RAS would not be logged because 
neither are mapped and are instead NULL. The AER and RAS register status would stay 
resident and be logged in the next ISR entry. 
 
> This implies the need for a callback for cxl_pci to notify the cxl_port
> driver of CXL errors to handle relative to a PCI AER event.

Along similar lines, could the RCH AER and RAS status be checked immediately after 
mapping and logged if status is present?

Regards,
Terry
