Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6857B6B54C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjCJWvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCJWvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:51:11 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABEC10A28D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:51:09 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536be69eadfso126583587b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678488668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LQ2HzZ5/bi/kOKo7NEBlYoMYy0KUYQz8z6lYvJaO88=;
        b=CsRc5Yj4v6oMwTHZDXSBIJu1WUd+WKnNbbnBRzECCKZQKqAeYyk3g2skIyqllyml9N
         YkuB1zIVR4Gz09ofgcAlgItEpzD2ZN3zrZZc7yQDar9fCWLsETqJzHdA++8HZbrRUGIB
         a8WLKRX6xoN+4ZGFFJKJYeERlLfRbze0ycq2elEM1zAfUoNmLjjMQf2hxremPynCPFxg
         hoIlggBNAGgThOr1cX9poKYS0U9KhEqkA54OWmkqxtTU031rj5Q2CNrhAmArdrUbC7Ze
         5B90KoNaRJHfbtbuEAW+CvZriQxfb/bCQYgh72mBblBbL39CthVhQBJKMdIBJj8aurqr
         IFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678488668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LQ2HzZ5/bi/kOKo7NEBlYoMYy0KUYQz8z6lYvJaO88=;
        b=gqY4G3unCtX0K5+6HmDIA3UZTQZdv8KqvFAPbjdJ8YjIlEGGni6kK1qri1tfVDdabz
         WWCooNeUBU1c5cIL5vpH00BSfe/lL8Lzx5OX8OC2AgWGPRygjuE9ZAm2D41Y0g5i3sYE
         qWmUzW7lq0vZDuqQ0/K5QLWdcNiIXYcXzTZ/KtQBspVv0X0LtvVrCwF5SrOrhkQ+9s2b
         x94uXrlgmSvHGeyvGnJdvljRbnlsqZVPsD86SS4f+K8xgTD7aRkAByajpOTbuawXgQHZ
         uW7C2mg9W2pNyUDtWuNqCPK+4TvNo86eAF5jOHtyUYGKJT7sfQTzR9Hh4wOucZqj3rP7
         Npvw==
X-Gm-Message-State: AO0yUKXT/hXS6rjaDRC0LSc1LylbcqAlUD5twk3NASLxPPDnxReY14+c
        lXZKMBVEW74mDLUFguIU1vYPlWx29DGdRh5ZJg+olw==
X-Google-Smtp-Source: AK7set9Vgsn5Grv4otQPAm23jXoXW/OhNMlrjQMLAs7IGnb7QimXeWnLl/d1v7+vmSUynvjW6CwEXRyAR13UOuRdqy0=
X-Received: by 2002:a81:ad1e:0:b0:540:7a8d:2ae8 with SMTP id
 l30-20020a81ad1e000000b005407a8d2ae8mr944258ywh.10.1678488668485; Fri, 10 Mar
 2023 14:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20230310132144.2241-1-lujianhua000@gmail.com> <20230310132144.2241-2-lujianhua000@gmail.com>
 <6539f132-c740-b9b6-8810-0affd6ab91ba@linaro.org> <ZAt4fTNEnyLteaas@Gentoo>
In-Reply-To: <ZAt4fTNEnyLteaas@Gentoo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 23:50:57 +0100
Message-ID: <CACRpkdavjBPaNq1sRfi-FYiT7T3W19fU-mjha0pAtooUyf-8XQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Novatek NT36523
To:     Jianhua Lu <lujianhua000@gmail.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 7:35=E2=80=AFPM Jianhua Lu <lujianhua000@gmail.com>=
 wrote:
> On Fri, Mar 10, 2023 at 07:10:21PM +0100, Konrad Dybcio wrote:
> >
> > > +#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        =
\
> > > +           do {                                                 \
> > > +                   mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> > > +                   mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> > > +           } while (0)
> > This should be in the same file as mipi_dsi_dcs_write_seq, imo
> I have sent a patch to do it, upstream don't think this wrapper is a prop=
er
> approach to deal with dual dsi and wrap all of mipi_dsi_* function is
> useless.
> https://lore.kernel.org/lkml/20230310110542.6649-1-lujianhua000@gmail.com=
/

We can keep it locally if the fight isn't worthwhile, but I will try to ent=
er
the discussion.

Yours,
Linus Walleij
