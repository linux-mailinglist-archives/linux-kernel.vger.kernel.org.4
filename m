Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB068ADAD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 01:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjBEArc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 19:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBEAra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 19:47:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA522DD2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 16:47:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P8W260jy0z4xwq;
        Sun,  5 Feb 2023 11:47:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <4b8d4f96140af01dec3a3330924dda8b2451c316.1674476798.git.christophe.leroy@csgroup.eu>
References: <4b8d4f96140af01dec3a3330924dda8b2451c316.1674476798.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Check !irq instead of irq == NO_IRQ and remove NO_IRQ
Message-Id: <167555802448.1621279.10787309982288240636.b4-ty@ellerman.id.au>
Date:   Sun, 05 Feb 2023 11:47:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 13:26:46 +0100, Christophe Leroy wrote:
> NO_IRQ is a relic from the old days. It is not used anymore in core
> functions. By the way, function irq_of_parse_and_map() returns value 0
> on error.
> 
> In some drivers, NO_IRQ is erroneously used to check the return of
> irq_of_parse_and_map().
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Check !irq instead of irq == NO_IRQ and remove NO_IRQ
      https://git.kernel.org/powerpc/c/bab537805a10bdbf55b31324ba4a9599e0651e5e

cheers
