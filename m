Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADC15B3708
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiIIMLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIIMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6840C0BD8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDW14byz4xG8;
        Fri,  9 Sep 2022 22:10:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <959d77be630b9b46a7458f0fbd41dc3a94ec811a.1661938317.git.christophe.leroy@csgroup.eu>
References: <959d77be630b9b46a7458f0fbd41dc3a94ec811a.1661938317.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/32: Drop a stale comment about reservation of gigantic pages
Message-Id: <166272520935.2076816.18378317029543943017.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:06:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 11:32:07 +0200, Christophe Leroy wrote:
> A comment about the reservation of gigantic pages was left in MMU_init()
> after commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support for
> reserving gigantic huge pages via kernel command line")
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/32: Drop a stale comment about reservation of gigantic pages
      https://git.kernel.org/powerpc/c/fc06755e25628ce215e9f75c1207250242dadf42
[2/3] powerpc/32: Allow fragmented physical memory
      https://git.kernel.org/powerpc/c/b0e0d68b1c52cb2c46e513011fdd53815cffefb7
[3/3] powerpc/32: Remove wii_memory_fixups()
      https://git.kernel.org/powerpc/c/0115953dcebe8858ba3d9997ba48328ebdca593f

cheers
