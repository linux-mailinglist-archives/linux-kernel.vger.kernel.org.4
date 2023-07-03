Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5783F745513
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGCFwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGCFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:52:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB567B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 22:52:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp40mcnz4wxr;
        Mon,  3 Jul 2023 15:52:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230429043503.19385-1-rdunlap@infradead.org>
References: <20230429043503.19385-1-rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc: delete empty config entry for PPC_86xx
Message-Id: <168836201879.50010.14712830432114866109.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 21:35:03 -0700, Randy Dunlap wrote:
> Drop an unused and empty "config" entry for PPC_86xx.
> It has no keyword entries under it and the following line's
> "menuconfig" for the same Kconfig symbol is what kconfig uses.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: delete empty config entry for PPC_86xx
      https://git.kernel.org/powerpc/c/9d87ab41743fa3658d568859d64936b37f058b60

cheers
