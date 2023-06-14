Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E900772FA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjFNKRT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFNKRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:17:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E05E57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:17:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-108-hCXQcDGBNYyzCsxMMZVW0g-1; Wed, 14 Jun 2023 11:17:13 +0100
X-MC-Unique: hCXQcDGBNYyzCsxMMZVW0g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 14 Jun
 2023 11:17:10 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 14 Jun 2023 11:17:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'GONG, Ruiqi'" <gongruiqi@huaweicloud.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gongruiqi1@huawei.com" <gongruiqi1@huawei.com>
Subject: RE: [PATCH] clk: renesas: r8a7778: remove checker warnings: x | !y
Thread-Topic: [PATCH] clk: renesas: r8a7778: remove checker warnings: x | !y
Thread-Index: AQHZnaHR7xBIFyeGDEu0eJYf3JlEQa+KFZ7w
Date:   Wed, 14 Jun 2023 10:17:10 +0000
Message-ID: <ec5ce50bc3e14f62bbf13c00a661e136@AcuMS.aculab.com>
References: <20230613025403.3338129-1-gongruiqi@huaweicloud.com>
In-Reply-To: <20230613025403.3338129-1-gongruiqi@huaweicloud.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: GONG, Ruiqi
> Sent: 13 June 2023 03:54
> 
> Eliminate the following Sparse reports when building with C=1:
> 
> drivers/clk/renesas/clk-r8a7778.c:85:52: warning: dubious: x | !y
> drivers/clk/renesas/clk-r8a7778.c:87:50: warning: dubious: x | !y
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
> ---
>  drivers/clk/renesas/clk-r8a7778.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
> index 797556259370..ad1a50f3b0cd 100644
> --- a/drivers/clk/renesas/clk-r8a7778.c
> +++ b/drivers/clk/renesas/clk-r8a7778.c
> @@ -81,11 +81,11 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
> 
>  	BUG_ON(!(mode & BIT(19)));
> 
> -	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
> -			 (!!(mode & BIT(12)) << 1) |
> -			 (!!(mode & BIT(11)));

Try just adding a << 0 on the last line.

Recent gcc and clang optimise the code to 'shift + and'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

