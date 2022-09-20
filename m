Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BD5BE5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiITMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiITMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:32:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F7D5C9E4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:32:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t7so3993485wrm.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=1MF4EqMmKiknkCxbkWjC3WSdMgGUyAMwUXpH/v5PLhs=;
        b=hqQ+kEhXrINc6InWXqyon5OwHwauo0C0OEZqG9NYnnK3ZJEsnGX1dAgFB3BKCrj+G2
         dPc7q5c1k8lHWMoQBkHE/1IaSTUy3ygewYM52gTFSgKVYi2WbLib61VKuUPe+W0DDkYR
         JKD8dDfQC2/sTJdVL6sudb0h/OJjZIYbZ88OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1MF4EqMmKiknkCxbkWjC3WSdMgGUyAMwUXpH/v5PLhs=;
        b=jeHK2vQKg6UiTjjIf3seX4YpcdTmb5fUAYHHEDttIMAJIwJXPDR3fDNWZqi6z9SKTY
         i2CAPy8XrNfdYG8DNWbuAanhPCQGF+/WvkokUinsvDEpaCwkeWHMJxguyFd/giu2zo47
         KKzAjC1/SHTIBEqoTOe/QlKyl2FZZDXhrjvIKbtfhqr9/HR0o0y/+9+06++eyUZm5sBf
         pXUmRKsQSLg7VlKPO3R/jNDrfI8wsUJr9KhylF2/j4RHLeA+pmG9QkgrN+7ct+aygnZ3
         f0qVZxxR0cXl6KdUMbSiguQRpwxyklOF9sCtZbaMtlL7PfKT1Rv/MaGzb9y8pfOJ68RN
         /ajg==
X-Gm-Message-State: ACrzQf0Sa8ICAtVXFqdWMY0HPQuG0NlTJ9V4bP1Pj48eAZHkjKJfVTFK
        JIgZjVekBSRso9C9XNOkp+vWfA==
X-Google-Smtp-Source: AMsMyM6r6Ml0b1UTbXqs9UY3GRGCQbw72xzvUd6ll61viiKh6J0PpVhoGzWJOg+mkXMFmIU7FSUtJw==
X-Received: by 2002:a5d:504c:0:b0:228:db0e:a4c9 with SMTP id h12-20020a5d504c000000b00228db0ea4c9mr14181924wrt.272.1663677127257;
        Tue, 20 Sep 2022 05:32:07 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b003b340f00f10sm17629084wmq.31.2022.09.20.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 05:32:06 -0700 (PDT)
Date:   Tue, 20 Sep 2022 14:32:03 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        sudipm.mukherjee@gmail.com,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] drm/amdgpu: initialize r variable into amdgpu_cs_submit
 function
Message-ID: <20220920123203.GA346517@tom-ThinkPad-T14s-Gen-2i>
References: <20220920122216.346321-1-tommaso.merciai@amarulasolutions.com>
 <3430255f-3675-eef2-92bd-4eb8be582c83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3430255f-3675-eef2-92bd-4eb8be582c83@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, Sep 20, 2022 at 02:23:58PM +0200, Christian König wrote:
> Am 20.09.22 um 14:22 schrieb Tommaso Merciai:
> > The builds of arm64 allmodconfig with clang failed to build
> > next-20220920 with the following result:
> > 
> > 1190:3: error: variable 'r' is uninitialized when used here [-Werror,-Wuninitialized]
> > note: initialize the variable 'r' to silence this warning
> > 
> > This fix compilation error
> 
> I've already send a patch to fix this to the mailing list 7 Minutes ago :)
> 
> Please review or ack that one.

Sorry, my bad. Don't see your patch :)

Cheers,
Tommaso

> 
> Thanks,
> Christian.
> 
> > 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 58088c663125..efa3dc9b69fd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1168,7 +1168,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
> >   	struct amdgpu_bo_list_entry *e;
> >   	struct amdgpu_job *job;
> >   	uint64_t seq;
> > -	int r;
> > +	int r = 0;
> >   	job = p->job;
> >   	p->job = NULL;
> 

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
