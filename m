Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E890D71883C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjEaRNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEaRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:13:03 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B5E19B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:12:42 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4573697b2cdso1625233e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685553161; x=1688145161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ha/IiHaH5j6Z2Cbh1nO+UGmSDQbqB1V+I93hhUI/9O8=;
        b=mhhJO60JV+y4yC2WvXQhRUZyuDqeajiEG8mRNQu0Z11kY7HL+8EAExQLenYZqH7z+2
         2Mzuf9o4IusHjj3MIZfkmPEGuHE5kI6AlerYuypAxDa9bcVAgVZ5UDmC8L+8kB35CRLQ
         PLG+y1whclaJ2hDGwEHNZhA0uec3QSAi4hM9WfzLBBAVV1fN0YEEr/40yZPpgQzFvTt2
         7rEhfgpLsOrEd35guANV18iRfJ+4089lf/mkJToW6y72IHKvYr5/tv6Jf15oIxwmEN2P
         KBD4pK9y5HmuoSr5dGUw0aDtS6LEuwi2zPBapnZ9fOR4sYBv5bsmBaySBb1FXslIxQiH
         882A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553161; x=1688145161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ha/IiHaH5j6Z2Cbh1nO+UGmSDQbqB1V+I93hhUI/9O8=;
        b=dMHtq6JBu6PUY8fX4x0Zpj8Rht83rqhKxhh7KXKfKRLup3hXJK0tzQN2fSeMNVNClu
         aYKd+LdfxcLflRh9Da+QFkkII1H/ynns/sIq0WqbLF3NmKZp0UoM+EL70oK5kWcCKh0s
         CEQo2D7KbSwJqRSCoVz8hHmCzCxW/CQUNjwsO+qzkmk6TadjOgfWjGeYd4jmnfGu7VGy
         G4BV3IuNLxeZSPuB6damE7s7hHu9WnJBOsThU39SRBbCE1RZYlWtzPOucyrsnXwAjIcX
         p+nVrbEYlgam/pg3+/ffrDbeh0FJfE9di+/BzXu+iTjjCdBjghCSd9U+v6oIm7jo5OU1
         EZLg==
X-Gm-Message-State: AC+VfDxu5wqgxwDdcH5Gz3tf1WFsDAdpmyMJWgucN9t5sXoQEgQYza3G
        LZIYwYGLY8TKLAljnIrmr0DA0Alz4b31EK+ssIC4uTNpGJ1+WYqt12Y=
X-Google-Smtp-Source: ACHHUZ6oRlQHMt3xDrn+41gUpjU+uA1RCTiAOhFhwhwc1iVr5n/7DlebDHtwxCujodDYMCeRKw4G+OdExuKthRhprqg=
X-Received: by 2002:a1f:cb44:0:b0:457:2d6a:7b4d with SMTP id
 b65-20020a1fcb44000000b004572d6a7b4dmr2205147vkg.10.1685553161697; Wed, 31
 May 2023 10:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
 <1685464318-25031-3-git-send-email-quic_khsieh@quicinc.com>
 <dfa12c8b-ccec-261c-9c83-54536e17c02d@linaro.org> <157e8219-7af2-c7ed-6d99-3caa6fbc11ba@quicinc.com>
In-Reply-To: <157e8219-7af2-c7ed-6d99-3caa6fbc11ba@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 31 May 2023 20:12:31 +0300
Message-ID: <CAA8EJponkEne2vVsNP=2Fxmv=Uc6i_LzAGBSEz9hPPotCEpGzg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dpu: retrieve DSI DSC struct at atomic_check()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 at 18:41, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
>
>
> >>   +    if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
> >
> > INTF_DSI
> >
> >> +        struct drm_bridge *bridge;
> >> +
> >> +        if (!dpu_enc->dsc) {
> >
> > This condition is not correct. We should be updating the DSC even if
> > there is one.
> >
> >> +            bridge = drm_bridge_chain_get_first_bridge(drm_enc);
> >> +            dpu_enc->dsc = msm_dsi_bridge_get_dsc_config(bridge);
> >
> > This approach will not work for the hot-pluggable outputs. The dpu_enc
> > is not a part of the state. It should not be touched before
> > atomic_commit actually commits changes.
> where can drm_dsc_config be stored?

I'd say, get it during atomic_check (and don't store it anywhere).
Then get it during atomic_enable (and save in dpu_enc).

> >
> > Also, I don't think I like the API. It makes it impossible for the
> > driver to check that the bridge is the actually our DSI bridge or not.
> > Once you add DP here, the code will explode.
> >
> > I think instead we should extend the drm_bridge API to be able to get
> > the DSC configuration from it directly. Additional care should be put
> > to design an assymetrical API. Theoretically a drm_bridge can be both
> > DSC source and DSC sink. Imagine a DSI-to-DP or DSI-to-HDMI bridge,
> > supporting DSC on the DSI side too.
>
> Form my understanding, a bridge contains two interfaces.
>
> Therefore I would think only one bridge for dsi-to-dp bridge? and this
> bridge should represent the bridge chip?
>
> I am thinking adding an ops function, get_bridge_dsc() to struct
> drm_bridge_funcs to retrieve drm_dsc_config.

So, for this DSI-to-DP bridge will get_bridge_dsc() return DSC
configuration for  the DSI or for the DP side of the bridge?

>
> Do you have other suggestion?

Let me think about it for a few days.

-- 
With best wishes
Dmitry
