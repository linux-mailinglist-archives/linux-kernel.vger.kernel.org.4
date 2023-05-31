Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDD718D94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEaVxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjEaVxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:53:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2138.outbound.protection.outlook.com [40.107.14.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800A133;
        Wed, 31 May 2023 14:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHf/24m0ZtM4fcqRMudUbkNFwJyDImxLJrbiyoR4bnl3jI6x8kdV5v/oCtOyFmx/sa5+fHGN8qtf32UFFtRagiR4OZPEXxoekDWsr8ZKxXY2bs8my7Zb7geqz6Qfj7vuNYn/npGySPw7vCFrtUsZ5WiGkDGaqmJ6Dy5UktcvViRKn7aICE2vbxCwdGtQBOP5Ag/+qu5rZwPRzrRed7QOkwKHGrKNpKJiLxsnL2XK6uD/ipyh4ATlvvKLR9Wo1KfpNAIceSn01ktO4EeVcctBLziwEK9eVHBIlSEHHx48mYYVqqqEh8NLfZj33UzrBZLa1RM6g+8lM75BoUTnzrYUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZZpGiPK0zgT7Kn1gQZ1RnI4zPP/erZgUzSiMNbEmIw=;
 b=hVgrWr3POkla60qlBv3LDRBuqFmGeN0Nknuncz1o2QnQYgvbFWRfgH8RXMEVRu/j9ci5/1YIAbt0nSq9O7xcMOoFum/26AAiYqgtRcJonnx0IGGp6yECs//8QGn6mWViqwkTHh5WgOD1F15IEoaGxZxyQWUsaamc+qIClKbaDFge9N2Fg82WX88vY3lKdqLVqwgHlxfplPhpwgDhHbhIke43RRdthZG6mHsBDq5GWQSa1JWOIK7mP6LFCDfG6mSX4WY1OuYwGyvzbYEL87rol4baUfX6s0NROYzt696dxFPU5555S9jsiH8v8RIInAQNJNXIgK4rJkPU87/j9YhOcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZZpGiPK0zgT7Kn1gQZ1RnI4zPP/erZgUzSiMNbEmIw=;
 b=brRAL6sAQ++GlnJNc6/I+fHNJS7rZ/dud9hbgwAKA5P7YxqSWCbpvIfsZ7/dYyxM4W3nysSjkrGWVFJtZTaNMvcEncF4TFucn80mTIk+6SX2ttW8m8mNy7h8cg/3SHWj0805NIs6Mvw6Ahy1kHQBu6FGuG8aaB9apqw3Zusk/l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAWPR02MB9854.eurprd02.prod.outlook.com (2603:10a6:102:2e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 21:53:03 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 21:53:03 +0000
Message-ID: <1149c073-b761-8ad3-2930-3ef10ea7cf0b@axentia.se>
Date:   Wed, 31 May 2023 23:53:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/2] mux: a couple of patches for 6.5-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::20) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAWPR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: b444fab0-6fd8-40d0-46f3-08db62216874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADCZKFHi+VAHdCbMpv0OC9m/meCLnp7FoTRKyNzbAZnu7Km9lMSPYiKaR16jI9iBRZSOGMoQpCCaXFu0Kp/wF7Xlt5vOaae8BMIi9jq7hWhHMM9hhmHChz+JI7BkSePlMnHEtTd5ckZTZ2PRrsg4im5dSnE6KLLcm8SnZ4mcqP9VfYhV5bjxhkQOrWmdzdI0ZqToFeIYSEft1BEPOL/DJNcUtgEnlIeLPmaKRynlmw+I+GrX68kbJ4oNTlGTkVDqE3HcLe4icXpnNp4QAZSA72wSFM6wABj8b9Pq5BxEN4CFyZcBFsTbbRM7uNgNsSIv/jC02TYStfpctRrBUPZKWQYXPC0LFw4AfPXPPMn2CsSumkJvxXimA/UNK1mL+0QaEiDRLgwxq7grgXbE+vWK40hh3MsRFLkMg85rD1dTHUn4tGEq+P9Zd8YIVA8/YM/OAoO20xZ0W5Z8NMvKhIe7upAyr9JU6QbDkJPGXfH5zm8Zr9TBsE4KZlumdNOQk3u9hc0EWyxzh9FNM7A1UUN7zYrCMVJkocjXm6z4ATkK6pNOcK2xhDPyzx8pbKNxoT1a6sX9rQpdz5l9lKq0y4YVnhJwLnNaLWKRSWv011QfSR2T56nnwVkgZDwUcRNtntgP0fPBYuIPEtQU8RZlDwqKPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39840400004)(346002)(376002)(366004)(451199021)(83380400001)(66946007)(316002)(5660300002)(36756003)(66476007)(4326008)(6916009)(66556008)(86362001)(31696002)(38100700002)(41300700001)(8936002)(8676002)(6486002)(2616005)(54906003)(2906002)(4744005)(6506007)(186003)(31686004)(6512007)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdWZnh2Q3NPbnpTOFpsZjEva0YrdVpRR3R5VXNBSGU3dGExUEhJbWJMM3hi?=
 =?utf-8?B?UXZwcTJyQ1lxY0UvSWZqVnlIelZ6QUxjQ2RITVV6NE5tK08zOHVzZDY2NmF5?=
 =?utf-8?B?S1k0bnJJZ2EvSm5JWS81QS8vOXdEOGdFZ1BTdnlpZnpaUHVWZlNScmpzMUhS?=
 =?utf-8?B?SjlYZWx3Um92K2ZoZDlMTVYyWjVhN0o0WS9KSVlTZXg2Wlk3bWZEMGhMSVpv?=
 =?utf-8?B?bGVVaGNFdDU4OEZPeW1zbFlKSjBtUnpoVUZaNUFqVTFWa2dRRStFbm10aDNQ?=
 =?utf-8?B?ZnAydXEvdkw0Q1dsa1ZSb0hUOFNDSFFBa3dDSFlLcnh0anZ6QXB5UjdVaUNZ?=
 =?utf-8?B?WGRmaHdNMk1NelhtbkJ0bER1TjJTaVdsWWJOc01WNml0VmdIb1JDNFFFcHhZ?=
 =?utf-8?B?ck8wM3FWQkVoQlhvRjhWTjMxa0dLWForSW52Vnk4dEpJRm81RmxISlhPdGdx?=
 =?utf-8?B?ZVZ0azd1ejc3VTlKdXJuRzNpUHpJelFMSHkvWUVnNXhXa0djWFpHdmxudktq?=
 =?utf-8?B?RFk3ejRsSFZpNUNPYWVWY1l3Ulk0ckoxNHEySGV4Um1CU0R3U3RySjdUc2RP?=
 =?utf-8?B?dER4RCtKRE9jcXE1RjBmUUIvcVRockU3N1lMcGF2ckRSQ05EcEdVWlBZcW10?=
 =?utf-8?B?N3BldzhNb29iR2g1Ym1UNGhLL1VmaGRZZWJRcnFNNnRWRHVFa1h0RlVjYVds?=
 =?utf-8?B?eUxkSHdXTko4Y2xadUFLNkVQamVucUY1VDJqMmE4S1BEYlFvTlJQNGVZT0Q4?=
 =?utf-8?B?UGFQOWpBZVFzQkZWYVAyS2lxNGRsOS9WcGVwbG5saGxtRHBYSk5uMERqMGRv?=
 =?utf-8?B?UUREekNyd0Y2VkNJL2t5clBPTVRsQjhHSDlkS2gycUVRWWx1QXZMQ3NCVlRk?=
 =?utf-8?B?VWdWQ09LVWY5QW1XaklyT2RaRkZpNFNYZDBqOVA4Uk5KZ2tHZTBhZ05aNW9G?=
 =?utf-8?B?SXpXVVNTUkkwOGxlMGFnWXFVcm4valI1c0FLdWZ4ZURoNk9IdXJDek1sTHJy?=
 =?utf-8?B?NUs3QWJpTHJ6NGh6YkRtQkduY0MzSDVXMmRvdWZRR1FZcEtHNnN5SG10eGhQ?=
 =?utf-8?B?Q1hPdk14K0RoT1hYYURBanphdEk1TDJxbUwvckp0RDIrMlpuakpUQU9pWDEy?=
 =?utf-8?B?ZFVzWTFLbUlodnN2WVRyOURYaWU3dVc0SXczOGVBQ3ZVajExdGN2STF3NkpF?=
 =?utf-8?B?QTRwTTdBOEhzaWJ2QzJXOFltWUVNazhTQkJMZ0RhdzZYUmhORzhHYWdjaEFP?=
 =?utf-8?B?cUpJNVczNklOZUJxeUxMVk1jR1krTndnN0NzSU1NUHBjV2RhOFBBVG1na00z?=
 =?utf-8?B?c3NacnZYakl0bVRaSGpydUF4dHBrbzVtS29ZNmUwa2RnSWpRejJEN3Y0V0lD?=
 =?utf-8?B?aHJOVWNwMkJvU2t1aUUvZDV4cDJ1bmNhd0ZhSWZ1MmpjRjY5Wm9iUWNsejBa?=
 =?utf-8?B?Q2wvNkRLMkFkd1dCbUZRVVlObEdITHhDL1NZMzdWZEd0VDZDdjJ1WVJNTUt4?=
 =?utf-8?B?K0E0R0wrODlZM0E4OVRyYVJEVVJPWnNsNUo2S0RESjFMU1JjL0Y5cDZJK1do?=
 =?utf-8?B?K1hiNmV0Q3gydzc1WlJKcVFKMHhKSk1IalBpVE5MTzViRTRLWE5xYzlTVFdE?=
 =?utf-8?B?L296bTZTejlJVGJNRDgvMDdSWUZIOHYya2lqUTRnS3VJUlpLc2Q3QVZnSW1m?=
 =?utf-8?B?bVJvSWE0eWpKakpxOW1kOHNxd3Y0SCtFUzdOWDBsb3I5WXM2bFRXOXZCbzB6?=
 =?utf-8?B?YXBFUUozRE5SbTVSUFg5K3YyZVBOcmtFaGxiNHBnS0o3NEJlSEFRRXA1L2ZK?=
 =?utf-8?B?czNiSlZDd2lhTXVDY2pSOWY5Z3grT29naDBYMzU1d2tLS1o1QTRJTVhsQXBY?=
 =?utf-8?B?S3U0eFdLUUZBTHZxWU9LMmFyQUpURjQ5WkNydCtpQ1hha2NpaHVYbVo3Q3ky?=
 =?utf-8?B?YWRUekZrRHQ0ZjJadEk0akljZDFpaHpkVFBYU1E4OHZVTFhycVVqcnJ2NjhL?=
 =?utf-8?B?ZjRQN0Q3bEhsdXZITlJoVVA5bDhITTdySEkybU55bk96VGhHTXZycnpMOHpJ?=
 =?utf-8?B?NW9mQ0VtL1dXQzdjNlIzZiszQUZ6U0hUaXhUM3RLT054QXVpVGJ5OVBkd3Bu?=
 =?utf-8?Q?CdyY3O+NO05O2zwAmV8bPp04i?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b444fab0-6fd8-40d0-46f3-08db62216874
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:53:03.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLk8pC0m7xc9lVZsDNAeolhoNhuck1LhTGYMBTX0Kq47VDgMJxFE+vqoWxWspuyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The mmio patch has been languishing in -next for far too long,
and the bindings patch is also plenty ripe by now. Both are
trivial...

Cheers,
Peter

Jean Delvare (1):
  mux: mmio: drop obsolete dependency on COMPILE_TEST

Matt Ranostay (1):
  dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC

 drivers/mux/Kconfig                 |  2 +-
 drivers/mux/mmio.c                  |  2 +-
 include/dt-bindings/mux/ti-serdes.h | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.20.1

