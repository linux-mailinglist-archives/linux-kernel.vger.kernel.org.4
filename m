Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159A8705994
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjEPVdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEPVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:33:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288597DAA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:33:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so8645256b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684272810; x=1686864810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6hLWOpZXVAPYMdSJJ2ItQN0RBkBNzkcQkwsr4O8qt8=;
        b=i+4YyHlZDcjlkeuWsEXE5awTcv8wCA7UxR1ayg1q4HYWieG0uIijMS0Gn/sofbDPBj
         5RE7Gm3NnZYZaraVIyOUyN5jpLVdP/LxV4E05sIi4sl51TCPajYkqbzDJtO3B22yyi6Z
         Cx4t4oVt+tyX8DxSX3WFaLM2jCHD/zJe27Yu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272810; x=1686864810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6hLWOpZXVAPYMdSJJ2ItQN0RBkBNzkcQkwsr4O8qt8=;
        b=Ma5syxyFGfuj2fRJ9j8xt2Kup+xeHbPQh5wnwPECv/YzMMHmZq9zvuQCyWsiYTF8Hp
         CzKmyiHnxWRmIpSJ6oSpH9q8KxSYzlhZES3CsHVv4b2pOFIEmZQh+PSamTFo1aPsGcP6
         mEN29c1KkJAfUzBDj/9fpFSX6A6KwuB8RuEaDmKzn/ilJbFlwimsdNT0kg1IALX7bpt0
         hE1E9SyBJdclwiijxdAnrfNRFWzkqlZ2FtRRA9QMGQZIjLDiNrXt6QimAh+2FzOpneYb
         Tr+ObIl6rdfPCfOpKJmco/gOTz3RHmqI5tTFt4jsZ9SnM9Fh03R5YEDqh6Vyub8G+5Jt
         5kXw==
X-Gm-Message-State: AC+VfDyqNDJmPj7csY5ELYleJu2ARGBS964mDJ+RMHfrJjcAD2pmIPAH
        XZLlIODTrk9liqcCrXGfIfSPSw==
X-Google-Smtp-Source: ACHHUZ5U4ZGbw3JlLZ91DeGnxEGGQ0ONw3/x9vvE0RHGGprBODEjQn/CFkOYL+QWOmfO7dyZdPCR5g==
X-Received: by 2002:a05:6a00:1950:b0:647:2ce5:57c4 with SMTP id s16-20020a056a00195000b006472ce557c4mr34302149pfk.5.1684272810661;
        Tue, 16 May 2023 14:33:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h11-20020aa786cb000000b00646ec752fedsm13603713pfo.199.2023.05.16.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:33:30 -0700 (PDT)
Date:   Tue, 16 May 2023 14:33:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH locking/atomic 19/19] docs: Add atomic operations to the
 driver basic API documentation
Message-ID: <202305161433.C015F9E@keescook>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-19-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510181717.2200934-19-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:17:17AM -0700, Paul E. McKenney wrote:
> Add the include/linux/atomic/atomic-arch-fallback.h file to the
> driver-api/basics.rst in order to provide documentation for the Linux
> kernel's atomic operations.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
