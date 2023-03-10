Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A8A6B3BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCJKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCJKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:18:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E50122006
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:18:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PY2854VW8z4x4r;
        Fri, 10 Mar 2023 21:18:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678443525;
        bh=jiJuyTX5wFANGcuOeY73DhON2fnne2lEj0SJrCko2lo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VBK1EyHgI7Ah60Dwwosee2JOBs/BGT8QYjNSoJ9mMCZpXB6cfJKi0eaKz4LhRXuRF
         JkogByCJps4SkQWaT5Qg6PDUyGqGTCT6Im1+dTwAoS+w7FwGVIR4yG1kC/cEpFBrbA
         RwJaYGuzEA9M2Yt3UaNK1i5UjSfkwdKJOGFVPite+pMIsJEvlGT2nYILK0XdxcSBBb
         K0KmjyDtxEYWj4kEUbydq3tWAzrD8Q2Ud/u8Ljl3BIDnJrjURVCin9/mwRUeRi8kO1
         V/Mv3oJT/nM6stubCmTJlFQieXkU5I3w+HLx5A6ygk2vBd9397gcQ0BLbEm1JjXU9j
         EfYX0QZEb7XWQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sean Christopherson <seanjc@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH] KVM: PPC: Mark three local functions "static"
In-Reply-To: <20230308232437.500031-1-seanjc@google.com>
References: <20230308232437.500031-1-seanjc@google.com>
Date:   Fri, 10 Mar 2023 21:18:42 +1100
Message-ID: <87ttysoqnx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:
> Tag a few functions that are local and don't have a previous prototype as
> "static".
>
> No functional change intended.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303031630.ntvIuYqo-lkp@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> This was prompted by a new W=1 build warning for a commit that went in
> through the KVM tree, but said commit has made its way to Linus, so it
> shouldn't matter who grabs this.

OK thanks. I'll take this via the powerpc tree for v6.4.

cheers
