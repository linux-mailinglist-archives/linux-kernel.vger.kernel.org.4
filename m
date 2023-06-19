Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF4734E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjFSIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFSItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:49:51 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2108.outbound.protection.outlook.com [40.107.21.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F710FE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMlhWOObzoA6KFgxCh7L/IFGGYaqCdtUR62Im6tRdd1tMbTTAHUkN3uMUc5U3hcg0wb3vUPe/hy5G876OXZGWB8u+gnM/luDzn3c/+0CgfNtUzkGQJggltl1Obz6HI87EFoxpRrUa2WT/1DnOgW6EkqaqfDz7+XaOnT0fyM5qWid3m78SSfcMXGCgLLT/DMbjTAdUZCruzOcfSq+eR28tM+CP6bR/dl8ycTblkNv3HgoiNEdQ8pbIfvje/0i3F1YKpvoiR2a1IZQ+ypS8xX/0Rz1kg7WyDPjxr0qUTkd3HbM/hBqKiUfDmNc4/SxtSnQUns9vxg2x0mJohP0yeEIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M82xTr5XhOYzzmfoCLkn8sUSJQ3CzwtpJP0kH9BMGyw=;
 b=X+konvqIonMzfKG7D05JJqh3V/2K/c6CiYvsT7gnPEm7ZTxf2XDGztK72CocbYYyTVuPnXUfCCOPmcwjmJ396PfH5iutf5abFWN5wPtaPKfBW1D55WY5rydXoevvaJRHZ81bwvzejRpwepWuUMF2u10/VP6ZhS5cT1ytKQG7jXsnMO7r4uYBWTusnTpeyZPWOjhfLOZdKn1NaGGW2jNFvLUBs7JddIzjJIoEMwRlJUacKNWWmnbb6hfSzF+2q1PH3ll9u3AkeZpWnK9I7M5V7U/kO5JwuaNqWkCUQ/cp1yV+XS5omOy85BjCcDsvFLXAQIapd6VkY5w+dpnMIPmTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M82xTr5XhOYzzmfoCLkn8sUSJQ3CzwtpJP0kH9BMGyw=;
 b=jk5E142tXLzL2y221H970SwVHL+oasG2TJpJMoqxPFgJ8kiGSf94XWNe7FeVnm8tMDTunzbgek8VLQNtYum/m1FWZ8nVdFgTB+Win1XHkNPA/K6/FIeYS+x8z6S2EgujuGFVwDDQMHOBrdRGNAA/pFRjFj3OWKrHOwiJ3hTboqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB6008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 08:48:19 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1b98:7428:fb6b:3b65]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1b98:7428:fb6b:3b65%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 08:48:18 +0000
