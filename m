Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744AB70CA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjEVUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjEVUPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:15:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789A184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3742920b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786532; x=1687378532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUSVdvb79gbFeSBJR73SGjUk4u7N4upLsGKBG6cFJho=;
        b=d11p2MvCaOb9DoRlM6AqC75l9/TUamQDOrS4u48NcKgH9GH6J4JPrMKK18a8tUR/LU
         iYPejOwfb9QSEG/SUBcp0ItD07IbC5SLO/puDtWsARfYOpbtRDOshBvSPAvq3U97snGU
         Rl/nd1M85ilGLAVKdf7X5MSSGgcMUqX1gysQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786532; x=1687378532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUSVdvb79gbFeSBJR73SGjUk4u7N4upLsGKBG6cFJho=;
        b=Bo12kpavbJ14aTdjN3BLc1OgeTPavOR6yuODQW1AqfG//TSR/Egq3DzbBt2DFAt/Bv
         tGrJcXuWQUzNCa7A1XalU9CkS28PLTCFFY+dtgdKNTc4CqmeAj9Ns6GMZieEyRcB0ii8
         6n4QaHrxG6biFfAEzBpwWhZntMYj/3/dKVaOKI0rHV+SFVhhiWLTuGzaf+9Vwky/+jbN
         WnjadzX7vqZbqR4Eo7nv6e1T8h4X92O7HnT0qW5WOuR4Ekyv44wwgFYfOU2GWZxqAHKf
         xgj+U418T3o0jHg81SPoX61n+vilXYfOauW/UcOkof4n0IOtDVo81DifN1ZqhIPUiKHl
         7ujg==
X-Gm-Message-State: AC+VfDyar/0cJtCbZ9hn5HL5vtP/I0l4BkpOle6ukna/DuIupFgnepvw
        WNE8A8MYtcYSG1BP2gzRf0jWUA==
X-Google-Smtp-Source: ACHHUZ4VR/bDiX3LTGczRv0D8hkVMKl4vQGKQDUaV1gV6VAWekr1r6jnhzrZ2egrciE2eQESOZ5R/A==
X-Received: by 2002:a05:6a00:2282:b0:63f:18ae:1d5f with SMTP id f2-20020a056a00228200b0063f18ae1d5fmr16955940pfe.29.1684786532020;
        Mon, 22 May 2023 13:15:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m8-20020aa78a08000000b0063ba9108c5csm4585207pfa.149.2023.05.22.13.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:15:31 -0700 (PDT)
Date:   Mon, 22 May 2023 13:15:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        linux-hardening@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Maxime Ripard <maxime@cerno.tech>,
        Lucas Stach <l.stach@pengutronix.de>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: dw-hdmi: Replace all non-returning strlcpy
 with strscpy
Message-ID: <202305221315.8E1A18B4A@keescook>
References: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155210.2336690-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:52:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
