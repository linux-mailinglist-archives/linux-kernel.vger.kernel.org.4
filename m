Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B90714D72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjE2Pwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjE2Pwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:52:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE192D2;
        Mon, 29 May 2023 08:52:45 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af1822b710so35781341fa.1;
        Mon, 29 May 2023 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685375564; x=1687967564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGEKNlVjba3Uxjbme8b9RXxIe58f3YvDlezq/+8zxTI=;
        b=Mjj5UgctfezMCHltzHW+A8T5x5/3dFb2dzNasfCyGbtOikmZvng/0XBFxq+uXYE/FY
         t6l3BHE+27xIy++ICtp63addI+J79hwzn9bwR19674sk57FXhmiKyPx6OWLuTTOaij4Z
         X5lumtOqj/JWTUjEujNKKgVE4eoiLWeJiafazpmY/LiF/Vxcelg6tRJZOhcpOptzwS2s
         KizfpfxMqxskhm2Q8DevdKApUT0fMSws9sWE162eWkKflZT0XPRKSMtAC8F6NU2Pxioy
         tPhZJEVXYtGGE+qRPRtJ2he+drqgMzbohVXSCnJD3svkS9XPXb+E95Hi1t4Ch6W2g4D8
         aFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375564; x=1687967564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGEKNlVjba3Uxjbme8b9RXxIe58f3YvDlezq/+8zxTI=;
        b=cSA8HodNSkqlS1yXBXd2PLvZSKyTMfk7UnZ8oaT7jF/Oskn1rmSbbTrCOyphIr/XfN
         xgCNa/nmJZ2vlaxac2FNeQKqIUdyWRXEg4ei+DBrhTz9Reiftdr0ryd+8z0AQZe3ZIIF
         SEQI2+n7BiEIm/H/Yu70tc03E1eUH2pAA+OBVev43+9ZYLfDV42KEtIjzvFh5KfBECEj
         vcevGGn8YUyTX8hdgPQV1tFS8OaizB9RjfrGiMGAPnsywPYr3fKnNS4wt9IVa6QbsvQd
         vTiSdQ3hs13jIQYXxtmyxpg0ZFPIWC9m8HmMJ+f0A2J6IMeZE6Q0Pp5gU7LiayMzs8HQ
         0/lA==
X-Gm-Message-State: AC+VfDyn1P/yfzVB3w4+EkVBSnVS9rNQUIE8ySKUeoXKZVqTvrIr94f0
        +67dKTZL9ih/pl60vhdKNwv7btrfuFr6gEzZd5s=
X-Google-Smtp-Source: ACHHUZ44ENjVnVGMqNdRd/W6tQ7x2nto8cf2mXLOOpYHKQnav8XqY4+w3zejqGP55+7gAu7B5aymdVDL1+GPnAzA5tI=
X-Received: by 2002:a2e:84c1:0:b0:2a7:748c:1eef with SMTP id
 q1-20020a2e84c1000000b002a7748c1eefmr4039767ljh.38.1685375563857; Mon, 29 May
 2023 08:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230521143202.155399-1-tmaimon77@gmail.com> <20230521143202.155399-2-tmaimon77@gmail.com>
 <0e72c35f-5d9d-45a7-5f85-3971b8029106@wanadoo.fr> <CAP6Zq1jOSKpzFvto1LMs=JftLK0fxrrg+73Sh34GunuLfcAfEA@mail.gmail.com>
 <fa7a8bc4-d1a1-3b1a-8b9e-618681d281dd@wanadoo.fr>
In-Reply-To: <fa7a8bc4-d1a1-3b1a-8b9e-618681d281dd@wanadoo.fr>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Mon, 29 May 2023 18:52:32 +0300
Message-ID: <CAP6Zq1gb8zJc=2QwNbes-AXP25thKsEVJ11pQfX24eWN62zDMQ@mail.gmail.com>
Subject: Re: [PATCH v16 1/1] clk: npcm8xx: add clock controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 20:36, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 22/05/2023 =C3=A0 14:56, Tomer Maimon a =C3=A9crit :
> > Hi Christophe,
> >
> > Thanks for your comments
> >
>
> [...]
>
> >>> +static struct clk_hw *
> >>> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> >>> +                      const char *name, const struct clk_parent_data=
 *parent,
> >>> +                      unsigned long flags)
> >>> +{
> >>> +     struct npcm8xx_clk_pll *pll;
> >>> +     struct clk_init_data init =3D {};
> >>> +     int ret;
> >>> +
> >>> +     pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> >>
> >> Everything looks devm_()'ed in this driver, except this kzalloc.
> >> Except the one below, there is no kfree to free this memory, and no
> >> .remove() function.
> > Also  clk_hw_register_divider_parent_data doesn't use devm_
> > about free the pll, we use it, return at the end of the function.
> > about adding remove, we had a dissection about it in V4, since the
> > clock is a service driver it shouldn't be removed.
> > https://patchwork.kernel.org/project/linux-watchdog/patch/2022062113142=
4.162355-7-tmaimon77@gmail.com/
>
> LoL.
> At least, I'm consistent :).
>
> Just to make it clear, what I mean about kfree() is not to add one here,
> but either:
>     - to use devm_kzalloc() here, to avoid a leak, should loading the
> driver fails      OR
>     - have some kfree() where needed (at least in the error handling
> path of the probe, if the remove function makes no point)
O.K. Thanks for your clarification.
>
> CJ

Best regards,

Tomer
