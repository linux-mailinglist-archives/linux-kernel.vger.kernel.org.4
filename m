Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CD655D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiLYMHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiLYMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:07:39 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C6130
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 04:07:38 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-45c11d1bfc8so122980847b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKTQU6JpYT/i5Ge3ms9B5Uj7VN4LVhAh6fCSSObj+sc=;
        b=t3E2z8YQO7Chfw3KwTr+LNsg7PTaNF52eqrqdBYBkzM1tA4UQrsAclrqVSDjXCuD3O
         y5kjlu2dfzHHhfK3NwbUMG7U2XZFrFXl3MhCwWTvZCcoATjtSUfYkILJSqfA6JD4lX67
         T3KQv9/+BH2C4+stqsYdcez2W300sxdvo1PrXTgJg98Bi2Fz+K7wjUY6DU0CPKioTJm+
         2BUIYFZfXGe717FXUA50jUcjFI2AoA4NmI2KYHYQcYVLFiC8z8fArRUZ1FI6yoRYwEgQ
         iVZJeu58k0B+DM3QioyTSx6WHidCkuXcBXKHNN4ZGuRDyvj4oaV87FpWPPDSt+HbumVJ
         +3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKTQU6JpYT/i5Ge3ms9B5Uj7VN4LVhAh6fCSSObj+sc=;
        b=aUugfSv23IDWZ6iIVdXvVg7T6MpDTMYqn3dDDcJ/LKTbSE7Oc78N0aHbbPr0CCYMia
         JS967GEgGuBVtby5fgRCjVZuUcwxT0Zpw5+1sNUP7JWCenwjiuET5xNJXdKbC+p6U5m+
         EFDkht88eL0iGqQriplVeMz5xEnyHyoHlost2H6bMdVf1hEoNJCfNSpYC6P3VpleHfw2
         R04wz+Zkfsk3H9rimIy6qm+DLza/iEnQZH0YU6Dn6vxyoLwRBbjVRL/0/N1Qk0gIE5mL
         10O7k7eo8X9x8i/H0ouMcR5MS0uz2Emm6RL1KAGAeOLxERtITJU2Y3ehppnfbwSFWCnb
         QglA==
X-Gm-Message-State: AFqh2kp66Lrinr0+UKXKT3xXReAGy4CrNlM0SuyWLErIuq+5Q0vlQ7UO
        UyQ+VNcyjFOUMc/2NJW5d9V4U96uxtBXkoyfT2R4gg==
X-Google-Smtp-Source: AMrXdXu9DkaN9Y80+F8H02K1xM663fXeLzgYkxqYtnCcRfU0jLJ0G9d/MxK3qm5Et9wUWnmTmGnB26hq2K567oTY0Ys=
X-Received: by 2002:a05:690c:80c:b0:46d:89d7:498f with SMTP id
 bx12-20020a05690c080c00b0046d89d7498fmr613972ywb.461.1671970057918; Sun, 25
 Dec 2022 04:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20221223132235.16149-1-anand@edgeble.ai> <CA+VMnFz8nQ2DnD6L9cPmoRqk+uohRqTEpak9g=WGJnSBoONmrA@mail.gmail.com>
 <CA+pv=HP8ckG8dsh-uZ6=k2nMGDGbw3gnh2b1ZWV31mzuYsjNig@mail.gmail.com>
In-Reply-To: <CA+pv=HP8ckG8dsh-uZ6=k2nMGDGbw3gnh2b1ZWV31mzuYsjNig@mail.gmail.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Sun, 25 Dec 2022 17:37:27 +0530
Message-ID: <CA+VMnFwGHk9OEZWjxWUqGqzwrxgRqy9VZ+tP2Ada5ErPo_dSVw@mail.gmail.com>
Subject: Re: [PATCHv1 linux-next 1/4] dt-bindings: net: rockchip-dwmac: fix
 rv1126 compatible warning
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     Anand Moon <anand@edgeble.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2022 at 02:54, Slade Watkins <srw@sladewatkins.net> wrote:
>
> On Sat, Dec 24, 2022 at 9:30 AM Jagan Teki <jagan@edgeble.ai> wrote:
> >
> > On Fri, 23 Dec 2022 at 18:55, Anand Moon <anand@edgeble.ai> wrote:
> > >
> > > Fix compatible string for RV1126 gmac, and constrain it to
> > > be compatible with Synopsys dwmac 4.20a.
> > >
> > > fix below warning
> > > arch/arm/boot/dts/rv1126-edgeble-neu2-io.dtb: ethernet@ffc40000:
> > >                  compatible: 'oneOf' conditional failed, one must be fixed:
> > >         ['rockchip,rv1126-gmac', 'snps,dwmac-4.20a'] is too long
> > >         'rockchip,rv1126-gmac' is not one of ['rockchip,rk3568-gmac', 'rockchip,rk3588-gmac']
> > >
> > > Signed-off-by: Anand Moon <anand@edgeble.ai>
> > > Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> > > ---
> >
> > Please add Fixes above SoB.
>
> That and, shouldn't the Signed-off-by: tags be reversed if Anand is
> sending this?

Agreed, Anand will resend the patch with SoB removed. thanks.

Jagan.
