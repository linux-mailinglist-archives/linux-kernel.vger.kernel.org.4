Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB274E773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjGKGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjGKGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:39:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99EA6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:39:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so80568731fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689057545; x=1691649545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elXCUTOCMTi1ImRqzrKtVg2T8j1H8DoAExvbCuJEHck=;
        b=bV+lIDNS9l71GtmTn/MBxlZNwGgvjaf398QyPfvN3943weO14tRLQ04OSKDq4E8j45
         RoxlS9CnUz9ggFbi9kCa+zwZFEzsv5tl+/fDTgeblNku1WOt7ntHM0syKcT34GGJ1A4D
         fKd92zMD+hxHC9neqX2mzTTJ9PBNhPahgjJpRiJSWawwyLtBu3HuzYVsFGwh4PyiLbjC
         Zv05i8/8Hs3jI7pLMaUK8xniRgzPs38Sgi+dOVJY/i3fSN9iBHtBHBNM0UAa7jsoFnqR
         8OGXQkZSiKVtnRDHFz8mbQtba9uKQCkjzGTjDI2IMai+4qbyrguuvdi4KlQ6LZvM8YUI
         riDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689057545; x=1691649545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elXCUTOCMTi1ImRqzrKtVg2T8j1H8DoAExvbCuJEHck=;
        b=FHovTrEiChPN0nkmV2T2Rc2mdYBcS9bxKuHH3ovmnqUaD8hP3Q+WlAqp9Cm2QpglLy
         iCiWl9tBKfBOoECDaAIlfl5HBpB2PgqWKhmUWKR812HlI2FB8VkaUzGZv3qKffWRi0OJ
         qmsicni85648LF9KW6WN0fp5bEBxaJH/c8aO/FnSY/dkhAxHgCqewcgNaqb1DCEvPkdo
         g73pCmD6OOylbjp3MZViMRtF7YPNYKAAwQZseoLNb+3/1ywBpCrtEZ1xoUgmAYilSKQS
         4MT3rydYVMC0GTGbFVbx5cc9PrXsTdnlZs+CPHiDVCLzPQbued/g5BCArb8qrFuWB5Lg
         CS7Q==
X-Gm-Message-State: ABy/qLaM+GCnHUHcE8src8OWga+JqEngD2ufTPeLNtcU59V4mLEB1Rme
        7ZXbF4TXriyn0lQ1o9rCR/YrrGh9jbk14cl/ohaO0RZMuukrdo8r
X-Google-Smtp-Source: APBJJlGpNNoFpy6/AS5QCL+upCPP64TZ8gxYYmR/GUA8O1+pECLM0aRmgpRHxbBfuPrk1WuweREZc/K8x0DKkDZVuPE=
X-Received: by 2002:a2e:98c7:0:b0:2b6:e2c1:9816 with SMTP id
 s7-20020a2e98c7000000b002b6e2c19816mr13629656ljj.20.1689057544922; Mon, 10
 Jul 2023 23:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org> <CAFBinCBT8yP5yZVOkQhkpQ0N83VO1Ctdm+npb91rLiv3KQz4ZQ@mail.gmail.com>
In-Reply-To: <CAFBinCBT8yP5yZVOkQhkpQ0N83VO1Ctdm+npb91rLiv3KQz4ZQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jul 2023 08:38:28 +0200
Message-ID: <CAPDyKFpTsCtkciaNmjm5ZXqDapHGip23FphHkd9+bqBviWT07g@mail.gmail.com>
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 at 20:25, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Fri, Jul 7, 2023 at 4:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> [...]
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -23,7 +23,6 @@ obj-y                         +=3D mediatek/
> >  obj-y                          +=3D microchip/
> >  obj-y                          +=3D nuvoton/
> >  obj-y                          +=3D pxa/
> > -obj-y                          +=3D amlogic/
> I think this change has to be dropped (see below)...
>
> >  obj-y                          +=3D qcom/
> >  obj-y                          +=3D renesas/
> >  obj-y                          +=3D rockchip/
> > diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefil=
e
> > index 7b8c5d323f5c..c25f835e6a26 100644
> > --- a/drivers/soc/amlogic/Makefile
> > +++ b/drivers/soc/amlogic/Makefile
> > @@ -2,7 +2,4 @@
> >  obj-$(CONFIG_MESON_CANVAS) +=3D meson-canvas.o
> >  obj-$(CONFIG_MESON_CLK_MEASURE) +=3D meson-clk-measure.o
> >  obj-$(CONFIG_MESON_GX_SOCINFO) +=3D meson-gx-socinfo.o
> > -obj-$(CONFIG_MESON_GX_PM_DOMAINS) +=3D meson-gx-pwrc-vpu.o
> >  obj-$(CONFIG_MESON_MX_SOCINFO) +=3D meson-mx-socinfo.o
> > -obj-$(CONFIG_MESON_EE_PM_DOMAINS) +=3D meson-ee-pwrc.o
> > -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) +=3D meson-secure-pwrc.o
> ...as drivers/soc/amlogic contains drivers which are not moved (in
> addition to the genpd drivers there's also SoC info and canvas
> drivers).

Yes, you are certainly correct, thanks for spotting this!

Kind regards
Uffe
