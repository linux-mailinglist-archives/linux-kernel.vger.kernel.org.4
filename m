Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3172B25D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjFKO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFKO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:56:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC1E73;
        Sun, 11 Jun 2023 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=VHU0yG0KLgt9xY3b0m4xhDK4rKy+IHw9tgVCdD4Sx3M=; b=aIcmsvIN74KslwL3J9xVs9MAjH
        9eMcXgSyocY4T0W1TzRlTides174S6JKaplLpy2Ugm5XlGAcEj4GpPSKIcGryZDrCYUkFRn7Q00/x
        yCbknDyDShIsoagOJQJAlvV02jHJdPpkXgaSs+7G6g0B68CNxLjb3ez8yvYRS2cjSBSFq+reHj49W
        5ertz3/GNdWsnOau5ZivUKAV4kPbFhZfYmWAtyXj9MX5g3lUTISXV0xicCpSA5QOAe5L8OfRNGZzf
        pgXvuddRw3GfwomZ/MBb0Rse9pGJ3W/GvZsFZhHfBvB5ef1H8zA0vC56rUngi+ndDBCSDD9GrYZGW
        eZiw0NSA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8MU9-001Aag-2D;
        Sun, 11 Jun 2023 14:56:05 +0000
Message-ID: <1c00f4aa-e696-a071-68a7-cdd62d8ba894@infradead.org>
Date:   Sun, 11 Jun 2023 07:56:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] crypto: fcrypt: Fix block comment
Content-Language: en-US
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     davem@davemloft.net, franziska.naepelt@gmail.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, bagasdotme@gmail.com
References: <20230606111042.96855-1-franziska.naepelt@gmail.com>
 <20230611105331.16570-1-franziska.naepelt@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230611105331.16570-1-franziska.naepelt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/11/23 03:53, Franziska Naepelt wrote:
> Fix the following checkpatch issue:
> - WARNING: Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
> v2:
>  - Revert SPDX change to address only one logical change
> ---
>  crypto/fcrypt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/fcrypt.c b/crypto/fcrypt.c
> index 95a16e88899b..e9e119bab784 100644
> --- a/crypto/fcrypt.c
> +++ b/crypto/fcrypt.c
> @@ -303,7 +303,8 @@ static int fcrypt_setkey(struct crypto_tfm *tfm, const u8 *key, unsigned int key
>  
>  #if BITS_PER_LONG == 64  /* the 64-bit version can also be used for 32-bit
>  			  * kernels - it seems to be faster but the code is
> -			  * larger */
> +			  * larger
> +			  */

The comment doesn't begin with a /* on a line by itself either.

checkpatch isn't always correct.
Maybe it isn't in this case.

I would either make it a correct multi-line comment or not make a change
at all here.

>  
>  	u64 k;	/* k holds all 56 non-parity bits */
>  
> 
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7

-- 
~Randy