Message-ID: <c2b8437f-eab3-a8df-04d6-87b5f205b8de@kontron.de>
Date:   Mon, 19 Jun 2023 10:48:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK
Content-Language: en-US, de-DE
To:     Teresa Remmet <t.remmet@phytec.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20230614125240.3946519-1-t.remmet@phytec.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230614125240.3946519-1-t.remmet@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f36cb5-b770-44fe-61a9-08db70a1ede7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLMadI7SPQ57zOtVmF8hMywrU1baf5QcJAt5AHkxOBzuatfHGevlQbSZmVNx3CEp4nBUr7//X0M53MT93Gd2WaMTtxlkEoFz5g9OJ1kblvSuoh2ZU2hWsG6hEk9uzq6nyNTWBtlZZZX6/SGe4Y+6qnfOSWV5JCQudV/mZnC3qCe3ZDBIq3Hvi7cUwptPNeoGl24HwEfT28VHhoTkOmXNx45lk4mIKyuexw7VFsi8tOXXghTyiZUgfxTwlrrmx419cgAvDe0jlFZDPEZGMMSpcmxTu5P1TBxLlrQEEi6/kQ4ecmVFvAH5DtR3oiNJPDHCpv9ee0WaB1mzW8lHlx7Hww8KI7pH+CkMEnJKSn3n1yldWzVzb6uVVdowY2rMBDLJx6HExElGzrcG6nJb3PvgUL5akw2es3OUq5RVTgHlOkEZFPcjzasXXKrQGKj2OCPPs1Rpm4PKcN69l5oIgOPj05MsPWAZXkz7zgaZSVpFHhrq3K4rJssSLY+5jOS0y3gG7tCE9/YgW0zzpZcSgCq+8uhssqMQlgcMfesht12FGKhmjyqa5gpJ8DYo+DrRwNmebU9J8fCyZBtMsCcAjHtI6ZtXwYuUzE+mF0N+NOdsE+qvCH3rH0YJKdZrP+lAJ4LwOBNfaAzf8Gf/K06MRjuicOMwMvTAu7Z057MwjfV9cIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(478600001)(4326008)(110136005)(26005)(6512007)(186003)(36756003)(6506007)(53546011)(6486002)(4744005)(2906002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(316002)(5660300002)(44832011)(31696002)(86362001)(38100700002)(31686004)(2616005)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE9CVW9FSSsrQVhnQXpocXBFdjlnUjl3NkhLdW8zMTdVWVBNYnplL1huTEhv?=
 =?utf-8?B?QkgxbmlVNXoxYjRINlBvUURuTzZPNXh3RDRYbHYydUFtYndHUUFOUmd6K2k5?=
 =?utf-8?B?bHVUQjQ2bUdrVElVOHRuS2x4VldDSmxwSno2MTZkZnIyQmpDWlhLejJuWTJo?=
 =?utf-8?B?NGJPWWYvdy83d0NLaDcrT2xLdExTZFQrMStPSURtamlhOFMvS0J2Z0srVVFj?=
 =?utf-8?B?R2pCQ0xzZ0ptVnM5Ym1oRmRpeEx6RTV3T1lqdWwweTR1dytPUUlZaUs5enBE?=
 =?utf-8?B?MldGb2ppR0JScjUzak8ySk1LSGxoWDNTbEJ4VHpwQWM4Y2lYcHdIdnhxekk5?=
 =?utf-8?B?UG13VmNPRDRYZitCdlh6Y1FjVjBYMTBmelB5RFg5SnVEZGNXSm13TXdsTmc2?=
 =?utf-8?B?SGVreDJuOFExeU9hcm5BTUdaNTkvZVBWNXRlY1pSVmQ3RUx5bno3ZFNvdzNa?=
 =?utf-8?B?NUhUNm5SRzRZUnNWQ2pOUzVNNVZ1K2x1QVdwdVhXaVF5ZytnZ0xJRjFRTDlT?=
 =?utf-8?B?Y1ZwbGpzRXNJTVpEVVJlN1JWOWU4UzdMR0IvSzNuTklQWGpYdU54YjNuWTZs?=
 =?utf-8?B?UUo3MUxINlRHdGRZZW1GOHpEc1ZnUkt5U25mamRKQXBrYldVcU9YV3orM0RZ?=
 =?utf-8?B?WTAwNFFGVzVqOTcyV0djY2RHQTF3Ty9xRE00bmxpZ0lyTlNONUtHamovZ1BT?=
 =?utf-8?B?ZzRTSFRYWnhsRDFuU2lxd1EzejdtcCtlL3M4MUNLUytiSFRDT09jOEJ3OXBu?=
 =?utf-8?B?UEFDYyt5MEVaTTQ4Ym0vWC9ldmptakZFRDZvSXI2a04rblROZjdoTWRDNXM1?=
 =?utf-8?B?dGNEdlI4emUyc2NYZlpZbitDb2VPR3Mvc3lWN2RHQXE4Ym1Nb0UwUHYrL0Mx?=
 =?utf-8?B?MWd6a0w5UHVNRXRBUmxoZ1kyNnVMZG8zUDFjWmVDWVVuWDdVZlU3TXZDazBS?=
 =?utf-8?B?TDZzbHcydEE2bkdncUEyRGp6VytMdm9aLzU4THBrTVpyK2Eydnp5bTFnWDls?=
 =?utf-8?B?M0lQbVNRNHQreWdDZXhMa0RMQ21TTElsRlcrMURFTDRCVWwzZE83OUVpUVRi?=
 =?utf-8?B?a0lTYjdCV0tTQVovL3h4cXlqOXJoaG9lOW9HWkhlWVFWeFZoYk9JaVFiYWdQ?=
 =?utf-8?B?Smc1VDRQNjVkVEs4emdBZms4OTU2R3luZTZ1OUZhWjY3ck5pRlhiMTJGNlk5?=
 =?utf-8?B?dGlhMXRzSFNRS1FUREtibk13aGFEUTZnOVo2SzFVUkNMczlKc3dmdlJXeWFR?=
 =?utf-8?B?OHZ3UklodENKUXVOZFgyVkg3cVR2M2lZbURxWDhIL1pXUjZqTmc4NTRpWENQ?=
 =?utf-8?B?SmVlb29VMkUzVmorZHU4cFVTTGpHQ1FrejlkVnFaelplRTNsaEJ6MENoSzd6?=
 =?utf-8?B?bk0rSFVVZDZyaVR2Q2ZHZkdEZHkyVzR2R1JHVG5zVWdORHFoeFVUeklDVzZp?=
 =?utf-8?B?Y0VZZ2ZVYm0wbDF3WHE2NTVQRjZ4R01oVWEwaXRjYzJBOXFINmF4YUtlZk0r?=
 =?utf-8?B?eFNrWUhtYjhtTkZCTjdMUUVaKzJRMzJNNUpTdlFQaitsSTBYNGxDOW9OVEN0?=
 =?utf-8?B?VllhdWZrbGNyL3lRM0U3SytzZ1FGb0VyUno1eC9rMTgxSXdjcXIxc1RDa1N5?=
 =?utf-8?B?dkhlZmYvMlpXOWRuSTlNcGp5UHJYMW9IRWR3b3M4QTI3Zm9hTkcxR3dZV01s?=
 =?utf-8?B?WFVFTTNMZEFoK1pkcmJMOG1CZnFGQy83clZPaDk3UzBSczN4K1JPOXI5dWQx?=
 =?utf-8?B?OGVDeG9MSXZFMWI4bXp5MjFQcWdVc2s4azE1Zmo5RHNWRTg1R204RjVVc0w2?=
 =?utf-8?B?eTNjMDh6VDVMUVN0TS81UFV3ZForRGo3M0FTUE5jOWdPNndPS1VNZml2TEtH?=
 =?utf-8?B?dzhqTGFOODZpTlBOQ2RHTnlZdUQ3U0dFN2k3OFVNcmU0dmp0ZjFjWTNWaVVY?=
 =?utf-8?B?VVd0cytyWkFCQTRhaFcwTDdhaVQ1dVJOOTZXMVFiOHNlWm44TDY1Qm8zM3Fv?=
 =?utf-8?B?Q0c4SEVYdm1LSUd6MW96eURvWitjencyc1RZOEhxeGYrZWlBa2d0YnQ3djNF?=
 =?utf-8?B?aXhZR1BwUTBabkFtQ2xaT0UybTR5ZWdOczRVcTVwTzdPbGdLcE4zV01WNHRJ?=
 =?utf-8?B?cUtMMDQ4d3dIMm96Ry9VVG04V1RjUkJmMTdhOGZhMlhWK0p3V2o0VStOdzMx?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f36cb5-b770-44fe-61a9-08db70a1ede7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 08:48:18.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kX4nyp5xXr9Zua1nGQ/FMkdTL8OqGMsEzFafw4PEHGu1wxwF1M+MCSZYn3kYXm3nxl1blY8q/nTk5DBpnQaKzrnbEZlMfc4Bx2OeLq0PryA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 14:52, Teresa Remmet wrote:
> L3_OUT and L4_OUT Bit fields range from Bit 0:4 and thus the
> mask should be 0x1F instead of 0x0F.
> 
> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
