Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B827B7323B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbjFOXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFOXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D85B3;
        Thu, 15 Jun 2023 16:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0214C62CED;
        Thu, 15 Jun 2023 23:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C07C433C8;
        Thu, 15 Jun 2023 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686871918;
        bh=t+QI63HrVrYITHLWjMqCtcO/Gehz+b2j1pbFfeAxwsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8YjWMm3BG13woqCmxETSdl8VSFNt+gRyz2TSTbj4d+zgUYGBDcvBIbq0ZJqTlz4f
         6pyuJf1J3IKUCqbS4PPRQ57r2kSoCRiOmZ2a2zPTtmKpzcCmvqSLA3qzxdZIiXHnLN
         m91/sI1BlT13ZUnDEzanf27QNwMjiS9eWyrK7tR0UDBHFCP5Wh+79B+EWYnYfBfckr
         RbcA6/g5C56bzpWgEMTvVVVB90aQQH2whmU3udOM7737StCUGQNZfx5XtszD2bKVek
         aPaQToLm3RFm3+L10CCV/fSD6r37jNUhLJ2oy0R6GgVb7rkjWPvfIU5ZhdoLLKqJ3O
         FIj2XX/5vY7Ug==
Date:   Thu, 15 Jun 2023 16:31:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH-next 1/3] crypto: api - Remove crypto_init_ops()
Message-ID: <20230615233156.GA25295@sol.localdomain>
References: <20230614174643.3836590-1-dima@arista.com>
 <20230614174643.3836590-2-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614174643.3836590-2-dima@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 06:46:41PM +0100, Dmitry Safonov wrote:
> Purge crypto_type::init() as well.
> The last user seems to be gone with commit d63007eb954e ("crypto:
> ablkcipher - remove deprecated and unused ablkcipher support").
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  crypto/api.c            | 14 --------------
>  include/crypto/algapi.h |  1 -
>  2 files changed, 15 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
