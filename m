Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D2694C97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBMQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBMQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:25:12 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2139.outbound.protection.outlook.com [40.107.241.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD13AAF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJVXVuUuExYxy6YvwYa5/1UpcTYnGTbGf4kYJI0aeGc7yPrsUljmtIZxp7Rmx/EAQjJeXSw7zsH+I/t2SiHCLDH6SiyWVdl432Y2VM+NvCQjJXkMW1H12ftf+cb2AFn/M5ls+WGAELblQ14wP4nu+lbQiM5hXiHHDHzQuNSeOC5xVJ328N/umGox6aWGk2RlzRvnPbyBorT9v4gFn91bYIXUGnCBI8SJPQzllHKUUELfMScArdKegRQj5zKHJmw1vJpBy9GHH47E44oIzNv0f5COpI5OQIRuFZiJc2uiQJ2b6yAnq2KWrXbpv5xmMxvCCN/QQ/3eny0W68cpb+NsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAlrcUvfjGpydxMzplPf5xIOnJNUsUmLmp3lomM051o=;
 b=VS28LN8ZZ/CNVhXQcheFL5iiFRYTa7b6PyUhI2ovj+jJQbgJogsRaZRE43MqjgJ3yqbDu/a9z78Ke3J7Cxp7SRMaygkvQik/mU1HA9APgY/vGEXx8uvCqBfZI9VPMGt9tVugZrMSD1aJKQZHpui8EE8tMlUoaSFmCTlIaqSg/MI/Psu9nup8ppT+DLC6dCtFQUVhvMupuGQ4ksv9eZW0aSmfgTPxiMcEiNUvVrPkJBN6D+4RJhgd2DjI34n+II9yr8UEfYukh4ZV81YDQt3OYaFGKn6LORnbHnapLBpSnSgEV7NWs6n76q1WKJf3E36ObeTV9ej6yVVkIILU9/qZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAlrcUvfjGpydxMzplPf5xIOnJNUsUmLmp3lomM051o=;
 b=FHNX9W+0T6bwD3uJaQllsliA7sEAaQua9hwvCt2VYdpbscEfvRYeyi31JZPZ1eDM0XgAveMfMx6zE+tWJ51VhHXT5dYCLhIKz8vHvtN7khAm2HZkpd4YlC/ULIGIaQFCq2qmwk+epYpEfIuUM23Mk7vTDeyFKV28lilZv/zCoN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB5572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 13 Feb
 2023 16:23:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:23:36 +0000
Message-ID: <4a334087-9c72-2d86-e1d6-5d08ed5adc45@kontron.de>
Date:   Mon, 13 Feb 2023 17:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/6] Revert "regulator: pca9450: Add SD_VSEL GPIO for
 LDO5"
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-4-frieder@fris.de>
 <ee7d0f98-3ae9-7e66-785e-65c9e11a7232@denx.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <ee7d0f98-3ae9-7e66-785e-65c9e11a7232@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e51dc8a-2c2b-47db-19c2-08db0ddea82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6ZYVwfE8A5NBAsUC4gzZcDmdaj7X4F0Z8+f4woM7vziqWA0qNLZaRncCgWS1x37d+zRdClqFrfpL5VwWZdUCQCVlK970XY3Nfedh48QrCLTPBAk8Fk1VhStv3GBj7QaekLg96WOUlMHnksCmQCjF5TWbQcUmMNZen6JrwSIf8QIql0XgeQXiPWNSj3uGpkubH1BdAECJq2zgciZQG9bP8vhZXIlX0Fs14VQ4wcm/74W0H6q+TOh3TEWqervjoRKE3gPTGBlzDbqp823PXawnP3M8iYPy0Fxte3Rhp9+Em85VWvqq2NG1wxpyykB9C/K5mcJ8wCOOYh0EhQcgSTS4WJPK0kc8XDXhx5o3NMFhWn1h6GorsPvJG8216M9W8XUMFZObQo398ZloY//WOvo2YvLO+jNxua3XK1d7keIpCUul57EGIB56o0KpsLUP1NH+0Btbj7TWiWDM9Rv2AdaQdtelvia0gIJnZ98HEVoq4blppbH+GQEIi9TTtW+4b2ZWPO+rDIFEm4Zx/isStdDvIHviIY0KsYpaic1vFYyGyHyGLKoc6cQveyrA8rGQOKauFKTtxmjsIjH7vORDU556uepDKy8e9F0P4vUnrZSgDfvvKyDWkNMvAubFcoeIA6dO+egQ/Ls/gV69yLC6VvLnIA2s7JC74OZv0P2iJ6CCpAGizRL0EubVgzW25lHRugfdwmr5pJZpEHya0RQjE/CYG1Ctrq7gQigSO5Sp68ZUek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199018)(31686004)(66476007)(6486002)(66556008)(66946007)(41300700001)(5660300002)(478600001)(31696002)(54906003)(316002)(38100700002)(110136005)(44832011)(186003)(4744005)(6666004)(2616005)(26005)(8936002)(6512007)(2906002)(86362001)(53546011)(8676002)(6506007)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUIwYk4yUGxYTTVUTDNVR0hrQW81RTJhS0Z6dXVFc29JTldSaStMNXhZeEJX?=
 =?utf-8?B?NXhYcWZRb2lJTnozM0Z1YXJFRVF0aXhRMUM1eFVUMjRrRFI0cEZZemJjUHdV?=
 =?utf-8?B?NkhMdHNYTERHYnFqSUJMMGZvSHJZSERJeDQyT05pTHdVeFNSWGZQazRyUmhk?=
 =?utf-8?B?TCtZVGU5czZuTFAvakNqbmdIRDVGY0VtNjVDTkdaZzVWS0VUak0wZHRLVlZE?=
 =?utf-8?B?MWVmWTZqTitSVVBGU25WNGxkY2xucUs3aVplUUpSMVdrRHNLbmpNNHBsNjZ3?=
 =?utf-8?B?NnI1SEc5dk5ld21hRTlwQ3F6WmdteHNZZ2tYcm0yTWppZWRCbGFRSUw2bnY2?=
 =?utf-8?B?eWFNZzdMUnBsL1hVTk43cmdlQWdLTXg3cXFTTTg1RHFLTDBVRzNROTdQbzFv?=
 =?utf-8?B?WGV6QzRyT0V6cUxPWlNRUEJId3FoUmFMM0J6angzaEFEb0FvRWtUS0F4UXRm?=
 =?utf-8?B?T3N2amNCYWFlWlFsUW1zUTY1RzB5NHg2QXUwTWhyQlYyTk5YWjVnZlJaNTRl?=
 =?utf-8?B?R1ZpL1Q2d1ZPWkRDRE9DaEtiQjlKZDNUNHdvaGxzbzFEUkttbDRha1lVVjR3?=
 =?utf-8?B?eDJIM2VPOEZ0NU12VGFTMmtWQVVOREEyOFVuUEsyWFZxR2VVNSszUWpiaTc1?=
 =?utf-8?B?c0VRc0V2M0cvQnpia0V3Zm1NOGpNYjE0eHFXb1BwS0Uwb0dyNS9iMVJlWUs1?=
 =?utf-8?B?aUZEVXk5YkpyTmF5NzlsNDRwcW9KUkhvWHBDMTE5SHUxN0h5T1VWekttakhy?=
 =?utf-8?B?cE5MN1V4eEhGT2ovNDJQZTdDY215VU5oYUNxcUlMS0FaUnZCN2Q3cklKOTNW?=
 =?utf-8?B?SnlWM0FMRHNmNHZ0RE9HanhWNnUrU0ptTHJ1d3VybGJ0VnlrUE1SaG81ZkRM?=
 =?utf-8?B?TlFITzFHcW9oN0paWGRqd0djVXJkZ09iOFBSYjIxQVhnSDV4V3JPazF5WFlB?=
 =?utf-8?B?VjBQNldBT25id1g2b3dIS1BITStURm1pK0NZdUhPNUNpcEg2bGh4dGQ1Z1dk?=
 =?utf-8?B?TklLakhYeTBQOVdkRDJTM29OeGVma1hQTytaWWw2UU1mMG1QK3Jmc1hWU1kw?=
 =?utf-8?B?SW5nSml5TEdHWDJaWk1qWmRWZzRyNzJDejAwN29BK0RlN0pmcFM4allFMW80?=
 =?utf-8?B?Z0RxZndZRUVzNGRvYkxPYk95L1lEMG1LVUlLRTc1cVlIZUNPOWRKdk9FQU9n?=
 =?utf-8?B?dlJCQ0RRZjJ2bWNMMExDT2pGUE5sYTdNb3piVk4rcEJvTnRQSFVOWlBRMHhD?=
 =?utf-8?B?dm1QQ05EYVRSZlhodUtMWGR2Q3dhNmlHSGN0VUNQUGpDWEJUd0Q2WEpxMEhm?=
 =?utf-8?B?WktyakhNZlNlTGdiaUNGM0drRmtXamFmMUg3ZEhWR0FwS0RmcWlMR3UrdUJB?=
 =?utf-8?B?OXhMbjl0cnVqbVhGNC9WSVdKM253aEpWMnFLeU41NmdDRGFPVDhsWEp6bWZH?=
 =?utf-8?B?SXFFNlBsVFBZYXpPbEVSb0VIRXZYSW96WkM1cGJTZWVHclRPZmowNEFjWjR0?=
 =?utf-8?B?ZjArK3NZWHZnM1N3LzgxalVWSm1SUjlFRUlYVGptcmg3UVJNNFEwOHI3WE5x?=
 =?utf-8?B?NFZrMDVXQkR1R25heUQraHpmR085bCszenl3SHNmU3ZLQklzUEhDV1FkdS9V?=
 =?utf-8?B?M1ViUURTZDAwV3JtYU9TRHcxeEpEZWU2UGF0bDE4eXVBZ29FRFpKQXdGbHVW?=
 =?utf-8?B?eEFrMjVVeHF0UW9kZzFQTkFXTmoxVHR2TFNXUjdza3AzbzZvVlhTYUtiNFZs?=
 =?utf-8?B?WmZkQUNZbW5pY0NpOW9NaXgxSThLdmNpcGxHcmVZak4zQ1ZGT0VhYmtKcy9G?=
 =?utf-8?B?Qzk2dzUzSmh5bzdxenZQckc4cTdtUzdoU2tQekZLclppSThCa1NvY1RISEpK?=
 =?utf-8?B?MjY2bjR2SlNnNXc1U0ZJNHpHaTNQYm5kUUxUYXRFbFkvUXhta0haVzV4bnFr?=
 =?utf-8?B?amRwL3diNGpJcHd5ckR2R2g5c1ZoUVVPdnk2WExBSGIzT1NVc3puZURTMG80?=
 =?utf-8?B?WnllQ0puMU1OUjZ4eFQycWRjcmw4RjBuSXVpaVlJSkdBaHZ1QURFcnBhdE1k?=
 =?utf-8?B?cGtTbzdtQXR4YkhBUjV4dzlxVG5DT0t3NHl3TlhhVUlucExxcUxDclJqSXpx?=
 =?utf-8?B?S0VsWExieXo2dVRKZEFVYlpOd2plYmhiNGZyTG5nRmFSVE1EMzhGWnRLSGI3?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e51dc8a-2c2b-47db-19c2-08db0ddea82d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:23:35.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEWoKpJOXWRL21TJouV1W2Q3hLjfsoeSG0KVBVUzztryQVA5vBF7FzDPyUdIhYiTeIeibAKPLrLlBDtws1gJ9v63YysHTiJJGu0KDD7BPYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5572
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 17:16, Marek Vasut wrote:
> On 2/13/23 16:58, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This reverts commit 8c67a11bae889f51fe5054364c3c789dfae3ad73.
>>
>> It turns out that all boards using the PCA9450 actually have the
>> SD_VSEL input conencted to the VSELECT signal of the SoCs SD/MMC
> 
> 'connected' , typo .

Thanks!

> btw would it make sense to squash 3..5 patches into a single patch ?

Hm, don't know. I think the changes are easier to understand with the
current separation between "revert", "core changes" and "pca9450 changes".
