Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E76E6E68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjDRVie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjDRVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D904B755
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADAE363979
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF6FC433EF;
        Tue, 18 Apr 2023 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853905;
        bh=8y2e9kv+5/6L0m6GFF2Jgn9ApZtit/ZIKZ7FL8RXKgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsV6C3GiEJWwXRZErvjXUuqGAUYpgpzUOMe+zavOQJgfGagu23c+CxuHDCSH1+RYR
         IIzk5Myi9+9b5NSLqJWdQwJ5hJ6koxwNCwJWIrlAyd4Uk0VdPAV2O7eahnlJldlgwm
         6U3fU1uzXKPEJBRLYfrbxwMU/IUzGuWbuzhiE4uCWhLT0MPoLCb37KO3A0H8CooNwk
         i0Vcetpc//Xdag4h9NHPuY5jv1T3r09zcneLQAAlO6RHQx2jeaNiPkOikk/e1jtMgh
         8m2SlrI6Q9n87mOUh7Mll+d86Mk5wuXV1aeXiYH6ASWWyX2croUMMrU+qEDSrad4FA
         IQayVyNw5i01Q==
Date:   Tue, 18 Apr 2023 14:38:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     ndesaulniers@google.com
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>, Tom Rix <trix@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/2] start_kernel: omit stack canary
Message-ID: <20230418213822.xauewkuus25k2aj6@treble>
References: <20230412-no_stackp-v2-0-116f9fe4bbe7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412-no_stackp-v2-0-116f9fe4bbe7@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 03:00:04PM -0700, ndesaulniers@google.com wrote:
> ---
> Changes in v2:
> - Rebase to avoid conflicts with Josh's changes.
> - Fix comment style as per Peter.
> - Pick up tags.
> - Link to v1: https://lore.kernel.org/r/20230412-no_stackp-v1-0-46a69b507a4b@google.com
> (sorry for the spam with v2, mrincon is helping me get kinks worked out
> with b4 and our corporate mailer)

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
