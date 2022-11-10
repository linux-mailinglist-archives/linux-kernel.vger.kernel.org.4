Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9B624654
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiKJPvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKJPv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:51:29 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460DC93
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:51:27 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s206so2224276oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9o/q02SgMUtKwCSGCp62SYqtX4KWBFvmJVY+jW/71qY=;
        b=gjVyVor+cEsWkvWUOGB7xjRTdZoU9NwM5TxlMvWV8xgI6+f1GF/x6yOniLLrKw+5Bh
         Tq3O+muwLKOkEbZvF9q/SQjhdTDwlw91rcYSsdF37sWMmlYzImmzmQgq+yTiewjlZmZZ
         IRP7dJ2mQuC+E6iuMcg2fBQWnLG685xFbt5uYlD2DCcH1WkKj2KmMUqrGBsnQ6JMRPWd
         pgtE3nKCM4sdrTXXbSnLgr7PMwiCo0qdVb4pcjJVr897D/xwnfOLkRyU6kJVXtXGitRz
         B47vqeHdCvTywOiK7FOaIpo2M493rWPWtQrAwQ4Kx+9gVm/9vxsww0TzKTX7HCEjB+fq
         xecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9o/q02SgMUtKwCSGCp62SYqtX4KWBFvmJVY+jW/71qY=;
        b=X8+89WSW1wuuUcemSE7fBgtvRYb03fjUq15utKB/CpZuUp6BWU6JaP3hIF7lGytM19
         XSPbiTGzTTGt5n2qge4l0v0JU3yxoH7Z9Jls8dlHLKCpJTPuwVaL2+vgoni0nT+8JPzy
         MFEJHsLSdCmqoc0B5uR3Ih3c3V3EPxAjCTb3hQ3fiA1aTJd5UbWuCra4+hOxKhWpMcDH
         vq73MtAFmfX7P0mbAIX/b80e9kcYV+Wf9nYnvIXaphzpZmHe3pa3h2GpDV2U0mxx63O6
         5eEioLaAP5nY3w7KGxRDkRPs3Igjogmz+lL5RzrQ8q+iInsI4cQQOd+SNe2Kzz7O0Avi
         Xc7A==
X-Gm-Message-State: ACrzQf3EnV8An3nuk4lAhRVeeRsITjdP6IWoe0WykgYwBYPBHr5W8Rxn
        VcfnmzRpHDrxkNsWG+P4GoHgNo0+DsddxAxCtcg=
X-Google-Smtp-Source: AMsMyM7UirTmV8hJcl+4Lyw1UKPy1lrw6dkr1YyynnQNsal87YgDDBrrEG4X7i/3GO1QM5iBZ0VzQKjxTuOl/3LzzGk=
X-Received: by 2002:a05:6808:7dc:b0:34f:97ea:14d with SMTP id
 f28-20020a05680807dc00b0034f97ea014dmr1575932oij.96.1668095486593; Thu, 10
 Nov 2022 07:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20221110130925.26928-1-tiwai@suse.de>
In-Reply-To: <20221110130925.26928-1-tiwai@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 10 Nov 2022 10:51:15 -0500
Message-ID: <CADnq5_OH1A=uC7tg8JD9tvWb-+EEgze4Kwuo1F7p8fAOpvhvyg@mail.gmail.com>
Subject: Re: [PATCH] drm: radeon: Fix audio get_eld callback
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 10, 2022 at 8:09 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> Check the availability of the audio capability and mode config before
> going to the loop for avoiding the access to an unusable state.  Also,
> change the loop iterations over encoder instead of connector in order
> to align with radeon_audio_enable().
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2236
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> Note: this is the additional fix on top of the previously submitted
> audio component support for radeon.

Applied.  Thanks.  I'll squash this in with the other patches.

Alex


>
>  drivers/gpu/drm/radeon/radeon_audio.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/radeon/radeon_audio.c
> index 71b67d4efe08..d6ccaf24ee0c 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -747,6 +747,7 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
>                                           unsigned char *buf, int max_bytes)
>  {
>         struct drm_device *dev = dev_get_drvdata(kdev);
> +       struct radeon_device *rdev = dev->dev_private;
>         struct drm_encoder *encoder;
>         struct radeon_encoder *radeon_encoder;
>         struct radeon_encoder_atom_dig *dig;
> @@ -754,19 +755,19 @@ static int radeon_audio_component_get_eld(struct device *kdev, int port,
>         int ret = 0;
>
>         *enabled = false;
> -       list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> -               const struct drm_connector_helper_funcs *connector_funcs =
> -                       connector->helper_private;
> -               encoder = connector_funcs->best_encoder(connector);
> +       if (!rdev->audio.enabled || !rdev->mode_info.mode_config_initialized)
> +               return 0;
>
> -               if (!encoder)
> -                       continue;
> +       list_for_each_entry(encoder, &rdev->ddev->mode_config.encoder_list, head) {
>                 if (!radeon_encoder_is_digital(encoder))
>                         continue;
>                 radeon_encoder = to_radeon_encoder(encoder);
>                 dig = radeon_encoder->enc_priv;
>                 if (!dig->pin || dig->pin->id != port)
>                         continue;
> +               connector = radeon_get_connector_for_encoder(encoder);
> +               if (!connector)
> +                       continue;
>                 *enabled = true;
>                 ret = drm_eld_size(connector->eld);
>                 memcpy(buf, connector->eld, min(max_bytes, ret));
> --
> 2.35.3
>
