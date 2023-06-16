Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3FA733277
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344273AbjFPNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjFPNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:47:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5D2702
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 241D262C50
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A886C43395
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686923261;
        bh=e3Rn9wSp0yBzOPdTFOU/3C0NFGTIC9+SG2QGu/MQAiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fwp/B2s6/1SMHXRYeVOqtSkxp17GBTzZ9lvprmabfaWKOBVM7I2+iCqNf2YnjPyXk
         yhjB7NhUuEAQEh5JGsUHNYWINtu6W4dBn1C/+1HwahCTnusYOENpybWKC91OQ37Udn
         z7A8TMgHrOboK7mdbFR8OS56LyY72J3p06xXgsy0auR17x5xhLjIYBI7mWMof9xphg
         L4k/g1sx0tIYT0Je/d+AmjqWzrOsa9pW56HpEEpelcQN9J5XhuLDpHbqu4C/FltLin
         zqYw7HQBYk04qC2AGZPLGYBozvhK3gkZtC71+9krbCmC62eysTcvyHSjC2AjgFAW75
         uQktPBuoaOdZg==
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b52fd56b7aso4011605ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:47:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDwT8v9SlLPEhRw8sNcnLY/mJMZWcPOIWZDPzMTicj+TitVl7/wh
        Ht8VHv8Twb5HBy26a5r0rPa7BGZKJIbv88r6IylzRA==
X-Google-Smtp-Source: ACHHUZ6S6xDb9UwuivCY3/VT2rSDFUreEKhVsbql4uCpIS5aTfqDe0VsnssVVihzjlCFyZXmoDBshHzfwGBE6X1ZLjQ=
X-Received: by 2002:a17:903:1112:b0:1af:a293:e155 with SMTP id
 n18-20020a170903111200b001afa293e155mr2017620plh.16.1686923260691; Fri, 16
 Jun 2023 06:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230616121341.1032187-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230616121341.1032187-1-juerg.haefliger@canonical.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 16 Jun 2023 15:47:29 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4jdDD20DY5sKL+ALC_Mk2UHRArOrQnjzKoyF30QZi8jw@mail.gmail.com>
Message-ID: <CAN6tsi4jdDD20DY5sKL+ALC_Mk2UHRArOrQnjzKoyF30QZi8jw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: lt9611uxc: Add MODULE_FIRMWARE macro
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
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

On Fri, Jun 16, 2023 at 2:13=E2=80=AFPM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
>
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm=
/bridge/lontium-lt9611uxc.c
> index 583daacf3705..6b2a4f8d6f78 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -1019,3 +1019,5 @@ module_i2c_driver(lt9611uxc_driver);
>
>  MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
>  MODULE_LICENSE("GPL v2");
> +
> +MODULE_FIRMWARE("lt9611uxc_fw.bin");
> --
> 2.37.2
>

Can filename string be made into a macro, as it is used in two locations?

With that fixed, please add my r-b.


Rob.
