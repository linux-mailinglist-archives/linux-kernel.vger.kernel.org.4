Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B5651A89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiLTGF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiLTGFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:05:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752678FCC;
        Mon, 19 Dec 2022 22:05:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F782B80B4A;
        Tue, 20 Dec 2022 06:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF6BC433EF;
        Tue, 20 Dec 2022 06:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671516342;
        bh=1q6F9HNnOxLzAlccZIWYJYxCV4vTjQ58G8TbnRun3FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYzRYG0FCuUOf26u1OX5hnuA+G8KVfSbQftswoWRj59ri/Jiwp5nGTvNiiwMUWt8X
         p0YHJOsCCinfM+oLrWZ1T0LJCYJmSgVz2PXbToQDaldFYzzVcgUxLMFq98dH6RPc9s
         0Rqgkp5iMn9RNk9s0IJeTzaX0wmsOpcdSqknwXbC5DyAuEDRknTXYhibFrSXYTPW3M
         xHbibRlQN88wJLlSFM3tliEBXRP8Aj5HzcDSZKZzBJyfvu8UYFkmzVECgKi9HOM/KB
         bGszvFw/v9ujLbI8eA4LkG35lk6SCaP9Dv35vMKDx2m5x9CojOvhkscf6PD1qNfUhd
         S8nFfLcQJS8kw==
Date:   Mon, 19 Dec 2022 22:05:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Robert Elliott <elliott@hpe.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] crypto: x86/chacha - add kernel-doc comments to
 assembly
Message-ID: <Y6FQtNgZy8lXKfiz@sol.localdomain>
References: <20221215063857.161665-1-elliott@hpe.com>
 <20221219185555.433233-1-elliott@hpe.com>
 <20221219185555.433233-9-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219185555.433233-9-elliott@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 12:55:55PM -0600, Robert Elliott wrote:
> +/**
> + * chacha_2block_xor_avx2 - Encrypt 2 blocks using the x86 AVX2 feature set
> + * @state:	address of input state matrix, s (%rdi)
> + * @dst:	address of up to 2 data blocks output, o (%rsi)
> + * @src:	address of up to 2 data blocks input, i (%rdx)
> + * @len:	input/output length in bytes (%rcx)
> + * @nrounds:	number of rounds (%r8d)
> + *
> + * This function encrypts two ChaCha blocks by loading the state
> + * matrix twice across four AVX registers. It performs matrix operations
> + * on four words in each matrix in parallel, but requires shuffling to
> + * rearrange the words after each round.

2 blocks, or up to 2 blocks?  What does that mean?

> + *
> + * Return:	none
> + * Prototype:	asmlinkage void chacha_2block_xor_avx2(u32 *state, u8 *dst, const u8 *src,
> + *						       unsigned int len, int nrounds);

When the return type is void, there is no need to write "Return: none".

- Eric
