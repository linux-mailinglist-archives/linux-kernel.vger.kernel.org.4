Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EF86BA864
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCOGuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCOGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:50:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EF737F3E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:50:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay8so6564849wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMpafT88xKlGNCU+6FBCcuoiCYHFgVVLGUzm7Q0IzMs=;
        b=NxrrTPv08AXziLwHrTt5wgaiPco9c1jPTlLwj2MWzNnTfdes8QAKNd/ZsuTvnXl7zU
         jLgkRK+XYW5NSaM1B0P0bPt/JYHi5DSZVv57cKBbpOfNjgk3iUoIqIAx9PevBZcCazdS
         70PkJ6neQb6vN96/SQxFnF1UaKsqiN5w+HnG+wr9SqPGw2u9xEukTOrBD/x6G1bzDTxz
         mMs7B4hXqdjusfMbX4GyFH9rGojBodZRHrWq7cMEno/jWwPfZ+NO3mF/xmdw1pOGF5wt
         Rv0UJWrpg13R3lWbaR3ln7XapoS+T+C8PYaQedBjFub64womMF0VzkPhHRswLQfQhg++
         1JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMpafT88xKlGNCU+6FBCcuoiCYHFgVVLGUzm7Q0IzMs=;
        b=AQ+JF9XiWMN4en8EM0DYIVB3anTAys05VIWyhExN7I7tdqetT813fJG3v92R+is/HP
         rDzXxtIagichFrThnhjKPmzw5f5pnoBzgZn8zy8wjuGFn0V32/0aVUrTzjKeOUKlcGxW
         /bqVHAkTwQu/fve4xiFFGnJFTfWW0POjWZyjrVvD69h9aq8E/xlV6E3lKEiaWGoqwpy+
         vNXVXNpp0CCa+0nCFkUqO1sAnYeyh+QsSFSAMFvu271y6ZGEqhds5dBCkzTAeatZuCLU
         XuzEXc8o2XBr4JWtfoLNip28b/aAHA4u9LQROTzwAAMvB4/QCk13BeJU9sRVY/C5NGWQ
         tc7A==
X-Gm-Message-State: AO0yUKXOTMKdYlUQFWtelr2nTDMYfwgx6AOiQJzm1HVXsPaVwGei1Ajl
        ebDfspjwG925H7pZ0w7CRWU4xK+upUT8shXjDabrDVo9QOVIg7UQNOU=
X-Google-Smtp-Source: AK7set/iMi/keDqYCbn4lQWitVerTuIzZdiRHeAm6JrmOMvCzavagqYRLylzlXSWX9eYnlju4AZ2lqWlAqHoSQGSkz0=
X-Received: by 2002:a05:600c:5388:b0:3df:97de:8bab with SMTP id
 hg8-20020a05600c538800b003df97de8babmr4708604wmb.4.1678862981933; Tue, 14 Mar
 2023 23:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230222173009.19874-1-jmaselbas@kalray.eu> <CAFA6WYPGF3Q=_U-rZGyyH=ouunwT=9nx7j+pueCVS5jLng4fxA@mail.gmail.com>
In-Reply-To: <CAFA6WYPGF3Q=_U-rZGyyH=ouunwT=9nx7j+pueCVS5jLng4fxA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 15 Mar 2023 07:49:31 +0100
Message-ID: <CAHUa44Hf1YysCX8ountu5ZZh+9aFeuwupNh8Kb1fMFpAnpLaXg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 23, 2023 at 6:39=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 22 Feb 2023 at 23:00, Jules Maselbas <jmaselbas@kalray.eu> wrote:
> >
> > Fix typo Unuspported -> Unsupported
> >
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > ---
> >  drivers/tee/optee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 290b1bb0e9cd..df5fb5410b72 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
> >  #elif defined(CONFIG_ARM64)
> >         return (pgprot_val(p) & PTE_ATTRINDX_MASK) =3D=3D PTE_ATTRINDX(=
MT_NORMAL);
> >  #else
> > -#error "Unuspported architecture"
> > +#error "Unsupported architecture"
> >  #endif
> >  }
> >
> > --
> > 2.17.1
> >
