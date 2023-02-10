Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD3691D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBJKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjBJKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:41:27 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2095.outbound.protection.outlook.com [40.107.8.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB13BB93
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV3b1ORwGzSO6GhZr/l/hghbm7niSJni6eecXrqp6GqtPgIoY28J9LFYKqWEAxjTINDQTLyv+pe+XaPAPk163W/sizycfm5ZWDP8YSxxvf1SY0GhHnWA2J0DmbUpeY/4uL3WOA85/fUhYCtBWT8s+27HlhoFQhVhgzIbYbkXsAggdU278s1jT0+CsoBD/Ve/gZV+f4R4/N0shQQdfExjJ3wD32k/QGy9ZhII3PQk9jU1ps1iBrzkYxsSVGAiHbcXdcgHpn/CVeVSdHt/ZU87Ojqb+Oe61WCl+lPdK79LWaHakfx5O0YYh4+e5gPJYs7drG73dLjz4r+07lP4DL7FNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5NzeK3U0tfJ6IhqW1Xl+P6oLuGKdYpVZOUCFM80nmU=;
 b=lpF/jcjThCpFAiBUfNl9VpELuTtytFoM9V5hhzQToivMRMIPrPP979uKUvAqXaov/gJlDRahnrxt6llSwtGETv9qtMr8/vy21FU9s/tdUPWwddC0ofVlKHHoAFWbz1KHTS0gibZlePsLgnNrTPj4XnB8FGrLP7VjniLRl4rFynojX8jOHCx4U065GnLzQWjw4B9XV+SSbJPNLao2at41UNIJUUMoFJ72oV1WUflCbW5Fm5J/9ubp5pKg3szt2Y/aodq/ggehFopNBpyCilr0ZaQT3Wl51+IGJtNpMb8yRyWNu3Vd+qcXceYRldduW4dzjwgH2dULlVAv852T7Zuu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5NzeK3U0tfJ6IhqW1Xl+P6oLuGKdYpVZOUCFM80nmU=;
 b=WJkkJupE/Xyx4FodsjfXt1mossKlr19iqBGTm1lH7XFqIZyaDffyrSr2E8yLyfAxKZZnQIdIJXipOAd8djoB1cnnVDYjjsRZj20H3FYzmCff6gRZWS5J1HRy7UJJKHvuY/EliDa0DkzQqyBUL5cppWjdGofBl0b4mbRsoBJk4Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAXPR02MB7909.eurprd02.prod.outlook.com (2603:10a6:102:276::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Fri, 10 Feb
 2023 10:41:22 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6729:6fa3:a04a:5afd]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::6729:6fa3:a04a:5afd%7]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 10:41:22 +0000
