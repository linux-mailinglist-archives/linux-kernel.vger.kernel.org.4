Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7BE5FD673
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJMIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:50:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83C65A3C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:50:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id w18so2356063ejq.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Eq/ww/61kF7UEYUJquz3gQawyeedcnVNs9ttspn+Jxg=;
        b=MzFESBng0hz0sPP1i7MX53IRdqo+s6IANrM+UXWer47SlyA2kws0MuA1VCNXNVKA4u
         grEBzayKCCC67pUYT2xAxT5v4PNSTLtH+7tvrD+PzW4NhzO5In05Q9zc84BGpc54IRwD
         v1REmL5X2zSk0vLYmZZjJkC4/KM/5ImJ1gDOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eq/ww/61kF7UEYUJquz3gQawyeedcnVNs9ttspn+Jxg=;
        b=DTdlj5luam7AnY62RUVXWBbwCmI8oBKbb2kRVkaflvldcd6EBy6vnhXXm4QroILY2n
         vndn4UeMJGpEk9FMhHyYS+nk3j0KQqEsJKvPgF7+DWEu2+FeJ3XX5tOk0e985Yg6mIKz
         TONy1lEidhAllzN9zKjlesDZ+S9vV8gqeJAAK3aeT86TOMjepiopvDD0uVVFxzpQDc4a
         bL2XW8WmwZnc4Qnk2W0xml/bMwXRg4xDOQwoqKRrukPcyGPc14EsiYMGyHYwF6NgvSw9
         8Xim7B0Nwa1FEJy9mHR4+lhx0B5sNk1G6MpuP2sFfLtDbqJFuvYy68HvGmQI3dmh8dXg
         h1Bg==
X-Gm-Message-State: ACrzQf1rgYnVHRgfKdQ0BqIzCOIw8wo50z8lBEzayZj7xqchBByTeUL5
        h0nMPB773MiqauGIth/R5kT0imJzlXq4EIFPoSZtFrb2c80=
X-Google-Smtp-Source: AMsMyM7GhWNCiU4Xw0H6JLxXS6xUxkVE10ALtrZFVSH2+Giufp5J4ESRyyRvIziMdJO/0OnJasP0RYiFjlaMcOE56fE=
X-Received: by 2002:a17:907:b07:b0:78d:ce2b:1999 with SMTP id
 h7-20020a1709070b0700b0078dce2b1999mr12044586ejl.267.1665651001242; Thu, 13
 Oct 2022 01:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221013101528.4afacfe3@canb.auug.org.au>
In-Reply-To: <20221013101528.4afacfe3@canb.auug.org.au>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Oct 2022 10:49:50 +0200
Message-ID: <CAJfpegs85WbrJ8sQ5Y3XCwtSdSwjK+m5GCAkTBOEUBc1-=h0xg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the fuse tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 at 01:15, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the fuse tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: modpost: ".delete_from_page_cache" [fs/fuse/fuse.ko] undefined!
>
> Caused by commit
>
>   0d659ac83481 ("fuse: fix readdir cache race")
>
> delete_from_page_cache has not been exported to modules since commit
>
>   452e9e6992fe ("filemap: Add filemap_remove_folio and __filemap_remove_folio")
>
> Which was merged into Linus tree in v5.17-rc1.
>
> I have used the fuse tree from next-20221012 for today.
>
> Is this really destined for v6.1?

This particular patch, yes.   I posted the patch and asked Willy about
delete_from_page_cache().

Rebased my for-next branch on HEAD and re-added the EXPORT_SYMBOL to
fix this for now.

Thanks,
Miklos
