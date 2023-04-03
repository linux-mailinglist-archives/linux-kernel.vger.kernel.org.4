Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047D56D53DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjDCVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjDCVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:46:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9A74EDF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYRQOiAr7hPYT7Oncu9w3+BxEpmNEXeGNVpeADEMfUv1XMn+gSMMjzXFxxWo5sGcsWg0VGJ8Wo4hynOswTzZuoWD8RsxOYiMQUMYM6koJoJt9ynMUqsiMrpHEsinh4vXNRzHv6DDJKfKFuGe4rbYIjNnrUpUtjPSchxA34p9ADWPTL5CdhP20Vg2C+Ga05ktczMftiUgUxSk12IjdsKpQvoqea7JSNhl1HcmP2V267yeyE9ZrRgar/wT5EZuvCToHO4IGtcKdrYJddw6dpW6zP3I99+UtWNQRyldRG6Xcl+Se47LgYAExGLZ9z4yTH1z+EwfsF9rceGUCxfCASnKyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skwb7VmaYyBosJXCTLOuvnxftu3152XeKxpx4qUrMIU=;
 b=T2XoX8LUGb5mkDp4VQ/+rbo75u7iGtWHbVTi3sBM8hjzotVdnfJKJc+PjyxlgjpnmKxnWEfFEimUEEsY1+3g79wOqkqRMOH2N3wzQnl4wMtPyLr7ZdiOqemxhJ8FvHQX+IZ1XFVzeaHWJubGpYxAZcQqpGs9rGmTy0Sicaaw4qk1MABYjJ8Vf91f6+TTF6hSScQF6THr7C3g7/oS+zcMVCss5bFjiFaik+RXKme8VkBE6zjbu9ml2Bky7tWS7QeCNqajgrRzS5tMsweIXyDXaUPgMl0o3kHcU9XwzzWyISvOO/Tf2ymWOPoAS9aZY2QkbHbGRNoeVnoguMaAUwE00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skwb7VmaYyBosJXCTLOuvnxftu3152XeKxpx4qUrMIU=;
 b=deBdpP4pyryuD+L9wWPAuzitKTj3loxjYpEwqZnmIm55ASEjiVtaUVA7XchnmrhQr99KN1AFeOlr6nhj0zJKmSugDJuKHjMtI5GeBBPbqTq/pdJQw2dtwglXG/fCi1QSs9o2++Pqhryf2iCJY2RXM42+OUMMjnFCnMLDN/sagn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 21:45:20 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 21:45:20 +0000
