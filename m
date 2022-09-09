Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28825B3704
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiIIMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiIIMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:10:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B111B750
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:10:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDd2Cc6z4xZk;
        Fri,  9 Sep 2022 22:10:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     agust@denx.de, paulus@samba.org, Liang He <windhl@126.com>,
        nick.child@ibm.com, ulia.Lawall@inria.fr, benh@kernel.crashing.org,
        mpe@ellerman.id.au
Cc:     joel@jms.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220615143703.3968898-1-windhl@126.com>
References: <20220615143703.3968898-1-windhl@126.com>
Subject: Re: [PATCH] arch: powerpc: platforms: 512x: Add missing of_node_put()
Message-Id: <166272522122.2076816.13173445897300716877.b4-ty@ellerman.id.au>
Date:   Fri, 09 Sep 2022 22:07:01 +1000
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

On Wed, 15 Jun 2022 22:37:03 +0800, Liang He wrote:
> In mpc5121_clk_init(), of_find_compatible_node() will return a
> node pointer with refcount incremented. We should use of_node_put()
> when it is not used anymore.
> 
> 

Applied to powerpc/next.

[1/1] arch: powerpc: platforms: 512x: Add missing of_node_put()
      https://git.kernel.org/powerpc/c/06f48f5cb5df2299f5e4b42e9dda1858bf172bcb

cheers
