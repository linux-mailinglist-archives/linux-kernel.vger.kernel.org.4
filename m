Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024306FD9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjEJImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjEJImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:42:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F32691;
        Wed, 10 May 2023 01:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSe0CnJMqNUBlT808xU0n9p4FxrkZJTLO9/AtTXuOsBdPxV3VXGtJLJ/kNy3L9ZpFiU8aFiIPvNA1LNvEhvYnmFYM+3FAJ5T9jhUy9R5DxiyOY1EwtHXLMNLc2NIvEC2O+YAXnve9BU2/FvNhGj7S9wxIY3/wVOyFrB2rJzG0pr+kSy84J08GFLFGui0FhUfWDiHji4l1FUPINFWkBAtn+GS3ouyKizC96hxCylz2kuZKvTMQOXCNYjWZp3dML5FsY8cBy+lNNzFPe0DUsmjkwS3mqvEgEP5pT9oQ+PGiyr/7+I9NJ5FrKmSHo3x0RDHU4TPOZobSnJiKE+Z6mFF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCdvtCTb/gm0qKUSmB9PDJzjcg9+UIo2wojNerHYQP8=;
 b=AOJ54JVINrqq9ffClZAZygj4NMrlmoCVSYzjDHHvg1q07YepBKwPsbqr6mvN/ghSQDw2wYU1tFwXLkF6ldxbPdCFSCkPIYV63X05ZYN4RuxGIjagbM4IzJxE34/kTTDqnL4vmtlFyKuPDgYBbvhkrYne/92yS7hGoF6VVmY6Q4TuM7+zcJQkMB4g1gH0Dkm/zEE6QdTzf5vBbAB6S1OUk/uohQ09Lwvstea7K40Tkupc+xCpM0Cwn59ObnRO7KjuGB4Me8xvyd80b1WIbREsl+Hk/4ZmnZeikFKoLlZeqM26GtehIiM3EDqIZYPjSkjSy2JE+DVrIRPB6weLiQCRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCdvtCTb/gm0qKUSmB9PDJzjcg9+UIo2wojNerHYQP8=;
 b=PzpTXz5worwHi4iUti/Q8XGI0Btt+pVfO/qtpMPMdA49I7FjgzoOpMMVtubImDFM9xPCZ/VGg6JLR9/G7dJdtdIJEW3pp5MbNTa5Y4Y7vyImknIb+2vLBfAZq889vKT/0zUcdrUjpFTFT+aBBteCmlsS91BmysjsS8H91hPpsjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6631.eurprd08.prod.outlook.com (2603:10a6:20b:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 08:42:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 08:42:15 +0000
Message-ID: <db2456d3-c0bb-7198-7841-056212572682@wolfvision.net>
Date:   Wed, 10 May 2023 10:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Input: st1232: wakeup in Suspend to idle
Content-Language: en-US
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe Kleine-g <u.kleine-koenig@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20230403124707.102986-1-javier.carrasco@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0058.eurprd09.prod.outlook.com
 (2603:10a6:802:28::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: fe208944-fc5f-478a-6de6-08db513274cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZR6YxvhsxWn2TU3G3VvrDqLMvypKwZmLkDqu+PrbIu2mniAU9XMV+Tf8qon9qI9jJ6iqpayq378Nc7mbm/Tjg+xwRvOVLxzIq9NrAkGuhXU9sKdzegvJU5hd+r/X8mQeWXs37f6JWc4vPusmI95t92ktIJW8vmfPYyHZBZf3JnaHmtBezrMJqpqDJ7ZFllA7D+47vttTkp8/wHQ1bNNw9bHXSsPuLP9Ls+FGU+9RWiDwovGSw2KAXAaxlRQ+vPE1apYa8rbgA0XYbu6IyKcu5I+JYizXu1nWaT53C5js9kS8Ii7gHA2dst6eLy9uJ+vIjzcePZq4na8RYHrWdOYqeCjv7x1C0UmGVuRPkx1fBIDiLFZJgkhGqJaxYUGe5IvSbrRjj6ugqKBI3xudQobEJfcp3SqsPOAPHPt3zk15GDc3j7zQi6u3sumjLnr1fm8IY6/eMTS9IrlNRHizetFPJa7iVzVtr7vFFUMAM7bMoNUS9JBmoVpe8tsLtCxNVJ10AUmWHUHzfw8XFHT+sU3i4EQyOCvbXxtQ9fmcIpj/VCr47oQPtFiOoId8L2THA8G26lK7EK2mIjY0NJN+hfvZ0ruDZuC3up+eDkMEJvRt8Iqm1u1l8xpXMVXVLeW6KBbgT1q608DbJahBgCVGlGXqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39850400004)(136003)(451199021)(31686004)(478600001)(4326008)(66946007)(66556008)(66476007)(6486002)(54906003)(316002)(86362001)(31696002)(36756003)(107886003)(83380400001)(53546011)(2616005)(6506007)(26005)(6512007)(8936002)(5660300002)(44832011)(41300700001)(15650500001)(8676002)(2906002)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3F1Znd2dHRsaVNkVzFZbkY2eG1SZWttaFVpdG5iVlVjMzQ4TEhWdDlibHdw?=
 =?utf-8?B?bE43dTBCVEtaSEo3bjZWYVRvamZTK2VqdllqV0pObkxVbStDYVBzOHFOaE05?=
 =?utf-8?B?NjU4NGFMSGFIaVh3Uk1MQkZyRkhGek1WeXUzNlpienNGU2hiTFY3NDJtc2RG?=
 =?utf-8?B?bGxGcU4rWVVBYWlMMkZldzNJWE9TbUZ5RytHQXJ2UVBuTlBINTVmYlV6NUkz?=
 =?utf-8?B?ZXBZZlVYT0k1VEtWWkRyOXp0MTMycmtyOWJyN21mWndUSGRnM3oydFpjRDMx?=
 =?utf-8?B?WHErZUQ2SnQ5RmtvSENKdS92UEZOdTVOTGxXSkZTU0tRM09ZcDRzempZWkRl?=
 =?utf-8?B?RXUweGplRXFrZ1hLa1FXOU9xM0xhMTYrNmsybHFlN1U1Wkt0L0Vnb1JRM2M2?=
 =?utf-8?B?Y3NORWg3OE5Lb3psazkwdnV1SXY5cUhlMTZ6VDlHQm55T2g4cGwyUWlGMS9G?=
 =?utf-8?B?Ui9FMWJXcG9oRGkvL3hkekU5dW9VL2lvLzhTMWNZY0RiL2c0Um5Vem5VamFN?=
 =?utf-8?B?bHdLT3kybzdSTGV3Rmk3V2d4RjBzSmQrT3E3d2NhZDR1MXFuWUJUaHF4MW5J?=
 =?utf-8?B?MDBTdDFUMDBMMXhJMXpvc1FXWENJVHdZaUZHQkxJZG9ad25RaEpWUEJnNkk3?=
 =?utf-8?B?UjgwcC84bUZZSU15ditZVHZUZHY3b3JLTkU4STV1dVdXY1dGR1M5NjRYMlg1?=
 =?utf-8?B?U215QlpxRFhwckU3NHZ2b0tCcWYyYWV2RHZTZXVnZy9vTkh3VDZkNDQ1YWNH?=
 =?utf-8?B?akdoakdDMzdFNS8zLzJQSnF6UDdJcStoYXdoZXZ4SEdzdlh5WWNYa0E3L1k4?=
 =?utf-8?B?enRQa3lLYjRBcVliSUdCRHlwNVRzUGVVandTdDA1VGhlK2FBNGVORHdhWmMv?=
 =?utf-8?B?WmZHV3dLVHZoRG9hcjRJWFNXVzMwWmFhb0hUL3hJOVJMVDlUVTdIQXJpM3pF?=
 =?utf-8?B?WWE4SG42QlZWZDlzT0RJcVgzM2tlNExRei82T2VmZkNnZEJnck9TY05zcHhH?=
 =?utf-8?B?QTJkVWVLS0I2QkVxMFkzdnMzN3lwL1pDQ3pQREN4azlSSDVzbXJYR1NnVFUr?=
 =?utf-8?B?amk0bjZqM2JsUWhzamZ3Tk1SVGpGNjRJbjRPS2g4UTNEcWQ2WkpWMHY2b1Vw?=
 =?utf-8?B?ZWJ2YUcvQTRkUU1kV3duU2I5bElaNCtMNm5aOTlIWGlTVDdWcThHdjMwVWJz?=
 =?utf-8?B?UHZiRitmaVRRS0tkZDlUWXVobjRidWRlNjQ1bXNaaTcvWmlqdkVsdTh2SXVs?=
 =?utf-8?B?aWxUMVlXSzVJd29yeU9rdks2Z09vMGZ5S04vcDBOT0VkWWIzellpZ3FJdVVB?=
 =?utf-8?B?c1FISzVNZlQwTzV1M0I3U0dmN29qVE8rVkhnY0FMZ0x3RDBPZTN4K2xCekNo?=
 =?utf-8?B?QitkNW03REpqU3d3UENzdUxmVVhoZytoU0NrZ1BBc2RKQkpJemtvRWpHbTE0?=
 =?utf-8?B?THllOUVZM3lZSG1HOW83ZFVrOVNqaGFEWTZlelduMDJ3WTZGMnVXcEY3WjB0?=
 =?utf-8?B?VlFqWndLejlTa2ZibWxjU1pBWGN6SFlIU1JzTnJGZ013YU9LcFVqdnZxV3Y1?=
 =?utf-8?B?dU1ocUlobC9PK1ExNzRJTDdTelpDbHN1NjE3VXpiaHIwbXJ4UDhIMGk5QVpK?=
 =?utf-8?B?U21EL2pNbHd1V3hqTVdYQi9QSVZrR0NHQkxWU0lscDM1bVJjL0tYajcrM0gy?=
 =?utf-8?B?MXlETjQ2M1VMMkt0R2dMSUczcGZOS0cyZWkrTDVNQitnVDZmRGkvcG9GVFFE?=
 =?utf-8?B?bWVxRkl4T29xdmdlRU16ZzNKV0wxYXBhYUl6OHE2MkxtOThPczZFbWh6TTZw?=
 =?utf-8?B?Zzg4am14L0ozUTZwUmZGa2ZGVTB6bDJwQ0JydVNRMVNYRFluYjNwUFVkRkJJ?=
 =?utf-8?B?VGlzOG03VkhOU05yVGk0QWlRb01NNlh0Yy9VcVNXM0pWTVQzNTFCUzhVa3NV?=
 =?utf-8?B?dEp0bis0cUVqdzVHTDV0a05vQnRjQllmcFFGSUgwK2drWnFCcHNFTm9uWXZX?=
 =?utf-8?B?MHhZRFBjdnFEcUpuYjZLR0w3aUFUemhweDA2RXNwSGRmMmxGZE9HeXVRSmJ2?=
 =?utf-8?B?cHJKRXU4eVp5UGJubFhkK1daRWxXeHNXMzIvRiswMjY2YlRPbkdBaVdDOHhO?=
 =?utf-8?B?MHlIRnhiWUVkd0xpQ0VZcVRnMmp3ckZweWhvWi8yTWJwRVJ2anBOSGRjdXc3?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fe208944-fc5f-478a-6de6-08db513274cd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:42:15.5263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLABUc2fDfF9v0jYAmBUerRARqdp/RrPmQQ1gqettVQ1P7l4gM4WZ00DrYisWyild78RfNNfhhoSy9+hvXzmEvEBOEfd+U0h060KWBYxUNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6631
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On 03.04.23 14:47, Javier Carrasco wrote:
> The st1232 touchscreen provides an interrupt line that can be configured
> as a wakeup source, and currently it is possible to use this mechanism in
> "Suspend to RAM" and "Hibernate" power states. 
> 
> Unfortunately, that does not work in "Suspend to idle" (freeze) because
> the device driver disables the interrupts in its suspend callback.
> Given that the interrupt handling prior to entering the mentioned power
> state modes is managed by the power subsystem, the irq enabling/disabling
> can be removed from the touchscreen driver, allowing the device to work
> as a wakeup source in "Suspend to idle".
> 
> Given that the st1232 device driver does not reflect its wakeup events
> in sysfs, this series also adds pm_wakeup_event to the interrupt
> handler.
> 
> These changes have been successfully tested with an ST1624-N32C and a
> Rockchip-based platform.
> 
> Javier Carrasco (2):
>   Input: st1232 - remove enable/disable irq in resume/suspend callbacks
>   Input: st1232 - add wake up event counting
> 
>  drivers/input/touchscreen/st1232.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
