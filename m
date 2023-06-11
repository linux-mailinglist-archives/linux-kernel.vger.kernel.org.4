Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86572B415
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 23:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjFKVI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjFKVIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 17:08:12 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2138.outbound.protection.outlook.com [40.107.21.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABC130
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 14:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl4rDcDFUeFgtrtWz1WO2ikfMaMXPIFca1XNoQXSWX61h6S9wav9j+WrGVQlJrIH5mnk5xn/1MwWLdsexA7OdxNefWG4sYdZ6dh3tZWlNcNK0d+huMm9JInLsf2ipuikGKRCNg9fCsbyqjhaAqafurtfJJMZD8SQQctgPe8KWW6zirZ53L9CbwFk1S/y3+i41e8DbErjfh9q+8BOTQRuN0KRKb0E20mOIckP7QyVHAdrc0eGL6aUjjsE4ZF813CuTZj2Pcx6Hx3uCfXgHNXPImzzsnZ7XSqheSpgHAJwXAo/KX/JQMfGMyQEi/yV7Ikaei1xysBSGey/1Q3hmu2FvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FwL3g7h7uP4wTQktcrbYGq2OP7GNu1IZ4jWvYQ/dc8=;
 b=g09OJXUB5v17ElAW1L4ExvwXlsFCF/0SzxlsjHBzoQJx0cRRQFKK0TW7Jvp0doME6KyZ0iC25cFSFoJdCn5DJfJp+wyP/Wnx473cUdfS8i9reQKJBwS95GQHT4xag06FGvBQCCkpYpATARHZvoUv5sCMEtpFmUta7EoFhRNCUzTmX00YhETru9JF60fukgwMP8LNHJDu/9juyfkCvmFknZR2tLs1Yf88L7Jpv1ChcLRLsi/g4ySxsgWF/ciltTTNF0lQlY8inGU+Df4iRA96V7a94zk2G+W+jCOySHC+wQvPeN8dGax7GXYIA6LDIPHipqUn4ImxTrQ7jxjuQnT5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FwL3g7h7uP4wTQktcrbYGq2OP7GNu1IZ4jWvYQ/dc8=;
 b=lh/1ZI41XoUfx932o/kMuzF7XHGPvreyyDmxidquEVVzEoRSJ0tS4P3p24OCxfcc4b7iSZ+lMAuvM3T2rCZLLu6Wmevx5mfDdVF7UMIIlyGbbrqX2pZxLafxr8BY3R7wxHDBEDdDzVr6lJtuQuBYqpSNNjK58nImUvCkE9BWEOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AS4PR02MB8429.eurprd02.prod.outlook.com (2603:10a6:20b:574::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sun, 11 Jun
 2023 21:08:09 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::b530:6b1b:5f11:a276%4]) with mapi id 15.20.6455.030; Sun, 11 Jun 2023
 21:08:09 +0000
