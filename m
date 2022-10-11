Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7B5FAD14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJKGyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJKGyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:54:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22A80BD8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:54:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so15145036pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 23:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sga1zyvqspSHTBK1MtPA6ZPMPuSJOrHoE2GS0bxhLWQ=;
        b=VnQ6xnBuVEotqAa9gM/q37YrprAvxlQ0OjmdCa7vk6kGUznFNA5OL0YLN7d6hfFkaB
         kL/CR2JMoYASUIJad8x0f8//OEqqeBw+MXO2dGrHo9C1IjySxeBaCzQae+duEHbZ5VGh
         o5DIeJPzmQ7h0KMT4bBpaRS7P1qRUkw1h5ra4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sga1zyvqspSHTBK1MtPA6ZPMPuSJOrHoE2GS0bxhLWQ=;
        b=CKB575xk1yVOhiOhLR346e7qJ1AG003CPwrQKyVpXiBFfF4QpxggGt+Npy/Ki1SWlf
         f5YD2l1/ASE87jz+QQbJIqLwvFsbhemLDdJBm+aXGpgjZbWyTvfbTRK5ZfnToH4YVLIb
         GtPESVtNzKvWvoPg1X5EnA/5UO3jDhaeCOov+pXkR3ATHOusIRfuTutxOLftUwCw07/K
         ZLrRU9Kip6nTx+LMCyrD9BmVcPJ2/0ZECzL1+mEzhelAy5dQyJIZlkggOGsu/wgWjHnX
         ulOX5wZtaK18C81zDIkAn8qb2CYdIexdKJa34AUCseg7tWTXRKMLmK5BDwcL55LUhDeb
         B97g==
X-Gm-Message-State: ACrzQf3ijf2t7usnMi5CvrdGqxBkBEfZWcCiHhV10GRjOvN7J/1UOyOx
        Tt1nMKlZuAlHeeOTJeU66+9xKQ==
X-Google-Smtp-Source: AMsMyM6NBkHG6BwYBxJhQvcR1RK23iSxIGICYMdvhAsd+Dr1M6D4z3tY2Fra1/RXzh/3MrvXzjBv5w==
X-Received: by 2002:a17:90a:c984:b0:20a:ac88:d39d with SMTP id w4-20020a17090ac98400b0020aac88d39dmr35350554pjt.13.1665471242729;
        Mon, 10 Oct 2022 23:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h62-20020a628341000000b0056286c552ecsm8048364pfe.184.2022.10.10.23.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 23:54:02 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:54:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [fortify] 54d9469bc5:
 WARNING:at_fs/nfs/namespace.c:#nfs_d_automount
Message-ID: <202210102352.B80BC62@keescook>
References: <202210110948.26b43120-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210110948.26b43120-yujie.liu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:45:56AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 ("fortify: Add run-time WARN for cross-field memcpy()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [...]
> [   57.256986][ T4357] memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)

Thanks for the report! I've sent a patch for this now:
https://lore.kernel.org/lkml/20221011065243.583650-1-keescook@chromium.org/

-- 
Kees Cook
