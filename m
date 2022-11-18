Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BA62FF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiKRVjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKRVjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:39:04 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60139.outbound.protection.outlook.com [40.107.6.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B365E9C6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7MNB0Fxr4ZMI/z44Z69qnGTx7xlM4TZnKQDhJ/VaxNfv6dlEM1qVRPQCPcRfHV6mlRoqnReRRAzqlT1My9X76783u3lDCNVceskV52Z74FrmIJMTKYXGHiLjLwBxBWcqsg8oqjPUnsxx6esmq+pxiFLbbIb3GFdNxVBx+5dedzJ7kR7wT7vwMsr/6+t7YWXxCPZg0HaVJTod+PAwTVOLMfgJzejtbZsmG0MXlKol2twEnLBqjEV/l99/u39GSCVWIyhEiKYy5joCibgvdYwgK1azMalStmSZTgfJH6Do3q2DJxgar1EKWAfl1/K5/k6Dq7KxcpYPcy9CJGp/f+A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixdr2hodg9kQm1ddCoB1k+vt8XTEH9FHMggoZ7fVdVM=;
 b=ZKkXmjow+1qDn2YwT2Z2rqUs8hjOHn0AoBDH7Zcarto6537Bn+vjZ25x+7XR3sK/kXy2w8TuFrmSay8sWU9x/uhjTNlVCLO7sLzQ3DWRf2bwY4BYYKEhyzqAK4DOyMsvAM2RQrP+ENTgbi1zWqr/guF0/4VWI+08+jG/VELRj/0T7lpQmRXsgbE6jcwBhiJguP6F8PEs7G9/wgTzcwGsON6lVNpjKXfGoJbqmRDdkd9/MHet86xM3TrVF33lDdmTLbjOf+KVQqmDrhPRRkU4W1eS/V+gMVj2yZE4YMqXDASqQonlnImAZhZLKAqc0e9vAyQMgPyfaqnUI/D+u+OqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixdr2hodg9kQm1ddCoB1k+vt8XTEH9FHMggoZ7fVdVM=;
 b=EYJXKlKtkBbI5xUqAeiou0nC3ujcIyl3Vw56N6L+CndpLmqraZ022Zv08KLGHhOHrUsJVlhxxIAQHBYeYm4D5bV2nEddw8RfvGBHPvS1dzK1cehD78S/B+WsbIxi/pWdOn6OLNUZb0mz0tkugzafnx0j7bd9e/91IC2sgMH6B5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB4PR02MB8581.eurprd02.prod.outlook.com (2603:10a6:10:387::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 21:38:59 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::a30:dce8:eaa4:7687%6]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 21:38:58 +0000
Message-ID: <08c5bdb1-c105-2f84-66f0-22f7f4fe968c@axentia.se>
Date:   Fri, 18 Nov 2022 22:38:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: at91: fix build for SAMA5D3 w/o L2 cache
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
References: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
In-Reply-To: <b7f8dacc-5e1f-0eb2-188e-3ad9a9f7613d@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::25) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB4PR02MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f340c3-8e41-426b-ab75-08dac9ad4d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sf0aBuBN4bpUbrWfbcRiG6P15ImgxJ9g8ZMQE4+4LLbYQsZacHW4tPI1KWZDnBQWr11Tu9JRmK3FJms0+xdT4D+XMUZ4tHq1tgf8OngFY/N8UWtn28BMO7ouIaEZSPFWlnABaek+Bj0P2xeXIcVf0H62rtCIxfiPXvJJbxB/9TA2h7IlfsFdZZGyoUAXkrMweHYx0RmFE/lAyjTC7ETj3njmLtpWdZYEBj9uH9HjjIMMZAaTnfFtsbkL7WlUgNKhX3UZWPgWgvUdzX2HmOvBSJTsc4GgDoFTVMPinpdCV9n/KQBwZKAgLCdCl5p3N1LxfDv2JLpL6YwAgkTZe96LNnX3/qhYEMtfv+NzYM9VRyUjNosODx+ATgej1mcB2Mjmt0ZLnuxvfgYi2vFkTac9dTbUwHczGKfrZEGMdw8sJU37ARYmyfIyoPZg671T/kaNrswCjcqgLQe1d/pXwmdPmjuewNRf/jL/jBOlx60XCoJzDXZLDByTCAFhFEiJwh6aW2XEwLl+IvhEPAt8HECEH6cER9XWZqbY3f9yTTz9yHwJ3UyybsjFRgae/vYXCC+2dQTeHn0oInlpNycSSUzvUIG9a8RjNihqxiJu1DesNuLFZMygHgves8GMvXNaMJ2g1mH4ZFCBZbtyc3zMCNTYvO0KOF+EmzU5DkRViNLAQNxfCPsEofRkSsQXCipPQBMdvgrJYEskqC5pSkzNntz/TG6YknqmmXzhkn0yDU/Dbms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(376002)(366004)(136003)(39840400004)(451199015)(31686004)(36756003)(38100700002)(41300700001)(2906002)(4001150100001)(83380400001)(86362001)(31696002)(66476007)(66946007)(6486002)(26005)(6916009)(186003)(54906003)(5660300002)(4326008)(6512007)(316002)(8676002)(8936002)(2616005)(6506007)(66556008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHVkZVVVdVdkbnVaRysxNkY4NUMxNTZoamtqWWRVcElSRmhxZk9BUEk5azV4?=
 =?utf-8?B?aTI3bEJFOHFMOVhUTlRsZ25uYVEvY0ROOGNaQW1JdlFYNHozUndVcWw4OGxV?=
 =?utf-8?B?cWRPUExpcmJMRzlMT0VoZkZRTTJteU9pNUowcWJZQTkyVmpSVVFEL0ZPejQw?=
 =?utf-8?B?bE1KTjdzTDd3U1liTVAvRkhvOURVcWdacUZtMWh1Z1hVdkJpTGpocUdBQVdU?=
 =?utf-8?B?c0o0MzJITHdZMDBDSjlSN1FuU3lUd3JNbW9TVWtPN1JVdEZqN2NVT3RvWlRD?=
 =?utf-8?B?Rm5HN2xCckFvbldOMFo1NlhYSS9lZFNhMWVBVXRjSkJaR2hFMlErSjJXQkx5?=
 =?utf-8?B?TnJPYks4bUNzNndseFBiUmFFK1BJZDRWZ3g3NFdES1MxMEpHeEQ1NjA0RktT?=
 =?utf-8?B?cUZYT2ZOemNtTmxpbUZXYmlUNjBZczdPV2I5TWNTVm5mMTROeG1sMi9qcEEz?=
 =?utf-8?B?QjhUUHIvKzFOR2NNNCttRGJrL1drbXFHRDM4eG4zOU9pNHdWYysrMThoQ2hO?=
 =?utf-8?B?U2FjbkxLdVJXM0FCTXZFOWNQd2FCaTJSQTZ4VzJLYjNSRGxwNWdNS1p4LzVr?=
 =?utf-8?B?SlpCSS94eHhXRS9HRE9oVjViQmJrZ1ZKcldyL0RiZTJSVmcwOVAxdDdZVDdL?=
 =?utf-8?B?Z3NVZjhBQTVzVlduU2REbGtLQkw5R01pUElUVTRWbVBqeU8vdHlGN0owY2lM?=
 =?utf-8?B?V0dMUVYyTDEzYUxYWWRobjVMVnBVd09vYnFPekFGTnl6S00vcHp3UVZZS1Vh?=
 =?utf-8?B?YWVNRHB2bEFydVVvcXkzdklFTzJ2M0VzMHBDYlpoNTVmbFZKeDdPRWcrZHdv?=
 =?utf-8?B?NFpPZW1IcUQyaGw0dlQzaFJiT3UwaWF2Z2hxVDBDU0NzWmV1d0pvZWMwSEpy?=
 =?utf-8?B?VzI5NDVUcUNERjJIVGxKN2o4b2t2UlVmejVFV3EwQ0VwMUxxUnJFSXJMUWhr?=
 =?utf-8?B?RXlrZ2RoNXBHUFlZT2RxeFVNd3NnYVRMMmpNSlpjZEx2UW93UE5VRGdxUURy?=
 =?utf-8?B?TVNLcEJNN3l2cmk0SGxSSDVVNHMyaEM4TkRsTzV6UVFYVGVKbjMyT1ZIclBJ?=
 =?utf-8?B?L2JrbEYvNzVVVFFySEI1WG9Fb05WVDVJVWFQdFZSMFFXT2dpSVlRR3QzejN6?=
 =?utf-8?B?Wkk0Rjd0OHlUcWhkZ0V1RUlHQ0QwalJ4M0JRN29pR1ZaUzViSlljQ1NMRnYv?=
 =?utf-8?B?cmNxSkEzbll0UlNzWnhYMDdiNDNtNmt6VUpURzJuYVlVeS9TK0VvOEt0bUl6?=
 =?utf-8?B?YmZMY0xVZFVhVXFuUnJSdWJVQUQ0aFUvcTRNVTVRNXlnYTQvdFdTZUluc0Js?=
 =?utf-8?B?WncxSW9RTzFVclQ0YlNxbWpZMXN2ckZOeE03bzJFMXlxTXp3VmZvbXZGRXNM?=
 =?utf-8?B?djgxQmd2Z2lmOHhZNFAwamVUVW9pSzlwcXA0VGNZR1E0NWl2YWJmamc3TWg4?=
 =?utf-8?B?L29TUU4ybUxIRXFaWXBJRFpUZEx0SzlXd1hWNUg3Tmc5M0F6Ry8ra3JwSkls?=
 =?utf-8?B?WXQ4aFMvTittc2dISGdtcVBDblRGVE1BU21UMXBVSURRanVSdkc4aUtKVTcw?=
 =?utf-8?B?T0ZCb3RsSGh4YUJSQXVWelY3UDZvT0ltdDBCY2RiS29zSUR3eUNaeXBRTTIv?=
 =?utf-8?B?Tko5eWpZdGwvdXZiaHRkU0ZCWVg5U3AzL3N3SmZZYXp5UCs1NVVjMzVpZ3lz?=
 =?utf-8?B?eUlaZzBnaHhiaVNaZGgvR3hwQldxbGlzbEdKVmNUY2Z3VmN2dEI5VllyVk0z?=
 =?utf-8?B?ekUwUkcrTmQvcXpkSDJrakJvMFcrc3R6aVNFS0xjNG9SWjU5MlQ0VWNNbklu?=
 =?utf-8?B?cS9jbHo5cFYzUXA3bVJiam95dXU4WFdjaFZQMERjbmVtTTdPbjVYZENlNkcv?=
 =?utf-8?B?QmJWam9nRUt4RWc2ZFpzcDBUUTc0S0E2NFFvTndRQTdQczJNdW8rSWlaYVVR?=
 =?utf-8?B?OVJxZXdETTEyTWpEU2dtVHF5My9qS0JUbXFib3FYbTV2czNRdDNTZENvRWg1?=
 =?utf-8?B?dzFXWWlHL0UzdE9RY1hkQjBXbmEwNjdMVy9PdStHcURIYVdYNk92NWtNKzUw?=
 =?utf-8?B?eWwvOHhzOFR6Rm1HcVE4cWhhZEpPbFVaT0haang1RS9EUllSbnlFUEZXV1RY?=
 =?utf-8?Q?YElcrfz3K91dSBDKgV4SsWkGv?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f340c3-8e41-426b-ab75-08dac9ad4d17
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 21:38:58.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQVp1LY9qf1J0ppwZXb+9CAgc07vCHnwEWZS5iNkjJdToHeJGQLQ9wQLzPINjnWU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8581
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

2022-11-12 at 16:40, Peter Rosin wrote:
> The L2 cache is present on the newer SAMA5D2 and SAMA5D4 families, but
> apparently not for the older SAMA5D3. At least not always.
> 
> Solves a build-time regression with the following symptom:
> 
> sama5.c:(.init.text+0x48): undefined reference to `outer_cache'
> 
> Fixes: 3b5a7ca7d252 ("ARM: at91: setup outer cache .write_sec() callback if needed")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/mach-at91/sama5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi!
> 
> I'm not sure this is the correct solution? Maybe SAMA5D3 should bring
> in CONFIG_OUTER_CACHE unconditionally instead? But that seems like a
> bigger change, and not just a tweak of the regressing commit...
> 
> Cheers,
> Peter
> 
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index 67ed68fbe3a5..bf2b5c6a18c6 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -26,7 +26,7 @@ static void sama5_l2c310_write_sec(unsigned long val, unsigned reg)
>  static void __init sama5_secure_cache_init(void)
>  {
>  	sam_secure_init();
> -	if (sam_linux_is_optee_available())
> +	if (IS_ENABLED(CONFIG_OUTER_CACHE) && sam_linux_is_optee_available())
>  		outer_cache.write_sec = sama5_l2c310_write_sec;
>  }
>  

It's been a week or so of silence, thus CC:ing the regression bot so
that this issue is not lost.

Cheers,
Peter

#regzbot ^introduced: 3b5a7ca7d252 
#regzbot title: Build-time failure for SAMA5D3
