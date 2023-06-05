Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3722722C24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjFEQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjFEQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:05:26 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02529B0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:05:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-557ca32515eso3610270eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685981125; x=1688573125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmwIG2LQ/1DCImJZNs0vH8WQcLvxkVp94qeGmLp2Vvw=;
        b=k9LIBIMFTYow9c2RzFgtROLZbM8LAWprrue4ijMpkvTZO+m4Qww8P8WbJb2qgUKtKA
         iUYp4gf+nU9exVms7e8ytnM+TkbimHZMzKvbNUeC61DAP0SAhQoi0LdqNzaimwQsDKAd
         m2fMnbZgrPaD1Iegex2s93YMH7TVIfZYOsUFoS0LrHRq542H4zRzPT9OMeAGkdEm88Kq
         TzvtFwTH+GJBFwatiQuQOfqx5eT1oAT5EKRODwLRDFJvBBhOQNcXPFGnNANCr/4qLxoe
         a7Bty7xfmXgVdcJhE0ZkUW7Z3zExYw0amINQeUWs6maDGhAH3IgPvkGXUrxuulzjsH7m
         aEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685981125; x=1688573125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmwIG2LQ/1DCImJZNs0vH8WQcLvxkVp94qeGmLp2Vvw=;
        b=eXHLfwAoYcrjW7Jlxv5k8Ia3Xe7+O9yWTwvbmtXMj/r1t+5pSmnoM7i0rtka71JM5a
         JRsK9SlRLnBjuTp+IiSNtgcOzoTmO2IFdbI6WEHoxQqaVq7CzWzi3LAZd6Tne2mScFTy
         rxm9Ci4dEojfdq7O/GwjfhnQ9jd2UCvTcKQpX6ftI+XtuNjIuemoa+JBEiyBdWgATJkD
         eN9LFDUNDNcmWPh+BieYHTY2hOtvwyKFL8P+qAFZTrJtbklVmcdyGh31q9NugSTc+SUl
         SVTFHyKVvJ11JyXgMtg4sEcdlWV2OSiZa3RJcWFUewtK1woxIvA56KFBOctYcsI2l/+q
         1o7g==
X-Gm-Message-State: AC+VfDwPTtud4lEZVwApr1PJFhGcgp1dOBCk3RPmVPPBwLA595VnK/Dm
        /gtW8nA58iCoiDdw685iXqOz1SntRa+2eElS5pw=
X-Google-Smtp-Source: ACHHUZ4sg16nvaPi+jRtLM+NPeFlsdjQfLErXtZphYrUXuBh0uzRYbI3btowTEY5CeenMg9WCYmkNySM9iFSSCq8Ceg=
X-Received: by 2002:a4a:a446:0:b0:558:a104:65fd with SMTP id
 w6-20020a4aa446000000b00558a10465fdmr289579ool.2.1685981125254; Mon, 05 Jun
 2023 09:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230601214814.2329224-1-olvaffe@gmail.com> <CADnq5_NQ2zgvRDZ8NWUsCm-8JO6PZSEmQ+WrbjYqjv3vTLfinw@mail.gmail.com>
 <CADnq5_OmrnBhRbRZ_0thdKktNsSDG4w7dr8Vn_sbiNT2_t2UQA@mail.gmail.com> <CAPaKu7RuyPMBb2gAKCa_EhXyar8QpEEJ3zwRBP6dXdOc-VSasA@mail.gmail.com>
In-Reply-To: <CAPaKu7RuyPMBb2gAKCa_EhXyar8QpEEJ3zwRBP6dXdOc-VSasA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 5 Jun 2023 12:05:13 -0400
Message-ID: <CADnq5_O3iCiRVXv6ZpTa5-GP7noaaGSBG6gfaU_ABnyH=GY3qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix xclk freq on CHIP_STONEY
To:     Chia-I Wu <olvaffe@gmail.com>
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

Applied.  Thanks!

On Fri, Jun 2, 2023 at 11:13=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> On Fri, Jun 2, 2023 at 11:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > Nevermind, missing your Signed-off-by.  Please add and I'll apply.
> Sorry that I keep forgetting...  This patch is
>
>   Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
>
> I can send v2 if necessary.
> >
> > Alex
> >
