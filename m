Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7260D262
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiJYRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiJYRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:22:42 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150ED9955
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:22:41 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id p127so15094575oih.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnycRWzQFhXW+E+yHAOypiR1qOTxMMwn/mhojHoxaPo=;
        b=aQXTsL9NfQ6zm9GGiC7urT7nYN3RJAfmUONUTx6FytLwp5zSbDRgfbpz0SkKcQutcy
         4IiyJ3bK+iCKC8ie7Y84bwUlEgaL6ANTpS+4zD0TzLANJacQoTs3TZPB6Wm9k+YJEydU
         Ke6M/V6X9jp3zk2h2TmweOM1irSxFs7/d5EqHPwZmxxqLIqLGm6bUl1n1/cq66ojxVoz
         r7bcn30Ga46Fqa5dIdpMNE1MQLX6HB1EZMpyWGIwJdkqAuXcYX26I3VWs6G6NchoaeG7
         /49Vx7VY34jlFs8ZP8oj5TyWvP0u0CjBOmubNWu2ozkoGngbbvQzSnY2njDzn7dQCvlx
         sRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnycRWzQFhXW+E+yHAOypiR1qOTxMMwn/mhojHoxaPo=;
        b=ZR89iqS/TgzCsS51c0HpVVYdgOCnDYTxbW0eoVpdAkjSdaq0kMG1xSGGZPi642WjZr
         RFRi3YymfMPb3l7BmmRxGqFcos0DT5nN20o2aJs7PCKZA6bKDVdhur/EDjLrn+D3ebnb
         jgZB4SNf0z21LQCiL/Yez89eQU3z92qAhyZGAWUWZ9wLRJ6Y/C5vUIbF4cotXDBWxSF4
         FvsFRHni7hiPwfFoGXAyuGbhFBQ6LZwz+yu/MkoE1zWJapr5tly9/cWHIRyE84+Pb8zm
         txukNUZNxgCu5lopG8eJh+0aEl3SYfh7UnNq7xQa/6gx3ClbNBAFTrXox27d0wzn+W0d
         U43g==
X-Gm-Message-State: ACrzQf0s0FF1o3xEekxkxNP9hqXzXkSlKy7QIx+EVnYEHd8FJh9yk78L
        IYh7QtkRHGku9gAwa3YrWd6N8GFI7q4=
X-Google-Smtp-Source: AMsMyM4Y1I0byczm5I1F5DvGJA5GWyFL+U1kQRDyENq0n5dTlj7k3Hyfz7okkqqHKolh48TLkZ4kXg==
X-Received: by 2002:a05:6808:130e:b0:359:5695:bb9a with SMTP id y14-20020a056808130e00b003595695bb9amr1590412oiv.131.1666718560890;
        Tue, 25 Oct 2022 10:22:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 11-20020aca0d0b000000b0035476861b1dsm1120347oin.49.2022.10.25.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:22:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Oct 2022 10:22:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux 6.1-rc2
Message-ID: <20221025172239.GC968059@roeck-us.net>
References: <CAHk-=wgLV1tNP0EYz7qWK-xeKzO6bh5Kogbpn2wxKLPPpOit3w@mail.gmail.com>
 <20221025162441.GA1128834@roeck-us.net>
 <CAHk-=wivKoK4VgfKB8ykQUHKhNSUYA2=m4X7k8QKaizSMvzgZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wivKoK4VgfKB8ykQUHKhNSUYA2=m4X7k8QKaizSMvzgZg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:41:50AM -0700, Linus Torvalds wrote:
> On Tue, Oct 25, 2022 at 9:24 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 152 pass: 152 fail: 0
> > Qemu test results:
> >         total: 499 pass: 499 fail: 0
> 
> Woo-hoo!
> 
> That was quick, for once.
> 

Yes, it was. I now have an even better one, with a new personal
milestone reached (500 qemu boot tests):

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0
	       ^^^

... after getting yet another qemu machine to boot.

> > Runtime warnings
> 
> Oh.
> 
> Well, close enough, and those fixes are presumably pending too.
> 

Let's hope so. I think I forgot to copy the ppc maintainers last week,
so we'll see if we get some feedback on the status of those problems.

Thanks,
Guenter
