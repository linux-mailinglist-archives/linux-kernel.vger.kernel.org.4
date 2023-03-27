Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FEC6CA2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjC0L7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0L72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:59:28 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817781BE2;
        Mon, 27 Mar 2023 04:59:27 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h16so1458163qtn.7;
        Mon, 27 Mar 2023 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679918366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o4yWNszVI2/ZcOwu9eXRrr9iehT4wRAPz3L0LpJT2U=;
        b=oFICXUAWbVzc3OvexyblJtPT5W93/SPNd3S6ogv6fD+//XE1BgYqNkfyp2j39CFTGN
         sSnEkIwe8gL9JKYi8yoxTxwtx+TyrVnw11lbfBXBYJJP4a4l+6mYl52JwCR0IjF4rjlb
         OfbcO6aBnVqXNCk3cN5bFnEZ/r8MoYI+O80chsnaELt17zPOwIxM3dnzDZbtRBu2/7mo
         jaK3/JZ1iSIsll8avKh3m2j796R+MqYN5JKTPHYn8crXmgui3jjiMYOLQjqmgDKS82L/
         w54gN6NHEMNfBZiECVHon3SrJeupWudg2DTR/rpth92nfGOAaVcup2eX4EPpsJqLx1Av
         FMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o4yWNszVI2/ZcOwu9eXRrr9iehT4wRAPz3L0LpJT2U=;
        b=xKIKzaMveGcTTaW+eDF5K9vJqHXdWEnH/VQ5dh5zZ9a6uF/ZS3pMjp9WJDWdMgT9Au
         D3o1h9VZb742pE7Fcs74gumhs4TlZDJ4IBlSQ6W0UXEyeqiu4YK7ciie6kxu570kdtcH
         3z5hh2cvrQ+R+cB8GnFrevzlBpdXwZqA30MALcR2cPDdo2yNmK+fvh7TRj3Bc/OgkVa/
         4r7xxIcC30+2qk7rFxP7/XYhROLvzB/ShOkMbYogbu1zW7Egtk2WUjURJf5Mwn+Fe+CN
         Aup4ZHMDxSChs+KIALaa4FFcO9CIy/GdIfeH2CYE5TCO/dSV2XbAzPoaJ1sD5xbW8Vhw
         bEYA==
X-Gm-Message-State: AAQBX9dgbS173S1PdgqCyLrk9FRHDXvqHqUNwr8FN66LOubLeaauFRbi
        rts8idTTs80L3meM3hCS+1vu5Z7Mn6zL0CWoBRL/QL2ZBaM=
X-Google-Smtp-Source: AKy350bjsRnbwotnIOQ+ZuZJwKardRLmU62FR3daPFFUuCwR2zpNc2Pr3q2CUw9PDgz8zREIuUgCUNkafilxj1bGrgc=
X-Received: by 2002:a05:622a:199a:b0:3de:d15a:847f with SMTP id
 u26-20020a05622a199a00b003ded15a847fmr4233934qtc.0.1679918366657; Mon, 27 Mar
 2023 04:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230327062754.3326-1-clin@suse.com> <20230327062754.3326-6-clin@suse.com>
In-Reply-To: <20230327062754.3326-6-clin@suse.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Mar 2023 14:58:50 +0300
Message-ID: <CAHp75Vf_k2ZDoyHUVbD_e4droAwxVqu7HCwNrPd=X_su-c8LjQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] pinctrl: s32: separate const device data from
 struct s32_pinctrl_soc_info
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 9:28=E2=80=AFAM Chester Lin <clin@suse.com> wrote:
>
> The .data field in struct of_device_id is used as a const member so it's
> inappropriate to attach struct s32_pinctrl_soc_info with of_device_id
> because some members in s32_pinctrl_soc_info need to be filled by
> pinctrl-s32cc at runtime.
>
> For this reason, struct s32_pinctrl_soc_info must be allocated in
> pinctrl-s32cc and then create a new struct s32_pinctrl_soc_data in order
> to represent const .data in of_device_id. To combine these two structures=
,
> a s32_pinctrl_soc_data pointer is introduced in s32_pinctrl_soc_info.
>
> Besides, use of_device_get_match_data() instead of of_match_device() sinc=
e
> the driver only needs to retrieve the .data from of_device_id.

...

> -static struct s32_pinctrl_soc_info s32_pinctrl_info =3D {
> +static struct s32_pinctrl_soc_data s32_pinctrl_data =3D {

I'm wondering why it's not const.

But don't resend too quickly, let's wait for Linus to comment on this
and other stuff. It might be that he can amend this when applying.

...

> +       const struct s32_pinctrl_soc_data *soc_data;
>
> +       soc_data =3D of_device_get_match_data(&pdev->dev);

--=20
With Best Regards,
Andy Shevchenko
