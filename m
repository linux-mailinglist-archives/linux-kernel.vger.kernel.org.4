Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16D63D21A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiK3Jhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiK3JhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D28BD08
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtd3Mkmz4xZl;
        Wed, 30 Nov 2022 20:34:01 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Anatolij Gustschin <agust@denx.de>,
        John Bonesio <bones@secretlab.ca>,
        kernel test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221124061918.1967-1-rdunlap@infradead.org>
References: <20221124061918.1967-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc/mpc52xx_lpbfifo: fix all kernel-doc warnings
Message-Id: <166980022198.3017288.13254869801146755533.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:41 +1100
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

On Wed, 23 Nov 2022 22:19:18 -0800, Randy Dunlap wrote:
> Fix multiple kernel-doc warnings in mpc52xx_lpbfifo.c:
> 
> arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c:377: warning: expecting prototype for mpc52xx_lpbfifo_bcom_poll(). Prototype was for mpc52xx_lpbfifo_poll() instead
> 
> mpc52xx_lpbfifo.c:221: warning: No description found for return value of 'mpc52xx_lpbfifo_irq'
> mpc52xx_lpbfifo.c:327: warning: No description found for return value of 'mpc52xx_lpbfifo_bcom_irq'
> mpc52xx_lpbfifo.c:398: warning: No description found for return value of 'mpc52xx_lpbfifo_submit'
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mpc52xx_lpbfifo: fix all kernel-doc warnings
      https://git.kernel.org/powerpc/c/4562bffb83b88e61ea9c9912e50efbd5a941f0b3

cheers
