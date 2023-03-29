Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF96CEF44
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC2QYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjC2QYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA50618E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB0B61D9A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 16:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AFBC433EF;
        Wed, 29 Mar 2023 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680107042;
        bh=ZfDCTUE3oR1CBgAqgNY9DNOMOsUvZeRr63AGfwcjHi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UycVgPSI2wjGSFkb5+6sqhBd51FDvviejCHPRnkkAFSOqBgkaVwTcKAOM1S6Lq/Hq
         YCLPPaS47IUFM3q2Ao94CpryVBWqDIOEBaykNg/9/btd2pwR69SDa+pCH+3u+b+7R/
         OuoOuOUtCvEKEHZFz+HGIuBOzeUIsFajRwLoz0KpLuWUwoff6DzZ0H/KKqVioQnURb
         QNd7w5l8VlIy17ib4up8TbNu02ALoERJk5ZEbpcQqQqb83DRztWbLXUzyfgjmxccTG
         n9NQkJrkomxFOxB4839oMGl+QERKTZ08GaLUbdYcJ7f8txJbR6ehDWBkJdcVEtQiF+
         0xe86mrC6P3VA==
Date:   Wed, 29 Mar 2023 09:24:00 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] objtool: Add "missing __noreturn" warning
Message-ID: <20230329162400.nimzdxjwd6isddux@treble>
References: <cover.1679932620.git.jpoimboe@kernel.org>
 <4f22aa05702ca037630fa6c1f7fd54d13914a631.1679932620.git.jpoimboe@kernel.org>
 <alpine.LSU.2.21.2303281110100.14873@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2303281110100.14873@pobox.suse.cz>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:10:48AM +0200, Miroslav Benes wrote:
> >  		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
> > -		return 1;
> 
> I knew I should have read the whole set first...

Oops, guess that is in the wrong patch.

-- 
Josh
