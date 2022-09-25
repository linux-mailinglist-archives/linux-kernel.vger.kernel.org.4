Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD05E96F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 01:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiIYXrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 19:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiIYXrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D629527FF4;
        Sun, 25 Sep 2022 16:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BA4B80D10;
        Sun, 25 Sep 2022 23:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB0FC433C1;
        Sun, 25 Sep 2022 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664149650;
        bh=jBdWE73gHJD6zbCZOgUVGcSjpqCYeSvt/dB/PnAu9SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4Kcj0C92cDc9V9BPCMXrqbOs0MeuLrS47eoSMWFqX0vrj9g5SZC394rY2SA8Fywt
         fcsn44BJWaaAwiHPoNyDSQMlZkRaKBfzOJoT4Tk4B/BAf1rNL86S5+otELzCWcOOuw
         kqlZ3olj9EmSoI5KJyTTxsRc9rMlnfjMxAw8sjFwN58JksDqvtSaYK3OOvqKOdOLJ4
         8Tokn9C7+RoZP9EZ2E3WPwDK1Sa/Jgyz91kcsNczJne4mwoWbtixmkdXJCvECkl6ZP
         UIDUxErsfPiwtEXEtpDYtCiJHquiKZJ0J9fziFEarkKo5n7T3xiuJBqL1pqB7W+oY1
         nNL2Ont+h9i5g==
Date:   Sun, 25 Sep 2022 16:47:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Compiler Attributes: Introduce __access_*() function
 attribute
Message-ID: <YzDoj5E/WsswW0OH@thelio-3990X>
References: <20220924150715.247417-1-keescook@chromium.org>
 <Yy/dLihBWSFzZdyq@dev-arch.thelio-3990X>
 <CANiq72nb8s0odCEfCEeWDKjJ7=aj_JxO9iaR8Jmn6LB1aSGifQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nb8s0odCEfCEeWDKjJ7=aj_JxO9iaR8Jmn6LB1aSGifQ@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 01:36:22PM +0200, Miguel Ojeda wrote:
> On Sun, Sep 25, 2022 at 6:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > The GCC docs say it is 'access', instead of '__access__'. I assume it is
> > probably okay so:
> 
> Yeah, attributes can be used either with or without double
> underscores, see
> https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html#Attribute-Syntax.

Aha, I figured I was missing something. That is what I get for doing a
mobile review :)

> In this file, we always use the underscore ones to minimize the chance
> of collisions, since the idea is that the rest of the kernel uses the
> shorthands provided here.

That certainly makes sense, I think it is a little easier to read too,
as it gives the attribute name a little separating from '__attribute__'
and any arguments to it.

Cheers,
Nathan
