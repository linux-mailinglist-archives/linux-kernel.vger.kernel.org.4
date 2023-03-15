Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE516BA580
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCODHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCODHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:07:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281575D779;
        Tue, 14 Mar 2023 20:07:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x13so22816948edd.1;
        Tue, 14 Mar 2023 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678849659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg96jB00Z0xJAjaX35dGOvi0S0BxZfiR5lY6gXxTruM=;
        b=pcytAVu3ygryJm2ME+7AeEiL4mOWRr++QzyMQjmGY2UnI/Uff+01CJgO/L9Ircaesg
         Xa4sqC9PVIhYgoPnMu4PMBQ/YPK3pZyUGLtPc1AQBVChzkslgRSTkzn1Q8ZCDafo22sD
         nn6gW0pmSieLpa6E6LORgPHIfFsDnqo89hsJT4Gaf4GsTQXluJC5W2orm2wXsP79i/k0
         BtQeNCtXcUPsrS5fuKtM+IaDEEiBkKikLD9KC9uDBQ+ZRzp7h02+GsCif0EIxNfz8O2p
         rwtQN6RC4yIz1nBT5Unx9SNvZIjCVbzrfjlakRiapTq9a4i1OsxvbF9Qu0MWFcTWnN4w
         pmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg96jB00Z0xJAjaX35dGOvi0S0BxZfiR5lY6gXxTruM=;
        b=wV9PXOua7PRlQdKTMWzvrty/ezQcLBzmioSZCK4eFCovSdMnaGJK9SIs3MZ5zjs6Pi
         7h3W0VL+blg6OkfGWCoMJCmjtwYTMy/GIw/B/CCWUdS0ZkztQHbTZL+7wTcdiC15/ddW
         gzcXZSc+WNoYxGsDzMdRLQRPxKIHj+E4/S5pvP54PwLAcR+aRb40+X+XY33Wj+9AoNPk
         o5YBW6VQZ1UyBLJc+wJjYG0J63n/BxBt2j5n44jiFgqqJRm7V3pu9rNkj6E1MNu4lN6L
         pQr/PASe+l+zKkpXC0SmAtWnYgQqxpQfucI1qfTNdCtiImsc+V1t2g0AsjWYZt3LvS7r
         Wl2w==
X-Gm-Message-State: AO0yUKUsGvNDoVmfhoVNE3Fi8ZRPuEcNbg7WO96Gnvl2pRYssGtEG+mQ
        FIUN9KATwQb+J1GeGEqsH/LMAI2IYa8kJjs0vE2k14QvWYU=
X-Google-Smtp-Source: AK7set8ZxP3H95X9OWSv2ZecRuaPva4uZTO8mzifEhRkJ6S5Mr5ycZSYvVuHcoKIBbPHVw4J8SaScTwBqs1gH/a91hw=
X-Received: by 2002:a17:906:5619:b0:92b:e576:ea31 with SMTP id
 f25-20020a170906561900b0092be576ea31mr2163021ejq.5.1678849659601; Tue, 14 Mar
 2023 20:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230210111141.1379645-1-keguang.zhang@gmail.com> <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org>
In-Reply-To: <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 15 Mar 2023 11:07:23 +0800
Message-ID: <CAJhJPsUQN5Lo_rVUbbmGY68gorwkcQT=9AXfcEh371cP97Wj_A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Update the clock initialization
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 7:31=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Keguang Zhang (2023-02-10 03:11:41)
> > The Loongson-1 clock driver is under re-implementation
> > to add DT support. As a result, ls1x_clk_init() will be dropped soon.
> > Therefore, call of_clk_init() for clock initialization instead.
> >
> > Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguang.zhan=
g@gmail.com
> > Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguang.zhan=
g@gmail.com

Hi Thomas,
Sorry to bother you.
For fear of raising build error, is it possible to merge this patch
before the above two patches getting applied?
Or is there anything to improve?
Thanks very much!


> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>



--
Best regards,

Kelvin Cheung