Message-ID: <d1a3d8dd-213b-3772-17a7-c08e06cab837@axentia.se>
Date:   Fri, 10 Feb 2023 11:41:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: mux/mmio: randconfig build errors
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <64cf625b-2495-2382-0331-519d1cab0adf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAXPR02MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 115c6ad4-d7ee-4d15-f6fc-08db0b5359d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QgnqFzyIWnIcNFwjYqu5ZZUewoq9wpU3SJr0Hn0uOBT+mvrH2l1+ADBb7zVT3bhWAcaKLKH/sYJu5WyP2XMbBuiPisxIOoKk2gEbibNjznc2Dw/BvJTlljnu0ZDa4FCFR8AB7v46eAnozb7L4be643v09/jpoOrpbsYXUNeAUeY3ra+C/E4rqioG7BqyUpE7i+SJjST/zSV5sgisin3UWwLUCyxZ0yCzSR4+tXqNtyPlNcfLG/nhSY5NGIBbqE9N4MNvbkVT1AGPSWUviwEMFIW3aT1kd3bIo1SXFeX9twvq2qJhakUi7DiLZxfZtkGBiawExNeJtPTg5V2eSu22ylVE/ARnzYJWJtR4WSg61FQmmxHjJu5lf5Tf0txWU0nEZSsM7t9paUMPHrBJJmevqS4f8HrXSVcQcRUj3ZkAfiDQHeEl7FPJcq1Fn5V2YIN1k8bZsJS+B/R3bMiUsZhF5P2J1+SkuH7vU5oxRKrY9F6C6PVjsH3ySXGUSeUpXiYkhWWRpsbJIgfalOlPcAELcZD26Jfu97JOF6qDHyEYugVMuWU+GO8CaE80Uz3UYRW/EA7lm9LqQ/jzqcHoiB0SrGYQtc9BeJMLP4Vt/X+r+8vagjpHABmt7Hwo7UsqfKIrbh9pms0/Y8H+OF8BJQYMUhfBuRfMefYoLI1g8NQJBDKu6mN6BGAVfZc2IP6VOHSHSgn5Hz+eascdA8TpsmCd0siN7PmkydF00MKaejAjIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(366004)(39840400004)(136003)(376002)(451199018)(66946007)(66556008)(66476007)(86362001)(8676002)(31696002)(36756003)(38100700002)(5660300002)(41300700001)(4744005)(316002)(2906002)(8936002)(110136005)(26005)(186003)(6506007)(2616005)(31686004)(6512007)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdDZ1NHaHVONWVrOERJRGlGYVhHeElKTzZYakxYRXIwcUs2RUxXcnV6YzlJ?=
 =?utf-8?B?Njg4SGY1eGNqQUZWRW80QlRheHRkeDBIbnFxOHQrQ2hQbGIvWkZQb1BZVnBU?=
 =?utf-8?B?TVVBaFUwMkIraUV2Q2dGTEMvZ0ppYUNxMGs5eXhBVHdsWnJIeWNmNFROQk92?=
 =?utf-8?B?U3RVZk9PNlltRHlDZC8rWjh1cUR0YWhndE91TEFJSk5ueWp0VEIxdkMrSXp1?=
 =?utf-8?B?NnBjR0dqb3dRcWtyMmJ2NHU2WHMzdFFwYTAxSGZXTmorUUNCTi9JL2VTelBK?=
 =?utf-8?B?VUpUbmdLNUpNZ3pZeWt0QytEaWozR0VqUUNkTE1jZktodnlOQnBUclNRQzRO?=
 =?utf-8?B?RUQ2WFlaQnVab0xIb0hrUC9yQkQweVgwa2tIZmlhcndiY2lmSHU2TFNock5r?=
 =?utf-8?B?aWpYWE5Va2Iyak91WDI5ZkNJcGd1R0Ivd0ppeW4vZVZwVGJIdDlzK3JFZStj?=
 =?utf-8?B?OXdmcFJGQktQanNCUVdDRDlhZHJiVDhCcTdoOTRlcmsxaTdYSy9jOFdySUlp?=
 =?utf-8?B?REJIRWpGa2k2ak40dkdBbWhOVzh5TjJNUTBFM1ROVENZemJlWTBaSTVSY0x5?=
 =?utf-8?B?ZHRGSXdyS0cydko5UTJtdnkrRlJScEllTHBOVnZLeEdRdHM3M2FnZGdyRzRk?=
 =?utf-8?B?dnFmOGU3cjlIZXJXTldLUm80S2JTclcrSHhIV1ptSnNZdWRjbjQzNGIvZTFZ?=
 =?utf-8?B?SExadEhxa0txc3puNitHNTBiSWQrb3pLc21semF6bEFoU1pCb1RDeUREeFB2?=
 =?utf-8?B?eURnVVhXL0V6RWhEeTBMMDE1TG80QjBRUXJFZ3JGQjBYOHdyT2lqS3c3NUl0?=
 =?utf-8?B?YmNjT0RORkd6Ny8xR2pXUE9wWGxjNVBtZkxQSTRoaUJ4RGx5Zk1PbjY0LzBC?=
 =?utf-8?B?REkyMnJQMHU2SXpaWTQ0OUJhdlFRUXFyNEZNOWo2VE42L28vWWhxZmpnb21r?=
 =?utf-8?B?UG16Nk1vd0NnM0NHSStRc3doVjdIR3VSUmNTN0huRUgvbWpDQUo5R2thU25L?=
 =?utf-8?B?MVU3N0F3S1h1TGVrdHlYZm0vT0VGYmFzNW00Nm9rMGhOenp3RHQzQjdZT2Vo?=
 =?utf-8?B?S3o1MHNyRk03akg5SFpjTFp6ZGVvQ2FkWUZNcWltY1Rpd1plZU9ZZmMrK3FU?=
 =?utf-8?B?ekdyZ3g4THQ2Z3IyTTNidkU4ZDhPK1pIRllQaWZDSmVTZXllNXdnOSt6bGJa?=
 =?utf-8?B?eG9IdzRyME9oZkFoVXNuL29jdDU2SnVHeE9qb0xGQWlWeFhBN1pvSEhwQk5r?=
 =?utf-8?B?QVdQWkZHSG94eHFhaVl0ZndrdG02YWdUUUdRMkdoYnZmUDdITm1jcTNQamhR?=
 =?utf-8?B?MDJlL0pKTWdiTFlnRG1xTm9NK3o3U2dYQVR4VEpiWkxnV0pGYkxWcjZHZ0R3?=
 =?utf-8?B?Rnc0VFlkaXdLYjlSM25TaWtVYTdOVGlKcEZrNVVtbTBCaGZNZ1BSbU5GdDJk?=
 =?utf-8?B?eVkwdUp0TWhNc1IzZnkzVjM4Vm1LWGhjWHpNV0ljc1htR3pJeHg5OUhOTkFD?=
 =?utf-8?B?TExFZVRtU291VUZ3d2xYckpkaElsdDU0ZTRtWTRIYlRYa09FNngyU1YvRnBu?=
 =?utf-8?B?dmVUaGZBOHd6TGRobkV2NmM3UjltcjFENElJQ0pxM1AwNDBFdGduTEE5OU5U?=
 =?utf-8?B?a1E5cURjblNKSnp1YUo1S1ZpcjVRTnVHNDUzSmcrZVRrZzFDVWxvRDdGTEFP?=
 =?utf-8?B?RFJIL0g2Wld5aHJGd1FraGViMWlyM3FUdFYxL2JlblVQUEc2bzgxK2tBanhP?=
 =?utf-8?B?VW5WdTR6V0tlZDhGa09rMERoWUxBaVlhUzF2T09JV2tBdmROWGZmT1RsbjA5?=
 =?utf-8?B?dXZuK0lpenZ4T1pBdTMxNVdScUcwYndzRTE3ZWMvNzBwcVhZaWxOazV5ME10?=
 =?utf-8?B?bXhvL3UzNVRua0NreDBndFZrZ0dHZ2RPRnpyMkY5TlgzRjB3MVVWdnhRM1BT?=
 =?utf-8?B?c1I0VEsvbzgwN253WW9wTXlKTjFBT2cvYWMrRjhDQlRhY3liM0pwb0RWREx0?=
 =?utf-8?B?Y1R4Qm1YS2h0a1B6UW55cTd2YWM2QnpyVzhhZ0N4dGJpWEZuWFRuVVlpSFlB?=
 =?utf-8?B?T1dJK0RpeUdpWExPMTQ2SHBHNGVqVTdpSVZxUlh2Y0czMVhmMXB0TXEveUJB?=
 =?utf-8?Q?o4I9vi07qcTNMqIONpRotZRn/?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c6ad4-d7ee-4d15-f6fc-08db0b5359d6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 10:41:22.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl+pYpGBxqqIkZpJE0jCCFODU/h9W13hSvsd1MMl5UWL3yveiPuZRKhwO0rKatTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7909
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-02-10 at 04:34, Randy Dunlap wrote:
> ../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
> ../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
>    76 |                 struct reg_field field;
>       |                                  ^~~~~

*snip*

> Does anyone have any suggestions for how to resolve this problem
> so that an erroneous randconfig file cannot be created?

Look like REGMAP is desperately needed. I'll follow up with a suggested
patch.

Cheers,
Peter
