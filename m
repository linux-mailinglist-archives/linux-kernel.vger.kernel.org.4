Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8016554DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiLWWHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:07:45 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2064.outbound.protection.outlook.com [40.92.90.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F31DA51
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 14:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJgoBhZxiYtmqCuJmNH/9pjstWlDEJXXPJQq8ukZMPAVOqfwZc9kyw1aX11keFnVK72CLyYbAKMuNqvZ+5/7XK4ykh3o9cxRMarfsiuuKY2+0/dA89R1VQQk2GIuOFlJFS3fger0ADFyo19b1kPicOlNYIyVdtq3At8P4hGmuulxDJ/YV6eD7NHBHGQFc6IuLFPUBdqJe23ksNbWnf5tngSOu2Skdu+BDP3yfisWJZwUT52+n2EcovNciV9Ed3S8w1F/Wdk1bdeFlq/HJw2iV/6fsx930NoGp2ySuP9aehpqTq1wAM/sFsXfdqypTAx0Iikpt8P61tewcoM+/dr03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l/HKPAHYksCkNw0ML5XNoZC1W+oCKmO52b4ftg2cpI=;
 b=dcVrbu2N3KR3Gh9lsp176Sz6hvlKTDW65YcHISYP+zf1tMUmdRAvri8caYypUvec6XNX3awpKe9h7aaQCQ8pYDfgMt1q8VpiSuvpqLmET4JJox9GrFHVjeEhI7yTt/fHVGScseIF4ZAa4HcsKGLQQlS+ZEMyTueS/WZLjEUwkOV+cqX5SA/oT+0GXHAnKWbrUY2TysPiCaNOeiLFnlNi0eVUNwGBIm4Vw9gCjmuXkFJC4lfRcPwEIQXTJA/GPU22OKaNQM5eHci34Tux53JZwk7ypw+aDcYU5uHJ6RM0E92xggehZWpj7of1wlHVVedKwTOqW+Fa1usKJCmoi1PS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l/HKPAHYksCkNw0ML5XNoZC1W+oCKmO52b4ftg2cpI=;
 b=rQEjkS3E4MwBU071vQadth5QIfoSEZXf29bRzfDBkuskZHVZl3fO5WadK+IUTHKcJ/CH/BstpkyM2sRrfZYMy2KhKq9pcOhnu8RBTWB2PNadIdo+EDGm1tEhi6Bt0rN2fBGcrXSOlynZ/yXH3B0CbYQMOhqSw/vO2b6U8SETbs2UBQwcLdjSPArlLtALG6EydsQbQYKYpjFE6wIWemZmedsBa4OgiOBwW8qdq6HY3NWC6HMsWqcCuGjI3Ms/0EiEbLi7cEEcWFj7W5MQLi8wJ7JrKvQfcZ9HMv7bP/UTIYX139OqoZ+fFbNzdLieMLNuEiAo9IKJPRE2jApvBCvQyg==
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com (2603:10a6:20b:c4::23)
 by VI1PR03MB6512.eurprd03.prod.outlook.com (2603:10a6:800:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 22:07:42 +0000
Received: from AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::b322:a70c:abe7:c5fd]) by AM6PR03MB5282.eurprd03.prod.outlook.com
 ([fe80::b322:a70c:abe7:c5fd%4]) with mapi id 15.20.5944.013; Fri, 23 Dec 2022
 22:07:42 +0000
Message-ID: <AM6PR03MB5282B02FC4F134D64B3A3BC393E99@AM6PR03MB5282.eurprd03.prod.outlook.com>
Date:   Fri, 23 Dec 2022 22:07:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     andre1coelho@outlook.com
From:   =?UTF-8?Q?Andr=c3=a9_Albergaria_Coelho?= <andre1coelho@outlook.com>
Subject: shared lib
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [aKq6ZHZISwcsMqmmJkU5HXHeNse/lS0qjYpH2Y7T/D87WrUS/bmnFtfPCwHiCGs8]
X-ClientProxiedBy: PR0P264CA0275.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::23) To AM6PR03MB5282.eurprd03.prod.outlook.com
 (2603:10a6:20b:c4::23)
