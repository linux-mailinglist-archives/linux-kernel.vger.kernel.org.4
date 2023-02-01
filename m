Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021B66866E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBANaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjBAN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:29:54 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D5164D87;
        Wed,  1 Feb 2023 05:29:40 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311BW5Tr002938;
        Wed, 1 Feb 2023 13:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=xkWt3LI+YLiu0uf+CzCNT1GpM5RsHrta0JPeh5TPz08=;
 b=guRn9t86hv/g33fpdJgZJaOOAgM5zF0utjA//qnFfYXy1CdWXaLgHDz+B9uoXW7wm9/R
 Jc3mWnKY8uruiJiUkdFEbf/x7jdsbP3s12ocgwVWFFfGQaQTyd3ogEgHV54eehrtqpj8
 jvkJ6LXBOi08p/m3Ca4K2xhvuHoE5+Uaw0bphMI4jwTpxjbUsJOEeXGm78mxVn0rSUAC
 XdM6xjg2TeVRtF8RU1DRwQQ/HMeCjTAv2PpS4jx80RvIE0cPJyG263oA616F1fCwmDlA
 /syeD8ETQ7CusGvrFTHE62WSAWwZ6Y8s+ydRMEmeiNZZcSRO52aTlz5eG17djU+ZYl5K Gw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nfq8dhcu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 13:29:16 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2679D1319E;
        Wed,  1 Feb 2023 13:29:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 01:29:12 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Wed, 1 Feb 2023 01:29:12 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 1 Feb 2023 13:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Taw19n6uWR9XYmwKEBy43LFn8eUG+u2tKwXKJ0jY1gAP6ympHwU1AFy2GQrcjj2z9Rvt2qH7RNCC0u5WVB5eFC75ToDvSKJDm51Xb8sPUkZXRCtkA4Jo1uV3O9uIE9VcIxlt92SIcZTC8rH4z0pTHemyZxBVoVGkeVmjgDCHZrMmZmpupLtKcFbFYeaWRhjOtqmDtH2pmH4vHvRIIHR89uj/wG/dV/5I/f/zN8tZVuj+PC04mg3p/TTq2dP3JTUz76YLdL38VsvGSSqAZtgVLvgQl59RIQnVDKXcH+P6lLZYckrwyVG1PniSoitMzUIQAc8lFvuQC7oJYGtXbcahHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkWt3LI+YLiu0uf+CzCNT1GpM5RsHrta0JPeh5TPz08=;
 b=CCuuRfQtAV5RWDb6uMa4FRjHGGS23tGS96jE5KItgVUwty5sp5nK/UjRwDsSpZTa1X5j4nRdg2JM7k+AiIGZlIWraErGszzJp2atuTLrFWWjAJ9RXFk3z+YyDmF63HolwI2GKZ0ffU0//6zvKrv7xis8kG8MyNMLxq7RnA4iURaXNqjWg5dABHI1uj5wD+XA5VmeWyAFpjETebMx/LmzbVrgWYN+lf+t1ZDzK+9DuIpGJ/tOmuIhLyD4tkBz+c9DC+UK9oUbLAdik+hURuv9jbZCj5OwWmrEgdu1HAniTRbHNUzfkG8+91omT9aptZGDBTlvB365lYhO1DfLhluKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by SJ0PR84MB1505.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:381::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 13:29:08 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9%9]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 13:29:08 +0000
Date:   Wed, 1 Feb 2023 21:28:58 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/5] ARM: Add GXP SROM Support
Message-ID: <Y9ppGn0rLfnA3vz6@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
 <Y9kbsRsRcOnGS0ps@enigma.ccjz.io>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kbsRsRcOnGS0ps@enigma.ccjz.io>
