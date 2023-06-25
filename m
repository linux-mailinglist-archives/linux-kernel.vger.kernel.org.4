Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5673CF60
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFYIbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFYIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:31:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC3E78
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:31:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31272fcedf6so1877758f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687681873; x=1690273873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zulwu5Ka4QRyyzBozREdwsGz6HjqchCHL6fXDsTMKzw=;
        b=QW5XIerK545NXTIxba0OoBPzgB2WmwB3lmtN+sfYnZbAi6zuVXMKWInuvQHxyWz7QI
         t/OqZW1OUAl35aV46jxUn+XXiJI4YCGiUxbYgfJ9Xa4Ez8IjBy/jfYnJwgnlErT2naB0
         gstCq4b1ZsRR8FcSPLIo8c000Jq421mBnaR57plMQSwvmWVc8roc6FhahrYrlcu/7qTx
         pky8dv0IYewuY1a0wfds8jKHi6n7c4zdnCveH053/ycgQC1xCG8CuMXu5JavzBkxHOCD
         BNYlGEX2J+eIB8/rt/gFIWXl2wxSU7US2rAtLEr/ipRbCVdndOU6qQEKMzxcPs5lFiG3
         5grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687681873; x=1690273873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zulwu5Ka4QRyyzBozREdwsGz6HjqchCHL6fXDsTMKzw=;
        b=SUalsyRnyDUvzv0fv3k4VVXVsLL5EP0OBGsOV34jxvdbAzKl8Ij7Lc1UIc6SjFhgdx
         MLeKmei3PTsmNja7La+n2oXXqopkOomXjv1bQTuIa9yk4FWjQxY0ZQIV4LL0pkL9vQBF
         In8efTqog7lITHkNx4gur5T9hQMiU23Xv4AyNQNf1m0tIAlhNjBgcr5BO3hKfQp2J8PR
         x3r9IKURN5q+f+dXksWZz+BdmkIcdCJEnV9CJd55vtPh4yODv5XV0zeza6pDzQiws1/z
         ORNrsalNyBCymibtvYDx2igANRCDqKCLkp8pIT+gWssk3raLE0gM2yBHkbP9ufOcZYug
         M08g==
X-Gm-Message-State: AC+VfDwnDruyJax3TnvNOVJYpfOP5GmE/TtmwZ5CMFHx6dM7P+3KGrCC
        TJbzaPimbdDkVldqq2osM07FhrDetkWFfu6VaT7Hgw==
X-Google-Smtp-Source: ACHHUZ61tzMCEGJ8vHNHAQaPB0C/RSl9ncoLF+n4T3q6vhJx+GdBPTuFi+c/felvlRNRSeDkoMjuyt1j/ueQykBMKxE=
X-Received: by 2002:a5d:4c8a:0:b0:313:e55f:b78c with SMTP id
 z10-20020a5d4c8a000000b00313e55fb78cmr1652709wrs.21.1687681873230; Sun, 25
 Jun 2023 01:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230623095547.51881-1-alexghiti@rivosinc.com>
 <20230623095547.51881-2-alexghiti@rivosinc.com> <87o7l6mgxg.fsf@meer.lwn.net>
In-Reply-To: <87o7l6mgxg.fsf@meer.lwn.net>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Sun, 25 Jun 2023 10:31:02 +0200
Message-ID: <CAHVXubhk2xf59XbNiRYKdr4J1yadpeX0KMgW1cFMR4GRN97MYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Documentation: riscv: Add early boot document
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Song Shuai <songshuaishuai@tinylab.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, Jun 23, 2023 at 3:44=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Alexandre Ghiti <alexghiti@rivosinc.com> writes:
>
> > This document describes the constraints and requirements of the early
> > boot process in a RISC-V kernel.
>
> Some quick comments...
>
> > +The RISC-V kernel expects:
> > +
> > +  * `$a0` to contain the hartid of the current core.
> > +  * `$a1` to contain the address of the devicetree in memory.
>
> Single `backtick` quotes are probably not doing what you want.  If
> you're looking for it to render in a monospace font, use ``double``
> quotes instead.  But I'd also encourage you to keep that to a minimum to
> avoid overly cluttering the plain-text document.

Indeed, the rendering is better with double quotes, thanks.

>
> [...]
>
> > +Virtual mapping installation
> > +----------------------------
> > +
> > +The installation of the virtual mapping is done in 2 steps in the RISC=
-V kernel:
> > +
> > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
>
> Please don't use :c:func:.  If you just write setup_vm(), all the right
> magic will happen.

The magic indeed happens with virt_to_phys()/phys_to_virt(), but not
with setup_vm(): is there something we should do when declaring those
functions?

>
> > +   :c:var:`early_pg_dir` which allows discovery of the system memory. =
Only the
>
> We also really just don't use :c:var: at all.  Kerneldoc doesn't
> currently know about global variables...perhaps it should but that's not
> the way of things now.

Ok, noted, I remove those "c:XXX".

Thanks

>
> Thanks,
>
> jon
>
