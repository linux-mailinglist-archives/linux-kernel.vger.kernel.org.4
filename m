Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B628473B210
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjFWHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFWHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:48:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D51710;
        Fri, 23 Jun 2023 00:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILwYmSk46/biqjyA5dD7Hk1l/xQ2+m/d0kuvzbDMUkStejJ7SwmvQ9w4ypANXWn3Fw0uSCHAab7DEdHAqsKzFf4q4jzTnY/HjdLWgZzhi1XG70uNwouSULXhs/KLXpEmpQ/nr6FLVnrIbJlVnq5o8wtYP6oM7QKF46Dsxhsi4KmBqctGICHwAgnZoMvUO8XV5ytKKqEETM0DfldT7h0sqf7C0FDznpplb3P73cHTpTVsNf8PvRgERxVWKo5LJMX9KMH1TXEDfhSfDRAWmMRMu/J+XlI5Sq9YPk+e1KR7tXcxMk2kZgdVwQ74vUlRF5M3cNQNp5zZsRJkWSNZRX+Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KECYEsleJBrPBZ7wIA7R9ASChxxBTSHh3OZIhiUS6Y=;
 b=go7jquPTZMToYugpsOl5oxF7jVgUDOpGW9wyxo0x7brkr15d6Nc5zgAO9NDafLQ7liWL44SuTM237KCbFZ/s2GfLvKb0CiZwIvA8tygtmX3/Wk3ldQ3SgmMzCm9YijL0eCjsasbeu+8O+5OrA2Ssdpdqrfclx943Ds5Jgjvx4d66pLutEMd0iS+aoRrQ/U6apNOYEkmc05cNtQkP5alLhpdT25LK2ZXY5SZs8LStvctNNhd70Od8xRJ6u+gVxhmTR7OM7GDfITDgu5ijcGsRKrrqaaN0fDiGzEf89zZ+eu2xo/4J+a37+kWo88DYdJLz5lDp/Rhp9EBg3nPORP7GaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KECYEsleJBrPBZ7wIA7R9ASChxxBTSHh3OZIhiUS6Y=;
 b=azpygwhMVwlmJ47CPpMWzf0y2Z3q2hMLmqp3KrPcO+93TMdDVS75W00f043awSFTYHQkoXzw8ultDCRCe7XykuhmQoGQxNQ0vgqkbWMrslUNg5xa9oZpw7ikPh/waPyT02yDL8Rwut2O9wWxrqNMu6C0NQcRPtsXmhkaRgkU/GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 07:48:31 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::6ad5:3607:d622:669%3]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 07:48:31 +0000