X-Microsoft-Original-Message-ID: <a4809127-9063-e1ef-d2c4-51df639dd565@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5282:EE_|VI1PR03MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e48ae6-0466-4eaf-7959-08dae5321cca
X-MS-Exchange-SLBlob-MailProps: 2pQMrP2hzeZxud+jUeRqY+MhIr2DFPqrOKdVH6S2dQTnOyzExZIXFbPocsuyVOnR3ewZefLwTJwfdhHxI79+/F63+T2r4bMvMsRHhiqizd5hDIkZPrxict4FjRDApkwgzs3Vx7lwmuNxkvivTydMh8P1E465ezTOQiP2qWMQIzpQyia6+8U1Nn+0uTCVjGnmBES+oVn928ymlmL+j44wY3bvv9ldxoyBHNqZna0jXcuSaEpM69FN0JLVhiVpv64b43EG+obbNOSe3Afh/Q9rkt7bPz+KkVfXeAmWEg6Y48k0U4DBO7cgbuRRTF/2iz1aeNzLirN8GJbhYHzJEKlsYMqFNAZHZY0mX0gBdAyhztTjaN9pqZOA4t/RmN9A1X3oul42cWt1f8Rb4fPI8Zc/W5KhF8eK3B4mybhUwcvzbLdccddDPRx+rirZxtfC7p/FiQ6N7FUQYqqnyzeV7DNTRXh3E9d52HvfaieF1yAge03JafU08OJRv+G8k99Teel5ipqCGjcJKxLaGGJ2pBL/XUyIB1lk1MC46t5iS0+x07dsp6zqmxAE9bA4D2c7SNwm6AgFIR6swYXOrQ5eksuwHaiuFyUuKY+7KOxIG2gMxtg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0FZ4fI33y/F36fhKEmzNIF4Wn4P4RmH9JD9gabWxcU3q2Dzq+CbWo/kQWUgayatBrOoNNJwQ1pCOs0oVrp3dkjcnH4qEeW8XdnbVPZ4YuyJ3WvMSA0AOJ0Jrl6qMeBO6pr+KHGVeLZ+8ptAF7sEQbUKW5g7B8peOGE3pAUaatTNH1XM5JVIeTxtUYIPhIRrUIaeCRfeaEI0CJAairA7GwYsw12epwhVmv9Iii890qG/+KS1y71KnVX6v0tPYtqHabJTBmM6LKPGfOCvYmUGjDT+uKOWSlBqSUpdtsCTrKzzF3dxRdMxQkEdLcbQcWiIC9Ca0k8t+a1jLskCjzIzStjVNPxGnNY5rWgoIyCF0MMDrI4KOll/J01cJtWXbnfJzq0XSFyb4AmvxPA2a3I6AfvgY9p4O6PTQlpsHwoQcCXYes4SQ0rH9C7ETBjsaB1ZIy04+8p3vX/T9YczzuEr2IkKHySxP3iLJjZcnrEisjwmkZvbpYD2utZlI5IiTEfOVQjX22CzAqiCMh9uLA+E0qE4QU1wJf+Pqz0ceW5/ZzMxlyIS4Vi5ujTbytxciHFO4vqj/lO33pJwx0hdvse5e119RgVavo85iDI+b7dn0kNNAFbaEZ0z5Pv2UtmAFW5A3aGyx9+wwslRH4xK/qRKSA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxIMmNEUXMvR2hWeU5ibFhJTnNuTFpVUjFhVFVyeWdBSndUS2tKeVhtZFls?=
 =?utf-8?B?UzdGa0pQREZGODlzb0lNMEMyQ0hwSEVjM0paQ09wRStQcVFHRzk2dW9DT3FY?=
 =?utf-8?B?RjFlS1k3K0dpQjZqcTFiZkU3ZW8zcHlDdGlzekRQTXFvVHoxZCt4bWR0R3Jv?=
 =?utf-8?B?VEtqSEpXNnFucjd0dmxLemwwME9ZV1ovbkdLSllBQWlId1JXZ2FzTm1qaHlY?=
 =?utf-8?B?elZhbkw0SlA3M2ZDcm1GLzVpNjJlc2lOY0VPamVHbGJTTHYyTS9FcXZQWk0z?=
 =?utf-8?B?SEx0S2s1UllaS3RYNVpvcHp3aFhmMERpdzhta1ZnUTV2MkFBVkx5VmhIK05j?=
 =?utf-8?B?QjJpZDBpN212WFVZMkdKZ3VUd3RmQnNBM1E5VXJ1eVJIRGZvcCtBSzNBZStW?=
 =?utf-8?B?RjhPbDNyQkJ3MHlOWk9zSzE0OHJuV0lpeGJaLzNxOTdtNnZHbVgrYk5tVS9h?=
 =?utf-8?B?blk4azJLbFBVMXRMeHB4ZUZQN3lINWJucVBVMU1TUmxFVG9qbk40Vis2NTAz?=
 =?utf-8?B?eWNXa25kOTRPYklWazdlajUwQ2xYVGlScU0rdHp0NytLTUhGb2kyRkR4cmYv?=
 =?utf-8?B?dVFvOTRjcWtmRm00MmU2aXlWYTA4cCtWcE0zZ2YxNlhaelQxeTJDVUFRWjZP?=
 =?utf-8?B?K242SHpZeFVXVXBiVU8zUXVkb1NYUjM1YW9QcjNtQnVMNEZLTjE0SXJRbk4z?=
 =?utf-8?B?QkhnbVBsNTFpTDZRVmZTRE45S1NrUEtRZGNTeXdRbTdnRnlRdTRqaUFrMEh2?=
 =?utf-8?B?WmFaNU5PZHNMMjlTSzBQdy9WMkV0eTdkWnNPNE5FUmZYTllRdFVVMmhkTytk?=
 =?utf-8?B?cUFUZVVtV28xd3I5akNTZ3o4OTFrR2kzVjBWMTluVm9sYnlBNk5sMkNtVkR0?=
 =?utf-8?B?bVUvUUpPR0xjZ1VpM0xEbXVuaEVIYXRNbE5yZ2NKSGNvV3VUL09xU1d1S2lU?=
 =?utf-8?B?VnJDMkxiMk1EN1VrVnZJbmF6a0tLdXRhNjBIUFM1Zm9RZC82ZEJwdkFjYkcv?=
 =?utf-8?B?d0VTZE1NZUFFWHVmMEVKY3ZhYU1jT2h2SjdhVzNpTXlSSFR0M0k3RXFUS0w2?=
 =?utf-8?B?R0FNVEh0K3RYd2ExMmJ4Ky9IWktmOGZPY25HMU41Z2tNMjc3eUR2UTFVTGM2?=
 =?utf-8?B?bnBIRGNQOEJXT244ZCtCZTdocXNoQnNmemFibkI4aTVCb0ZlTEZ4SzE5dUY1?=
 =?utf-8?B?MVIvSEpoZ0FwakkvUVZHcTV3RCtWd01sKzlURGhEd1lMTE5HdzdnaDdmR3Bw?=
 =?utf-8?B?TklzWXJBSExTQVBxR2tBbjR6N2tYMTc0WFJ5UHpCT0RPK1g3M3daY1BUaXhs?=
 =?utf-8?B?di9sTEJGQndsVVRvQVlncGMvKzJoMVB2dVYxTy9ZU0ZJUVZheVMxczB6TEwy?=
 =?utf-8?B?MTdldXJPOUdCTVIybzQ1cWlYN3ZVT2luSG5WWkpRZFdnUE5FTi9ubDJuVGxm?=
 =?utf-8?B?RDljTHhTS0RCajBZOUg4MGtkZFpTeXN0Y00vblpkWEVPTjVSNVhwSE9FbWxC?=
 =?utf-8?B?TU1lK1U5ck43UkdQNjNzMXc2YWQ0UDRkYThLVDl0N2Z6b0FXaFNOY3JJRVJJ?=
 =?utf-8?B?OU90YXdldHVDbmNrYi9nWXJYUitibTM4VEdBSWlEa05pdWJkRzR4VGdSM2tw?=
 =?utf-8?B?SmJEOHdCd0xPUjVXKzEzdGpYUXV2eitwOHY1aWMrYTdQSEhsdjNSTnFjUSs2?=
 =?utf-8?B?dlNrbE9HUjk0UkxsenhKVlcvc0FRcHYycUw4R2lpb2Vka2RGazU4YjBicEk0?=
 =?utf-8?B?VGZsVVN1QXFYajVwK1Y2b1lrYVpackMycCtiZ2s1MFJQSHlweWRWMDAxZDJu?=
 =?utf-8?Q?XJbkVpI+cccoSNO1ceCOlRWUuPOQ8skvah71c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e48ae6-0466-4eaf-7959-08dae5321cca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5282.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 22:07:42.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6512
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isnt possible, to have shared libs , without loading them into the 
processes memory?!


like pointers to libs or sometihing


thanks


p.s : i know this is vague, and not sure if this is the correct mailing 
list...but still, its an idea :)...just something to debate :)


