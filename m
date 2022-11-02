Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0D6617324
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKBX76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKBX7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:59:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306F55BC;
        Wed,  2 Nov 2022 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t5AqGgPaokx6x0rdC5uz+rjU5dq/lOC3mQZwI1qWWWM=; b=2lQc0nXIKirMBa4o/dvF+NXVyc
        nyq0G4c3Y6tODFlxfJPvEFrzp7u999cDdCbQImfmCGm8LEr+avFItV98IZ7vT5r4g2F8qlDLoXKrI
        sGcK1fLVzSFrDpi9ihWorXe7ZAD/yBzC9Xk9li1KNmQLQu+O/Y0+BQZGHtAIHhCR6GlXj6h/38caX
        g98vFMkepKFvL68ADOye4fDgtHlk2uT1OJfBAAdFp3gbMm01dltKKhP22PndC8Wffr+qJOcE8y6Rp
        Tb8TsWBuG9oyXMBdQcgXP3kPnqcdpc2qpNa9GD4ckfBgsCBVeoXRWEKKL+Ns0+SQotRwqBV5g4kc3
        LPHdLXuQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqNeA-00FFcb-PY; Wed, 02 Nov 2022 23:59:50 +0000
Date:   Wed, 2 Nov 2022 16:59:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-modules@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v5 1/2] module: add module_elf_check_arch for
 module-specific checks
Message-ID: <Y2MEdgcrkR79yWqs@bombadil.infradead.org>
References: <20221031120733.3956781-1-npiggin@gmail.com>
 <20221031120733.3956781-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031120733.3956781-2-npiggin@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:07:32PM +1000, Nicholas Piggin wrote:
> The elf_check_arch() function is also used to test compatibility of
> usermode binaries. Kernel modules may have more specific requirements,
> for example powerpc would like to test for ABI version compatibility.
> 
> Add a weak module_elf_check_arch() that defaults to true, and call it
> from elf_validity_check().
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> [np: added changelog, adjust name, rebase]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
