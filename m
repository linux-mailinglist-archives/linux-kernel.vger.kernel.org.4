Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C826AC0D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCFN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCFN1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:27:17 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2115.outbound.protection.outlook.com [40.107.14.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC12A6C4;
        Mon,  6 Mar 2023 05:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRKQmHP7Sp6ZX3ycGlxWTdrt3ZHKJoy+50LvF0/KtDbD2zvrbB5JXXadWY6a4yFgwR0nP43O8czUV/HffY494ktUB5fZ0Ucz0xA807xl20nB9LO7nhqSEcbDUpD2OHxSB7Os7SMyNKkQVQYBavgGMXfyNAZBNzIvMabZI5r7Wz8JJXZqlSdFoOozEhZ8qes2vV4WkuTq3rzW2Y3KtJ9IbZtCTRs4TVyT6j6AcrbRpTouIE1hSf03je7t212stoCUJR4BMRywfUhPZkgvWqlR7aulMJQALdix07gR50G7X3farMXgQLi5dp77JM0F+tUfXnQK1gjboon/2kCmDO121w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8c69Fb42lC9uie8D/vboyRtYIB4yWzzaB8h9c/sKPg=;
 b=FZY8/gTdY5/42I0aTjYjen1i1n5uBFg/+gafMjwUCzQFSCrb89wliEBE4CaLcyDvU19PFRJE2k7wd83NuNSfQRFXAvTtHy2+LzL32K87LpKFI0QNsHozqY6dYe1mBTJJcHyw7z2hhVAMnal3qpKbImmCPVoeeDUzDT4E2aX6b+ZEKcNdleXVukqTfc8U4X/jxsoO2e6S+UTdnr4T0T8T1waWO5pmmMaEMz/AzNtdFFyzasl7diAE5zvy7FGJ/+gRmGrTy8dNl6qh2WyjIBLYx53DDh3EDoDd8YNDPS2VFmmhjcsi2JEQ06axwdPlbQvVEvIr6xsM/tmlL5bVEJj+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8c69Fb42lC9uie8D/vboyRtYIB4yWzzaB8h9c/sKPg=;
 b=LZyDFIqyqNUuYpvTouY5eup32ISDjKrB17tS43eGXQd/VaaDc9ThLkevbZ2LbEfQm+4Kt6o3rIzSZp7G1bJFS9nlrANihWNk8V683EJ6rSen7oy2AqQz+JvnyZYcxnuudrR7SbD4lCK8elhPdG+j+6YXEII09ziUbkxoTU5u5o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB7169.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.15; Mon, 6 Mar
 2023 13:27:12 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::914b:adde:72ff:b7c2%4]) with mapi id 15.20.6178.014; Mon, 6 Mar 2023
 13:27:09 +0000
Message-ID: <da83fdd0-9eae-09ce-ff6f-47cc012f9628@kontron.de>
Date:   Mon, 6 Mar 2023 14:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/7] Enable backup switch mode on RTCs via devicetree
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230201143431.863784-1-frieder@fris.de>
 <Y9qQHpySbrFcBB0P@mail.local>
 <b58f5e31-f13f-6d90-774c-2017ee3de121@kontron.de>
 <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
