Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC40D745516
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGCFw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjGCFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63202B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:52:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp654tCz4wxw;
        Mon,  3 Jul 2023 15:52:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Anatolij Gustschin <agust@denx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230614171724.2403982-1-robh@kernel.org>
References: <20230614171724.2403982-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: 52xx: Make immr_id DT match tables static
Message-Id: <168836201904.50010.1650566287434945163.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:59 +1000
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

On Wed, 14 Jun 2023 11:17:23 -0600, Rob Herring wrote:
> In some builds, the mpc52xx_pm_prepare()/lite5200_pm_prepare() functions
> generate stack size warnings. The addition of 'struct resource' in commit
> 2500763dd3db ("powerpc: Use of_address_to_resource()") grew the stack size
> and is blamed for the warnings. However, the real issue is there's no
> reason the 'struct of_device_id immr_ids' DT match tables need to be on
> the stack as they are constant. Declare them as static to move them off
> the stack.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: 52xx: Make immr_id DT match tables static
      https://git.kernel.org/powerpc/c/d65305bfa6f797712b928bd8f4781380726b70a0

cheers
