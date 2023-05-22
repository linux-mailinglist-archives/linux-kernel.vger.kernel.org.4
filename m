Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7431870CBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjEVU6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbjEVU6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:58:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE79198
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:58:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2533a03388dso4429869a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684789109; x=1687381109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXcDp+9WnYXQQ8kzzUbP3R21GvXgk1x8osyoI1bp1So=;
        b=oU2I2ROs4mi0M7l2FNvk5YXCuVWnzyk9mtidGKRoiOk5LaLFDN45ANR9REntIN5k75
         +7Auu97ZCX/Qi5rZe1E43LRdahoqPgK2PPtSqaVy5DF8hBGH5uCzFDlBE+Y3nQ+oEbxX
         v/f6/N8P/+S3+pEQpwruIzVYdXFaK6OgoY5ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789109; x=1687381109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXcDp+9WnYXQQ8kzzUbP3R21GvXgk1x8osyoI1bp1So=;
        b=PnLmmjWj0uS4S4x1zS/d31MmnF03HgRW9RwA7cvJrP3PcNCsbLnguQn4gCr1Wl/bzn
         IIKUebAAblDK1QToyzQyAEqUnxIfVmRsEFtCvbBKMJ/mCYpG6b2GwOdhPl/zkMPuA2/R
         xhJQExk/XDN4lx2079WNZWn7OH3SoQmD74Ph638cNIgwRQgjhaQuEtOz63pCwTqxsJ9t
         1DIzCExue3WB+AdizzbQ47k1s+lCp7uH+u79JE7bRTghM/WV3SxOficfgmRBA5AhnwJM
         n9p1uQ4n7QIjGfh/VtrdaNQ1ic5n+x7h1EDW9aXopl5Vql5rhorBgix10ql14f99WfZC
         ogow==
X-Gm-Message-State: AC+VfDxyHTbZ3KgHyqpA2oo5xNbGato/913PRzsX/BDgkVHZVAWf6hFf
        tyCtMMlbAYiyLWCA8ZUfugN35Q==
X-Google-Smtp-Source: ACHHUZ5xWwngfsZNKPu1p9KpeSjcsXo4wq99/sjLIBhRb1f+J1o/JpC3tSO95mNeCoBZdEfu/9KP1Q==
X-Received: by 2002:a17:90a:d302:b0:23f:2661:f94c with SMTP id p2-20020a17090ad30200b0023f2661f94cmr11619408pju.47.1684789109523;
        Mon, 22 May 2023 13:58:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d61-20020a17090a6f4300b0024dfbac9e2fsm6803551pjk.21.2023.05.22.13.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:58:29 -0700 (PDT)
Date:   Mon, 22 May 2023 13:58:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        paulmck@kernel.org, peterz@infradead.org, sstabellini@kernel.org,
        will@kernel.org
Subject: Re: [PATCH 00/26] locking/atomic: restructuring + kerneldoc
Message-ID: <202305221356.32A50E3@keescook>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:24:03PM +0100, Mark Rutland wrote:
> The patches are based on the tip tree's locking/core branch,
> specifically commit:
> 
>   3cf363a4daf359e8 ("s390/cpum_sf: Convert to cmpxchg128()")

I did successful builds of:

m68k
parisc
sh4
sparc64
arm
arm64
i386
x86_64

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