Message-ID: <b288afd7-b596-24b5-a00b-358bbe609085@amd.com>
Date:   Mon, 3 Apr 2023 16:45:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/11] x86/kvmclock: Use Secure TSC as clock if
 available
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-10-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-10-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E08.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:5) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 5131ff1c-5cb4-4a30-9527-08db348cb875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7J4++QpKIJbelohiFFvbnkz+DZWuRXkWjJ8DqbjbfmEB0pfpAAtjowIN+y5NausRy7VYY9TRXpo1Ktt6HYtd7dzbUx/7CspLtiJ/e8a7gJwrFM1p1AB7vPM84bAlt+RICafeyl03UCDUuyrSFx0QJL6hHtn9C84AvUU0JfUKurCXteEgn23+j+TRrPuNB4bKwPYVG+43pTm2AKYFovFbch0OVnD8AimREgCS41aS4GvtD/PMJSd2uoeBGTqWIIWmOc6OZZvCIZDjOBFR2V07OdkbX+2ABj7J4sibAYrNL43lHLmbRE6uItwtvdLW4b84KIIJNwFIu+WmMA2wgJMscJyqU8Q4PpEwOl+T6Y/rTQsK1K3cMJvCDumMqUeJeVBka8WsR6JHs3rfKHRrj892pldOxbf1RXkIVtLAqYMEAcBPTd50ezeNadm9w5DcDUT8J/Ew9v+1X1EyAXzYMVI5sI8OgXxbM4dWyki5pk6ZkTj13d4CdpBry3ElnxIaeg+VQHZNWhGgG6+Sucjg5c4I74da4+TK7QN+HSrO+QAp4s2IGA2k0E4ExVyeLD1S2iai78m+ivyPm6qZ7Ij/b8Q6bBXs45A1OGvvZ6rqbpPFLp4SIRzR0xGmbAyqw1t20PoIgwzAHL3Qp7TnahMq/UCPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(31696002)(86362001)(2906002)(36756003)(31686004)(53546011)(2616005)(186003)(83380400001)(26005)(6666004)(6486002)(6512007)(6506007)(66476007)(66946007)(66556008)(478600001)(8676002)(41300700001)(5660300002)(38100700002)(316002)(4744005)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JVcm8weHBUOGhrZHZPRHI0Ym1SUW5DMHFJVElCcXRyVC8vdnB1SmRoOVMx?=
 =?utf-8?B?K1kxdjJEdzRjZGZNVXdNNERRWGZETVVQVXZFeGU5NjhmUDVhZUpuVXh6V2hp?=
 =?utf-8?B?OFU5SksrUlRNYXRqYmF6T2psekk5aDhLa09OM3VxSmw0Ukw2L3JFZFl0aW5H?=
 =?utf-8?B?dk43SkFCQklHNVRkd3FjdXlmdkQraVVUeE44cSs4SFpQUDl0WHVKb09KTnlm?=
 =?utf-8?B?ZDJGalBRSWdwVGJYVWNqc1ZOOTNVZ051SFpHQ0VGQkJmZ3RvT1BtUm9yR3ZC?=
 =?utf-8?B?N0pFMzFBRjY1UlRkNFQvWVZSVHhyVUJ3eEFFUk9sUndCU2R1L1cxN1R4WWty?=
 =?utf-8?B?SzNTaEpCQ2xCbU92VWQ0cWwrbDI3Y1FKbjlpYTBuYnVPN0ZCRUd5ak1Cend1?=
 =?utf-8?B?ZmtQRjJXSlUzc0FVOWJYVVJKOUY3cXBNUDgyS2NML1I1enJtbzVtTXM3SDhE?=
 =?utf-8?B?eFcvR0JIUW5QUlc3S24wL3daKzR6MVdFaXNGaWRMZjFsNnpJZDA2REhLVmVM?=
 =?utf-8?B?V2RYNUtGYVJFeWs3VGZDUVcxSzJoaW16SVhoeU9WN2ZURzdhb2Qra0VENXJP?=
 =?utf-8?B?aGpjZ2dMaWhSa1FINGcvRm1UeU1Pemg0MFdGNFdzdUUwWXljQm5GTWtYdVBG?=
 =?utf-8?B?OHoyNEE0Q25TekcvUXVZaTh4MmJnSU00ODgzbjdzWDRuQ3AyZy9GRFc2ejdL?=
 =?utf-8?B?YlFKRm5uRFlaSzVoc083RW5oeE1udlFvMXZwZXlGNWhWakxXUXlJSHV0Qzht?=
 =?utf-8?B?dHRYRlBXcEtpWDBKSEtzUWx4c2VqVFJDck1JTkhJYWZHQThnTE1udmdCWS84?=
 =?utf-8?B?em5wSjJYY3k5eTAxaitWQWFlMGh4VGZHVWlLTmEvaVBYZkszV1AzN3JWNHJR?=
 =?utf-8?B?b01qbkRsYU5NbHB6NDRCSHk0bFo5QlRtUWh4aVhCTll5WE1CNlo0bHMwNmUv?=
 =?utf-8?B?b014NDB3b3NVL2J2QWZWNU1vMTZLVHVtRHZYNm9yTzhCT0JJVzZ0VHE2Ympz?=
 =?utf-8?B?UGFrbXNDeGNUeWxDUnJFSTVQa3M1NEZTaEdvOWJDd1hiZnM1TjBpWEtYcXg1?=
 =?utf-8?B?YVAySGpCcHRlMFNkRzk1U2hTUGs4YVZmaEJlbmVKdURDTTNOcGx0bi9mNHg5?=
 =?utf-8?B?YkVxbjRXb0ZLbXdpNk15SnFZdWlpdzNUVDVsaE4xdWlnUUNJeHZtRlA3Nmc5?=
 =?utf-8?B?RWR0L0trT20wb0d1Z1A1djY3V3JrWDVmanBxUlFwQXNGT0FFc09LMStlUVFn?=
 =?utf-8?B?cUNBNVppSlNyazZQV0M2dHFSM3YxM0ppK2RjeC9HUUpIR3pSajQ3K1Joc0dp?=
 =?utf-8?B?clc3N1lzSkFWVWhvR2xCVmF2dzJIUHFSU21hWVo5YXJnZFVIYkgzYzFQeWt6?=
 =?utf-8?B?NHoyTk5wSXhmWUxQM2habDlQSkpRYzFJTnhZRHp1OUs2Vkl5d05NYVlKcmQ2?=
 =?utf-8?B?OVkza0d6aVl6VmJlNGZYVGVHZmtlVG1VZlRja1BueENrNHMyRS8xRytUa2tW?=
 =?utf-8?B?cFZWZ2RCYXpzeG9sZmtzcWdrTFV4c21YcE8wTWc2b2JvR0pBV2pSRll6dHJV?=
 =?utf-8?B?UVVIZVg2NmFzMS84cGl2ZjlJQzZ1TFFOYTdaeWRaQk9qTHNvUDdXLy9taW5C?=
 =?utf-8?B?Ny9BS0N2YjlsK3BxNzhnV2tqdGtHdkcwSk53RWFhWDZCQ08ySVNRbHZ1d3dz?=
 =?utf-8?B?TVI2SHl1UjluVk9KbFNxdkhPbXpkSERGbHB5RE1td3V2WW0vZS8vYnV4akJl?=
 =?utf-8?B?WnpkYnNwK0g5MEJOSTJGNitaVVUxV3BDcTFoVk92d2ZvN2pwejlSN1NaRkxQ?=
 =?utf-8?B?NVFsZkp2U1kyamh4ZElPemZ3aEtZTGdaUVpUaEFoWmk1cHd2OEJqMVhGa3R6?=
 =?utf-8?B?NFFpcGVlN3prQ2FHRWFaakVXSGZDM2Q1Y0ZXMVZoWXF0N0xINHRwazFCNUJv?=
 =?utf-8?B?cnpVTVlmM2Rac3RJbm1xdWM1bVBjeGtPK3pkOWN4UGhWWUZ6eWN0RkdHc1d5?=
 =?utf-8?B?QXM0eElGZG9XcU9kV3k0ZmVYTDVCNmpQWWRLTVk4YU9aUmFxcTQ1UmtETzJU?=
 =?utf-8?B?amppaytNVjFCQVJWSHdwT2tJRFJmK1R3L2hubGtqOHo1UEg4NHROeWRkRlB0?=
 =?utf-8?Q?SXat1oq28w3rwO7ureTrPVqEK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5131ff1c-5cb4-4a30-9527-08db348cb875
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 21:45:20.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Alg1lE0uxOP9QELZ/fXa5FUiY0F2jV97IfukJS9odnY9nHLDR4B8qeNG1tvnG8UO4ymrs3vdSqujFVu94JALjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> For AMD SNP guests having Secure TSC enabled, use Secure TSC based
> clocksource instead of kvmclock.

This patch only results in skipping the initialization of KVM clock, it 
doesn't cause Secure TSC to be used as the clocksource.

Thanks,
Tom

> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>   arch/x86/kernel/kvmclock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 0f35d44c56fe..1be342064851 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -288,7 +288,7 @@ void __init kvmclock_init(void)
>   {
>   	u8 flags;
>   
> -	if (!kvm_para_available() || !kvmclock)
> +	if (!kvm_para_available() || !kvmclock || cc_platform_has(CC_ATTR_GUEST_SECURE_TSC))
>   		return;
>   
>   	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE2)) {
