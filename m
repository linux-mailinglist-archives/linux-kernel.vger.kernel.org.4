Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D382A745C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGCMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGCMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:54:10 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0FDE58;
        Mon,  3 Jul 2023 05:54:09 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-47e5cf4e347so159654e0c.3;
        Mon, 03 Jul 2023 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688388848; x=1690980848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UNjUFxogKwa7w723fW56Ug+Y7s+F2FtRHsJB36Mz9o=;
        b=KoI8luSuFSpDxhSSQSZ1IAWiWyD9Ctbdj/6LYRQkmggybdV7t2a0UOuV+Hw/bjlWr3
         TKsHTDWgdVTIi4hEGYmmDJQzL3jY0RpamZWYCiC73/TfFz1QVarPSYsgm6PX8vh8AfTa
         4Mk5ZCj5vpfXmtLaobAT5o3SLkon0tJDSjp1XUXJSxdpV+7BYXz8z/xRTkbOv8B88aLz
         LMq9T3fXP+hhI0Eg+vNFLeYE7zUmnmeDzqE6tfA4RMSPGVRE+/94b9Dmi4iQjxNZtC3V
         bOV54ukfW84Nwc99HT/0Is0JOV4ofXhZxT0JkVnM+dPfUArt/TPOvnGYo8eue49Dmwes
         F67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688388848; x=1690980848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UNjUFxogKwa7w723fW56Ug+Y7s+F2FtRHsJB36Mz9o=;
        b=GVexBi3yx/+wyOXNZmv1DvxxnZOeBGkqXORawecn1XbwXy6SvtsZHMdT7hguslsqSS
         6yK47Dc+/LeVg3d3amxlot64T7cdm6iRoGlOg/EmhoH7Nh0w1uApFfN7NREeaeEAJUt5
         FoghZ0LYTmnMEYo4wYVS6HqFjq2uP2cTT3NVgurwmO/0j1gn/xWj+l46Eg+wY+wPGnAE
         PeOnblnJCJ952JbZLdP7ePlnI7yz0ky+o8O6fHjyRLF38mys4QAOeyErpZVYmj3hXd4i
         XcQQXl0nCS8RxQJkEFFTodr8bb0186ag4mK3U1DrJ27h7ISPZTqBPri3l1KH9EulWUxC
         lFsg==
X-Gm-Message-State: ABy/qLbPjnbBWurFtGGCjaut61O5CAldlwAb2P6rP3c7HrSGbl6eoA1a
        Z4PKmfA2SdyO1OU6pbUgrdJJ7P2zeG2Y2hIm2kQ=
X-Google-Smtp-Source: APBJJlEyfvGPjC4sl8jnRJcD1mI5MQh0QGdeOcVz+gjYTgStp4xiqpqSM7Pt6GQrZjE9wkd/yzrx/O7U8G5/LUovkLs=
X-Received: by 2002:a05:6102:21b:b0:443:6457:10e with SMTP id
 z27-20020a056102021b00b004436457010emr4733155vsp.7.1688388848288; Mon, 03 Jul
 2023 05:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230703113142.424670-1-arnd@kernel.org>
In-Reply-To: <20230703113142.424670-1-arnd@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Jul 2023 15:53:57 +0300
Message-ID: <CAOQ4uxj5v=zTsiXvHGD70nMcKSvTVwM2G0raCDePY64gofu+AQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: mark ovl_redirect_mode() as static again
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 2:31=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function was moved to another file and is no longer marked
> static there, causing a W=3D1 warning:
>
> fs/overlayfs/params.c:92:13: error: no previous prototype for 'ovl_redire=
ct_mode' [-Werror=3Dmissing-prototypes]
>
> This was probably lost by accident during the refactoring, as there is
> still no caller in another file, so add back the annotation.
>
> Fixes: 06bcaa2dafb7e ("ovl: move all parameter handling into params.{c,h}=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This is against a patch that is not upstream.
I will squash it.

Thanks,
Amir.

>  fs/overlayfs/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> index b8c2f6056a9a8..a63160dbb0f95 100644
> --- a/fs/overlayfs/params.c
> +++ b/fs/overlayfs/params.c
> @@ -89,7 +89,7 @@ const struct constant_table ovl_parameter_redirect_dir[=
] =3D {
>         {}
>  };
>
> -const char *ovl_redirect_mode(struct ovl_config *config)
> +static const char *ovl_redirect_mode(struct ovl_config *config)
>  {
>         return ovl_parameter_redirect_dir[config->redirect_mode].name;
>  }
> --
> 2.39.2
>
