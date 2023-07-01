Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D3744974
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGANuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGANuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:50:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144EC3C11
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:50:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5776312eaddso15662757b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688219405; x=1690811405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezm+NjXf2KCPvjh2cUYvqoi17u9GLDDqaRcVx1XsiHA=;
        b=R2rNfLLxRrVBYKsSHAcBwKJVDcAhDgmgfawivAKqzoPyyh2oD0EyQ45LpLCPIoMLeH
         J4P+p6OajPIe2EFxKpAqtnr+h0e3D3yCCc2lNMll43/f+fHtX352P2NH0M0lmhn4Xiqy
         6qkJAhx14uUNv1QCv/Um85MT4x6fVvwpLHXbXo75ddeokFl/QInQ31DbPTsTi4jW0V+g
         uWsQSm0eerjNioH7ecPxv3lWqAqbdFRfya2z9oDS65B7K2PHW4SxVYJYy+ZJcMqUVOtk
         s+UVgHc69oUSNVJw4LUmrQOTloB1H1J/kYj1n3/9CbwmMayMkjlGqeegWoGtC6gPlbWr
         SSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688219405; x=1690811405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezm+NjXf2KCPvjh2cUYvqoi17u9GLDDqaRcVx1XsiHA=;
        b=G8cWwNYslmbc7e1NDtDjJmkXWSfIBGDrEFRUHwEuQYqgFVCjAzCttqvYvGvLxWxC8Z
         ORFe391y/wdeRJj49vGc7D/qMoIQ6h9/iB8E/T2Xr6uGNxo/yxDzTW1lnkJG0kAMlr65
         i9QosqvGxF/ooG+lrfAwB7HvYDKDAJOU+544+2+SePEW5ScQvIIoHQ7KVV8RE/kKoYNj
         juA569Dhvnfw4mMAAU0Qs4AM/fsMgdhtqTY0NWwXHKGzvWQEDi6ouQe+j4U4SrfIHhLj
         Ftb/l9BzShza3SugcNP03s0LouIxGT+ui/FHZRdKFMbEW710/+pHTuJC11/rNNtITUoU
         rrIA==
X-Gm-Message-State: ABy/qLZPUY9acxpCAI/xyVL834I1FixZzUm3g1cUOGiepNUBaNwnRnnM
        PLKN4IcOORoswbRoKCiTcJ29erssvF+beLADL1xXXg==
X-Google-Smtp-Source: APBJJlGXw6gZAbhK4kl28Jt3+uNyGtz1CZs/V06D3OBlIubL8fMEUnFM2hCVt33G8WUHmy8s370jcIDCaHOXRR/TDpc=
X-Received: by 2002:a81:83cc:0:b0:576:c543:2a5f with SMTP id
 t195-20020a8183cc000000b00576c5432a5fmr5543264ywf.4.1688219405263; Sat, 01
 Jul 2023 06:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <62ae6810d41e0429ebaadfac8a95409f4bc72456.1688160163.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <62ae6810d41e0429ebaadfac8a95409f4bc72456.1688160163.git.christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jul 2023 15:49:54 +0200
Message-ID: <CACRpkdYu4KWx4cgt1PFniduJb5kRmnKs84k+7xVdo3dDY=TqbQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: busses: i2c-nomadik: Remove a useless call in the
 remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     wsa@kernel.org, Andi Shyti <andi.shyti@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:23=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> Since commit a410963ba4c0 ("Merge branch 'i2c-embedded/for-next' of
> git://git.pengutronix.de/git/wsa/linux"), there is no more
> request_mem_region() call in this driver.
>
> So remove the release_mem_region() call from the remove function which is
> likely a left over.
>
> There is no details in the above commit log, but at its end we can read:
>    Conflicts:
>            drivers/i2c/busses/i2c-nomadik.c
>
> This may explain why this call has been left here.
>
> Fixes: a410963ba4c0 ("Merge branch 'i2c-embedded/for-next' of git://git.p=
engutronix.de/git/wsa/linux
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: synch with latest -next

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
