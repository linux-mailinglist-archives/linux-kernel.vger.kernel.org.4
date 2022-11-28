Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6E63AB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiK1Oxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiK1Oxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:53:31 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678761F9C7;
        Mon, 28 Nov 2022 06:53:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKiiqW2E8wPKVCeEIDNRWIMysGTZT5Yo06EQkck84JQsjgPwvynqd4ykmwKc5+a3WfK6ZjKs/APKmwtroO+FmC9sgSCTIb3LIsMwLeVqmUHNyPBlWjLi4dZ5087rDTJnXUcv+YUJEIRq1aRLxfIzBaic9Cr70OX8pbqr884E7vB9Z02LLwhEm1ulHDHT9nQik6MypKPCu85wckTDa3qrqbb4SD+NMY/CwfMvlXRiH2MfXr8PVgpyuh2YlmwWzr+TvOrj0t4zn73cE3DvQ1CbN46scobODqCHkVF582iEN97DK+EK/UIIZ3nKraYgUp0YZZPnkpq0mnS1XVeznWWTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvqANHk1zaYEqCxlAeXiUJGAdTa8cUpg2yNzMST8/FM=;
 b=JFr4g6XjqpaAdk9kbAHRmQU0OYkldIb24TfEQq5sBHvmvU/vIlmhxDpdatd96AJbZDBuj0XHG0jT5kvAT7Yp6wlofzgqvRaXzVBlYEeWYBsSSH5Fo/kmiNnrocHsiIRjfubCLSzYfHp7KOQ1BXnY6QoCIvaqKD2vDAkaFgpUPZyk6AQRurYJc9pSPciz+NB42P02FBLx3hE5KvLuU2mFs3YBwbf4PGDlOP1/+5drhSHRvaS48SDBZTdn/NjgaqEyeZn8vhAwsqwoMFLDeTSbVJjirStmMKsHstn63wKP9LCZvznFmsAAoMS8a24F+0VK2N0dm0Fd6ZFpVg5WTGiVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvqANHk1zaYEqCxlAeXiUJGAdTa8cUpg2yNzMST8/FM=;
 b=O99vMvLpfXqo1D3yo4kH1g73qzz1UkScGUdkVSXzG9KISBdb6coO+jW3pY6Lhjdthday5bDo+ki61RdyjV++ha/I0Xy/KumZB1j5DW5UAfx/Fh/hIRgd8hS3uSaJrp/F4VUX0e0sCA9pfGcjZsED0ElbGm82Z0YaytVt3EpCBME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BL0PR12MB4884.namprd12.prod.outlook.com (2603:10b6:208:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 14:53:28 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 14:53:28 +0000
Message-ID: <6b1d95ed-3000-3baf-81ae-7794c9515e3b@amd.com>
Date:   Mon, 28 Nov 2022 08:53:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] docs/sp_SP: Add memory-barriers.txt Spanish translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, sos-linux-ext-patches@mailman-svr.amd.com
References: <20221111174739.2471900-1-carlos.bilbao@amd.com>
 <87fsec9foh.fsf@meer.lwn.net>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <87fsec9foh.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:610:57::15) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BL0PR12MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: e22bb851-e011-4387-a3ea-08dad1504ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIDhQw/gtqJV2AUBHpDgw1LEWQ/MTPvC4YjNwAVbK/XUaEjEoqoqbtHIprhyArupGGtKhkOXC9EK/ut2Sc/nK6ghC90brNQcC+cM4SGJakf6cBcHBuG8ifYJTBH1ZTUghIzW6vgLDaIt0lHyl/uriunvbEZ8CDlP0VE1tW2MLQ8xkrAmbIE+Nc0x5WgmIVRpkkqqRLE+fruwNkBs/h5fcXejmLIDvzkeEG5WBXGtKnxPserYy5epwDE0aLGBWSmk6D6xPYNBUD3JXFJ8dmCxwQcshQPs4ddg+f4T94sDcQyWK3z8Z8px92CCTylue32oSFd3+CeXlV2Z6ZcLQz3nSVs2TgVmjaZr1ulfspEZSDndnzc0fpPbvMR3wOM124ljbtuxNKqI13KBVpULEV3I3Rhww110BgW7vO6idPk5dpc7Uh02Xf8hFdCQELIKtgbi1dvaw2BsxCupX3c2m8Ca5i37IZB0rkwD1F6axmU/MkVS8v12M9JX455t+kZMpaWEIHGnUcnb0o9OTQoK1YpO9hyUvoSzNUs3SGsCxELk0kwwNWLR44/1VxDDxm6jXCegrU0ruJNz++hFHPo4MN3uyjzfla1lUYWB8wnXSoBcy2S7/fgw+LY5g8VAX2JmP5B8y0nkCCx9slSgm96yS+LWUVYTCScbBpC3B72tZylwyqfFa3lTsenrB+JsI8tYN0gD/vlN7o46vz4EJ1biwBg8SCiPnpSgij+XH7pY88/d/SY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(8936002)(5660300002)(186003)(36756003)(66556008)(8676002)(66946007)(4326008)(41300700001)(66476007)(6916009)(316002)(38100700002)(6486002)(6666004)(2616005)(26005)(86362001)(6512007)(31696002)(6506007)(53546011)(478600001)(2906002)(31686004)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE5VRm9YYmNESi92cjlRMnhyMmw0amxkOTRablo1UDdadkRXamdEcFBYeUFW?=
 =?utf-8?B?aFA2UXNMMEgzWVh2SGxTdVIrSzZPeWFVNDZIQkcrNDM0KzJKT01ZVEZoNWN0?=
 =?utf-8?B?bVdFMTlBRFRkQ0tndVFLZGZaZUJMbk5rYUdWZnZVaDltT2RxNXp6MXBtYkFH?=
 =?utf-8?B?bThnK1FZVnFHbXZOd3NpSE1VNFByYnBWakwzMDFReUJmUUhQWDZPcC9wL2lM?=
 =?utf-8?B?Uy9JTFc2a0FkTGVRNGErd0k0dVhPekYvbGdzU3VYWWVHR1NNSkF5MnFCczAr?=
 =?utf-8?B?dndWQWxjSTJoeElkWGpIbVQrdFZET0ZmeXhZa09rVENoaUhlUDNXeDJDWUQ1?=
 =?utf-8?B?YUdJNnc3QXpjK2MzTm82REJMc2RZUGZ3NmU0TUtIbTYvMXMwOFAyYVpJUElq?=
 =?utf-8?B?ME1SblNGN1VZME01a3JPQThBcFFxL3hXYnpQUEs5aEtyd0FYZ0FDNFNPSUFP?=
 =?utf-8?B?OVY4QkdiSkozcnY1ZGNxVzdtcmxjdzVZT2poUTFRZVpOcVJNUElpNVVwUVBU?=
 =?utf-8?B?eHlvNDRETVFDN1o2U1BWY0lKYTNsNEhLYUNkSEFnZXNCd3BkL2loS05OeW51?=
 =?utf-8?B?Ny9uQVFVajBXd2svd1g3WWhabTVmYXBJNUZkVmp0bDhsVG5UY2N3Sm5OdllD?=
 =?utf-8?B?Nm01MzlWMzhRUllJUlI0Wi9ISlZhUzhoRVkxMmIyWEhyYllFMTlORmM3Qk8r?=
 =?utf-8?B?QzFWYzFUM2V6dlBYekhVbS9LblpUV203cjNwb24zZTQ4ZnNpbU9PdXY5SDJF?=
 =?utf-8?B?Y3ZCZ3hDY3ZXeUxKNzUraTBieHVueHJpUHFOY1RlUzVkR3FneG1xYW9hU0li?=
 =?utf-8?B?b3pMN2FyVEFpMnppL2g3MUZGeVJpZlZDWjA2YzJDY2RhWUh2RVlTbFBtZHVr?=
 =?utf-8?B?Z2ZtSzBzbHo0V1VMY3lwRHRGVk00WHllbHByT1g1OEpHZDEvemRYQmVHQ0xa?=
 =?utf-8?B?WmVuRSsvNGxmRjU2YkVuZGNQNmNKWUNrQTFBWXlpdTJnTW5GODFQdWZ1SUY2?=
 =?utf-8?B?OVM5WE1uNzB3RlNPbDQrVzFQazYxclAraG04VnYwRC9ZYVJoZTNtWTVqbDhU?=
 =?utf-8?B?ejd2bkhYUHU2Y1Rxc0E4clhoT3hpbU9wanRqbnhZNUpkM3p6Y1MyRG9nZ2tU?=
 =?utf-8?B?dlpFaldsYldrUE1IdjUxU0tIRVI0QVhFQTBLaVFCN0JDNHVNdlcwMUNyNXkw?=
 =?utf-8?B?RUF6RXd4OUhkMUpnQjFnVG91R016OFhROVQzYUt2c2ViZUVQNFJ3RTJWQ05T?=
 =?utf-8?B?bVVuVFByby90c29oWWk2MkM4cnFPcCtNa3JHb1dCckVBb0tpcnNxMHpHUGV2?=
 =?utf-8?B?TUhGOUlvNjgrTEs3NjhXYy9PbmxqYjZ4ZE41Z3kwQXJRam1naW9nWkQvNW1t?=
 =?utf-8?B?OVlYVkZVVEdnWk1aU2c3ZkIyV1lyQ2J2MnBLb2VGWDNnUGwxVm11OEhZVEhE?=
 =?utf-8?B?amdlcTdlUXZPV3pEcHg5aVJlYUlZM1FSM1owZWtzeVVVdDBVNEhGR0FkRkg5?=
 =?utf-8?B?VW1TN1R2clV3S1ZrUXVsVGdkNDVYTSt3K3lEZFoxNGtZNnMxUlBZVHF1aVB0?=
 =?utf-8?B?SndwK3g5enpaU0VaeHpKOTQ3QW5RQ2RQaHBwUDhrdUFDR1N6eWVENVJZaytn?=
 =?utf-8?B?OG52RUpvVnhPeTNmcm5Kc1Vadm1VM3RNMW4rSm1lcjBRTUxtMGQ0Tmt0M0Fi?=
 =?utf-8?B?RFNQOEtzaXg4Z05lM3JmV1NDWG1oVGp1aDlxZG05NElrTGdwdU5OOWhnaVla?=
 =?utf-8?B?VGVncEJXZ2RvZjl6K0kvSTFoR01oMEgxSWhiQkpwWlUvMUtRQ0tIcS9qeTlp?=
 =?utf-8?B?dEJIRkhZa213aHR0MGdZOXEvWFRaYVF0dGJnZ1ppUmdiRkpSUC9oejB4ODlw?=
 =?utf-8?B?R3p6U3FQTTR6VlFVdlFsWjlWWWxNdG5vcU8vTEcyTEUrbU1BVCtQa1Q5MlYz?=
 =?utf-8?B?Q3ZKVzVHdWRjV2MvbExUY1dwYkhpOStaZjJHeTA2TmNoRVFzMmpHWmJaK2s4?=
 =?utf-8?B?WlVaenJPWGtodjMwMUp6Z0E0T2pmbXBYTUxNR01BMTkzS25kUm41Q1RWOFJB?=
 =?utf-8?B?QVFoTWN0KzRmd0lsbWphWENLRjFzcEM1VHVPeE9NVVJPU01CbzBJVVliY0dw?=
 =?utf-8?Q?o0RH1adTtzRgZFswkDnQP8Me4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22bb851-e011-4387-a3ea-08dad1504ee9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 14:53:27.9119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LubX1UXSKGA7J/QssGvfQID7vrbubqHi85KeYpnIe3guZ5tP+pFxOpdkgSd3B9vD2EWH0xYLVRYeVoHxQkt+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4884
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 15:10, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao@amd.com> writes:
>
>> Translate the following documents into Spanish:
>>
>> - memory-barriers.txt
>>
>> Also include it on index of Spanish translations, following the same
>> approach used by the Korean translation, as a note at the end of the index.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/translations/sp_SP/index.rst    |    4 +
>>   .../translations/sp_SP/memory-barriers.txt    | 3134 +++++++++++++++++
>>   2 files changed, 3138 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/memory-barriers.txt
>>
>> diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
>> index e20dd6e875e7..61dace3df9a6 100644
>> --- a/Documentation/translations/sp_SP/index.rst
>> +++ b/Documentation/translations/sp_SP/index.rst
>> @@ -79,3 +79,7 @@ Traducciones al español
>>   
>>      howto
>>      submitting-patches
>> +
>> +.. include:: ./memory-barriers.txt
>> +    :literal:
> That's an awfully big "note" to add at the end of the index file; I
> don't really think that's the best experience for our readers.  Can this
> be done using the wrapper documents like for English in current
> docs-next?


Yes that makes more sense. Sending v2 :)


>
> Thanks,
>
> jon


Thanks,

Carlos

