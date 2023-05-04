Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716DE6F65AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEDH0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjEDH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:26:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE842728;
        Thu,  4 May 2023 00:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dccqwHVPUB6s4iH6cQr4t09LPUVIkemkhFcujp4CeaCR8vptBtaV/8UNKzzZmoSIAIPsIcmbEoK/nmGH4dmBK8FQpkJDRwkD8J1qtuJp9M+Zk8PiridMD0OyfhT4QtukgegcfObu6YoI4aWv2FK0grZpUf6uggJaoy8yWzqH8cVTvzjXvLJ09TrLUJ/osUiAWfK3cmNJlQfvkNjVcjpDQ/saFL1CEkNPrWhPrxrV2pAgAiJqcmKkOSY8knfkCiQgfVhb2YE4U+qgWjFeNpKvdf+8TYKs+3dlEfsI5bgvHAWRMVtkHXiqwGyx4Gjmz7IexxUYd77YL+A2oEt38a923g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtrKIW34oECzFpjUUyl49qvgvouQRhTrjChU56YAzZ0=;
 b=FxDW3voHBLyc16k9TxMjgwG7pVDsVJrXo3+WjwLpKFvvoMtAOH/xFA86nbZb55cVPeVMK3BSAloAQBMfG0pARKuThzPIwBlZ3m0VHuFnaeQwXIFuo5+JVrVsqkgdiTwvL5RsTssP7FvhOndqXwpTYYTPDUWE3IEZR34M4Q4UKTMyjUT8gGazyEEN+AY9hK4faMk7h/2jPdL04U7v319zwvLssrOQRqhVjtu8O8nJgpKVJEa8Cwh5nVqsmrsSZLLBaTh/7qSF+uca75DbkjqX83IUb0Gkmm/w0ZUvcshTFK5o6WD6y/yT6bHa9mu/bvIUIMHz2hVKz3Wb4egJkJGVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtrKIW34oECzFpjUUyl49qvgvouQRhTrjChU56YAzZ0=;
 b=QPWZkP1nKLXwhLSYnmuooC0aGNuAj3z4zp85SeDjSvX2qHEjVlD4CHx0Jgpc1kqVxDcwWbmJ2gT475dovKZtNRf5VVG2EGWbqFHg1sIwG5LeQS7wrnOtKxb8f4B23zYwtalOqOsmUydpEtiBLO11c3ULK92FmdjfsCIMWTgGh5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 07:25:59 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 07:25:59 +0000