In-Reply-To: <7268b05b-bbb1-ec4d-6a05-f5ccbdfeed90@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::16) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 358569fa-8077-4779-35c3-08db1e467cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKTQzrI2eZufj6wZZGleplclGOAks9bpaT82xW42sw1KJXs9fb+eqKCbr90tiEXuIuNilfsgMqdp2empl5xmetkHA3i3wuk0D5qZd+zeSYs0efvlCFSy7C3oDWn4cpJgwDkBzuErpYdKA5gKYYOfcptzpEEYzg2XaI4mRW88oMY4RR1F3s/rO8kTk7ZOgWbUsl6zNvd2YlAa0n+lVlfVAWGA1dNcMMTRBMvMRlaueXE9v5qmGe8nS+a2Kuo9OAveAoXEhyMr5n18Q8aHG7XwSFgMKUAOm7TMLqTDvcJxiqW9l8WzePD0Qrx/84YS9Cs7nJspQ/+VV2QweQtsgPJMlS3c20edx6NsLnzmEdrW0gGN/yvbJEDCRhCytQyL8l2xyRRuoGOzYpnULcydteAxzxv+S2NPodgsS1a6/8NUPTDUQQr9dFmXeAAhxGTYMHc1nNfljXuhCDJXe8U+HUAOV8etZyol4hJeC1qrHzeuhdc1wka+morOV6Dpl4yee8AAlLWtWIebhmGFue6cGk5vNkOm8KOgXEdb+4LKtnfUkRkfMct+l1qXhXdANsTeOqVLDTaGZd98k8k3zfN/Mr561gmqcfoPdmzfB7X3RofA0lOppc33PP1V2MM6h3wQgHVczpMPzmnyM6e5yOGYjFcwwhUvds2d6NZ7sXtWdNMQ/8w7MN+bdBkt9lzIoZHWKweRqYsqC6tJh2ghNPGVHcf/RGl6SSDxTmE8KyGy5q2KoIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199018)(8936002)(31686004)(7416002)(5660300002)(44832011)(66476007)(66556008)(66946007)(2906002)(8676002)(4326008)(54906003)(110136005)(316002)(478600001)(66899018)(36756003)(6666004)(6512007)(6506007)(6486002)(53546011)(2616005)(41300700001)(86362001)(31696002)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFh4Ri9ndjhodm0xSitXS2hTN0tGZDhpSnM3LzRmOVBvZjJXRTI2ckVnUUhU?=
 =?utf-8?B?NW44VHhaa0JpaExGSnUxcDRyYmtzSFNobm1ydlpZaVBpZ3B3alppSTF1Vnh4?=
 =?utf-8?B?OXBwbzIwVHVaQml6Q01VSG5Oc0p6cDFtUUI3SWN5dXJEbll4STdhc1J3TzBr?=
 =?utf-8?B?N3BzUUU1bVpUU2tnTU4ycW9YclVGRE9LVEtUM1FKTVRUMzh2dGZxQ2lVaHdr?=
 =?utf-8?B?d1Bzb3hwbXJvTUVMenVlZmZiNWFXa1RIZkVNM2hKcFBsa1BnMWwxaTI5dFpU?=
 =?utf-8?B?VEUzaHhWTVZLYkVIQTJ5dlgyYktqQ05wdkZ5b1VWYmIyQ3I0YnQ3ZVVxYmUv?=
 =?utf-8?B?eU5jOElBWm5xdG9YUmZaZXNlaThxU1NibmRYSGw1a2t2K1IxZ2kzQTVuQUxF?=
 =?utf-8?B?WnJGdmVMcnJQeFQyb08rUWZ2TmYzRllJQ011UGpoTmNadDNia3pnMEUxSnNC?=
 =?utf-8?B?MmE3TEI4SUwrS2VxcnNLYUZOOUU1ajVzcTU0VWdmdDlSSjZ3cDZ5MWZOWUtT?=
 =?utf-8?B?c1czQlNvVm5tdXYzQ3R0MFB1NDZPWXBmVFh5cTI4NFdFRDIvV20vbHZkNHV1?=
 =?utf-8?B?RGFuaGJ0WnB2TGJ4Rkl0RGF4cDJkMDdNZGFhRmxqNTlsM05tYkhlZGhqK25x?=
 =?utf-8?B?T29yUzFxRnFoaGJTZi9xbmwwSVlvcGlMYm5yUUc2dVYrU01oYk9ZTjM0aGVt?=
 =?utf-8?B?MGZ4Y2NjeFdyNG41enA1OUp2V2N1dFpqRmQ0bCtKSWdDdS9jU1A3WkJReERt?=
 =?utf-8?B?Y2xRZk5hYlJLTXFlK1kxelZoTUszYTZQRnV4eUxCWHg3cm9BR0U1VkN6aWV5?=
 =?utf-8?B?KzhpMkZRQzBNZURldHJ4SUV6cHdOUWZ4Z0RDQkk2bjJpZ0tMZmE4RCtITnBp?=
 =?utf-8?B?RkhJa3hidWZWR0h5UmtIYmFBSHVLKzhScE8vMWdZdFlLdVA1a3VoeEtndjNj?=
 =?utf-8?B?RmdTai96OXBpRU9icmlVS005UzhCUDhkMWY0SlhTNjQ2eXlGVkNpa2lYZEtx?=
 =?utf-8?B?UEo1ZG9Kems1Mlk2ajRFR2NCV0xEcG1xSVdCbHNwS01ySGlDdG9nVllub2Rv?=
 =?utf-8?B?MTZzdDRZTW9ZNHBpSTFhSWhFTnQvdll6L1VNSU4zVWlBY2ZXVHBvVHUyYith?=
 =?utf-8?B?K3JERW9lN1MrWVkrN3RZNUg1Y0xmNlhiQ0dxUldKU0pPeU9ydGlnSnIzZEZ6?=
 =?utf-8?B?OWJNVHVhRzZRako5TnY2ZGk1NlJnc05OVmxROGpFcGtqYkR2V01Fdll2WDU5?=
 =?utf-8?B?NDBCdTVsMk9VQzBGYXFSV3lrQUVORit1Tjg1RlFGNExVQTgwSlJYUGtFTnVS?=
 =?utf-8?B?QkhMNkRFeXdUOEZoaXRsUlJHNVNqcTBFd0xhcDRHOTRWczIxWmRObHZWQjdM?=
 =?utf-8?B?ajVFYm5sNXc5cHNsUThmU0ZLSW9xd29saVNXTm13MlU4THpMalJTRFFBTW96?=
 =?utf-8?B?S2c3TEtzYmcwK25vc3UySDhwYk54VFpFeDU4K2xRaVVFeFE0RUlUL04rSDh1?=
 =?utf-8?B?SnhKeDdtWldBZVlhZG5FbGFESUhWbzlCU1N4VnBCZE5MYlJHSzN6enM2S0FD?=
 =?utf-8?B?VklOMXp0QWlta1EzY2ZSOWpaMzdjaUhmeitXSmk3RTJHaWpRcFVqYmxuZC8w?=
 =?utf-8?B?WEVobXVWYUhDL1BuNVVYNG4vcHM2Vktnd2lqaDl6NzU3aC9iSmpCalIrZS91?=
 =?utf-8?B?MURTNFkzVUpGQlRkZENTdm0wS2JDMXFPVVh1UW5Cb0EzOEJPZUJtQWxRT0NG?=
 =?utf-8?B?RnVUWlZCRW40TVJIL0l6dVlsVHJVcFNtV0JuM0hBcUphWFRGS2V6S1BtZzEw?=
 =?utf-8?B?RUl3SmF1YlZkdktNTE1sT0g3SlJRM2MwZ2hSMFNRaUhXN1A5QUtvclNmbVh2?=
 =?utf-8?B?RXI3cTU1cm1VMjI4UnJCbGh4d2grMFBUdWloMlErWWtva3FWSS9aQjFyRVRC?=
 =?utf-8?B?NExSc1VGamhLTXVLTS9zbjRGcmZHelROc0hyK3ZkellWdHlaV3pMREZQMHI4?=
 =?utf-8?B?T2VvelJOMlNhQVFNMnZKekgwZ0RtaEdEQWU5djluVWxEM0haVWFRK0crMTNz?=
 =?utf-8?B?dllQRTd4WlgrcjcrQzdmalB3UHJjRjJNRkFKd3RPd2I4dGZpYlNac2VOcWZG?=
 =?utf-8?B?UmZTUkdJSk5GRE9XSGxNb1grWEJXaG9iMWtXNXFraW00U0F1aEF2c1dnUTJM?=
 =?utf-8?Q?UUJ87LhgG6JTnphlRX6YwfcYZG9zOK+6rJZY+6L96n/d?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 358569fa-8077-4779-35c3-08db1e467cb6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 13:27:09.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIG5k7n/nPKf9R79yZH5vqFnaEMYptdjhjg5o98xwDcx5XitSvunErFJVPPGVOIlChOaujlPkyQdmwFzuaxT5kFIIkYDovxhGMhT5+YZXxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7169
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 10:18, Frieder Schrempf wrote:
> Hi Alexandre,
> 
> On 01.02.23 17:26, Frieder Schrempf wrote:
>> On 01.02.23 17:15, Alexandre Belloni wrote:
>>> Hello,
>>>
>>> You can't do that, this breaks an important use case and it is the
>>> reason why I didn't use device tree in the beginning. What is wrong with
>>> setting BSM from userspace? You will anyway have to set the time and
>>> date from userspace for it to be saved.
>>
>> Ok, I was already afraid there is something I missed. Can you give a
>> short explanation of what use case this would break?
>>
>> There is nothing wrong with setting BSM from userspace. It's just the
>> fact that users expect BSM to be enabled in any case as there is a
>> battery on the board. It is much more effort to ensure that production,
>> user, etc. are aware of an extra step required than to let the kernel
>> deal with it behind the scenes.
> 
> Would you mind elaborating on your argument that this would break stuff?
> I currently don't see how an additional optional devicetree property
> would break anything.

Ping!?
