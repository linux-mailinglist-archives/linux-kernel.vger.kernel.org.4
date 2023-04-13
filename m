Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09116E15AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDMUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDMUMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:12:19 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097471FCC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:12:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5491fa028adso627964467b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681416738; x=1684008738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huT4FujcHXScyzhCCiWxC6Qo3dKvB4TLtzgLZuY6bg4=;
        b=loF2Zs/MUL5DZEttkHR48HL2G4xLa7co1JZa/ZjsBPFQ94c2xdNrhQdAVvBxoYq1rU
         lH+xnCOZe//rfTcRCgZb5PR2dsQAKsf72k9TViqafM5wtRFdrJ2dihjPAywS30NEN1LJ
         gj2yEiEVnZ9d2U//PgtjyxWF7DUTOnRQ6igXlwfy+2NwbVxCtrCSWt54xRZZAvqLletA
         8QQwxTskeQseWSevoIv235O8iagmTnWehYeDlZ+B4RN9CWBKNiHEe4pVn4ZftvLhvWXp
         tqXYrZ8CytHTnpNa/tewuMt3e1wbCVOkb9TKRNZ1vr0EHrDXwoYqXiwjaEAyFaWUw8qM
         yw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681416738; x=1684008738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huT4FujcHXScyzhCCiWxC6Qo3dKvB4TLtzgLZuY6bg4=;
        b=U23AEbzC7mmbevn0ij05LBhfwhd3mM0fVZYs1Sqf0H//ccZP6OmATvfYdYAxj2enaW
         AofFSh/QiXsHxlf3i6dzPo5U5O1FYwj7yEVj9gBpjqA/8qeecAye/hq97kxubbzx48b3
         pYX9zv2nyEQsMTzR3ooLN/AF1oyzxERLykJgIlWn7XiT+NUEISIhJ/GPZIwjxs3Vtcn7
         NRFRt+PfsbVEh40mRPap3lzR8TVtUnH9e//iL1Yoof3xrj6FX40yc4KspwPCkHOdNQz+
         hkGcW2Ks1WpCVtLPRRh2/FaN1gYL0sQ2uWMcFPOqHM3U1IfaHiTxp5vVgni9ogMtwp/B
         NCMQ==
X-Gm-Message-State: AAQBX9eYr9LeFRnMJRBInGXwKhEsh9FLpw0aA2VS35BWN8xTY5tTOo2N
        Y/0N34BLfPRTdO651s3KTS0NRuHRIVkDT7izO6uenn2gXvW5+77X
X-Google-Smtp-Source: AKy350bJXLu0gVkdee3XTye1rjXA9u/btZu7MnQNaZUQ3umViEaPtAxZrgeXwB+pnPtVn6JPDmnFmoHbMCAWioBMEUQ=
X-Received: by 2002:a81:e503:0:b0:54f:40fe:10cc with SMTP id
 s3-20020a81e503000000b0054f40fe10ccmr2233268ywl.9.1681416737751; Thu, 13 Apr
 2023 13:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <37694343f8b89dc0469d4a1718dad8f5f8c765bd.camel@linux.intel.com> <ZDJtc7C6YBgknbTq@gondor.apana.org.au>
In-Reply-To: <ZDJtc7C6YBgknbTq@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Apr 2023 22:12:06 +0200
Message-ID: <CACRpkdYnXdFky0z0EEsmbQ5hbs=J=oRb+3vAcuDpWaLTh1kxmQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ixp4xx - Do not check word size when compile testing
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>, clabbe@baylibre.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 9, 2023 at 9:47=E2=80=AFAM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
> On Fri, Apr 07, 2023 at 02:37:44PM -0500, Tom Zanussi wrote:
> > COMPILE_TEST was added during the move to drivers/crypto/intel/ but
> > shouldn't have been as it triggers a build bug when not compiled by
> > the target compiler.  So remove it to match the original.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202304061846.G6cpPXiQ-lkp@i=
ntel.com/
> > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > ---
> >  drivers/crypto/intel/ixp4xx/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> We could also fix it by making the BUILD_BUG_ON conditional:
>
> ---8<---
> The BUILD_BUG_ON preventing compilation on foreign architectures
> should be disabled when we're doing compile testing.
>
> Fixes: 1bc7fdbf2677 ("crypto: ixp4xx - Move driver to...")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304061846.G6cpPXiQ-lkp@int=
el.com/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This fix is more elegant I think, as it keeps the compile coverage.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
