Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541B1660B6B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAGBV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbjAGBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:21:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB52610
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:21:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d15so3511863pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGp7XQc2VGbBDxiW6oPsPSq8rd+Pp+GUF89FSmtguMY=;
        b=ctHCqkF8lWWCEMvSMP9SB71dYd2YSRUg9u4uNjoTKAZOuhG9kNvAcXTqwBn8Pl6rDm
         o/rzUuIRcux5YaDdSV5Ygdm16fu+ymgygpIhROQBk1CdYiXLc6BAV0oHyT4CP24tQoAP
         BJLKuFdc8n/R4v9FAHU85MgPACIAHu0IsRGws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGp7XQc2VGbBDxiW6oPsPSq8rd+Pp+GUF89FSmtguMY=;
        b=IJmlYquGauN2kzTZxwExK44kOik9dd5ERB3Nq/Dkb1rqv3W1yBQro4BDG2LdspB+a3
         FOyl1PM1L7DNpt6JA26Mh5zQww1OxUSu9WI9d39sWvzaB0MtvVJVCdlH08XxdOBAsfeX
         wwwVRN5Jwx9e0sCUvpj7TU2bUFUbF3ETVMj2cBtyvGxj6jC9UWUuX+US8/9EEZsOQGDA
         NBlZZ3SR5RI0Ytneb3i0Q78hkixrvVdD3NI6KxNsBf44/EGJuZliYNvW1Ghlya1xLpFF
         2/V3w+3DuZFSb3j1WDVhAZMKCiBbXm4gsn8a8ZweCQ4xoavW5BMWWgPMJ6RoVvz+C1jo
         ovnA==
X-Gm-Message-State: AFqh2krO+IbqiDNcCgcCe7JZVtfxeRNMYy+FRWhmlizOXQX8KliMklJ/
        N9uRqYj8h7OC7kY3WETFLRuc7g==
X-Google-Smtp-Source: AMrXdXucd5QiL3Gpmu1dQs5wApEskRuwAtx0qubwZvtkLbZyghXUapggu1smjFX+LjoGpUNSoGZhlw==
X-Received: by 2002:a17:902:e354:b0:192:6aa8:e3d8 with SMTP id p20-20020a170902e35400b001926aa8e3d8mr46653793plc.28.1673054482918;
        Fri, 06 Jan 2023 17:21:22 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:bc4e:2cc9:68b3:15dc])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b00192b0a07891sm1545055plx.101.2023.01.06.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 17:21:22 -0800 (PST)
Date:   Fri, 6 Jan 2023 17:21:19 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/rockchip: vop: Leave vblank enabled in
 self-refresh
Message-ID: <Y7jJDw4RcNceyLbR@google.com>
References: <20230105174001.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
 <20230105174001.2.Ic07cba4ab9a7bd3618a9e4258b8f92ea7d10ae5a@changeid>
 <9455bc5b-2074-4f48-71a7-5c816ee19a78@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9455bc5b-2074-4f48-71a7-5c816ee19a78@mailbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:42:54PM +0100, Michel Dänzer wrote:
> On 1/6/23 02:40, Brian Norris wrote:
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > @@ -719,11 +719,11 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
> >  
> >  	mutex_lock(&vop->vop_lock);
> >  
> > -	drm_crtc_vblank_off(crtc);
> > -
> >  	if (crtc->state->self_refresh_active)
> >  		goto out;
> >  
> > +	drm_crtc_vblank_off(crtc);
> > +
> >  	/*
> >  	 * Vop standby will take effect at end of current frame,
> >  	 * if dsp hold valid irq happen, it means standby complete.
> 
> The out label immediately unlocks vop->vop_lock again, seems a bit pointless. :)

Oops, of course. Will change that in v2.

> AFAICT the self_refresh_active case should just return immediately,
> the out label would also send any pending atomic commit completion
> event, which seems wrong now that the vblank interrupt is left
> enabled.

If I return immediately and drop that completion, I hit a warning:

[    4.423876] WARNING: CPU: 5 PID: 58 at drivers/gpu/drm/drm_atomic_helper.c:2460 drm_atomic_helper_commit_hw_done+0xe0/0xe8
...
[    4.424036] Call trace:
[    4.424039]  drm_atomic_helper_commit_hw_done+0xe0/0xe8
[    4.424045]  drm_atomic_helper_commit_tail_rpm+0x58/0x7c
...

I plan to leave it as-is for v2.

> (I also wonder if drm_crtc_vblank_off doesn't take care of
> that already, at least amdgpu doesn't do this explicitly AFAICT)

I'm not sure.

Brian
