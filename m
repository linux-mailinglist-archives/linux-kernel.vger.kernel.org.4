Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21526D8C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjDFBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjDFBLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:11:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D147EF1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:11:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsNjn5SJJz4xFL;
        Thu,  6 Apr 2023 11:11:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
In-Reply-To: <99ca1da2e5a6cf82a8abf4bc034918e500e31781.1677513277.git.christophe.leroy@csgroup.eu>
References: <99ca1da2e5a6cf82a8abf4bc034918e500e31781.1677513277.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/perf: Properly detect mpc7450 family
Message-Id: <168074339918.3678997.525922814661699693.b4-ty@ellerman.id.au>
Date:   Thu, 06 Apr 2023 11:09:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 16:54:45 +0100, Christophe Leroy wrote:
> Unlike PVR_POWER8, etc ...., PVR_7450 represents a full PVR
> value and not a family value.
> 
> To avoid confusion, do like E500 family and define the relevant
> PVR_VER_xxxx values for the 7450 family:
>   0x8000 ==> 7450
>   0x8001 ==> 7455
>   0x8002 ==> 7447
>   0x8003 ==> 7447A
>   0x8004 ==> 7448
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Properly detect mpc7450 family
      https://git.kernel.org/powerpc/c/e7299f961fe5e4496db0bfaa9e819f5e97f3846b

cheers
