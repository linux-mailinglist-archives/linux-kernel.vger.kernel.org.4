Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4678C6D7729
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjDEIno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:43:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E17271C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:43:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-4fd1f2a0f82so11039a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680684220; x=1683276220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HN6lXiiJx4/5yCFxwqdcj1SL/T1KBmY3SBfRwXs2JTU=;
        b=FjY3F5Z5GXioXNULwvJZp8rKLWxXRgzzxFf+3IP/jr6oD20oQzlx9iRVMpX04NnKGO
         Zh/Zi1vcgPtDJuqazXE3BDRb2JH8riq84m9wbQaKEXvsRFEzFwib2Nb0MxgioV5jEJV7
         xYc2XnqEkwJaqmdTKEiK5hUo5kUn/h5ZNjNVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680684220; x=1683276220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN6lXiiJx4/5yCFxwqdcj1SL/T1KBmY3SBfRwXs2JTU=;
        b=PdTpqJuHyOOltyn8o0UX1BWo35bhhKVmtfm2gPBS655tVL+UXd20lrKXAuZLhEAGjg
         Tls5VUiqXl63xnum3cPoNaXJZtni5xsZAm21e6o9/0F9hac74DfLaTdrBDTPzCMaE7W7
         ax3Nt06cTXNcC2pI7bVi0RvpFOJvkXMB0fU2/5GfcewXl+uNyytJXX4XJJs1fV8pSAB2
         es1w+Fc1rVJ0m4HLNLQbCvIMe2h+jMLA6Rh68Crk9J1SL64z4f0mtcXdks70Bgwqxn52
         qDxGMqzcvx2vbs0AODdmiM+AiYBV37/sTv+JKu2Oxe4mP3VbHdi1UM8GHXPJJiNUiSPS
         gOrg==
X-Gm-Message-State: AAQBX9ceQ6TVRN0sNswB938wSSiC0ApJ1SWecC/5PmahPRWGXP5IiZCb
        ZFntiKMb10moBkdNyD12o9wNfw==
X-Google-Smtp-Source: AKy350beKEdSQvvyhgJajFb9f2flrdfUuMkXgrhX3Rp6i3c9rA5VvvLwSh0DDm0+MAesQ5cXy+Yyig==
X-Received: by 2002:a05:6402:268e:b0:502:ffd:74a1 with SMTP id w14-20020a056402268e00b005020ffd74a1mr1156509edd.2.1680684220218;
        Wed, 05 Apr 2023 01:43:40 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id k1-20020a1709062a4100b009477ba90a85sm7062009eje.69.2023.04.05.01.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:43:39 -0700 (PDT)
Date:   Wed, 5 Apr 2023 10:43:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>, yq882255@163.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH 0/3] Revert lima fdinfo patchset
Message-ID: <ZC00us/xrcQohID6@phenom.ffwll.local>
Mail-Followup-To: Qiang Yu <yuq825@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>, yq882255@163.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Erico Nunes <nunes.erico@gmail.com>
References: <20230404002601.24136-1-yq882255@163.com>
 <CACvgo53mV7Aoe+omtSF0BNg+gVOWqDQ_QAmMkhikjQw-vF55Xw@mail.gmail.com>
 <ZCx6Q5y1dgAv2q/o@phenom.ffwll.local>
 <CAKGbVbssdy3D8iCyUHr-kqr8spSDkTXfKzg4pQwoSZB+dv3i0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKGbVbssdy3D8iCyUHr-kqr8spSDkTXfKzg4pQwoSZB+dv3i0A@mail.gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 08:50:06AM +0800, Qiang Yu wrote:
> Applied to drm-misc-next, sorry for the trouble.

No worries, I already complained to Lucas/etnaviv people that the sched
revert should have been at least posted/discussed on dri-devel. Imo this
isn't on you.
-Daniel

> 
> Regards,
> Qiang
> 
> On Wed, Apr 5, 2023 at 3:28 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Apr 04, 2023 at 04:17:33PM +0100, Emil Velikov wrote:
> > > On Tue, 4 Apr 2023 at 08:13, <yq882255@163.com> wrote:
> > > >
> > > > From: Qiang Yu <yuq825@gmail.com>
> > > >
> > > > Upstream has reverted the dependant commit
> > > > df622729ddbf ("drm/scheduler: track GPU active time per entity""),
> > > > but this patchset has been pushed to drm-misc-next which still
> > > > has that commit. To avoid other branch build fail after merge
> > > > drm-misc-next, just revert the lima patchset on drm-misc-next too.
> > > >
> > >
> > > The bug/revert is unfortunate, although we better keep the build clean
> > > or Linus will go bananas ^_^
> > >
> > > Fwiw for the series:
> > > Acked-by: Emil Velikov <emil.l.velikov@gmail.com>
> >
> > Can you (eitehr of you really) please push asap and make sure this doesn't
> > miss the last drm-misc-next pull (-rc6 is this w/e)? Otherwise we'll have
> > a bit a mess.
> > -Daniel
> >
> > >
> > > HTH
> > > -Emil
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
