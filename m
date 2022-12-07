Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E2645D3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLGPGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:06:39 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551313F;
        Wed,  7 Dec 2022 07:06:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxAAT0GGMG0w0vSsEe5CVE4oH0dPGDz9hNXBZaOOQc2Laf6eFgB1su+PTcIduO3Tb5/L5HUoZqT93rFxzhLzUj7F/dmHROEzyEB4MzU6HDTKwTERURkyAFCD2Fnjy8ca9jrzNKjvgAsYhJutIPm9EMfXMIS3OGrdnUIi7KIth8KYc5UG8byfhdS1y8cN/dl/r2/ytqmpLUeM0+UJAv+rNson4S3mIvaNZfdjg262zOjdMQVDRZDclaobbGMJJ9qyh8rzoZffqQk5YGn2PUSHCIamjtYACfpSNUle9b7thaNqomaAv3N+9obT/WwV8ozx6HDuBipR5HPm+LYtzay1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SMtSLkVo3gHS4UTTQ0BOJ/SXxyAgpGeQhytWdQPX+o=;
 b=EwcvxIThQTZCCT9sbcrDxLRhl2H6y81r+JW6DtnTFJI5rXrp9O7WZ3WK2NZHb+DKYQwyYO83qeLlVRTnDfodvzieRZhhcuvtIBzihegUvkctc2GnqvbT60ImXhJD7SgPhdMl+1IS8uXY9pPgFkXN5fmc/0lWzVBiOInQowJZODiExaQNvkQv0zQd6IZLI2Ggv6PsDCp/JsbyKcBwqtcZp7oCLXTzvbrhIeZ6jyIN4pqZZukbCcQDIJ6dY0PCNyInV3EP2ZLyk2dYZWexyIQRTQe/8V5FuHW5ABiGWNkbk+Da6FIi3LsmbkR4xTyRiNDblBrWePEefypf7ji6s+R9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SMtSLkVo3gHS4UTTQ0BOJ/SXxyAgpGeQhytWdQPX+o=;
 b=qeCExIaHV+L8dPCywXDZ4N19T814xfKuVaFz2pmBqD5WhmFQoEqbhE1MTRIbrX0vq8EsUkS00V3EQ4RaHP9nkUg/4sqeZdbmxheCQ11raCTmVV5s5AEMltNvIN8LoNDB6t0lcS3ZyDXQeZ6wWp5dSDsqsNHp33BC8I6rsH/Tljs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:06:34 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%5]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:06:34 +0000
