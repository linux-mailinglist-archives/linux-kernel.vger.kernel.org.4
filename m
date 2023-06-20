Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0208C73761C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjFTUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFTUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B0187;
        Tue, 20 Jun 2023 13:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CA32611B9;
        Tue, 20 Jun 2023 20:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAADC433C0;
        Tue, 20 Jun 2023 20:33:26 +0000 (UTC)
Date:   Tue, 20 Jun 2023 16:33:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     mhiramat@kernel.org, ebiggers@kernel.org, azeemshaikh38@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/boot: Replace strlcpy with strscpy
Message-ID: <20230620163325.35c9203c@gandalf.local.home>
In-Reply-To: <168729290245.455922.11993639418267016143.b4-ty@chromium.org>
References: <20230615180420.400769-1-azeemshaikh38@gmail.com>
        <168729290245.455922.11993639418267016143.b4-ty@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2023 13:28:26 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Thu, 15 Jun 2023 18:04:20 +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > 
> > [...]  
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] tracing/boot: Replace strlcpy with strscpy
>       https://git.kernel.org/kees/c/b1c38314f756
> 

I was going to add this to my queue.

-- Steve
