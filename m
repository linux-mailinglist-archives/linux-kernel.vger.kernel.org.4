Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1345F9D30
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiJJK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiJJK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:59:46 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130091.outbound.protection.outlook.com [40.107.13.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC76BC9C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqYrTJRsR2s/2GIBM3M4jh/FWqpVAStGC2C1FdjY99Bzq9JzZSkg6du6zHG+C0gDBzIJs3Glpj5sCqXTGBGfgNe7BmxT6doK1sVWSBRJ+Xz825zaSPBl/zf4+cJ8DUufTmAQtou9vZPs9G9WVUzAhia4RQe6z4PIPLK95DE70RUfx/k6na1hWtXbES97lguEms1mfD4KsuK6B3xLb0r8DmAQvaAYTgWiIta0d+mQbR6iJ2vEZYTrYiUuB8S72xotBNP0bmMhto26cBCdZDUnVHLOg0rYn4tmR6VIvbTUcoQdTXhEiwJ2WZttP7JxbZDGrQEsh5uMA8dWcdH1Rj6ptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irUw+/zz/rJDj93uw4jWAXBq3oU8tG6ujSi4mETypb8=;
 b=M8mPENQeUWBVAvYQfLvHgI7jSDJDKQQ1UX82m8QGeFpRR7DyXzblgq4SpN4jQfRyHwmqOqHvPKFcHBHd14sygOSSdvP/quEDIfdQMfFhhUlxczIgwiF+klKbuqdMFyknbgakWSPwuQSL3nzDPNQh44Okxl2ywDmcj0iemJ18gHWF4huPrTLo3Q0d996+eXzK+zA6YJqoY4hqCrvE/gzRRm+e+rwR7zTgoDr3niHbX7/7lAgrx/o9RYg1aHJuYneZ/5opjo/c69IOAA0mdRBduxQTmSjSMJdy4swgmE+cwl2OJqd/claTtUQytco4s5N5lJR8BPNWrt/Wx1TeBrQlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irUw+/zz/rJDj93uw4jWAXBq3oU8tG6ujSi4mETypb8=;
 b=Y1fLba67RQuaTqG8uUx6vnvPA/NmjHaiearyLlPd7jv56alFLalJyrneDg5VhBlLDOPYxMxVx5EIiPly0ixaTYSQyXy7cNH/WO5/Ae6T0NP97LBH6n6Ck26n7wYjZVEI/UAh+1wMCx7PWC0gu2GAVkRwD3iv1/8ZNZUmFlTBGrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:59:41 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1fd4:b93c:2d9:2542%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 10:59:41 +0000
Message-ID: <8685d4d2-ffd0-5ae9-a23f-e41154a74229@kontron.de>
Date:   Mon, 10 Oct 2022 12:59:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash
 support
Content-Language: en-US
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
 <20221010105110.446674-2-mikhail.kshevetskiy@iopsys.eu>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221010105110.446674-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3611:EE_
X-MS-Office365-Filtering-Correlation-Id: be285545-9242-443c-4eaf-08daaaae8851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYFU0tmDYlwDIwbfK117qyYHXDkHGBivJhFwNdn8D6NA0+G3QASZ6lrp37WkFEWCpWH99H7ge1oLDCdNMbSqUctJ8iakAnOly9LxT0afb9m6NpGrFp4UQBFADbzgvwdsP8H/OvNQ1sZRP16XFdKfg3Suh4FG63YONcZ6XkBhkC2INHjYDnsdRfz5pGD0jfeQhX/LCrGLsqZwI5TzCw87DOLcWt+a9Ru7gctiIZGqEo7VIfluKnhJa/JmVZ8t3GiHLwDJQOv7kKWkdhkOwQC7NHq/R8rrfvykJmqUdSNlx7lQ7hmn5g+XZY7dtHTRWoaX7h6gPXho/jB9/eAC6C7W9DRJqHqq6sprCWlWnLpR9InMxL5nVtLTHRJ657IAVH4up/ru29kdCJSuGOP1du0VMgnJ/L6HJx5mXbFzoB7Puli5AoqnlrYuGpl5uufQxq16YMw9dpzkMJjijhFZBKk1eZxjkiXTy8WYK814uGXoVkDll1ud2H61j21mi7TNRa5jOHQDBer5xqamgxvJ6c9L6FxZySKxNkylAne2UwrQqBRkevmMqzcwD3yeXiGiecRJm8BKeUbQeNK0UPfMkxEmE8hwI5x+hkhinFf18Fz8HCFxffMElAGTY7rgEvlYUxhvFZwIcxeFFpEtYDHRE8BhtIGIU7+hUQdMh2C5SJliYZ370l4SypJrhFwvRtUT6ptGklD5IJ7LsZ2/kGiH76jmMGUoyLYezU4Pw6taFx8kG5UrftLriI/9a2ZraLlW5VeBOmISOs0/KC4yTAyAqGEZRtzakquDi4e1N5Vsb3/57VQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(6506007)(53546011)(26005)(31686004)(8676002)(38100700002)(66946007)(66476007)(316002)(66556008)(4326008)(558084003)(36756003)(31696002)(6486002)(186003)(6512007)(478600001)(2616005)(86362001)(2906002)(54906003)(5660300002)(8936002)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UENERHhSVXdycUhDQ3VmU1JzMUdaNWJwMmVuWE01RjNSZlEyRXA5NlhiUkN1?=
 =?utf-8?B?dmd4MzFoQ3dJbjg0NEpBdUpxV01kbXB6QVNvWEFrcmpuYjdBcEF3U3lKSWlr?=
 =?utf-8?B?SkFSaVFqNE95bzhHNUxYUVZnNmJ4R1djYTJKcEtnNVlXemdSQk1OdFpOM25I?=
 =?utf-8?B?Z1ZONjZ3TWw4QW5DVEQ0ZWVmNnZKT2pFeFpWQXg0ZjhHZUNCUXlVaUpvRXdl?=
 =?utf-8?B?bWR0bFRCZEtHNWRLTVdTRDdJNnp0WjYwdFp0UDB5TmlnOEhFQVBhdmlURWdk?=
 =?utf-8?B?ZnRqM2h1WXoxaVY5SW5pWDZPNVQxV2FXQ1cvUjhDUXpLOUVCbVRzb25jekpY?=
 =?utf-8?B?RjFIWW9PbWgxaGsrN2I4NHZTSjZvejU1dURFYUVFVnpmamJSd2NxbTIyRmdz?=
 =?utf-8?B?a09TdERvSHBINFZOS2NKaWYrZ25pM2JCSDdnRHpWTlh5NGRTRUFlM3UyME9D?=
 =?utf-8?B?ZktrcUVyUklWanh0YkpWbS9EcVNWSjUrcVRNTnRnejZVR0I3cjVDVnRhRkU5?=
 =?utf-8?B?N2pXZUZVbzVDbld5VWZ2ams4M0NmVGV3c0xjckF2bjdqMmp6QzNKSkEyNHhq?=
 =?utf-8?B?QXV5aDlDenMxSit1dzZVckg0WE5VSVBCckwxbEhkei9wS3V5b3JGcFJDSUZG?=
 =?utf-8?B?REphZk42YVNOQmlZbFZuT1ZRNTFuZG1rVDdPZmFZSXgrMHJRWTFxTmptQVBm?=
 =?utf-8?B?VlIwMW5lWVhlamtZdUtXUjM0RTQvbUJrbDhrdUNhSnlrUUtWMkYwSTc3bDZT?=
 =?utf-8?B?R2FkdzZUSmtHWGlsWkVmeHhUUVJ1Ulo5NEs1dzlGOFU3ck1iOUk5MFVlYmNl?=
 =?utf-8?B?YjlTSkZheUtqcEhDektXUm5vMWIwbzJGOXNYN0J0MnpoTDBnNFd6V3RTVEpN?=
 =?utf-8?B?MlFweGNOOUNHL0phaU94aFFMdWQ5aVBFUkJZVjN6S3pPTTRBZ3locXlKQ3pU?=
 =?utf-8?B?MU9rZkNxY3d0TnVPWXJOTm8zMENYR3dLa055RTkvd29TMkJDSkR4LzA3enl1?=
 =?utf-8?B?TU9hbmlXUlJSSHBOT2dwQXMwSkxZeGhoc1ZXWUxtdDZyNjF4QzhsODFPQk5m?=
 =?utf-8?B?WTN6ZTdPOWZucHdQT3BHZ2VYd3dDcVQyOXY1V010VHUwcDJzRTVTbzdPZjBT?=
 =?utf-8?B?bldnZ2FUbDNCWmoramFPTVl2dXp4WEpSbU4rL0t4YXNPZGw0TE9aeXBjQkMz?=
 =?utf-8?B?R2plVUR4SHd3am9tN2R1amF3MVVtcXlxV1NIbDNkMXBsUVJQaFBJYVNHMUFT?=
 =?utf-8?B?RC9LOVJWWm5lODFFYTdvYUVubDAyVzYyS0pEeGt5NEhEazZaYjFxUVliVUp2?=
 =?utf-8?B?OTdkNXRQQW5TaGUrVWZHa3owTXZnN1FwODlheTdQeHg0VG5zUnBIRDVZVVdS?=
 =?utf-8?B?NFJFTE5NMElDdE5kMnJhUEJURStKZXk4MkJSQjhibmdlY1RBQThTWUdHVHV2?=
 =?utf-8?B?TW1QZG5aaUdFWTZrSEQzb3dCdkhUcEcvWVgrbzhaczJhWXJyd3A5NWo0RWx3?=
 =?utf-8?B?K2dPaXl5R1NaU0tnRXNLOUtwTy9lSDdPT2xEUlgranFxRXIvMlMvdXdKMzE2?=
 =?utf-8?B?emg4dkFwZTBGZXRaMlRndVhvUEd6NmI4R2djd1o2U21idE5SaXBzQU1JNEYv?=
 =?utf-8?B?YTRqNnVMRDNFK3BMRFFKRFhsQmJ4cVZVRDVxQkRueWtHVVBsTk13SU9sdFJp?=
 =?utf-8?B?TjM2bE03K2ZlaThRZzdZWlgzanAxWEFrSC9sTTBWbTYvMlB1OHZwaTQyWnZ2?=
 =?utf-8?B?MjVLM2crcFlMMjEyRFJ3NG1maXdjTWpXckZxOWlzeUJFQ0s1WDVJUTJRZGd2?=
 =?utf-8?B?R3hOcy9SQUFBUW8zSHpKN0FmNWlGZzZwWVdNWmZFRGVHK1hZSnRzZ1pxbWR1?=
 =?utf-8?B?aFQ3eXVCbm9BbzhBR05FK0tmRFhtYnpVS2ZXR0hhTlNoY1lMOFZCbkhhQ2dy?=
 =?utf-8?B?YWRpZzlyRkZJVGE0ekZPRXBESUIzV2tIZndsQXFSVENld2JKWUpPejl3Zjlw?=
 =?utf-8?B?T055ZjduUFh4djZpcnFYZDFzaEI2UWlOSWJXM1V2M0VqSE1ZZURtRnNIb3gx?=
 =?utf-8?B?eHMrK0Rha1c4ODFFczZQa3VkV1V3NW9RLytPRmxxV1pWL3dWY0YyT0NiNU1B?=
 =?utf-8?B?eDJoTVV3K2JrU0IrSVNhZ3FzV1JzY3ZjVmd4eTdZK3FjOG5FSDdoL0YyVzN5?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be285545-9242-443c-4eaf-08daaaae8851
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:59:41.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p1ZyM5LJqoNqrAZEKlyNojqLjtGqJ1/AhHQkh3lE30tIFXxUSgrYkX1zcMS8pS8RJQO4cNIuERDjzuGk1hTJtgkXOjT/ySkXEb/VFj1Z4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3611
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.22 12:51, mikhail.kshevetskiy@iopsys.eu wrote:
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> Add support of Winbond W25N02KV flash
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
