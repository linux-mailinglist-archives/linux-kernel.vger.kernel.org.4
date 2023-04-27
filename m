Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2746F04C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243638AbjD0LLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbjD0LLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:11:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E44697;
        Thu, 27 Apr 2023 04:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpg7BVJM44ZxN7T2ejOKq3st2e72sr4W7KnUGf830zu8th2m/WcSq5xAsGmVrWivRvTK87BnNzMtzN4c4urjKqtmkfhZo6J/a42agyyk5K4PJppgx2J5+1Z6jzeeINOC/t/sIDMEncSWZyC8vsySnVWJQ31VNc/VuxRp3beTnmxdKtbq1/pjibdvFpsXu2zA5hVnYf46d3spmdOON33hf4ZGcfPZ8j3cEk7lWSajbpIuewSnpGHksuIjOW2jnxaVOXLv1jaqiIZSzwde+XQZTXAyWh4P9iDzcuOXWYAoLmBLl7aC1sQz0r0Kl1SG6D2FleUsSMzEb1UO0yBZFGfv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dygWW8BZnIW3ZXLldvg+CMBDIswChGmSMsqzUC5qVLU=;
 b=DWmq6SC0bqYMqEQ8U/j3XkNnTUtSqLhejpHL/29kL6v8YTz46L3Q25BeAgW1+00hwTPzD2T6ucbWPQ5PdZg7vBc+ImX6tTn7a4vmn9KeSDBnnNpE5cQk+fTZZzaX/JGnp1XmhHWaPq4IQ5N3xjWz58nMWBZvPzyloc+YyEiuKGHEc1ilZR2Nnd4lfVNYBEQhZvhLphN2VL4TD6Aq2KRBSxG6xdlsP8RlZDg1nOe3+oQ2X/MdkmAR63zt9TY2x8mu0hNuXzCiK2JpN4laG0Cim2nUkJYDe0Uab3Y6ikQbCRLRA/URa6FbXYUWeE84WyWOuNWh5pMAeyheTVASQIfaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dygWW8BZnIW3ZXLldvg+CMBDIswChGmSMsqzUC5qVLU=;
 b=pvU3XIkGZtKere2jmmuXdr8C/e4hPCphuXp6ePHXNFiW6jk7gNbL3jpz+1mM4hI1zXtT8ZOjXO6EjO/lThYkQX7XGo41tqtrMppoe6mzNq4+YeuYPYwmtvTrSMnnXrfJBMXCujV0eEm18Un0Jd+UND87vZ5QJsa5sX8+H84lUuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB3PR08MB9110.eurprd08.prod.outlook.com (2603:10a6:10:43c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 11:11:28 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::77dd:14e4:a772:d85f%4]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 11:11:28 +0000
Message-ID: <de87d6ae-3449-5581-3e17-4aae72e8197a@wolfvision.net>
Date:   Thu, 27 Apr 2023 13:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC v1 0/4] Input: support virtual objects on touchscreens
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        phone-devel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Bastian Hecht <hechtb@gmail.com>
References: <20230425115049.870003-1-javier.carrasco@wolfvision.net>
 <ZEpWrWpzkI9kNTkr@duo.ucw.cz>
