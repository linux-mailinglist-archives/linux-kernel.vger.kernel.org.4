Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC672CD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbjFLSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjFLSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:15:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D904A196
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:15:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E31C62CAE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B3C4339B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686593714;
        bh=5VVyxM283nZurXcrJu3NkFtut1FZ/yTQ9dxSE9OavyA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DKOZ6Kp1scSEhJ5dYFZKi0n5vUjPdNQ4iRD119WiyOBSPKlZLFFGPAFGFrY9mzFTX
         SCUzL9XyZT53mky/qSIW6wDoc9LrJEj1ahMve48G5Gs1cGYtbveKcYkQ2K/p8Jh80l
         40BlVVwBktZi67sc/C38GltyfbyZWS6sUCwxRIBVm3riEhzW4iIW0pt5fxMUxvbjZS
         hLnX2EPIHeTfBveLh9G5Tk2EzjdAkyXO3AFJtf0teTmEoIWdzTeIkRV6iWUzhqlmRC
         kKtgRAyM4ngRIqDiIqX5/z1r0TRWPuXlHEc0BXSRjZ1xCRzAdLhPzYPqANr8LAJ/yV
         Xn5SBiS6nxVMA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b219ed9915so54907551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:15:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDxOtbaiVGDoPRbLmqG06Zyfriar/v08Jn7Zxolq/3ZGben+Fk8e
        RCiAhKPUABd21uohEK48Jj2m826d73AINc4Hxg==
X-Google-Smtp-Source: ACHHUZ6ovfpFOeZlPP4eF2X3MviCSbc9D8V33vQx/IVpA2iO/zgsRMO0jJiIqkYTV1Duqk7AccRU4D6T3M8xYOLaZqc=
X-Received: by 2002:a2e:9ad1:0:b0:2a7:974d:a461 with SMTP id
 p17-20020a2e9ad1000000b002a7974da461mr3688248ljj.34.1686593712740; Mon, 12
 Jun 2023 11:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230410232647.1561308-1-robh@kernel.org> <CAL_JsqLeAvEVa8h3qywqESkqGG1O+9QWqA7fc1EJeDGkmAV7Fw@mail.gmail.com>
 <0ce32e34-d53b-4038-ef39-3b0f3e2f8a7f@loongson.cn>
In-Reply-To: <0ce32e34-d53b-4038-ef39-3b0f3e2f8a7f@loongson.cn>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 12 Jun 2023 12:15:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsa9KQxk6r=ZxtY30Mk5nk9ST5ejJ+8VXZ5vPJAGHMBg@mail.gmail.com>
Message-ID: <CAL_JsqKsa9KQxk6r=ZxtY30Mk5nk9ST5ejJ+8VXZ5vPJAGHMBg@mail.gmail.com>
Subject: Re: [PATCH] drm: etnaviv: Replace of_platform.h with explicit includes
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 12:49=E2=80=AFAM Sui Jingfeng <suijingfeng@loongson=
.cn> wrote:
>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
>
>
> On 2023/6/10 04:17, Rob Herring wrote:
> > On Mon, Apr 10, 2023 at 5:26=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >> Etnaviv doesn't use anything from of_platform.h, but depends on
> >> of.h, of_device.h, and platform_device.h which are all implicitly
> >> included, but that is going to be removed soon.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> > Ping!
>
>
> of_device.h already has 'linux/of.h' and 'linux/platform_device.h' includ=
ed,
>
> Would it be sufficient by simply including linux/of_device.h ?

That's part of what I'm trying to remove. Standard practice is to not
rely on implicit includes.

Rob
