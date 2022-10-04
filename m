Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9C5F4466
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJDNjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiJDNiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:38:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4C4CA0F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:38:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1Q1dtLz4xH0;
        Wed,  5 Oct 2022 00:38:50 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3bc3f5a51949ee7f52dba36677db23d4337c7995.1662544980.git.christophe.leroy@csgroup.eu>
References: <3bc3f5a51949ee7f52dba36677db23d4337c7995.1662544980.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Make PAGE_KERNEL_xxx macros grep-friendly
Message-Id: <166488986064.779920.7775499498135224322.b4-ty@ellerman.id.au>
Date:   Wed, 05 Oct 2022 00:24:20 +1100
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

On Wed, 7 Sep 2022 12:05:21 +0200, Christophe Leroy wrote:
> Avoid multi-lines to help getting a complete view when using
> grep. They still remain under the 100 chars limit.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Make PAGE_KERNEL_xxx macros grep-friendly
      https://git.kernel.org/powerpc/c/6cc07821adce44e864c3752a3842936a6a7f6aef

cheers
