Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DAB693181
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBKOfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBKOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:35:39 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4193E3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:35:38 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B44A3F194
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676126135;
        bh=Lme9XhkAr8Cxdn2CNlWscsuXuEcjxv9u2EwlF9Hplsg=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=QPDEjIQ44TX4KLhMofNC+G+QQYBfmaiH0fD/fZ53EupytdidY+iwUe3WsV012cwry
         WCPcrlg/qtWElsHl53jYC00fX3vj55S1YPWWE/3TilR9AtIwyNRQnSVpMGS8qJyHbH
         8ggAzGZenJ1c0pg94yC6914TXgdCxyiA9/K39iU1vdF8HB0Tbab+YdsoCLMGDxa/g0
         CBjUfMszMrf8XhfVj1SyJPQd7hOC2RAj6cg6Ck0nWL6YZBiGoALB+ohs2xS7oIctxS
         QlnjFXagE1VAYT6gFpU5wDa1ZuIXE1ggV/Oi0StHC5XF2Qrq0Y/P+rh0ckAPh6PVfy
         dVMFXXNfzTyWw==
Received: by mail-ej1-f72.google.com with SMTP id d14-20020a170906c20e00b00889f989d8deso5164553ejz.15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 06:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lme9XhkAr8Cxdn2CNlWscsuXuEcjxv9u2EwlF9Hplsg=;
        b=yp30jnw9+y04vRMhLbiF6oYHsGt0ZuPvbsuChWZwKkbk4LgnqAUTgj6S0dPuor+ZKl
         c7euzS+mmSPeHAmc01/4JDhwJakyeh2MMPK1NWZgdib5+m1c5tmI1SBxyWP5qAw1DOl0
         DPJkEOoMwpUDwmao95eSfxNOxAKASGyIpIoupAgPo+PGiC36zlhS/KWDXF+h4dNLxATb
         moUI8lALUr4ElmicB+A/2fLn3t5dsVuKq5o+qfj0d61QAZuZ3TjYRrk64LVUY7q6dysZ
         syUZVjIu9E4RLXM/55UkQ21KqsZd/GO5ng6Ksz/PC6xWv/NtTJxQWwbiFiHfvPT+4/nZ
         jOAg==
X-Gm-Message-State: AO0yUKVw6z8Iq+s6WEmGL4kq7uFJT5mH+PFtyW9lj1hD1BGwLdJ/zgRG
        iooaBVvTrL8a5czxm76cKCp498xFQWBaYcfXmfnUf5skgTYnQkVv1WfRAo9YS8Cvqll1VTH52ud
        vXeqGurpJhtkQwlHRCeoY881a352GFl4d9YGnW2Yy5w==
X-Received: by 2002:a17:906:7159:b0:82d:e2a6:4b0d with SMTP id z25-20020a170906715900b0082de2a64b0dmr16075156ejj.18.1676126134491;
        Sat, 11 Feb 2023 06:35:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+P8SX8aILiTuCnS1F4GLtcNeBIYuJKTjIh4OzPTPRE/DHHp8jql26LVq3sV5VO5bMRzq9UCQ==
X-Received: by 2002:a17:906:7159:b0:82d:e2a6:4b0d with SMTP id z25-20020a170906715900b0082de2a64b0dmr16075147ejj.18.1676126134305;
        Sat, 11 Feb 2023 06:35:34 -0800 (PST)
Received: from localhost (host-87-7-128-191.retail.telecomitalia.it. [87.7.128.191])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906059300b0088f8803661asm3898223ejn.8.2023.02.11.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 06:35:34 -0800 (PST)
Date:   Sat, 11 Feb 2023 15:35:33 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <kees@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
 <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 05:44:33AM -0800, Kees Cook wrote:
> On February 11, 2023 1:04:16 AM PST, Andrea Righi <andrea.righi@canonical.com> wrote:
> >On Fri, Feb 10, 2023 at 02:43:56PM -0800, Kees Cook wrote:
> >> On February 10, 2023 1:51:41 PM PST, Andrea Righi <andrea.righi@canonical.com> wrote:
> >> >With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen passes
> >> >-ftrivial-auto-var-init=zero to clang, that triggers the following
> >> >error:
> >> >
> >> > error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'
> >> >
> >> >However, this additional option that is currently required by clang is
> >> >going to be removed in the future (as the name of the option suggests),
> >> >likely with clang-17.
> >> >
> >> >So, make sure bindgen is using this extra option if the major version of
> >> >the libclang used by bindgen is < 17.
> >> >
> >> >In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
> >> >without triggering any build error.
> >> >
> >> >Link: https://github.com/llvm/llvm-project/issues/44842
> >> >Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> >> >---
> >> >
> >> >Changes in v2:
> >> > - check the version of libclang used by bindgen to determine if we need
> >> >   to pass the additional clang option
> >> >
> >> > rust/Makefile | 13 +++++++++++++
> >> > 1 file changed, 13 insertions(+)
> >> >
> >> >diff --git a/rust/Makefile b/rust/Makefile
> >> >index ff70c4c916f8..c77d7ce96a85 100644
> >> >--- a/rust/Makefile
> >> >+++ b/rust/Makefile
> >> >@@ -269,6 +269,19 @@ BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
> >> > # some configurations, with new GCC versions, etc.
> >> > bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
> >> > 
> >> >+# Auto variable zero-initialization requires an additional special option with
> >> >+# clang that is going to be removed sometimes in the future (likely in
> >> >+# clang-17), so make sure to pass this option only if clang supports it
> >> >+# (libclang major version < 17).
> >> >+#
> >> >+# https://github.com/llvm/llvm-project/issues/44842
> >> >+ifdef CONFIG_INIT_STACK_ALL_ZERO
> >> >+libclang_maj_ver=$(shell $(BINDGEN) $(srctree)/scripts/rust_is_available_bindgen_libclang.h 2>&1 | sed -ne 's/.*clang version \([0-9]*\).*/\1/p')
> >> >+ifeq ($(shell expr $(libclang_maj_ver) \< 17), 1)
> >> >+bindgen_extra_c_flags += -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> >> >+endif
> >> >+endif
> >> 
> >> This logic already exists in the top-level Makefile. How does -ftrivial-auto-var-init=zero make it into bindgen_c_flags normally? (I.e. why does the legacy -enable... option not?)
> >
> >If we're using gcc, the top-level Makefile doesn't set the clang
> >options, so in this case CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER is
> >undefined.  But then bindgen always relies on libclang to parse C, even
> >if gcc is used globally, therefore it needs the extra clang flag.
> 
> Ah yes! Thank you, I keep forgetting about mixed compiler builds.
> 
> >
> >Ideally it'd be nice if bindgen would support a gcc backend, but until
> >then we need to do something special here, like this kind of duplicated
> >logic...
> 
> Right. Yeah, good fix. One nit: the -enable... flag is removed in Clang 16+:

oic, with clang-16 we get a deprecated warning (but it doesn't fail),
then starting with clang-17 the -enable.. flag is not available anymore.

Then I agree that a better check would be version < 16, instead of < 17.

Thanks,
-Andrea

> 
> https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/ReleaseNotes.rst#deprecated-compiler-flags
> 
> With that fixed:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> 
> -- 
> Kees Cook
