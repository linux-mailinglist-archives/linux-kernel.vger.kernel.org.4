Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4563D1F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiK3Jca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiK3Jbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:31:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B4D55AA5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:31:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqk3D0wz4xP9;
        Wed, 30 Nov 2022 20:31:30 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <65f76300de07091a59a042a3db2d0ce9b939a05c.1664346532.git.christophe.leroy@csgroup.eu>
References: <65f76300de07091a59a042a3db2d0ce9b939a05c.1664346532.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Simplify pte_update() with 16k pages
Message-Id: <166980023807.3017288.13472562694365213076.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:23:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 08:29:00 +0200, Christophe Leroy wrote:
> While looking at code generated for code patching, I saw that
> pte_clear generated:
> 
>  2d8:	38 a0 00 00 	li      r5,0
>  2dc:	38 e0 10 00 	li      r7,4096
>  2e0:	39 00 20 00 	li      r8,8192
>  2e4:	39 40 30 00 	li      r10,12288
>  2e8:	90 a9 00 00 	stw     r5,0(r9)
>  2ec:	90 e9 00 04 	stw     r7,4(r9)
>  2f0:	91 09 00 08 	stw     r8,8(r9)
>  2f4:	91 49 00 0c 	stw     r10,12(r9)
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Simplify pte_update() with 16k pages
      https://git.kernel.org/powerpc/c/f2c45962cc618c12f69fd46e6ebc20b9cd7f15ac

cheers
