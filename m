Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317E4745512
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGCFws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGCFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F4B2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:52:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp44F45z4wxs;
        Mon,  3 Jul 2023 15:52:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230521225103.19197-1-rdunlap@infradead.org>
References: <20230521225103.19197-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2 RESEND] powerpc/embedded6xx: select MPC10X_BRIDGE only if PCI is set
Message-Id: <168836201882.50010.697016860186007941.b4-ty@ellerman.id.au>
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

On Sun, 21 May 2023 15:51:03 -0700, Randy Dunlap wrote:
> When CONFIG_SMP is not set, CONFIG_BROKEN_ON_SMP is set, and
> CONFIG_PCI is not set, there can be a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
>   Depends on [n]: PCI [=n]
>   Selected by [y]:
>   - MPC10X_BRIDGE [=y]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/embedded6xx: select MPC10X_BRIDGE only if PCI is set
      https://git.kernel.org/powerpc/c/05d1c49c0339bab1c5d94a3d5146c8efc8385dd2

cheers
