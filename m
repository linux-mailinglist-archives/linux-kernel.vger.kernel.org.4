Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A701C731956
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbjFOM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbjFOM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:57:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC3268A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:57:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30fa23e106bso4932106f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686833859; x=1689425859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8xh5vyd+GR/5dO/72QSwLjCc2jeYDKhssNeiXwjjaE=;
        b=FdDKhKnbG9ZKhSrzl2Z9UXln9rDc6VtMwZP8jtbQPoa+Eo4ZBTNd8Fc/B2Qv13tBCc
         SYHJXRSfhPpXGsgwBAv/3bWsBR6AoOo0uKazPaIwAidAb/APmYBFyKylxFxNn6Cs6otJ
         r8EBilxPFa3r01C4zFVau9U9pTrOdKDnBXBMvrI09RrgDhCgsaz1X5g8qRCPe+EXAzx6
         wNYQYQLHaPaz2bhP4479eRavcI2AWzScWIZpIvx1BnCZN7uvqgBllpA/19Z7fkeZSjLF
         ByAwPZ6VB4+g78KOq7KSpoYXlSi4lNns6Jq6FmZe0n3BkdLCz+b2i1H1nW536hZVG2W9
         SvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833859; x=1689425859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8xh5vyd+GR/5dO/72QSwLjCc2jeYDKhssNeiXwjjaE=;
        b=K2SQRp5S6DoSwTkVvJeDvr14AIqp2p1fxNuUFbWuEhz/Uw/LFmvmOohwH4/s0TpTil
         HHt5DjSy9CjFnaqRYsDdX3leLDbWtpBsA0mZyl3fSvXleZSIrEkaDju9aLkxKh7etifC
         Umza4k5oLRlgHX9SNGh7miJTHqYV20KAxWy13+5NvR2Ui1ngENWrQTXHWfAJ4uwNqSoH
         gGRxwa3CquNYEuMZjmm7HPgcJbwuEQJAHvylaiJjKZqr79lF3x4VgOVb3ODV3s14sCFd
         zJ//2rV4K+9hFEbvsRQs2EbhYaRN25h399emXkVAmMuWKa7bZahJqyQe58STmRiTQrMm
         75yg==
X-Gm-Message-State: AC+VfDyt1qwja8eX4V8XRkFrLJkYiPAZw+eT9JM03ADrUdidj/v7KCLN
        a0E8BNDstmP0Uq4WL55xOWRAjGbOLnehM8A6wVhp0LDnd+dzyd2e
X-Google-Smtp-Source: ACHHUZ4q6gXFkaVMc0iU3bq294NH/Y7gn9HB+thx+5YdmHhTBTFo+rOiD3uedZRA07ZTwZwQbVHW3D8TzklWGtUiPT4=
X-Received: by 2002:adf:e28a:0:b0:30f:b1e8:88a1 with SMTP id
 v10-20020adfe28a000000b0030fb1e888a1mr10246989wri.20.1686833859306; Thu, 15
 Jun 2023 05:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230613011853.6385-1-jiapeng.chong@linux.alibaba.com> <CAFA6WYO1dr_Se9AWyToZCwbxDA10D2bM_ADXLCLi8Acx+sxspQ@mail.gmail.com>
In-Reply-To: <CAFA6WYO1dr_Se9AWyToZCwbxDA10D2bM_ADXLCLi8Acx+sxspQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 15 Jun 2023 14:57:28 +0200
Message-ID: <CAHUa44G69uobzWEWUBtncViH-Xf4aXYot=y+XvQJZwqqbs-otw@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Use kmemdup() to replace kmalloc + memcpy
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:42=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Tue, 13 Jun 2023 at 06:49, Jiapeng Chong
> <jiapeng.chong@linux.alibaba.com> wrote:
> >
> > Use kmemdup rather than duplicating its implementation.
> >
> > ./drivers/tee/optee/smc_abi.c:1542:12-19: WARNING opportunity for kmemd=
up.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D5480
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > ---
> > Changes in v2:
> >   -Add one commit message.
> >
> >  drivers/tee/optee/smc_abi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index 3861ae06d902..d5b28fd35d66 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1541,12 +1541,11 @@ static int optee_load_fw(struct platform_device=
 *pdev,
> >          * This uses the GFP_DMA flag to ensure we are allocated memory=
 in the
> >          * 32-bit space since TF-A cannot map memory beyond the 32-bit =
boundary.
> >          */
> > -       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +       data_buf =3D kmemdup(fw->data, fw->size, GFP_KERNEL | GFP_DMA);
> >         if (!data_buf) {
> >                 rc =3D -ENOMEM;
> >                 goto fw_err;
> >         }
> > -       memcpy(data_buf, fw->data, fw->size);
> >         data_pa =3D virt_to_phys(data_buf);
> >         reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> >         reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > --
> > 2.20.1.7.g153144c
> >
