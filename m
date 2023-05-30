Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17BF716828
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjE3Pzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjE3PzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:55:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC4C7;
        Tue, 30 May 2023 08:54:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b2a2bf757so274003785a.2;
        Tue, 30 May 2023 08:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462098; x=1688054098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s5DlRI1Ww8WGRfLlLIBGkH5nMkMdXv1f8qiMvf3a2w=;
        b=lEznzOIFWCa9WlNKlX46MRWcJJvy9TkfKRc1KqK23dKijDQzLkamUrD9Z8Jo3mRV0V
         MDx2m/lxlRTFwdc0m6aRWOxqeIXGkVX86ewSkeGNTotOyYcpgW1kcLLI84ho8EVpHbVx
         qlPY08S5BqCsAB88qdleNfdchdxDeviwfPr0H2rRPiofoqRxm4mLoEIu5XJJPvMn2WhY
         ORmxLzsLLt4yxYvKPXmIYdFjz6Id4fvTyga6s7d9BYreoSWQRYhyRsREze1kaoDTKkyv
         E1c7z9KRFt9mmtu6NVfPGPvvQGlpGIn3zij2gHrIzJ7PIOAmDrJySgD5CQuoiPvTT4WJ
         i6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462098; x=1688054098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s5DlRI1Ww8WGRfLlLIBGkH5nMkMdXv1f8qiMvf3a2w=;
        b=T5qb84k2MQqiL6HO/86m5KgTmPiwuqxMxNyl8822nWLwUArkf1+dVahyEjsZqclrHG
         sncS2S9Pi6P8jCQsp2UciWhNMqNRAGjEFB4axa+lrgPlV8LirSlz43FV6dJgX5VsLrbb
         lJDHAJlIEpsXNFuHY0+TvI5hQ7yj4QhiG0ZIyOmJE5wowKiN9XcZYxT4hKgUvO6+yakv
         G8m5kVqCZrPGP4ovTfyGjmfijGmZ3i2kP7KR0xTfRKSWCSFiOUGipUKcHx8RpkP2c6XF
         ymT/Rb4u+78O9loA0DSHLt4acoGEpsxtDk1V0eKKvalFDwg1WsVrIdHhnxNP9KHyR1q+
         ywCw==
X-Gm-Message-State: AC+VfDy0FlkErgwLF1N5sUKmPXRj5mISgB5fRRr5Xq2A8DIPB2WP6tfW
        8qnNhCkuiosgZLAa/CZJOCYXS8uuWNOBNSsc/vo=
X-Google-Smtp-Source: ACHHUZ5H2+h/6gsqWP6ovqBCWYLBnTOUhomZBQgQatSvOvmMPSqJ7RS+6sbm/47VFlSpJDCggsxisegmKNpKtCoO9l4=
X-Received: by 2002:a05:6214:1c09:b0:626:24aa:87ef with SMTP id
 u9-20020a0562141c0900b0062624aa87efmr2599319qvc.62.1685462098230; Tue, 30 May
 2023 08:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517160326.10732-1-osmtendev@gmail.com> <35dea714-6a0f-4673-fd33-23644ea85d33@linaro.org>
In-Reply-To: <35dea714-6a0f-4673-fd33-23644ea85d33@linaro.org>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 30 May 2023 20:54:47 +0500
Message-ID: <CAK6rUAOn_+WSqc8R94deSsZHHwJaJLL2LxFGv929bMj7foCcGw@mail.gmail.com>
Subject: Re: [PATCH] lvts_thermal.c: Fix error checking for debugfs_create_dir
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After Reading more about it I also learned about this and I was
planning to send a patch to remove the error checking for debugfs
API.Should I send the patch for it?

Thanks
osmten


On Tue, 30 May 2023 at 20:47, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 17/05/2023 18:03, Osama Muhammad wrote:
> > This patch fixes the error checking in lvts_thermal.c in
> > debugfs_create_dir. The correct way to check if an error occurred
> > is 'IS_ERR' inline function.
>
> We do no longer check debugfs functions return values.
>
> eg.
>
>   https://www.spinics.net/lists/linux-spi/msg37903.html
>   https://lore.kernel.org/lkml/2023052835-oxidant-doily-404f@gregkh/
>
>
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > ---
> >   drivers/thermal/mediatek/lvts_thermal.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/=
mediatek/lvts_thermal.c
> > index d0a3f95b7884..61386be78fa0 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -188,7 +188,7 @@ static int lvts_debugfs_init(struct device *dev, st=
ruct lvts_domain *lvts_td)
> >       int i;
> >
> >       lvts_td->dom_dentry =3D debugfs_create_dir(dev_name(dev), NULL);
> > -     if (!lvts_td->dom_dentry)
> > +     if (IS_ERR(lvts_td->dom_dentry))
> >               return 0;
> >
> >       for (i =3D 0; i < lvts_td->num_lvts_ctrl; i++) {
> > @@ -197,7 +197,7 @@ static int lvts_debugfs_init(struct device *dev, st=
ruct lvts_domain *lvts_td)
> >
> >               sprintf(name, "controller%d", i);
> >               dentry =3D debugfs_create_dir(name, lvts_td->dom_dentry);
> > -             if (!dentry)
> > +             if (IS_ERR(dentry))
> >                       continue;
> >
> >               regset =3D devm_kzalloc(dev, sizeof(*regset), GFP_KERNEL)=
;
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
