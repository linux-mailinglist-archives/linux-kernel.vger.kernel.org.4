Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7962E22B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiKQQlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKQQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:41:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120571024
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=TWDvTz5NdHIOzdWIKC2xnvewhpxjA4YVlkVdo/wop7s=; b=3UIy1kY9d01Vl+tqWoXEdBrNsF
        WbwrwQmjOFXerTEmwBBOxos9xukf4Vf0C7msfli7mxiDFZ0B/p/WX/J+D4kYqrf4V2lTERIvjTDYj
        DAgAKPJIb0+ZHaheVTm3p/t+Uaw0093fBmZ6lUpmMtsDC8HEIePUZNax3csKa8KVkWRErh7K/csIQ
        H0QZHr581wIM91cCKmlIfEEaXa0typn03Zv5oHS74vo6B2GFVy+K6BYV/bZeu7PEXcxRnkx1w21n6
        O9e/ExAecd5f4jIyc8vwOvKtv1KSpaMF5InCxn34gyCFeFZ4qDNSsWHlO24I2/Va2avbDMecw5Dza
        8PvneH0Q==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovhxS-00G45T-II; Thu, 17 Nov 2022 16:41:46 +0000
Message-ID: <2b3bc31e-c308-b04c-1759-26bcf8dba6d3@infradead.org>
Date:   Thu, 17 Nov 2022 08:41:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] random: add helpers for random numbers with given
 floor or range
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, tytso@mit.edu, kees@kernel.org,
        linux@armlinux.org.uk, ydroneaud@opteya.com,
        gregkh@linuxfoundation.org
References: <20221117163511.2186302-1-Jason@zx2c4.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221117163511.2186302-1-Jason@zx2c4.com>
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



On 11/17/22 08:35, Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 6f323344d0b9..140dbd557dbc 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -161,6 +161,8 @@ EXPORT_SYMBOL(wait_for_random_bytes);
>   *	u16 get_random_u16()
>   *	u32 get_random_u32()
>   *	u32 get_random_u32_below(u32 ceil)
> + *	u32 get_random_u32_above(u32 floor)
> + *	u32 get_random_u32_inclusive(u32 ceil, u32 floor)

                                         floor,    ceil)

>   *	u64 get_random_u64()
>   *	unsigned long get_random_long()

-- 
~Randy
