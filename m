Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45265D3BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbjADNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjADNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:05:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775C1DDC2;
        Wed,  4 Jan 2023 05:05:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D16CEB8163C;
        Wed,  4 Jan 2023 13:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8BC433EF;
        Wed,  4 Jan 2023 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672837524;
        bh=HgcYcbLQUuCY1Kc4OAO0bhkr3GGWCNM95MhsYtgwtFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpEmyY0KD/wAbTx9zt1oOJuG2pGJ/yjn3463c+ljDnKtFAukM8ayLV8EQ64TEQV49
         HQiOVLtYs5gkbjT8SSwJfeCfmLJ6QrM46YiFFTHuTgyLcUvdqPcUeZeYfpHC+jzK2r
         j/mMC30uncw75IpfdAjFtq27tmAAZqtFcyFGn4NyOmXnibldHFTNAfxCIrrSHzWXhw
         waV3Q1XGW30xj6rLHB7+Z3wQJ6IwX5JobdnvDYWeB6h/mK8soAEttepQEvgKQZpktM
         BOaIo4TomDJRWFAfy5SjZ7Q/OKQJLx2s2+nNWQhMX3LJMVElRXE+MMaAQnQ8kUf4xN
         sYK36Yb0j4RCg==
Date:   Wed, 4 Jan 2023 13:05:21 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: certs: fix FIPS selftest depenency
Message-ID: <Y7V5kQVgK3PTWRHi@kernel.org>
References: <20221215170259.2553400-1-arnd@kernel.org>
 <Y6tF52G6/bnG+VfJ@kernel.org>
 <Y6xCYmZkggGzzzBM@farprobe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6xCYmZkggGzzzBM@farprobe>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 08:19:30AM -0500, Ben Boeckel wrote:
> On Tue, Dec 27, 2022 at 19:22:38 +0000, Jarkko Sakkinen wrote:
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Might want to fix this when picked:
> 
> > Subject: Re: [PATCH] crypto: certs: fix FIPS selftest depenency
>                                              dependency ^^^^^^^^^
> 
> --Ben

Thank you! I updated the patch accordingly.

It should be soon available in linux-next tree.

BR, Jarkko