Message-ID: <b523ccd3-8365-7e7a-5f35-a5fb5492ff33@axentia.se>
Date:   Sun, 11 Jun 2023 23:08:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: adg792a: Switch back to use i2c_driver's .probe()
Content-Language: sv-SE, en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20230611204737.828617-1-u.kleine-koenig@pengutronix.de>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230611204737.828617-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::15) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|AS4PR02MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: de2fa9e1-55df-4984-f5fa-08db6abff580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4eGtJs4aApDPw0H1jBz9zfEESt1cLC2VH6hDb8wo9JC0jIlIKhtEbnJafVS07xG9VX1G0NSjhSYA2G8lCw3uCDc9tSkudUHIdR8acluvqlYARXPk/wdw2OWxUm1K0FcZLvTnJUxccggmW882moPkPtvkr4UZf8G+9jINe8OtL79Hun3PlPqzB+LTHPzS9ig1gWfx7C+HtSxG42JEX5APq+SrtLc8YwMv46bapKpK9+cIBsDftTeeikzcYip3brsMj2t+lgkab8t2YQwRPrC63Yi823gK3dQ8UqnlhRh5j1QDRul7z8Svj20ls+lNCJi7Jx1XrIXVxDdljsF0FQvcYFYEctnjnOL0VHvBbYQEYWXTgdpmU+2w2oOeZlISZDs9oFQwO5CvuJ6IqoORVNhQxR2nyrAiKGvwKaiv9iJWpdI8DI2oYoGFyGm7jHnzzhzv/jskMpppwjL9luHqeZa5lequ+gvm/lQcUQ5Aqjd045IIEFKX05rtyxfyml2uM3uBvuh+zhN7uQOWrz8NHU5Kzi6mhbjAd9HYIYopeGQDpSkWNmjC/UGwTDaVxL7ecqPKR/VcYqBWyPJn1l6MV1rk9IZx2SRZPs8OWtuEL9Sw5ReZM0AOvfrscnQm/LBixh9aIXVAZR4unKD9Bq2UULPNV97x06of9t9YFygwmvNZhXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39830400003)(136003)(346002)(451199021)(2616005)(6506007)(66574015)(26005)(6512007)(41300700001)(38100700002)(31686004)(6486002)(6666004)(186003)(478600001)(110136005)(66556008)(66946007)(66476007)(316002)(4326008)(8936002)(5660300002)(4744005)(2906002)(86362001)(31696002)(36756003)(8676002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENmaHo1VkliY0l1Yy9HS25qdzM4MjlGU0IyVUM3VnY0TExBanFPM3ZKMVFM?=
 =?utf-8?B?dzdDcGpwdVNJNHVXOWtxYzhNWFppWXRwRXdSNW0wUVVacXlYcDRSQjN1WTQr?=
 =?utf-8?B?WnQvd2hseEh3bVhkUHRCUnIzbHFxYTA5aTUrY1NYSE5tNE95TCtoby9sVmhG?=
 =?utf-8?B?L2YyN3Zoelg4YVI5cVhjWWhOU2dnYjdXOFVQRFFzTm9Sa1FIVVF3bFlFOFpZ?=
 =?utf-8?B?UXo3c3ZqTHVJWTcrcGhuRWt4YzRlWWVvKzZzRWY5dWtWL0I0ZzNMbVlnUCtK?=
 =?utf-8?B?TDZ5RUN6cUxCQ1p1ZEhDSVlmQncvajYwSFA0bTZNRThmOFNyZDZMdmhvNi9j?=
 =?utf-8?B?TGxaelRuWGZmaE9MR0kzNXIyOHVtRmpjZHpDY3NNeE1sTzNQWXJUUUtMVi8r?=
 =?utf-8?B?RUhXdUZJbk9pTWJzYVc1YTVqNGxaY2hWaHAyVURoZVl2cUVwbGlOMk1TYmpq?=
 =?utf-8?B?SEZLL2JoemtzQlJHN3l5YUdSNDhxN0VqQWRTTm9FdCtTZE9wR0Z0MzUySmZo?=
 =?utf-8?B?ZENRZUltRFBIa0FTVlhlRml0cGI5Vy96cEx0U0UrVEM4aHlCZzRySmhyUERh?=
 =?utf-8?B?MmVYRVFGOGtEWUUwWkpMT0lpejd4L012TXpZWU9WdDVaUC9WZlI5Q01WZDZl?=
 =?utf-8?B?MlVObmh1enhpSHVjdlYxSllEVU45MDYwVTh0Y2t3M20yQ0FQaGorK05mNkpC?=
 =?utf-8?B?K3BsV3V0enFTR3BrS0o0VGFUT0NGSWFXZmtFcExSTnZ0akl3dnlGNmhaWkJB?=
 =?utf-8?B?aVhHREJ6MUJYdVFESFd6dW04bGRJUENqQUhGSlY0c0pGcU9HbTFsK3lOYmRw?=
 =?utf-8?B?ZDZ4WkZJaXdZNVhHU3VrM3Nja21EY2pEQ0VWN2V5RVMxQVdvWCtnUENDNzll?=
 =?utf-8?B?SmZEZWpzc0QxSkdqb0toc2hYYStvR3lHSEtFS0lNRVpCY2QveW01eVZTdlRG?=
 =?utf-8?B?ZXJDTEVFcGR0Y0R4OGEwZnNtcmhhVmdrdTJDdThDZWk0bEhkMnVBbkQzS0o2?=
 =?utf-8?B?Y2xlRDFjWXFxWnZOSWdRY3dybzJMZGN4K21BSzJjaFcwbWZJdWRZd3NoRVI5?=
 =?utf-8?B?cWprZ0lvUngxR2xUWEppa0VlanZidmVCTVJENlpLNmtzWlhjRzZYK2JDazVw?=
 =?utf-8?B?aUVsMS9vNzlROGV2RFdUbEhUa3U0QlVPYjVmVWphRklaRnEyZ3NFdlJvcm5t?=
 =?utf-8?B?Y2dFd1VORnJDRmpGNkFxMU8yM0tOQlFrZldMT1phdGFIdndXbmFxSTNESlVi?=
 =?utf-8?B?YkNpblpoVVJyNFhpQXpCeFZydTNjSHZBL0s4WE9ab1cyWXJLTjRTMU9ScXVW?=
 =?utf-8?B?RmM2ZUZVRjNVYk9uL2o2MlZtZlZWQW84Wk13VXVWRkwzaEloZUhzQzdFUGYy?=
 =?utf-8?B?cVA2Ym5QbXI2dTVldlRrbFFUZVpGTVJ6T3hqKzE2a2NTeUVFazhvOXNPWkVF?=
 =?utf-8?B?WURVT1Z0M2U3cHNzbUxyRDhvbEpEdjgrUFJDSWZ3N0FQU25ybERvUlVWeisr?=
 =?utf-8?B?OE5HZU5TRkFxcVh3Q2x4anNjUVFoc083amd2NWdwbEpYOFBUdXo5SEN5bjFi?=
 =?utf-8?B?b3U4SE5iVzZ0cE93UzVaVzZITldRMW1xU2VDUXIxUXBUYnlXeW5sTWJub2Rs?=
 =?utf-8?B?Zm1KWnNpeFhzR053aENCa3Rqckh1YUcxSmM2bG16VTFQMEJhaW0zVFdrVnpE?=
 =?utf-8?B?MEZleDVHUzVnMHZNNnBVTWJCNDEzYmpGZkprRExHYjNiN1paZWZob0JZazU3?=
 =?utf-8?B?d1JUU21Md0Njc2xHVmg5WUlFOVo2QU85MW93RXBCN2FDbkhVdG9GaW91NzVt?=
 =?utf-8?B?TDhpbW5leDJxcHNkbmtFMitkalY4OW1LZnJ3WUQ1czllYTk3SkdXZ05MUWFu?=
 =?utf-8?B?V3EvVU1PWExZUUNUZlIwWVFGVTFMeW1Db0lLNXBRemtFZ1AxOEcralpyT2tl?=
 =?utf-8?B?ZGE3cE42M1NvUzJHRHpoWE5nYWFRTnlDRHdaS0NJdEh2RlpsQ3VmNGMrNEZZ?=
 =?utf-8?B?ckFiVWZkMnVUWlpJelVBNGNQUk14dm9sYUVRaGFyU2RRREQ0UEc2ajV1Njlz?=
 =?utf-8?B?WUVFdXZNUVhkMDF0Ny9FVlNHWHlZcTV1VHlrbUVWb3NQck80MC9QbVJRcHh6?=
 =?utf-8?Q?TidY59YfNNXNbcBQrxOcacoFJ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: de2fa9e1-55df-4984-f5fa-08db6abff580
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 21:08:09.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOrV1KfktCIfhDEvm+czzcisXkx6YDjot5fEilOKSgTMtGm1826WBJ7hrDp0Fqs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8429
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-06-11 at 22:47, Uwe Kleine-König wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> commit 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> convert back to (the new) .probe() to be able to eventually drop
> .probe_new() from struct i2c_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Peter Rosin <peda@axentia.se>

Greg, please pick this one directly, if that's OK with you?

Cheers,
Peter
