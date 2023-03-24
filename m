Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A556C87BB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjCXVwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbjCXVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:52:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE33C18175;
        Fri, 24 Mar 2023 14:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqQyDXn3PgXlGjyqwnjhAxq4waE4rV5Cw+DNYnNkCrAZXrrjHcfeHeQEjJ2TuLW3u/KQQ4tnKfa8F1P3IPg/qKnaOymWqsDnVeEnvtyCBPjpgPWv+1/W8uemlVBnsF0KZFFyLLRmzdal2z7/o9v2kxG6/XSxW0xt/RH4NC0lhOW/sPLOMKX8QCJOlhiGWxs0eMrpRwvX7CCwMB8ngxnOn3SqX5l+HOEs7KKMlg2734O1IgQYxCntpKiA0UR5Q1MvYujGglyhLJmIIJSG/0FMN2LZLbRlRfqPHDIn2PwQ+iEkAdAGVU7thIqMnaN2sx0FSiceKEmVnCzvnWFXvM74wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH3YGonJc8BH+9GQXa4T7aINm6Vu+Ymg/3lTC+X8Jtw=;
 b=MpvONAWFTVZtDR6mtHvXKU9ZdU0AUfaZz3gQiOLPPpL/1PWdSN/39Np2s421VnYNnqZ6KQ3YiRvjbnmrO1UI5zIB9KYa7iN8Sm6PphoU0vnTemr6i0INwueA2XHN18Whi+H+Kim/4GcGfpaV715maoI/HVVv6otV5AuSQmzfWqKGv4Je5vsMopEl43prPPpTviy29P2c4hIAYyrUAa5xup/eldubxDaMamoQmG3FVPVYYytqDPs/jhh3P7Cyh9jQaZoPLtrFvVI4NyPBce6BAmDV6CONqJ7GP8tAg+W6c1SQVDTidFoHHvjgM8JxiylPdMimmiV9NbXlu9wwzC8M3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH3YGonJc8BH+9GQXa4T7aINm6Vu+Ymg/3lTC+X8Jtw=;
 b=sualB6zZydp10VYl39p0D3oHoZQDXxDMdjBSmuDXwgD7XydvP/wBumWueUN1uzJg+R7NdnScn8ZaUY78F+w4l3Q7s7Volxv7JDqJbtUx959o1groXG4A6KFWFraN575HnHF/GULES0/bkuWP8uObWNUuKj/EPYEG56VsfccXJ4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39; Fri, 24 Mar
 2023 21:52:18 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::8ffc:be4a:e730:2bbc%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 21:52:18 +0000
