Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8605ED6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiI1HxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiI1Hwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:52:33 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DB1D13A0;
        Wed, 28 Sep 2022 00:51:21 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1odRqZ-009Jqj-Dv; Wed, 28 Sep 2022 17:51:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Sep 2022 15:51:11 +0800
Date:   Wed, 28 Sep 2022 15:51:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        lei he <helei.sig11@bytedance.com>, kernel-team@cloudflare.com
Subject: Re: [PATCH 0/4] crypto: add ECDSA signature support to key retention
 service
Message-ID: <YzP87+27tWPGFCcQ@gondor.apana.org.au>
References: <20220908200036.2034-1-ignat@cloudflare.com>
 <Yy6wqqVpUCeQKrdh@gondor.apana.org.au>
 <CALrw=nG3UUL9e37AnFq3Q25-ApW+EHAfWNJDw+pwE0vNLUtxrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nG3UUL9e37AnFq3Q25-ApW+EHAfWNJDw+pwE0vNLUtxrA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:18:14PM +0100, Ignat Korchagin wrote:
.
> Should I resend patches 1-2 here and maybe 3-4 to the linux-keyrings
> mailing list?

I need acks to patches 3-4 because without a user we don't add
new algorithms to the Crypto API.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
