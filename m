Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB9639849
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKZVob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZVo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:44:29 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2A1277F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuAXaalf8tx+WmNNUuo8XqLucRk+sS8LmU9FCeyE9yvYE0ImH84Kk4Ta12OAoDIREBeifYprBjqXk/QaG4jW3Pn87HX9qQ8ZNz4+TwZpimygSpaDR0kfX+TMG3gnMH6WPgmxkLQqTF5MoGj4GY6f2hbLn5xyNOp4lSpUzCwQQ8DOIjyUdwBUBkutTtaI5DIwrEAy73DvnzMGtQ3X7PkmIZh9hp3xqsJ4NClX0tRO38PmbkqCG1EZJ+lFOKRIkWnE1BFYbxpIjAa6gOm/Nwc4eZDQoafU8LTNn5ID/5uELuj+dqLl8Jhle99cKVJAYn5SKwj3CrSkyAzbc3Q3bXD0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCzN9LHmyrheuucjnDlRXxQczQYPr8NmmNvv5cxPsMo=;
 b=fQ0LDOi8uM/iH7RoBxRg9uYqki6NJ5oUyUxonyHgiGj4l9Nu/GRnBNYpU/CBia1xfGxD/DRSWYMIzoJmv3FQkYuWw1VdTclZhTJNnwBTdgYuKyO/yW098lj4UEfSWgimnHbiV2GxDqY3E6mMzI5Ob3msRyG0v9eE6RBZVcUfCyUpORcpoPKjPfJKEBgUGfmg9eIBJRAlYpkgDjsVgilQ/2KRr3Y8dRHVTVbDYa+YyOW7Wp95IFeS9UZE1BFwEwIeTDL9fIMEz9WEGTaxGzhvO5/QmqHeWbxYCuCwWCwRQ7ymNQ3Z8FZqnds8mG75bp4AO7mQ4eg+p80Sf1oRNjr0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCzN9LHmyrheuucjnDlRXxQczQYPr8NmmNvv5cxPsMo=;
 b=PMerigIjJWkLllM5DIIyyJYzCooVt949n1VGRvgQx5z38pPSnAbOY3sdi18pYv1dk7MKjsmx9j2NeM2E4EYCxte4pJsuA7gxjW2SqWIGYVJK3h96ey2XFavVzl64CMuKnUo/7GAcS6rmTDSZNeBNdJGkwhcYwxDaJmtT/9/IVfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DU2PR02MB7773.eurprd02.prod.outlook.com (2603:10a6:10:2e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Sat, 26 Nov
 2022 21:44:21 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687%6]) with mapi id 15.20.5834.019; Sat, 26 Nov 2022
 21:44:21 +0000
