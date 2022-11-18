Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84462F73D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiKROZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiKROZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:25:54 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC093EE36
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:25:53 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id h132so5503269oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5LuCmVD+3CzNfg5KR+7IARdB1H73xIJwmBWKt3WBdb0=;
        b=qp9ji3g1Zto5tl8YjmqzsfnUJw0MjS+im5UISNC927DOLiSAZeOWqJS1103QMHndmo
         CcZ4m8Y/9u28kXeEwm9+vg551FXvA5XalaJwyj9evGvu31EoMNmccD4e61+b6IFaM4IS
         JKDtC9pGdsqZPJAKsoicJqoCFYEPuFTNDCtxyvtpP5bSlrziBdOdmkPgH04xSOKoYXSR
         cGIbeZkF99rGAf3aS+sWzWv4JnB6DCBjc7du32dAMsTFV0YvU3a7AnQmgmG55LVmN1D/
         r22dmthkpcTX4OBYEGs1TOuuA5madt85KzlHMV0IAT7GA5d5BEznYTJsFLMfOw39DJFa
         q27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LuCmVD+3CzNfg5KR+7IARdB1H73xIJwmBWKt3WBdb0=;
        b=6u9OeOb8w/d9V0FwmIxpbN7365WGn5V+uy3J6WdX38Q7H4LVUL/HVM8QlIpEF8jGY5
         xWJ+Oqu1AwTxMT5+jaGZMPkN6D0HzVNrZ2GMiYk/E04zwBpMDPcWTczCXSXGl1MpHjRk
         hdw8RPe2+yjkTCaLgkmxn28f4k/rnsHKpmxV4kizlN2Wc0IG6D+810HzSGmiUiRQ78TG
         IeO0wC/j+ibl61zBvSrvvFShpZBJHXvQ3kcDU6y8WpH7Rm9Gev+CxfWX7/YT82Hz3++K
         wZptlDj/AtHbpnKzNsfx3oe7fwMGtoY3ivY/yV16BaFjZpjuHEi2m4dp7GlxRAXufrFa
         v3ug==
X-Gm-Message-State: ANoB5plcFdFlgz68kieDN+/fEruJ5l3Lnf1lWXtwz8RuSI4IErrWf3Mv
        No22f9JHYw4U8gojl7pPsUxvgL4/ldeIuRCRf6c=
X-Google-Smtp-Source: AA0mqf7hOTbTOfZDgLxwFZCFP25720NR4mjhlMjriyEEj6DGWfet0Wlz+nn0zLwKCQI1Hx0PTQ6xYT24UR7wr+L4CbE=
X-Received: by 2002:a05:6808:295:b0:357:670f:9e4e with SMTP id
 z21-20020a056808029500b00357670f9e4emr6631793oic.46.1668781553121; Fri, 18
 Nov 2022 06:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20221118115306.128293-1-arefev@swemel.ru>
In-Reply-To: <20221118115306.128293-1-arefev@swemel.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Nov 2022 09:25:41 -0500
Message-ID: <CADnq5_MP6Fz6gm=vc74U8sc6SgZy1D+39ZQX48zdiWzf+24tTw@mail.gmail.com>
Subject: Re: [PATCH v2] amdgpu: nbio_v7_4: Add pointer check
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        lvc-project@linuxtesting.org, avid Airlie <airlied@linux.ie>,
        trufanov@swemel.ru, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vfh@swemel.ru,
        amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Nov 18, 2022 at 9:11 AM Denis Arefev <arefev@swemel.ru> wrote:
>
> Return value of a function 'amdgpu_ras_find_obj' is dereferenced
> at nbio_v7_4.c:325 without checking for null
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index eadc9526d33f..0f2ac99de864 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -304,6 +304,9 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>         struct ras_err_data err_data = {0, 0, 0, NULL};
>         struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>
> +       if (!obj)
> +               return;
>

I don't think we could ever get here with a NULL obj.  This is part of
the interrupt handler for NBIO RAS, so the interrupt would never be
enabled in the first place if the obj didn't exist.

Alex

>         bif_doorbell_intr_cntl = RREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL);
>         if (REG_GET_FIELD(bif_doorbell_intr_cntl,
>                 BIF_DOORBELL_INT_CNTL, RAS_CNTLR_INTERRUPT_STATUS)) {
> --
> 2.25.1
>
