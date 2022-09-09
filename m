Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298485B3B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiIIO56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiIIO5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:57:53 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6413866D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:57:52 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id l5so1391680qvs.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2x+xqqGT4Ml4G3qpdBsIVCu6hyaAev1tjK+isLhPiyo=;
        b=B7w97KI4QOup9CfrW1eW+fMk6tofIDUYJkbi2GROg5/Z3kjtmI2xKZe+X6otTxC9Z6
         VjHVP6Dr0/UY91JuG7n34qHyf1JI/wyZWdrMY1XuWl4hcVe7VNxAn5nQRNRI0/Gn9KI3
         ee7yKrmjYLBFU2O7DP/SLyypUEmcGq7GOrcqdUZ+1UYe1KCdR65xzdaLI+1XL5HKShMf
         z/g5tJdfKDPfpCZDp7rEZXpJk/Y30sqXM2iQIECVgylc+6IcNiz/rz6Bx368VGOCMiX4
         /XcDabzN9OJtYMjQLcAxv5FDXG4s6zL1qaRYXvaszDqi2jkTJ4ihAEy3YRLAQM3VCWZg
         /okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2x+xqqGT4Ml4G3qpdBsIVCu6hyaAev1tjK+isLhPiyo=;
        b=KvD86mfyUoW/q5FLqnByBvNNSF0KR/Gx/JbLDWTEhkA7+60K246N8Hq6iBkm3QooeP
         uZwSWwUCN2rBhGDOOrRj7olkXw3+jcjP+/Wf2aQEZE67eEjc/viBShUcrWKLvFIOrHsw
         4WWhshJcS7PaMJPSzAgCX0XbsEU9lEsOHzW5BEjIOBsRwmD3YaoXmeiKuSHAtKfc1Ze4
         NT4umdkH5COy24ivuVO1xGv0n0SecxFOTegJRfM8AkoNun/3LTRs+C5rrcsRE8GcbZQi
         I1ro6vXotlirugoZB60sa9uSrIEfZR6tNev57W0LIMUGwDbxfRBX+9GQYQLJJYVjSZTU
         E8ZQ==
X-Gm-Message-State: ACgBeo01nsu6JiOpKbpCjaBPF6+mN1TWfViXutfSnhVxaJgVHCzq3DNd
        o0lFJCrCMrfkZZYEsNKstrjo2W4m1OTvMkUmO5U=
X-Google-Smtp-Source: AA6agR6b9vbE7L0V4DiioV1Wp3d8k4meAaMN9r9zCjmgKNJaXv0m5vw4tTAKQTy92m65ieVnFTPsfwmK1/IU8ELPGzo=
X-Received: by 2002:a05:6214:2463:b0:4a5:77ee:e6e0 with SMTP id
 im3-20020a056214246300b004a577eee6e0mr12429444qvb.12.1662735471119; Fri, 09
 Sep 2022 07:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220901141307.2361752-1-georgepee@gmail.com> <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com> <YxtIiBvAGs2vAl1P@arm.com>
In-Reply-To: <YxtIiBvAGs2vAl1P@arm.com>
From:   George Pee <georgepee@gmail.com>
Date:   Fri, 9 Sep 2022 09:57:39 -0500
Message-ID: <CAKj0CMtkY_BSkAY3Lo5QbMDM1g0Wa9F8MsVuW0fyJiuPe3z4aA@mail.gmail.com>
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The details are here.  I originally thought it was a compiler bug
because it first showed up after a toolchain update.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106763

Since FP16 is an optional extension, wouldn't it be beneficial to a
user who compiled some userspace float16 code using gcc
-mcpu=cortex-a55 which ran on a cortex-a55 with FP16 extensions but
SIGILL'd on a cortex-a55 w/o FP16?

On Fri, Sep 9, 2022 at 9:07 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Sep 09, 2022 at 08:34:26AM -0500, George Pee wrote:
> > Adding the hwcap was part of the diagnosis process-- I added it just
> > to make sure that the cpu in question supported the optional
> > extension.
> > It seems like it could be useful to be able to check for support in
> > /proc/cpuinfo.
>
> Ah, I wasn't aware that the feature doesn't work on arm32. I don't think
> it makes sense to expose a hwcap bit to user in this case.
>
> --
> Catalin
