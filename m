Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C347B5E7FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiIWQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiIWQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:27:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187EE14D4BD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:26:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y136so650989pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=IyPY3jNYz1zmj8hC2XWs0gtCQLKsELDuACeXIEucHZQ=;
        b=SAiDToSaHfqFgiQllB+souznfy9cjE7uiCVxu/+FJGJpgekfLf+2ETQzw13CSxgE4W
         D9ntvAOYdxO6PUNeuaeN40fQ4wwK3Q7qFil1G2HjPAjEl/oDTiogBRI0dFZHgn8DBEYk
         2PqoiKAmgBVn3F2ho+OFCFsKsc3GJ9QLxaBNFeUiOBw0jr7nSGrD8ubD1OaH5K/l9z1H
         rrCK58W+ULROUGDf5NfcudRKbLBDelMEql+ZTk6M7dL6LmEauMKa3/RZBKF8ZxLsAqUF
         kNqQqWZjcPTpikk+isWJ+fFvgC341oYUzHEqI1Bl/AEPU5ZgODtle9ipNJ93iOLux8fe
         4/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=IyPY3jNYz1zmj8hC2XWs0gtCQLKsELDuACeXIEucHZQ=;
        b=sWgbjPeG8lzKNQ0Q3njQpFlYpZhIyZ6yJEMIm+Q6fP24gVCliNSAzWVGYxS7FsEONq
         aEh+02GHgt+W7ktk2EdqdECurstSL3as8okxFkglcxDY0qi9bFOIgZedlaUo0jOCa7dJ
         if28CJkf4i/20SGHuBxXA+CjpbsYJ63Dpi2iLRwJFJbOJyn5ZEQdKhzKdtJ4lpGAbkiv
         JW091De7XFiTrza5U6EbB6er6FRi44/xi7OHdihABqBflFKbpU9FEdHB9VrKwmGq8k1s
         dN2NI2hIDcewJTyZZPhYZGlZu/zZC1Z4S0mqOSgnOTszM2oKC5GSSbma+dwTvD6JfHE7
         cvWg==
X-Gm-Message-State: ACrzQf3Nki/hdeXq7sdEwkRq/6wdzl0x7viz8i44fdhw7B8aDEkiDzQV
        XHeGpuYMVYU05vBDs/EF/bk=
X-Google-Smtp-Source: AMsMyM7rc731dQvjk+iLZLlBI2OutVcUyXEqc0JNp5UQYmHIx7XUmEOD6VBJInYp1uuo4XbQUAajFQ==
X-Received: by 2002:aa7:998f:0:b0:54d:a441:85da with SMTP id k15-20020aa7998f000000b0054da44185damr9782049pfh.20.1663950417459;
        Fri, 23 Sep 2022 09:26:57 -0700 (PDT)
Received: from localhost (27-32-155-116.static.tpgi.com.au. [27.32.155.116])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b0054ee4b632dasm6537845pfv.169.2022.09.23.09.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 09:26:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 24 Sep 2022 02:26:52 +1000
Message-Id: <CN3X6YN1FRQ3.1Z9BVD6WYQY3M@bobo>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/irq: Modernise inline assembly in
 irq_soft_mask_{set,return}
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Segher Boessenkool" <segher@kernel.crashing.org>
X-Mailer: aerc 0.11.0
References: <178f30ff62c0317061f019b3dbbc079073f104c3.1663656058.git.christophe.leroy@csgroup.eu> <CN3LB8F3D9LM.3W1RQRVS64UXU@bobo> <20220923121829.GL25951@gate.crashing.org>
In-Reply-To: <20220923121829.GL25951@gate.crashing.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 23, 2022 at 10:18 PM AEST, Segher Boessenkool wrote:
> On Fri, Sep 23, 2022 at 05:08:13PM +1000, Nicholas Piggin wrote:
> > On Tue Sep 20, 2022 at 4:41 PM AEST, Christophe Leroy wrote:
> > > local_paca is declared as global register asm("r13"), it is therefore
> > > garantied to always ever be r13.
> > >
> > > It is therefore not required to opencode r13 in the assembly, use
> > > a reference to local_paca->irq_soft_mask instead.
>
> > The code matches the changelog AFAIKS. But I don't know where it is
> > guaranteed it will always be r13 in GCC and Clang. I still don't know
> > where in the specification or documentation suggests this.
>
> "Global Register Variables" in the GCC manual.
>
> > There was some assertion it would always be r13, but that can't be a
> > *general* rule. e.g., the following code:
> >=20
> > struct foo {
> > #ifdef BIGDISP
> >         int array[1024*1024];
> > #endif
> >         char bar;
> > };
> >=20
> > register struct foo *foo asm("r13");
> >=20
> > static void setval(char val)
> > {
> >         asm("stb%X0 %1,%0" : "=3Dm" (foo->bar) : "r" (val));
> > }
> >=20
> > int main(void)
> > {
> >         setval(10);
> > }
>
> Just use r13 directly in the asm, if that is what you want!
>
> > With -O0 this generates stb 9,0(10) for me for GCC 12, and with -O2
> > -DBIGDISP it generates stb 10,0(9). So that makes me nervious. GCC
> > does not have some kind of correctness guarantee here, so it must not
> > have this in its regression tests etc., and who knows about clang.
>
> GCC has all kinds of correctness guarantees, here and elsewhere, that is
> 90% of a compiler's job.  But you don't *tell* it what you consider
> "correct" here.

Right, that's what I expect. I think the confusion came from here,

https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-August/247595.html

In any case it is answered now.

> You wrote "foo->bar", and this expression was translated to something
> that derived from r13.  If you made the asm something like
> 	asm("stb%X0 %1,0(%0)" : : "r" (foo), "r" (val) : "memory");
> it would work fine.  It would also work fine if you wrote 13 in the
> template directly.  These things follow the rules, so are guaranteed.
>
> The most important pieces of doc here may be
>    * Accesses to the variable may be optimized as usual and the register
>      remains available for allocation and use in any computations,
>      provided that observable values of the variable are not affected.
>    * If the variable is referenced in inline assembly, the type of
>      access must be provided to the compiler via constraints (*note
>      Constraints::).  Accesses from basic asms are not supported.
> but read the whole "Global Register Variables" chapter?

I still don't see what clauses guarantees asm("%0" ::"r"(foo)) to give
13. It doesn't say access via inline assembly is special, so if
optimized as usual means it could be accessed by any register like
access to a usual variable, then asm could also substitute a different
register for the access by the letter of it AFAIKS.

I think if it was obviously guaranteed then this might be marginally
better than explicit r13 in the asm

       asm volatile(
               "stb %0,%2(%1)"
               :
               : "r" (mask),
	         "r" (local_paca),
                 "i" (offsetof(struct paca_struct, irq_soft_mask))
               : "memory");

But as it is I think we should just stick with explicit r13 base
in the asm.

Thanks,
Nick
