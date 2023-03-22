Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E96C3F45
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCVApk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjCVApZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:45:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B639BB3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:45:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so66644084edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 17:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679445922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrtn8nmTpdpmlgteuK1+I9kCTEi3WBSapYh/Vb77bok=;
        b=VW31Rf9rgwMP9zlJPFNGWbV/hbH9wFiZ9VXmZSwuQsH+/Lwds11o8qr14npM4cUj9p
         2z1mwUFi9nvypKReOlWlhwqyw/WvoPUvkTAeIwGPSrw6tcZr0QSL9m/EmLybxR2c/8dA
         uxGa3OdLJAVyZnZkBGKhx3UyuFp26ofXvTDURP4Gtawcv5r5JsahT+G+0px4ilVqFRGm
         0zpONLmv1eqvpK2id/1vhlb6fwSPOXgCQxjy3yhaf+lnNN/8y4qEKUCE4/Aj4Z3LBFs0
         04ocCUbGQr6uscy1auN6Wn5lcJe0dGi9r5k2wOv0LMioodyuuAk3ibVkaIldh8IQO4U3
         QPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679445922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrtn8nmTpdpmlgteuK1+I9kCTEi3WBSapYh/Vb77bok=;
        b=wH/0N3Y7RiXl7lYIUZcTvpTucESfV68h2L46UNFBAxJqjYlFiUrWzcKVF7OOh0UIql
         5rX1ZZDmqAnfxZ7NgqigCsra/Czhyc119HVtN078PGuFDEZ0y0vYn7bsPrpst7tKaWYw
         tKhLZwkGcBPMxAG0bpXxK9Ecvt9fRbnBUQNDNI/DRlDpl3B35fx3RgWm5elQ8yWvEyYm
         gT2eXZigHWePKm4C5xBL3HHdmt0LCprEsDrRsRvLmrpDqnn6AeNxYqlT8Z3ZtnCIaVzF
         gxhMKAmVzykXh1Spa/jWeOfp5Em4v16xaVwPDSEgTmuQ1+kA0a1TTzJJpFu/A5SIXiar
         B17g==
X-Gm-Message-State: AO0yUKUiA+NZwLnD3JO10wfQAVK1RNQGo6iblY+mhc4IzD/j7cDtorwz
        35XAZoB4jrLpCaF6HkKy0YU=
X-Google-Smtp-Source: AK7set9+toSZFFbOheWMw08WFtHuw2LBGIYFjBR36MoXWEw//iln1ImIgpEqD5zQkjHozI7eOTQi5g==
X-Received: by 2002:a17:906:b115:b0:8b1:76ca:f228 with SMTP id u21-20020a170906b11500b008b176caf228mr4968055ejy.39.1679445922119;
        Tue, 21 Mar 2023 17:45:22 -0700 (PDT)
Received: from andrea (93-41-0-79.ip79.fastwebnet.it. [93.41.0.79])
        by smtp.gmail.com with ESMTPSA id u24-20020a17090657d800b00934823127c8sm3249365ejr.78.2023.03.21.17.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 17:45:21 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:45:14 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 1/6] riscv/cmpxchg: Deduplicate cmpxchg()
 asm functions
Message-ID: <ZBpPms0PGv4sWR1Y@andrea>
References: <20230321074249.2221674-1-leobras@redhat.com>
 <20230321074249.2221674-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321074249.2221674-2-leobras@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 04:42:44AM -0300, Leonardo Bras wrote:
> In this header every cmpxchg define (_relaxed, _acquire, _release,
> vanilla) contain it's own asm file, both for 4-byte variables an 8-byte
> variables, on a total of 8 versions of mostly the same asm.
> 
> This is usually bad, as it means any change may be done in up to 8
> different places.
> 
> Unify those versions by creating a new define with enough parameters to
> generate any version of the previous 8.
> 
> (This did not cause any change in generated asm)
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 102 ++++++++-----------------------
>  1 file changed, 24 insertions(+), 78 deletions(-)

Diff looks nice,


> +#define ___cmpxchg(lr_sfx, sc_sfx, prepend, append)			\
> +{									\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"0:	lr" lr_sfx " %0, %2\n"				\
> +		"	bne  %0, %z3, 1f\n"				\
> +		"	sc" sc_sfx " %1, %z4, %2\n"			\
> +		"	bnez %1, 0b\n"					\
> +		append							\
> +		"1:\n"							\
> +		: "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)		\
> +		: "rJ" ((long)__old), "rJ" (__new)			\
> +		: "memory");						\
> +}

Though I'm not really a fan of macros depending on local variables with
"magic" names, can this be avoided?

Thanks,
  Andrea