Message-ID: <a10ed157-6d2e-4a97-b7cc-e07481706f2d@amd.com>
Date:   Wed, 7 Dec 2022 09:06:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] docs: Move rustdoc output, cross-reference it
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>, corbet@lwn.net,
        akiyks@gmail.com, ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-2-carlos.bilbao@amd.com> <87359r39gg.fsf@intel.com>
 <5887a9cd-b48e-e2af-7639-3f9ff53fcd8a@amd.com> <87lenj1erb.fsf@intel.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87lenj1erb.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 532fead1-fa3c-48d5-46d3-08dad864a186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/ULzlQZ0Pu0xGxFmfXifmQlQduOZYuT5isZP3deVeXNKFvfFrecvSFsYgj83uUuY6cSSEi6vEFsshhYAW6cPmWqMvRsINMUT5v+PcLNsxRd0IgKOuO39YWtA+Ultkf6Bv3es+/y7sts4UqLj10kns5LM4mkn8ofy6cqXEp26xSVnFk6W8/5hTGpY+FkIKYD5iE7wNy+wmU6vAAGMugHNxMoHuYaFlnqUSb6AYMt83PFz+tAizBKSSKDkDQh9RY1uQaCGY3m/RMHvSTW4GyXKdrOIdhEsisWEscMKQpgM/IsqY/l0DETkPtRYpn4LtuM3+fhMtIhaIKHnPU8+d2oIXxPB/k3y1OQQv8+mOAqdUPIHkpI6GdfEasyBycNsbZdggT223m6F8cFhg5zXaNzWs1WLB51KAnCDo1lY11lt432TKJBmdWmLFrrw5j4pM6NaaDVARkOTxxJcNDuR0b0I6limCK/waQTwycfqh3qLxi4NAG8XFnB5wuvqqtPCRgJB9cynbMBvgwKprOwp88ZVOKJ+LZ4hSoDOL2WH+di2JO2A1W9An+WytnQMDSESkX9nqGAkpGKNpSzobpYAHr0MmeL71d+zSGxoZdZulwXnar0QFQMXnkPdZRXlZpS3crR6saLYn0FgTEJVG0onrkZ2yQPcyO9IQJJMsA6JmqOpIjVsidz+AcoNRJMvwd0V/qFMIPbA+xsyf57xbNpar2em0DsS9XpMTywbTbttb0b8Wmtxf278KTbCwcNcfqsHrAl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199015)(31686004)(31696002)(86362001)(36756003)(4744005)(6486002)(6506007)(478600001)(966005)(38100700002)(53546011)(26005)(8936002)(66476007)(6512007)(8676002)(44832011)(41300700001)(2906002)(316002)(4326008)(66556008)(66946007)(186003)(5660300002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFlKZThSc3pOb3RwcjdSejVpd2wxNWFIbkJKLzJpanJPUmxydWR4Tm1DOVN2?=
 =?utf-8?B?dUpTVVdXTCtYK283TDBVdXB3NjNJOG9PQXE2c1I4ZG5jRDl0enMwSmo2M213?=
 =?utf-8?B?YXppK3V4VzN0OC9EYVhZTUZwOXhiRW1OWjBQTDJQSkY2dzJHN0FhamFQaTZx?=
 =?utf-8?B?bEFycFo0NTBPMDhYUkhpK3NuTWhmNjV5ZzdSNjhnOHQwd2lQdkZoWkpLU1FX?=
 =?utf-8?B?YVF1NFFxM0JsUHVJUC9SWHI0bEJSUG5aM24vdWsyZThYRGtCR2dkKzIwSE5l?=
 =?utf-8?B?R3F6bjJpOHB6QWV2WHZWVlgzQWtFbGJsYUNKbzlaaHVvR0VZd1hYNWgxK1oz?=
 =?utf-8?B?TFQ2UlovWmpiT3VSRE9BaytNNjVDMjFYejl3ZGllTXdINDYycFE0cm9kS2Yv?=
 =?utf-8?B?QlFkN1EwblRJMnpxN2RSS1NSVlRHVlhRTHZ5MjVIR1FxRzBXSnhiNFZiVS9w?=
 =?utf-8?B?eE5pMmpOOWkweVphOGhsa2FwVWlPcytJRUFPYXgzenRRS2xHbUFMN0xuMWEr?=
 =?utf-8?B?OTJFZ2lUVE56RGVsemtySURZdStVeHg2TzJTMWdyaVlEaHptb2J1MnNHL0E4?=
 =?utf-8?B?Vm1CellnM0prLzhVSUREbkQrR09jQVc1VnYyV0R3ako0bmhBeEhaZENyWlZC?=
 =?utf-8?B?MmJReVZRSzc0K1VVZDliN1QwOEJ1WmNTcjgwQ1FDSC9lQlhPQkFkK1R4NzJO?=
 =?utf-8?B?MTlEQ0hFSWY5NWEySWt1ZGVGSEJIdmlSb0JmZ09jM2JDcHQ5eGl3cDV0QzBO?=
 =?utf-8?B?ZFdFYmZXY205R0JSRXQyNHVSZkVmVng3VWZ5ZldmejZPQ2FIcG1ScHZWaFdB?=
 =?utf-8?B?QWRPNzlUaUdoSk5lcXR0QW1MbXRXZmlQZXhlSVZZV1pCUnBZU1lBSjhUbHhs?=
 =?utf-8?B?U1kwU013NEdHMms5WTRQWWM0VDM4ZWxhVmM2ZlA0SkxJNkJRUU5xaDk1c1Fz?=
 =?utf-8?B?c2tJcko5V25xM0M1dUk2cjRwR3lKYzMwYWpyWFd0RGZrVE1YWTM3MHZSYnY3?=
 =?utf-8?B?cmN3cjJhM1U4MDFPR0VSeFl5SUMvZWNwTGQ4SnU2Y095a2llblV6VWwweFRr?=
 =?utf-8?B?a29wTGZWcnlNU2dKWG5LUFZiK2NVWlROeWRTS3RFVlNrVGdmVWFFN2xIMmk0?=
 =?utf-8?B?K3BDSjJENHNBRWl4V0VEcVN3NDUrV3ZWdDcwYkRIQmYvdHp2SDJoUHQxMGw5?=
 =?utf-8?B?ZHMzWFFKU2ZkanpXYWQydmpadzVCbkFRR29SYjFsRlA3R2RBaktFTDc0ZEVR?=
 =?utf-8?B?V3R0MEl1aGtFN2tDY29CL0Q0eFBIbVltUkpuVU96dHR5T3FCT1V4K240VnBj?=
 =?utf-8?B?aDJKZXArTnBFSXFPUlR0NUVzdUQwTTNkSTQ1YmJkSlNZSllyT093SmRWYzI4?=
 =?utf-8?B?RkNWckp6U3NqSTlXM0pjZkxqSVZoRk5BdGFRKzZKTGhNMVFSNkExaTN0bmE0?=
 =?utf-8?B?MGZIcTBUWUJYNDlRUC96SFNTS3pqdXllVVd2S2hqUWt3TDdyR08xbmUxMlJP?=
 =?utf-8?B?eFRYa2dTdm56bC9zUmlabVhIVE9ZODJnaEI1TnZYUDdkZTczR3RCK2RQSmFy?=
 =?utf-8?B?UWY0enZMbHVDVlBmNG8yeDNHVXByenE0dHptMTdjRFZVWEs5Y1JMNnFwY2tT?=
 =?utf-8?B?T1diS083RHFsZ24vcUVTRnZpY09uVzIwdTNLQ3ZlM2tjS2Z3WHpQM2E4RmRR?=
 =?utf-8?B?QnJ6SU1BVDBDc0ZNbStmejVVMTZuaHBQZzB2cnRXdmJNdEM0S3pSSndiaWFh?=
 =?utf-8?B?eUUwUTFDWC90RlVCdWFmZjR5b1N0enRqeTk3YllYNndYMnFVN2p4MGNEUjVJ?=
 =?utf-8?B?a0tKZ2VLZ1NCazBXb21ORjE4R2xQT0FQQkk4UjhwMUZmUlMyOUNqaEZKN2Nt?=
 =?utf-8?B?eE9NVzFyeG12NzEremJhNnJobkxLNzlOTWFOVDYvQ2xFSWUyWk5nVGc3Rmxw?=
 =?utf-8?B?ajdkTzg5dkpPUXc5Z1RTWHVkcnZyQU9iY1NiWWJ5YzBrK1lueXlNODZ2NGxy?=
 =?utf-8?B?YVFwK2RBRGZyL2UxdnA4aEdGbmZWa3lBUnRiNHYrUXUrL1REVHU4K3QyMWpk?=
 =?utf-8?B?SFNySTdjVWpBWm5jR1BwOG5vMWowWE41ZEs3T1FRcUoxWFdjaWk1Vk13RFNM?=
 =?utf-8?Q?U7GSo0flrME/F+lArNWXHGcil?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532fead1-fa3c-48d5-46d3-08dad864a186
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 15:06:34.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OUd+u42yKAsTWtClkYRZr5RNfQo3iGkTJ7ObNzrp2KJAGv9KwlEZuiyxvyUcE1RzdGpq/nLHFoJCfxu39wcPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 08:15, Jani Nikula wrote:

> On Wed, 07 Dec 2022, Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>> On 12/7/22 2:27 AM, Jani Nikula wrote:
>>> Also, please don't use "here" as the link text.
>> Why not?
> It's considered bad style, see e.g. [1] or [2] or the plethora of
> results you get if you search for "here as the link text".
>
> The link text should describe what's at the destination.


Understood, thanks!


>
> BR,
> Jani.
>
>
> [1] https://ux.stackexchange.com/questions/12100/why-shouldnt-we-use-words-such-as-here-and-this-in-textlinks
> [2] https://www.w3.org/QA/Tips/noClickHere
>
>

Best regards,
Carlos
