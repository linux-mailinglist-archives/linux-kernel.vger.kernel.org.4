Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DAD710D78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEYNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjEYNmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:42:12 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BF1194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:42:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-56190515833so8184427b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685022130; x=1687614130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnG6Y0IkjRC+xsIGYgvUWotRP5vSWqfQin1m7Vqzl+Q=;
        b=A0gGlkaoUyC51HiKT+sCwopfPgRLO/zbYFHsZREc34UN5l0U50VA2C7WbPqQdRNmiw
         dR+UZ8Ar2aT5oRBt+f1Xqy4YU/brDH4AGJrRfcEzQUI6Hf1hBjxupWv9xzQ50XCZfV1d
         F+91EwWiCl+OtRywLSvbmMXJMLe3C+wmPz98ed65lTI+1ISXBDQ9707JhewqqrS+P8RE
         0P0ceE4d0A/u4GjmH2VgTs1J/+TvHQ7pi78MO3dENtkWAe1GKtX0oAfXw3eBZC27dBwu
         PQhKTGaaY2rhgatuNqBRJam5kp6fNt9jBKPBA1vgnrAtEKvjJ8XZ2HTrUqLE2CbEl9M0
         ajnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022130; x=1687614130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnG6Y0IkjRC+xsIGYgvUWotRP5vSWqfQin1m7Vqzl+Q=;
        b=JykoXt6c0J+VUcxuVx21a7DFzFJ6PNRUmYhfcpXmDCCChyXsaAPED/mfWHfo6GkDGi
         pXJTksJ6ucNIBbv3VCaTIsc7luQj6Mt5zrx/jFtrayE4GgZRUxpBrR4LFsPVKV+91fwZ
         z6/EanpAgZDq8brOtq672rhfKMpj+QvlkEsowJc4zSprVDV9Jkru7sCKyug6aA1s1i+k
         Rv09LHzjqeDaR1JRMCBAkmgGSV2C9jId3/SGsL6pL4C+jhcnMObRTDqwQMhXpc/van78
         DEqJGVbodwlGK7yjajGiQq3sdEmUfgQlyt0e0XNw1auJt1FxaaVHkkjhLwn7FHsT1jQy
         nw2w==
X-Gm-Message-State: AC+VfDyqWeErIll1suad2ipqjr9/P9Xa7z2pWdB+neLQTxOVbLhUh57h
        o1ftiyYPciv4khRoVRICBTWO1xpyXlS5MsbS7fBE1A1aW9pjQlMl
X-Google-Smtp-Source: ACHHUZ6BTIEaLVAcq9ramx4EpoO0jRq+5+ZKW8MlnCM75osqLzXGJ6qlJNZHHoFN2nqQOfZeKTBa4Upd84pA3+wFQ/s=
X-Received: by 2002:a81:a1c6:0:b0:561:89f1:6bb with SMTP id
 y189-20020a81a1c6000000b0056189f106bbmr3129173ywg.6.1685022130027; Thu, 25
 May 2023 06:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230525092202.78a1fb01@canb.auug.org.au>
In-Reply-To: <20230525092202.78a1fb01@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 May 2023 15:41:58 +0200
Message-ID: <CACRpkdYUPmaBWDwH_ARHp-bFtpML3aShd_mKBBq+ndQATGEJjQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the asm-generic tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 1:22=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:

> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>
>   b1e7601203a8 ("arm64: vdso: Pass (void *) to virt_to_page()")
>
> This is commit
>
>   b0abde80620f ("arm64: vdso: Pass (void *) to virt_to_page()")
>
> in Linus' tree.

Aha Catalin ACKed it and Will picked it up, perhaps Arnd can drop it from
his tree, albeit it is not a disaster, I am surprised this was the
biggest fallout
we've seen of those patches.

Yours,
Linus Walleij
