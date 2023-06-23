Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246B173BCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFWQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWQgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:36:08 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0552720
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:36:06 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso509441b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687538166; x=1690130166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhs8onmrqAwdGqexHpILazT0xkmF8Iid7yS9jfwfxs=;
        b=XqOQ1RxMf8GC/YluK2GfHcEEWekghUFV2JWO4n/AAp0lA/ISyS2EnYI1T7ptCu9CWW
         BCXQkoDNhDFSsP/OslzJcFnuFUkc5s8F2Vc2zAdqNaxVvhyRoGmjYSGeKSYSE6iBqQT2
         hC6WKVzKQ7y07MpYOe+WATDQtYasHNfTeYhbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538166; x=1690130166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHhs8onmrqAwdGqexHpILazT0xkmF8Iid7yS9jfwfxs=;
        b=hyvSEZE3GugFawGrtmYsLyCruAIDJ+Wf60BEJTMidA7M3zQ0VV+88irQsOc9fkOpva
         28f9gcPXxCdTkCHEGMBIBNniVVzAcLyjdaCaWJ8nSHLcKaOuv2/nDJnvkfZvumCGvqvL
         FOdVRZo2rS+mO7H9V+cvy3k4lKyXxcW3xQk0sThd09DOl8zx8j12M7r7LxVFaIWaFmbU
         NRueN7Eb+sSHD53E4Mfq0dvPzS3cw+3eNpkXOIC6xFvwHqopEwTeU0CqWAwoG0C6SEM6
         YQ0jjLouoIqMZKJjR2uVpyEQphZ2rhGRvgGelyi7q7pceJoyY2XWAN/L01KetyOxvEQ8
         Lu2A==
X-Gm-Message-State: AC+VfDy+qOQ2fGEElxorSIwJvaanTSYrPEE+ZlojnL96XjlhMl3TDzKc
        dSS+z+tFyrPcIjE9BYxJqf3I4S1mypHN9azx0WY=
X-Google-Smtp-Source: ACHHUZ7/4OmeRh5Ci7FAVcnMLi2617iEndw7Y5mvSV0OQN7dkxw0YjZ64cotTzPq6V1drytqAuEuLQ==
X-Received: by 2002:a05:6a21:3386:b0:125:928d:6744 with SMTP id yy6-20020a056a21338600b00125928d6744mr3115605pzb.11.1687538166342;
        Fri, 23 Jun 2023 09:36:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709027c0500b001b246dcffb7sm7361409pll.300.2023.06.23.09.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:36:05 -0700 (PDT)
Date:   Fri, 23 Jun 2023 09:36:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] elf: correct note name comment
Message-ID: <202306230934.C235D5751@keescook>
References: <455b22b986de4d3bc6d9bfd522378e442943de5f.1687499411.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455b22b986de4d3bc6d9bfd522378e442943de5f.1687499411.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:50:11AM +0300, Baruch Siach wrote:
> NT_PRFPREG note is named "CORE". Correct the comment accordingly.
> 
> Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> 
> v2: Swap "CORE" and "LINUX" as noted by Kees
> ---
>  include/uapi/linux/elf.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git include/uapi/linux/elf.h include/uapi/linux/elf.h
> index ac3da855fb19..4d1c8d46e7f0 100644
> --- include/uapi/linux/elf.h
> +++ include/uapi/linux/elf.h

Hi, I took this patch, but it seems something is misconfigured on your
end for patch generation -- normally I'd expect to need "-p1", not "-p0"
to apply patches. Are you using "git format-patch" to produce these
patches?

-- 
Kees Cook
