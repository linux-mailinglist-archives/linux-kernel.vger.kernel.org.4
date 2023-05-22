Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9A70CAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjEVUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjEVUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F3A10D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d44b198baso1848133b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786568; x=1687378568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
        b=a4/oSrRQtWRLaqbqVFZWY7qrHna387jLw1QMQLYbleIE1kd7KUiXqNFbF1hj/qyxeL
         u1g/ZpYLS57Lq8SdoOE1vTW6fiOdToSwphBQ415xl1AvhSYo0HTQyvVR5Fe4UifeqLOh
         hGHUHAnxcE/O6kVjnzpWzBPmEl0VRTz/fDV2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786568; x=1687378568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzlAGM8RQ6FHyn5tETnI+sMMAIwviCvOlXcFSHD1eAE=;
        b=EBxsU/JhIdxbCTPK310iNiEFH3XPA8l4ozIg4mtRGBdo21P4bMOvHbAG2Tyi0LgA9d
         S+L5bIkVQsoWHOY4n5G3ksmhn47U6szVGMMk/TT1S1b0yjYTdTUv055AcL2Np+fKYc9q
         lIC6n81uwVoFApCZ2qeRtaBoBXQGJqZVXLYG4REaZ1VBAQyNZjS4oZsG+ZoyX52s9VRF
         /H6cuUiASuUaL2RdBynuV1QqO8D+/lw98Erkl/QmRSIeQvFo4XRdBvFI0dQ+oYHKkj14
         5V2MNqFM3+0gsdO4a/D5bHk6hGRduXnVVIierOT/tC5yh9TD25cpoMKV13up8CEvpfvD
         smFA==
X-Gm-Message-State: AC+VfDzc2rIaNxq0K1MLMTwGSx3Mba6hrGEn5RimOeKQ3EBPZP4JRKy/
        ri9txZgmhBMQkrQlKR6Kwv/YWA==
X-Google-Smtp-Source: ACHHUZ7kSdg7lvscJChRXHco/lZQNRpJ7GeHs3ZD/B6Dkut0O0hFkEBB9llB/7LICw3wA0pe6/GJnA==
X-Received: by 2002:a05:6a20:428f:b0:10b:c843:9522 with SMTP id o15-20020a056a20428f00b0010bc8439522mr3203020pzj.20.1684786568532;
        Mon, 22 May 2023 13:16:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020aa78612000000b0063b7c42a070sm4508531pfn.68.2023.05.22.13.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:16:07 -0700 (PDT)
Date:   Mon, 22 May 2023 13:16:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Evan Quan <evan.quan@amd.com>, linux-hardening@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/pm: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305221316.038CDF6B@keescook>
References: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522155245.2336818-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:52:45PM +0000, Azeem Shaikh wrote:
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
