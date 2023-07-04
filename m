Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48098747174
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGDMdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGDMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:33:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D9D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:33:13 -0700 (PDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77D9F3F731
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688473992;
        bh=gy4Y3Oco7V4O0qs2lvEoa7dVI3NuFWh8wF5vNDqvAfY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QgIQJRZHNeX6RMvTIqKJyEShxtNVrzwsirfDQFjRmGeaXqph0qFA/lfKXFrsO7o6L
         yL7F9KC6UeSrMZESxu3aBlHi7AlBt281oLgQjO6qUm8YlMeprYZHv6fFiFXmWDWHlV
         GeYdg99ZP1j0GjOzKsLX0FTB3zRI0wZega1U15UlDouEqc6rOUB7XC/p9PyGO9z4fq
         q4uS5BH2NHtxqPtdsO5cMpjEOGYr7flijaO8GlkuZlqXdLtHUErbnnuxuQSiofeix+
         2HB/87k29RU/tqfiT3LPySM5u+PKqeoxyoT9rNIGWcPn6LKPk8A35O7MIbe7v+sOMf
         4GZedonMcFLkA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55afcc54d55so5704232a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 05:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688473983; x=1691065983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy4Y3Oco7V4O0qs2lvEoa7dVI3NuFWh8wF5vNDqvAfY=;
        b=kiskt0UMHvS2k2MXItOUXVkyOd6ilowojCl6ZAIBDonXefP7doBEVVHIXGlG4VBZyM
         bRj5Ye6s+kgEVBI1ABc7MTeMgwkup0XiH12dXnoEQyvW1GnTUS9TppOCU0pJLFX8Fqf+
         cYPSfpLU8spNTAt1i5EeX9HfU2YQhu+Np2URA1JFCFuvq9KQ/3N5G1xueNsk2GWJSNLs
         B1TTREkb65DIbpg5CjqB+1dYLyI5p1FkL+lTrNJFo4996kTQETdoWzO43ZIXOeuNYnLZ
         D0DOSO85Qh76/uKuaWyBeam+v5jwIHWutIwXXx722ugO2tIkENP+t3cUPz5mSeFkv0eE
         U7Fg==
X-Gm-Message-State: ABy/qLa5QufvG3MKb98aPtTCTJYsK2Rs0YX8L17Dmxu0wVzjCzrIwMOp
        UkocPcWsRw6Prf4r5u2SZOb7jIfqCgqZKAQKnYhr3sgZ2FXdUj1AgYyDUt2XHVG7LkY09FkGBMq
        iK3bSAua5nbTkiqUyXkBG//JL0mUy8Has5mfFlll8HsY3N5CQWaBmuV6SrQ==
X-Received: by 2002:a05:6a21:3814:b0:12e:44:a1a6 with SMTP id yi20-20020a056a21381400b0012e0044a1a6mr8431327pzb.11.1688473983386;
        Tue, 04 Jul 2023 05:33:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGae+2iySp3xgwZd0kWkyY46HWnfktpgUwojgNRFu2M9Wl2v4eWGdhI9PBPcXvWopiWdqDucbx4YO6MZ31PIcI=
X-Received: by 2002:a05:6a21:3814:b0:12e:44:a1a6 with SMTP id
 yi20-20020a056a21381400b0012e0044a1a6mr8431303pzb.11.1688473983018; Tue, 04
 Jul 2023 05:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <a0bf3b4c-a528-4507-9bd4-95a0a9eb927d@moroto.mountain>
In-Reply-To: <a0bf3b4c-a528-4507-9bd4-95a0a9eb927d@moroto.mountain>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 20:32:51 +0800
Message-ID: <CAJB-X+XtfBm0a4btt6NT9rvdrxETNLNMVQ3G=u513Nh8RKwjWw@mail.gmail.com>
Subject: Re: [PATCH][V2] EDAC/i10nm: shift exponent is negative
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 8:02=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> Here is a better commit message.  You can just copy and paste it.
> ------------------------------------------
> [PATCH v3] EDAC/i10nm: Prevent negative shifts in skx_get_dimm_info().
>
> UBSAN generated the following warning during a timeout:
>
>     UBSAN: shift-out-of-bounds in drivers/edac/skx_common.c:369:16
>     shift exponent -66 is negative
>
> That most likely means that rows, cols, and ranks were all set to
> -EINVAL.  Address this in two ways.
>
> 1) Change the debug output in skx_get_dimm_attr() to KERN_ERR so that
>    users will know where exactly the error is.
> 2) Add a check for errors in skx_get_dimm_info().
>
> Fixes: 88a242c98740 ("EDAC, skx_common: Separate common code out from skx=
_edac")
> Signed-off-by:
> -----------------------------------------------

have sent V3 as per Markus' comments.
https://patchwork.kernel.org/project/linux-edac/patch/20230704095939.119620=
-1-koba.ko@canonical.com/
Thanks
>
> > @@ -351,6 +351,8 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap,=
 struct dimm_info *dimm,
> >       ranks =3D numrank(mtr);
> >       rows =3D numrow(mtr);
> >       cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> > +     if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -E=
INVAL)
> > +             return 0;
>
> Change this to:
>
>         if (rangks < 0 || rows < 0 || cols < 0)
>                 return 0;
>
> It's bad form to check for a specific error code unless there is a need.
>
> regards,
> dan carpenter
>
