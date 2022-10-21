Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE2607BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiJUQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:11:54 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2D285B52
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:52 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u15so3742484oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/dQ4/s5WdUJ0VB2UX1txrF0qZgGGjk2wy/dzjGjpZs=;
        b=Fsrx2rYLUrrLnF0iVmOZCT0YfuuivyZisJuO0L47efAZu5UtI+TCmhMZZv1WWc4a7r
         uJBXOk55gWda6quKiXFZkKxQgpmWLz79dYf6yuDxXSmxGE/h/zqbtHO3/kRqmmGQze1T
         Do1r4DARYmwhEja3+bd5xRGDQQTKVFDxWqP+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/dQ4/s5WdUJ0VB2UX1txrF0qZgGGjk2wy/dzjGjpZs=;
        b=jWWOmNgNQJS0O4lJpIk6FwqvVcsxfTLe+7xm4SMHaZnOLCwP2TL9jdPa2ZKhDt2s8S
         Ra5n+stj7yF+2vE362LRO24dUMcEl3f4yWdhxgZIvfElaxepsstMpGAJ08ls0RcfyXNX
         LyVnu22I8/bINjP0V/nta0OgZfC1wkU7ysYky43rCwLgSUCAiWZkFn5TaKpemc9efG3b
         PHMxl1v8OwjLs3hbWsLFgyL4aEJEDy1U58h09K086ZEtmpyYOQe5DFjnP53JiEjwkawy
         OW+Rv/paPM7X0UgQTxg+XmiCh29Yq49dWvnVXoMNm/loUxJuLR0DRqLP2aQlxcE2WxXu
         1Aaw==
X-Gm-Message-State: ACrzQf3+WjAHyiG5laoSasvbqfveGUaeK+emxSPycSqjDSGifIp9d26F
        u4w2BD42A9DT4kJwwxCZjHtWl1+upvXRcg==
X-Google-Smtp-Source: AMsMyM4vJuqObfddhpz71y5gW99J3p0TPxT14dneYCJnChxYJl78mUpgf4K7I/eaMdHaNgI73XNS0Q==
X-Received: by 2002:a17:90b:4ac8:b0:20d:56c4:a892 with SMTP id mh8-20020a17090b4ac800b0020d56c4a892mr57008320pjb.19.1666368700360;
        Fri, 21 Oct 2022 09:11:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709027ec900b00176ab6a0d5fsm14931296plb.54.2022.10.21.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:11:39 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:11:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Dan Li <ashimida@linux.alibaba.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] compiler-gcc: document minimum version for
 `__no_sanitize_coverage__`
Message-ID: <202210210911.C794D018B3@keescook>
References: <20221021115956.9947-1-ojeda@kernel.org>
 <20221021115956.9947-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021115956.9947-5-ojeda@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:59:56PM +0200, Miguel Ojeda wrote:
> The attribute was added in GCC 12.1.
> 
> This will simplify future cleanups, and is closer to what we do
> in `compiler_attributes.h`.
> 
> Link: https://godbolt.org/z/MGbT76j6G
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
