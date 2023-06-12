Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC72872C867
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjFLO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbjFLO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:27:27 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238C1FCC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:25:23 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30c4775d05bso3009519f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579886; x=1689171886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63/1cVX3TUUVbw84whvXkBRmPJLPt0qPyYpBKlpXx+Q=;
        b=REfN4H4bGnJ4WQK8/yMc/bg9xGageBtD9dkolu6akkMi8R0/rfYVlRZJF6m7n0+0X+
         rvU5tsnLlMmmI8+0mUOEbH0FeloMJ9JTmciNZobLCiOx3upRJ8buZdXY4acn8fzs46wM
         HiGwJrAGgGGJf1sSYeD/yVt649dncDVeDBSTr2CjEENMEQzS8gymqPCGDwyPUFmLgywQ
         X9sNlsozTs38ji0UoihLyAW2BEPkenzLTbgH8rgpzr1zPhN79Q58+z9eEoxKJ1Jx8m/e
         SlQjX7qcEWjwXFGdQyJsSR4stcYmhLM6wXrMWp9lxs5MzR8oLMa2JGcjLnoGQrc7kenO
         Nmow==
X-Gm-Message-State: AC+VfDy8Vy7rpb62b+rePJ+MMs2Dwm6jNVfewl7mBpOVZ++zN8UoGGlb
        jLP25Cp+5WP04RevuBzyVDC9GuNKJGfH3g==
X-Google-Smtp-Source: ACHHUZ7A0f7fPwC6KF9lYPM6ob4/uCJkD8LSGubGbjKGs6mc5Wzy7tYqSiSCuVygXmKtV7Vedu/M8A==
X-Received: by 2002:a1c:6a18:0:b0:3f7:19f9:4c4f with SMTP id f24-20020a1c6a18000000b003f719f94c4fmr6653437wmc.21.1686579380288;
        Mon, 12 Jun 2023 07:16:20 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-006.fbsv.net. [2a03:2880:31ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003095bd71159sm12722545wrz.7.2023.06.12.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:16:19 -0700 (PDT)
Date:   Mon, 12 Jun 2023 07:16:18 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <ZIcoss0r/898/CpH@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:53:01PM +0200, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 06:46:16AM -0700, Breno Leitao wrote:
> > MDS and TAA mitigations are disabled when `mitigations=off` parameter
> > is passed, tho.
> 
> So add them to that menu.

Sorry, to waht menu specifically?
