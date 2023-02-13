Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E07F694748
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBMNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBMNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:43:38 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300AB93FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:43:35 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-52ec329dc01so143743387b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MZUqtHGEt4hmalJ9Nq9va1qwBby7HH+VJC/DscVKwTk=;
        b=LK7EpQgWthIGYI8KqTlaFjM4JtMGQPQP3rRAsKf2tSoinZX2ZSFX61iXyZk41qkMWS
         kA3LmtdC/QUE+jBbJDbDsKYqu0wyXxxUBszrMiEbhBWDC0IXszDkEVDxBcFQGLkOoiDH
         4p5K6Sc0ltdB+x5aujxz6MIKhSAR2j/8+4GqtglaObnUhqZiheS94HhpGZ8z/RWLQpQl
         3dKqkWn8Vz/5Tn08WhJ+/HHsPABDlfVflPq9v++44IgoLpOCHEM/Ayxo+qsn8fZysGju
         1H3rguff9gEYCxDrd1xtfXJRbpdyHPqVHe6m2ZOS0FsQV0b7m2gd9nCu5cfT9C0zakJO
         CTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZUqtHGEt4hmalJ9Nq9va1qwBby7HH+VJC/DscVKwTk=;
        b=iUfLrJMerVcCvDSPu7X74BzsSJ+Lk5JHj3n2doU3PaGtJsw6JV55mMMbFm4f9EtAs/
         /z+ttQtur0M2IPf8od4Oc7CX9UQ/r5vtvtlGVKI3/tc0cKnH34jNm8U0p+yNxJHeomR6
         R7aKsKRKhCyUld1egnmATPUP8VlLdCyN+r8SFsUl5nebWE5ur7Fnn3H9fEdJkT7EUxaa
         qRmKRxxGv2nr/TebZpgJHPD55Vk3FpIgEr4SfAxrYin8Ns3QhlXhvlzhdT7UbChCmrS6
         5+u6t+2HOzSOIgw+V+qrCPfxZ3INvA47IRIEqCDSEyfgx33sUhe1Ubc68Gpbbf9nm/Ke
         hK5A==
X-Gm-Message-State: AO0yUKVG/TlRrWpVUcifQmDMVp8T1FdtW5qSmqLvFnTsJqzu9MUmvPfw
        2tE8kqfWRXKNgwwCQtngPr+8KnoqiPyGzjo8DpbC9w==
X-Google-Smtp-Source: AK7set/lXYFWvBmM87O7a1KxrqBS3XjQWpO/aWMK5QeiALscA5wifZwrCEL1qcsuhU6qka+WxebN4apgDBUgbelovlo=
X-Received: by 2002:a0d:db96:0:b0:52e:c7a1:7439 with SMTP id
 d144-20020a0ddb96000000b0052ec7a17439mr1272721ywe.384.1676295814296; Mon, 13
 Feb 2023 05:43:34 -0800 (PST)
MIME-Version: 1.0
References: <20230213080620.62f7eeb6@canb.auug.org.au> <Y+oZ7O9d8r8SIM0A@smile.fi.intel.com>
In-Reply-To: <Y+oZ7O9d8r8SIM0A@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Feb 2023 14:43:22 +0100
Message-ID: <CACRpkdYrBpUZAcJMvXMouW08RW+6LYzPraeJdDFv+yQRzoqWrA@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the pinctrl-intel-fixes tree
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 13, 2023 at 08:06:20AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > The following commit is also in Linus Torvalds' tree as a different commit
> > (but the same patch):
> >
> >   a13bbd841bf8 ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> >
> > This is commit
> >
> >   a8520be3ffef ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> >
> > in Linus' tree.
>
> I believe this due to it's in my tree and not tagged. That's why it appeared in
> the upper trees with different SHA. I'll drop mine.

Ah, also the $subject says "intel pinctrl fixes" tree, not the
"pinctrl fixes" :P

My attention to detail is lacking today, like all days...

Yours,
Linus Walleij