From:   Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <ZEpWrWpzkI9kNTkr@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0135.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::19) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB3PR08MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7857d1-33ae-4c76-9a84-08db471025a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAsLDnqge9oR0QGLTt5+Tm2x+xXuNZCdQdvC1W4keJ4yr/a2B+GseIHs/lyl268ziut5qHX4fquWltL2+E6AaXFD+IPqX8isKhHjRD1If0GdHee4WF/SLXjKMIrHksaW3/cO6OLnIcfK5N5Ubu3OVB7e0YJCWj2rgEb/VIn4a7qNlpbTQcMGaMrafCyghJ1Bgm/9XICciapGZY1BNN+A+v/AtwOJecaWjd/LiqouoXICZWFW3puGVIOwJSqwBTHYdzskh2PU0o5q9lxKctRY9/wDRKRhG+jDJ/+Qg9z1md8YEyZMjRmy9vQwS7JXimnGzgDDWL2GYgs2LnRGCK9hQF/nZkUIJbgSB5c67/X172zefSV127S6j/A7u5VFhBlHfh7fnOw+gt08xesT4efsvjFkv20/j8ZtQYkhUD4Zc4mIf5czgVVmRm/i2905Q1sPshcIzp8m9xy4wgztyG+aWeyPBcuxwvaaKyRWiiScpISPPItdvxCi05Uvi+KccX2oPBWN5LAM1fZjXpV6pPnijG18BNJPMkNZ2Hd5Pm0GI4bGZwRumfO5Nqn+5gUnGvP5dYy40ZvarGJvlftSkY4J9mCy6YnAtFBPTSGkBE6iKONAde57mMSwtZLi4t+5ynJnzymuLsb1J6ypFZ9LMDLMCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(136003)(396003)(346002)(366004)(451199021)(478600001)(38100700002)(54906003)(86362001)(31696002)(110136005)(186003)(6506007)(6512007)(26005)(53546011)(36756003)(2616005)(6486002)(6666004)(36916002)(316002)(66946007)(41300700001)(4744005)(66556008)(4326008)(7416002)(44832011)(5660300002)(31686004)(66476007)(2906002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjRzRzFCQjR6dEJUOERJSFpHUE14MlZ2ZkcxTmF4RkFRRkhNNjEyQlorYkti?=
 =?utf-8?B?MzJvemcrMHk0enptaStXV1ljQXByVTBreDJkUktWSG1RdU9OTmxGUUsvYm5B?=
 =?utf-8?B?WVF3bnJvbGt2R1BHSmw4NFZwWklzcUtzajliSE1RS0lNSjYyWU8wWFJUZFVi?=
 =?utf-8?B?dWdVS0ZoN0xESHV4S2lwL1BkVjFvek4yaXpTWTc3VUF0blFuc0pKN2ttSU1u?=
 =?utf-8?B?dGU3NENsUTNIUFIvR0RLVno1ZjUvM0RuNk5jYVJ3QnlkVUY5UUpid2NwR00z?=
 =?utf-8?B?ZEhaVEhtZ3h3NlRhRjhMWkhKVWZSUHBhNXF4R1h5bzV5S0MvRjcwTE9yREY0?=
 =?utf-8?B?bUVsOWNRd09SNUdKazdkTkJScmdoMjlRNDE0eVA5R1k1M0EvVEp2bTFJY3Ns?=
 =?utf-8?B?QTlmbFZ0SjRRODdBL0Fpb0RuNmZSRktWUVhRYXRveWx1S0RneG44cXB4c3Jk?=
 =?utf-8?B?Q2V2bHoyTGJPanhVS2I2KzBNSGc1c0ZMS0pJQ0lzbWVreDVCbzdGdFoxWllD?=
 =?utf-8?B?dkVjc01LQktpa2JPRGdKL2ZQd2FESnJqclArUndpaXZYYTQvL3FtbWRSVTZ3?=
 =?utf-8?B?aDZFbDJ6VjRqcGsyczJTUmI2ckpqdDVSRmk2b3BycXU1Rzc0Q0k5V2JRNDFG?=
 =?utf-8?B?SXJvWUcxSjdIYTd5a1NuM1IvV2g3a1lib2NxSkhFaU5jclRzbmxROW54RVRj?=
 =?utf-8?B?Mm5hYlhZSFRSS2pvejV2UnJuOVJ4dGJSOGgxQ1huQjhIL1RvbmRsdmRmSFc1?=
 =?utf-8?B?NWpqQ2NIdHVKTEJnNm5IRVp4U0ZPNlROVW9JcjQxeWRpaXI0c1M0RUV3Sit1?=
 =?utf-8?B?ZFlCN2RXdEtWS2tKSDlWdXBMdGxOLy9WcHZDZkhOQjZGeGVabFAxMWZLSEVk?=
 =?utf-8?B?Q0lqdXFQeklyMGVjcDhzNEUyc05mWk1UMWpLMWFOc2YvSzk4YjEwbTJIRjZx?=
 =?utf-8?B?MklvYVpUbkVBTFVmeTFVclc3VmVsNERtL0JjUm5POWg5ZFNIU2dBM3ExSUI1?=
 =?utf-8?B?ak1kRWNpMjZCcGs2Q2lqZm1DZTZOR0U2TDcwWTc2OU9pVGRVWXZ2N3YrVmxE?=
 =?utf-8?B?ckhtYTF0a3dybXQ2U0JtOGwwK29BbGlUSlg0SERPRlMxcDYrTGEzWXZtR3Yv?=
 =?utf-8?B?Y3c4bmh2ZmtnZHJoNHh6bXN1Nmd4WHJhdUp1cnVKM0VDSVFqUlVjNEFpbG1K?=
 =?utf-8?B?cFFtQWxybHEvdDFmVjRCT0ZQV3FOQ3A2M0VFR3NPb1o3VmNEL2k1TVoxeDZa?=
 =?utf-8?B?M0p0a0pGM3Y5S1VPSkdKSXZsYnIvWXBDM3k1WGhxQzhrRHlVK2dnRU9NQXAv?=
 =?utf-8?B?dkRMZ1pZSTZnTkZ4VW9qbklzZWpLWU5sTmtZM284K2Nva2JGQ3lYNkc1UnZQ?=
 =?utf-8?B?RDBHY1ZGNHk5V3hha2lJbm11dklTcTZOV0c0eDh5bE41UnhiUy90N1Y5akx5?=
 =?utf-8?B?R3FzVFdBc1FnNDBMS3lpbng5MnYvMnFCMXhHdWlHcWpkOEMvQnlYUTVqcC9v?=
 =?utf-8?B?elVMUFRZNlVjeC9LTVlSVUZaZzZxc2x6MWJOOXVzaE5ja1FDdVZhYzQ5VXZ2?=
 =?utf-8?B?M0VQRzZWaE9IUS81cTEwRERCVHJwUVpEZ0hVU1JSOXJxbmpUQnNzREpYZ1Fp?=
 =?utf-8?B?VlcwTVEwb3FHQUswL09lbEFmRFR1ekF1UG9ZSDFlMi9MRVFaQTBhUzRqWUk3?=
 =?utf-8?B?c3F3NGFKa1dZTXRLMWhYaTVIdlVUSWo5MkdBTm9rR2pMQ0JxQmJyNTVsSUFF?=
 =?utf-8?B?b1hTUG5BQThzWHMvbi9vSzBESUh5Q2I2Mkd0Z1BQcDRHMXhsM0luK3RieWtz?=
 =?utf-8?B?KzZDcDZncjRidS9ZVkpLMWkrZzFHWVNDb0RtZmFQZmVydWxWamhIWUNlRHNT?=
 =?utf-8?B?RkhSa1p3a2tQQkdDRGRiVWRQTDloOEovM2dZVjZqNXp0S2lNSFZaWERSc0tm?=
 =?utf-8?B?Z29ES3ppYytWVUYyY3hkak5nVElFdlVRTDNsV2pLQ1RGMEFWK2xneUVUdHhx?=
 =?utf-8?B?MVFMRWE0Ujd1Wk1mY1FRcjYwSWpzWjYwSFQxNXBWSDFCZ3NXNFZtdnI3bkxN?=
 =?utf-8?B?M3k5SE1rekdvL01neGl5UW9TZ1IyZ1lzNXlTLzFhMkJaaksyN2RqTVVob1pj?=
 =?utf-8?B?V2JCZW9LTnFJR25iY24zanNHZnZpL25Pb1BCd1ZMcS9kYUE0aGhLblZDYzZq?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7857d1-33ae-4c76-9a84-08db471025a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 11:11:28.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5831rLwdqCHs0TH1lnoCUrwGJIKINFOwIEMYHvY9uyREH/+BlFNDESiUVHd2WSKCEG4OhiWb49fhNeDZrCxNjO3WdZuMrtucIc81NuePf/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9110
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 4/27/23 13:04, Pavel Machek wrote:
> Hi!
> 
>> Some touchscreens are shipped with a physical layer on top of them where
>> a number of buttons and a resized touchscreen surface might be
>> available.
> 
> Yes, it is quite comon, for example Motorola Droid 4 has 4 virtual
> buttons below touchscreen.

Are those buttons configurable in some way? Or do they have a fixed purpose?

How does Android handle those buttons, BTW?

> One question is if this should be handled inside the kernel. It will
> make it compatible with existing software, but it will also reduce
> flexibility.

I would say that it should be described in device tree if the purpose is
fixed. For example, if there is no display behind the touch screen at a
certain point but a printed sheet (e.g., with a home or return symbol)
then it is clear that this button is not going to change. In such a case
I doubt that flexibility is required.

Best regards, Michael

> 
> Best regards,
> 								Pavel
