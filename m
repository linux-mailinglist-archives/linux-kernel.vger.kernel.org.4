Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78C46AC4AA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCFPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFPUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:20:38 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5167E2BF3E;
        Mon,  6 Mar 2023 07:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8rpRZFPKTgCoahXRkzFGeY2ZNm1XHAwEZvFqXnuZCEqyhlIsk4cjBlUjsAWHXu3ggjicxCiGcxxve3syg3H68DLEHvGd1qcGNuqsFBi258wlkjhXrRwMA7Z1Mf9ihSk7Lt+OCneO40Wx2wrwsG3I1ucfQuVUwj6/4977fewIwk2LsqNqQbYnchfAE7sZ76uSIt88vmBLkfeURbKVJr1ooXaaoYYXnNqpExmbiBI8Z3pZkcjmRMhj13SwqNfTYdkhhVtkatQjdowC7MlRN1OxWGoKrlR6WLwUgi2OTv39wrFu3akG6DqM5b4Cm62ACcHSmkE6dsxSTbatz0OPNhoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNTj4qjdAUB3gn0I935wLnkgaldpAk6Up4Vms5dp01Y=;
 b=LxTUfqISSnOkS1rfmE5LLX9tR9c0cPjS1lgQ+njgZ66FQVjckm86pSvLtzRVFqZgLSrnKYIbNPBxh5XAuE6QQ6vGu9kG6HEH9STatkALPEheQf+QFk5eoPIp174qd75uA8GX/BZjVGTn5PLqELonJik5cTV2CE4dMiEjBZCWMnuV574lzmRkRE/N/5m5O87NYFMShnMeCi4fr/2J1h/8eC4kNyi1VMTyIPU0gAep9WDDSPG9v9T9pM+AvAFyD6YTUGLVSNleC0oPpgX/4NAq9QsZmT76xllVE9EXHuuKD1gskPX3vnFP18kMqHmCX3swa1m6gzmph9KrKr5HqvwxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNTj4qjdAUB3gn0I935wLnkgaldpAk6Up4Vms5dp01Y=;
 b=CVqvXf3JZoC4VFC362EYnLO5vd5TFJS+2ZGFtIKfQ2RxT9e08v3ijgRpiqlDuyBUI6HSWXoUJg/36IH2exMiiTD6WNUMZ7X8pgsWOLc2l02+KNWHZy32pUfOxUJiYfzbcTwzN6tXB9LR3Dhc8JKPN9fHCli9mTlQwGZ9Cwr9Ubw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 15:20:35 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::70f8:b479:637:1dd4%8]) with mapi id 15.20.6156.019; Mon, 6 Mar 2023
 15:20:35 +0000
