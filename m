Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767D63D218
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiK3Jha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbiK3JhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:37:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2228BD0D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:34:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtf30w7z4xvh;
        Wed, 30 Nov 2022 20:34:02 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     joel@jms.id.au, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        ruanjinjie <ruanjinjie@huawei.com>, Julia.Lawall@inria.fr,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20221019063414.3758087-1-ruanjinjie@huawei.com>
References: <20221019063414.3758087-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH -next v2] powerpc/mpic_msgr: fix cast removes address space of expression warnings
Message-Id: <166980024887.3017288.841160634700021311.b4-ty@ellerman.id.au>
Date:   Wed, 30 Nov 2022 20:24:08 +1100
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

On Wed, 19 Oct 2022 14:34:14 +0800, ruanjinjie wrote:
> When build Linux kernel, encounter the following warnings:
> 
> ./arch/powerpc/sysdev/mpic_msgr.c:230:38: warning: cast removes address space '__iomem' of expression
> ./arch/powerpc/sysdev/mpic_msgr.c:230:27: warning: incorrect type in assignment (different address spaces)
> 
> The data type of msgr->mer and msgr->base are 'u32 __iomem *', but
> converted to 'u32 *' and 'u8 *' directly and cause above warnings, now
> instead of using a type cast, change the size of the pointer offset to fix
> these warnings.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mpic_msgr: fix cast removes address space of expression warnings
      https://git.kernel.org/powerpc/c/16a3f41ff3322830683d3ccc14d77736829c61bf

cheers
