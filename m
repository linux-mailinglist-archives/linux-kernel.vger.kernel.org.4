Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08D4608508
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJVGXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiJVGXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:23:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D924471B;
        Fri, 21 Oct 2022 23:23:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a67so13251968edf.12;
        Fri, 21 Oct 2022 23:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kok/Ux5+rEDlXMBd84wchGv4GoNr9xODr30MDalxF54=;
        b=BmIxsFLz1o38iqVCPe15V6QzdxASVWLlPnGIFPg3ksvcpe3PP8IkXUVtEVkQEhjs1b
         Q8TeniK56qBaCoPxOb0G4I55FJwK2NafG6TV8gFfhhO5X8CSZx3LVyQvz20C3IA/nimc
         y/fQqRFX0fUL5kIa/WZL+9gdgE4vq38j8hoTNgyz73tX3SxOXzZO/avi2PQnYenax8Me
         96oGHwEJ7kPwzG7NRR55AtYgHV4VT8mnHN6uK5VyDJ7PSNon4eHy+9TLi7w93dDUDiGR
         DMFHCREubTYccVADRYCk3yspeUgtilZlodnp7yMSmrFXHHcBzZqugpsnvMk94WYg5W0t
         WsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kok/Ux5+rEDlXMBd84wchGv4GoNr9xODr30MDalxF54=;
        b=ocTnjC4dXQ/VzIZ1tF6oO9KgN4vy7oo5MDb14B5jQh8wF2uWTPaA8LZ6fJaFZda30g
         ox0OhM7YbolRWtHJSrxaQ5Vxuw8CGjBQjIqocXgAWD3Dz5cdpxaYJWcLB27Fps5NgSPN
         Z0N7dGAUaMjUQ+zJUB0W15MSM+b/YmH4iSarPwYCAxwHXbaGhM0FChDpc0J7bXGDMCnW
         Pm5ZmxCXbXgMDQEGzjKHT5RBbKDAQjh4eBwa5R21Rhx+KYdxn34q++0Vp3iSyAJ822s2
         wmhzV8X4I6fGjOY3SO2pG80NwGGyGpmIzf4WOsGJoz9e+0C9XwE+WFPXsddORjqFi4yM
         nIzQ==
X-Gm-Message-State: ACrzQf1rIDFPYVjnewetasl/04hl+eFQPfbi7lA4J+tvnMfD+8+QFsUW
        hpaL2O5r7jGPjCjRZTT1WZ0uUU9UkGY=
X-Google-Smtp-Source: AMsMyM5R/vZJ8staClALQmMuYQAiHqoUtWGu7El7foI5U930SWjH9vVV3rPT+XRiHjh9dsUAkUUt4w==
X-Received: by 2002:aa7:cad5:0:b0:454:88dc:2c22 with SMTP id l21-20020aa7cad5000000b0045488dc2c22mr21024495edt.352.1666419788845;
        Fri, 21 Oct 2022 23:23:08 -0700 (PDT)
Received: from gmail.com (1F2EF769.nat.pool.telekom.hu. [31.46.247.105])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7d34b000000b0046182b3ad46sm233044edr.20.2022.10.21.23.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 23:23:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 22 Oct 2022 08:23:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/fpu: Fix copy_xstate_to_uabi() to copy
 init states correctly
Message-ID: <Y1OMSAmyUg99iorm@gmail.com>
References: <20221021185844.13472-1-chang.seok.bae@intel.com>
 <166639111821.401.9381657733834636095.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166639111821.401.9381657733834636095.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Chang S. Bae <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     471f0aa7fa64e23766a1473b32d9ec3f0718895a
> Gitweb:        https://git.kernel.org/tip/471f0aa7fa64e23766a1473b32d9ec3f0718895a
> Author:        Chang S. Bae <chang.seok.bae@intel.com>
> AuthorDate:    Fri, 21 Oct 2022 11:58:44 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Fri, 21 Oct 2022 15:22:09 -07:00
> 
> x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

> +		mask &= (header.xfeatures | xinit->header.xcomp_bv);

Nit: those parentheses are not needed.

Thanks,

	Ingo
