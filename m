Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8F65BF5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbjACLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbjACLvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:51:09 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83F96587;
        Tue,  3 Jan 2023 03:51:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so32358289pls.6;
        Tue, 03 Jan 2023 03:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+ASKySmgpYe6aeuyIud7plzReCzUcsxfQRRqpb3dCM=;
        b=dLWgbFCgL/n8+lBOD8gxbhiFHszFpeZo6BLDCarxXTBswHednpdDH3tiBOUHIzQOp5
         TI0Rdf7kTZRDLe00zrmwQUVOnpj8jr/TmHnW2/kUSku2MJ7gvJrX1vYGaPl7Y8Yn35mX
         EogWrpq293abNtofIdw5cybQ7/bzkBtlUP+qOcJSTzOi7xIUvg7w2+E5N6c7ATvIDKZW
         OOhoOBKu1bxEhC4gJM69Lis/aPWlt6gtIKIEvjGqcnshfQqMLj9V7XQ45PGLrUweHVfV
         SfXHCcMqpBIIorivPDikeOufr+z7HteEdwseA9IGlJIARcJjUBY1i/ezVdzKhQBIJKLy
         9xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+ASKySmgpYe6aeuyIud7plzReCzUcsxfQRRqpb3dCM=;
        b=wqre/ji89OaFdZMtB8vfxw0bdhG0dZ21MJe2uvSO12gJMlf/NkWWV9Y7mOSRzjlxxA
         1s8xKdl53iIK5pRUky5vGgXUy3lx4ELfvIs/RP6i3NodUr9RWjynx8PIDIPowPwIaeVM
         F8Uw+t45vWQiOy0JwYMWAJHCNFu2GvG0NPnLFCRCq17tR2eWLXrNH43BYgOZwvitehEj
         IgooHFIWGsc9WPPJ4Fsv7TvU6DtH6yjwNdc7NimODwJXu2DzNQ3qpl8GZJI7Uxb4YWuC
         dmX8VZcZtHyUmpubRzpzi4dt6+Owdzn02lsEqSBV6zWcN8DJx7C4+lW9nCdRLPrxRmot
         ojHw==
X-Gm-Message-State: AFqh2kqss0v7uqq1Cc2h/n8zfunbHCFE76mTuUBDA4xBZb8qVvC7LNCq
        IjyCNQ7HkoIlruDEWZuP/IcRd8dcZUCkHWOOTas=
X-Google-Smtp-Source: AMrXdXtjlG1QUtAGeuLxA2IQuXmZaZsBpL9dcTNtyWMOgr14QYIXMLdO7UE7vUNs7b0MrUG8gFjc9kbTS0iPSsOUAFY=
X-Received: by 2002:a17:90b:485:b0:219:720c:29cb with SMTP id
 bh5-20020a17090b048500b00219720c29cbmr4199206pjb.76.1672746663119; Tue, 03
 Jan 2023 03:51:03 -0800 (PST)
MIME-Version: 1.0
References: <Y7QVN0XY+ld2mBk4@qemulion>
In-Reply-To: <Y7QVN0XY+ld2mBk4@qemulion>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jan 2023 08:50:51 -0300
Message-ID: <CAOMZO5Adkz2ZZaWF1VQgTZ43LB-+MqLxp+smS_zFBSJK+x7bjA@mail.gmail.com>
Subject: Re: [PATCH] staging: media: imx: remove unnecessary return variable
To:     Deepak R Varma <drv@mailo.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 8:45 AM Deepak R Varma <drv@mailo.com> wrote:
>
> The function imx_media_fim_set_stream() can directly return 0 instead of
> using a ret variable which never changes its value. Issue identified
> using the returnvar.cocci Coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/staging/media/imx/imx-media-fim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-fim.c b/drivers/staging/media/imx/imx-media-fim.c
> index fb6590dcfc36..e719227d4323 100644
> --- a/drivers/staging/media/imx/imx-media-fim.c
> +++ b/drivers/staging/media/imx/imx-media-fim.c
> @@ -373,7 +373,6 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
>                              bool on)
>  {
>         unsigned long flags;
> -       int ret = 0;
>
>         v4l2_ctrl_lock(fim->ctrl[FIM_CL_ENABLE]);
>
> @@ -393,7 +392,7 @@ int imx_media_fim_set_stream(struct imx_media_fim *fim,
>         fim->stream_on = on;
>  out:
>         v4l2_ctrl_unlock(fim->ctrl[FIM_CL_ENABLE]);
> -       return ret;
> +       return 0;

Maybe you could change imx_media_fim_set_stream() to a void function instead?
