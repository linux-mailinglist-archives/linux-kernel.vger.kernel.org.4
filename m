Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08856DDE57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDKOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDKOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:43:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF14E1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:43:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2ef70620b9dso636880f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681224234;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFrLw6zphVlz4pdr5/y9hU7mKuJn6EFgXAarb/1MgNg=;
        b=ZvwZhETovVk3TNd1NTc1Ua8qAcJSs/foIRtPU+hMn5Q7FURVX3wJ4Fd+t7q3IFFrba
         H1xdsCS1OSNc5YLTm3tftfl++EViYGf6qVGUDhKKuwZ7Y8T1iHzERzuLGwlkbXxAXUPE
         7oY0oKhiwLnCPPLnol2/uQ4Q6L0mQ80dsmFmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681224234;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFrLw6zphVlz4pdr5/y9hU7mKuJn6EFgXAarb/1MgNg=;
        b=rRUaFsppxXhAuoXB5glaFlLI6a3S7a3zDV6/hhjxG05wW4H04YLjbUXRxPS7jXpnI4
         RWuUl88jAQ8QkyT2umn1IK5kdXLIKBzT0wyFAvdMLRI56bPA7FEBDPtfE3+2G2kLO1Yc
         /RHEtyiSiR8ws5cIwBGiZ3nf13c3bhAXqxht5kz9Usqq6j/hEpnAQKBRFUngFxIyeLN9
         TF5OEjNrS0/gBB0vnUI83pUcRvWDiMyINJDJNMVFzX1JHg/G4J2UnfBq5A/sKA8NRMuh
         F2Uk9QUt6S/XYusj/8jhsrC3xNtwJDMobu8EwnNO3KAABnXhY5XnXXyz6lVlQw8ZjnkU
         Lr6Q==
X-Gm-Message-State: AAQBX9fTyenqFDl0y7tULc3V7yLaT34bvkm0G1sCb293WoxI6g19B2W8
        Uyy3rAod/JhVb8URh/q97LpfXg==
X-Google-Smtp-Source: AKy350YfCjAzBtozcHyDcYRR5tTo5Fu2xDGWfVpf+b9HpvPB8lFaCOrEdiiGsq5gGvLyZ2MSv4KFhQ==
X-Received: by 2002:a05:600c:4408:b0:3ed:793d:9dd6 with SMTP id u8-20020a05600c440800b003ed793d9dd6mr8083422wmn.1.1681224233907;
        Tue, 11 Apr 2023 07:43:53 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c214700b003eb966d39desm17370123wml.2.2023.04.11.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:43:53 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:43:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/drm_plane.h: fix grammar of the comment
Message-ID: <ZDVyJ4AQLW7deNhH@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Sui Jingfeng <suijingfeng@loongson.cn>, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
References: <20230409131547.494128-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409131547.494128-1-15330273260@189.cn>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2023 at 09:15:47PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Applied to drm-misc-next, thanks

> ---
>  include/drm/drm_plane.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 51291983ea44..79d62856defb 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -56,7 +56,7 @@ struct drm_plane_state {
>  	/**
>  	 * @crtc:
>  	 *
> -	 * Currently bound CRTC, NULL if disabled. Do not this write directly,
> +	 * Currently bound CRTC, NULL if disabled. Do not write this directly,
>  	 * use drm_atomic_set_crtc_for_plane()
>  	 */
>  	struct drm_crtc *crtc;
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
