Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F4562E96F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiKQXT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbiKQXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:19:26 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41972136
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:19:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so3243023pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBG7oyaijsCs+AkyB480R7surFEt7JkA2k2VbS/kZYQ=;
        b=JchDDL5/DOlP6j9lUMlspTqgaFV4s9nwIJAsn96fhlHO8vmv5OjKer7ndNaH2Cz7xY
         angRwTwMUaQhTZSFCg5SSReYBynCN5+lVd/BZbbmZmTbg32Qo/D4UYmdS5qJQ4EuCLtb
         LRcO4Rhcd6sxfjWlyGEHMkaxsvRbTcjQPJJxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBG7oyaijsCs+AkyB480R7surFEt7JkA2k2VbS/kZYQ=;
        b=Iqo2qCbD5tbB4XZLLhrOKOYf6Y2tGcV9BYF8Dy3Xe0gxqYMs5DoqVt7fu70pN5LL+6
         RLuSE38qVSU+XkG9nM7Dlv9gPtX11WEjqjKcFZQiwnCuS+0AjAII3tTabxrLrKBFg9Cs
         cU4c3imhRsJfaBSWMEKbxh0xByKAK0JaNf5ZLvrBtERga2aM7uxsD2V3+kuV6UaeBlHW
         +rzdNCeJ+5KIttOgHu2b5CpbOBEdIdOesvTc4btc42i9kzO9aXDlNpKPwzEZH4Wer7yJ
         48YI32R1BEvJlu42Af0YW6ttN4U6NlmI9JECP1AxQRlV2QA5lVwI+U5fNUm4+B3YaDcA
         2ExA==
X-Gm-Message-State: ANoB5pm/1GP26V1LB83owsZRItyZLvY39TU8jpQm6b2YnlFSIhR0tPAO
        me48U2tXhwPwYzoNmNTEpQDJ+Q==
X-Google-Smtp-Source: AA0mqf5gYHTV4d1cJmSvcoc5/KxPzeS1y0Zb1fIaJiX9fjzOdUIlsRe1Bo/bjk0EkMpAHBf2HyMu/w==
X-Received: by 2002:a65:4c88:0:b0:477:55c:3ff4 with SMTP id m8-20020a654c88000000b00477055c3ff4mr4055311pgt.442.1668727164990;
        Thu, 17 Nov 2022 15:19:24 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 135-20020a62178d000000b0056ba6952e40sm1684386pfx.181.2022.11.17.15.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:19:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:19:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] drm/fsl-dcu: Fix return type of
 fsl_dcu_drm_connector_mode_valid()
Message-ID: <202211171518.88D58BBE@keescook>
References: <20221102154215.78059-1-nathan@kernel.org>
 <Y3K7GbHAMZPdY243@distrobox-ZFeO0pwFho.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3K7GbHAMZPdY243@distrobox-ZFeO0pwFho.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:03:05PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> On Wed, Nov 02, 2022 at 08:42:15AM -0700, Nathan Chancellor wrote:
> > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > indirect call targets are validated against the expected function
> > pointer prototype to make sure the call target is valid to help mitigate
> > ROP attacks. If they are not identical, there is a failure at run time,
> > which manifests as either a kernel panic or thread getting killed. A
> > proposed warning in clang aims to catch these at compile time, which
> > reveals:
> > 
> >   drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c:74:16: error: incompatible function pointer types initializing 'enum drm_mode_status (*)(struct drm_connector *, struct drm_display_mode *)' with an expression of type 'int (struct drm_connector *, struct drm_display_mode *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> >           .mode_valid = fsl_dcu_drm_connector_mode_valid,
> >                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   1 error generated.
> > 
> > ->mode_valid() in 'struct drm_connector_helper_funcs' expects a return
> > type of 'enum drm_mode_status', not 'int'. Adjust the return type of
> > fsl_dcu_drm_connector_mode_valid() to match the prototype's to resolve
> > the warning and CFI failure.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> > index 4d4a715b429d..2c2b92324a2e 100644
> > --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> > @@ -60,8 +60,9 @@ static int fsl_dcu_drm_connector_get_modes(struct drm_connector *connector)
> >  	return drm_panel_get_modes(fsl_connector->panel, connector);
> >  }
> >  
> > -static int fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
> > -					    struct drm_display_mode *mode)
> > +static enum drm_mode_status
> > +fsl_dcu_drm_connector_mode_valid(struct drm_connector *connector,
> > +				 struct drm_display_mode *mode)
> >  {
> >  	if (mode->hdisplay & 0xf)
> >  		return MODE_ERROR;
> > 
> > base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
> > -- 
> > 2.38.1
> > 
> > 
> 
> Could someone please pick this up so that it makes 6.2? We would like
> to try and get this warning turned on so that it can catch more
> potential run time issues at compile time but that can only happen when
> all the warnings are fixed.

I'll pick this up tomorrow if no one else snags it. :)

-- 
Kees Cook