Message-ID: <3a21a541-d725-a199-0237-ed16cad29a28@amd.com>
Date:   Fri, 24 Mar 2023 16:52:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver
 logging
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230324214159.GA2660001@bhelgaas>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20230324214159.GA2660001@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0007.namprd15.prod.outlook.com
 (2603:10b6:207:17::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 38760abe-c25c-4946-cacc-08db2cb209c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeL7NHPMaX22PFxW4Iijh7iJW2KeyP+UatpJUp2wCmI+k2pjPNW2vEuRyyHtuqo4ews8ON/Z8Afcx7kDqXfWGWzw2lsUfSYyfeZcGDg3YQn89AMK8ADxBurpTBMHEVpPZMXHwwzgSU8zhK/o33sDw0hDh93edYYOYBjsiyMugSGXaU6StIFKn5MoLCrDynme8z+DCIRiKthrqr2TcwzkcrGgzjHRUj3x9EcWzW432dCjSr8BdnyBFiONT1V1+nVBhhNS26FxT9bG6ZtakQDshq0ISI9K+G764Y31cdeeUoeXk5hHgWAGfLVrkTr3uvghLQvaybpHMKKVp0mCZylMylat+jPeJn4cY1oT217orLCCsZBsyp2babDPBoe4lsI6/uit9mslOPucfSEicUJ6ZzlRA8+D6z6wc3XP4jCG22WJ8KKN73A1mZxG54OlceAC7kCUoXLzGJaxx5dD/0xCVHZE1H7Z4dEa2/8RQ7fyiJNXC8pe+OhaFafWVJcIAGd1UpCA1M/A/1alRHLJ8hbAR4A8JBIWiVkLycwugR4T/4bpiBmONAz5suA19dBNKSeoEzqV2M4PEbUm8RhMG/rJ3o+dg8xhHYwlE1dsVOLVMH+e2JIJrBnlddQfKV61qiNXD+bwLjz9a7mgu4n4FhFOJoSGboXKisvLKeQsEjXDl7XKJnDDBaPuCsXTV+fnMK0hFoVir+0WYyK0lKYFza9QOCn3mD8oyImNMg5ReqDl7Ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(83380400001)(2616005)(7416002)(5660300002)(6666004)(6486002)(316002)(478600001)(2906002)(6512007)(66946007)(66556008)(6506007)(8936002)(66476007)(8676002)(6916009)(41300700001)(4326008)(36756003)(53546011)(31686004)(38100700002)(186003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmdBcXN6Z3hZNEloMEhkeGlkdmxGMXZKVHkzQUJML0tkUGNldXBBeHJOV2RT?=
 =?utf-8?B?YUZOZ3J6UHhCTnljUVNTTFRhYnQ4b2JoK2tKSTYzZWZzeEVRYTdlL0FqL1VH?=
 =?utf-8?B?Vk1ONEw3K1NXYWkyS0xVQkI3VENqcWJZaCs2QVB4WS9hL1NSZTgyUDFJZkpW?=
 =?utf-8?B?c0VCa2NYU2IrYng4N3NuVmM5aUdYVW5MR25sbUFqTnJhdm03Z25xVG8xZTBW?=
 =?utf-8?B?bEdJdFljSHB1ZjJCMmRZTExNcWw5ZTkxejVyRHVBbERGZ0NRUmsweXhQaldJ?=
 =?utf-8?B?YWxiQWU3cUNwd3ZxQlZvejUwVVFSQUtJd1EvVzNwZmdvdml2RlRvNHNTWEJj?=
 =?utf-8?B?WDhzUjlGemZLSlp3bHg0ZXAwTWNBbjFkVDhKTGJVQXNKZkVBZENWRmxmTEk3?=
 =?utf-8?B?Ymp1SGhVd25xK1BPTlBqVU1GNGl3NGFBdStIV1BKRVF0OVZjRXlxNnFQRHRx?=
 =?utf-8?B?aVJHb2llV2FvU2xJSlUvUGlSQ01yaWozeWNMMXRnT2o1ODcrTFFQeVc3RjFH?=
 =?utf-8?B?QnFOSk1oMFJSVm1FMTdLS09UZDZpa3ordTV5Wi8reEk2WXRMMkZaR0tVS3px?=
 =?utf-8?B?eEtYUlZsYXJUaEwwT2owNzJOdkE1Nk9SVFBiT2tUR3ZMd29ieUFkQzRCL04v?=
 =?utf-8?B?Q3k2QkpiZlpuYk1aWi9LLy9SVmVtblBUVzc1STdJNFB6QWJrQVFSLytnVHJL?=
 =?utf-8?B?UmQxYkRvWFlDTFAvejRYUnpqbVA3eTY5ajUrSTV5ODFhaHhrRi9pOTB5Ni85?=
 =?utf-8?B?NzZoS3hpNnhxbFk0UGZQN1c0clArSTJYSXoyRkhCKzNOT0xkanFJYWFqMlBv?=
 =?utf-8?B?SHdudTlodklKQTZaSzJUaWRySXVqSk56WnpXYzIzTENodDBteTN4ZHhtNEZP?=
 =?utf-8?B?T2tTWEs4UFk1Nlk4RTVsVlU2STNkRmFacW5UMEF1NW5OdHl0TEJqTnh4cFhp?=
 =?utf-8?B?ZEdBSmJkSXNSLy9nTURlanBVckVxRzV4MHJ4dXJqbmVqK3k2eHhoRTNFMWFF?=
 =?utf-8?B?djlKYjB2NDl0eVMxVE9FbDd1TTdYcVg5bW41UDY2K2F5N3l4OTR5OE9pQktD?=
 =?utf-8?B?OC96eW1uMG1sYU5jQ3VwcHl3ZldEZlRWTWhEeFo5R0JDM25xQWlTYW16bkRu?=
 =?utf-8?B?K2VzcFhIdlVJd3hJMlBMRlgraHVjZWhyR2xWTU1uTXVQK3ZPbllNOUd0REs4?=
 =?utf-8?B?UHlseWZjSDZHVGgra1Nqa3pPUzdIQ0NXV21XMXkrUkJna2xoK2VPTjJGbmVj?=
 =?utf-8?B?V1NRL003R1crSnB1dTk0SHJJOXZ3SlBlNW5EM1BaWW5rOUgvODVDc1dpTGp1?=
 =?utf-8?B?N0VZNnZLRm4vd0pWVTFEM2tqdTJKYm1xUWFySCtmRkVZcW5yYlFqZ2Q1OWZV?=
 =?utf-8?B?cGEvQjk1b1QzK3ZEU0kyd2VVQ0szUktxOHdWTklraWM1NmVzQkRjV09yaW1a?=
 =?utf-8?B?dTdBZmgva0FHbFNEekZML0ljcXd3a1lTTkY4dkNabFlzQ3pqZG9kZitVaWVt?=
 =?utf-8?B?ZnZuK1BCYVhhc25lS1JweEtVd1dzTmRWQ00xb1BWeXQ5c3VDR0JoaWtqT2R0?=
 =?utf-8?B?Tng0M0tKZ20vU3pHUU14QXQ0d1ZtL28ySUc1aG44enFHWUJrSE83aXNqbTBh?=
 =?utf-8?B?eVZ3VnFRM1JsMEdTaDJCMFc1bDBtUlhRL0JOOW9TMFJjb2Jla01xN2F5MTBa?=
 =?utf-8?B?OE92RXIxSmpOanowMzl0QzdENXZrYjRyNk4rWU51MXBGZ1pJOGpGZi9KV0tj?=
 =?utf-8?B?RmFLbnM3WmpkNktraTYyOHdydVBxN3FBWkQwUVgyais3Q1Zwb0k0Y3p0aWQv?=
 =?utf-8?B?Q2pzOVpZak96SERIL0ViUk5pZzk2MFdOSjVRMWFRT2RSR0tMVkZjNitUSUcx?=
 =?utf-8?B?Yml3SWNCcHlMWEZNd3pLT2E4clRScHlmV3lNdysxY29BZlFQSXE4MEYwekZ5?=
 =?utf-8?B?K3RhVUxZRXNmUEl4bmpZUDh3cTdLSnR6aGlseGJ4OXlkVmE4VWIzZ3p5cGZJ?=
 =?utf-8?B?QlpmbGdoQU9rQWZmVmdQRjVXelVjV0ZMS1BoWWFHWHJmbVorQi94c1E3bGlR?=
 =?utf-8?B?NzdHbXk5WlE3M1VHWXRhWjc5SGtkTVhtWFk5a3ZIWk1LbkRLTzhiNklOSW95?=
 =?utf-8?B?cm5hd0oyR3lMWG82b0FERWUwRllYY0R1QUQwby9DV1pEZWM2a0dlM2RuUTBW?=
 =?utf-8?Q?LZL8/JzyA2+kyWqJC/EC+BRt5LE/ZH4+3o9CbJ8kofqZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38760abe-c25c-4946-cacc-08db2cb209c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 21:52:18.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRKNrR6N2vYR4y5Idc/RkOIhAUE2uqzmPA5QkJUPYLbN2ExhNdpiIl8nY5kvuNxSOQRegq6x4XJNCcufiUdY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/23 16:41, Bjorn Helgaas wrote:
> On Thu, Mar 23, 2023 at 04:38:06PM -0500, Terry Bowman wrote:
>> The CXL driver plans to use cper_print_aer() for restricted CXL host
>> (RCH) logging. cper_print_aer() is not exported and as a result is not
>> available to the CXL driver or other loadable modules. Export
>> cper_print_aer() making it available to CXL and other loadable modules.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
>> Cc: "Oliver O'Halloran" <oohall@gmail.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> But please update the subject line to:
> 
>   PCI/AER: Export cper_print_aer() for use by modules
> 
> to match previous history.
> 

Hi Bjorn,

Yes, I'll update the subject line. Thanks.

>> ---
>>  drivers/pci/pcie/aer.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 625f7b2cafe4..7f0f52d094a4 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -809,6 +809,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>  	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>>  			aer_severity, tlp_header_valid, &aer->header_log);
>>  }
>> +EXPORT_SYMBOL_GPL(cper_print_aer);
>>  #endif
>>  
>>  /**
>> -- 
>> 2.34.1
>>
