Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2D6EC366
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 03:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDXBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 21:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 21:25:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE010FD;
        Sun, 23 Apr 2023 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3SQZYajG7K9DFLQFO6V7CGWNKCYxAKPpVQjSrUf9Lk8=; b=k4L6YHb6xXnj7ELFNgJ7bn9Scp
        WZM1vIf6N9MkFOV8AVxPfYYAq3tmnjUDYjXDQ4KLCEpeVcUpmcLlAQjCYQ0cvHGkmTKFnzQc7hmgx
        HMB/1KugKJz/JPi5P6E2GGYdjJw3l+Ai4v+p8FAOFBs0OBx1xnQo9ju1RRgBi7XYpWiyn44NIr2w+
        jR4SzpBVFYfVU+R+hvsalGwNL63dQ1iF4mcAEQveAChgH2hG68DqBJO3lvzEuErmGamsb2BizoPmv
        w3EhaQ+dN3t3ZTN2u4byjZY+NTnm4DySXWU9y4LXQWRFvXoRkm+yYME92lG1GpKcAZrVj9OD5NmtO
        p8cEdD5A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqkxR-00F2YX-2a;
        Mon, 24 Apr 2023 01:25:33 +0000
Message-ID: <3f8ba0cc-5665-916d-b211-b2d5d6e952f4@infradead.org>
Date:   Sun, 23 Apr 2023 18:25:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] crypto: engine - Fix struct crypto_engine_op doc
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20230424002925.2740296-1-mmyangfl@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424002925.2740296-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/23/23 17:29, David Yang wrote:
> Remove redundant underscore and fix some grammar in prepare_request doc.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

No, I didn't report this issue. You either found it on your own or someone/something
else reported it.

> Link: https://lore.kernel.org/r/b58dc77c-c975-46cf-581c-368d9a87ae64@infradead.org

Also drop the Link: line.

> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  include/crypto/engine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/crypto/engine.h b/include/crypto/engine.h
> index ae133e98d813..2038764b30c2 100644
> --- a/include/crypto/engine.h
> +++ b/include/crypto/engine.h
> @@ -78,7 +78,7 @@ struct crypto_engine {
>  
>  /*
>   * struct crypto_engine_op - crypto hardware engine operations
> - * @prepare__request: do some prepare if need before handle the current request
> + * @prepare_request: do some preparation if needed before handling the current request

That part looks good.

>   * @unprepare_request: undo any work done by prepare_request()
>   * @do_one_request: do encryption for current request
>   */

-- 
~Randy
