Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC10563D1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiK3JcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiK3Jbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462275655D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqj6lLyz4xN2;
        Wed, 30 Nov 2022 20:31:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <67c3b5d44edfec054234ea9b4d05fc4b4f7f8a0e.1664346554.git.christophe.leroy@csgroup.eu>
References: <67c3b5d44edfec054234ea9b4d05fc4b4f7f8a0e.1664346554.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Reverse order entries are written by __set_pte_at()
Message-Id: <166980023882.3017288.12713313027194330624.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:58 +1100
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

On Wed, 28 Sep 2022 08:29:22 +0200, Christophe Leroy wrote:
> At the time being, with 16k pages __set_pte_at() writes table entries
> in reverse order:
> 
>  294:	91 49 00 0c 	stw     r10,12(r9)
>  298:	91 49 00 08 	stw     r10,8(r9)
>  29c:	91 49 00 04 	stw     r10,4(r9)
>  2a0:	91 49 00 00 	stw     r10,0(r9)
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Reverse order entries are written by __set_pte_at()
      https://git.kernel.org/powerpc/c/0b4721815c5328e08c3acdee4a53890e012d830b

cheers
