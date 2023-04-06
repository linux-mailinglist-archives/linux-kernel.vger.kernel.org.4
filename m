Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2E6D8C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjDFBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjDFBLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:11:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722517ED9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:11:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsNjy4gf5z4xFn;
        Thu,  6 Apr 2023 11:11:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230327223045.819852-1-robh@kernel.org>
References: <20230327223045.819852-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: isa-bridge: Remove open coded "ranges" parsing
Message-Id: <168074339913.3678997.512446611502736454.b4-ty@ellerman.id.au>
Date:   Thu, 06 Apr 2023 11:09:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 17:30:45 -0500, Rob Herring wrote:
> "ranges" is a standard property with common parsing functions. Users
> shouldn't be implementing their own parsing of it. Reimplement the
> ISA brige "ranges" parsing using the common ranges iterator functions.
> 
> The common routines are flexible enough to work on PCI and non-PCI to
> ISA bridges, so refactor pci_process_ISA_OF_ranges() and
> isa_bridge_init_non_pci() into a single implementation.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: isa-bridge: Remove open coded "ranges" parsing
      https://git.kernel.org/powerpc/c/e4ab08be5b4902e5b350b0e1e1a3c25eb21d76d4

cheers