Message-ID: <875b2564-589b-c381-cbf0-f30470d4a5a8@amd.com>
Date:   Mon, 6 Mar 2023 09:20:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] docs/sp_SP: Add process deprecated translation
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergio.collado@gmail.com
References: <20230306134420.30210-1-carlos.bilbao@amd.com>
 <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <38cb9f23-a56a-f420-5942-0bfeb620306e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:610:51::26) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de59257-117d-49a0-d9d4-08db1e56553e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /njG7k1MPmtZwPfjTgQmYvcm03OMedkWogFDc6RN+UqT5KYpciIbMmRBF8wT6eqOYaAUNny99KXkmrOz4lmLQMJelPu57cjfMro2qQxvQeN3Ve5QicpU7eiANYyoyS5Oep+W7HNDRRdKlJLsPvzc94rA8fcAFC5k/gpmFxJCMgwgBwn0itJB+2p/kxXOMH2CqZzbGU8v5XKPogEA4Inb37CD4BfeYckX6YUj0lBU/ZMjJHLAId96yTk5SV6q4VlsrRMgsxrdj6SvyS3bR/1iGTrFA/JRmGxbrnvgkvvnIDakhYjx9etggRhwzfVVtL3jFSjHcRmJX1sqp79Ue+hC1PRTeoo1sW/1986/Xx6md7SRfwV3s+eaNh02ZYwsGLb+pr5qis8mt8u2FPloa6vHV78ImOBRzGQaTiR6d9FmL/qAef/0d3SJM133s3WIHxppRplqyvmrNCrPIX0XUhTzPOxfGaMzCQUJbNnQEvqU+IJJZ2HPgisSS0eG+dFESSDRt1EY4vE8j4R0X2InHC0WCeEKGtwe75Jr2jZ/TU+n781gFU4rG0L7rCYLYBINr4iZf5EfDDbVg9PkztmLSNNVnSiILYWcuheh12l6VkgBBltpQkR/JcamOCPaLVwCMlL0FGrpQR52pN/UhpVsyK7GdabHakwFgpiMqTuMmhr7i4Mm1pjttiRiexYy24nqkHRf0W8AofXhudmWPS5zryV2b2iTLv6rKrwd44Up9xHo/HA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(31686004)(36756003)(478600001)(316002)(38100700002)(2616005)(5660300002)(6486002)(6512007)(6506007)(53546011)(26005)(186003)(41300700001)(44832011)(66476007)(66946007)(8936002)(8676002)(66556008)(2906002)(6916009)(4326008)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1o0a2tuRG9vb0FGcTI2STE0VlZtb1crSmV0azJ0T284Qm9zeHl1MGpONWpE?=
 =?utf-8?B?Z2J2a29keE1yMks0M2lmMk5XV09Pby80MTNZSjl0OXJLZ25jNTBtaFlHVmtS?=
 =?utf-8?B?RGRhUlA2MGZvUkd4V2l5bkJndEMvLzFMSHpNM2l6ZXRqdnVDSFVTVkpDb2Jj?=
 =?utf-8?B?T3RXMEcrYW44citNL0diczJIcFJDTzV3TkhyZllpejVHTGlpTEVwSEFHRTIr?=
 =?utf-8?B?c0Q0V1d1ZzhSUitwdXNQaWF5TElUZDV0bDBKVlBwUDJkSk9rclN1SSt3Vlgv?=
 =?utf-8?B?R0E3QnNQWGV2SmU2MzZ2QjNoaGIxOERwblJiMlcvWnRGVFFTSTJvRlFlMGlF?=
 =?utf-8?B?ZWxzeEJ5TnFWTUFtbFFHa053d2ZyV1dDTmpnVWoraEFxZVVRc2RBNFUyY0ti?=
 =?utf-8?B?WVBRaW5FbHBoQjkxREM2TjgzUWl5NVRkRkVIeTFraWZYWUFLOTY2RHUreTlB?=
 =?utf-8?B?QUtHSkkvZkhvbklJV3pnbkpxWmRuRVRjOTZoRVFXN1JESG11ZjZlWU80eDhC?=
 =?utf-8?B?RkpiaDE0R3hkNkNaU3pGdjVrQ2V5UlNvakdJRW9DYTZtQS9veUJjVjMxdWNJ?=
 =?utf-8?B?dnljMzRQZ2Z4V2dTa1k4VDhMR2oxbGltY2MyUndWYlQ3VEtMa3JNeTJVeFlm?=
 =?utf-8?B?MzhtTUxud3pGcW5HTlZINlNjSlZYc0JXWXcyMFI4VEVQSjh2SmRoTkxuMUlh?=
 =?utf-8?B?MXAxVVc1NEFZNW1nLzk1a3BZcEpVVlFCd21FeUFDcDFrMmhaYm9WL0tIY3hE?=
 =?utf-8?B?clFLRUdjQzdSbzNRMlRDaEhIZGtMT0RpRHBCdVZDRkxQZHlNUkJJT2F0eGcv?=
 =?utf-8?B?bGdzUkorYVltMlVaVkZyN2JVelNNbXY4RDl0aTczSlE5UHNkZEJJN1BpUFow?=
 =?utf-8?B?UlBkd1BsdVhkT0hDWC9Ua3N6WEk3clBMZ3B6S2VzQ3ZkQndwdWdSU2RIT3B2?=
 =?utf-8?B?czU3cTAwQW9ZM1ZHRnkwbHpUODdFL01NL2Z3YjRKaFE1R25HVFJJMk5JanV6?=
 =?utf-8?B?L3I0RFpzU2hTSHEvdE9TU2ZKUkw2VjE4UVhYV203Q2J1bkhNaW9jdTJCVFRC?=
 =?utf-8?B?Ui9MVWlrajQzMzdteHpXc0x2dVd6L1IrNXNQbCtjTTdLeGtPRC93amhFcGdm?=
 =?utf-8?B?R2xJV3llMVVmOGh6SWpua2wzbTVpNnBvME5IVVplblpsTUtLYWQzYk1DZk9W?=
 =?utf-8?B?b0orT2swWXBlZkNuaWtUcGE4NFo3Q2pQZEh3VTFUU2ZVRXdudElDRnFyY2tO?=
 =?utf-8?B?WnkyT2RPNTVrNnJWUmdORGxCb3o1TjhRemJJWktOekJ1TkZneStCZSszSVZ0?=
 =?utf-8?B?b2JiWWY0d1phNnVxaWlrRUxzdGxCRHF2ZVZobFJMR09OM1MzR3psVlJpWERa?=
 =?utf-8?B?eXY5R0VTaC9mSmg0ZVhmY1lZeThEd1F3dDgyK0hSMXRJUU92UDY0K2RQNld3?=
 =?utf-8?B?eHFyQSttWE9OR04vSmZ1MDFPTlJ3QS9CWnpoWkRQOWdsbzJ2SWpaQ0VuNUxk?=
 =?utf-8?B?SnlPaUtRK0YwMTEwREY2VmNxelBDL2xwSnlIUlJLT3RrTmQzTUloQm5QRWwz?=
 =?utf-8?B?Ly9GTDMxYkwvQ1R4VDVBTW5QUzRsUkduVFBFTGlaMzJYNzhSZE9vL1pvQ3oz?=
 =?utf-8?B?cFFRbCtSczBQQmNWekJPcHpwUHg3Sm9aWnZ2VTAxc0JNRGhJajNhRktnRXhr?=
 =?utf-8?B?V0FITGpZSU92RnlIM3VrN3JlVW5mbHZma3ozZit6dnhYZ2NkM0VNeTZRSGUx?=
 =?utf-8?B?dS9JMEtVNU5IYi9nUGJzNVhMaVhxZVBqcVBKdFJCNG1xU1hlQitYbUVzK2FH?=
 =?utf-8?B?R245SktKYThGNDNqQ1RHdzdTcklXc28zMml5VGhVY0cxNytJelQ3R1ZBYzNF?=
 =?utf-8?B?bjFlcCswU2k5d3pjMGd3ckI1Z2hydkFZUmJJRC9UNHl1M1FWeUZMdEtEOEZI?=
 =?utf-8?B?T1FPSzZRRXB3SjBaOEFFSGhZWVd0b1RpdE1SZWZNSmhpZzVZWGliaHlQamdR?=
 =?utf-8?B?V3ZwMlUrTGZKZHJPUFBiT1phNUZFR3JTQkc0WHB6UFppU29TT0lwMW9xMzFy?=
 =?utf-8?B?d1cyT0plQnBsMnhJL25kd1NzaHo5UDlTYVE0Z3IxMzBBWFJNK0lSSXRKZnZC?=
 =?utf-8?Q?2QN8NabAD234BR+AGJArpQCXV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de59257-117d-49a0-d9d4-08db1e56553e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 15:20:35.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoXezA5orD8tZdvzI5xXsAyqhLVjYZpYLSwUiwS1Y7sXCmPImhLs5bMhy6B7iBvIkhLtEko1DHJDZCat+YzXtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Akira,

