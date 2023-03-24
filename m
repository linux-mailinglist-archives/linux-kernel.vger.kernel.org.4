Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF66C823F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCXQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:19:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F7C170
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:19:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so1900852pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679674780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GcRU+3Df6sch2ymL5NXBQO6zVQfdEa74o4nvNV6luxg=;
        b=oWIQTF8GO82CugYWAgdiV5RGkyHBdeDUHQPbumdrXpTQseSP5VEySKvMejl9vEkVMw
         1B1IvRchFgMX0BRIVDcGH42fje5WbeHrIP/HzHJrjis4aJNsY5Mmj8yDsIoSBWg5z1Dg
         gGo8/50iB6yCBUbfDxr/KrCyXF4cixKGgVmyRvgQNLC85wm6xY/7uvrjooXlOSlnJOtB
         DcqVV3JHhwzIv9S94GdSqBmc9erf26+BNXT0Umm4ABFxErBf87sefAKiAVCD48gusIyJ
         TWxAFK/wSjD9deki8fwipuNsCs4X9QOEaS851ie/a0kjc0bqVGFdmH42g80FIvAPsKU8
         b97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679674780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcRU+3Df6sch2ymL5NXBQO6zVQfdEa74o4nvNV6luxg=;
        b=utcOQQ4tDCICSLj0/7gvp5vNp2KF4KufTIPbmT+Zygv2xT+dKZ2yMb7077H5kKWpgz
         B9tDDgTNQ4wmYuLejf+03P8O67Mj83We026rvNurKU9hQUjHlrK4lkO1FYz3aTUWBq2p
         NSK2wUPlgsG1NeHLoocYdHzKOtH6GE4AA0VMavijb6+3k9PCTKQOBbSxLbI0CGUZ3ExR
         qQDHfFJ5aXA1xNaA6HmSLxlpx5Aa9bsdmLQgC9XiUdD/ghy5GlZU9yDYB1EUFh2Kyhgs
         rvzaz9QrYVCFygUiKmoHpWjvJklrpT8LiWdc+ByxN9jIEwp6rt7qChKtSVqfQwwcaqyi
         AthQ==
X-Gm-Message-State: AAQBX9eSEpNf0p37d5C1eiKF5fAIctKRDuI6nfKy6tUtD8x6NAm+/QHP
        njZuIx8B3/9Nz80NM4roB4VBBzN6oPdZGw==
X-Google-Smtp-Source: AKy350aTgNwwO8z9vDGdaqdwVaR+5mjRd0oD8yxP/+5RxB+F62sTIoQDmv+8HMLru970L0B6ZLgFww==
X-Received: by 2002:a17:902:6944:b0:1a0:4ebd:15da with SMTP id k4-20020a170902694400b001a04ebd15damr2492184plt.66.1679674779655;
        Fri, 24 Mar 2023 09:19:39 -0700 (PDT)
Received: from sumitra.com ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001a19f3a661esm14341040plg.138.2023.03.24.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 09:19:39 -0700 (PDT)
Date:   Fri, 24 Mar 2023 09:19:33 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Staging: greybus: Use inline functions
Message-ID: <20230324161933.GA174474@sumitra.com>
References: <cover.1679642024.git.sumitraartsy@gmail.com>
 <ZB3BshO6Yen25LvB@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3BshO6Yen25LvB@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:28:50AM -0700, Alison Schofield wrote:
> On Fri, Mar 24, 2023 at 12:20:30AM -0700, Sumitra Sharma wrote:
> > Convert macros to a static inline function, to make the relevant 
> > types apparent in the definition and to benefit from the type 
> > checking performed by the compiler at call sites.
> > 
> > CHanges in v2: Change patch subjects, noted by Alison Schofield 
> 
> 
> Please review: https://kernelnewbies.org/Outreachyfirstpatch
> Section on 'Following the driver commit style'.
> 
> To follow the commit style of the greybus driver, update these
> commit messages to be under 80 chars, and use "staging", not
> "Staging"
> 
> Like this:
> drivers/staging/greybus$ git log --oneline | head -3
> 1498054921e2 staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
> a7d2a41b7453 staging: greybus: Inline gb_audio_manager_module()
> f7d3ece211be staging: greybus: Inline macro gpio_chip_to_gb_gpio_controller()
> 
> BTW - I wasn't instantly sure about using 'Inline' as a verb in this
> case, so I did this (git log --oneline | grep inline) and found it's
> a common use. 
> 
> We're building a habit here for when you submit across subsystems
> in the future. 
>

Hi Alison,

Thank you for helping me out with this patch subject.

PS: I am focusing on writing good patch subjects and descriptions.

Regards,
Sumitra

> Alison
> 
> > 
> > Sumitra Sharma (3):
> >   Staging: greybus: Use inline function for macro
> >     gpio_chip_to_gb_gpio_controller
> >   Staging: greybus: Use inline function for gb_audio_manager_module
> >   Staging: greybus: Use inline function for pwm_chip_to_gb_pwm_chip
> > 
> >  drivers/staging/greybus/audio_manager_module.c | 7 +++++--
> >  drivers/staging/greybus/gpio.c                 | 7 +++++--
> >  drivers/staging/greybus/pwm.c                  | 6 ++++--
> >  3 files changed, 14 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.25.1
> > 
> > 
