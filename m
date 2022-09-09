Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813CA5B4102
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIIUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiIIUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:46:36 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63F1475C9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:46:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-12ab0eaa366so6935575fac.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fIWWFRWToSyjND5u32f5EwlAkJEA8KQOjYH9kYp+XHw=;
        b=ii/jSDrdVYygo+6BfJIU+E/q04lrQEhFJv/UxSLRbbQ76BmfzhBfe938IDSrQS6Y+e
         6LJlYHvRDS7tLmEIJdHcl3B2P5L+Asems9NCYW2weKImyBqW+je0Oii+bwvX69oNQLDd
         nTguM0fs6zP5RqTIFTaiCz8UqDpOBk+jWjJmIKA4ux5Nd6ycTm/fpAmfXdeDfWf+/Qm3
         hh443dUp58IIfeWJz7ddTeVXvJiYkCn1UJfXbCf4xJdCaEyEigZFMntYh9OBJtVbsnno
         Dople/SpP1j2Ol+i0CqEJ9qw/i0I0/NINIuuXAUW9WQvbOGtcTCwK3WJ0BWbF0J+Xq+y
         u69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fIWWFRWToSyjND5u32f5EwlAkJEA8KQOjYH9kYp+XHw=;
        b=6yw5wQG90Rz7nmY9rh22FsvNSMlORnSL1FHxE+eZ6ACZa0lG6CK541Oj4SsFp6fBCZ
         FIm4rhLGXMzDODBeusQNiWk12Z9IIeuG6jEoVoX5OXnlymt0NllGAvTTLJlM8Ja1HAOQ
         /TkzLUvyptak1vb6d58KlDB23i4RLQSUENMNsWy3E3QZ/40wFkCAyGl9Q9u4s/PdMxja
         kUmx/VuC9f4r+Dj9dOpXN4cOM7Zdkqo8ptKZbe0BLs0saxKNyHMWZospq0R0FOliiaDS
         +3XZ1lGPQ5zDd9+BHrCjGYRXaJZbOcTMgY1nt7YR/uIdtBdocuKEUXh2KD7QmtQjHxx5
         YmCA==
X-Gm-Message-State: ACgBeo2RlzHeAljRan5h2LvL9eUCm7K6tzXC66B5lMe0xQ+q9WUXKgjv
        8njXFNvnwslAYHPgyy4CaGN8gVktee0fLthLHkE=
X-Google-Smtp-Source: AA6agR5xiiLiZPpsFq6YQrxT7/tHRboxJGNQw12HUSDCAvkjWrEy6Cg42aJ/OF36IUtsRmY4md2+xpswpxG5l7N94ZQ=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr4521225oiw.96.1662756379115; Fri, 09
 Sep 2022 13:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220902073320.319673-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220902073320.319673-1-ye.xingchen@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:46:07 -0400
Message-ID: <CADnq5_PSreYBqUg2HDVTBmZ1L-0z40EkfO45Yoru7JAz+d4-Ww@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/radeon: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     alexander.deucher@amd.com, airlied@linux.ie,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Sep 2, 2022 at 3:33 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value radeon_drm_ioctl() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index a28d5ceab628..6cbe1ab81aba 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -512,14 +512,11 @@ long radeon_drm_ioctl(struct file *filp,
>  static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         unsigned int nr = DRM_IOCTL_NR(cmd);
> -       int ret;
>
>         if (nr < DRM_COMMAND_BASE)
>                 return drm_compat_ioctl(filp, cmd, arg);
>
> -       ret = radeon_drm_ioctl(filp, cmd, arg);
> -
> -       return ret;
> +       return radeon_drm_ioctl(filp, cmd, arg);
>  }
>  #endif
>
> --
> 2.25.1
