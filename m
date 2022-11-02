Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41B616187
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKBLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKBLNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773E29372
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs21so24013103wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hFXoRnPy1WdfghTVJbVUy2MF553rUGFfljaSrg4rUnQ=;
        b=X0FmawncYsbBULeTZ+9pbryjZdPgHzl2ChG9z+lO4BnPr4a4EwCVSfkiWUSeDQdpQK
         xUk950tAiUPhTwnWw4rIGFHorpCvmVjbXQw2FuCQRhzxFPkkdxLR5ov8mJC6cfYqMZRL
         +f0KKanCYKDRl1cKhTMli7dFzTwhZc/nSQCxe9r0+cT5tiljcTb89Fa+0Zp7QUfq0iG7
         seqj7UcmwivogFyEejZNm2Wz+BxbZAHTzAqT6GRIcoN9Bu2JynATgwMnkS9f/VZYrRj2
         Nug1sb5SHmijABaoqZUwQeYQUxerqSC3ukk5m9u90zWszHMZgNnOsaGGWokKSiKi0LYh
         y2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFXoRnPy1WdfghTVJbVUy2MF553rUGFfljaSrg4rUnQ=;
        b=MunvB3/uo5f9rumjOoB6kqOcZSkx3xIuC7Ctyj77vM/gAio+XThbGd/lohCfr19aeU
         84rfNBRL/ggmJGMOSy9Q7rnMYlisD1rz412P2LAz4AbXufulwbvp8BU/h6VFx6NUYh4I
         24r6OsXuPCLFgLrVGNe1hI5n4dw9k59CeusnEhdCOAGR5ziEHAUBy4ZKoBXIKMN/xnmN
         653mHB8ZfPYyNovlYeTDJ0SxB+7WP8H2Cj8cqNuTJ9gjF+jdWkEb6sa+gnqIOqE61aZw
         M1jLOU++Uau/xFfogwASSpmg8VjzOKM85yGWTEI/W9gjYhabVXZvBMby0wtZ+6UBfJvv
         /KRA==
X-Gm-Message-State: ACrzQf0AAQT1r/NywOO0qrPKXPxcjq/y/P7Vz3hhU4MEza3MwflBJAUC
        w0KYmHPrCfHUBqXMkG5jcaA=
X-Google-Smtp-Source: AMsMyM5vSW/BtZTYdHGLRdtwds2gXNx9Wg8ozs72+a31ijLePU4PmDye71cCT+6nikKajSoH1ciboA==
X-Received: by 2002:a05:6000:1372:b0:236:bf8e:a78c with SMTP id q18-20020a056000137200b00236bf8ea78cmr11860295wrz.197.1667387406191;
        Wed, 02 Nov 2022 04:10:06 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id h3-20020a5d6e03000000b002365730eae8sm12430524wrz.55.2022.11.02.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:10:05 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:10:03 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     emma@anholt.net, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: Fix pointer dereference before check
Message-ID: <20221102111003.GA3233@elementary>
References: <20221029093413.546103-1-jose.exposito89@gmail.com>
 <20221102090153.tujblkvd3jlhdtxr@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102090153.tujblkvd3jlhdtxr@houat>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thanks a lot for looking into the patch.

On Wed, Nov 02, 2022 at 10:01:53AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Oct 29, 2022 at 11:34:13AM +0200, José Expósito wrote:
> > Commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug") introduced
> > the vc4_hdmi_reset_link() function. This function dereferences the
> > "connector" pointer before checking whether it is NULL or not.
> > 
> > Rework variable assignment to avoid this issue.
> > 
> > Fixes: 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index 4a73fafca51b..07d058b6afb7 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -319,9 +319,9 @@ static int reset_pipe(struct drm_crtc *crtc,
> >  static int vc4_hdmi_reset_link(struct drm_connector *connector,
> >  			       struct drm_modeset_acquire_ctx *ctx)
> >  {
> > -	struct drm_device *drm = connector->dev;
> > -	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> > -	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
> > +	struct drm_device *drm;
> > +	struct vc4_hdmi *vc4_hdmi;
> > +	struct drm_encoder *encoder;
> >  	struct drm_connector_state *conn_state;
> >  	struct drm_crtc_state *crtc_state;
> >  	struct drm_crtc *crtc;
> > @@ -332,6 +332,10 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
> >  	if (!connector)
> >  		return 0;
> >  
> > +	drm = connector->dev;
> > +	vc4_hdmi = connector_to_vc4_hdmi(connector);
> > +	encoder = &vc4_hdmi->encoder.base;
> > +
> 
> I don't think that's right. Connector shouldn't be NULL to begin with,
> how did you notice this?
> 
> Maxime

This issue was reported by Coverity. At the moment this function is not
invoked with a NULL connector by any code path. However, since the NULL
check is present, in my opinion, it makes sense to either remove it or
make it usefull just in case the preconditions change in the future.

But at the moment, this is not a big deal.

Thanks,
Jose