Message-ID: <eb325b2a-d265-d8bb-8e98-9eef8f03355a@amd.com>
Date:   Thu, 4 May 2023 09:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: usb: Add binding for Microchip usb5744 hub
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        ilias.apalodimas@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@amd.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <cca068980ae0b902168a9a9b78cab4efb43157a8.1683121150.git.michal.simek@amd.com>
 <4aa7adbf-f89e-6819-64d2-5942a456528a@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <4aa7adbf-f89e-6819-64d2-5942a456528a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c56957-ffbe-46a0-9d6c-08db4c70ce76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbRw6AjfLrDTSujdlRDmMAvFoooB1+QiWBlRINVPvWZGF+WdXUTVFmXuK6ed2VcfibL6R0EFAqzt+/vmmNon+hMT5Sa0EhI1bn1C87pgGIB+H0LlE+GZv15naxmwjVu1CVbUcq2uNPMvPgnOH+aU6xUiGgpU0INcY1jOACIMeibJjbqKJd6bdqQg/gRFd/gRjOEKX0QunwLFj9wj/6n1cfigwSZ+EHh9XI0B7pyJNFtisk7r+GsT7rLMhhxduAuRvluNDzuHTnHa0H+AgtiOH63b8YJtJoNDlOyhwY1DhqU0W47sfnOLgIxYosIAOuHkU3C+jzgxf1H+hAZeqbaTiKDOKkrzAppe+OVBQBOExwXaQMtmsYXbykYdlo87q28S4tQw2fVO61Qf18u18jkigKO30v7n/VGV36UQxxjR1b+87kymiGq+xheJ7gWdJ00S5Z4tTBsWhQch9M3qLVgr9zd8iPPuEpdlnzNg11522KnJR6Guzw9UZt7egH7U8RHMT6dQD/VQLDjIA3aU6ohjNhZnPU9FbWtuC7KRlVMfntMfYTzth9rNPWxVeyACc5Ch5yxyiAT/S+n/HYg0b3Jx5SJ+EPtla6yWxgQ0MooW8ICgLTBbHnXxlf8/GapJ8ZFV0/CUMyfh17M0k1oytQb4cdmDLN+qhaiH7L0R1EYSfQIxySaTDLcHbU/gDT6MJzIg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(38100700002)(7416002)(6666004)(478600001)(966005)(6486002)(5660300002)(316002)(66556008)(66476007)(41300700001)(8676002)(44832011)(8936002)(54906003)(2616005)(66946007)(4326008)(2906002)(186003)(26005)(6512007)(6506007)(53546011)(31696002)(86362001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhXak9QUm8vYWFGNW16amdRUCtQb29BVHFTcW1LL2Z5UURzaGdtenRCZ29t?=
 =?utf-8?B?RUtzSUEra01maXlVZG5oMk4rOStubHV6ekxPT3BFaW92QUowN245cDVBcFRi?=
 =?utf-8?B?MXVIRnVsNmw1RFp3dWhXMTRwVWdEbG1zeFJESkpzdm5ieGR2SWpyYkMwTTFo?=
 =?utf-8?B?SmxlYXNKeE9zUnV6cXVnd0E0VndTRDVPTWJobFBaazFZbHpUcEM1K24wUzJz?=
 =?utf-8?B?eGdKaGZHdTRKTW1BaWVXN2dXRGNBckc0YTZrYzJLUVdvOVlrQXpzdWM3VGRr?=
 =?utf-8?B?ZmhOVE01MWV3bHN4TnZSVzFzRVdRWHh3c0REcXpCM2R5OGoxb2x1RWViSUhJ?=
 =?utf-8?B?MGVJV0QrcFcwdFpTdEI0Zi9rLys4N3p3YTFVZ2I3alBvaXY0QnVjOFo2MTBs?=
 =?utf-8?B?YSs5ZnViTzFtYWpuU05PWFRxZlFLWlhncnpqR2NTN1lxbmdNWXdROGtOempk?=
 =?utf-8?B?V0pFQndLdjdOZ3l4d2pHdDIvSWRNbFZhRW5waVlyTmlLSkJFQ2lwc0FJMnJK?=
 =?utf-8?B?Yk5UcGJsdFdPc0ovSUJrSEpzL0EwQ3o1aHNrOHFGT2NhVCtvU0FiNGFnQlBm?=
 =?utf-8?B?Yjh4YU1DcHczb3JVbndleXByTW8yL3M1ZUhMTGI3eVZJSytjcHVLRVZ6VkJL?=
 =?utf-8?B?TStYdjJrbDFUYlVmbnZseEI1U3RFVXMrTnN4bDBKRXZVQzBkZkZ4UHIvSWVk?=
 =?utf-8?B?SlRBeXd2RmpUVnBjTnJUTXhyaXVlNnhraGdXanBMZy9iMlFJVXBjRFhGTTNM?=
 =?utf-8?B?OVE5eEkzdGxzK3UwaDZva3BOUzVJUEpKUk81SENQeGk2MlRGZE1ya3EvNjNo?=
 =?utf-8?B?TXVTUXdPS25ZZC9FdlFWMEh1Q0F3a2JNMTVmWWRjWTA0YkRiajcwQ2xXY0FX?=
 =?utf-8?B?c21DT3dkdUFEQjd0d2NFMDZSTnVidkgyVVQ3eU8vSno2UW9lYittNkNPTCt2?=
 =?utf-8?B?YW1TNnloc1d2MzRVZkRsNUhZaFR4K3lDNWRhcWI1dXVxekRrSTZhdGdxUlhY?=
 =?utf-8?B?TGZoeU9iSkdld1RwZHd4aStIdVErK2d2V296ZmJkUm5MWHRFc0JHUmVVNXRR?=
 =?utf-8?B?bnV1ZGJCc3JkWklCMUZoL1ovREIvcUcxUnY4TU9OODBhemFEUHpYMExMaExR?=
 =?utf-8?B?cVljYVZqcCt3YjNaNm1kN1ZpcC9SNVhVNkRFNW9xdndzem5iTGVyd3QxcjUx?=
 =?utf-8?B?Q290Yk5aT21mOGsvSktkbEE0cEpGd09wQWdlTHVLNlVadlhwU2U3ajludXhX?=
 =?utf-8?B?SUYxZjJZdEt2NVRnRE9rNFJ2cjJvSnEyZzQ3R2VZSlVwQjZOektlZk9OSWMy?=
 =?utf-8?B?Qm5sZG1wbDkrd1hJa1hGZlVuMTY2R2pZVW1sdUtlTlVVNmtnQStFWU5oZ0s0?=
 =?utf-8?B?bzJvL3czQ2l4UjRFanNmaDBWK3FmdTg1VVJGMDFLb3NrZXI1c3VZRFRmMzNE?=
 =?utf-8?B?N2h1QXh2c25DRjM1bVZ6NVB2QXdzaEhDYm4zamhsYzZRL1B4RHlBNEd2QTND?=
 =?utf-8?B?bGxEMFlZYVVrOU9Da01vdW81eUp5S1FuRU1IVG1wd3VZTWpOT0x2MHl3aUFN?=
 =?utf-8?B?VStQT3ArRDc4MTdTRXJIUFV6QlhjL1ZJbFpaMVI2eDFxQXQ3d3IyWWxNdE1D?=
 =?utf-8?B?SS92bkNjZ0JwMDBHMUZwWnY4RmtHd3E3NWxDalg4R2xYMjVoM01KcXFtTW55?=
 =?utf-8?B?VGZTVVZrQmcvRTRvbDhKRFVvS3MzRXRIc0FHZ1NsMGcvNzVmY1dYWFpES0xI?=
 =?utf-8?B?UnRxYTNmQUd1SW1tajlQaGdFTEJjTW9USGxUbGZpOUtZd3UzZkhTSXhqM3Vp?=
 =?utf-8?B?VElPYUdKSVNrVlNJcjhQZzZyU0lSRGM3aWd0cUx6aWtkelZqM1hCaFVIUnVU?=
 =?utf-8?B?a3ZWY2tjMDlPVDVzQ1VQNTFtVjl6Z3pTTUZFQTJ5dlF5KzB3Yi85RG1XSzRp?=
 =?utf-8?B?cWJvTHJVR2xOdU1qSlBKU0tsVzhESVh3UWMvWkhMMG1WUWVzdmlxckRBTkQw?=
 =?utf-8?B?OGZhczdmaXhRVHFjakdxbzA1TFl5WmtvTzVVUVUvRG5EbStOZVFPK1R6ZkNl?=
 =?utf-8?B?VUpyTWQxU2k3ZFhoRHVVZHB2bTJHbndaWGx1T0pRa1laVGRPcnNIL3FwYnh6?=
 =?utf-8?Q?17w47UUzj8a/qmv12+ehVD3ip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c56957-ffbe-46a0-9d6c-08db4c70ce76
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 07:25:59.0501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7niYS7gDpxhYLY7EbsfKqFw6tUAvQ27ObFh5ULvn4XhRXBlV8DqDXZfuUbWP8U3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/23 08:46, Krzysztof Kozlowski wrote:
> On 03/05/2023 15:39, Michal Simek wrote:
>> The Microchip usb5744 is a SS/HS USB 3.0 hub controller with 4 ports.
>> The binding describes USB related aspects of the USB5744 hub, it as
>> well cover the option of connecting the controller as an i2c slave.
>> When i2c interface is connected hub needs to be initialized first.
>> Hub itself has fixed i2c address 0x2D but hardcoding address is not good
>> idea because address can be shifted by i2c address translator in the
>> middle.
>>
>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> It looks like that usb8041 has also an optional i2c interface which is not
>> covered. But it is mentioned at commit 40e58a8a7ca6 ("dt-bindings: usb:
>> Add binding for TI USB8041 hub controller").
>>
>> i2c-bus name property was suggested by Rob at
>> https://lore.kernel.org/all/CAL_JsqJedhX6typpUKbnzV7CLK6UZVjq3CyG9iY_j5DLPqvVdw@mail.gmail.com/
>> and
>> https://lore.kernel.org/all/CAL_JsqJZBbu+UXqUNdZwg-uv0PAsNg55026PTwhKr5wQtxCjVQ@mail.gmail.com/
>>
>> the question is if adding address like this is acceptable.
>> But it must be specified.
> 
> Why? phandle points it explicitly.

Ok it means just list usb hub on i2c with label and point to it. Works for me.

Thanks,
Michal
