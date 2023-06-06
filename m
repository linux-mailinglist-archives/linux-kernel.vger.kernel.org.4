Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F59D724F94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjFFW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjFFW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C79171B;
        Tue,  6 Jun 2023 15:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7009F62D9A;
        Tue,  6 Jun 2023 22:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61186C4339C;
        Tue,  6 Jun 2023 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686090543;
        bh=BE/Y78iy49nztkz3B5s6KdQt99eoZP/TQ2E6JCvgLgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPjbOJUanlgEhGuh3eudn3EeTrBQfiBtMJrMUPZe0/CrAOZQNkCimZAbZyJec3UN/
         7L0HYyfYZLNfR+SHaI0eavaM8akiWXPRTb8EcUrJ9nqPf/eEIymhJRSMUjQ5aXJA5a
         6Ci1lBAWpOHT15pFRT/sRhVJ+Mx8cpZNXpN0fpaeBgxoLWHo4lfOVB3jPkYLbZ2EWb
         Z4VKa7xQGJeqrdyROpyCcvcEePM+ldBIsMu6GT1dzjm+bpqO7H9EM2qEmCwUrkCP95
         q3El9eKvBLEzaca3grvyj/LtQQQIazW6RqvrGOTXEWIjeLycs/vFEmA5eZi2ccTazk
         KCQBP8SdJ125g==
Date:   Tue, 6 Jun 2023 15:29:01 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: [tip:objtool/core 8/12] vmlinux.o: warning: objtool:
 rust_begin_unwind+0x5c: rust_helper_BUG() is missing a __noreturn annotation
Message-ID: <20230606222901.kzz5dpglz7c5okhk@treble>
References: <202306070408.EFxuDoRs-lkp@intel.com>
 <20230606215212.r7if2gsynajugf6j@treble>
 <CANiq72nD3wvOxfUq9mxTiPDbf+VKmbU+eVepO7QY_G2LT-UOEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nD3wvOxfUq9mxTiPDbf+VKmbU+eVepO7QY_G2LT-UOEg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 12:22:45AM +0200, Miguel Ojeda wrote:
> On Tue, Jun 6, 2023 at 11:52 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > So it seems to be an issue with bindgen, though that github issue has
> > been resolved.  Any idea when this will show up in a toolchain?
> >
> > In the meantime we may have to get objtool to manually silence the
> > warning, unless you have any better ideas.
> 
> We were going to update `bindgen`, so we can just do that -- one more
> reason to do so! :)
> 
> If the update goes into the upcoming merge window, would that be fine
> with you? Or do you need it for this current cycle?

The next merge window would be good.  Eventually I want to get objtool
to zero warnings so we can do -Werror, but we're not there yet :-)

Thanks!

-- 
Josh
