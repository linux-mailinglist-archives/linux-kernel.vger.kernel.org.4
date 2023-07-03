Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000EB7454E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGCFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGCFee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:34:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44881B7
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:34:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZP44WYcz4wxn;
        Mon,  3 Jul 2023 15:34:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
References: <7e469c8f01860a69c1ada3ca6a5e2aa65f0f74b2.1685955220.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
Message-Id: <168836201884.50010.14478880824891760898.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 10:58:35 +0200, Christophe Leroy wrote:
> Looking at generated code for handle_signal32() shows calls to a
> function called __unsafe_save_user_regs.constprop.0 while user access
> is open.
> 
> And that __unsafe_save_user_regs.constprop.0 function has two nops at
> the begining, allowing it to be traced, which is unexpected during
> user access open window.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()
      https://git.kernel.org/powerpc/c/a03b1a0b19398a47489fdcef02ec19c2ba05a15d

cheers
