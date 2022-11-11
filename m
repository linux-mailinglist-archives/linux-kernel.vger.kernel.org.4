Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF266264B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiKKWgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:36:38 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABAD6713B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:36:37 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id c26so1823508uak.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y14SvCt3WkV61w719xQpLmfaxX972HWTaoEASWzbxw=;
        b=ccILGE7efpG+za2PGnAtlj+Eq9I+J9ZyRsg4hnHWwZm6CjQT0GdHs1GhXctuinHWkA
         awGbJE/ir58GdUmWBc7KJVwr5+pqZu92icX15uW5miYnf+zdDTDtJsCvMZZ5xd5oBLrq
         V8BU5FJ+ZjHDQHZ3cl/atWAGfYanM/Dbnq2gCSJC54QkUkeZoKexI/cQHPXm/1wmheCM
         zrp92bGgjb+HFE/H8NUwZ0GPyFhUO3mZsoK3C9/L8twyoNrAHv9hPJLB1dLH1PdRFMvj
         RsPQ0OWPS35j7y5YfNst83OhgKehsWQuj9jRUuPQZRqmhJ7kcFCGDjPmw3Bp4k6MVUBE
         NBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y14SvCt3WkV61w719xQpLmfaxX972HWTaoEASWzbxw=;
        b=cF0Yx+VNNF51nO71tnD1pY1CZ9FTTNguMC+4OHzemc6noUl6ZCHQLukF5kRnPC+klJ
         cagNBc19VOM9b/S9L2Xsjlj+RsL8vEC0TdvwqUmFeYhHblo1lAvWbR8Z5U548x1WGuYp
         GjVlSLfQKVsmGiLbdp1gGsGRnA5elZthxQX8M3wY3yb3VPBUcZFo7AQfNaecee/iO43+
         H7GlUjgMPmyJhz2NB3bL0t7HN9RyHW9sc8giqw1+SGjB8o2m/2v6zv8JKEGQpZ5P+lc4
         +fvlIoJqB/Ok+oFQlmnX+S4Pft6uBotfgb0lYIwoKIuUg5K/c/AuYVX8cHGv3vg5cZMO
         ZOXQ==
X-Gm-Message-State: ANoB5pmAYRVZD5Y5Bg4QWzFXsbnHDAApPeTAIMfaMWHiW4ykJ5faLVPd
        n8XO38vHrma+wlBJKVhjMKabVo0SC87e18+d7V6ajFBJPfg=
X-Google-Smtp-Source: AA0mqf7dkWkUnS/6Cu96O0+y/JKnUJlFiSpS41qu/zcfB5sIFTPFE0pNQ9eL/jHCnDBXd/NQTvs60eXgJqHPP6fz+7g=
X-Received: by 2002:ab0:7384:0:b0:411:1606:21bf with SMTP id
 l4-20020ab07384000000b00411160621bfmr2062957uap.12.1668206196852; Fri, 11 Nov
 2022 14:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20221022225637.1406715-1-jim.cromie@gmail.com> <Y20+PqtF+dFAe7hX@kroah.com>
In-Reply-To: <Y20+PqtF+dFAe7hX@kroah.com>
From:   jim.cromie@gmail.com
Date:   Fri, 11 Nov 2022 15:36:10 -0700
Message-ID: <CAJfuBxzbSkGHdr+r35ZQ1aGhfqQS6bv8_NSbQY6ptsu0qLKCKA@mail.gmail.com>
Subject: Re: [PATCH 0/2] RESEND vmlinux.lds.h tweaks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:09 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 22, 2022 at 04:56:35PM -0600, Jim Cromie wrote:
> > hi Greg,
> >
> > this time w/o the stale patch 2.
> >
> > These 2 patches are "no functional change", but they are a simple step
> > towards de-duplicating the repetitive columms in the __dyndbg section.
> >
> > For a DYNAMIC_DEBUG=y kernel with 5k pr_debugs/drm.debugs, the
> > footprint reduction should be ~100 KiB
>
> Cool stuff, let me add it to my tree and see what breaks!  :)
>
> greg k-h

very good, thnks.

on a rev2, I'd change _s_ _e_ macro vars,
maybe _BEGIN_, _END_, or _1ST_, _LAST_

and maybe expand the commit-msgs for more explanation.
