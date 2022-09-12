Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB45B6203
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiILUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiILUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:06:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836521809
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4296127D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFECC433D6;
        Mon, 12 Sep 2022 20:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663013204;
        bh=POm5i/TN6x7SZia4lCIH+aJnU08Ov/27rWDNjJHTN1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qd9upT6GqFOCIGNRHAi2HJWDE/w//dK4jcNazYGutioly7EMjZ+E0qVKokDfmf1VP
         OiX1w8Ib5p9EMJcv+A5Vym6JkPK5BTR0kC9iNb/4Dq5puMW1bOujobSKkkas6ZPRue
         rFw0DKVp5cgFW3I4fSF+l7tJ8JvUPQAZ9/Uxe52Y=
Date:   Mon, 12 Sep 2022 13:06:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Subject: Re: [PATCH mm v3 00/34] kasan: switch tag-based modes to stack ring
 from per-object metadata
Message-Id: <20220912130643.b7ababbaa341bf07a0a43089@linux-foundation.org>
In-Reply-To: <CANpmjNM3RqQpvxvZ4+J9DYvMjcZwWjwEGakQb8U4DL+Eu=6K5A@mail.gmail.com>
References: <cover.1662411799.git.andreyknvl@google.com>
        <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
        <CANpmjNM3RqQpvxvZ4+J9DYvMjcZwWjwEGakQb8U4DL+Eu=6K5A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 11:39:07 +0200 Marco Elver <elver@google.com> wrote:

>
> ...
>
> > Hi Andrew,
> >
> > Could you consider picking up this series into mm?
> >
> > Most of the patches have a Reviewed-by tag from Marco, and I've
> > addressed the last few comments he had in v3.
> >
> > Thanks!
> 
> I see them in -next, so they've been picked up?

yup.

> FWIW, my concerns have been addressed, so for patches that don't yet
> have my Reviewed:
> 
> 
> Acked-by: Marco Elver <elver@google.com>

Updated, thanks.