X-ClientProxiedBy: TY2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:404:a6::32) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|SJ0PR84MB1505:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992bf13-9a8c-40e1-2024-08db04584bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1dGGbaNuw63A+eB2nrbE1A3YrvILAKBq0wKXVpAxz++cehxkuzaNZA09zNnahdt6sCtc43Fb6PnNdle6Vd/7hN6HiR6Xx33SYxfjlZUujCKniJutx1IS/M1n7I2KRxOHPoRDK2yKUV5giXISZNzpqHqSBeYDoFgOwNQx4JEScMmRWicNrvEdtSzXG43sHpsswGs1CzukcbefVgVd/pqJHyaLoV8y8vgfVfjUJ5+CR7XY/kHf0l+G6gMBq0ZKNMBgzIlDRYtE8cWPKVqGKPsBjjNVn26JY5wADUnJBt2Idh8eypjv2T3tptxLSzeb5Szsz7nyXhHzVREfN+jvv2e5CKIGY6Ffk2QNQW8I3gFW+vdGlN7Rk52PmkurQyTFBqmVwlEW/d9nqyBI3TuzMvubEepqoqdkbWrlOsAaJyTkQScsK1XVVe4cNxMZ+rMcvkG6DnTfUh7IfR9nWfBevWiRfOoQa0fRfOP2XkRh4Ih60SrsGcWvHWm5H+vrXqkHC9yO4gblGRvTsSs9HOXonqSt9J7YxzHGo6lvE3CflavXu6V/qlv4g18n4zutb74cKNeK/kot2NZFvoz5rUpfX1a2myKpjI5HRbbUXfZVerYrsKY7uNUfLwALbQfpUZog7rR5lQ1j7gxFezAj0KY9/g4HvVjSwTt2ih3BFU7PObf0wM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199018)(5660300002)(8936002)(7416002)(6916009)(4744005)(38100700002)(82960400001)(86362001)(2906002)(54906003)(966005)(478600001)(41300700001)(186003)(6486002)(6512007)(9686003)(66946007)(6506007)(66556008)(316002)(4326008)(66476007)(8676002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySViE/N8052apUBJUvQ3Q8UZ8a+INE6QMqdfuwIZNa6ZRIsJTPhBWuScDqNX?=
 =?us-ascii?Q?Rnnm7b+mOoeDSwAEctlxnbTWQR2qgpSHgetjeMHdMhJsiVclIsbG8XqW491D?=
 =?us-ascii?Q?OaVh3/Vc5XmDKOAjrg/yWp7gUpfkeGNPqdv078J1r83ImaeDRRarNxV2Gx/F?=
 =?us-ascii?Q?xtYTkCHqAtaD0p2LNbB2CrzRUfl40emVAthB2sGfQM1kMegMQST4LRSLbOFl?=
 =?us-ascii?Q?NCxYboWkdpPhYYK7/C4gzC6kA7L/F3ZQgqyJG/8bMl7GpRSOT7cmhlbSRazK?=
 =?us-ascii?Q?YZOAhp9eUK9/011oxL5sabzllgRAhRgUERBGq+h98J9/diyrORIKUcTU7k6O?=
 =?us-ascii?Q?Ukz9AEDl/WLKhjS2Xsa175p5HxueaXQnzTZqxDBCeQw4aMJ6oz/drFc+Px8y?=
 =?us-ascii?Q?jn0rxUuwFUY0Ti5alWM0mWKsiKFs2qVQ5TLgaHI+HmzwPFyg2pi00DP9KkvI?=
 =?us-ascii?Q?lqv5GtSuQq+KGnLxIiyyMRDrQRD1TPZ5rZ4Q4A2T9IlJ1S8xbjkgQz6jNQJr?=
 =?us-ascii?Q?FfxAo461HB+Js1LtkzbfhdnSeAld4Uq0GnF/+Hz70ggfLMV6o2h5DWzUaptS?=
 =?us-ascii?Q?Vwl3ZwYmo8sKwDNw3DcWci8S8X0IxxZLMsh3g+j0UCfVYfBIqpmuWKHlhggo?=
 =?us-ascii?Q?uYfPhOB89xyv/2crcLPxTjJS820ttUwsa46GTvOvEedk4LVjMiCD0fg3egXm?=
 =?us-ascii?Q?SwUe6MNSVukjJ8sExsOqjJPhdJ3G1uMX4ZiTHzTzl3BoI+YR89QOfnj0ObfK?=
 =?us-ascii?Q?Yo+nNWa71lC1UtbywRhKbdV6O7ldsz8goNUT/5xTr+UCPn2JPECYuvVXVWK+?=
 =?us-ascii?Q?xKGTVCkmu48S4pAGMZVxV9hgRx9cYlihVRmxix4ud2LMMX1PWZSBl3oMSkZ5?=
 =?us-ascii?Q?tjf4JDaX8V3bNhkEJO41mku0xwig7VTdKbuIJf7IIBOQs+NUPPOAx2EGsNQb?=
 =?us-ascii?Q?IvmTtFfGxba5YLr2D1kdXoMBzGhSt56kidGiFo/d0y7DLfFG9sVvgq93+Jl6?=
 =?us-ascii?Q?a7FdcTir+EhEuvBUwc3YZcE56HIiG036a0gTyJj2KAuyebMMx/y8TqQk9n6j?=
 =?us-ascii?Q?NUAzALAvlzgwfp5XtlBdVSIF2lMLhP+nAgN4pZ43E5XLe0n1NN1dQAqz9+JR?=
 =?us-ascii?Q?sEJf6P6e7GWZ2G6rPowgevyDYks9uV2SpVSlrdBIftRWe/fSf5tNo0E0qqF8?=
 =?us-ascii?Q?aK2d7/iEgN8Hw2pzE+zliLJjXKDD6ct5asjd78uRkYFEWswLWYXMCOhT3ZSn?=
 =?us-ascii?Q?PaFQMTItgxn7pyUphZbhEwfbkqUCoU39py3x1pI9/ig4JDUOc4qAfU18hMQK?=
 =?us-ascii?Q?JkYCpt7l344nqu1kbQIZZpch5dciueQI7uC4TcMUJc0dhyEgfgWcYXwy1EiH?=
 =?us-ascii?Q?mXV8NVfEWgFyCiVPakAYRbawwbVrtMaUinnikCm65NSNe+vmdFjbbQd2lV+d?=
 =?us-ascii?Q?NvTjq7szyNg3wytx3bmxtMOBheB40RkEtOa8mOWFMq2whoiCq22d0SqSjqPV?=
 =?us-ascii?Q?kVs5QOhQdwQA0AYk60TiYoVMp2ZKyCimSva87AGXzdyW7OCMQp1J6u0/p/E8?=
 =?us-ascii?Q?CUE9GBaHy5fQd7c+ZIiiLJc2dImbik/xzZoLPa+ftS+AM4HwA9Pu6+9JUyFl?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992bf13-9a8c-40e1-2024-08db04584bcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 13:29:08.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XadWIFBv3rrn0U67NuN/qBUPtXzLwy1kX1Aq1vHyHhv+7bxIMdRnAwAR06w2yM61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1505
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: HN7uJA-cSbA08m5SSTpHd9uYizMPR3Up
X-Proofpoint-ORIG-GUID: HN7uJA-cSbA08m5SSTpHd9uYizMPR3Up
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=517 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Jan 31, 2023 at 09:46:42PM +0800, Clay Chang wrote:
> > I'm trying to understand whether we can find some common ground with
> > controlling e.g. Aspeed's BMCs LPC peripherals based on Arnd's query[1],
> > but the description is a bit too vague right now for me to be able to do
> > that.
> > 
> > [1] https://lore.kernel.org/all/66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com/
> > 
> > Andrew

I briefly studied driver/soc/aspeed/aspeed-lpc-ctrl.c, and IMO the
similarity between HPE GXP driver and Aspeed's could be that we both
expose the LPC memory addresses or registers for configuration purposes.
However, the functions to be configured could vary. There are a few sets
of registers that HPE wants to expose for configuration in the future.

So, do you think there could be some common grounds for genralization?
Please let me know if you need more information.

Thanks,
Clay
