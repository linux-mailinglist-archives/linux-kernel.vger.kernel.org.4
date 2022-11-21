Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4BE632D05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiKUTbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKUTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:31:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF029BE26F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:31:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w4so2714129plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oC01w75+BC6zrMlCSKPUDMxphH7KPs1R9UnUFSUpeYw=;
        b=Pdw0XXErqS1PgwCmNkH9rspHwrdI1O3eFjB+pw+cMQEN4M6BZqrIk6ylnayBkObhMc
         Bh4+OvW5IAD5/EbeDiS7ZXAjAdKGFZYrqPwtT0es6AX4Cwy20ZK8hC7OdoJYbq7EVzhF
         LQtSVfpxif8InEPFGKS0/qDZm5gG0ynabeNAu/pbynkNW4pRgwMUd/T8JHMj99gnx9gA
         dfr/VbNPVD++y8ol0c4S/A7fW9Kz5tifVQi1+2GKWEx4s2XTLmP/K8+6RNxcmD6dM/cv
         Vqr3F3WaO5YOX1mnAMtsVKdO24VL46TnS+dHNccJ2VO37OlPSScI0mJpMmWv7B4GmtR8
         o2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oC01w75+BC6zrMlCSKPUDMxphH7KPs1R9UnUFSUpeYw=;
        b=qfZy8YDEePAbFngpDe+VOC/ykfdpp+91KUGCpu2/29Bp7PTCsBvkCimTfRm1qhM8td
         QvKivsAKUD+q+riCcyLsF9lL3RXZQ0oL2mLurYtE+ng9aIgXHW4U71cOL1jlTqPXKCYb
         7nzcaLl0G3nU37hkR76tWcbKXG2i291S5t71MDUwv7ZYZqySX0xjiCw11+mMSyh8acni
         UwB2PUzhDxkZ8/vM+FobxRS95u3Z9LgjHwWH7AtEfcyw7nfhtvSRETIyDIIDFYF6UEfA
         6EK9Q+z4j3BsLWHE0vPfscuUX4h0fFkXRV7H6ZxPOUtwQMTJJ4dZZFlMa/z6HEmr+e05
         SvDA==
X-Gm-Message-State: ANoB5pkWzT6MVCYgOaAJrim62CriDGXXFWLUSw2F8l5EYBOlArahfagr
        GlhDgQNhD6gEJWGseq/69EGv8g==
X-Google-Smtp-Source: AA0mqf5uB1x90SY6CZJ84lF4+qw7+Voi7ifO//IKb7wjxInhvdLJpg4ESjdrlcZHZUQZQ849d9LOpg==
X-Received: by 2002:a17:902:f391:b0:186:ac81:2aa9 with SMTP id f17-20020a170902f39100b00186ac812aa9mr611868ple.95.1669059094034;
        Mon, 21 Nov 2022 11:31:34 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090a740200b002135e8074b1sm10623507pjg.55.2022.11.21.11.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:31:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 19:31:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     alexandre.belloni@bootlin.com
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test
 with dash
Message-ID: <Y3vSErWtH6L6GmMn@google.com>
References: <20221115110158.2207117-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115110158.2207117-1-alexandre.belloni@bootlin.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Masahiro and build, as I don't think this should go through the KVM tree (which
is also partly why no one has responded).

On a related topic, should init/Kconfig be added to the KCONFIG MAINTAINERS entry?
Or is there a better owner for this?

diff --git a/MAINTAINERS b/MAINTAINERS
index 046ff06ff97f..ffff36e16b88 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11040,6 +11040,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 F:     Documentation/kbuild/kconfig*
 F:     scripts/Kconfig.include
 F:     scripts/kconfig/
+F:     init/Kconfig
 
 KCOV
 R:     Dmitry Vyukov <dvyukov@google.com>

On Tue, Nov 15, 2022, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> with a syntax error which is not the one we are looking for:
> 
> <stdin>: In function ‘foo’:
> <stdin>:1:29: warning: missing terminating " character
> <stdin>:1:29: error: missing terminating " character
> <stdin>:2:5: error: expected ‘:’ before ‘+’ token
> <stdin>:2:7: warning: missing terminating " character
> <stdin>:2:7: error: missing terminating " character
> <stdin>:2:5: error: expected declaration or statement at end of input
> 
> Removing '\n' solves this.
> 
> Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs to workaround clang-13 bug")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..13e93bcbc807 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -87,7 +87,7 @@ config CC_HAS_ASM_GOTO_OUTPUT
>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
>  	depends on CC_HAS_ASM_GOTO_OUTPUT
>  	# Detect buggy gcc and clang, fixed in gcc-11 clang-14.
> -	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)
> +	def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -c -o /dev/null)

Tested a variety of compiler versions via godbolt, and the results are the same
for all cases, so with the caveat that I am far from a shell expert:

Reviewed-by: Sean Christopherson <seanjc@google.com>
