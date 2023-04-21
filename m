Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB716EA0D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjDUBNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 21:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjDUBNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 21:13:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB25E76;
        Thu, 20 Apr 2023 18:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOnNO4yUK3mveZMdAodUeKeFC2eLt2+KyENwCTFI5tdhSmCh7mME6XesNxSVBVCGhxmjcMGt4cp0WHdr7Xs68kj6QK/2ZsxD0Jm2FLo/AiTv8wiISGiIL+73KL7IKO4490/9KBMpdbggT7BKueEpQzYqJzSAn6cUF7c+N4L5Mm1Rt0gW3/MnSPkrNwhuGVv6tMCUyDWe7abnYf0ZzXtK/FilGTWJ9uSzvjz64SQaWU9yulhVQPzIUstGuLoCDtLwhc/5+TZ29r7pVgqdf9C6UN6D2OsmrjVjQ30RZ89pDIUqZNXMUkVhyBk6DgYnw8kL65YeVu1VjyYIj0aTAePjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69YaAD8Oo/Ow+xMWktfNgQy+k5VvRRpagdoxkV/bXM4=;
 b=Vs2gjhzAoN1Icfm6OhrE1xONu6Q7Wrpf3tOT5KtufKUAMxOCuAkicdtz/GxC12ePzRaLjryumxWfNrRVEtsb+Krvl4B1R78Xoy2HU6yf6vfpDrqc4LGS6GIqJWlAPynyp98CeVk2uCejqirL+zGQrjl9xXyyCFNAToA3+R07tf9Bjn59riQBWD1egUOqK9h4sOCTHZt6XDmscu43u2ntWnh0Hwj52elkwSH3x6uacLXGxnMHGeT9hJzQaUKLHfs/hTwFdTEMNcPVkNZ2HEZhDhmWHu4wA102dSgAaZNoobheZHOcqREZbn9GirgGgyi3HPjNsbaZL15ph+RK3tCwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69YaAD8Oo/Ow+xMWktfNgQy+k5VvRRpagdoxkV/bXM4=;
 b=RqzdriESblxLxbj8fC9Nal2uEq1cGr8/ilZhBDEtUpT704wPxvP2jSqdc1M4ncPwD9K34gabZ7BvnWxm5saSJmmZE+X0iBuADhdRGRH9yNuxDNqhKwCmwCm5oU3Vl0P6Tiieq46nqyCX3d1AD4g8Z7w6EleI1errd1gbLc976ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9966.eurprd04.prod.outlook.com (2603:10a6:10:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Fri, 21 Apr
 2023 01:13:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 01:13:26 +0000
Message-ID: <a2877a6e-7203-bde9-f3ac-198ea754efbb@oss.nxp.com>
Date:   Fri, 21 Apr 2023 09:13:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] dt-bindings: usb: ci-hdrc-usb2: allow multiple PHYs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420065051.22994-1-krzysztof.kozlowski@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230420065051.22994-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b583cb-a07e-4cb0-5865-08db42059b9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SJu7WTvtM7GWZ0etY/OwcghxgQeOLo/PEmqUca1uVDIY+oWVi1TRMqDFp8w/t4BL32sZXCAdG2xMwAYJmUYbpy5worpMI7Lr9Ptm/+xcP5y4+RDfU/DkHaOgfSE7JpR1WM7Uyk39RHnwS2fCjQgXMlizcK7FkISVEABlU5zsjBy2UjCr8K5JbmlHoji/C+UdtBWSIlyGGa2HxyIKgS7Xcr9CkUFJSAupdT1ZBLzSlvGXOiaiXCSA5fKX2SrGO9aIUtP4Y2WwCGV9434HvQndwmGYQ11INxkVrqRlZXOkmlgF1HkYPkTgzcxRZ/l1wAOarrO4oBprqFw06hRu39wlG0PvYq9MS2O6Qigudw1zixq9CsaodbPm1WL2weiCflSh5VUmuGRd1YVK75Wf3oSvwlhOLQpO2CW56oMXmVMp0xt3+i8Mc3fMht7sz1IfEcWZF0utmt4PmC13HcmTeP2QvlIDIGpOWw80LAQJ5nmwrP2IfSvpgtI9jIScd+SgbiuoLZn133k2j31set4h4IgNEmJePYx9GEJXANKKc9M15u3aC4MzVCBLbXyMeTuHKHuPZ4N6j7ZOARYwYrWQ9eyvqhCCKd7uKTAMgCs7w4Ep0ocu7Ag2DYyhrzDNfd/A0rIj6jMcDnwjZKZH8m5n1WTc/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(31686004)(2616005)(4744005)(66946007)(66556008)(26005)(2906002)(6512007)(186003)(53546011)(6506007)(6666004)(6486002)(86362001)(66476007)(110136005)(31696002)(5660300002)(44832011)(478600001)(38100700002)(41300700001)(316002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1duQktMc2ZuVEptQlhoOGo3ZEZ2SFN1SWZqMmFDWHJ6M3BXYmNkWm85ZkZK?=
 =?utf-8?B?RTlpcmN6SXNYWi9SL25mQ2JCMXp6SzhkMlhjQlA5K2o4STdsZEtCaVZBdFho?=
 =?utf-8?B?T2luYWxVQVYrQkhaeDFvemx2dW1PbHljT0UyU0VHRjRQeHlwS2lkMUd0UGNO?=
 =?utf-8?B?d2NSM0lBeW11dXFPWGtOV1FVazcrTUFGY0xrVUdsMjhUTm1TMnZudHNXaG52?=
 =?utf-8?B?ZmtzK01pdERqYVZBYkMrMm9uMExHRWQ4VUpEeDdXdGQ4RHUyaG50UE80VlBD?=
 =?utf-8?B?bEhpYnRMZEh4Q0N3R29lTWdMRlN6N1pFUmZBOFkvckQ0cGNDK1hteEJTVmc3?=
 =?utf-8?B?SEhLOTBUTWhnc3VPNUZZOWtzdzhGNFYwR3pZOXR6YWhtYmtrTHJHaFBoaXdE?=
 =?utf-8?B?d1VzSkhsSzdxc0tKbTh2TXJMZ0pIaVhjN05EL0xMeUVpNVZ2YWVMNzFYam9s?=
 =?utf-8?B?QTZrRUdEZDNxQ2tRUitRZTlaZHRoRTh2dXZHL1VxSE04OEFBRmZhS2FnMXFm?=
 =?utf-8?B?ZlMxUGQ5M2xWY2NoVGhvaHlkdG9aNjFBSVNXWTY5UDlGbGcvU3BZR1M2RWZG?=
 =?utf-8?B?RVdCdkRQQWE0UWFGYjJqM0dmQkY2Y3BQOHhsRDVzY2NObmFBVWtrNy9JaFBO?=
 =?utf-8?B?WEE3VUpYaDVzRlc1V3FJcW1ad1o3bmlidkFhTzVxTW9GZU9WSmZ1QTlkeFVi?=
 =?utf-8?B?dm5aVi9BNnBwL3c1TXNubEtrT0F1RWpDRFVHNWJzYi9uWlM2cDUvdnVCSHEv?=
 =?utf-8?B?S290eUptN2RmeXRqNlZTWG1Vb205S0taY0Z3cnRTZlNhZmh1K3JOZnhLVmZS?=
 =?utf-8?B?U1cyQnY4VUlFdDBDbnhjclVVbXhuSnk1QVlJOE00OFg5SVlkai92TmFhZHlL?=
 =?utf-8?B?RGFEcVdreDViKzNJRXFERnIwbFJBQ3gzWlA0YmdNRDg2NzdaNi9NbGlOcUpO?=
 =?utf-8?B?amlSZVlteGhLSHFRTXhWT202SWR1VWRQa3BmSWU0Y1ZXdXp2Rmo4N0xoTGxW?=
 =?utf-8?B?WWdKVGxxYVpHeHdNeVlsaGpNbmtGUGdzdCtlVVY0TjI4T0JmUkN1VE4yeUhK?=
 =?utf-8?B?RmVhbVJlWkhXb0srak1haGkvd1M4VW91NG51dzVDN2FmQnVpaTVGTGpiaDBF?=
 =?utf-8?B?VlVsblIrNHowT2hEY2R3TjdzNytUS3FsVzQ1UzY0SkVPQkx2Z0ZsVkQyWWY0?=
 =?utf-8?B?c3hGNkxIL1UxZUI0b2o1aTU5YXM5SHZnRCt1NHFsamRXTURyM21MMkk0ZTE4?=
 =?utf-8?B?eHNwbmU3VVNVVmJOWVlwa21ZL09rQzhnbE9sVHluTnZjS08ycFpvS3ltMzlx?=
 =?utf-8?B?VGlMRFd0MVZ3STJldUtXSStCYnpnYUF5eDhOM0ZzUFdSaTBSUFpuVXNYb001?=
 =?utf-8?B?RUJySWpoWFczS2tNQUlEZGlDeHArRi94UnJJSDlKTlJURWU3Uno2WWIveklO?=
 =?utf-8?B?S0NLZ3NsMW92WnRPZkVRNEtBSk9KOGticUhpekdvVGdXMFJNS0x1WDZUMVRL?=
 =?utf-8?B?OE00L203ZHlNREdibG1yTnB3RHY1TlZkYnJ0NHcwV0l0OVhkY0dHUjBMTWNX?=
 =?utf-8?B?WWV6L0NWVXorMmgrZnFEZ1VjSU9XbWpOYUk3VmdSRkg0dHZCWXFOYnVrOWMz?=
 =?utf-8?B?UWN6aEEyTWo4ZHBrK3cvREx1Ukw2WVprN1RKbUJYb1NsR004ejg2N3Q4OUpD?=
 =?utf-8?B?emFROUVIUWhwU0JkWi9OVThXdUZpN3VBOHVTak1RY201QWhJd01kemFEOFZq?=
 =?utf-8?B?ZW1YWndHc013WTRuVWRQd29NTVNScElPZkdTYkdoczEyUkR0ZVF3V1Nlb2w2?=
 =?utf-8?B?d0YybUd0UDJZb2Z6MzRkMVJGOW9Ra1l2am4vTGJXZ1RQakdXMk1BT3JYcGdK?=
 =?utf-8?B?T29tOFJ3NU9QWDlIL0xLbWFIV2JSUXdFazZsU2NGRTJIOUl3N3FMZjRwcHNL?=
 =?utf-8?B?MWZpZEZCS2F5L2x1UDk4NmlWV3hIT0tVYWdXT0NvWHVxMlFuQk1IY29YdmhX?=
 =?utf-8?B?MG8wTjBqbDZuazd4YVVVTjkxUGpDMzdQNTlnZ2hkV2hGYi9Xa1RJMVU1YlVq?=
 =?utf-8?B?bVRCTG9KcHBQV2lLWTQ3UUVUUit0VGpWWllWcUpPamlrQW50UGk1M1hEVHBS?=
 =?utf-8?Q?LZiyartNxMcGVSh1g0r23+lDs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b583cb-a07e-4cb0-5865-08db42059b9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 01:13:25.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u4PUaTMgAgsOSu9IBv9xoW06Hfwfel6PQ0PaHk2raDvPwnrf0O7S/+c61WY3Dc7aD4RjSA8aR3BnB5CW0kSEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9966
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2023 2:50 PM, Krzysztof Kozlowski wrote:
> Qualcomm MSM8974 comes with USB HS phy in two variants, although final
> DTS chooses only one.  Allow such combination in the ChipIdea USB2
> bindings and also disallow any other properties in the ulpi node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
