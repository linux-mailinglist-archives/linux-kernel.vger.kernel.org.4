Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847945B3711
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiIIMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIIMKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B0102D68
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDY576Zz4xYS;
        Fri,  9 Sep 2022 22:10:05 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
References: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/vdso: link with -z noexecstack
Message-Id: <166272522030.2076816.2756216556441607158.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:00 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 17:25:24 +0200, Christophe Leroy wrote:
> With recent binutils, the following warning appears:
> 
>   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.2.0/../../../../powerpc64-linux/bin/ld: warning: arch/powerpc/kernel/vdso/getcpu-32.o: missing .note.GNU-stack section implies executable stack
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.2.0/../../../../powerpc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> To avoid that, explicitely tell the linker we don't
> want executable stack.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vdso: link with -z noexecstack
      https://git.kernel.org/powerpc/c/1d53c0192b15f42129a3dbbbfa05637bcf781a3e

cheers
