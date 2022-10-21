Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E761607DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJURkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJURjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:39:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2A3FD6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:39:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g27so8562776edf.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jf/Eb/CewThpJ/hWTbFyMXRlobZKi0EOll0w249IASg=;
        b=FjP2s6nGxVS8vSbGwtA3KWSHKhXX8uLMMdG+La4JzzyBHW4NHjGGaQnizz3lVooFie
         IzVyvdcrTpQendS3OohqZkGPSatE52FV8Ug+S6d6WNP+VoYS8NVpX4vfrcaeZpOld4y+
         CQDkL7FZGdYjOHxLKjFVRrTIaoYWXb/oBNAPCs6g0/zbE8cdMQTsd8PQAr/o7ND2yytX
         D9Q4/uv6BI89n2p7DXRIFEsAY9SlP4uayCt2MSuUx+emK3UPqMfmc1EQ4zGSadbIfkfi
         ULPEiSeiXEQhHFkkNtAyJB9I9WPzMLs+d3pfqQIxO+nUVeFrnO6wtr8CMsv1zCns2h5l
         jtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jf/Eb/CewThpJ/hWTbFyMXRlobZKi0EOll0w249IASg=;
        b=Bz2Q6hzrXnGqEuqf+iw7njUCgmzUcTaVgYka1i0nrhfRPo4K4v6rXaIDJN56CDxA9C
         pLqiOUXJs7PvKcfuHQ0TwCje0KfFxV0Iqc5vP4In0fNvsrZsGwdnemELpq646wHnBRio
         mGlLzzmsTU6UEtbSLbQvsGAg+XIYvs7jjZa/Su3G2zChakfG9YtQOk2xAgh0MshkkFDy
         5xQqMynLOrMkuEh/cegpgipW4g9PmrQshfa7zQFr1iEL+72hXQgSfFfvsqtipI9tDNiZ
         Jff8ZU2mMRVR0ISh3vKDY4n1rAVM09Sp83yF1POLje/RNcHf0Y1Vzw2iLiSVqdMcW7ID
         CVFQ==
X-Gm-Message-State: ACrzQf2eeHc29Zv4qGAEkLhYPr74s9LzaJoaPvrXh6UnuZ2rFXfRABbZ
        zF1RA2GJbeXOGXbkEM8bpH4ldH4DnHwAVEloWhfq+w==
X-Google-Smtp-Source: AMsMyM5vRLF1pjmsZkk6dWKKdTQUxxi+xL34Z05v4VMrgP/GcxHM3uShCJNvXK4HE4rhr9H9xKahQA33esiY3op/I/g=
X-Received: by 2002:a17:907:3f1e:b0:78d:f198:fd00 with SMTP id
 hq30-20020a1709073f1e00b0078df198fd00mr16066742ejc.730.1666373989777; Fri, 21
 Oct 2022 10:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
In-Reply-To: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 21 Oct 2022 10:39:13 -0700
Message-ID: <CABCJKuf=OB_3ZR_rwaG3H5kHKmTTDk+sihjJXYmyWgZjUX2yTQ@mail.gmail.com>
Subject: Re: kCFI && patchable-function-entry=M,N
To:     Mark Rutland <mark.rutland@arm.com>,
        Fangrui Song <maskray@google.com>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 8:56 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> For arm64, I'd like to use -fatchable-function-entry=M,N (where N > 0), for our
> ftrace implementation, which instruments *some* but not all functions.
> Unfortuntately, this doesn't play nicely with -fsanitize=kcfi, as instrumented
> and non-instrumented functions don't agree on where the type hash should live
> relative to the function entry point, making them incompatible with one another.

Yes, the current implementation assumes that if prefix nops are used,
all functions have the same number of them.

> Is there any mechanism today that we could use to solve this, or could we
> extend clang to have some options to control this behaviour?

I don't think there's a mechanism to work around the issue right now,
but we could just change where the hash is emitted on arm64.

> It would also be helpful to have a symbol before both the hash and pre-function
> NOPs so that we can filter those out of probes patching (I see that x86 does
> this with the __cfi_function symbol).

Adding a symbol before the hash isn't a problem, but if we move the
hash and want the symbol to be placed before the prefix nops as well,
we might need a flag to control this. Fangrui, what do you think?

Sami
