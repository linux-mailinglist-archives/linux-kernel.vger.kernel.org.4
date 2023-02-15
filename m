Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD50697C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjBOMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjBOMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:43:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2831E1D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:43:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGyRF2QHWz4x7s;
        Wed, 15 Feb 2023 23:43:05 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <e62892e32c14a7a5738c597e39e0082cb0abf21c.1675335659.git.christophe.leroy@csgroup.eu>
References: <e62892e32c14a7a5738c597e39e0082cb0abf21c.1675335659.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG
Message-Id: <167646485519.1421441.15913006369717887437.b4-ty@ellerman.id.au>
Date:   Wed, 15 Feb 2023 23:40:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 12:01:04 +0100, Christophe Leroy wrote:
> CLANG only knows the following CPUs:
> 
> generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630,
> g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500,
> power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6,
> pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9,
> power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le,
> ppc64le, futur
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG
      https://git.kernel.org/powerpc/c/4b10306e98456aed03cad75ce467e8b1efdccca0

cheers
