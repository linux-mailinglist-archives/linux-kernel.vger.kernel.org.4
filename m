Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457B0623345
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKITOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKITOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:14:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DD186D4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:14:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A4961CB6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C9C433C1;
        Wed,  9 Nov 2022 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668021245;
        bh=9+ezXuKLKJrJi5jxVLZ+tU4siYaqZ/EiW1zLmFT7V5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlkVESRsZ+UF+b2bbmijcDlfkW00l80vMLZazpLDfuvKXh4KzFWxQlOqSxsJ3Wq/M
         2F1eX21cy2X1+O6bxhMiC66OsvmNoGKyZRgSZ93sm1X/tniXBBm9yiFU+80Ps1/gzm
         CmoTV3reHgNhTOCfEqgzMEy3kcxGjX/MxSLHxjxkypBG8zfuQfxXP7FUOo0GwL8ota
         7hxqVup6ADQVwL9vZcU0whWO1cqbrHgxpQWeCnF6w5LjZrCOjcLFk1PssrvQ0PEVSo
         5/v1cmsEkIvX8fyan0GaH+U7jY56HbbZDVHRl9qo/VrONr5kl9X+vkkDBVvSYszQAX
         Lx9X/5gLgxJVg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
Date:   Wed,  9 Nov 2022 19:13:57 +0000
Message-Id: <166801759869.863955.2245773811250086481.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221107141753.2938621-1-anshuman.khandual@arm.com>
References: <20221107141753.2938621-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 19:47:53 +0530, Anshuman Khandual wrote:
> pte_to_phys() assembly definition does multiple bits field transformations
> to derive physical address, embedded inside a page table entry. Unlike its
> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
> simplifies these operations via a new macro PTE_ADDR_HIGH_SHIFT indicating
> how far the pte encoded higher address bits need to be left shifted. While
> here, this also updates __pte_to_phys() and __phys_to_pte_val().
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
      https://git.kernel.org/arm64/c/a4ee28615c7a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
