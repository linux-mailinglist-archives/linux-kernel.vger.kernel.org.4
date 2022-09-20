Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849A5BE0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiITI47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiITI4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:56:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E66B170
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:56:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id c7so1881559pgt.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=1xCkS/NtliFBAi/Unm7O+jqERrlsw7P433sZiPkri3c=;
        b=azy6gWBcH4uAn3JvvMQoDVf6XDBtjAt5NsZSWHLqsSuh4LJjSUMemhinc/jbUGQkNz
         nSjbWacmQzT0rFScKnaXXVgE/9M4fLe1q7HJ2WaujXmuSJjwS4RHp5acXPeqYF83ht6z
         BxBcRNj+t3HCeMaPJzDrr0/z0n8qxrJ34c+Py8pNW+95MahPfZ4yUIJl5ngeLToM0ZC4
         4Jsgt2sn25OJMS/SeSkqpk/D5v616MJ1BqTh/8DOxGvRLpp4EzygolAktTUGqO88/Ys5
         MXnmDRgw8Sg4Ib3mF2wZCSNf33n2NVcEL0lX8lfdJyPgWDszilpA5/AOUrC4Ab5vU4Bb
         COAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=1xCkS/NtliFBAi/Unm7O+jqERrlsw7P433sZiPkri3c=;
        b=5fhNx5WEaUgz84VOXXw6qpC6CeQdWET94vP1PsxVhNNXckfwzO4YhX1I2Zhmv5LIur
         BoyBsByQcAACRdLzWuOQGfNux18Nu8dDgBOSxWbAF4rc/iqe/11Ubgp0XK1P17vYSMwY
         qGfm0ZuerOC/IdJb+Y7ghds+l7ctLi2Sq1KOqWMpycg+Vo2YLAI5uXEtJHabhOotEPi6
         HhlB1E9COIslMhON8ULCmhHPdfwyTQV/v0xZf8AYGkTTTgXduj86Q/47xy0thWsBsIfc
         Gnwasa/44Ksctna5UD78Z3wF7eLzrbJD8Imm+FmBuq0CunuItSWRr3c7G0xft/2kU60U
         ZLzg==
X-Gm-Message-State: ACrzQf3iIdD+5gQsANPuFZxTeS9ufYxdMCVPUhpScxN0TMEWz/4CQKf0
        isnLNiAs/z7bl5g0mKa6JiIBYqZTI6ZQfA==
X-Google-Smtp-Source: AMsMyM48Yj9b5Zqz62ykAeM1jQWHvPRvE0b7QwL9zrD02o/110sRTUMvRa0KxyX0KGZe86Bc2XWSAA==
X-Received: by 2002:a63:88c8:0:b0:439:494d:fd10 with SMTP id l191-20020a6388c8000000b00439494dfd10mr19078526pgd.201.1663664214258;
        Tue, 20 Sep 2022 01:56:54 -0700 (PDT)
Received: from localhost ([203.219.227.147])
        by smtp.gmail.com with ESMTPSA id a2-20020a1709027e4200b001754fa42065sm868869pln.143.2022.09.20.01.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:56:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Sep 2022 18:56:49 +1000
Message-Id: <CN13QQX0NEA2.M6SABG46NYYN@bobo>
Cc:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 06/19] powerpc/cputable: Split cpu_specs[] out of
 cputable.h
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.11.0
References: <828f6a64eeb51ce9abfa1d4e84c521a02fecebb8.1663606875.git.christophe.leroy@csgroup.eu> <a44b865e0318286155273b10cdf524ab697928c1.1663606875.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a44b865e0318286155273b10cdf524ab697928c1.1663606875.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 20, 2022 at 3:01 AM AEST, Christophe Leroy wrote:
> cpu_specs[] is full of #ifdefs depending on the different
> types of CPU.
>
> CPUs are mutually exclusive, it is therefore possible to split
> cpu_specs[] into smaller more readable pieces.
>
> Create cpu_specs_XXX.h that will each be dedicated on one
> of the following mutually exclusive families:
> - 40x
> - 44x
> - 47x
> - 8xx
> - e500
> - book3s/32
> - book3s/64
>
> In book3s/32, the block for 603 has been moved in front in order
> to not have two 604 blocks.


>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/cpu_specs.h           |   27 +
>  arch/powerpc/kernel/cpu_specs_40x.h       |  280 +++
>  arch/powerpc/kernel/cpu_specs_44x.h       |  304 ++++
>  arch/powerpc/kernel/cpu_specs_47x.h       |   78 +
>  arch/powerpc/kernel/cpu_specs_8xx.h       |   21 +
>  arch/powerpc/kernel/cpu_specs_book3s_32.h |  607 +++++++
>  arch/powerpc/kernel/cpu_specs_book3s_64.h |  488 ++++++
>  arch/powerpc/kernel/cpu_specs_e500.h      |  135 ++
>  arch/powerpc/kernel/cputable.c            | 1877 +--------------------

This series is a nice cleanup. No comments yet but kernel/ is getting
pretty crowded. Should we make some subdirectories for subarch things
like mm has?

Can do that after your series. Probably requires another merge window
to do it.

Thanks,
Nick
