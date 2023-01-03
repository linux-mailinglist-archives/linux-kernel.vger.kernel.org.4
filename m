Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CB65C5AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbjACSFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbjACSEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:04:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0A13D55
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=oyK9I3qV18tKgg8rutCGUfqb8ivJms+jT9byIfFYM34=; b=AGIIwL4TMTZqyvzri8m/ORf+Y0
        +ljcFvAK2J/sGMMnQskbMqCIupQEp4qSZH4hEXunjWohOcuQcqfKZHHG6rB6kzymMHTT4M3f9KhiB
        L1TMOr/MV+Peb5u1CSX0vxmhsNjzyMO37irr+UKQkTOKY6yT2g18y4kZNEu1N/8fQz/IxdbHSUYOi
        IethhGx9P2jR+uCSCAUvvISkB5bRKDuGCHTV4AIZHq7JG7vDCSSXHxnFKrKPd/27fC7hNzIhuoSIG
        iYt/PBf7HQRsAVK/WSOE8aOPMKcD9DflH/DZ0i7/+G0evKg5cuEr8o0iYsRnCTxsqnbPoEIT/vlZe
        +QZHAWyg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCleV-003hZ3-T9; Tue, 03 Jan 2023 18:04:45 +0000
Message-ID: <7247ac21-f06d-74bc-e9ad-34930ec6d0a4@infradead.org>
Date:   Tue, 3 Jan 2023 10:04:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scripts/spelling: add a few more typos
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     colin.i.king@gmail.com, dfustini@baylibre.com,
        linux-kernel@vger.kernel.org, joe@perches.com
References: <20230103175901.128262-1-sj@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230103175901.128262-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/3/23 09:59, SeongJae Park wrote:
> Add a few more typos that found from real patches[1,2] to 'spelling'
> file.
> 
> [1] https://lore.kernel.org/linux-mm/4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com/
> [2] https://lore.kernel.org/damon/20221228174621.34868-1-sj@kernel.org/
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  scripts/spelling.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index ded8bcfc0247..64bddbf7425b 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -411,6 +411,7 @@ contruction||construction
>  contry||country
>  conuntry||country
>  convertion||conversion
> +covert||convert

"covert" is a real, valid word. Is it always incorrect when used in kernel
source or documentation?

thanks.

-- 
~Randy
