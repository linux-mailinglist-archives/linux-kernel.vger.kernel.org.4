Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BACD6ED50C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjDXTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjDXTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F465B8;
        Mon, 24 Apr 2023 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pX7fYbKdD9VUrX9qHrWFIZBffJYFHZDuRDtcQ0DAZtg=; b=4UN2HFnnh8+j9ZC0AM/R+6mB2x
        RPFbAwa7y/feep8ZgnD+12MU+vwRNZDi9ErMQsse0BmMavlfFUhs5C3SsHXnnkNHhP/5T118mP6uz
        uCNj0sck6TDzdhp3f3JRokTbS4D9xLGhoN3KK2jtlW9EqcGJDUsyWoIvJBVetEe/nONSnB4NyGttZ
        fiJa2oK96K3UYJqHmgknNV0MOl1V6KdCLSAEtdaMadZHnwMXZ2+GLO7SrkXKvICQqjZLaml1F7cM6
        WtS3uSUyFF3r32Q2Hbw08KuvBQ21QgouLCkntnhP7Lgqb0zpJPD8diQbylihwJq8TzzRZEpmULJ+A
        7lYp9i+Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr1VX-00H2Am-23;
        Mon, 24 Apr 2023 19:05:51 +0000
Message-ID: <1c5a7284-11b0-47d4-97f4-ef7d8c518fe3@infradead.org>
Date:   Mon, 24 Apr 2023 12:05:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] crypto: engine - Fix struct crypto_engine_op doc
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>, linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20230424172021.2893856-1-mmyangfl@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230424172021.2893856-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 10:20, David Yang wrote:
> Remove redundant underscore and fix some grammar in prepare_request doc.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2: fix description too
> v3: remove inappropriate commit tags
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
>   * @unprepare_request: undo any work done by prepare_request()
>   * @do_one_request: do encryption for current request
>   */

-- 
~Randy
