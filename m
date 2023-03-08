Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C956B14FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCHWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCHWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:21:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC33B1A65
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Ud6uuT6gLo6urdoTho3aQuDaEhmT6aTvtOe/zvNUFxM=; b=uG4bExi6WU8b6kgsvKfrPLGWy/
        j+Dgne2r0wPDpM/v9hTiZYwQY8hg9U1audxfZjwLjIJ+1yNRht+fj9+tXelAlZbhbMvRNTZsre/0n
        w1e8gRkCHMpIgIByVH8rXn7Imx43pdopvkgVSQaHQTaUkjiuN6hzoPsIMMtYx7BWgkilv3/5niKzB
        MSMGB/RKKcA27K1U9aSWxj15u4cTfcqLZVw3DTlEztaEXPWZHEdbi9iQbuYTIPJ02YF9CM88HT5hu
        we5d8+U9qBEIjv0la5/ydEAmgL8YxY5wY6278fnBpRjhfgeMqchgDe0NdckUohk+T4gmSSF4ZWWF9
        jJ/y5l9Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pa29t-006x4Y-AS; Wed, 08 Mar 2023 22:21:17 +0000
Date:   Wed, 8 Mar 2023 14:21:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] shmem: add support to ignore swap
Message-ID: <ZAkKXaaY22/Ebdxm@bombadil.infradead.org>
References: <20230302232758.888157-1-mcgrof@kernel.org>
 <20230302232758.888157-7-mcgrof@kernel.org>
 <CAJD7tkZOPbCEb_5VvmEyimcDmpaOxe9dtmuenUH3mwVADH+RSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZOPbCEb_5VvmEyimcDmpaOxe9dtmuenUH3mwVADH+RSA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:03:57PM -0800, Yosry Ahmed wrote:
> On Thu, Mar 2, 2023 at 3:28 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> > index e77ebdacadd0..551b621f34d9 100644
> > --- a/Documentation/filesystems/tmpfs.rst
> > +++ b/Documentation/filesystems/tmpfs.rst
> > @@ -13,7 +13,8 @@ everything stored therein is lost.
> >
> >  tmpfs puts everything into the kernel internal caches and grows and
> >  shrinks to accommodate the files it contains and is able to swap
> > -unneeded pages out to swap space.
> > +unneeded pages out to swap space, if swap was enabled for the tmpfs
> > +filesystem.
> 
> Nit: s/filesystem/mount to make it clear it's a per-mount setting?

Fixed this and all the other typos you addressed, thanks!

  Luis
