Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D1074D237
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjGJJvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGJJuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:50:16 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F61FC6;
        Mon, 10 Jul 2023 02:45:13 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qInRy-0007zw-0Y; Mon, 10 Jul 2023 11:44:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v5 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Date:   Mon, 10 Jul 2023 11:44:56 +0200
Message-ID: <5381895.Sb9uPGUboI@phil>
In-Reply-To: <20230613030216.GC883@sol.localdomain>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230613030216.GC883@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am Dienstag, 13. Juni 2023, 05:02:16 CEST schrieb Eric Biggers:
> Hi Heiko,
> 
> On Mon, Jun 12, 2023 at 11:04:38PM +0200, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > 
> > This was originally part of my vector crypto series, but was part
> > of a separate openssl merge request implementing GCM ghash as using
> > non-vector extensions.
> > 
> > As that pull-request
> >     https://github.com/openssl/openssl/pull/20078
> > got merged recently into openssl, we could also check if this could
> > go into the kernel as well and provide a base for further accelerated
> > cryptographic support.
> 
> I'm still a bit skeptical of the usefulness of a standalone "ghash"
> implementation, when in practice it will only be used as part of "gcm(aes)".
> Directly implementing "gcm(aes)" (instead of relying on crypto/gcm.c to compose
> "ghash" and "ctr(aes)") also allows some performance optimizations.
> 
> I asked about this on v4
> (https://lore.kernel.org/linux-crypto/ZCSG71bRuTzVutdm@gmail.com/),
> but I didn't receive a response.
> 
> Any thoughts on this?

somehow I always seem to overlook this when adapting the series :-(

I guess for me the main gcm was always a stepping stone to get
started and extend later. This is my first rodeo with crypto stuff
in the kernel, so this looks like a manageable chunk and as can be
seen by the discussion we had about licensing brings enough topics
on its own :-) .


Heiko


