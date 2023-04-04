Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD456D6D21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbjDDT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjDDT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:28:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38340D5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:28:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn12so135004252edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680636486; x=1683228486;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCVmz0T8iHiHtH7a2wMYKMxDUPs6L8UFRcHeBvRmBAU=;
        b=W+yeEUVDtcLeK1sXdifY29Ljdfd3je0Eb7T4XfBZ+ltTmV+JKqnAYAsi3H0pOYhIl5
         jbc0tBu6ZFDMBXbGzHwFR5QCJYtTgpqblVF8invTekBzRx86hiOKlB0FZNOe5QoDEUSW
         pLaDnxpUbbj9Wuu9OOZgWUelYmi+VGQjlW7/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680636486; x=1683228486;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCVmz0T8iHiHtH7a2wMYKMxDUPs6L8UFRcHeBvRmBAU=;
        b=k/wo41X1n58sLXEJ4Vg/68slSoJpz87KXLTYsH3aMXP7QlYjDnBHXVofx3SpuHTxJ/
         QI+cbOMr8VcQL0vFu+MSz2Rpz1b9wMk7qpRpU3YYtvEQIKKOmKKIeq5oTJW6tjY138gD
         k3O0QFq86s7sCo/lLB3Kkcp7ue3o27vizX0Y7tOMzjqzJiEt5u8swNRn8WW6zo+E8iue
         TgsTWt45T5TJdBRXYxZEmpKFmtjUFjAK/LNTo085xQcHfnCDs2/l49/NOhzCZ1XNLr30
         cEI9AeIrCp4rVtOhMFAwCe+XCwmS3f/4u8EYjjYOX5gVO4qoPbKSdcL4eEXLukd3pwf1
         7xng==
X-Gm-Message-State: AAQBX9fTm7Yy3jIXYn9fHc/qD2dQI4ydZ3Yi2iIjbiyyY/FAMUGlFb+V
        qg1/Krc8CKeAaXHZHx0oeY0VYQ==
X-Google-Smtp-Source: AKy350ZfSXIvET0COGP5gtjzSXywPfCpMp7M5ms3jss4Y0ez/AQVBbeHSNIrJP0+TaHdDf0Qe7/7Xw==
X-Received: by 2002:a05:6402:1e8e:b0:502:1f7b:f069 with SMTP id f14-20020a0564021e8e00b005021f7bf069mr598086edf.2.1680636485980;
        Tue, 04 Apr 2023 12:28:05 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s10-20020a056402036a00b004e48f8df7e2sm6256896edw.72.2023.04.04.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:28:05 -0700 (PDT)
Date:   Tue, 4 Apr 2023 21:28:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     yq882255@163.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Qiang Yu <yuq825@gmail.com>,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH 0/3] Revert lima fdinfo patchset
Message-ID: <ZCx6Q5y1dgAv2q/o@phenom.ffwll.local>
Mail-Followup-To: Emil Velikov <emil.l.velikov@gmail.com>, yq882255@163.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Qiang Yu <yuq825@gmail.com>, Erico Nunes <nunes.erico@gmail.com>
References: <20230404002601.24136-1-yq882255@163.com>
 <CACvgo53mV7Aoe+omtSF0BNg+gVOWqDQ_QAmMkhikjQw-vF55Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACvgo53mV7Aoe+omtSF0BNg+gVOWqDQ_QAmMkhikjQw-vF55Xw@mail.gmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 04:17:33PM +0100, Emil Velikov wrote:
> On Tue, 4 Apr 2023 at 08:13, <yq882255@163.com> wrote:
> >
> > From: Qiang Yu <yuq825@gmail.com>
> >
> > Upstream has reverted the dependant commit
> > df622729ddbf ("drm/scheduler: track GPU active time per entity""),
> > but this patchset has been pushed to drm-misc-next which still
> > has that commit. To avoid other branch build fail after merge
> > drm-misc-next, just revert the lima patchset on drm-misc-next too.
> >
> 
> The bug/revert is unfortunate, although we better keep the build clean
> or Linus will go bananas ^_^
> 
> Fwiw for the series:
> Acked-by: Emil Velikov <emil.l.velikov@gmail.com>

Can you (eitehr of you really) please push asap and make sure this doesn't
miss the last drm-misc-next pull (-rc6 is this w/e)? Otherwise we'll have
a bit a mess.
-Daniel

> 
> HTH
> -Emil

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
