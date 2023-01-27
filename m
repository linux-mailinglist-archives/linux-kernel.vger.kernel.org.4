Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D748967DC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjA0Cwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjA0Cwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:52:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AD10E0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C9ABB81F8D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D8DC4339B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674787949;
        bh=XmZzmR0H0odzZa8z+aZHxpi+uFsfehvEV4nWc6PcC00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eo1FVATEqdfJvfJZte/joq1pAcX0U8hjZirWywMNQZxEJducD3X9WqLsXD4HJsfdj
         LD53lb34LZM9SgFT5t8ZLqJo7P8eepC58YF+wJqauy8qAuyEOYeXmb1iWOaswC+f3A
         lJyXN0Q4cGx1LxPkmYZSSdcASUqRKAFifFv793zJSP0AsJ/96IJdm0AxGcdOYHLGHJ
         ym+2zKZhz32VEpKNTo+g7wRjXodyc6LooXiI/tQcCTAKX7lCa+J/1rdrDIL1k5hW5u
         3sINUC/oBAyqy0TsVs+XOCnbn9MZISVWGzfYPyHmGok9N6rhRof9VzXwTIi6LNtZfm
         vPjHynsH/+Nnw==
Received: by mail-lf1-f50.google.com with SMTP id x40so6053366lfu.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:52:28 -0800 (PST)
X-Gm-Message-State: AFqh2krlO/AtIdB8RN/L+kEIC+CygTAXhAw/Cx8PMlM8Hs1WvbZUPXhw
        v0DViXn1Wh5nTkrG2N/WoDwFkhu3TmEK1hTDkw==
X-Google-Smtp-Source: AMrXdXuUHO8hzB79znCWY5z5W+kP+XGUd9qQcOVFLEto3iBwYVy74HhXFjPnd5hXwwIRJ9E6HcUdt0DBWBdYu5B/NjE=
X-Received: by 2002:a05:6512:3f0c:b0:4b5:2aed:39be with SMTP id
 y12-20020a0565123f0c00b004b52aed39bemr4431185lfa.195.1674787946999; Thu, 26
 Jan 2023 18:52:26 -0800 (PST)
MIME-Version: 1.0
References: <Y8LNIt97qxLk8e70@ubun2204.myguest.virtualbox.org>
In-Reply-To: <Y8LNIt97qxLk8e70@ubun2204.myguest.virtualbox.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 10:52:14 +0800
X-Gmail-Original-Message-ID: <CAAOTY__4hW_MKnL5PxES+Z_VYTM1JXPgNCi2TW=WAb7Ri9yHLw@mail.gmail.com>
Message-ID: <CAAOTY__4hW_MKnL5PxES+Z_VYTM1JXPgNCi2TW=WAb7Ri9yHLw@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dp: Remove extra semicolon
To:     Deepak R Varma <drv@mailo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Deepak:

Deepak R Varma <drv@mailo.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8814=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Remove unnecessary semicolon at the end of switch block closing brace.
> Issue identified using semicolon Coccinelle semantic patch.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek=
/mtk_dp.c
> index 9d085c05c49c..9da58ac5a8b8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -1693,7 +1693,7 @@ static int mtk_dp_training(struct mtk_dp *mtk_dp)
>                                 break;
>                         default:
>                                 return -EINVAL;
> -                       };
> +                       }
>                         continue;
>                 }
>
> --
> 2.34.1
>
>
>
