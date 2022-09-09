Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A177F5B3717
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIIMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiIIMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA6C12DA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDW4d6Vz4xXS;
        Fri,  9 Sep 2022 22:10:03 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <688084b40b5ac88f2905cb207d5dad947d8d34dc.1662531153.git.christophe.leroy@csgroup.eu>
References: <688084b40b5ac88f2905cb207d5dad947d8d34dc.1662531153.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/math-emu: Inhibit W=1 warnings
Message-Id: <166272525808.2076816.12460969365372770146.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:38 +1000
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

On Wed, 7 Sep 2022 08:12:54 +0200, Christophe Leroy wrote:
> When building with W=1 you get:
> 
> 	arch/powerpc/math-emu/fre.c:6:5: error: no previous prototype for 'fre' [-Werror=missing-prototypes]
> 	arch/powerpc/math-emu/fsqrt.c:11:1: error: no previous prototype for 'fsqrt' [-Werror=missing-prototypes]
> 	arch/powerpc/math-emu/fsqrts.c:12:1: error: no previous prototype for 'fsqrts' [-Werror=missing-prototypes]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/math-emu: Inhibit W=1 warnings
      https://git.kernel.org/powerpc/c/78c73c80fd860d5b3471d8eaa2778a105a56f6ab

cheers
