Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2786949C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjBMPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjBMPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:01:26 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4FF1DBA4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:01:09 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C46F3F11B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676300466;
        bh=o5JzMwOKW+2dlPWOvDNfJRa9ASUKbSbD6R5eHASFS8s=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=pbVqUYp5EDrJaFp/vjsAAghdMkzATMJ3YEc7k1H3olHop8NqF4lr1P9dlOYfw8qTp
         siELiP1LWo40MUkTT3EDY1kEFhcwwwz8vAoaNQOMVC61M4EZEuDzIF6Ns3L/kcanOu
         giaC/yHgkBxXQDIYw+KxJA3OksO1OmO5Hidt+ytJESBCtxIDv/OyUXdJZSM7hNYFvg
         LH38c+JmnSNuAPYkX9XTnaTfV71jKPMbSVainiV/NtyUxAi7hHQmYuWI7OHS28iQRe
         CdmcwbMy6d9nnW6LAKdUJXogqYQjMgt0BM+W0UW7DNjGlKYAeZAVlimj2X9MN/Xt8P
         2Uo1483Pkw4UA==
Received: by mail-ed1-f70.google.com with SMTP id s20-20020a05640217d400b004ab46449f12so5736105edy.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5JzMwOKW+2dlPWOvDNfJRa9ASUKbSbD6R5eHASFS8s=;
        b=FFl4ca+m4GWfyVCAqYwwzzOEjxbR49dmy29d9mX8Tw/HT++vrt7V6mZsdv6kOflnpV
         dqTcW//+JhWrLX7UHbsiZuv4eU7g4Ls9yE58cFGfUy8ZeWE7YlY5NJ6p4TF/Fa8vTsWg
         fMFraveQMXUx71y8lUPgSt3lARYQa7VnAlpdszZ6zG4bZds+3X67/zkfykl3MwyLljWa
         SAGVCH6RBWOvnVAKhqUbHmBZT/9zRKzAT1pm4jYCF03j+nIP2UpzExnQ4iBub1mNAgEC
         tmZLgG4xpU9INPbHToP6cvTzHcIj5/cohH9l6eDySAD+bI1CkawzkQqSj22nn+6G6N7n
         QXjg==
X-Gm-Message-State: AO0yUKUBCX3d87JYdrmwO9Gzs/GFa6ZxuI2IekbEWM/Q6bZvHLR/oS26
        1mtXl/Mw95TMfKct7qr8v/ZQiibIn9d8v5tNmCf8v0Xkjx7b6xU2zMm9yHmQ87MdJB8YuTwugHc
        FAR4sql2m0DiEtOU7G79EM/nuJ+BbSl1LoXgMw5C5nQ==
X-Received: by 2002:a50:f611:0:b0:4ac:b3ff:866a with SMTP id c17-20020a50f611000000b004acb3ff866amr9387926edn.24.1676300466335;
        Mon, 13 Feb 2023 07:01:06 -0800 (PST)
X-Google-Smtp-Source: AK7set+60e14qkSzS0RxhL6/FXZjLzPukCKBGT4oVZL9k7yilV1xGdz7c911teLM/7YlaPomF5m2uw==
X-Received: by 2002:a50:f611:0:b0:4ac:b3ff:866a with SMTP id c17-20020a50f611000000b004acb3ff866amr9387917edn.24.1676300466149;
        Mon, 13 Feb 2023 07:01:06 -0800 (PST)
Received: from localhost (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id b30-20020a50ccde000000b004acb890553fsm3728198edj.26.2023.02.13.07.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:01:05 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:01:05 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Eric Curtin <ecurtin@redhat.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Martin Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: fix regexp in scripts/is_rust_module.sh
Message-ID: <Y+pQsfNiLkspVIK2@righiandr-XPS-13-7390>
References: <20230210152622.92912-1-andrea.righi@canonical.com>
 <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=FZtNmYvbb-YPHmQ=bm8rH8VO3M9nemT4i03g9A2PD2Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 02:19:38PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 10, 2023 at 4:26 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > nm can use "R" or "r" to show read-only data sections, but
> > scripts/is_rust_module.sh can only recognize "r", so with some versions
> > of binutils it can fail to detect if a module is a Rust module or not.
> 
> Do you know which versions? If so, it would be nice to document it here.
> 
> > Moreover, with this patch applied I can also relax the constraint of
> > "RUST depends on !DEBUG_INFO_BTF" and build a kernel with Rust and BTF
> > enabled at the same time (of course BTF generation is still skipped for
> > Rust modules).
> 
> Even if that build succeeds, can you load the modules? i.e. the
> constraint was there due to
> https://github.com/Rust-for-Linux/linux/issues/735.

This patch simply fixes scripts/is_rust_module.sh to recognize Rust
modules from "regular" C modules with certain versions of binutils, so
that BTF generation is properly skipped for Rust modules.

In this way both C and Rust modules can be loaded correctly (at least in
my tests I'm able load both with CONFIG_DEBUG_INFO_BTF enabled).

I haven't dropped the "RUST depends on !DEBUG_INFO_BTF" yet, but I think
with this fix is applied we can relax this constraint.

-Andrea

> 
> Also Cc'ing Daniel, Eric and Martin since they are the ones working on this.
> 
> Cheers,
> Miguel