Message-ID: <8bda5b4b-54ac-0b20-4167-686856347e54@amd.com>
Date:   Fri, 23 Jun 2023 09:48:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] can: xilinx_can: Add ECC feature support
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Srinivas Goud <srinivas.goud@amd.com>
Cc:     wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gcnu.goud@gmail.com,
        git@amd.com, michal.simek@xilinx.com, linux-can@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <20230616-unneeded-denote-eaa4053514d8-mkl@pengutronix.de>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230616-unneeded-denote-eaa4053514d8-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::6) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d17852-6462-4bec-003b-08db73be3d02
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SERuWO1F+lQ7LYAG2XYxqouqVE49qqVlUfD25ZASGxAGwTstzggvVNd33lXomsJ9nMv2jjZI0FmB96SuaRNjXtE32uVPTVwL9oNz3hfO0cQb4pvzVne25nQH2FywgP+Ux5HrJ1+NPplk77awOfhIU5JP66IjliQ63vVTYvPNq9LrekcJ1h2txy66WN8awdCO+olt1ka7gcpk2IsOwwgPtQ8ptfWwtg6niSh6W6vJGHjM+crddS/Vj2/6lrwqp3rydreCTUSmgx/wfP9gtvM+7zm1CME3hPC+HxOpxFt6MdLpcwn+4Ov9ZFHXOCJypy3KQgSQl1s/wSG1eUATvMiW04OryRfDgGWQnlToWPncFybp55iRZbYhBLD6rILPFnk0mqJDvXuLEXPwRS9VhQ0254VhhW3RkXfex2j2X1cq/GPv+tSkIL9hNUE/PEkS4LtgJkGjXvbt5AZnptHar9Pi7RKp0x7HyJ2gG2UBVBeJk7R7J0wnlNDY52EXfHvAhg3k1O0LnpIp1/nxffcyvj7JQJvTmcYYeQ62CydHuA3qgXb8EONXYdzwM9GPRY7uqjOBHdpMZ38vdSYTHleixHVw+o9n7I+dWXzyGsYzkh2/fngXjVtmMgA2akX/8HBfLvKmzRooy5uI78Ux9shBK40StQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(38100700002)(31696002)(86362001)(2616005)(316002)(41300700001)(66476007)(66556008)(8936002)(8676002)(66946007)(4326008)(31686004)(44832011)(6636002)(5660300002)(6506007)(53546011)(6486002)(478600001)(6666004)(966005)(7416002)(110136005)(83380400001)(26005)(186003)(6512007)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FmMlVGNDNhZGdsbUVJZTFXeXdSdzJ1M25QSkpuaUI5eFdlRm90NWU4enRm?=
 =?utf-8?B?MHZvM0Ixc0lBeE5jdWw4T1gwR3VKSmRpaXRuYlFNWnFNb3FmaGxXU3o0YVlj?=
 =?utf-8?B?dXQ5LzQxbGZNTTNqS0FVM252WFJDMERZeEpYU1FGUWUvTWt2a2hwZ3FVd0pM?=
 =?utf-8?B?VG10MXFOSWRZUkhDSkhJczd2ZjNmSGZmMy9wZmU2d3VOQ1RwSmdpamJIaStp?=
 =?utf-8?B?YjZwTE84SEJKcEVqNjd5Vjlmakp5OXZiUTV5U1NOYVpDRmJ6Q05BRWhYY3E2?=
 =?utf-8?B?VkxLM1A2RFNObjRWa1RKZFVZNDF5VEs5K0JMS1FpcEd1MnFyemkrNnBpejZy?=
 =?utf-8?B?ZlZ1SDlGV0o1VytqWHU5N1lBU0hmNFI4b1hyUjhUbEkyaFMvSjFWTWd4c1dJ?=
 =?utf-8?B?ZUJQZmdML0tmbHJBRUdqTzRoTzNvR2N6dnJUU09abG1UcHZVWDd2SlduNWlr?=
 =?utf-8?B?aDR1UnpuRU83Qlh3Z2syR0FjUXRQbGlwb3JlcFRja1JvRFBjbkpzT2FhU05Z?=
 =?utf-8?B?ampvejhqVUUrNUV6NWt6YmV1SFQ5NStSZGVMQXVRTGlNRjNSMXRpaDhhWHVS?=
 =?utf-8?B?TThldEFaajFVdDkzZWMxSUhVOElRWnRkY0lUVUpPYitCQnJTYTZoUWZwVUhq?=
 =?utf-8?B?dDdWRHJ3TEJRQ0IxWFV2TzFYeUsxbkRpQzg1cTJzaGxyaDE5UXg5ZEg0M285?=
 =?utf-8?B?VnNiRitrTC9XWE1EY2ZxOFRJQWZVSTFpWi9TaUNUblJDeFd3NzlsTFg1QXRL?=
 =?utf-8?B?S2M1eENJWWcrOTFJcGl6STl2akFIbEpsTUo3NlQrTUR4V1lpcndHV3VjOXlJ?=
 =?utf-8?B?cUkybHVnQ3BrWE9FdCt3aURoQ1ZxeGZPUWxzQjNvRUhGaCsxQWJVQndET3M0?=
 =?utf-8?B?d2dVdUNKR0JZQTVQK2ptTnFIRGs3YktJanFUYnY4Q1VYWFN1OFgrZmZON1lh?=
 =?utf-8?B?RHFYUklSV3plNzJZMU1qYXdqd1U4MTM1Zzk2SDRQbVgxYnFwRi83cStXWTN4?=
 =?utf-8?B?ay9NVytqRVcreGRVakJOczl0K1czd0w1YldvRm92NU1nWWkySURpQTl5M0hX?=
 =?utf-8?B?SmFnZEo0UitVZE40NVRCN3NEdTJJdzgrcTNrSHR5ajZEdE9jc3BHTEI2NzN2?=
 =?utf-8?B?OEMraTdYSms3eW8vVUpOZXlaQUVsNEpqWWVUUnZodEZRN1ZUVVVickdGeXh0?=
 =?utf-8?B?UzlxUDhyRjh0WVhsV09DZ2lKZWtJMjB3RGMrVGdKSXh1RU1uSHUvNU1SY1Fk?=
 =?utf-8?B?SWFQU1EwVmZYWi9xLzVCaWxUS3ljTTU2S0hkeDBlbTBEc3UzOEI4K3p5djg5?=
 =?utf-8?B?TkhRdGxkVzUzcVRPQ1Z2SmY0RHBQa2wvdjVxK29Wc1ZtSW9rU09nTFBkMWZk?=
 =?utf-8?B?Wm9WbklJM2R1aFNSaWFZQ3NIZjEya0V3a1d1c1NqT0xzQnhrQW9DUDNrMVdT?=
 =?utf-8?B?ZlZrMjFvMitYNy9IUzQxejM4akRiNTY0MkNMSDYxUkxObXE5ZS9WNm4vVHZW?=
 =?utf-8?B?aENWY0NkQTE4RXdaKzBVRG54TmFROVMrenBYanJZK2hITjVXY1ZPVXRvSE83?=
 =?utf-8?B?N1NuVjIwY1haUlFBOTBtRGVDZ052VWtOci9jdG4rQ2NlRFNkZnVqeUw0YzVu?=
 =?utf-8?B?S0pTNUo3M0o3aUd1QmExYW4yTTBIV3RuNE14dUxzYlpWellSKzFqRVdWbmtG?=
 =?utf-8?B?bjl1NVdKSDRRY0h6VkRwMUZHSC9KSitTTWw4Y2ZraDZTNTBIbk1qRjljWjNw?=
 =?utf-8?B?dVAwR2tabVJaZlROQkk3Q05rSTEvaHJiMDdxWEt5UDBORUxyQXhaMlJSMUEx?=
 =?utf-8?B?N20rcllPZThEcjZrQXVQV2U0WUR6V25nVVBEbWt5WXJhZGFtZnhBTnljRnVr?=
 =?utf-8?B?Q2h0bFYyYlc2UlRRUkpBUDFBQjVHeFltMm1ObnlqaGVPb2tjTmhKK2tXVHdE?=
 =?utf-8?B?QWRNS1BnbkpMZnZuemJNd3Jrc2FMNk41YlZRWEtIRnVDd2h0dEtBOEl6czBJ?=
 =?utf-8?B?ajFGd1k1bDVZL04wU1FjMktqbUdQVGVITm80SHBMNmVuempjS0NXSWlpM1cz?=
 =?utf-8?B?cnhzVUFBRGg2bVVxWkU1dDlWNWMrSDN0aDZNNVhDMnRVNUYwdU5yN1BwbzdV?=
 =?utf-8?Q?ccd93EhLb9xx6Ou1wz5hh+VAp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d17852-6462-4bec-003b-08db73be3d02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:48:30.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfP4yqPXPHJQeDyrFJCRgTAueJbh31iQlx6rgJaGGBmsgjVKDW4q/FmkV31K0jlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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

