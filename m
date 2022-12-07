Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2655B6459FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLGMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLGMic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:38:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF55131F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:38:25 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 21so17313740pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFA8+rEw0dxGOhWHCOJyRKc/XlYicDFAj7Rf5FW7TzA=;
        b=t45ZmiFiysNDnaTHfWAb3RxuHZT4KGyJJyq2U+vEKG4/PCNiljE47SCANhrxVGdhP9
         RtgsPk1u3TFy0hRfahBjhY/pGvM9ZHNAxX3iT57ZWXEq5H/U2eE+e9XppfbmcTG51s8L
         Wie2vlqEvOB2wjhlyj5JzkzQKsUEXHFoFGQ3IdwbPrbh1hkXh2gKcFo6Aa0F+/l1jvkN
         vqHPU8LQcFzr5H+G2ahj7cIDlw+65Wk4C6kJyGtvg5Css5T6jTDXavykd5xs49OV4M++
         Fy2wyBHuaG+VYMVx4iuo9NrqV6922a71Btu7pMrlV4Ys7WsFSUgNYurLaYaaTBifxMHa
         UFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFA8+rEw0dxGOhWHCOJyRKc/XlYicDFAj7Rf5FW7TzA=;
        b=CUOdBeJrDlmlLz/JaNzLtMW1IXO1vUck96jxc71Sa5abqGSo0ih4tUuHl5SBhujrJb
         XMxZK49vbzNzBo3vfTXip8+qnMyvdLl4ADo7UERHh4u3zhdloGGtq66aaNMcuIevEWtT
         66JqrWUsrZaLyt1CoPhzwClDKkauzuPZbYKA1B+OKIJzCT3tzsdQa0GzIyBbSrQG7Qw1
         vHnIM7r3UimrpZOFwpf9LnOO84kpQ22hAZjtSq8pnYuUwK/bBMkQPXUShRS59HZZ38mZ
         FHuBJeZwxbAQYqlKLRGUthh7fDXDpqlDHAa1qXObItXrmpwjyfTQ/PLy/ipyxAufglCz
         f6QA==
X-Gm-Message-State: ANoB5pmw0yaBdwkhuNkx5OflJR4sYJgtiDvUplb7eIhhh9YAXEvCQJHQ
        W4MFrLPvHLtICrt19qaZ/9Jm/63K7KAY1YOGzPuv2g==
X-Google-Smtp-Source: AA0mqf4TlYvFM19eSDCRhF5eZXqHNWp9CkKSbYT4qXd/pLe0CEnTI/WrNOSb58jE7JpoVhrOKgGsVGCK2BaabiGGE30=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr62955490pgb.541.1670416704625; Wed, 07
 Dec 2022 04:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
In-Reply-To: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:48 +0100
Message-ID: <CAPDyKFp_hq1-kvd4s=573vU=2AkfteSuCiDxcGK0-UHMW-mh7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Resolve "unused" warnings with CONFIG_OF=n
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2022 at 01:04, Brian Norris <briannorris@chromium.org> wrote:
>
> With W=3D1, we can see this gcc warning:
>
> drivers/mmc/host/sdhci-brcmstb.c:182:34: warning: =E2=80=98sdhci_brcm_of_=
match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>   182 | static const struct of_device_id sdhci_brcm_of_match[] =3D {
>       |                                  ^~~~~~~~~~~~~~~~~~~
>
> Rather than play around more with #ifdef's, the simplest solution is to
> just mark this __maybe_unused.
>
> Fixes: 1fad8422c989 ("mmc: sdhci-brcmstb: Allow building with COMPILE_TES=
T")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202212060700.NjMecjxS-lkp@intel.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-brcmstb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-br=
cmstb.c
> index 55d8bd232695..f2cf3d70db79 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -179,7 +179,7 @@ static const struct brcmstb_match_priv match_priv_721=
6 =3D {
>         .ops =3D &sdhci_brcmstb_ops_7216,
>  };
>
> -static const struct of_device_id sdhci_brcm_of_match[] =3D {
> +static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] =
=3D {
>         { .compatible =3D "brcm,bcm7425-sdhci", .data =3D &match_priv_742=
5 },
>         { .compatible =3D "brcm,bcm7445-sdhci", .data =3D &match_priv_744=
5 },
>         { .compatible =3D "brcm,bcm7216-sdhci", .data =3D &match_priv_721=
6 },
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
>
