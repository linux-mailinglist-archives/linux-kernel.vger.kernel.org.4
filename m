Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87A5FE697
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJNBcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJNBcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F219B65A;
        Thu, 13 Oct 2022 18:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0731D619A2;
        Fri, 14 Oct 2022 01:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B4EC433D6;
        Fri, 14 Oct 2022 01:32:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CfBqEF4C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665711122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rQm/bg82voTY0agndJMPgSI5IXnvAXgYe23RREiWRLY=;
        b=CfBqEF4CDbKS9nkckHfE0gHPtk/xfga4D6hyKfH1zeApvfCLLqWxTCSMj7luxpbt7i520f
        ydy7WkBn1VUc3CszAoEHEyr3wZoZ4yma5kBrJNXe/nif58rWO7f0pkan9prnT1/Tznmwyw
        shBgZxNhOp3tnRBR/esMOIcGuclhkJQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43dc2873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Oct 2022 01:32:02 +0000 (UTC)
Date:   Thu, 13 Oct 2022 19:31:59 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0i8D5NNnxMAo1hq@zx2c4.com>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <CAKwvOd=_gfTD24zEh9YpoNuBr_D+xjsefeb8sNXnSaU_UgnVRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=_gfTD24zEh9YpoNuBr_D+xjsefeb8sNXnSaU_UgnVRw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 02:08:22PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 12, 2022 at 6:37 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi,
> >
> > I've been working on a (still in development) patch that tries to
> > apply a few compile-time constant folding tricks to a widely used
> > library function, so I wanted to make sure my trickery worked across
> > all supported gcc versions for as many call sites as possible.
> 
> I'd imagine the kernel's inconsistent use of -ffreestanding per
> architecture would be a blocker, if by library function you're
> referring to a symbol that would typically be provided by the libc?
> 
> Do you have more info about what the specific issue you've observed is?

As mentioned, I don't really care to follow up with this. But you can if
you want to waste your time. Download a toolchain. Run allmodconfig.
Observe breakage. Shrug your shoulders and wish we would sunset ancient
toolchains.

Jason
