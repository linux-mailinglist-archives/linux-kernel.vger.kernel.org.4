Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91370E3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEWReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbjEWReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:34:16 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAC61A4
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:33:52 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-babb985f9c8so7605739276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684863228; x=1687455228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxJT2l9AQiSzolKv87z4T+nj/6Voqeaq5rKuGn4L58s=;
        b=NszQYt8L7vYkm2To4A082HXzf99FoYGffUy1WJs0IxDiKVOBKNIZF4LS8bzJP4U9Xb
         FsbiTsVNDdLLO9Of0VWtDdM9HjmJ8Fa0XOqMUAkOVIdCF9F9+SGWpxExplm0xqL+eVeR
         n1QcsrICYT3cFla8/FwSnnDBvbshHMlOilkW8bkXqFbv2/EgaolJPeOD9816GfD7BerT
         X+l2GmVnc+Rf/e8zNFVSRWCvASTB1ECiX5BE3ROF8deLdC5sOaLrZC6p4pSjtFYSYQxv
         TJ8D9YPiDGYxcvy97IVEBRWhnZ+uI32T3E8TRAB96y0E3fA2QkewP+VJ0ckw2nIlRBeP
         2IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863228; x=1687455228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxJT2l9AQiSzolKv87z4T+nj/6Voqeaq5rKuGn4L58s=;
        b=bTVqtEICfM9eFlTHTV1DOoogaOCe0NLgDPeXivgExQXyjcWzdoOLttisUWhaAQrzRU
         tZdN5GEP19AZqtKOtHymlVL3Q74hcIcBVyOC2ITbVhmvoqn3Gxwv4YKvxC1F5LfZI5dW
         Cz6ptNHcLboplUHFdi3EGTMi9Ayx957jjRH56uESHJCPVvUMGpXmIME6iYBTLOax18XG
         rswakgflzVl4eCoG8yIlNn5boO7oBWgaPN2LV4uC8h5gLeoSQ729Mx4QDC67C0Y4sctN
         DP3bEb8JhE9x3/9wkHATiIU0Ft6Qz7e8sdBOyVpIne+dWoJt6Z3KeJGAwBJdZmlqlwZr
         wBCg==
X-Gm-Message-State: AC+VfDzmeh8TShmGRkg6lQq89gl1+7N/yiU5R3kQHY+Kw6FXLTSbL+5m
        2/XnTW7ehhRxEFlXSNW2zn2YpWlXRVkxhtHBWTsC0A==
X-Google-Smtp-Source: ACHHUZ7CvU4JrLWdiw8GNueFAwAmwyblmrdIcjrSDreVSwbYIvgWidxnuleSI1/e3yufGf6NDzI1RndQMl1F02Ag8X4=
X-Received: by 2002:a25:541:0:b0:bab:534f:d8a4 with SMTP id
 62-20020a250541000000b00bab534fd8a4mr14934833ybf.55.1684863228586; Tue, 23
 May 2023 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230519142456.2588145-1-pavacic.p@gmail.com> <20230519142456.2588145-3-pavacic.p@gmail.com>
In-Reply-To: <20230519142456.2588145-3-pavacic.p@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 19:33:37 +0200
Message-ID: <CACRpkda8Q+zy-J9Hs28eJuioaE6eEzDmFE6ftEGgs9ot0t4Y6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 4:25=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.com>=
 wrote:

> +//macro for writing to DSI
> +#define WRITE_DSI(dsi, seq...)                                          =
         \
> +       {                                                                =
        \
> +               const u8 d[] =3D { seq };                                =
          \
> +               int ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d))=
;         \
> +               if (ret < 0) {                                           =
        \
> +                       dev_err(&dsi->dev,                               =
        \
> +                               "Error (%d) occurred while trying to"    =
        \
> +                               " write MIPI DSI command: %s (decimal val=
ue)\n", \
> +                               ret, d);                                 =
        \
> +               }                                                        =
        \
> +       }

As said for the other patch, this reinvents mipi_dsi_dcs_write_seq()
so use that instead.

mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x13);
etc.

Yours,
Linus Walleij
