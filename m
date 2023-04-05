Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B926D7677
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbjDEIKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjDEIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:10:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424095272
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:10:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5002f12ccfeso5512a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680682217; x=1683274217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYng4RQQ65saANXRp3rGtw6wJ5XpKl4KZk/LZ3eaJXA=;
        b=W0rd5Bpgi1vliAc17Mz3poPX51Ck3XK/aFu3eyDWtMoFTsBpamjwatZZhbHkptinzk
         qOywYup0tGesJZgVgszoU0yCnqI7N0t2gZD+vCXBMYqIQZrK/bkKF3sH2Kk54IHUwg4H
         A5s2LlKiSixKGCLJC128ThGb7BHIMzFv4hGfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682217; x=1683274217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYng4RQQ65saANXRp3rGtw6wJ5XpKl4KZk/LZ3eaJXA=;
        b=L+As7Ywr8Nu4tDn25UnWOmk1w2zIgtlaAyyEuCKDDUEK8uZemsWSab5zzfNKALzAxI
         7M0E5tRG2OjqQUCOubcJNnou3Ou1nErVevy+eS+ZfnM6Wa4qHK8ohJPDtlq8WjQbvZG3
         TC3A3UDDJY23x0VsAVwpvlRvQS1RsPR0ymV9LggN+RPG/LvxomC6qOttLLNgxgeuuDCb
         wRhzDCFvdMLqF6GmnDuYwBNi8QlL+Gv9PhNKBGnHLGmjzyE6Hupfh6cRO8BPn7PU03Gc
         XZLq49P2lq6J97dCKZYtaI2yegIbgcd8XNntFM8wFdfK63w4b79798njBFBhHPI15tog
         tRiA==
X-Gm-Message-State: AAQBX9c9oSKeMdwfH3l/gzhCr1gBs5SNSwtRNvRyVg3O4Y5DvrU1lO+u
        +y++Ho+ZOFfWQsT1XSn5UP19wg==
X-Google-Smtp-Source: AKy350aujdeQuLMeiv17bxm63ZZuJ5mEe+xCY00PLtSuADQnzCEH5US5Oz8r6EVUL9Weg5aN500Geg==
X-Received: by 2002:a17:906:1d4:b0:92e:f520:7762 with SMTP id 20-20020a17090601d400b0092ef5207762mr1041803ejj.6.1680682217744;
        Wed, 05 Apr 2023 01:10:17 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id hg15-20020a1709072ccf00b00939e76a0cabsm7062067ejc.111.2023.04.05.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:10:17 -0700 (PDT)
Date:   Wed, 5 Apr 2023 10:10:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vblank: Simplify drm_dev_has_vblank()
Message-ID: <ZC0s56+O0bsQPmpC@phenom.ffwll.local>
Mail-Followup-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230403160735.1211468-1-robdclark@gmail.com>
 <ZCyMiERvNHTP45o8@phenom.ffwll.local>
 <ZCyP55f2CFQqtP0a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCyP55f2CFQqtP0a@intel.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 12:00:23AM +0300, Ville Syrjälä wrote:
> On Tue, Apr 04, 2023 at 10:46:00PM +0200, Daniel Vetter wrote:
> > On Mon, Apr 03, 2023 at 09:07:35AM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > > 
> > > What does vblank have to do with num_crtcs?  Well, this was technically
> > > correct, but you'd have to go look at where num_crtcs is initialized to
> > > understand why.  Lets just replace it with the simpler and more obvious
> > > check.
> > 
> > If you want to fix this, then I think the right fix is to rename num_crtcs
> > to be something like num_vblank_crtcs. It's a historical accident back
> > when vblanks without kms was a thing.
> > 
> > Plan B is someone gets really busy and fixes up the entire vblank mess and
> > moves it into drm_crtc struct. Now that the dri1 drivers are gone we could
> > indeed do that.
> 
> And easy first step could to simply wrap all the naked
> &dev->vblank[drm_crtc_index()] things into a function
> call with some cocci/etc. That way most of the vblank
> code doesn't need to care where that thing actually lives.

Yeah I think that might work out. Roughly:
- Wrap all the drm_vblank_crtc lookups
- Emebed it into drm_crtc, delete the drm_device->vblank array
- rename drm_device->num_crtc to something more meaningful maybe and move
  into drm_modeset_config

The big holdup always was step 2 because we still had to care about legacy
drivers without drm_crtc, which meant you'd have to have two paths, which
was kinda really annoying.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