On 3/6/23 09:13, Akira Yokosawa wrote:
> Hi Carlos,
> 
> Minor nits in the Subject and Sob area.
> 
> On Mon, 6 Mar 2023 07:44:20 -0600, Carlos Bilbao wrote:
>> Subject: [PATCH] docs/sp_SP: Add process deprecated translation
> 
> This summary looks ambiguous to me.
> 
> Maybe
> 
>     docs/sp_SP: Add translation of process/deprecated

This summary follows the same format followed in the past. Some examples:

docs/sp_SP: Add process coding-style translation
docs/sp_SP: Add process magic-number translation
docs/sp_SP: Add process programming-language translation
docs/sp_SP: Add process email-clients translation

> 
> ??
> 
>> Translate Documentation/process/deprecated.rst into Spanish.
>>
>> Co-developed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> Signed-off-by: Sergio Gonzalez <sergio.collado@gmail.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> 
> To me, Co-developed-by: from the author of the patch looks
> strange, because it is obvious the author did some development on
> the patch.
> 

No, we both worked on this patch so Co-developed-by: is the appropriate
tagging. That being said, Sergio translated more than I did, so I put
him as sole Translator in the document itself.

> Which is your intent:
> 
>     Author: Carlos
>     Co-developer: Sergio
> 
> , or
> 
>     Author: Sergio
>     Co-developer: Carlos
> 
> ???
> 
>          Thanks, Akira
> 
>> ---
>>   .../translations/sp_SP/process/deprecated.rst | 381 ++++++++++++++++++
>>   .../translations/sp_SP/process/index.rst      |   1 +
>>   2 files changed, 382 insertions(+)
>>   create mode 100644 Documentation/translations/sp_SP/process/deprecated.rst
> [...]

Thanks,
Carlos
