Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A681720D8C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbjFCDNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjFCDNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 23:13:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF501B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 20:13:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94ea38c90ccso39139966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 20:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685761987; x=1688353987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Usb7s3F8Xcfix1ovSHJbrYw1xUMhb/AXZoRNHGtQMu4=;
        b=bkpouXYiWv5DvZQEaOW/WHkl//foa4/btTP91qA+yLpwAEzE0YgM9ALdYSL572Bj++
         4mRXbYEcl3wP/41wCyd6POXHidubgNxO3ooDCj8hWB1/3+JvJkTDSeSUlk6SPNo52QIU
         NNl9jhEYndnd482CwXO2Htea2SrGYJBZOQ6LQPlZ4Cnozk6NazfFHM4poPDDPCkINuv+
         /yenzoAfN3uO0JbcqZXHOkahVJPpXvAN4reSRUVNZxOAmjchuyDPcKaYfGlZzpTwu/Lq
         RFWTS/AQqjfYTr4kag5c2gCC5nSqaKG4iWyp3jI5NGZd1tR2atwzyUoBX3wBoMTyDJSA
         KgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685761987; x=1688353987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Usb7s3F8Xcfix1ovSHJbrYw1xUMhb/AXZoRNHGtQMu4=;
        b=ZuA2HmTO3V4tZ6GeQYcvOFiemPBX1Av3gIL3INOwG7osyJzpK+69JCmA5UmClg5jfE
         waL6JiOHLHUWp1vdrE56wZ/XvjnxM2D9tQAaAiskXvHe9o6g7yrYvd+pMNnjkN46QWkk
         DevdKDICFrfPxaBMr2XXml60qyog6L4+0+CoeuwIpa3AoUCvu6aEN4IlsLwKSxMV6KfA
         xTsGrY7NvbHdY8K0Uzfm8wC3mEkOh5EJM8fQJn519pmOavY7dyJkf8CasTRamU8hPgZf
         Ax1JEJFTyVaiuCYyDDlePisydiOfB3BLqnE4kxjauNOsxgFGz6GKwAgZGRcHfNmnApCe
         cl/A==
X-Gm-Message-State: AC+VfDy35vNGfz9t/+4GacFCPjWcHKjqoYMaxsxowJlhqTya8IUr2BnU
        ow3Hz0wjTWTcrHIIeb8lYXPIMsVK6OAAmoux110=
X-Google-Smtp-Source: ACHHUZ5D07vBton5O5EJBgAy/2QO3MN1X4cvxATItcSokD+xAqlFk4XJXnM6Fy+xPS49b3Wp5e7yKzAAB17LJrSEx4I=
X-Received: by 2002:a17:906:145:b0:94a:5f0d:d9d6 with SMTP id
 5-20020a170906014500b0094a5f0dd9d6mr11500293ejh.4.1685761986837; Fri, 02 Jun
 2023 20:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214814.2329224-1-olvaffe@gmail.com> <CADnq5_NQ2zgvRDZ8NWUsCm-8JO6PZSEmQ+WrbjYqjv3vTLfinw@mail.gmail.com>
 <CADnq5_OmrnBhRbRZ_0thdKktNsSDG4w7dr8Vn_sbiNT2_t2UQA@mail.gmail.com>
In-Reply-To: <CADnq5_OmrnBhRbRZ_0thdKktNsSDG4w7dr8Vn_sbiNT2_t2UQA@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 2 Jun 2023 20:12:55 -0700
Message-ID: <CAPaKu7RuyPMBb2gAKCa_EhXyar8QpEEJ3zwRBP6dXdOc-VSasA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix xclk freq on CHIP_STONEY
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Likun Gao <Likun.Gao@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 11:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Nevermind, missing your Signed-off-by.  Please add and I'll apply.
Sorry that I keep forgetting...  This patch is

  Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

I can send v2 if necessary.
>
> Alex
>
