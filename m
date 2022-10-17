Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E445660132B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiJQQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiJQQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B2A6DFAD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F4A611D3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2635C433D6;
        Mon, 17 Oct 2022 16:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666022633;
        bh=DLnN0htvivwVhuJQm7cIim+/YRJwPriv2PpoqwyHlSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QiuJUAR/ea4x4NaK2D4yJyt1vA6WE758Mv0xHXmgJ9aNw3zYyfmyCCyey7ihQq02E
         2RwieJBrEp7hJSUKL/h/IcdWi9VHL0oDunl6+G1czR3ZWGU4//3Z9uY6PadeQKK/zW
         1MyDEBUM2RJTiV1qzheh2YXAkf92LBGAcM8WjDNqOjfww41HyoYTf6PhG5x8dG55Ya
         PLSL9qY4Gyx4kVKY/s2AghpR4a/tG7VRxcGh63KoQJ+UmcXgqjwi9WFm3BCdVTwkhW
         mLdyXZ1lK97qfyWgRU7CPwxo3iGpKiCWlGthjkjbXnL1/O+MXZLHK9E1x3GvSQK/1/
         Opg8ZlbD22QNA==
Date:   Mon, 17 Oct 2022 17:03:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/2] (attempt to) Fix RISC-V toolchain extension support
 detection
Message-ID: <Y0185O1zjyfv7WjN@spud>
References: <20221006173520.1785507-1-conor@kernel.org>
 <20221017155103.4dt5uzmnlbtibqcn@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017155103.4dt5uzmnlbtibqcn@kamzik>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:51:03PM +0200, Andrew Jones wrote:
> On Thu, Oct 06, 2022 at 06:35:19PM +0100, Conor Dooley wrote:
> 
> However, we could also drop the compiler and linker checking if we
> converted our use of cbo.* to the insn-def.h framework (I think Heiko once
> mentioned looking at doing that, but I'm not sure.) I'm looking at adding
> Zicboz support right now and for starters I've duplicated and modified
> these checks. But, I think I'll look into defining the instruction type
> needed for cbo.* and using insn-def instead.

What is the ETA of your zicboz support? Do you think these patches
should be applied to v6.1 & backported before being replaced by insn-def
when your zicboz support arrives? Or just wait for your zicboz series?

Trying to decide what status I should set for this in patchwork.

Thanks,
Conor.

