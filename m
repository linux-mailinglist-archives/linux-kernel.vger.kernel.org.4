Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4366673E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAKXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjAKXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:49:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5ED33D45;
        Wed, 11 Jan 2023 15:49:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nsksv2jQhz4xwq;
        Thu, 12 Jan 2023 10:49:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1673480948;
        bh=TO/ocmhMcHhsC/mqRwZMtfMXh7M3wWSE08jEbN0UeLg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o2sBrft+so5KCuv0rKQ2RDo0CxlMgp5/wA1agHH5jMAmc0z8DK2QaB14Zt9Zh4TA8
         lA0ZD+uPhEV7I7fXYlPAL+8oJ3TlP0KvnaNadhGAnJYQa2LkxFh4wtyuN3MBKAFyu+
         Y78Zr6oIECFdgxscUQzixUKK3fyeE4vrHYDmj+POR2jlkvT+Gpvlxyabcb5Tlo4wrR
         lFI4NaI3C5EA1PW3t8PJM0jvKPRGY2Rm4bUtJvIkmWuMn/5ApkMN08LIGzCo+JTa+y
         AGlTSbK1KdoPzk6jF+PSPM+sx5iOO3KKHucOS1dtf79iX+LOLgX5b4CPnPwJSX/s7i
         mllhGHAOrh8Yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH rcu 04/27] arch/powerpc/kvm: Remove "select SRCU"
In-Reply-To: <20230105003813.1770367-4-paulmck@kernel.org>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-4-paulmck@kernel.org>
Date:   Thu, 12 Jan 2023 10:49:04 +1100
Message-ID: <87h6wwhbtb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> ---
>  arch/powerpc/kvm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index a9f57dad6d916..902611954200d 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -22,7 +22,6 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select HAVE_KVM_EVENTFD
>  	select HAVE_KVM_VCPU_ASYNC_IOCTL
> -	select SRCU
>  	select KVM_VFIO
>  	select IRQ_BYPASS_MANAGER
>  	select HAVE_KVM_IRQ_BYPASS
> -- 
> 2.31.1.189.g2e36527f23
