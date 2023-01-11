Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E0665A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbjAKLoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbjAKLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:43:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32610658B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:42:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4A1DB81B77
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9891EC433F0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673437368;
        bh=AKcM0Lzbqhutq676iY/kkqjxwiNdORUZcfGqBFBp1oI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vH2t/tvaL25Fis0aaV0YAxqhYjgyuKyeMDDU6Dx2nXmrl2BZoNNU6/baAp/gLEOKt
         nhFZZr+jLD1pSyUaQmndhuk5Ef6lSaTMuW7mC0oFANDm2ud0Diloly278V05pQ4zWc
         RUlSDnKg0b7FmEHsuVXL7QoGzeddSnfpaQqin8BbRhSDKCBVw/9BLMlnWECgK6uKWy
         JnUQrOGCVU+7jIyaqKuuJe/vtWPIa1vyp2ppFuShf3FjaBLIWf4Y/lXNOHAlmTONns
         8hsy7ju8BwVKGxcRldj9Eafzzc37qnAR3H5zzXtDjXRNDFZ4Wq6YdbK6iguHOIHLMg
         rauOpTszFkl+A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15bb8ec196aso3471908fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:42:48 -0800 (PST)
X-Gm-Message-State: AFqh2kpxl6YdZvhz26vm1PsFIM30ltVRCekjaVu/UWSP70tsv8wo1Xcm
        MIy2zDVZOUOJgyal/zdTCjBLWn3Mq1HbQhpYo3Q=
X-Google-Smtp-Source: AMrXdXsO4gU8EFT50TH+wPFFAwHxi4wrBEIgO4Nf96wTo4SMlFDLTwozZPvA8pejeCKzxkoGoj21mkZQc7SDDOMDS8Y=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr2426733oak.194.1673437367898; Wed, 11
 Jan 2023 03:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20230111093822.2934184-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230111093822.2934184-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Jan 2023 20:42:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmyKYC4e3fOyACPVJJ03gTh4TwNqXAx_SLP_Zkei0XXA@mail.gmail.com>
Message-ID: <CAK7LNARmyKYC4e3fOyACPVJJ03gTh4TwNqXAx_SLP_Zkei0XXA@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix LOCALVERSION_AUTO help text
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 6:38 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> It was never guaranteed to be exactly eight, but since commit
> 548b8b5168c9 ("scripts/setlocalversion: make git describe output more
> reliable"), it has been exactly 12.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---



Applied to linux-kbuild/fixes.
Thanks.



>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 0958846b005e..015dbb63b61a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -204,7 +204,7 @@ config LOCALVERSION_AUTO
>           appended after any matching localversion* files, and after the value
>           set in CONFIG_LOCALVERSION.
>
> -         (The actual string used here is the first eight characters produced
> +         (The actual string used here is the first 12 characters produced
>           by running the command:
>
>             $ git rev-parse --verify HEAD
> --
> 2.37.2
>


-- 
Best Regards
Masahiro Yamada
