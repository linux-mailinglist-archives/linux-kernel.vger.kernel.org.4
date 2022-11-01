Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D836153D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKAVOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:14:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378D1C42C;
        Tue,  1 Nov 2022 14:14:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 20so14520878pgc.5;
        Tue, 01 Nov 2022 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6indUiCprMB0zjMLWvS6nYLrTKO3j8yjpLRzZacHoFM=;
        b=RvakqeHbzhIjgHA0SHrXXMScjhxIrsj98u/WPUsnoZgBbiMepcA6jWfxYuNLJ7YZKl
         7hQeN3cKsZHdgVa+by5PM9qwRAXlERGLBHtTYOATeumHcVBVJh12ijdH6hESg72b+wzw
         r27PIVAfsU6wsVC8jduamUDUDRQGWhqhfjL5fViN9pYW8AANiVCifGt4VRus4t71d8K3
         bh7W73of1dfjJMq65cWyAGs/0pzBnk7/j5SrDExP3MtP88tq0+DVqzpssHJq3RUnbrxN
         ZOeHFX75u3sTcdI+a70BLWQq/HCHg3+AiUVcjCfn2nTWdfUYiuiN2UIjcWOAoiGnLtrt
         Ah6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6indUiCprMB0zjMLWvS6nYLrTKO3j8yjpLRzZacHoFM=;
        b=wtDLwGDX8GJdCIu9/lu6GJZIlpu4fyPWU8XyEiYreGwiEzNxUVocWMBB4OPeIobRaO
         aP1DEIdFqlx3ndZkSQ9h6jNo+RO2CbqDtG4gT7sHCEpzCHCeeH4ZaAM+q7DJtBop2CGB
         zPcp9wg2f3j2N+jp3UT8KXvHuwSZNzN+oGYdWnMzdYnVdAFsdziB0Yx/0vlYnEM3jR0C
         ufRt4JgoRR0V4MDaqII4nBm/HAj0FkRnLsOZyl/tgEhEMMEVt0bOcveNynOFOlP6fwx6
         H3yBR3JtZ8jPmiVNnVxPs3ClzVF/p4WH3fV/o+soWKPmOnS5lewwEYssmwQ6WSZ14GX5
         yjUw==
X-Gm-Message-State: ACrzQf3uYJK+3ynSaqrapBct0axZ42I0rtnSrVNhazQnel8y9LchaCOp
        CpYrGqmII2mCCFCFNHMJ3a0=
X-Google-Smtp-Source: AMsMyM52pQddQpmtGf7qmD+beu+QOQ/6824R/3H3162dp/zW7VTCB30F2Ej07jtHrVsyBI0az0Lq5A==
X-Received: by 2002:a05:6a00:234d:b0:561:ec04:e77e with SMTP id j13-20020a056a00234d00b00561ec04e77emr22151908pfj.14.1667337242960;
        Tue, 01 Nov 2022 14:14:02 -0700 (PDT)
Received: from mail.google.com ([103.229.249.253])
        by smtp.gmail.com with ESMTPSA id o20-20020a170903009400b0018685aaf41dsm6804056pld.18.2022.11.01.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 14:14:02 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:13:54 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <Y2GMEjB4NQ3RYk2C@mail.google.com>
References: <Y1trhRE3nK5iAY6q@mail.google.com>
 <Y1yetX1CHsr+fibp@mail.google.com>
 <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Mod90O=tN26+Yi74WPYxpVtss+LG_+_HZyFv2EtzR+MA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 10:42:14AM -0400, Alex Deucher wrote:
> On Fri, Oct 28, 2022 at 11:32 PM Paulo Miguel Almeida
> <paulo.miguel.almeida.rodenas@gmail.com> wrote:
> >
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > refactor the rest of the code accordingly.
> >
> > It's worth mentioning that doing a build before/after this patch results
> > in no binary output differences.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> 
> This seems like a worthy goal, and I'm not opposed to the patch per
> se, but it seems a bit at odds with what this header represents.
> atombios.h represents the memory layout of the data stored in the ROM
> on the GPU.  This changes the memory layout of that ROM.  We can work
> around that in the driver code, but if someone were to take this
> header to try and write some standalone tool or use it for something
> else in the kernel, it would not reflect reality.
> 
> Alex
> 
Hi Alex, thanks for taking the time to review this patch.

I see where you are coming from and why you may be apprehensive with the
approach. From my humble point of view, I think that the artificial line
that separates "what we can change at will" and "what we should be extra
careful not to break/confuse others" is whether the header file is part 
of the UAPI. Given that atombios.h isn't publicly accessible, I tend to
gravitate towards the first one.

> > +  /* empty fake edid record must be 3 bytes long */
> +    sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;

I am assuming that this is the part of the patch that makes you feel
concerned about how devs will get it (should they copy this header),
is that right? 

If so, would a comment on the ATOM_FAKE_EDID_PATCH_RECORD struct
specifying the size of the struct when empty do the trick? 

- Paulo A.

