Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDA700E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbjELSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbjELSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:03:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6002E7D99
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:03:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso11976155e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683914609; x=1686506609;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wX35csAzyFHnVisSwqQUmM55/FGS5IjRbvk+3PARSIY=;
        b=a2Os8llOt9vV1D4eCwmkRQkI93Uuz+OU3+OIRl91Nfqe9ZdY/2B1baxq5/RehZ+bnH
         xnTjq4XE25UxjQYy4DCsC+1WQcCU1J+GolhL2n+ax8uSUVR965lCnABQ8vw6JEdtwYj1
         0acODiiyF9FyKH+A2EVY4zdhvv6ysNuSjeYVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683914609; x=1686506609;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX35csAzyFHnVisSwqQUmM55/FGS5IjRbvk+3PARSIY=;
        b=BBS4WanZbcZAvV4kpaYkI9yiYexgvYinOrUKPAkTAtwVoyfTkqSoTuPMwGySsDQ3K5
         yMH8rGaE6rbNLo8FM7ERzmTtZd+iGbWagh0dZBTadUT/XoZkoKOOPchsZxBnTu1PRyHh
         tfZ7rcgPYlwC1QRG69epqulDC4YQZtnSYFtGTk9prF19GFGlrGAYEZ5hy1uGVqe3bM0/
         stN0+XNICl5J7wsEgQCO9RBeP8e+Jog9xMR6Kqoi9KpJXHUJ5yRuXh0TtSYJrXJtCu9C
         Y1vQ9CPKjxd6zNKg6YbAZQ6IUjqBSu5f16GYc3FfrewVigvnaj1awhzibZPFvvVU9ufn
         4vmQ==
X-Gm-Message-State: AC+VfDxNFpdRYJV4zo0eccllmHAJaob9zNNIjicmbhHMP9WYH3OyP0T6
        c+dZuO3vN0YYcqeqh/JFKCjVAhIJvXNQtkUfWuUGf2lzqq/qqi4w
X-Google-Smtp-Source: ACHHUZ6PaqBOAHi370NUX7PmynPhgX949UwtsRLRySAJxMzlzmUq+lXxvttUdtc5tbCV15gkYvMmpUGa1Yv56ikLq3U=
X-Received: by 2002:a05:6512:21a9:b0:4eb:30f9:eeca with SMTP id
 c9-20020a05651221a900b004eb30f9eecamr3740062lft.28.1683914587723; Fri, 12 May
 2023 11:03:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 May 2023 11:03:07 -0700
MIME-Version: 1.0
In-Reply-To: <CAA8EJpokAoGni7vNwuijs7EvmjCweO3pgChij3Qx3OUkVTVpiQ@mail.gmail.com>
References: <1683750665-8764-1-git-send-email-quic_khsieh@quicinc.com>
 <1683750665-8764-2-git-send-email-quic_khsieh@quicinc.com>
 <CAA8EJprtQF0x_LCOTrt5bvRnJ+xRz6QxLF6QAP-4Pff6V5TJ2g@mail.gmail.com>
 <20230511155331.2jmfe7xcs5tihdgb@ripper> <5ef83699-01de-d062-6239-9bb834c70458@linaro.org>
 <8ac0b5f5-27da-2b28-8f10-b2fca447511a@quicinc.com> <CAA8EJpokAoGni7vNwuijs7EvmjCweO3pgChij3Qx3OUkVTVpiQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 12 May 2023 11:03:07 -0700
Message-ID: <CAE-0n51SHQhUJiY=BJp8CQQ1aTAOxeMDr2+NX_vpmjN_cyJJrA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/msm/dp: enable HDP plugin/unplugged interrupts
 to hpd_enable/disable
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, dianders@chromium.org, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@gmail.com, agross@kernel.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Baryshkov (2023-05-11 17:54:19)
> On Fri, 12 May 2023 at 03:16, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> > 1) DP with GPIO: No downstream drm_bridge are connected, is_edp = false
> > and internal HPD-logic is in used (internal_hpd = true). Power needs to
> > be on at all times etc.
> >
> > 2) DP without GPIO: Downstream drm_bridge connected, is_edp = false and
> > internal HPD-logic should not be used/enabled (internal_hpd = false).
> > Power doesn't need to be on unless hpd_notify is invoked to tell us that
> > there's something connected...
> >
> > - dp_bridge_hpd_notify(). What is the point of this check? <== i have
> > below two questions,
> >
> > 1) can you explain when/what this dp_bridge_hpd_notify() will be called?
>
> The call chain is drm_bridge_hpd_notify() ->
> drm_bridge_connector_hpd_notify() -> .hpd_notify() for all drm_bridge
> in chain
>
> One should add a call to drm_bridge_hpd_notify() when the hotplug
> event has been detected.
>
> Also please note the patch https://patchwork.freedesktop.org/patch/484432/
>
> >
> > 2) is dp_bridge_hpd_notify() only will be called at above case #2? and
> > it will not be used by case #1?
>
> Once the driver calls drm_bridge_hpd_notify() in the hpd path, the
> hpd_notify callbacks will be called in case#1 too.
>
> BTW: I don't see drm_bridge_hpd_notify() or
> drm_kms_{,connector_}_hotplug_event() HPD notifications in the DP
> driver at all. This should be fixed.
>

Is dp_bridge_hpd_notify() being called by
drm_helper_probe_single_connector_modes() when the connectors are
detected?

I see drm_helper_probe_detect() calls connector->funcs->detect() which I
think calls
drm_bridge_connector_funcs::drm_bridge_connector_hpd_notify() but I
haven't confirmed yet. The 'detect' bridge is the DP bridge in msm
driver

         if (!dp_display->is_edp) {
                bridge->ops =
                        DRM_BRIDGE_OP_DETECT |

so if the bridge_connector is being used then I think when fill_modes()
is called we'll run the detect cycle and call the hpd_notify callbacks
on the bridge chain.
