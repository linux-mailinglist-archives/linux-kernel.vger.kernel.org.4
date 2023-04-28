Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C836F12D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbjD1Hvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345870AbjD1HvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:51:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1a::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530015BB3;
        Fri, 28 Apr 2023 00:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBSt50l1yeCqmNIOJNl2PBGiXD+0qL6oPhFAjQaDnu9gh8IIBg562o9HZpkrU6+TdadeBFF3cSMoCjRxDf6sTuTa8PA2nalF670JchH6ID2hmNrdSC6fiiI8TYIBpqsa6QRUpBoX/Yv+CRC3C4GmQO5zq9ASqcL5znKha/7wGqB6lmBmUxJ+/g9vtoPTEN+gN3G4McDFH4T/FDWNDyQMIcboutVAjktuDJQtTSRTlnB7z14umh736O0PK66Py3ued/tBjEWlZbXOGfXGz7vlGtNgJAJBhKErR7o7+ATQw4sG4EShDWfmg89GUZis+/2rqGt4+YE51fdV1iQp+xdzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N651Dt/syDkFe8XQx7TtJ1WWMqZ50PpLzTfzJNUV6Uc=;
 b=Hov3GmvOMebEwvp6/l7yaUZRFvQklcVJMJXD/dmWEwNHOtXMAwqYRfwPPoPbJavtjGio8cQR5EYOwRqctrmNHaboF8YHWVYg1KL9wipWKRnnF5lLl4z+Jhz00OXNaTXevtFskga2ZtHZ3GmT+HRklQzbjx9Bkom5xvusFN7hH7MeIt8Rr5tTdB17kZyg8t6LHX4ejx7WErI5fmdSETvS18GRN9ZrtGFY7bKlP7NN8PybxPn/LfZvAq46UKL16GdHkfDqxA/6Vz7bmXpUQQu5GogFlZSofBdvWEXcKXOhZQGkhk+BvDvdYXssS8+UTUWyFQ/245HT41J5e/O/rIwSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N651Dt/syDkFe8XQx7TtJ1WWMqZ50PpLzTfzJNUV6Uc=;
 b=R4N8dlfsaaBRK0lEBY7idpTPZHg5ixTAy1sb90b5rLVEKkutw0WEfE1m4S/7HPxMpZUcPJGG+QM7oVbaSk9wXRENmDUVCfcCs3tTHziG/8iAaOWOIM1DumAKc/64ifQNQ1wQFd7eg/u+LdaC4+ATkIBrNZtvtjjr7QWpxNIqFuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9778.eurprd04.prod.outlook.com (2603:10a6:150:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 07:49:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 07:49:34 +0000
Message-ID: <1667a487-5cca-a9b2-47b3-9e6d06fc3548@oss.nxp.com>
Date:   Fri, 28 Apr 2023 15:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx93: fix memory leak and missing unwind goto in
 imx93_clocks_probe
To:     Zhanhao Hu <zero12113@hust.edu.cn>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230426142552.217435-1-zero12113@hust.edu.cn>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230426142552.217435-1-zero12113@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: a9946c86-6577-4a0c-e7b6-08db47bd1bbe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqjDqqKb7L1l1n79lVIiVSboXo5U135RSU3GcatW1Ax2MDx1EdZWsEt51n0IML9sCzfRbWHfWmlsO5W68G8JEN6/90XhlTeC2y5+GdFvdVuUbKItpwEKv40hBg0dNaaa9RnOy/jb1T5OYY2scf6vvG6WdXwrNeNrAXr3QoKt7Oa94U7JpxyN6gNK4tE2E7+7q9l0jB5qwVF9IDO6AV5ZqHAZyRzpjnie3atHcH7vxV444HdU1zNV9Dl4QvXl8MyhJjJwrMvsgeM2MN9MXs6uMVWD3i75sI9BaXLOoF1/Kuo8VQCbFAm3RIJJxMZYxAz5r8xUq7+/SFyhz+EOMP5RnMHcEEbmGDf1xxW8Qz56A4tULEkr6OOUrgThaPy5/azEgK+XL/5b7TYNM4rq1TYXewav+WD4mmj/n9Yi2jsVDnR96c3beCctH5ltE0mhsa3hfu6D/xWpI/JUalX/QMPblNImW3rRPKdmSPgX4J4Jodl+Kw/eINlaAY6fAHih+FSV3c2zxZbucW5oHkhb/Vd0yHNHakDxSH2zH1yixM8D97fs5sGyJd37TS/YqvPd3dWKV83aXdMp5UUnyJiU4H0tm2eLI29BTGwFzOrTwU+WsOLV+IpoWx8qls1+AF6pDELgZ45/XGKggBKElOAnCcBa32AhbI/RtXvzwrHi5xT2jdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(110136005)(86362001)(186003)(478600001)(6666004)(6506007)(26005)(6512007)(53546011)(6486002)(8676002)(8936002)(38100700002)(41300700001)(2616005)(921005)(2906002)(7416002)(4744005)(83380400001)(31686004)(5660300002)(44832011)(4326008)(31696002)(316002)(66556008)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0ZyNERMMWpkY3ozanRDMDZQNlNMbzQybWt6M3BkUmIyS1ZsSVZTMGRGcTVa?=
 =?utf-8?B?OVNCbWtiVUo3YU9rUkFBdnI1SGlJWitEU1RpODhBbzBYQklhOHVwcThYeHM2?=
 =?utf-8?B?ck1MYzlpa2RYTnJaOEluZTg3UkwwY1hNeWMzV0RaMnlRS0xSTDBsaGtLMEVD?=
 =?utf-8?B?Q1ZDckREREtoK2VsUGpFZ1BwMDl6L1FpL3NWaDVKUmlvRzNPRlkrMk1qcEhD?=
 =?utf-8?B?OVBsYzNlZ3NoN0dXT3EvT2RGbFRTY25KNEY3UkxJdHd2VzFNd0p4RlRqYktn?=
 =?utf-8?B?RGV6V3NwYVdmZTBBNmJZMHkvRlVub0xXU3JQZnBia0psRytHeXF3Q01WZ0NW?=
 =?utf-8?B?TENEY2xBK1NBdGtZRWNLdk01Um5ob3V2K3Zrbzh3M1RReEFUYURBWFBubUVO?=
 =?utf-8?B?c1lBY1ZPVVFvVXE4ZFJHN3hOcnVZNHdiMTZXNDlvMnFHSDk4NzEyNnpIUVJO?=
 =?utf-8?B?YnJvUlptTUt1d29waDkxK2lwVXlzdUVGZ1RUVmRhVWNWVEtyOGlsU2VFUVhQ?=
 =?utf-8?B?cVNOcDNJVHJKOUVSbXBvVFhCeDk2ZkdseGtGaHhFeEJFQnd4bWpQbU5LZnpm?=
 =?utf-8?B?aTQ5aWV6bEpxZHBPUHphRndlMkoxU3N4VGVZdW9KZmFmOWVSbkViVXZOaFJS?=
 =?utf-8?B?amozUkxPMTFGZzF0UjI2MU9jeURMMkt6VWpsVGZPckdDK0xsRVlwSGVUaTh5?=
 =?utf-8?B?ano2dmdxTjFSSlcySkYvWDYzRkE2OGhuMVpLUkR6ZGtOa25raGNPWkhoSitE?=
 =?utf-8?B?c1F0bHVvN3o0M2hpL2hycE40ZkxiKzhFT05XNkE3V0EvWjZHK1hQK1FLdjJF?=
 =?utf-8?B?Mk5heFpodmlhU1EybExISC95UkYzajB5MUhPYmZLSTU5SVdWMVIreEEyT3c1?=
 =?utf-8?B?dlpMVFJSUVlaVExHNWtKUFIyc3ozZXJBM0N3WVRYRWhSNVAxYlNaVWZQaFJ2?=
 =?utf-8?B?aHZDQWVYclQzelVvenpVT1VaeUNzcHRpbVVZVHArUE5rbUZjUndZSWpWM1hJ?=
 =?utf-8?B?Qlh3MUI3NW9kM3Vka1B1QlhYZjZlTGNJeTI4WnRCZ3psaHVMZHhYM0ZDN0pq?=
 =?utf-8?B?WmZLZkNrNnNYNElYUUtMc1RFNUxCVS9uTW9iTnVPbFVMQmRPNnZKUTRZaUZO?=
 =?utf-8?B?L2NKSmlYSnR4ekpHVjFOSUNmWFNmUFM1TzUrbXZjZXFScHg0eFQzeEsvTmFU?=
 =?utf-8?B?TXNreVp2NHBZWkN1NGtzQU1SUjJBcG8xR3VETFRDeENOY0ZQZnR5Y2svZkF3?=
 =?utf-8?B?aGY2V3hqcHhseWVWUFNWR2dOMTAyUzR3eU1KWXR1WUxXdTZOa29RQlA4VWEx?=
 =?utf-8?B?SWp1cHRONGNVU3dabUVmU2FJV1FabjJUZmQycVMxR0ZLQXVkM3ZtZ090Z2ZX?=
 =?utf-8?B?MkN0cmo3b0dReVNqOEVjQVVoNkhMZ3ErM2cxbVZ6K1RTMklFN3l2cUFldGh5?=
 =?utf-8?B?RDFhUXE5M1ljNFQzbEdvSmJXZHRaMjgrYlExSEh3Z1hWVlI5Z1VlQktrTmN6?=
 =?utf-8?B?THpTYUE3cEZNZ0tDN3pTSkhmc25NR1B0bXhzVWxocldkeUhRU2MwUTlQMTB1?=
 =?utf-8?B?bU15YzcxVlROL21uKzkwWFg0VTNyd0FMZjMzQnZURlVIM0E4ZEIwd3gzdFk3?=
 =?utf-8?B?bHdpbys5RURCa3hEV3djRGZSbHZsck9teURJb2hHMWpyUDVEblo5NWY2RXI1?=
 =?utf-8?B?NUZFOXFTSjFWQkIreWM5bkcxcC93SDJlOXBOUXZLVTJhWk5tV3BNRDlGOEhO?=
 =?utf-8?B?dE12Tk9qZFVpVTZ6YUFwV0ZKNXhIVGFIUUtURnNXR1EwOW5ZZmpFQXFXWFFn?=
 =?utf-8?B?MHFTYWVPUGdMbDZEdjJESnRyOGVPSENaQlRucjFIVjJKcWcyREtZaEhDUk5t?=
 =?utf-8?B?YzRkdkhQd0dRSnBZRWFWUkNkOWtpZTFseG1Kdk1rbEo5L2h5Vm0xSGJKakoy?=
 =?utf-8?B?ZENHVXRtdnkyUHBuU1M0YW1YcEsra3pnU1BibmIyZVdLZExVM1htamc2TkVs?=
 =?utf-8?B?OFR3c2FOUkIxYkdUVXNQZFAxQ0VXdXJ5N3FDb2VIL1I2TFk4dS9RM2pVTGw5?=
 =?utf-8?B?ZGR0c2lKVDZKT1Vwby9CT1ZBR3RTUytFRnZob0lLS0VoSG8zcTNXMlU4Q0NU?=
 =?utf-8?Q?p16kjqHrLAZZa443tqnJC6ANG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9946c86-6577-4a0c-e7b6-08db47bd1bbe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:49:34.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpfQBJJzlZT4K3TR9ondkW+r0mj8nv/zSfqis/lxX/2NDyJKWS3YJtnjp8EP9FdcilBwYd7026ZeWHb13oNjcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9778
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2023 10:25 PM, Zhanhao Hu wrote:
> In function probe(), it returns directly without unregistered hws
> when error occurs.
> 
> I fix this by adding 'goto unregister_hws;' on line 295 and
> line 310.
> 
> Besides, I use devm_kzalloc() instead of kzalloc() to automatically
> free the memory using devm_kfree() when error occurs.
> 
> Similarly, I replace of_iomap() with devm_of_iomap() to automatically
> handle the unused ioremap region. So I delete 'iounmap(anatop_base);'
> in unregister_hws.
> 
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Signed-off-by: Zhanhao Hu<zero12113@hust.edu.cn>
> Reviewed-by: Dongliang Mu<dzm91@hust.edu.cn>

Actually the clk driver should never fail, otherwise the system will not 
boot. But anyway it is fine to include the changes:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
