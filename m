Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F1564D263
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLNW3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:29:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067F4B1C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:29:38 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m18so47995824eji.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bSdi2nTZFfN0KO3twl810Uns3X1CbpenS2xYlJiGPM=;
        b=QS+/BUVNsbN6h+tQwIBW7N0LXW4/Jg584fdK+n867YoxGH2EVT3pvpOv0U+9ZxfOF/
         rC+A8JiiEJr2R7MGbILNYNFTad0rr0C8KD/sy/c1V8PbqBkKH32/xb29IPq+heVzZkXp
         klpRQ11wYfFmdLXqkEepJLbDXUndJHe8njFAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bSdi2nTZFfN0KO3twl810Uns3X1CbpenS2xYlJiGPM=;
        b=q0MyNNfRN0L7UH37Q7pv4vo9yiFIrDFq6EiMVGCHgV0cT5qXPSgD6EeCOo8ApxRxaW
         flmWnfUVKFfe/TwQrWiyS5pSSBHhy8lUrbro30xaB4SjdBdy3G6la8O7G0TBOjIf59K8
         EvH9aW9MI13bQwIqaGVVahI1DiZxc4P1Vv3cIUgiUdvT1X4UHcxl2c1u6n1iXKhoJB57
         GAY+9vjRulTeRTrqx+QSyegkqXqnduHEiqV9f4yIw0XL9X9OzrFEkSg7O1Q049dkT1tp
         yOpcWDoJM+/G/CMZVhOVVGlqoBe0x+8jLLZjUDnHOXm4Y8ur4fXuWN2OFELMLpjZ1pZ+
         1fHw==
X-Gm-Message-State: ANoB5plT6o52RQ33Da2Lf4hpq/akc5/EhHqIioulEUTZ4ZCqABlrGzqw
        4HO+f12FcTa7D9/6/n8/kBkO/I+OCiIi4aT2bJs=
X-Google-Smtp-Source: AA0mqf4zSdfAb2h8QTSCI2C/sPMtUTkPkYE0yJC0G1vWMGcokv4bKARuGoVEEAzRdSGc0RwugTXPhw==
X-Received: by 2002:a17:906:408e:b0:7c0:eba3:e2e with SMTP id u14-20020a170906408e00b007c0eba30e2emr20452325ejj.31.1671056976375;
        Wed, 14 Dec 2022 14:29:36 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906055100b007806c1474e1sm6177648eja.127.2022.12.14.14.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:29:35 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso573079wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:29:35 -0800 (PST)
X-Received: by 2002:a05:600c:2d91:b0:3d0:69f4:d3d0 with SMTP id
 i17-20020a05600c2d9100b003d069f4d3d0mr191822wmg.93.1671056974914; Wed, 14 Dec
 2022 14:29:34 -0800 (PST)
MIME-Version: 1.0
References: <1671052890-11627-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1671052890-11627-1-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 14 Dec 2022 14:29:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UTeCU7BcfPMXz8J-9uOp_7Fn9PFdtFMsu46x5wKa0RyQ@mail.gmail.com>
Message-ID: <CAD=FV=UTeCU7BcfPMXz8J-9uOp_7Fn9PFdtFMsu46x5wKa0RyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: do not complete dp_aux_cmd_fifo_tx() if irq
 is not for aux transfer
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 14, 2022 at 1:21 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> There are 3 possible interrupt sources are handled by DP controller,
> HPDstatus, Controller state changes and Aux read/write transaction.
> At every irq, DP controller have to check isr status of every interrupt
> sources and service the interrupt if its isr status bits shows interrupts
> are pending. There is potential race condition may happen at current aux
> isr handler implementation since it is always complete dp_aux_cmd_fifo_tx()
> even irq is not for aux read or write transaction. This may cause aux read
> transaction return premature if host aux data read is in the middle of
> waiting for sink to complete transferring data to host while irq happen.
> This will cause host's receiving buffer contains unexpected data. This
> patch fixes this problem by checking aux isr and return immediately at
> aux isr handler if there are no any isr status bits set.
>
> Follows are the signature at kernel logs when problem happen,
> EDID has corrupt header
> panel-simple-dp-aux aux-aea0000.edp: Couldn't identify panel via EDID
> panel-simple-dp-aux aux-aea0000.edp: error -EIO: Couldn't detect panel nor find a fallback
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index d030a93..8f8b12a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -423,6 +423,13 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
>
>         isr = dp_catalog_aux_get_irq(aux->catalog);
>
> +       /*
> +        * if this irq is not for aux transfer,
> +        * then return immediately
> +        */

Why do you need 4 lines for a comment that fits on one line?

> +       if (!isr)
> +               return;

I can confirm that this works for me. I could reproduce the EDID
problems in the past and I can't after this patch. ...so I could give
a:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'm not an expert on this part of the code, so feel free to ignore my
other comments if everyone else thinks this patch is fine as-is, but
to me something here feels a little fragile. It feels a little weird
that we'll "complete" for _any_ interrupt that comes through now
rather than relying on dp_aux_native_handler() / dp_aux_i2c_handler()
to specifically identify interrupts that caused the end of the
transfer. I guess that idea is that every possible interrupt we get
causes the end of the transfer?

-Doug
