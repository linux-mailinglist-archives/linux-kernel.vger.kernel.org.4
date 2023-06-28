Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9654741814
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF1Sek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjF1Sei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:34:38 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6B1726
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:34:36 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-563531a3ad2so157341eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687977276; x=1690569276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44i1HPgVbDjroHL3xpYNV2W1/J/Ibi9y849Av9M0qyY=;
        b=kPGmdWzzEVQtSrhSb93sFIagde0v3WzAxnzvFWxsyuVa7H6O+bTAdLjamfYt2oY56i
         bUZi/qQlHUo9WUo3Tu+N3GYI/QAnZcSms9X2LynUVHSaQtu73xHS8/tS+ZdvCxp/qwE4
         Th7NbgPdfyqMtuGXqXSke+VnvpwAuCGidV1TEYvtKvDjDGlXVyr4diYmZwt2sfo+v4C8
         7qoMTIPqy7XiWaf6OTAcmmiYtE+55bA1WfHfEd25KFQvk3NxI0Ov7uTAfYcKUSeRvrjH
         +WoOpe6OWsly5Wnz1HyQTEYPnyjsiud37jadMJYFGodoqo/25cPtdYG7/XMpkQR9bmSZ
         dKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687977276; x=1690569276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44i1HPgVbDjroHL3xpYNV2W1/J/Ibi9y849Av9M0qyY=;
        b=Bex7zsGb1viQ/AcXyvUU0vd5sARkikOowvWPO2w7hdFofkcr5xZApG+ZE5fK6Ur1xn
         Awix8XqMWlEvpcmMKblIL4psrTzWaMWsYxTkzE8qpA864Urg4ER0beHUm7Gm3lCYgT4N
         xegqCL/mZN7nZi5O28Bz/6TmYHkltCL9pTCQHlTBnJyn9154GXv3Szuj3i5AVclNwpUn
         +74mSB/n1jaqJRPMe3ADj7GkfUmQjAUNVlOSxawAimKbqVkePMpKYdotfugy3Q6hCBJz
         SHEoPquymvmGJjFCjTJ7bFr6m4yTn8jAfFgvY6+5jaC7RIKaAZowxFYCqIgxVIAnaHnh
         LCaQ==
X-Gm-Message-State: AC+VfDzAFU/0TEhc2R7ChWaTgmKz8sroOVs8ysZgJacqbVnwZmv8ncEQ
        elBOyLhuRWOqA1LDUr+ohMub6oOkdAAY7VJB5pc=
X-Google-Smtp-Source: ACHHUZ4sp+cRLx2BGJd2DsfYaUSIcfnnRHHgz3BQGkTCoYvhCmvSlc3Mha1JU/ZWFXrPcJzh6ICSYZqYQ/HpoN6xrzU=
X-Received: by 2002:a4a:a308:0:b0:563:488d:c661 with SMTP id
 q8-20020a4aa308000000b00563488dc661mr7261860ool.8.1687977275994; Wed, 28 Jun
 2023 11:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230628020657.957880-1-goldstein.w.n@gmail.com>
 <20230628091241.GAZJv5ie0xVGvnMKIM@fat_crate.local> <CAFUsyfKYQk87fxCDj9FpM9xzLwZVRrfUZgyUCF5G+HuC0N2pXg@mail.gmail.com>
 <CAHk-=wj1fe4Pa0zLxUTiMjaxEXW84HBup+Hv=fe-U8PoFzrm5g@mail.gmail.com>
In-Reply-To: <CAHk-=wj1fe4Pa0zLxUTiMjaxEXW84HBup+Hv=fe-U8PoFzrm5g@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 28 Jun 2023 13:34:24 -0500
Message-ID: <CAFUsyfJ-n53mXd1QZCtFfkCjux6Hy7iAG4-uALX0Uyofg=PTGg@mail.gmail.com>
Subject: Re: x86/csum: Remove unnecessary odd handling
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        edumazet@google.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 12:44=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 28 Jun 2023 at 08:32, Noah Goldstein <goldstein.w.n@gmail.com> wr=
ote:
> >
> > Linus, if you're planning a patch and want to just integrate the codes
> > here I'm happy drop this patch
>
> No, that patch looks good to me.
>
> In fact, I wasn't planning on integrating my patch at all. I literally
> did it as a "I would have done it this way instead" exercise.
>
> And while I am currently running with my patch in the kernel, I don't
> even really know if it works and does the right thing. Maybe my use
> doesn't even trigger csum_partial() at all. I did not do any testing
> that "yes, I get the same checksum as a result".
>

There is a reasonably robust kunit for csum_partial: lib/checksum_kunit.c
so if you happened to run the kunit testsuite with your patch, it's
probably correct.

> So
>
>  (a) removing the pointless one-byte alignment looks good to me.
>
>  (b) I'd actually hope that somebody who _cares_ about this path and
> has put some real work into it (as opposed to my "superficial
> dabbling") would look at my patch and either go "yeah, not worth it",
> or "looks good, I'll take it".
>
> and I'm including that final patch of mine here again in case there
> was any confusion with the earlier versions (there were at least two
> known-broken versions I posted).
>
> *If* somebody likes it, and verifies that the checksum result is
> correct, feel free to do anything with that patch, including adding my
> signed-off-by for it (or taking the credit all for yourself -
> Mwahahahahaahaa!)
>
>               Linus