Hi Marc,

On 6/16/23 13:12, Marc Kleine-Budde wrote:
> On 12.06.2023 17:12:54, Srinivas Goud wrote:
>> ECC feature added to Tx and Rx FIFO’s for Xilinx CAN Controller.
>> Part of this feature configuration and counter registers added
>> in Xilinx CAN Controller for 1bit/2bit ECC errors count and reset.
>> Please find more details in PG096 v5.1 document.
> 
> The document "PG096 (v5.1) May 16, 2023 CAN v5.1" [1] lists the
> XCAN_ECC_CFG_OFFSET as reserved, although it has a section "ECC
> Configuration Register".
> 
> [1] https://docs.xilinx.com/viewer/book-attachment/Bv6XZP9HRonCGi58fl10dw/ch1ZLpOt4UKWNub7DXjJ7Q
> 
> The other registers (XCAN_TXTLFIFO_ECC_OFFSET, XCAN_TXOLFIFO_ECC_OFFSET,
> XCAN_TXOLFIFO_ECC_OFFSET) are also listed as reserved and not even
> mentioned on the document. Am I missing something?

We cross check available public documentation with HW team and there is no 
public documentation for this feature yet. We didn't get any exact day when 
documentation is going to be released.
Unfortunately it is not the first or even last time when this is happening but I 
still think is good to get this feature done properly till the time when 
documentation catch it up. Please let me know if you have any concern about it.

Thanks,
Michal
