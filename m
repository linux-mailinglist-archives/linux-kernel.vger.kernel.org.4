Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D147B5F445E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJDNi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJDNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3324DB67
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1N3pCHz4xGy;
        Wed,  5 Oct 2022 00:38:48 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <bea5ad0de7f83eff256116816d46c84fa0a444de.1662370698.git.christophe.leroy@csgroup.eu>
References: <bea5ad0de7f83eff256116816d46c84fa0a444de.1662370698.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/book3s: Inline first level of update_mmu_cache()
Message-Id: <166488985859.779920.743401358886191871.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:24:18 +1100
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

On Mon, 5 Sep 2022 11:38:25 +0200, Christophe Leroy wrote:
> update_mmu_cache() voids when hash page tables are not used.
> On PPC32 that means when MMU_FTR_HPTE_TABLE is not defined.
> On PPC64 that means when RADIX is enabled.
> 
> Rename core part of update_mmu_cache() as __update_mmu_cache()
> and include the initial verification in an inlined caller.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/book3s: Inline first level of update_mmu_cache()
      https://git.kernel.org/powerpc/c/73ea68ad0d2f655815b6f1fbe1c5521d72f01b64

cheers
