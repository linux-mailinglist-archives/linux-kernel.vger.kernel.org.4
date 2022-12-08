Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA74646FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLHMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLHMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:49:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A727CD1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:49:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrh50JTz4xZ7;
        Thu,  8 Dec 2022 23:49:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     bgray@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
References: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/5] powerpc/code-patching: Remove #ifdef CONFIG_STRICT_KERNEL_RWX
Message-Id: <167050321439.1457988.16908884696488370128.b4-ty@ellerman.id.au>
Date:   Thu, 08 Dec 2022 23:40:14 +1100
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

On Fri, 2 Dec 2022 09:31:39 +0100, Christophe Leroy wrote:
> No need to have one implementation of patch_instruction() for
> CONFIG_STRICT_KERNEL_RWX and one for !CONFIG_STRICT_KERNEL_RWX.
> 
> In patch_instruction(), call raw_patch_instruction() when
> !CONFIG_STRICT_KERNEL_RWX.
> 
> In poking_init(), bail out immediately, it will be equivalent
> to the weak default implementation.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/code-patching: Remove #ifdef CONFIG_STRICT_KERNEL_RWX
      https://git.kernel.org/powerpc/c/84ecfe6f38ae4ee779ebd97ee173937fff565bf9
[2/5] powerpc/feature-fixups: Refactor entry fixups patching
      https://git.kernel.org/powerpc/c/6076dc349b1c587c74c37027efff76f0fa4646f4
[3/5] powerpc/feature-fixups: Refactor other fixups patching
      https://git.kernel.org/powerpc/c/3d1dbbca33a9c6dd3aafd4d14aaea9cc310723e1
[4/5] powerpc/feature-fixups: Do not patch init section after init
      https://git.kernel.org/powerpc/c/b988e7797d09379057cf991ae082f9ad7a309a63
[5/5] powerpc/code-patching: Remove protection against patching init addresses after init
      https://git.kernel.org/powerpc/c/6f3a81b60091031c2c14eb2373d1937b027deb46

cheers
