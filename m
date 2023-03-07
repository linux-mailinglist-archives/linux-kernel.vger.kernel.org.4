Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7E6AE4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjCGPcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCGPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:31:59 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09351BB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:31:57 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c80so4792528ybf.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej1wMX0xmC5g1dxLkHmNOArc3+7GOqB/eA4DE4RyK4c=;
        b=dZkA6PzJvWsX5mEy6t5JDiwxiahiFz/4Eawhp1d/Bcqk+dR2z7JNj2riwjQyAzKAAe
         ciH0PyY6MAb2wVOkmIiDO4+CKoUZnw1pfewuR8t2OziaNck88JqQL7ydiWq25OX7An9w
         7PgZKQJ1Gbr+HTlUYfGmoHQrRSl5Y2rfdaWC0ZuJJjKOagyHZBWNc+gaiPlUWmRU7Yte
         f+GlwwdjXVHydKtRFbgCoLUzkM71TNc35lZ5Co+HcPeF79NXdhE04gxghtFxXLlZSD17
         CgP1oOjXIDM8OxEh+VvDxMQkhkCtgRbQ0SpAz3xnxIk95wo11cIqS98nHkXmheLpfRh2
         wfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ej1wMX0xmC5g1dxLkHmNOArc3+7GOqB/eA4DE4RyK4c=;
        b=VNYlmAOYKYHDkrd2mc3ch4ngLbHdRDwPdkk55jR/W9WDsEpgtszoGd2tJEN5hu6bNH
         Bgu74tg5ifR2dRp/P2LMmPW3CnBrGVTBNHg/P2muYCui+1bGDM8IOq0CxlVUTYzHbqOQ
         ycZAJPfMl0YEuoYo6lcTVBOFZ/TsjLZpIVF/1UHCoAbo8CVR7968wOmzENP/1QprGqEr
         XBX61Yl2KZ6JngvgVAIujTauYEGR3ybtcqmLG6H5qqFCveDitQTRXUZGY3hhZSOyS0vd
         lwM8Ra1mVfZytzEm2dBoBi+xkIMs28+aVLZdpC/o0o+5YE5kU16GGTV7Pmb2VaWE2jng
         pFGA==
X-Gm-Message-State: AO0yUKUgrwKR9XRE8ssXFlMr4scqbWFEiSsMyd13q3aCRAkHcniy7+Gu
        Xua8mkKqU/0tbHNxn38AOfkh6GnwlRyHq3WUE3PUzw==
X-Google-Smtp-Source: AK7set9/2bK3mUzyiRzESQsU6pjbcNV8AIUilPKmGcvAAgOXm1cAbDz62p+1ObNkkp4uRo5v+YJxbxzZR5pLCAEFUKE=
X-Received: by 2002:a25:e90b:0:b0:9fc:e3d7:d60f with SMTP id
 n11-20020a25e90b000000b009fce3d7d60fmr6590460ybd.5.1678203116816; Tue, 07 Mar
 2023 07:31:56 -0800 (PST)
MIME-Version: 1.0
References: <ZAVu/XHbL9IR5D3h@gondor.apana.org.au> <E1pZ2fs-000e27-4H@formenos.hmeau.com>
 <CACRpkdY8iN_ga0VuQ-z=8KUWaJ6=5rh2vZEwcp+oNgcBuPFk=g@mail.gmail.com> <ZAcNhtm/+mik1N2m@gondor.apana.org.au>
In-Reply-To: <ZAcNhtm/+mik1N2m@gondor.apana.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 16:31:44 +0100
Message-ID: <CACRpkdbcrCa9v82xVWtixWdDPvCu6E6Rkw-3Vg3APisdvYGwqQ@mail.gmail.com>
Subject: Re: [v5 PATCH 7/7] crypto: stm32 - Save and restore between each request
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 11:10=E2=80=AFAM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
> On Mon, Mar 06, 2023 at 11:08:13AM +0100, Linus Walleij wrote:
> >
> > This partly works (after my folded in fix in patch 5)!
> >
> > Clean SHA1 and SHA256 works flawlessly.
> > HMAC still fails, but not until we start testing random vectors:
> >
> > [    7.541954] alg: ahash: stm32-hmac-sha256 digest() failed on test
> > vector "random: psize=3D0 ksize=3D80"; expected_error=3D0,
> > actual_error=3D-110, cfg=3D"random: may_sleep"
> > [    7.567212] alg: self-tests for hmac(sha256) using
> > stm32-hmac-sha256 failed (rc=3D-110)
>
> So it's timing out.  I wonder if the timeout in stm32_hash_wait_busy
> is long enough.  Perhaps try adding a zero so that the timeout becomes
> 100,000us and see if it still breaks?

Sadly this doesn't work.

I tried increasing with one and even two orders of magnitude,
but the timeouts still happen, usually two of them, sometimes
one sometimes three, depending on randomness, as can be
expected.

I think you mentioned something about that we need to store
the key in the state as well though?

Yours,
Linus Walleij