Message-ID: <f518b66b-6ce0-6828-8e67-a1f572b951b4@axentia.se>
Date:   Sat, 26 Nov 2022 22:44:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mux: mmio: drop obsolete dependency on COMPILE_TEST
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20221124133737.659429ce@endymion.delvare>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20221124133737.659429ce@endymion.delvare>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DU2PR02MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: ce36ebe8-b056-418b-9cf5-08dacff76090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dsa3klE+FWFHXvFnuCSyD2XpoOMXBIpjxrZkynXbaKhCW6XtWUki2t4iTgZSIYws8+v0ayu6W7mPJyqtF57s0GG0DlWmdRvTPTRNcyQ6qLpGXyMV4Iqjn1k8MI74ZnYRmJaEWXG8uPZ/RuGqBmOGD1qLUNf+6Yn7F1z0LrG1gCdfNXEtkjImQKb9W2IngQxBfDcoBI4TuBv9LdZLCBDjgtWM4IDAUn7sdp4oc5LmyAZadFu8ogjwUDwocIbdXpMBawhUUu9FOBH+ELZF2X4J+FQEq13xoXqXosQtmOjWhhrVDZUuqjb5eCs138I/C+GTgvxtFOWRx+PBmVmPOycy1sKWH5pEOYVmoIMr50Fs4E+BmdGasRzAB+6t/3SZa9XiwSW1Fuiyey3juCcX7jhp3oct4SrTOKlLy2Cg3VJrBJxnbzIyKtL0dtJuQBaCM2MAE9qfGtfy0j/lbzdMOlhLHyMfAkk8mkX0/fOvTl6u+TjteFniHkTweXklx+IJFN4r+XuQku8N5Gdefix1zpVQSGjSTdmlbl1aOIZ3Cauze6HvtTQ8zmfLsZCLREcT0UvjX5tMh5OkinG9J+TSKLRtaVTo4BA1rQHf2VDg3lLX9GsFAaiGnNrs7hYc50gBq/YoiH9QcGkshF1MF6MsmPVU/FhgXU4ymgtFVCNcruwx64EIRyRd0nqhvWR1CfKveDfu1BbCNMhJWh2OAzOY7XflRVYu8oWJvey31R4Tgd3EGx7WKzGiYce60sIAMQ477glq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39830400003)(366004)(396003)(136003)(346002)(451199015)(84970400001)(36756003)(186003)(66946007)(41300700001)(8936002)(4326008)(66476007)(6512007)(26005)(66556008)(8676002)(478600001)(2616005)(6486002)(6506007)(31686004)(86362001)(31696002)(83380400001)(4001150100001)(2906002)(6916009)(316002)(38100700002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStsMGpWMC9ZK0Jmb004Q0todHl1ZHJkN0ZNOTRGRk1tT1JyQWFvVHpUVVor?=
 =?utf-8?B?Y0hwMmduOTExbUlRcW16VTJrYmdVT0lJemQxWlBYUGpWR0J5eENRRnlLck02?=
 =?utf-8?B?Skt6QzJPb1hlaENmMUorNXl3M0JEWGdCdnZsTmlxNStKdVRMRzJEMFJGMzVJ?=
 =?utf-8?B?Y3BGVHdteDRWdUZLT3lyckRqdFhiUVllTG5rQytEVENBaExsYmxYdjZHZVBE?=
 =?utf-8?B?TDBEbkJvU1pxRFNDWmpYdzl6ZEdzYTFLNTA0a1dtVi9rTlpET0cyMnRBY1g3?=
 =?utf-8?B?REovNmo5WHRpbTlGRHRmR0p3dlhac2I0VndndFVrV2x2Y1MwaXZPclpMR2lx?=
 =?utf-8?B?c1VSVG0vbWgrVXA1WXBrNlN2cW9Yc01aZ0pXd0RML0JVU285enFIOEttMEps?=
 =?utf-8?B?Y0E3cERxa2ppcjZHNUFLYjVtZHAvT3VzaEtoRndJcGZjNEI5Mmc3YmlySytN?=
 =?utf-8?B?UnA3alpLdDJHQm8zUUdwV0t1VjlpR3hiQlRucnUrWC9VTVduenVMSVpVS3dL?=
 =?utf-8?B?ZXZQdjVmdSs2YmlsMUY2bVBCWUFtZFRNajNtMndHd0FHdEF1QnFCcXY1U0RE?=
 =?utf-8?B?V2NQYm14WGZ3c0VISHJReUp4cW9jck9aNHFvVUNEVEVQYWcyK1Q1WlorUjdJ?=
 =?utf-8?B?c3JtZ3RORjFxRThLRTRNWGhVK0srSmh4MDN0a0t6OHJmNjRlUWNSekJEK2Zs?=
 =?utf-8?B?VFJDdDk3eE9OV0FSZG41a3cra2IwQjlIa0c3MmxIL1J5aUhHaC9lODF4Y1lo?=
 =?utf-8?B?d0VHdmljNGljaTkvY2hJaWV6bXZoYitCTVdYdzd0RDVoaW9aZjBybTJYc1c4?=
 =?utf-8?B?MkNGUnFlUGR5Mi9DdHh2VitZMHBWMzhFb014ZW9HSGxRTzBRWHZ4d1RtZXBW?=
 =?utf-8?B?MXI2QllHclk5QkdlbUNmZWJHd1ZYK2ZzZWg1WXJXM1JXV2NmLytpWng3ZUNv?=
 =?utf-8?B?bEYrUnl2K1J5a2ZicjBQTXBsY3h0WTJEU09Id3hpMytHaURPWkFwWHhwclBH?=
 =?utf-8?B?OXJheURvQTZKcVpJeDhNKzArMEF5TzZaUU5md3kyYnY2VjhteXNJY0VQN2hh?=
 =?utf-8?B?Q3BtY0lEcWtNaFl3a09XQXlGV2N0UjFiUlRnc2JvTDdzakRxSTk5QTIycEJ2?=
 =?utf-8?B?VTdZelNFZTJTOCtBeDZwaHBNYnErUWExa3dyVlQvSDBzd1ZMQ01WUVM2cHRw?=
 =?utf-8?B?WnhvMmJpdEEvMCs4NEdzNGN2aFFGNWlPUzRYNkc4aDdPVDhJbURua2lWSy9U?=
 =?utf-8?B?YnVWakdMN3g1eEkwSEFVN1lHcnlJVWo1dzk3cWNnUnBMRVovVkZ0Q2R6Zlcz?=
 =?utf-8?B?VjJKbjZpZ3crQTh0TWRCa04zaUNkTVR1MFBHbUNkbHVLY0RNbDhBQWpNakU3?=
 =?utf-8?B?TS9wbnAzRTBRU2dNMjVNNEFqSDBuNE5Gc1hjL2xsNjFSa3E4VVhGeWE3UUEx?=
 =?utf-8?B?OEJVTE9TMS85NUgxUld3NUQ1NEZ2ZWltaGlxWWVWVzZlRWZ6eFMvYXRkL2gz?=
 =?utf-8?B?eXB0V1NpYjVnZkRLU3E5enJVN0lGZlVBVnJNWHBMWXlyenF2RktpaEdRa3pX?=
 =?utf-8?B?SkFkTUNyU2Y1MldzK0NFTzlmM0lFbVlvR2hWRHYwYm5kc1pGS1pXU0Y2ZmNY?=
 =?utf-8?B?clZ0VFFwRDlRS2VWL08rR0hXbUtPTUFCd3luTlZZZDhhZXBJVXBLdkVTOU4w?=
 =?utf-8?B?ck13OU9neFFIbXhVNzQybnBFOGRiaFVCYzNMc09xMTd4eTVoNHd5d2ZwY1Vo?=
 =?utf-8?B?empHTWlUVTJzWjNqQXoyTFZLcHZIZElBQWtsOElJOFBySzQ4ZktlTXdQZVJM?=
 =?utf-8?B?cGNpODZkS1ZjcFpHeUV6ZlZVcHRRRjFsT2w3dVpNZzhuRFlFYjZlZ0xOU1Bk?=
 =?utf-8?B?TzVDNWZQWGtQTDRrYkc0T3ZsaUFMcmd2M3hqME5kdTl2di9sNC9TcXRvb1Zv?=
 =?utf-8?B?Ti9odjhlamdWM0NPZ0dSWFdrOGZXOEc0NStGYzErd2hvRzVQcVpnVVNNbmxq?=
 =?utf-8?B?bUt1SW9RWktRM2JkUW50OXVZY1FNci9tMml3SDFNRk9qRFRyT2U5RmhjZXFR?=
 =?utf-8?B?Nk8rSU5xeTMxaEcxa2pQYUNQUkh5SWR3TDBUSFpRM3ZsY2t3ZWF5RWdwVlJC?=
 =?utf-8?Q?OiWQ1zqVMdZ/zOCzM82aKI5lW?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ce36ebe8-b056-418b-9cf5-08dacff76090
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 21:44:21.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XadQpdWaL1qPibppMNC9l4oMv7CqNghKlMaxhnshn3wxA8jWquJrB0u6LV0cteDa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB7773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2022-11-24 at 13:37, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> As a minor optimization, this also lets us drop of_match_ptr(), as we
> now know what it will resolve to, we might as well save cpp some work.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Peter Rosin <peda@axentia.se>

Yes, entirely reasonable. I have pushed this out to the mux for-next
branch. That said, it's probably a bit late for the upcoming merge
window...

Cheers,
Peter

> ---
>  drivers/mux/Kconfig |    2 +-
>  drivers/mux/mmio.c  |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-6.0.orig/drivers/mux/Kconfig
> +++ linux-6.0/drivers/mux/Kconfig
> @@ -47,7 +47,7 @@ config MUX_GPIO
>  
>  config MUX_MMIO
>  	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	help
>  	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
>  
> --- linux-6.0.orig/drivers/mux/mmio.c
> +++ linux-6.0/drivers/mux/mmio.c
> @@ -131,7 +131,7 @@ static int mux_mmio_probe(struct platfor
>  static struct platform_driver mux_mmio_driver = {
>  	.driver = {
>  		.name = "mmio-mux",
> -		.of_match_table	= of_match_ptr(mux_mmio_dt_ids),
> +		.of_match_table	= mux_mmio_dt_ids,
>  	},
>  	.probe = mux_mmio_probe,
>  };
> 
> 
