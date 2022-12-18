Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BAB64FDDE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLRGFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 01:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiLRGFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 01:05:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98738DE82;
        Sat, 17 Dec 2022 22:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=ypL0A9clU3cCGTC02491AvrbAvJzaOhFy23STR3upl4=; b=E6VuttQ4BpdP0kmBn2mX+4wcfA
        77321IEynaw4yJJdocjjXRHeOpeSGlCCJ/yRofFJ+winhZh5QZqmB9Niel1NxRDlL5nfFG85JUfQf
        5YHxzDd0QS6kDaKXbZQZsdewi/LOylndnQC4FiDeuKRj876Vrp1EVHk/at1r/tO8KgNNgIPNTmijA
        1I4dBWLkZ3xHaHE4zVvCaSqVnN28c21wEPJdD9ObBEI2Rb7djJTRusO1FazUBR8eom5A1YKRZKHLR
        hKdWc09xbiWZiXfXD5CtSRIFExoE/LOHItBDc5SsVxqbLf8dgM/Nzam8l/3+/o5p8wrkHNLf64mwL
        yeg8q+qg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6mnT-00GJZJ-QU; Sun, 18 Dec 2022 06:05:15 +0000
Message-ID: <946a9764-13c2-8393-6d61-d9b32d70f48f@infradead.org>
Date:   Sat, 17 Dec 2022 22:05:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V3] scripts: kconfig: Added static text for search
 information in help menu
Content-Language: en-US
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221217055148.28914-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221217055148.28914-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/22 21:51, Bhaskar Chowdhury wrote:
> Reconstructed the sentence for the better readability.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>   Changes from V2: Inducted Randy's suggestion to make it more readable.
>  scripts/kconfig/mconf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 9d3cf510562f..760ebf6c20b1 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -161,6 +161,12 @@ static const char mconf_readme[] =
>  "(especially with a larger number of unrolled categories) than the\n"
>  "default mode.\n"
>  "\n"
> +
> +"Search\n"
> +"-------\n"
> +"Pressing the forward-slash (/) anywhere brings up a search dialog box.\n"
> +"\n"
> +
>  "Different color themes available\n"
>  "--------------------------------\n"
>  "It is possible to select different color themes using the variable\n"
> --
> 2.38.1
> 

-- 
~Randy
