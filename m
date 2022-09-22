Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9775E6F82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIVWSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:18:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EB10D0E7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:18:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y11so11169262pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=3tQ8DexTmBQhSl481NWshvFci5ptg/GjLyg2jvTMyy8=;
        b=m2zXmoY9XUMR6tDEDw/SxGMgC29NNYVTIjkuU19RN+nAKxMR0jR+SlImSib5RdnwhU
         IBd6KYLL/N+QCZXd0GePsiZhx8eKAG8BnzVYErauhrhmI5L3V68rn5ZqSYUzNktJ6P/M
         C9FMtt/Yims1ynU3WNfaGSqRCaOjqOdxaLf9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3tQ8DexTmBQhSl481NWshvFci5ptg/GjLyg2jvTMyy8=;
        b=5Y1NyLHs9G8l0i6wx4QTEPrht2ZACKUFItW4N1HfBudDpn8FcyjMLY2kMPh37wtfS0
         OeQJ4UXZ08E5zRwmTeSTSlv6fqysIg+rotupByCt+Zwe8yFuKbxjwKDsYxOr8DEpKw05
         EYgyBQ5d7oBwMuaAbQXXZzdlX8kcCypoJ23t6Q5TXNdHS1MBekFTwtqZUC6kQPVL4RFY
         oKSRUj03p+rGtihs7j2x4v3xkxYyv8/jN6by/n8SgtjvBdgAQnzQSIiphIiSqajK3wN4
         zDvFp06xPi+tcq/sNWKT5oNfuoRavH6F16jHSyBUm0qgScf3oAuU4hlojoHZBQ8Md9rV
         pZbA==
X-Gm-Message-State: ACrzQf3QWy0QCHA3MNwtiyJ+ZyW6XoDO0umm4B3QYVbomb97m+NP2oMo
        Lo7T0Rr0Y4alxr7qQ6GUUf1aydFo8MLwMA==
X-Google-Smtp-Source: AMsMyM5IOGzk4mSpLeHRFJnBdY3T8XeyPe0dEzifkjTh1mWaBFGbHYS0gTk2TY8zuFIWmZJDazPXqA==
X-Received: by 2002:a17:903:496:b0:176:ba09:1cc0 with SMTP id jj22-20020a170903049600b00176ba091cc0mr5292930plb.41.1663885082768;
        Thu, 22 Sep 2022 15:18:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b0017834a6966csm4777432plr.176.2022.09.22.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:18:02 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:18:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Mohan Rao .vanimina" <mailtoc.mohanrao@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] vmlinux.lds.h: CFI: Reduce alignment of jump-table to
 function alignment
Message-ID: <202209221514.B2B02622@keescook>
References: <20220922215715.13345-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922215715.13345-1-will@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 10:57:15PM +0100, Will Deacon wrote:
> Due to undocumented, hysterical raisins on x86, the CFI jump-table
> sections in .text are needlessly aligned to PMD_SIZE in the vmlinux
> linker script. When compiling a CFI-enabled arm64 kernel with a 64KiB
> page-size, a PMD maps 512MiB of virtual memory and so the .text section
> increases to a whopping 940MiB and blows the final Image up to 960MiB.
> Others report a link failure.

Heh. "That's not an image ... THIS is an image."[1]

> Since the CFI jump-table requires only instruction alignment, reduce the
> alignment directives to function alignment for parity with other parts
> of the .text section. This reduces the size of the .text section for the
> aforementioned 64KiB page size arm64 kernel to 19MiB for a much more
> reasonable total Image size of 39MiB.

❤️

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://www.youtube.com/watch?v=rne8pOxGuwM#t=27

-- 
Kees Cook
